DROP TABLE IF EXISTS Hospital;
CREATE TABLE Hospital(
	Hospital_Name VARCHAR(100),
	Location VARCHAR(100),
	Department VARCHAR(50),
	Doctors_Count INT,
	Patients_Count INT,
	Admission_Date TEXT,
	Discharge_Date TEXT,
	Medical_Expenses NUMERIC(10,2)	
);

SELECT* FROM Hospital;

SELECT DISTINCT(location)
FROM Hospital
WHERE Hospital_name LIKE 'City Hospital';

---1.	Total Number of Patients .	Write an SQL query to find the total number of patients across all hospitals.

SELECT SUM(Patients_Count) AS Total_patient
FROM Hospital;

---2.	Average Number of Doctors per Hospital .	Retrieve the average count of doctors available in each hospital.

SELECT AVG(Doctors_Per_Hospital) AS Avg_Doctors_Per_Hospital
FROM (
    SELECT Hospital_Name, AVG(Doctors_Count) AS Doctors_Per_Hospital
    FROM Hospital
    GROUP BY Hospital_Name
) AS sub;

---3.	Top 3 Departments with the Highest Number of Patients . 	Find the top 3 hospital departments that have the highest number of patients.

SELECT department, SUM(patients_count) AS total_patients
FROM Hospital
GROUP BY department
ORDER BY total_patients DESC 
LIMIT 3;

---4.	Hospital with the Maximum Medical Expenses .	Identify the hospital that recorded the highest medical expenses. 

SELECT SUM(medical_expenses) AS total_Expenses
FROM hospital
GROUP BY hospital_name
ORDER BY total_Expenses DESC 
LIMIT 1;

--- change date type text to date

ALTER TABLE Hospital
ALTER COLUMN admission_date TYPE DATE USING admission_date::DATE,
ALTER COLUMN discharge_date TYPE DATE USING discharge_date::DATE;

---5.	Daily Average Medical Expenses . 	Calculate the average medical expenses per day for each hospital. 

SELECT Hospital_Name,
       AVG(Medical_Expenses/(discharge_date - admission_date)) AS Avg_Daily_Expense
FROM Hospital
GROUP BY Hospital_Name;

---6.	Longest Hospital Stay o Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date. 

SELECT *,
       (discharge_date - admission_date) AS stay_length
FROM Hospital
ORDER BY stay_length DESC
LIMIT 1;

---7.	Total Patients Treated Per City o 	Count the total number of patients treated in each city. 

SELECT location,SUM(patients_count) AS Total_patients_city
FROM Hospital
GROUP BY location
ORDER BY Total_patients_city DESC;

---8.	Average Length of Stay Per Department o 	Calculate the average number of days patients spend in each department.

SELECT department, AVG(discharge_date - admission_date) AS Avg_Stay_Length
FROM Hospital
GROUP BY department
ORDER BY Avg_Stay_Length DESC;

---9.	Identify the Department with the Lowest Number of Patients o 	Find the department with the least number of patients. 

SELECT department, SUM(patients_count) AS Total_Patients
FROM Hospital
GROUP BY department
ORDER BY Total_Patients ASC
LIMIT 1;

---10.	Monthly Medical Expenses Report o  Group the data by month and calculate the total medical expenses for each month.

SELECT TO_CHAR(Admission_Date, 'YYYY-MM') AS Month,
       SUM(Medical_Expenses) AS Total_Expenses
FROM Hospital
GROUP BY TO_CHAR(Admission_Date, 'YYYY-MM')
ORDER BY Month;