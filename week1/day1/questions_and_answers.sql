-- 1. Select all columns from Employee table.
SELECT * FROM Employee;

-- 2. Select only name and salary columns.
SELECT name, salary FROM Employee;

-- 3. Select employees older than 30.
SELECT * FROM Employee WHERE age > 30;

-- 4. Select names of all departments.
SELECT name FROM Department;

-- 5. Select employees who work in IT department.
SELECT e.*
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
WHERE d.name = 'IT';

-- 6. Employees whose names start with J.
SELECT * FROM Employee WHERE name LIKE 'J%';

-- 7. Employees whose names end with e.
SELECT * FROM Employee WHERE name LIKE '%e';

-- 8. Employees whose names contain a.
SELECT * FROM Employee WHERE name LIKE '%a%';

-- 9. Employees whose names are exactly 9 characters long.
SELECT * FROM Employee WHERE CHAR_LENGTH(name) = 9;

-- 10. Employees whose names have o as second character.
SELECT * FROM Employee WHERE name LIKE '_o%';

-- 11. Employees hired in year 2020.
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

-- 12. Employees hired in January of any year.
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;

-- 13. Employees hired before 2019.
SELECT * FROM Employee WHERE hire_date < '2019-01-01';

-- 14. Employees hired on or after March 1, 2021.
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

-- 15. Employees hired in last 2 years.
SELECT * FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 16. Total salary of all employees.
SELECT SUM(salary) AS total_salary FROM Employee;

-- 17. Average salary of employees.
SELECT AVG(salary) AS average_salary FROM Employee;

-- 18. Minimum salary.
SELECT MIN(salary) AS minimum_salary FROM Employee;

-- 19. Number of employees in each department.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id;

-- 20. Average salary in each department.
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id;

-- 21. Total salary for each department.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;

-- 22. Average age of employees in each department.
SELECT department_id, AVG(age) AS average_age
FROM Employee
GROUP BY department_id;

-- 23. Number of employees hired in each year.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date);

-- 24. Highest salary in each department.
SELECT department_id, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;

-- 25. Department with highest average salary.
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 1;

-- 26. Departments with more than 2 employees.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 27. Departments with average salary greater than 55000.
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 28. Years with more than 1 employee hired.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- 29. Departments with total salary expense less than 100000.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- 30. Departments with maximum salary above 75000.
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;

-- 31. Employees ordered by salary ascending.
SELECT * FROM Employee ORDER BY salary ASC;

-- 32. Employees ordered by age descending.
SELECT * FROM Employee ORDER BY age DESC;

-- 33. Employees ordered by hire date ascending.
SELECT * FROM Employee ORDER BY hire_date ASC;

-- 34. Employees ordered by department and salary.
SELECT * FROM Employee ORDER BY department_id, salary;

-- 35. Departments ordered by total salary.
SELECT d.name, SUM(e.salary) AS total_salary
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY total_salary;

-- 36. Employee names with department names.
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;

-- 37. Project names with department names.
SELECT p.name AS project_name, d.name AS department_name
FROM Project p
JOIN Department d ON p.department_id = d.department_id;

-- 38. Employee names and corresponding project names.
SELECT e.name AS employee_name, p.name AS project_name
FROM Employee e
JOIN Project p ON e.department_id = p.department_id;

-- 39. All employees and departments including employees without department.
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
LEFT JOIN Department d ON e.department_id = d.department_id;

-- 40. All departments and employees including departments without employees.
SELECT d.name AS department_name, e.name AS employee_name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id;

-- 41. Employees not assigned to any project.
SELECT e.*
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- 42. Employees and number of projects their department is working on.
SELECT e.name AS employee_name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
GROUP BY e.emp_id, e.name;

-- 43. Departments that have no employees.
SELECT d.*
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 44. Employees who share same department with John Doe.
SELECT *
FROM Employee
WHERE department_id = (
    SELECT department_id FROM Employee WHERE name = 'John Doe'
)
AND name <> 'John Doe';

-- 45. Department name with highest average salary.
SELECT d.name, AVG(e.salary) AS average_salary
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY average_salary DESC
LIMIT 1;

-- 46. Employee with highest salary.
SELECT *
FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);

-- 47. Employees whose salary is above average salary.
SELECT *
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- 48. Second highest salary.
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- 49. Department with most employees.
SELECT d.name, COUNT(e.emp_id) AS employee_count
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY employee_count DESC
LIMIT 1;

-- 50. Employees who earn more than average salary of their department.
SELECT *
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 51. 3rd highest salary.
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- 52. Employees older than all employees in HR department.
SELECT *
FROM Employee
WHERE age > ALL (
    SELECT e.age
    FROM Employee e
    JOIN Department d ON e.department_id = d.department_id
    WHERE d.name = 'HR'
);

-- 53. Departments where average salary is greater than 55000.
SELECT d.name, AVG(e.salary) AS average_salary
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 55000;

-- 54. Employees who work in department with at least 2 projects.
SELECT *
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) >= 2
);

-- 55. Employees hired on same date as Jane Smith.
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date FROM Employee WHERE name = 'Jane Smith'
);

-- 56. Total salary of employees hired in 2020.
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- 57. Average salary in each department ordered descending.
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC;

-- 58. Departments with more than 1 employee and average salary greater than 55000.
SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

-- 59. Employees hired in last 2 years ordered by hire date.
SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date;

-- 60. Total employees and average salary for departments with more than 2 employees.
SELECT department_id, COUNT(*) AS total_employees, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 61. Name and salary of employees whose salary is above department average.
SELECT name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 62. Employees hired on same date as oldest employee in company.
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    ORDER BY age DESC
    LIMIT 1
);

-- 63. Department names with total projects ordered by project count.
SELECT d.name AS department_name, COUNT(p.project_id) AS project_count
FROM Department d
LEFT JOIN Project p ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY project_count DESC;

-- 64. Employee with highest salary in each department.
SELECT e.*
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 65. Employees older than average age of their department.
SELECT name, salary
FROM Employee e
WHERE age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);