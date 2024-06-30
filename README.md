# Salary of Data Professionals

This project involves comprehensive data cleaning, standardization, and analysis of a salary dataset using SQL. The dataset covers salary information from 2020 to 2024, including various job titles, experience levels, employment types, and company sizes. The project aims to extract meaningful insights and trends from the data through a series of SQL queries.

# Project Overview

**1. Database Setup and Structure Overview**
- Used the Data_Sal database.
- Analyzed the distinct values for work_year, experience_level, employment_type, and company_size.
     
**2. Data Cleaning**
- Checked for null values and confirmed there were none.
- Assessed duplicates and determined to proceed under the assumption that dimilar records were not an indicator of duplicacy but is due to multiple jobs with the exact same role in the same company.
- Standardized the data by modifying column data types and updating values for clarity.
- Grouped job titles into relevant domains to exhance the analysis.

  **3. Exploratory Data Analysis (EDA)**

  - Identified the job with the maximum salary.
  - Calculated the average salary across different domains.
  - Analyzed the employment distribution across different company sizes.
  - Determined the percentage of remote work.
  - Assessed the distribution of experience levels and their corresponding average salaries.
  - Evaluated the distribution of jobs across different years.
  - Compared maximum salaries for specific countries (India, Britain, and the US) for the year 2023.
  - Analyzed the average salary trends across domains and years, excluding the year 2020.
  - Identified the most popular domains among small, mid-sized, and large firms.
  - Ranked the top three jobs within each domain based on average salary.

**4. Key Findings**
- Machine Learning professionals have the highest average salary, while Data Analysis roles have the lowest.
- On-site roles are predominant (67.24%), with completely remote jobs accounting for 31.25%.
- Machine Learning is most popular in small firms, Data Engineering in mid-sized firms, and Data Science in large firms.
- The highest salary recorded, according to the data, was $800,000 for an AI Architect in 2024.

# Conclusion

This project demonstrates the power of SQL in cleaning, standardizing, and analyzing a complex dataset. The insights derived can help organizations understand salary trends and make informed decisions regarding employment and compensation strategies in the data industry.
