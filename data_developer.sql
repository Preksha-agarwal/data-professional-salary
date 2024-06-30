USE Data_Sal;


-- DSTRUCTURE OVERVIEW
SELECT * FROM Salary;


-- Make a backup table Salary1
-- Working table is Salary
CREATE TABLE IF NOT EXISTS Salary1
SELECT * FROM Salary;


SELECT DISTINCT(work_year)
FROM Salary;
-- Data given for the year 2020-2024


SELECT DISTINCT(experience_level)
FROM Salary;
-- There are only 4 values for experience level of the job
-- 1. SE: Senior level
-- 2. Mi: Mid-Senior level
-- 3. EN: Entry level
-- 4. EX: Experienced


SELECT DISTINCT(employment_type)
FROM Salary;
-- There are only 4 values for employment type
-- 1. FT: Full Time
-- 2. CT: Contract
-- 3. PT: Part Time
-- 4. FL: Flexible


SELECT DISTINCT(company_size)
FROM Salary;
-- There are only 3 values for company size
-- 1. S: Small size
-- 2. M: Medium sized
-- 3. L: Large sized


-- DATA CLEANING
-- To Clean Data: 
-- Deal with Null Values 
-- Remove duplicates
-- Standardize data 
-- Remove unnecessary rows and columns


-- 1. Check for NULL values
SELECT * FROM Salary
WHERE work_year IS NULL;


SELECT * FROM Salary
WHERE experience_level IS NULL;


SELECT * FROM Salary
WHERE employment_type IS NULL;


SELECT * FROM Salary
WHERE job_title IS NULL;


SELECT * FROM Salary
WHERE salary_in_usd IS NULL;


SELECT * FROM Salary
WHERE remote_ratio IS NULL;


SELECT * FROM Salary
WHERE company_size IS NULL;
-- No NULL values in the data


-- 2. Check for duplicates
WITH CTE AS
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY work_year, experience_level,employment_type,job_title,salary,salary_currency,salary_in_usd,employee_residence,
				remote_ratio, company_location, company_size) AS row_num
FROM Salary
)
SELECT * FROM CTE
WHERE row_num>1;
-- We see that there are many records that are same
-- But we cannot say that these are all duplicates as there may be a scenario where multiple companies have multiple people
-- for the same role with the exact same amount of package. Therefore, we will continue with the analyses under the assumption
-- that there are no duplicates in the data.


SET SQL_SAFE_UPDATES = 0;

DESC Salary;


-- 3. Standardize the data
-- Firstly, change the datatype of the columns

ALTER TABLE Salary
MODIFY COLUMN experience_level VARCHAR(20);


ALTER TABLE Salary
MODIFY COLUMN employment_type VARCHAR(20);


ALTER TABLE Salary
MODIFY COLUMN company_size VARCHAR(10);


-- Update the records to give more clarity

-- For experience_level column
UPDATE Salary
SET experience_level='Senior'
WHERE experience_level='SE';


UPDATE Salary
SET experience_level='Mid-Senior'
WHERE experience_level='MI';


UPDATE Salary
SET experience_level='Experienced'
WHERE experience_level='EX';


UPDATE Salary
SET experience_level='Entry'
WHERE experience_level='EN';


-- For employment_type column
UPDATE Salary
SET employment_type='Full-Time'
WHERE employment_type='FT';


UPDATE Salary
SET employment_type='Part-Time'
WHERE employment_type='PT';


UPDATE Salary
SET employment_type='Contract'
WHERE employment_type='CT';


UPDATE Salary
SET employment_type='Flexible'
WHERE employment_type='FL';


-- For company_size column
UPDATE Salary
SET company_size='Small'
WHERE company_size='S';


UPDATE Salary
SET company_size='Medium'
WHERE company_size='M';


UPDATE Salary
SET company_size='Large'
WHERE company_size='L';


SELECT * FROM Salary;


-- Look at all the distinct values of jobs in the data
SELECT DISTINCT(job_title)
FROM Salary
ORDER BY job_title;


-- The distinct number of roles is huge. But we see that there are many roles in the data that fall under the same domain.
-- We will create a new column and group all the roles falling under the similar domain.
-- The Domians will be:
-- 1. Data Science 
-- 2. Machine Learning
-- 3. Business Intelligence
-- 4. Artificial Intelligence
-- 5. Data Analysis
-- 6. Data Engineering
-- 7. Data Management
-- 8. Data Specialized Roles

ALTER TABLE Salary
ADD Domain VARCHAR(30);


-- For Data Science roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE job_title LIKE '%data scien%' OR job_title LIKE '%Data scien%';

