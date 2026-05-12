/*
    Question: What skills are required for the top-paying Data Analyst jobs?
    - Use the top 10 highest-paying Data Analyst jobs from the first query.
    - Add the specific skills required for these roles.
    - Why? It provides a detailed look at which high-paying jobs demand certain skills, 
      helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
        j.job_id,
        j.job_title,
        j.salary_year_avg,
        c.name AS company_name
    FROM 
        job_postings_fact j
    LEFT JOIN company_dim c ON j.company_id = c.company_id
    WHERE
        j.job_title_short = 'Data Analyst' AND
        j.salary_year_avg IS NOT NULL AND
        (
            (
                j.job_country = 'United Kingdom'
                AND j.job_location ILIKE '%london%'
            )
            OR j.job_location = 'Anywhere'
        )
    ORDER BY
        j.salary_year_avg DESC
    LIMIT 10
)

SELECT 
    t.*,
    s.skills
FROM
    top_paying_jobs t
INNER JOIN skills_job_dim sj ON t.job_id = sj.job_id
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
ORDER BY
    t.salary_year_avg DESC;
