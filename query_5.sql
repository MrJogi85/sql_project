with skills_demand as(
SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as job_count
FROM
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_postings_fact.job_work_from_home = TRUE
    AND
    job_postings_fact.job_title_short = 'Data Analyst'
    AND
    salary_year_avg is not NULL
GROUP BY
    skills_dim.skill_id
), average_salary as(
SELECT 
    skills_job_dim.skill_id,
    Round(avg(salary_year_avg),0) as avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
AND
    salary_year_avg is not NULL
AND
    job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id 
)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    job_count,
    avg_salary
from
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where 
    job_count > 10
order by 
    avg_salary DESC,
    job_count DESC  
limit 25;
