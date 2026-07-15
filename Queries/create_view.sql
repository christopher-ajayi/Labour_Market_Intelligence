CREATE OR REPLACE VIEW jobs_master AS

SELECT
    j.job_id,
    j.company_id,
    j.job_title_short,
    j.job_title,
    j.job_location,
    j.job_via,
    j.job_schedule_type,
    j.job_work_from_home,
    j.job_posted_date,
    j.salary_year_avg,
    c.name AS company_name,
    sj.skill_id,
    s.skills
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
    ON j.company_id = c.company_id
LEFT JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
LEFT JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id;


SELECT *
FROM jobs_master
limit 10