UPDATE Salary 
SET Domain='Data Science'
WHERE job_title IN(
'Data Scientist',
'Data Science Manager',
'Data Science',
'Data Science Engineer',
'Data Science Consultant',
'Lead Data Scientist',
'Data Science Analyst',
'Data Science Practitioner',
'Applied Data Scientist',
'Data Science Director',
'Data Science Lead',
'Director of Data Science',
'Managing Director Data Science',
'Marketing Data Scientist',
'Principal Data Scientist',
'Head of Data Science',
'Staff Data Scientist',
'Data Science Tech Lead',
'Data Scientist Lead',
'Applied Scientist',
'Decision Scientist'
);


-- For machine learning roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE (job_title LIKE '%ML%' OR job_title LIKE '%Machine%')
AND job_title IN (
					SELECT DISTINCT(job_title)
                    FROM Salary
                    WHERE Domain IS NULL);

UPDATE Salary 
SET Domain='Machine Learning'
WHERE job_title IN(
'Machine Learning Engineer',
'ML Engineer',
'Machine Learning Scientist',
'Machine Learning Operations Engineer',
'Machine Learning Developer',
'MLOps Engineer',
'Machine Learning Infrastructure Engineer',
'Machine Learning Researcher',
'Lead Machine Learning Engineer',
'Machine Learning Research Engineer',
'Head of Machine Learning',
'ML Ops Engineer',
'Machine Learning Modeler',
'Machine Learning Software Engineer',
'Applied Machine Learning Scientist',
'Machine Learning Manager',
'Principal Machine Learning Engineer',
'Staff Machine Learning Engineer',
'Machine Learning Specialist',
'Applied Machine Learning Engineer',
'Research Engineer'
);


-- For business intelligence roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE (job_title LIKE '%BI%' OR job_title LIKE '%Business Intelligence%')
AND job_title IN (
					SELECT DISTINCT(job_title)
                    FROM Salary
                    WHERE Domain IS NULL);

UPDATE Salary 
SET Domain='Business Intelligence'
WHERE job_title IN(
'Business Intelligence Engineer',
'Business Intelligence',
'Business Intelligence Lead',
'Business Intelligence Analyst',
'Business Intelligence Developer',
'BI Developer',
'Business Intelligence Manager',
'Business Intelligence Specialist',
'Director of Business Intelligence',
'BI Analyst',
'BI Data Analyst',
'Power BI Developer',
'Business Intelligence Data Analyst',
'BI Data Engineer'
);


-- For artificial intelligence roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE (job_title LIKE '%AI%' OR job_title LIKE '%Artificial Intelligence%')
AND job_title IN (
					SELECT DISTINCT(job_title)
                    FROM Salary
                    WHERE Domain IS NULL);

UPDATE Salary 
SET Domain='Artificial Intelligence'
WHERE job_title IN(
'AI Engineer',
'AI Software Engineer',
'AI Scientist',
'AI Research Scientist',
'AI Architect',
'AI Research Engineer',
'AI Programmer',
'AI Product Manager',
'AI Developer',
'NLP Engineer',
'Prompt Engineer'
);


-- For data engineering roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE ( job_title LIKE '%Engineer%' OR job_title LIKE '%Developer%' OR job_title LIKE '%Archi%')
AND job_title IN (	SELECT DISTINCT(job_title)
                    FROM Salary
                    WHERE Domain IS NULL);

UPDATE Salary 
SET Domain='Data Engineering'
WHERE job_title IN(
'Azure Data Engineer',
'Big Data Developer',
'Big Data Engineer',
'Cloud Data Engineer',
'Cloud Database Engineer',
'Data Developer',
'Data DevOps Engineer',
'Data Engineer',
'Data Infrastructure Engineer',
'Data Integration Engineer',
'Data Quality Engineer',
'ETL Developer',
'ETL Engineer',
'Lead Data Engineer',
'Principal Data Engineer',
'Data Architect',
'AWS Data Architect',
'Big Data Architect',
'Principal Data Architect',
'Cloud Data Architect',
'Consultant Data Engineer',
'Data Integration Developer',
'Data Integration Specialist',
'Data Integration Specialist',
'Software Data Engineer',
'Marketing Data Engineer',
'Data Modeller',
'Data Modeler'
);


-- For data analysis roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE (job_title LIKE '%analytics%' OR job_title LIKE '%analyst%')
AND job_title IN (	SELECT DISTINCT(job_title)
                    FROM Salary
                    WHERE Domain IS NULL);

