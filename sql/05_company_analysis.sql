--the analysis in this section aims at understanding employers hiring behavior.
-- This will be a useful analysis for job seekers, HR professionals, labour market researchers and public policy analysts.

-- 20 Companies that posted the most jobs.
SELECT cd."name",
        count(jpf.job_posted_date) AS company_job_count
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
GROUP BY cd."name"
ORDER BY company_job_count DESC
LIMIT 20

--Companies that recruited for the greatest varieties of job titles

SELECT cd."name",
        count(DISTINCT jpf.job_title_short) AS job_varieties 
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
GROUP BY cd."name"
ORDER BY job_varieties  DESC


-- Companies that offered the greatest pay

SELECT cd.name,
        avg(jpf.salary_year_avg)  AS avg_salary
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.salary_year_avg IS NOT NULL 
GROUP BY cd.name
HAVING COUNT(*) >= 10
ORDER BY avg_salary  DESC

-- Companies that hire the highest remote workers
SELECT cd."name",
    count(jpf.job_work_from_home) remote_worker_demand
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.job_work_from_home = TRUE
GROUP BY name
ORDER BY remote_worker_demand DESC

-- Companies that hire remote Data Analyst the most

SELECT cd."name",
    count(jpf.job_work_from_home) remote_data_analyst
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.job_work_from_home = TRUE AND 
jpf.job_title_short = 'Data Analyst'
GROUP BY name
ORDER BY remote_data_analyst DESC
LIMIT 10

-- Companies that hire remote Business Analyst the most

SELECT cd."name",
    count(jpf.job_work_from_home) remote_business_analyst
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.job_work_from_home = TRUE AND 
jpf.job_title_short = 'Business Analyst'
GROUP BY name
ORDER BY remote_business_analyst  DESC
LIMIT 10


-- Companies that provide health insurance most frequently

SELECT cd."name",
    count(jpf.job_health_insurance) health_insurance
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.job_health_insurance  = TRUE
GROUP BY name
ORDER BY health_insurance DESC
LIMIT 10



-- Company with the hightest paying individual jobs
SELECT name,
        jpf.job_title_short AS role,
        jpf.job_location AS location,
        jpf.salary_year_avg AS salary
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id 
WHERE jpf.salary_year_avg IS NOT NULL
ORDER BY salary DESC
LIMIT 20


-- Companies that hired the most Data Analyst
SELECT name AS Company,
      count(jpf.job_title_short) AS avg_data_analyst_hire
FROM job_postings_fact jpf  
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.job_title_short = 'Data Analyst'
GROUP BY company 
ORDER BY avg_data_analyst_hire DESC
LIMIT 15


-- Companies that hired the most Busines Analyst

SELECT name AS Company,
      count(jpf.job_title_short) AS avg_bus_analyst_hire
FROM job_postings_fact jpf  
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
WHERE jpf.job_title_short = 'Business Analyst'
GROUP BY company 
ORDER BY avg_bus_analyst_hire DESC
LIMIT 15


-- Company Hiring by year
SELECT name AS Company,
COUNT
(CASE WHEN EXTRACT(YEAR FROM job_posted_date) = 2022 THEN 1 END) AS year2022,
COUNT(CASE WHEN EXTRACT(YEAR FROM job_posted_date) = 2023 THEN 1 END) AS year2023
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id
GROUP BY company
ORDER BY year2023 DESC



-- total hiring for companies in 2022
SELECT name,
        count(jpf.job_posted_date) AS hires_in_2023
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON
jpf.company_id = cd.company_id
WHERE jpf.job_posted_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY name
ORDER BY hires_in_2023  desc


-- total hiring for companies in 2022
SELECT name,
        count(jpf.job_posted_date) AS hires_before_2023
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON
jpf.company_id = cd.company_id
WHERE jpf.job_posted_date < '2023-01-01'
GROUP BY name
ORDER BY hires_before_2023  desc
LIMIT 10

-- Data Roles by Company
SELECT name,
        count(DISTINCT job_title_short) AS data_role_count
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON
jpf.company_id = cd.company_id
WHERE jpf.job_title_short IN (
'Business Analyst', 
'Cloud Engineer', 
'Data Analyst', 
'Data Engineer', 
'Data Scientiest',
'Machine Learnig Engineer',
'Senior Data Analyst',
'Senior Data Engineer',
'Senior Data Scientist',
'Software Engineer'
)
GROUP BY name
ORDER BY data_role_count desc
LIMIT 10

SELECT DISTINCT jpf.job_title_short 
FROM job_postings_fact jpf 



