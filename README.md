# CREDIT-RISK
CREATED AN SQL BASED CREDIT RISK PROJECT TO ASSIGN EACH CUSTOMER A RISK RATING 

# Credit Risk Analysis Using SQL

## Overview
This project analyzes customer credit risk using SQL. It categorizes individuals into risk levels based on factors such as income, loan amount, home ownership, and credit history. The dataset is processed, transformed, and stored for further analysis.

## Data Processing Steps
1. **Dataset Creation**: A copy of `credit_risk_dataset` is created for modifications.
2. **Column Enhancements**:
   - Added `row_index` as the primary key.
   - Added `credit_risk` column for categorization.
3. **Risk Classification**:
   - Customers categorized into `HIGH RISK`, `MEDIUM RISK`, and `LOW RISK` based on various financial factors.
4. **Aggregations**:
   - Number of customers per risk profile.
   - Average loan interest rate per risk category.
   - Breakdown of default rates among risk levels.
5. **Exporting Reports**:
   - Credit risk dataset exported as `.csv` files for reporting.

## SQL Queries Used
- **Data Transformation**
- **Risk Categorization**
- **Data Export**
- **Aggregations and Insights**

## How to Use
1. Clone the repository:
   ```sh
   git clone https://github.com/sumit3178/Credit-Risk.git
