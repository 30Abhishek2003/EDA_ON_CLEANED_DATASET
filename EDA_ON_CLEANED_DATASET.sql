-- EXPLORATORY DATA ANALYSIS

USE World_layoffs;

SELECT *
FROM layoffs_staging2;

SELECT company , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT industry , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT MAX(date) , MIN(date)
FROM layoffs_staging2;

SELECT year(date) , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY year(date)
ORDER BY 1 DESC;

SELECT stage , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

select *
from layoffs_staging2;

select substring(`date` , 1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
WHERE substring(`date` , 1,7) IS NOT NULL
group by `MONTH`
order by 1 ASC;

WITH ROLLING_TOTAL AS
(select substring(`date` , 1,7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2
WHERE substring(`date` , 1,7) IS NOT NULL
group by `MONTH`
order by 1 ASC
)
SELECT `MONTH` , total_off , SUM(total_off) 
OVER(order by `MONTH` ) AS Rolling_Total
FROM ROLLING_TOTAL;


select company ,YEAR(`date`) , sum(total_laid_off)
from layoffs_staging2
group by company , YEAR(`date`)
order by company;

WITH company_layoff  (company , year , total_laid_off) AS
(
select company ,YEAR(`date`) , sum(total_laid_off)
from layoffs_staging2
group by company , YEAR(`date`)
order by company
),company_year_layoff AS(
select * ,
DENSE_RANK() OVER(PARTITION BY year  ORDER BY total_laid_off DESC) AS RANKING
FROM company_layoff
WHERE year IS NOT NULL			
)
SELECT *
FROM company_year_layoff
WHERE RANKING <=5;