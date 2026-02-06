/*WITH remote_job_skills as(
    SELECT
        skill_id,
        count(*) as skill_count
    FROM
        skills_job_dim as skills_jobs
    INNER JOIN job_postings_fact as jobs on skills_jobs.job_id = jobs.job_id
    WHERE
        jobs.job_work_from_home= TRUE
        AND
        jobs.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)
SELECT skills.skill_id,
        skills as skill_name,
        skill_count
FROM
    remote_job_skills
INNER JOIN skills_dim as skills on remote_job_skills.skill_id = skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 10;*/

SELECT 
        skills,
        count(skills_job_dim.job_id) as job_count
FROM
    job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_postings_fact.job_work_from_home = TRUE
    AND
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    job_count DESC
LIMIT 10;