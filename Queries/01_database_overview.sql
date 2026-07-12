--Number of Distinct Companies
SELECT 
    count (distinct (name)) as total_companies
FROM 
    company_dim cd;


--Total Number of Distinct job_title
select 
    count(distinct (job_title_short)) AS total_jobs_title
from 
    job_postings_fact jpf;
    
--Listing of Job titles
select
    distinct(job_title_short) as job_titles
from 
    job_postings_fact jpf; 
    
--Listing of Skills
select
    distinct (skills),
    count (distinct (skills)) as skill_count
from skills_dim sd 
group by skills;

--Range of Job Posting Date?
Select 
    Min(job_posted_date) as least_date,
    max(job_posted_date) as max_date
from 
    job_postings_fact;

--Number of remote jobs vs on-site
Select 
    job_work_from_home as remote_work,
    count(*) as total_jobs
from
    job_postings_fact
group by 
    job_work_from_home;

--Job Schedule Types
Select 
    job_schedule_type,
    count(*) as total
from
    job_postings_fact
group by 
    job_schedule_type;
