# SQL Project: Data Cleaning (Layoffs Dataset)

## Project Overview
This project focuses on cleaning a dataset containing global tech layoffs. The goal was to clean and prepare the data for further analysis using SQL.

## Dataset Fields
- `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`
- `date`, `stage`, `country`, `funds_raised_millions`

## Cleaning Steps
- Removed duplicate records using `ROW_NUMBER()`
- Trimmed whitespace from fields like `company` and `industry`
- Standardized values (e.g., Crypto naming inconsistency)
- Fixed country formatting issues
- Converted `date` from text to proper SQL `DATE` type
- Handled NULLs in `industry` using self-joins
- Removed rows with both `total_laid_off` and `percentage_laid_off` as NULL

## Files
- [layoffs.csv](./layoffs.csv) – Inspect original data
- [layoffs_data_cleaning.sql](./layoffs_data_cleaning.sql) – All cleaning operations
- [layoffs_clean.csv]('/layoffs_clean.csv) – Final clean table used for EDA

## Skills Used
- Window functions
- String and date manipulation
- NULL handling
- Table creation and transformation

## Tools
- MySQL 8+

