-- This Section of the project presents analysis of skills that are mostly in demand. From this analysis we would be able to know the most valuable skills in the IT labour market.

-- 1. The most in-demand skills

SELECT sd.skills,
        Count(*)
FROM job_postings_fact jpf 
LEFT JOIN skills_job_dim sjd ON 
jpf.job_id = jpf.job_id 
LEFT JOIN skills_dim sd ON  
sjd.skill_id = sd.skill_id
GROUP BY sd.skills 
LIMIT 20

-- algjalgdajga
SELECT count(*)
FROM company_dim cd 


-- fadfaldfja
SELECT  *
FROM job_postings_fact jpf
