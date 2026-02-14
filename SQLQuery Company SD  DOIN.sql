
use Company_SD;

UPDATE dbo.Employee
SET Salary = CASE SSN
    WHEN 102672 THEN 3000
    WHEN 112233 THEN 1300
    WHEN 123456 THEN 800
    WHEN 223344 THEN 1800
    WHEN 321654 THEN 2500
    WHEN 512463 THEN 1500
    WHEN 521634 THEN 1000
    WHEN 669955 THEN 750
    WHEN 968574 THEN 1600
END
WHERE SSN IN (
    102672, 112233, 123456, 223344, 321654,
    512463, 521634, 669955, 968574
)

select *
from dbo.Departments

select *
from dbo.Dependent

select *
from dbo.Employee 

select *
from dbo.Project

select *
from dbo.Works_for
   

 /* all the employees Data*/

 SELECT*
 FROM dbo.Employee;

 /*the employee First name, last name, Salary and Department number*/

SELECT  Fname,Lname,Salary,Dno
FROM dbo.Employee;


 /*all the projects names, locations and the department which is responsible about it.*/
 SELECT P. Pname, p.Plocation,d.Dname
 FROM dbo.project p
 INNER JOIN  dbo.Departments d
 ON P.Dnum=d.Dnum;
  

/*If you know that the company policy is to pay an annual commission for each employee 
with specific percent equals 10% of his/her annual salary 
 employee full name and his annual commission in an ANNUAL COMM column  */ 

SELECT Fname+ ' ' +  Lname as 'full Name' ,
Salary * 0.10 as 'Annual commission' 
FROM  dbo.Employee;


/*the employees Id, name who earns more than 1000 LE monthly*/

SELECT  fname +' ' +lname as 'Full Name',
SSn,salary 
FROM dbo.Employee
WHERE Salary > 1000;

/*the employees Id, name who earns more than 10000 LE annually*/

SELECT fname +' ' +lname as 'Full Name',
SSn, Salary 
FROM dbo.Employee
WHERE Salary * 12 >10000;

/*the names and salaries of the female employees */

SELECT Fname+ ' '+Lname ,Salary
FROM  dbo.Employee
WHERE Sex='f';

/*each department id, name which managed by a manager with id equals 968574.*/

SELECT Dnum,Dname,MGRSSN
FROM dbo.Departments
WHERE MGRSSN= 968574 ;

/*the ids, names and locations of  the pojects which controled with department 10*/

SELECT Pname,Pnumber,Plocation
FROM dbo.Project
WHERE Dnum =10 ;

/*the Department id, name and id and the name of its manager*/

SELECT d.Dname,d.Dnum,e .Fname+' ' +Lname as 'full Name',e.Superssn
FROM dbo.Departments d
INNER JOIN  dbo.Employee e
ON d.Dnum=e.Dno ;

/*the name of the departments and the name of the projects under its control.*/

 SELECT d.Dname,p.pname
FROM dbo.Departments d
LEFT JOIN dbo.Project p
ON d.Dnum=p.Dnum ;

/*the full data about all the dependence associated with the name of the employee they depend on him/her*/

SELECT  D.*,E.fname+' '+lname as 'full name'
FROM dbo.Dependent D
INNER JOIN dbo.Employee E
ON E.ssn=D.ESSN ;

/*the Id, name and location of the projects in Cairo or Alex city*/

SELECT Pnumber,Pname,Plocation
FROM dbo.Project
WHERE City='alex' or City ='cairo' ;

/*14.	Display the Projects full data of the projects with a name starts with "a" letter.*/

SELECT *
FROM dbo.Project
WHERE Pname like 'a%';

/*all the employees in department 30 whose salary from 1000 to 2000 LE monthly*/

SELECT *
FROM dbo.Employee
WHERE Dno=30 AND Salary BETWEEN  1000 AND 2000 ;

/*the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project*/

SELECT E. Fname+' '+Lname as 'Employee Name' 
FROM dbo.Employee E
INNER JOIN  Works_for W 
ON E.SSN= W.ESSn
INNER JOIN dbo.Project p
ON p.Pnumber= W.Pno
WHERE E.Dno=10 
AND W.Hours>=10 
AND P.Pname = 'Al Rabwah';

