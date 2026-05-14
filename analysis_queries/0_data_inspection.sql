-- ====================================
-- COUNT Total Number of Jobs Postings
-- ====================================

SELECT COUNT(job_id) FROM job_postings_fact;

-- ====================================================
-- Check pencentage of Non NA salaries to Job Postings
-- ====================================================

SELECT
    ROUND(
        100.0 * COUNT(salary_year_avg) / COUNT(job_id), 2
    ) AS percent_of_non_na_salaries
FROM
    job_postings_fact;

-- ==============================
-- COUNT of Remote vs Non-Remote
-- ==============================

SELECT
    job_work_from_home,
    COUNT(*) AS jobs
FROM job_postings_fact
GROUP BY job_work_from_home;

-- =========================
-- Country-Level Job Counts
-- =========================

SELECT
    j.job_country,
    COUNT(*) AS num_jobs
FROM job_postings_fact j
GROUP BY j.job_country
ORDER BY num_jobs DESC;

-- =====================================
-- UK Job Counts by Individual Location
-- =====================================

SELECT
    j.job_location,
    COUNT(*) AS num_jobs
FROM job_postings_fact j
WHERE j.job_country = 'United Kingdom'
GROUP BY j.job_location
ORDER BY num_jobs DESC;

-- ==========================================
-- London + Remote ("Anywhere") Job Postings
-- ==========================================

SELECT
    j.job_location,
    COUNT(*) AS num_jobs
FROM job_postings_fact j
WHERE
    (
        j.job_country = 'United Kingdom'
        AND j.job_location ILIKE '%london%'
    )
    OR j.job_location = 'Anywhere'
GROUP BY j.job_location
ORDER BY num_jobs DESC;

-- =======================
-- Most Common Job Titles
-- =======================

SELECT
    job_title_short,
    COUNT(*) AS num_jobs
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY num_jobs DESC;

-- ============================================
-- Salary Statitics for Most Common Job Titles
-- ============================================

SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary,
    ROUND(MIN(salary_year_avg), 2) AS min_salary,
    ROUND(MAX(salary_year_avg), 2) AS max_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY avg_salary DESC;

-- ============================================
-- Check Date Ranges
-- ============================================

SELECT
    MIN(job_posted_date),
    MAX(job_posted_date)
FROM job_postings_fact;

