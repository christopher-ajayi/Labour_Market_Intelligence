--Missing Salary Rate: 754,586
SELECT
    COUNT(*) AS missing_salary
 FROM  job_postings_fact jpf 
WHERE jpf.salary_rate IS NULL;

--Missing Yearly Salary: 765,652
SELECT
 COUNT(*) AS missing_yearly_salary
FROM job_postings_fact jpf 
WHERE jpf.salary_year_avg  IS NULL;

--Missing Hourly Salary: 777,021
SELECT
 COUNT(*) AS missing_hourly_salary
FROM job_postings_fact jpf 
WHERE jpf.salary_hour_avg IS NULL;

--Missing Company ID: 0
SELECT
 COUNT(*) AS missing_company
FROM job_postings_fact jpf 
WHERE jpf.company_id IS NULL;

--Missing Job Location: 1053
SELECT
 COUNT(*) AS missing_location
FROM job_postings_fact jpf 
WHERE jpf.job_location IS NULL;

--Missing Job Title: 1
SELECT
 COUNT(*) AS missing_job_title
FROM job_postings_fact jpf 
WHERE jpf.job_title  IS NULL;


--Company Data Integrity
SELECT 
    company_id, 
    name
FROM company_dim cd
WHERE cd.company_id IS NULL OR name IS NULL;


--Company Integrity = zero null companies
SELECT 
    count(*)
FROM
    job_postings_fact jpf 
WHERE jpf.company_id NOT IN 
(
    SELECT cd.company_id
    FROM company_dim cd 
    WHERE cd.company_id IS NOT NULL)

--Checking if all skills exists = 0
SELECT 
       COUNT(*)
FROM 
    skills_dim sd
INNER JOIN skills_job_dim sjd ON 
SD.skill_id = sjd.skill_id
WHERE sd.skill_id IS NULL

--Data Quality seems to be good on average.

