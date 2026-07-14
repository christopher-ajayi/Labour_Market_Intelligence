/* **Business Objective**

Understand how salaries vary across job titles, companies, locations, skills, and work arrangements.

This section demonstrates your ability to answer compensation-related business questions—a valuable skill for data, business, and financial analyst roles.
*/


--Research Questions
-- 1. Job titles with the highest average salary
SELECT
    job_title_short,
    AVG(salary_year_avg) AS average_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY average_salary DESC;

-- 2. 20 Top paying companies
SELECT
    cd.name AS company_name,
    AVG(jpf.salary_year_avg) AS average_salary
FROM job_postings_fact jpf
LEFT JOIN company_dim cd
ON jpf.company_id = cd.company_id
WHERE salary_year_avg IS NOT NULL
GROUP BY cd.name
ORDER BY average_salary DESC
LIMIT 20;


-- 3. Locations that offer the highest salaries

SELECT
    job_location,
    AVG(salary_year_avg) AS average_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_location
ORDER BY average_salary DESC;

-- 4. Average salary for remote vs. on-site jobs?
SELECT
    job_work_from_home,
    AVG(salary_year_avg) AS average_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_work_from_home;


-- 5. Salary Distribution

SELECT MIN(salary_year_avg) AS minimum_salary,
        MAX(salary_year_avg) AS maximum_salary,
        AVG(salary_year_avg) AS average_salary
FROM job_postings_fact jpf 


--7. Salary by Job Schedule

SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS average_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_schedule_type
ORDER BY average_salary DESC;

-- 9. Salary by Year

SELECT  
        EXTRACT(YEAR FROM job_posted_date) AS YEAR,
        count(*) as total_entries,
        AVG(jpf.salary_year_avg) AS average_salary     
FROM job_postings_fact jpf 
GROUP BY year
order by year
 
