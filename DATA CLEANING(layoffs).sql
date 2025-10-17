-- Data Cleaning

SELECT *
FROM layoffs;

-- Steps:
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Value or Blamk values
-- 4. Remove Any Columns

-- Creating a copy of Dataset for staging
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- checking duplicates

WITH duplicate_cte AS
(
Select *,
ROW_NUMBER() OVER(PARTITION BY company,location,
industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT layoffs_staging2 
Select *,
ROW_NUMBER() OVER(PARTITION BY company,location,
industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;
-- rows need to be delected
SELECT * 
FROM layoffs_staging2
WHERE row_num>1;
-- deleting them
SET SQL_SAFE_UPDATES = 0;-- TO off safe update mode
DELETE 
FROM layoffs_staging2
WHERE row_num>1;
SET SQL_SAFE_UPDATES = 1;-- TO on safe update mode


-- Standardizing data
-- removing extra Spaces
SELECT company, TRIM(company)
FROM layoffs_staging2;

-- updating trimmed names
UPDATE layoffs_staging2
SET company=TRIM(company);

-- changing similar industry names into a single name
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;-- from hear we found that crypto, cryptoCurrency, crypto Currency are the same thing

UPDATE layoffs_staging2
SET industry='crypto'
WHERE industry LIKE 'Crypto%';

-- checking the changes
SELECT * 
FROM layoffs_staging2
WHERE industry='crypto';

-- checking issues in location
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;-- no issues

-- checking issues in country
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;-- issue at united states

SELECT DISTINCT country,TRIM(Trailing '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country =TRIM(Trailing '.' FROM country)
WHERE country LIKE 'united states%';

-- changing date from text to date  
SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`=STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- empty or nulls
-- layoffs
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; -- we dont know if there are actually any lay offs so we're gonna delete them
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- industry
UPDATE layoffs_staging2
SET industry=NULL
WHERE industry =''; -- to avoid redundency

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL OR industry ='';-- identifying empty industry columns

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
SET t1.industry=t2.industry
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;

-- dropping row_num
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;






