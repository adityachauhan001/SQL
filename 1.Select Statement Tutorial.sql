SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
 last_name, 
 birth_date,
 age,
 age+10
 FROM parks_and_recreation.employee_demographics;
 #PEMDAS
 
 SELECT DISTINCT gender
 FROM  parks_and_recreation.employee_demographics;
 
 -- WHERE CLAUSE
 
 SELECT *
 FROM employee_salary
 WHERE salary >= 50000
 ;
 
 
 SELECT *
 FROM employee_demographics
 WHERE gender != 'female'
 ;
 
 
  SELECT *
 FROM employee_salary
 WHERE first_name = 'Leslie'
 ;
 
 #Logical Operators
 -- AND OR NOT
 SELECT *
 FROM employee_demographics
 WHERE birth_date > '1985-01-01'
 AND gender = 'male'
 ;
 
  SELECT *
 FROM employee_demographics
 WHERE birth_date > '1985-01-01'
 OR gender = 'male'
 ;
 
   SELECT *
 FROM employee_demographics
 WHERE birth_date > '1985-01-01'
 OR NOT gender = 'male'
 ;
 
 SELECT *
 FROM employee_demographics
 WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
 ;
 
 -- LIKE STATEMENT
 -- % and _ 
 SELECT * 
 FROM employee_demographics
 WHERE first_name LIKE 'Jer%'
 ;
 
  SELECT * 
 FROM employee_demographics
 WHERE first_name LIKE '%er%'
 ;
 
  SELECT * 
 FROM employee_demographics
 WHERE first_name LIKE 'a%'
 ;
 
  SELECT * 
 FROM employee_demographics
 WHERE first_name LIKE 'a___'
 ;
 
  SELECT * 
 FROM employee_demographics
 WHERE first_name LIKE 'a___%'
 ;


 SELECT * 
 FROM employee_demographics
 WHERE birth_date LIKE '1989%'
 ;
 
 -- Group By
 SELECT *
 FROM employee_demographics
 ;
 
 SELECT gender
 FROM employee_demographics
 GROUP BY gender
 ;
 
 SELECT gender, AVG(age)
 FROM employee_demographics
 GROUP BY gender
 ;
 
 
SELECT *
FROM employee_salary;
 
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

 SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
 FROM employee_demographics
 GROUP BY gender
 ;
 
 -- ORDER BY 
 SELECT *
 FROM employee_demographics
 ORDER BY first_name
 ;
 
  SELECT *
 FROM employee_demographics
 ORDER BY first_name DESC
 ;
 
 SELECT *
 FROM employee_demographics
 ORDER BY gender, age
 ;
 
  SELECT *
 FROM employee_demographics
 ORDER BY gender, age DESC
 ;
 
  SELECT *
 FROM employee_demographics
 ORDER BY 5, 4 
 ; 
 
 -- Having VS Where
 
 SELECT gender, AVG(age)
 FROM employee_demographics
 GROUP BY gender
 HAVING AVG(age) > 40
 ;
 
 SELECT occupation, AVG(salary)
 FROM employee_salary
 WHERE occupation LIKE '%manager%'
 GROUP BY occupation
 HAVING  AVG(salary) > 75000
 ;
 
 -- LIMIT & ALIASING
 
 SELECT *
 FROM employee_demographics
 ORDER BY age DESC
 LIMIT 3
 ;
 
 SELECT *
 FROM employee_demographics
 ORDER BY age DESC
 LIMIT 2, 1
 ;
 
 -- ALIASING 
 SELECT gender, AVG(age) AS avg_age
 FROM employee_demographics
 GROUP BY gender
 HAVING avg_age > 40
 ;
 
  SELECT gender, AVG(age)  avg_age
 FROM employee_demographics
 GROUP BY gender
 HAVING avg_age > 40
 ;
 
 -- JOINS
 
 SELECT *
 FROM employee_demographics;
 
 SELECT *
 FROM employee_salary;
 
 SELECT *
 FROM employee_demographics
 INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
 ;
 
-- Aliasing in joins
 SELECT *
 FROM employee_demographics dem
 INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

 SELECT dem.employee_id, age, occupation
 FROM employee_demographics dem
 INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- OUTER JOINS

 SELECT dem.employee_id, age, occupation
 FROM employee_demographics dem
 LEFT JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

 SELECT *
 FROM employee_demographics dem
 RIGHT JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- SELF JOIN

SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- JOINING MULTIPLE TABLES TOGETHER
 SELECT *
 FROM employee_demographics dem
 INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
;

SELECT *
FROM parks_departments;


-- UNIONS 

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;



SELECT first_name, last_name, 'old Man'  AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'old Lady'  AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employees'  AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;

--  STRING FUNCTIONS

SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT UPPER('Aditya');
SELECT LOWER('Aditya');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT TRIM('   YO!   ');

SELECT first_name,
LEFT (first_name, 4),
RIGHT (first_name, 4),
SUBSTRING(first_name, 3, 2),
birth_date ,
SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics;

SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics;

SELECT first_name , last_name,
CONCAT(first_name,'',last_name) AS full_name
FROM employee_demographics;

-- CASE STATEMENTS
SELECT first_name,
last_name,
age,
CASE 
	WHEN AGE <=30 THEN 'Young' 
    WHEN AGE BETWEEN 31 AND 50 THEN 'Old'
    WHEN AGE >=50 THEN 'Go See A Doctor'
END AS Age_Bracket
FROM employee_demographics;

-- Pay Increase and Bonus
-- <50000 = 5%
-- >50000 = 7%
-- Finance = 10 % Bonus

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
END AS New_Salary
FROM employee_salary;

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS New_Salary,
CASE 
	WHEN dept_id = 6 THEN salary * 0.10
END AS Bonus
FROM employee_salary;

SELECT *
FROM employee_salary;

SELECT *
FROM parks_departments;

-- SubQueries

SELECT *
FROM employee_demographics
WHERE employee_id IN
				(SELECT employee_id
                 FROM employee_salary
                  WHERE dept_id = 1)
;                  


SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;


SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(`MAX(age)`)
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
GROUP BY gender
;

SELECT AVG(`MAX(age)`)
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
;

SELECT AVG(min_age)
FROM 
(SELECT gender,
AVG(age) AS avg_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_table
;

-- Window Function

SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;    

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.first_name, dem.last_name, gender, 
SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;    

SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;    


SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS Row_Num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_Num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) Dense_rank_Num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;    
    
-- CTEs
WITH CTE_Example AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary)min_sal, COUNT(salary)count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example
;


SELECT AVG(avg_sal)
FROM (SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary)min_sal, COUNT(salary)count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) example_subquery
;

--  Temporary tables
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT*
FROM temp_table;
INSERT INTO temp_table
VALUES('Aditya', 'Singh Cauhan','Batman');

SELECT*
FROM temp_table;

SELECT * 
FROM employee_salary;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT * 
FROM salary_over_50k;

-- Stored Procedures

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();

DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries2();

-- Triggers and Events

SELECT *
FROM employee_demographics;

SELECT  *
FROM employee_salary;


DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;	

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

-- EVENTS
SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM employee_demographics
	WHERE age >=60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%';









