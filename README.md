# Global Tech Layoffs — Exploratory Data Analysis (MySQL)

## Project Overview
This project explores a cleaned global tech layoffs dataset (`layoffs_staging2`) using **MySQL** to uncover key trends, high-impact events, and patterns across companies, industries, countries, funding stages, and time periods.

---

## Business Questions & Analytical Queries

### 1. Layoff Scale & Complete Company Shutdowns
* Queried `MAX(total_laid_off)` and `MAX(percentage_laid_off)` to identify the largest single-event workforce reductions.
* Filtered records where `percentage_laid_off = 1` (100% workforce reduction) and ordered by `total_laid_off` and `funds_raised_millions` to pinpoint which heavily funded companies shut down completely.

### 2. Aggregated Totals by Dimension (`GROUP BY`)
* **By Company:** Calculated `SUM(total_laid_off)` per company to identify organizations with the highest cumulative layoffs across multiple rounds.
* **By Industry:** Grouped layoffs by `industry` to reveal which sectors (e.g., Consumer, Retail, Transportation, Finance) were hit hardest.
* **By Country:** Aggregated total layoffs by `country` to compare regional impact globally.
* **By Funding Stage:** Evaluated layoffs across company maturity stages (`Post-IPO`, `Series B`, `Series C`, `Acquired`, etc.).

### 3. Time-Series Trends & Cumulative Rolling Totals
* **Date Range & Yearly Breakdown:** Used `MIN(\`date\`)`, `MAX(\`date\`)`, and `YEAR(\`date\`)` to measure year-over-year layoff shifts.
* **Monthly Rolling Total:** Extracted `YYYY-MM` periods using `SUBSTRING(\`date\`, 1, 7)` inside a **Common Table Expression (CTE)** and applied a window function (`SUM(total_off) OVER(ORDER BY \`MONTH\`)`) to track cumulative global layoffs month by month.

### 4. Top 5 Companies Ranked Per Year
* Chained multiple **CTEs** (`Company_Year` and `Company_Year_Rank`) using **`DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC)`** to rank the top 5 companies with the highest total layoffs for each individual year.

---

## Key Insights Uncovered
* **Post-IPO vs. Startup Impact:** Large public companies (`Post-IPO`) drove the highest total headcount reductions, whereas smaller, venture-backed companies represented the majority of 100% shutdowns.
* **Accelerated Layoff Waves:** Monthly rolling totals highlighted a sharp escalation in global workforce reductions throughout 2022 and early 2023.
* **Sector Concentration:** Consumer-facing and retail-driven tech industries experienced significantly higher cumulative layoffs compared to other sectors.

---

## Tools & SQL Concepts Used
* **Database:** MySQL / MySQL Workbench
* **SQL Techniques:** Common Table Expressions (CTEs), Window Functions (`DENSE_RANK()`, Rolling `SUM() OVER()`), Aggregations (`SUM`, `MAX`, `MIN`, `GROUP BY`), Date & String Functions (`YEAR()`, `SUBSTRING()`), Filtering & Sorting (`WHERE`, `ORDER BY`)
