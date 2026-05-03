-- Total Records
SELECT COUNT(*) AS TOTAL_RECORDS FROM patients;

-- Missing Values
SELECT 
COUNT(*) 
AS MISSING_VALUES 
FROM patients 
WHERE 
patient_id IS NULL;

-- Duplicate Records
SELECT 
patient_id, COUNT(*) 
AS DUPLICATE_COUNT 
FROM patients 
GROUP BY patient_id 
HAVING COUNT(*) > 1;

-- Missing Email Addresses
SELECT 
COUNT(*) 
AS MISSING_EMAILS 
FROM patients 
WHERE email IS NULL;

-- Missing Email Percentage
SELECT 
(COUNT(*) FILTER (WHERE email IS NULL) * 100.0 / COUNT(*)) 
AS missing_email_percentage 
FROM patients;

-- Duplicate Records with Same Name and DOB
SeLECT 
first_name, last_name, date_of_birth, COUUNT(*) AS DUPLICATE_COUNT
FROM patients 
GROUP BY first_name, last_name, date_of_birth
HAVING COUNT(*) > 1;

-- INVALID GENDER
SELECT COUNT(*) AS invalid_gender
FROM patients
WHERE gender NOT IN ('M', 'F');


-- FUTURE DOB (LOGICAL ERROR)
SELECT COUNT(*) AS future_dob
FROM patients
WHERE date_of_birth > CURRENT_DATE;

-- DATA QUALITY CHECKS SUMMARY:
-- DATA QUALITY SUMMARY
SELECT 
    COUNT(*) AS total_records,

    COUNT(*) FILTER (WHERE email IS NULL) AS missing_email,

    ROUND(
        COUNT(*) FILTER (WHERE email IS NULL) * 100.0 / COUNT(*),
        2
    ) AS missing_email_pct,

    COUNT(*) FILTER (
        WHERE (first_name, last_name, date_of_birth) IN (
            SELECT first_name, last_name, date_of_birth
            FROM patients
            GROUP BY first_name, last_name, date_of_birth
            HAVING COUNT(*) > 1
        )
    ) AS duplicate_records

FROM patients;
