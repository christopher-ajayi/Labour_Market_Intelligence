-- This section reveals a few more insights into the data. We would be exploring questions such as:

--1. Ranking Highest Paying Job Titles

SELECT jpf.job_title_short,
        ROUND(avg(jpf.salary_year_avg), 2) AS avg_salary,
        dense_rank() OVER(ORDER BY avg(salary_year_avg) desc) AS salary_rank
FROM job_postings_fact jpf 
WHERE jpf.salary_year_avg IS NOT NULL 
GROUP BY job_title_short

----- CTE Version
WITH highest_paying_Job_titles AS (
SELECT jpf.job_title_short,
        ROUND(avg(jpf.salary_year_avg), 2) AS avg_salary,
        count(*)
FROM job_postings_fact jpf
GROUP BY job_title_short 
)

SELECT  job_title_short,
        avg_salary,
        rank() OVER(ORDER BY avg_salary desc) AS salary_ranks
FROM highest_paying_Job_titles


--2. Top Companies within each Job Titles

WITH company_summary AS (

SELECT
         jpf.job_title_short, 
         cd.name,        
         round(avg(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON
jpf.company_id = cd.company_id 
WHERE jpf.salary_year_avg  IS NOT null
GROUP BY job_title_short, cd.name)

SELECT *,
         dense_rank() OVER (PARTITION BY cj.job_title_short ORDER BY avg_salary desc) AS company_ranking
FROM company_summary AS cj


--3. Top Skills for Each Job Title

WITH jobskill_rank AS(
SELECT 
        jpf.job_title_short AS job_title,
       sd.skills AS skill,
       count(*) AS demand
FROM job_postings_fact jpf 
LEFT JOIN skills_job_dim sjd ON 
jpf.job_id = sjd.job_id 
LEFT JOIN skills_dim sd ON 
sjd.skill_id = sd.skill_id
GROUP BY job_title_short, sd.skills)

SELECT *,
    rank() OVER(PARTITION BY job_title ORDER BY demand desc) AS ranking
FROM jobskill_rank
LIMIT 10


--3. Salary Ranking by Location

WITH salary_location_rank AS(
    SELECT 
        jpf.job_title_short AS job_title, 
       jpf.job_location AS location,       
        avg(salary_year_avg) AS avg_salary
FROM job_postings_fact jpf 
WHERE jpf.salary_year_avg IS NOT NULL AND 
job_location <> 'Anywhere'
GROUP BY job_title_short, LOCATION)

SELECT *,
        RANK () OVER (PARTITION BY job_title ORDER BY avg_salary desc) AS location_rank
FROM salary_location_rank


--5. Hiring Trends Over Time

WITH trends AS(
    SELECT 
        EXTRACT(MONTH FROM Job_posted_date) AS month,
       count(*) AS job_posted
FROM job_postings_fact jpf 
GROUP BY MONTH)

SELECT *,
        Sum(job_posted) OVER (ORDER BY month asc) AS cummulative_Jobs
FROM trends