/*the names of the employees who directly supervised with Kamel Mohamed*/

SELECT Fname+' '+Lname as 'Employee Name'
FROM dbo.Employee
WHERE Superssn= 223344 ;

/* the names of all employees and the names of the projects they are working on, sorted by the project name*/

SELECT p.Pname,E. fname+' ' +lname as 'Employee Name' 
FROM  dbo.Employee e
INNER JOIN dbo.Works_for w
ON e.SSN=w.ESSn
INNER JOIN dbo.Project p
ON p.Pnumber=w.Pno
ORDER BY p.Pname ;

/*For each project located in Cairo City ,
find the project number, the controlling department name ,the department manager last name ,address and birthdate*/

SELECT 
 p.Pnumber, d.Dname, e.Lname, e.Address, e.Bdate
FROM dbo.Project p
JOIN dbo.Departments d
 ON p.Dnum = d.Dnum
JOIN dbo.Employee e
 ON d.MGRSSN = e.SSN
WHERE p.City = 'Cairo';

/*All Data of the mangers*/

 SELECT *
FROM dbo.Employee
WHERE SSN IN (SELECT DISTINCT Superssn FROM dbo.Employee
WHERE Superssn IS NOT NULL) ;

/*All Employees data and the data of their dependents even if they have no dependents*/

SELECT e.*,d.*
FROM  dbo.Employee e
LEFT JOIN dbo.Dependent d
ON e.SSN=d.ESSN ;

/*Data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000*/

INSERT INTO dbo.Employee(Fname,Lname,SSN,Bdate,Address,Sex,Salary,Superssn,Dno)
VALUES ('Asmaa','Aly',102672,2001-01-01,'20 El Mahrousaa Cairo ','F',3000,112233,30) ;


/*Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660
,but don’t enter any value for salary or manager number to him.*/

INSERT INTO dbo.Employee(Fname,Lname,SSN,Bdate,Address,Sex,Dno)
VALUES ('Afnan','Ahmed',102660, 2001-01-01,'30 Hilopolis Cairo','F',30) ;

/*Upgrade your salary by 20 % of its last value*/

UPDATE  dbo.Employee
SET Salary =Salary*1.2
WHERE  Salary =3000 ;

/*a. The name and the gender of the dependence that's gender is Female and depending on Female Employee.
b. And the male dependence that depends on Male Employee*/


SELECT Dependent_name,Sex
FROM dbo.Dependent
WHERE  Sex='F'
UNION
SELECT Fname+' '+Lname as'Employee Name' , Sex
FROM dbo.Employee
WHERE Sex ='F';

/*the project name and the total hours per week (for all employees) spent on that project*/

SELECT p.Pname,SUM ( w.hours) as'Total Hours' 
FROM dbo.Project p
LEFT JOIN Works_for w
ON p.Pnumber=w.Pno
GROUP BY p.Pname ;

/*the data of the department which has the smallest employee ID over all employees' ID.*/


SELECT d.* ,e.ssn
FROM dbo.Employee E
INNER JOIN dbo.Departments d
ON e.Dno=d.Dnum
ORDER BY e.SSN ;

/*OR */
 SELECT d.*, e.SSN
FROM dbo.Departments d
LEFT JOIN dbo.Employee e
ON e.Dno = d.Dnum
WHERE e.SSN = (
SELECT MIN(SSN)
FROM dbo.Employee );

/*the department name and the maximum, minimum and average salary of its employees. */

SELECT d.Dname,
 AVG(e.Salary) as AVG_Salary,
 MIN(e.Salary) as Minimum_Salary,
 MAX(e.Salary) as Maximum_Salary
FROM dbo.Departments d
LEFT JOIN dbo.Employee e
ON e.Dno = d.Dnum
GROUP BY d.Dname ;

/*the last name of all managers who have no dependents*/

