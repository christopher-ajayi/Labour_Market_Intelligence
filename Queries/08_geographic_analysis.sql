/* This section aims at analysing how labour market differs across location*/

--1. Locations with the most job postings.
SELECT jpf.job_location AS location,
        count(*) AS job_count
FROM job_postings_fact jpf 
GROUP BY location
ORDER BY job_count desc


--2. Locations that offer the highest average salary

SELECT jpf.job_location AS location,
        AVG(jpf.salary_year_avg) AS avg_salary
FROM job_postings_fact jpf 
WHERE jpf.salary_year_avg  IS NOT NULL 
GROUP BY location
ORDER BY avg_salary DESC



--3. Location with the highest percentage of remote jobs.
SELECT job_location,
    COUNT(CASE WHEN jpf.job_work_from_home = TRUE THEN 1 END) AS remote_jobs,
    count(*) AS total_jobs,
    ROUND(COUNT(CASE WHEN job_work_from_home = TRUE THEN 1 END) * 100.0/COUNT(*), 2) AS remote_percentage
FROM job_postings_fact jpf 
WHERE jpf.job_location <> 'Anywhere'
GROUP BY jpf.job_location 
ORDER BY remote_percentage DESC
LIMIT 20


--4. Most in-demand skills in the top hiring locations.

SELECT 
       jpf.job_location AS LOCATION,
       sd.skills,
       count(*) AS skill_count
FROM job_postings_fact jpf 
LEFT JOIN skills_job_dim sjd ON 
jpf.job_id = sjd.job_id 
LEFT JOIN skills_dim sd ON 
sjd.skill_id = sd.skill_id
WHERE job_location <> 'Anywhere'
GROUP BY LOCATION, sd.skills 
HAVING COUNT(*) >=10
ORDER BY skill_count desc


--5. Most common jobs titles in each loation.
SELECT 
       jpf.job_location AS LOCATION,
       job_title_short AS job_title,
       count(*) AS title_count
FROM job_postings_fact jpf 
WHERE job_location <> 'Anywhere'
GROUP BY "location", jpf.job_title_short 
HAVING COUNT(*) >=1000
ORDER BY title_count DESC


--6. Salary by Location and Job Title
SELECT jpf.job_location as location,
         jpf.job_title_short AS job_title,
      ROUND(AVG(jpf.salary_year_avg),2) avg_salary,
       COUNT(*) AS salary_records
FROM job_postings_fact jpf 
WHERE jpf.salary_year_avg IS NOT NULL AND 
         job_location <> 'Anywhere'
GROUP BY location, jpf.job_title_short
HAVING COUNT(*) >= 20
ORDER BY avg_salary DESC


