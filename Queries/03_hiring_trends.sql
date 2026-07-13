/* Business Objective is to understand the demand for data professionals.
 * The following questions provide insights into what the demand for data professsional is like.
 * 
 */
-- 1. How many jobs are posted for each job title?
SELECT
    job_title_short AS job_title,
    COUNT(*) AS total_job_post
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY total_job_post DESC;


-- 2. top 20 location with the highest number of job postings
SELECT jpf.job_location, 
        count(*) AS job_post_by_location
FROM job_postings_fact jpf 
GROUP BY job_location 
ORDER BY job_post_by_location  DESC
LIMIT 20


-- 3. Percentage of total job postings by job title.
SELECT 
    job_title_short,
    count(*) AS total_jobs,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*)
        FROM job_postings_fact jpf), 
        2 ) AS percentage_of_total
FROM job_postings_fact jpf 
GROUP BY job_title_short 
ORDER BY total_jobs DESC


-- 4. Most Common Job Schedule
SELECT 
    job_schedule_type,
    count(*) AS total_job_by_schedule
FROM job_postings_fact jpf 
GROUP BY jpf.job_schedule_type 
ORDER BY total_job_by_schedule DESC


-- 5. Total Remote jobs
SELECT jpf.job_work_from_home,
        count(*) AS total_remote_jobs
FROM job_postings_fact jpf 
WHERE jpf.job_work_from_home = TRUE
GROUP BY job_work_from_home 


-- 6. Percentate of jobs that are remote
SELECT jpf.job_work_from_home,
        count(*) AS total_remote_jobs,
        ROUND(COUNT(*) * 100.0 / 
        (SELECT COUNT(*)
        FROM job_postings_fact), 2) AS percent_remote_jobs
FROM job_postings_fact jpf 
WHERE jpf.job_work_from_home = TRUE
GROUP BY job_work_from_home
ORDER BY total_remote_jobs 


--hiring trends by year
SELECT job_title_short,
    COUNT(CASE WHEN EXTRACT (YEAR FROM job_posted_date) = 2022 THEN 1 END) AS jobs_2022,
   COUNT(CASE WHEN EXTRACT (YEAR FROM job_posted_date) = 2023 THEN 1 END) AS jobs_2023
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY jobs_2023 desc

