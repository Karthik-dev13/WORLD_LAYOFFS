# 📊 Global Layoffs Data Analysis (SQL Project)

## 🧩 Project Overview

This project focuses on **data cleaning and exploratory data analysis (EDA)** using SQL to uncover insights from a global layoffs dataset.
It involves preparing raw data for analysis, removing inconsistencies, and exploring trends in layoffs by **company, country, industry, and time**.

---

## 📁 Repository Structure

```
├── layoffs.csv                             # Raw dataset
├── DATA CLEANING(layoffs).sql              # SQL script for data cleaning and preprocessing
├── EXPLORATORY DATA ANALYSIS(layoffs).sql  # SQL script for performing EDA
└── README.md                               # Project documentation
```

---

## 🧹 1. Data Cleaning Process

**Script:** `DATA CLEANING(layoffs).sql`

The goal was to transform raw data into a consistent, accurate, and analysis-ready format.

### Key Steps:

1. **Duplicate Removal:**

   * Identified duplicates using `ROW_NUMBER()` with `PARTITION BY` on key columns.
   * Deleted redundant rows to retain unique records.

2. **Standardization:**

   * Trimmed extra spaces in text columns.
   * Standardized inconsistent values (e.g., `Crypto`, `cryptoCurrency`, `crypto Currency` → `crypto`).
   * Fixed inconsistent country names (`United States.` → `United States`).

3. **Data Type Conversion:**

   * Converted `date` column from text to `DATE` format using `STR_TO_DATE()`.

4. **Handling Missing Values:**

   * Removed rows where both `total_laid_off` and `percentage_laid_off` were `NULL`.
   * Filled missing industry values using data from other rows of the same company.

5. **Final Cleanup:**

   * Dropped helper columns like `row_num` after cleaning.

The cleaned data was stored in a staging table named `layoffs_staging2`.

---

## 🔍 2. Exploratory Data Analysis (EDA)

**Script:** `EXPLORATORY DATA ANALYSIS(layoffs).sql`

The EDA phase focused on understanding layoff trends and drawing insights from the cleaned dataset.

### Analysis Performed:

* **Overall Layoff Scale:**

  * Maximum and minimum layoffs.
  * Percentage of companies with 100% layoffs.

* **Top Performers:**

  * Companies with the highest layoffs (single events and totals).
  * Locations and countries most affected.

* **Industry & Stage Trends:**

  * Layoffs grouped by industry and funding stage.

* **Time-based Insights:**

  * Yearly and monthly layoff trends.
  * Rolling total layoffs using `WINDOW FUNCTIONS` (`SUM() OVER`).

* **Ranking Analysis:**

  * Identified top 3 companies with the most layoffs per year using `DENSE_RANK()`.

---

## 📈 Key Insights

* Startups in the **crypto** and **tech** sectors faced the largest number of layoffs.
* **United States** recorded the highest layoffs overall.
* Peak layoffs occurred during **2022–2023**, aligning with global economic slowdowns.
* Layoffs were more common in **late-stage startups** than early-stage ventures.

---

## ⚙️ Tools & Technologies

* **Database:** MySQL
* **Language:** SQL
* **Concepts Used:**

  * CTEs
  * Window Functions (`ROW_NUMBER`, `DENSE_RANK`, `SUM OVER`)
  * Data Cleaning & Type Conversion
  * Grouping and Aggregation

---

## 🚀 How to Run the Project

1. Download the repository or clone it:

   ```bash
   git clone https://github.com/<your-username>/layoffs-sql-analysis.git
   ```
2. Import `layoffs.csv` into your MySQL database.
3. Run `DATA CLEANING(layoffs).sql` to prepare the cleaned dataset.
4. Run `EXPLORATORY DATA ANALYSIS(layoffs).sql` to generate analytical insights.

---

## 📬 Contact

**Author:** Karthik Valiveti
**Email:** [[your-email@example.com](mailto:your-email@example.com)]
**GitHub:** [github.com/Karthik-dev13](https://github.com/Karthik-dev13)

---

