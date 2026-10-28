
from pathlib import Path

import pandas as pd


# Resolve paths from the project root, not the current terminal directory.
PROJECT_ROOT = Path(__file__).resolve().parent.parent
RAW_FILE = PROJECT_ROOT / "data" / "raw" / "Superstore.csv"
PROCESSED_DIR = PROJECT_ROOT / "data" / "processed"
OUTPUT_FILE = PROCESSED_DIR / "superstore_cleaned.csv"
QUALITY_REPORT = PROJECT_ROOT / "reports" / "data_quality_report.md"


def main():
    """Load, standardize, validate, and export the Superstore dataset."""

    if not RAW_FILE.exists():
        raise FileNotFoundError(
            f"Raw dataset not found: {RAW_FILE}\n"
            "Check that data/raw/Superstore.csv exists."
        )

    PROCESSED_DIR.mkdir(parents=True, exist_ok=True)
    QUALITY_REPORT.parent.mkdir(parents=True, exist_ok=True)

    # Load original data. Preserve source records for investigation.
    df = pd.read_csv(RAW_FILE)

    initial_rows = len(df)
    initial_columns = len(df.columns)

    # Remove accidental spaces around column names.
    df.columns = df.columns.str.strip()

    # Remove leading/trailing whitespace from text values.
    # Do not change IDs or numeric values.
    text_columns = df.select_dtypes(include=["object", "string"]).columns
    for column in text_columns:
        df[column] = df[column].map(
            lambda value: value.strip() if isinstance(value, str) else value
        )

    # Report duplicate rows, but do not delete them automatically.
    duplicate_rows = int(df.duplicated().sum())

    # Report missing values by column.
    missing_by_column = df.isna().sum()
    missing_columns = {
        column: int(count)
        for column, count in missing_by_column.items()
        if count > 0
    }

    # Convert known date columns only when they exist.
    date_columns = [
        column for column in ["Order Date", "Ship Date"]
        if column in df.columns
    ]

    date_conversion_errors = {}
    for column in date_columns:
        original_non_null = df[column].notna()
        converted = pd.to_datetime(df[column], errors="coerce")
        errors = int((original_non_null & converted.isna()).sum())
        if errors:
            date_conversion_errors[column] = errors
        df[column] = converted

    # Check numeric columns without inventing replacements for missing values.
    numeric_columns = [
        column for column in ["Sales", "Profit", "Quantity", "Discount",
                              "Shipping Cost"]
        if column in df.columns
    ]

    numeric_conversion_errors = {}
    for column in numeric_columns:
        original_non_null = df[column].notna()
        converted = pd.to_numeric(df[column], errors="coerce")
        errors = int((original_non_null & converted.isna()).sum())
        if errors:
            numeric_conversion_errors[column] = errors
        df[column] = converted

    # Export the prepared dataset.
    df.to_csv(OUTPUT_FILE, index=False)

    # Create a factual quality report from this run.
    report_lines = [
        "# Data Quality Report",
        "",
        "## Dataset",
        f"- Input file: `{RAW_FILE.relative_to(PROJECT_ROOT)}`",
        f"- Output file: `{OUTPUT_FILE.relative_to(PROJECT_ROOT)}`",
        f"- Input rows: {initial_rows:,}",
        f"- Output rows: {len(df):,}",
        f"- Input columns: {initial_columns:,}",
        f"- Output columns: {len(df.columns):,}",
        f"- Exact duplicate rows detected: {duplicate_rows:,}",
        "",
        "## Missing Values",
    ]

    if missing_columns:
        report_lines.extend(
            f"- `{column}`: {count:,}"
            for column, count in missing_columns.items()
        )
    else:
        report_lines.append("- No missing values detected.")

    report_lines.extend(["", "## Date Conversion Errors"])
    if date_conversion_errors:
        report_lines.extend(
            f"- `{column}`: {count:,}"
            for column, count in date_conversion_errors.items()
        )
    else:
        report_lines.append("- No date conversion errors detected.")

    report_lines.extend(["", "## Numeric Conversion Errors"])
    if numeric_conversion_errors:
        report_lines.extend(
            f"- `{column}`: {count:,}"
            for column, count in numeric_conversion_errors.items()
        )
    else:
        report_lines.append("- No numeric conversion errors detected.")

    report_lines.extend([
        "",
        "## Cleaning Notes",
        "- Exact duplicate rows were counted, not automatically deleted.",
        "- Missing values were reported, not automatically filled or dropped.",
        "- Conversion errors should be investigated before analysis.",
        "- Review the output and compare its metrics with the source data.",
        "",
    ])

    QUALITY_REPORT.write_text(
        "\n".join(report_lines),
        encoding="utf-8",
    )

    print(f"Input rows: {initial_rows:,}")
    print(f"Output rows: {len(df):,}")
    print(f"Duplicate rows detected: {duplicate_rows:,}")
    print(f"Cleaned dataset saved to: {OUTPUT_FILE}")
    print(f"Quality report saved to: {QUALITY_REPORT}")


if __name__ == "__main__":
    main()
