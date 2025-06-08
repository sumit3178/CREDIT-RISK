select* 
From credit_risk_dataset;

CREATE TABLE credit_risk_dataset_copy AS  
SELECT * FROM credit_risk_dataset; 

SELECT *
FROM credit_risk_dataset_copy; 


ALTER TABLE credit_risk_dataset_copy
ADD COLUMN row_index INT AUTO_INCREMENT PRIMARY KEY;

SELECT* 
FROM credit_risk_dataset_copy; 

ALTER TABLE credit_risk_dataset_copy
ADD COLUMN credit_risk VARCHAR(20) DEFAULT NULL ;

CREATE TABLE CREDIT_DATA_M7 AS 
SELECT row_index, person_age , person_income, person_home_ownership, person_emp_length, loan_intent,loan_grade,  loan_amnt, loan_int_rate , loan_status, 
loan_percent_income, cb_person_default_on_file , cb_person_cred_hist_length, 
CASE   
		WHEN credit_risk IS NOT NULL THEN credit_risk
        WHEN person_home_ownership = 'RENT' AND cb_person_default_on_file = 'Y' THEN 'HIGH RISK' 
        WHEN person_home_ownership IN('OWN', 'MORTGAGE') AND cb_person_default_on_file = 'Y' THEN 'MEDIUM RISK'
	    WHEN person_home_ownership IN('OWN', 'MORTGAGE') AND cb_person_default_on_file = 'N' THEN 'LOW RISK'
		WHEN loan_percent_income >= 0.5 THEN 'HIGH RISK' 
        WHEN person_income >= 35000 AND cb_person_default_on_file = 'N'  THEN 'LOW RISK' 
        WHEN person_income >= 30000 AND person_emp_length >= 10 AND cb_person_default_on_file = 'N' THEN 'LOW RISK' 
        WHEN loan_int_rate >= 15 THEN 'HIGH RISK'
        WHEN loan_amnt <= 1500 THEN 'HIGH RISK'
        WHEN loan_amnt >= 3000 AND cb_person_default_on_file = 'N' THEN 'MEDIUM RISK'  
        WHEN loan_percent_income <= 0.10 AND cb_person_default_on_file = 'N' THEN 'LOW RISK'  
		ELSE  'HIGH RISK' 
END AS credit_risk
FROM credit_risk_dataset_copy;

SELECT* 
FROM CREDIT_DATA_M7; 


SELECT *
FROM CREDIT_DATA_M7
WHERE credit_risk = 'UNKNOWN' ;

-- to count the number of customers with there risk profile 
SELECT credit_risk, COUNT(*) AS total_customers
FROM CREDIT_DATA_M7
GROUP BY credit_risk 
ORDER BY total_customers DESC; 


SELECT cb_person_default_on_file, credit_risk
FROM CREDIT_DATA_M7 ;

SELECT credit_risk, AVG(loan_int_rate) AS avg_interest_rate, COUNT(*) AS total_loans
FROM CREDIT_DATA_M7
WHERE loan_status = 'Defaulted'
GROUP BY credit_risk;

SELECT credit_risk , cb_person_default_on_file AS DEFAULT_H
FROM CREDIT_DATA_M7 
WHERE cb_person_default_on_file = 'Y' AND credit_risk IN ('MEDIUM RISK', 'LOW RISK');

SHOW VARIABLES LIKE 'secure_file_priv';



SELECT * FROM CREDIT_DATA_M7 INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\credit_risk_report.csv'
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

SELECT  'row_index','person_age', 'person_income', 'person_home_ownership', 'person_emp_length', 
       'loan_intent', 'loan_grade', 'loan_amnt', 'loan_int_rate', 'loan_status', 
       'loan_percent_income', 'cb_person_default_on_file', 'cb_person_cred_hist_length', 
        'credit_risk'
UNION ALL
SELECT row_index, person_age, person_income, person_home_ownership, person_emp_length, 
       loan_intent, loan_grade, loan_amnt, loan_int_rate, loan_status, 
       loan_percent_income, cb_person_default_on_file, cb_person_cred_hist_length, 
        credit_risk
FROM CREDIT_DATA_M7
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\credit_risk_report_main2.csv'
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';


