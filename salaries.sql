create database salary;
use salary;
select * from ds_salaries;

-- 1) How does the average salary rank for each job title?
select Job_title,avg(salary) as Avg_Salary,DENSE_RANK()
over(order by Avg(salary) desc)as Salary_rank from ds_salaries group by Job_title ;

-- 2) What is the cumulative salary for each experience level across all job titles?
select job_title,experience_level,sum(salary) over (PARTITION BY experience_level order by job_title) 
Cumulative_Salary from ds_salaries;

-- 3) Which company offered the highest salary for each job title, and in which year?
select * from ds_salaries;
select job_title,work_year,salary from
(select job_title,work_year,salary,ROW_NUMBER()
over (partition by job_title order by salary) 
as Salary_rank from ds_salaries)
as ranked_salaries where salary_rank = 1 order by job_title;

-- 4) What is the difference between each salary and the maximum salary for its job title?
select job_title,salary,max(salary) over (order by job_title) as maximum_salary,
max(salary) over (order by job_title) - salary as salary_difference from ds_salaries;

-- 5)What is the highest and lowest salary for each job title?
select job_title,max(salary) as Highest_salary,
min(salary) as Lowest_salary from ds_salaries group by job_title ;

-- 6)What was the average salary for each job title in the previous year?
select job_title,work_year,avg(salary) as avg_salary,
lag(avg(salary))over (PARTITION BY job_title order BY work_year ) as previous_year from ds_salaries group by job_title,work_year;

-- 7) List all employees who have a remote ratio of 100 and reside in the United States (US).
select * from ds_salaries where remote_ratio = 100 and employee_residence = 'US';

-- 8) Show the top 5 highest salaries in USD, along with job titles and company locations.
select job_title ,company_location,salary_in_usd from ds_salaries 
group by job_title,company_location,salary_in_usd order by salary_in_usd desc limit 5;

-- 9) Find the average salary in USD for each experience level.
select experience_level,avg(salary) Avg_Salary from ds_salaries group by experience_level;

-- 10) Find the average salary in USD for each company size, but only include sizes where the average salary exceeds 50,000.
select company_size,avg(salary_in_usd) avg_salary from ds_salaries group by company_size having avg(salary_in_usd)>50000;

-- 11) Count the number of employees for each employment type.
select employment_type,count(*) num_employees from ds_salaries group by employment_type;

-- 12) Retrieve all employees whose job title contains the word "Engineer".
select * from ds_salaries where job_title like( "%Engineer%");

-- 13) List all unique job titles available in the dataset.
SELECT DISTINCT job_title FROM ds_salaries;
