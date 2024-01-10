use Covid_symptoms;

-- 1. Find the number of corona patients who faced shortness of breath.

select count(Corona_Test) from df_cleaned 
where Shortness_of_breath = 'True' and Corona_Test = 'positive';


-- 2. Find the number of negative corona patients who have fever and sore_throat. 

select count(Corona_Test) from df_cleaned 
where Corona_Test = 'negative' and Sore_throat= 'True' and Fever= 'True';


-- 3. Find the female negative corona patients who faced cough and headache.

select MONTH(Test_date) AS months, count(Corona_Test='positive') AS total_positive_cases, 
RANK() OVER (ORDER BY count(Corona_Test='positive') DESC) AS Ranks FROM df_cleaned 
WHERE Corona_Test='positive' GROUP BY months;


-- 4. How many elderly corona patients have faced breathing problems?

select count(Corona_Test) from df_cleaned 
where Corona_Test = 'negative' and Gender = 'female' and Cough_symptoms= 'True' and Headache= 'True';


-- 5. Group the data by month and rank the number of positive cases.

select count(Corona_Test) from df_cleaned 
where Corona_Test = 'positive' and Age_60_above = 'Yes' and Shortness_of_breath= 'True';


-- 6. Which three symptoms were more common among COVID positive patients?

SELECT symptom, SUM(count) AS total_count FROM (
SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'positive' AND Cough_symptoms = 'True' 
UNION ALL 
SELECT 'Fever' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'positive' AND Fever = 'True'
UNION ALL 
SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'positive' AND Sore_throat = 'True' 
UNION ALL 
SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'positive' AND Shortness_of_breath = 'True' 
UNION ALL 
SELECT 'Headache' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'positive' AND Headache = 'True' 
) as x 
GROUP BY symptom ORDER BY total_count DESC LIMIT 3;


-- 7. Which symptom was less common among COVID negative people?

SELECT symptom, SUM(count) AS total_count FROM (
SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'negative' AND Cough_symptoms = 'True' 
UNION ALL 
SELECT 'Fever' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'negative' AND Fever = 'True'  
UNION ALL 
SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'negative' AND Sore_throat = 'True' 
UNION ALL 
SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'negative' AND Shortness_of_breath = 'True' 
UNION ALL 
SELECT 'Headache' AS symptom, COUNT(*) AS count FROM df_cleaned WHERE Corona_Test = 'negative' AND Headache = 'True'
) as x 
GROUP BY symptom ORDER BY total_count ASC LIMIT 1;


-- 8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

SELECT symptom, SUM(count) AS total_count FROM (
SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM df_cleaned 
WHERE Corona_Test = 'positive' AND Cough_symptoms = 'True' AND Gender = 'male' AND Known_contact ='Abroad' 
UNION ALL 
SELECT 'Fever' AS symptom, COUNT(*) AS count FROM df_cleaned 
WHERE Corona_Test = 'positive' AND Fever = 'True' AND Gender = 'male' AND Known_contact ='Abroad' 
UNION ALL 
SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM df_cleaned 
WHERE Corona_Test = 'positive' AND Sore_throat = 'True' AND Gender = 'male' AND Known_contact ='Abroad' 
UNION ALL 
SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM df_cleaned 
WHERE Corona_Test = 'positive' AND Shortness_of_breath = 'True' AND Gender = 'male' AND Known_contact ='Abroad'
UNION ALL 
SELECT 'Headache' AS symptom, COUNT(*) AS count FROM df_cleaned 
WHERE Corona_Test = 'positive' AND Headache = 'True' AND Gender = 'male' AND Known_contact ='Abroad'
) as x 
GROUP BY symptom ORDER BY total_count DESC LIMIT 1;