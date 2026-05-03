-- =====================================================
-- PROJECT: Healthcare Patient Data Quality Monitoring
-- PURPOSE: Identify data integrity issues before analytics & reporting
-- OWNER: Data Analyst Portfolio Project (Shubham Kumar Gupta)
-- =====================================================


-- =========================
-- DATA COMPLETENESS
-- =========================
-- Total Records
SELECT COUNT(*) AS TOTAL_RECORDS FROM patients;


-- Missing Email Addresses can impact communication and patient engagement efforts
SELECT 
COUNT(*) 
AS MISSING_EMAILS 
FROM patients 
WHERE email IS NULL;

-- Missing Email Percentage can help prioritize data cleaning efforts and assess the impact on communication strategies
SELECT 
(COUNT(*) FILTER (WHERE email IS NULL) * 100.0 / COUNT(*)) 
AS missing_email_percentage
FROM patients;

-- =========================
-- DATA UNIQUENESS
-- =========================
-- Duplicate Records may indicate data entry errors or multiple entries for the same patient
SELECT 
first_name, last_name, date_of_birth, COUNT(*) 
AS DUPLICATE_COUNT 
FROM patients 
GROUP BY first_name, last_name, date_of_birth 
HAVING COUNT(*) > 1;

-- =========================
-- DATA VALIDITY
-- =========================
-- INVALID GENDER
SELECT COUNT(*) AS gender_quality_issues
FROM patients
WHERE gender NOT IN ('M', 'F');


-- FUTURE DOB (LOGICAL ERROR Data Validation)
SELECT COUNT(*) AS future_dob
FROM patients
WHERE date_of_birth > CURRENT_DATE;



-- =========================
-- DATA QUALITY SUMMARY
-- =========================
SELECT 
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE email IS NULL) AS missing_email,
    ROUND(
        COUNT(*) FILTER (WHERE email IS NULL) * 100.0 / COUNT(*),
        2
    ) AS missing_email_percentage,
    COUNT(*) FILTER (
        WHERE (first_name, last_name, date_of_birth) IN (
            SELECT first_name, last_name, date_of_birth
            FROM patients
            GROUP BY first_name, last_name, date_of_birth
            HAVING COUNT(*) > 1
        )
    ) AS duplicate_records
FROM patients;