UPDATE Salary 
SET Domain='Data Analysis'
WHERE job_title IN(
'Data Analyst',
'Data Visualization Specialist',
'Analytics Engineer',
'Data Analytics Specialist',
'Research Analyst',
'Data Analytics Lead',
'Data Analytics Manager',
'Data Analytics Associate',
'Data Analytics Consultant',
'Data Analyst Lead',
'Lead Data Analyst',
'Business Data Analyst',
'Financial Data Analyst',
'Staff Data Analyst',
'Finance Data Analyst',
'Compliance Data Analyst',
'Analytics Engineering Manager',
'Product Data Analyst',
'Data Visualization Analyst',
'Sales Data Analyst',
'Marketing Data Analyst',
'Data Analytics Engineer',
'Principal Data Analyst',
'Data Visualization Engineer',
'Consultant Data Engineer',
'Admin & Data Analyst',
'CRM Data Analyst',
'Data Reporting Analyst',
'Data Quality Analyst'
);


-- For Specialized Roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE (job_title LIKE '%Robotics%' OR job_title LIKE '%Deep%')
AND job_title IN (	SELECT DISTINCT(job_title)
                    FROM Salary
                    WHERE Domain IS NULL);
UPDATE Salary 
SET Domain='Data Specialized Roles'
WHERE job_title IN(
'Robotics Engineer',
'Bear Robotics',
'Robotics Software Engineer',
'Deep Learning Engineer',
'Deep Learning Researcher',
'Quantitative Research Analyst',
'Insight Analyst',
'Quantitative Research Analyst',
'Autonomous Vehicle Technician',
'Computational Biologist',
'Applied Research Scientist',
'Computer Vision Engineer',
'Computer Vision Software Engineer',
'Data Pipeline Engineer',
'Research Scientist',
'Data Specialist',
'Data Strategist'
);


-- For data management roles
SELECT DISTINCT(job_title)
FROM Salary
WHERE (job_title LIKE '%Mana%' OR job_title LIKE '%operation%' OR job_title LIKE '%head%');

UPDATE Salary 
SET Domain='Data Management'
WHERE job_title IN(
'Data Manager',
'Data Operations Manager',
'Data Science Manager',
'Data Product Manager',
'Encounter Data Management Professional',
'Data Management Specialist',
'Business Intelligence Manager',
'Manager Data Management',
'Data Quality Manager',
'Data Analytics Manager',
'Data Operations Analyst',
'Data Operations Specialist',
'Data Operations Associate',
'Data Management Consultant',
'AI Product Manager',
'Managing Director Data Science',
'Data Strategy Manager',
'Data Operations Engineer',
'Machine Learning Manager',
'Analytics Engineering Manager',
'Head of Data',
'Data Lead',
'Data Product Owner',
'Data Management Analyst'
);


-- To check for roles that are left
SELECT DISTINCT(job_title)
FROM Salary
WHERE Domain IS NULL;
-- We have successfully added domains to all of the data


SELECT * FROM Salary;
-- We have completed Cleaning of the data


-- EXPLORATORY DATA ANALYSIS

-- QUESTION: Find the job with the maximum salary for the year 2023
SELECT work_year,job_title,salary_in_usd,domain
FROM Salary
WHERE salary_in_usd=(SELECT MAX(salary_in_usd)
					 FROM Salary);
-- The maximum salary was given in the year 2024 to an AI architect
-- with the amount of USD 8,00,000


-- QUESTION: Average Salary Across Each Domain
SELECT Domain, AVG(salary_in_usd) AS Average_Salary
FROM Salary
GROUP BY Domain
ORDER BY average DESC;
-- The Highest Average Salary is in the domain of Machine Learning
-- The Lowest Average Salary is in the domain of Data Analysis
-- The averge salary in Artificial Intelligence is more than that of Data Science


-- QUESTION: Which type of firm employed maximum data professionals?
SELECT company_size, 
ROUND(COUNT(company_size)*100/(SELECT COUNT(*) FROM Salary),2) AS 'Percentage'
FROM Salary
GROUP BY company_size;
-- Medium-sized firms employed the maximum data professionals i.e. 92.57%
-- Medium-sized firms employed 6.29% and Small-sized firms employeed 1.14%


-- QUESTION: Find the percentage of remote work done
SELECT remote_ratio, 
ROUND(COUNT(remote_ratio)*100/(SELECT COUNT(*) FROM Salary),2) AS percentage
FROM Salary
GROUP BY remote_ratio
ORDER BY percentage DESC;
-- Most of the roles(67.24%) are for on-site work
-- Completely remote work make up for 31.25% of the total work


