-- =========================
-- Country-Level Job Counts
-- =========================

SELECT
    job_country,
    COUNT(*) AS num_jobs
FROM job_postings_fact 
GROUP BY job_country
ORDER BY num_jobs DESC;


-- =========================
-- Job Counts by Location
-- =========================

SELECT
    job_location,
    COUNT(*) AS num_jobs
FROM job_postings_fact
GROUP BY job_location
ORDER BY num_jobs DESC;


-- =====================================
-- UK Job Counts by Individual Location
-- =====================================

SELECT
    job_location,
    COUNT(*) AS num_jobs
FROM job_postings_fact
WHERE job_country = 'United Kingdom'
GROUP BY job_location
ORDER BY num_jobs DESC;


-- ============================================
-- London + Remote ("Anywhere") Job Postings
-- ============================================

SELECT
    job_location,
    COUNT(*) AS num_jobs
FROM job_postings_fact
WHERE
    (
        job_country = 'United Kingdom'
        AND job_location ILIKE '%london%'
    )
    OR job_location = 'Anywhere'
GROUP BY job_location
ORDER BY num_jobs DESC;