/* This Section of the project presents analysis of skills that are mostly in demand. 
 *  From this analysis we would be able to know the most valuable skills in the IT labour market.*/

-- 1. The most in-demand skills
SELECT sd.skills,
        count(*) skills_demand_count
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
GROUP BY sd.skills
ORDER BY skills_demand_count DESC
LIMIT 20


-- Skills with the highest average salary
SELECT sd.skills,
        avg(jpf.salary_year_avg) AS avg_salary
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills 
ORDER BY avg_salary DESC
LIMIT 20


-- Most in demand skills for Data Analyst
SELECT sd.skills,
        count(sd.skills) AS demand
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.job_title_short = 'Data Analyst'
GROUP BY sd.skills 
ORDER BY demand DESC
LIMIT 10


-- Most in demand skills for Business Analyst
SELECT sd.skills,
        count(sd.skills) AS demand
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.job_title_short = 'Business Analyst'
GROUP BY sd.skills 
ORDER BY demand DESC
LIMIT 10


-- Most in demand skills for Data Scientiest
SELECT sd.skills,
        count(sd.skills) AS demand
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.job_title_short = 'Data Scientist'
GROUP BY sd.skills 
ORDER BY demand DESC
LIMIT 10


-- Most in demand skills associated with Remote Jobs

SELECT sd.skills,
        count(sd.skills) AS demand
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.job_work_from_home = TRUE
GROUP BY sd.skills 
ORDER BY demand DESC


--Highest paying Remote skills

SELECT sd.skills,
       avg(jpf.salary_year_avg)  AS salary
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.job_work_from_home = TRUE AND jpf.salary_year_avg IS NOT NULL 
GROUP BY sd.skills
ORDER BY salary DESC

--Skill Demand By Year

SELECT sd.skills,
        COUNT(CASE WHEN EXTRACT(YEAR FROM job_posted_date) = 2022 THEN 1 END) AS year2022,
        COUNT(CASE WHEN EXTRACT(YEAR FROM job_posted_date) = 2023 THEN 1 END) AS year2023 
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
GROUP BY sd.skills 
ORDER BY year2023 DESC


-- Top Ten Skills by Demand and Salary
SELECT sd.skills,
        count(jpf.job_id) AS job_count,
        avg(jpf.salary_year_avg) AS avg_salary
FROM skills_dim sd
LEFT JOIN skills_job_dim sjd ON 
sd.skill_id  = sjd.skill_id
LEFT JOIN job_postings_fact jpf  ON 
jpf.job_id = sjd.job_id
WHERE jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
ORDER BY job_count DESC
LIMIT 20


-- Demand -- Compensation -- Capabilities -- 