-- QUESTION: To find the percentage of experience level in the data
SELECT experience_level,
ROUND(COUNT(experience_level)*100/(SELECT COUNT(*) FROM Salary),2) AS percentage
FROM Salary
GROUP BY experience_level
ORDER BY percentage DESC;
-- 64.53% of the people have senior level of experience
-- 24.42%, 8.01% of the data consitutes of Mid-Senior and Entry level of experience respectively


-- QUESTION: To find the average salary as per remote ratio
SELECT remote_ratio, AVG(salary_in_usd) avg_sal
FROM Salary
GROUP BY remote_ratio
ORDER BY avg_sal DESC;
-- On-site jobs have the maximum salary
-- Surprisingly, completely remote jobs are also not far behind in terms of salary


-- QUESTION: Find the number of jobs in each year
SELECT work_year, COUNT(work_year) AS frequency
FROM Salary
GROUP BY work_year
ORDER BY work_year;
-- Data is of post-covid period mostly
-- Even then, we have very less data for the years before 2023 as compared to the amount of records for 2023 and 2024
-- This unusual data distribution can be accounted for by a few factors:
-- 1. Bias in the way data was collected or reported before 2023
-- 2. The frequency of reporting time might have changed over time
 
 
-- QUESTIONS: Find the average salary among different experience levels for the years 2023 and 2024
SELECT experience_level, 
ROUND(AVG(salary_in_usd),2) AS 'Average Salary'
FROM Salary
WHERE work_year=2023 OR work_year=2024
GROUP BY experience_level
ORDER BY 2 DESC;
-- Maximum salary in Experience roles. This result is not very accurate as there are 
-- small number of experienced data professionals. We will proceed with an exclusion of this category.
-- The average salary follows the order as expected, with the highest average salary of a Senior level
-- data professional all the way to lowest salary of the entry level data professional


 
-- QUESTION: Makeup of the job market on the basis of experience levels and employment type
SELECT experience_level, employment_type,
ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM Salary),2) AS percentage
FROM Salary
GROUP BY experience_level, employment_type
ORDER BY experience_level DESC, employment_type ASC;
-- For every experience level, full time roles are the most popular
-- Major jobs are occupied according to the following trend
-- 1. Senior
-- 2. Mid-Senior
-- 3. Entry
-- 4. Experienced


-- QUESTION: Compare the maximum salary of data professional hailing from India,Britain and the US for the year 2023
SELECT 
CASE
	WHEN employee_residence='US' THEN 'United States'
    WHEN employee_residence='IN' THEN 'India'
    WHEN employee_residence='GB' THEN 'Britain'
    END AS Country,
MAX(salary_in_usd) AS 'Salary in US Dollars'
FROM Salary
WHERE work_year=2023
GROUP BY employee_residence
HAVING employee_residence IN ('US','IN','GB');
-- Among all the data profiles, maxiumum salary obtained by employee in USA, followed by
-- employee in Britain, and then employee in India


-- QUESTION: Find the average salary for all the domains and years. Exclude the year 2020
WITH CTE AS
(
SELECT * FROM Salary
WHERE work_year!=2020
) 
SELECT work_year, Domain, AVG(salary_in_usd) AS avg_sal
FROM CTE
GROUP BY work_year, Domain
ORDER BY work_year ASC,avg_sal DESC;
-- We can see that Machine Learning has more or less been the highest paying data domain recently
-- Whereas Data Analysis has consistently been at the bottom in terms of pay

-- QUESTION: Find the domain which is most popular among small, mid-sized and large firms
WITH CTE1 AS
(
SELECT Domain,company_size,
COUNT(*) AS freq
FROM Salary
GROUP BY Domain,company_size
), CTE AS
(
SELECT Domain,company_size, freq,
ROW_NUMBER() OVER(PARTITION BY company_size ORDER BY freq DESC) AS row_num
FROM CTE1
)
SELECT company_size,Domain
FROM CTE
WHERE row_num=1
ORDER BY company_size DESC;
-- Machine Learning is the most popular job in small-sized firms
-- Data Engineering is the most popular job in mid-sized firms
-- Data Science is the most popular job in large-sized firms


-- QUESTION: Among each of the domain, find the top 3 jobs with ranking among all the years
WITH CTE1(Domain,job_title,salary_in_usd) AS
(
SELECT Domain,job_title, ROUND(AVG(salary_in_usd),0)
FROM Salary
GROUP BY Domain,job_title,salary_in_usd
), CTE AS
(
SELECT Domain,job_title, salary_in_usd,
DENSE_RANK() OVER(PARTITION BY Domain ORDER BY salary_in_usd DESC) AS ranking
FROM CTE1
)
SELECT *
FROM CTE
WHERE ranking<=3;
