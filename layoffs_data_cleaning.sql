-- DATA CLEANING IN MYSQL
-- create a backup table 
CREATE TABLE layoffs_backup AS
SELECT * FROM layoffs;

select * 
from layoffs_backup2;

-- identify duplicate and delete them
CREATE TABLE `layoffs_backup2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_backup2 
select *,
row_number() over(partition by company, location, industry, total_laid_off,percentage_laid_off,
`date`, stage, country, funds_raised_millions) as row_num
from layoffs_backup;

select *
from layoffs_backup2;

delete
from layoffs_backup2
where row_num >1;

-- fixing issues in the data
-- trim industry column
update layoffs_backup2
set company = trim(company);

SELECT DISTINCT industry
FROM layoffs_backup2
ORDER BY industry;

-- unifying cryptp, Crypto Currency, CryptoCurrency
UPDATE layoffs_backup2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

SELECT DISTINCT country
FROM layoffs_backup2
ORDER BY 1;

-- removing extra dot from countries that has it
SELECT DISTINCT country, trim(trailing '.' from country)
FROM layoffs_backup2
ORDER BY 1;

update layoffs_backup2
set country = trim(trailing '.' from country);

-- converting date column to proper date format
UPDATE layoffs_backup2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_backup2
MODIFY COLUMN `date` DATE;

-- fixing null and empty value in industry
select *
from layoffs_backup2
where industry is null
or industry = '';

UPDATE layoffs_backup2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_backup2 t1
JOIN layoffs_backup2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_backup2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- drop the row_num as its not needed
ALTER TABLE layoffs_backup2
DROP COLUMN row_num;

-- noticed some rows has null value for both total layoff and percentage layoff. check if its a significant number
SELECT COUNT(*) 
FROM layoffs_backup2;

SELECT COUNT(*) AS null_rows
FROM layoffs_backup
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Create a cleaned version of the layoffs table for analysis,
-- excluding rows where both 'total_layoff' and 'percentage_layoff' are null
CREATE TABLE layoffs_clean AS
SELECT *
FROM layoffs_backup2
WHERE total_laid_off IS NOT NULL
AND percentage_laid_off IS NOT NULL;

-- view the table 
select * 
from layoffs_clean;