SELECT DISTINCT e.Lname 
FROM dbo.Employee e
JOIN dbo.Employee emp
 ON e.SSN = emp.Superssn 
LEFT JOIN dbo.Dependent d
ON e.SSN=d.ESSN
WHERE d.ESSN IS NULL ;

/*30.	For each department-- if its average salary is less than the average salary of all employees--
 number, name and number of its employees.*/
 
SELECT 
  d.Dnum,
  d.Dname,
 COUNT(e.SSN) AS Num_Employees
FROM dbo.Departments d
 INNER JOIN dbo.Employee e
  ON e.Dno = d.Dnum
GROUP BY d.Dnum, d.Dname
HAVING AVG(e.Salary) < (SELECT AVG(Salary) FROM dbo.Employee);

/*list of employees and the projects they are working on ordered by department and within each department
ordered alphabetically by last name, first name. */

SELECT  
DISTINCT e.Fname ,e.Lname ,
p.Pname,p.Dnum
FROM dbo.Employee e
INNER JOIN dbo.Project p
ON e.Dno =p.Dnum
ORDER BY 4,2,1 ;


/*Top 2 salaries */

SELECT SSN,
Fname+' '+ Lname AS 'Employee Name'
,Salary AS 'TOP Salaries'
FROM dbo.Employee
WHERE Salary in(
SELECT  Salary
FROM dbo.Employee
ORDER BY Salary DESC
OFFSET 0 ROWS
FETCH NEXT 2 ROWS ONLY) ;

/*the full name of employees that is similar to any dependent name*/

SELECT DISTINCT e.Fname + ' ' + e.Lname AS 'Employee Name'
FROM dbo.Employee e
WHERE EXISTS (
  SELECT 1 
  FROM dbo.Dependent d
  WHERE e.SSN = d.ESSN
  AND d.Dependent_name LIKE '%' + e.Fname + '%'
);

/*update all salaries of employees who work in Project ‘Al Rabwah’ by 30%  */


UPDATE e
SET e.Salary = e.Salary * 1.3
FROM dbo.Employee e
JOIN dbo.Departments d ON e.Dno = d.Dnum
JOIN dbo.Project p ON p.Dnum = d.Dnum
WHERE p.Pname = 'Al Rabwah' ;

/*the employee number and name if at least one of them have dependents */

SELECT e.SSN,
e.Fname +' ' + e.Lname  AS' Employee name'
FROM dbo.Employee e
WHERE EXISTS (
SELECT 1
FROM dbo.Dependent d
WHERE e.SSN=d.ESSN) ;

/*In the department table insert new department called "DEPT IT"
, with id 100, employee with SSN = 112233 as a manager for this department
. The start date for this manager is '1-11-2006' */

INSERT INTO dbo.Departments (Dname, Dnum, MGRSSN, [MGRStart Date])
VALUES ('DEPT IT', 100, 112233, '2006-11-01');

/* Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100),
and they give you(your SSN =102672) her position (Dept. 20 manager)  */

UPDATE dbo.Employee 
SET Dno = 20 
WHERE SSN = 102672;

UPDATE dbo.Employee 
SET Dno = 100 
WHERE SSN = 968574;

UPDATE dbo.Employee
SET Superssn = 102672, Dno = 20
WHERE SSN = 102660;

UPDATE dbo.Departments
SET MGRSSN = 968574 
WHERE Dnum = 100;
UPDATE dbo.Departments
SET MGRSSN = 102672 
WHERE Dnum = 20;

/*38.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344)
so try to delete his data from your database in case you know that you will be temporarily in his position.
Hint: (Check if Mr. Kamel has dependents, works as a department manager,
supervises any employees or works in any projects and handle these cases).
*/

DELETE dbo.Dependent
WHERE  ESSN=223344;
 
UPDATE dbo.Departments
SET MGRSSN = 112233
WHERE MGRSSN = 223344;

UPDATE dbo.Employee
SET Superssn = 112233
WHERE Superssn =223344;

UPDATE dbo.Works_for
SET ESSN = 112233
WHERE ESSN = 223344;

DELETE dbo.Employee
WHERE SSN=223344;






