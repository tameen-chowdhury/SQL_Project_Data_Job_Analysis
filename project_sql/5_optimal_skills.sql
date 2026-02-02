/*
    Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
    - Identify skills in high demand and associated with high average salaries for Data Analyst roles.
    - Concentrates on remote positions with specified salaries.
    - Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
      offering strategic insights for career development in data analysis.
*/

/*
    -- Final solution (concise and efficient)
    -- Uses a single aggregation with HAVING to identify
    -- high-demand, high-paying skills for remote Data Analyst roles.
*/

SELECT
    s.skill_id,
    s.skills,
    COUNT(sj.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
    AND j.job_work_from_home = True
GROUP BY
    s.skill_id
HAVING
    COUNT(sj.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
    -- Alternative (decomposed using CTEs for readability)
    -- This version separates demand and salary calculations
    -- to demonstrate stepwise query construction.
*/

WITH skills_demand AS (
    SELECT 
        s.skill_id,
        s.skills,
        COUNT(sj.job_id) AS demand_count
    FROM
        job_postings_fact j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = True
    GROUP BY
        s.skill_id
), average_salary AS (
    SELECT 
        s.skill_id,
        s.skills,
        ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = True
    GROUP BY
        s.skill_id
)

SELECT 
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    a.avg_salary
FROM 
    skills_demand sd
INNER JOIN average_salary a ON sd.skill_id = a.skill_id
WHERE
    sd.demand_count > 10
ORDER BY
    a.avg_salary DESC,
    sd.demand_count DESC
LIMIT 25;
