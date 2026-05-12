/*
    Question: What are the top skills based on salary?
    - Look at the average salary associated with each skill for Data Analyst positions.
    - Focuses on roles with specified salaries, regardless of location.
    - Why? It reveals how different skills impact salary levels for Data Analysts and
      helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT 
    s.skills,
    COUNT(sj.job_id) AS skill_count,
    ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    s.skills
HAVING
    COUNT(sj.job_id) > 10
ORDER BY
    avg_salary DESC
LIMIT 25;
