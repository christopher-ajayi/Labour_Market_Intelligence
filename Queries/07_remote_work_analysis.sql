/* This section seeks to investigate how remote work differs from on-site.
 * This analysis will compare how employers prioritizes remote and on-site*/

-- Number of jobs that are remote vs. on-site
SELECT DISTINCT (job_work_from_home) AS work_arrangement,
        count(*) AS job_count
FROM job_postings_fact jpf 
GROUP BY work_arrangement 


-- Percentage of Jobs that are remote vs. on-site
SELECT  job_work_from_home AS job_arrangement,
        ROUND(count(*) * 100.0/
        (SELECT count(*)
        FROM job_postings_fact), 2)::TEXT ||'%' AS percentage
FROM job_postings_fact jpf 
GROUP BY job_arrangement 


-- Remote vs online job title distribution

SELECT
    job_title_short,
    COUNT(CASE WHEN job_work_from_home = TRUE THEN 1 END) AS remote_jobs,
    COUNT(CASE WHEN job_work_from_home = FALSE THEN 1 END) AS onsite_jobs
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY remote_jobs DESC;

-- Salary Variation between remote and on-site jobs
SELECT jpf.job_work_from_home AS work_arrangement, 
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jpf
WHERE jpf.salary_year_avg IS NOT null
GROUP BY work_arrangement 


--Companies that post the most remote jobs
SELECT cd.name AS company,
        count(*) AS job_post
FROM job_postings_fact jpf 
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id 
WHERE jpf.job_work_from_home = TRUE
GROUP BY company 
ORDER BY job_post DESC

-- Skills that are most common with remote jobs

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

-- Locations with the most remote jobs

SELECT job_location AS location,
        count(*) AS remote
FROM job_postings_fact jpf  
WHERE jpf.job_work_from_home = TRUE
GROUP BY job_location
ORDER BY remote DESC

-- Remote job hire by year
SELECT 
         EXTRACT(YEAR FROM job_posted_date) AS YEAR,
             COUNT(*) AS remote_jobs
FROM job_postings_fact jpf 
WHERE job_work_from_home = TRUE
GROUP BY EXTRACT(YEAR FROM job_posted_date)
ORDER BY remote_jobs


-- Remote hiring by schedule
SELECT jpf.job_schedule_type  AS schedule,
        count(*) AS remote
FROM job_postings_fact jpf  
WHERE jpf.job_work_from_home = TRUE 
GROUP BY schedule
ORDER BY remote DESC
LIMIT 20

-- Top paying remote jobs
SELECT
        cd.name AS company,
        jpf.job_title_short AS job_title,
        jpf.job_location AS locationn, 
        salary_year_avg AS salary
FROM job_postings_fact jpf
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id 
WHERE jpf.job_work_from_home  = TRUE AND 
        jpf.salary_year_avg  IS NOT NULL
ORDER BY salary DESC
LIMIT 20


-- Top paying remote jobs
SELECT
        cd.name AS company,
        jpf.job_title_short AS job_title,
        jpf.job_location AS location, 
        AVG(salary_year_avg) AS salary
FROM job_postings_fact jpf
LEFT JOIN company_dim cd ON 
jpf.company_id = cd.company_id 
WHERE jpf.job_work_from_home  = TRUE AND 
        jpf.salary_year_avg  IS NOT NULL
GROUP BY company, job_title
ORDER BY salary DESC
LIMIT 20

