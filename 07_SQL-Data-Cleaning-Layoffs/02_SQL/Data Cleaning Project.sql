-- SQL Project - Data Cleaning --

SELECT * 
FROM layoffs
;

-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens --

CREATE TABLE layoffs_staging 
LIKE layoffs
;

SELECT *
FROM layoffs_staging
;

INSERT layoffs_staging 
SELECT * FROM layoffs
;

-- now when we are data cleaning we usually follow a few steps --
-- 1. check for duplicates and remove any --
-- 2. standardize data and fix errors --
-- 3. Look at null values and see what --
-- 4. remove any columns and rows that are not necessary - few ways --

-- 1. Remove Duplicates --

# First let's check for duplicates

SELECT *
FROM layoffs_staging
;

SELECT company, industry, total_laid_off, `date`,
ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off, `date`) AS row_num
FROM layoffs_staging
;

SELECT *
FROM (SELECT company, industry, total_laid_off, `date`,
ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off, `date`) AS row_num
FROM layoffs_staging
) duplicates
WHERE row_num > 1
; 
    
-- let's just look at oda to confirm --

SELECT *
FROM world_layoffs.layoffs_staging
WHERE company = 'Oda'
;

-- it looks like these are all legitimate entries and shouldn't be deleted. We need to really look at every single row to be accurate --

-- these are our real duplicates --

SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM world_layoffs.layoffs_staging
) duplicates
WHERE row_num > 1
;

SELECT *
FROM world_layoffs.layoffs_staging
WHERE company = 'Cazoo'
;

-- these are the ones we want to delete where the row number is > 1 or 2or greater essentially --
-- one solution, which I think is a good one. Is to create a new column and add those row numbers in. Then delete where row numbers are over 2, then delete that column --
-- so let's do it!! --

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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;

SELECT *
FROM layoffs_staging2
;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1
;

-- now that we have this we can delete rows were row_num is greater than 2 --

DELETE FROM layoffs_staging2
WHERE row_num > 1
;

SELECT *
FROM layoffs_staging2
WHERE company = 'Cazoo'
;

-- Standardisasi Data --

-- Perbaiki perusahaan dengan spasi berlebih dan mengupdatenya --

SELECT company, TRIM(company)
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET company = TRIM(company)
;

-- Perbaiki nama industry yang hampir sama --

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry
;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'
;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;

-- Perbaiki nama negara yang sama (ada tanda baca berlebih) --

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY country
;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States'
ORDER BY country
;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY country
;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'
;

-- Mengubah format tanggal --

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
;

SELECT `date`
FROM layoffs_staging2
;

-- Mengubah jenis data "date" --

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE
;

-- Mengisi missing value berdasarkan data yang sudah ada valuenya --

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
;

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb'
;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''
;

SELECT t1.company, t1.industry, t2.industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
;

UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL
;

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb'
;

-- Menghapus baris yang tidak berguna (total dan percentage laid off tidak ada data) --

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

-- Hapus kolom row_num --

ALTER TABLE layoffs_staging2
DROP COLUMN row_num
;

-- CEK HASIL AKHIR DATA CLEANING --

SELECT *
FROM layoffs_staging2
;