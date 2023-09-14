#1

-- 1.1 Select the names of all the products in the store.
select name from products;

-- 1.2 Select the names and the prices of all the products in the store.
select name, price from products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
select name, price from products where price <= '200';

-- 1.4 Select all the products with a price between $60 and $120.
select * from products where price between '60' and '120';

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, price* 0.100 as percentage from products;

-- 1.6 Compute the average price of all the products.
select avg(price) from products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select code, avg(price) from products where Code=2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(name) from products where price>= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price from products where price>= 180 order by price desc;
select name, price from products where price>= 180 order by name;


-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from products
join manufacturers 
on products.code=manufacturers.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
select products.name as product_name, price, manufacturers.name as manufacturers_name from products
join manufacturers 
on products.code=manufacturers.code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select Manufacturer , avg (Price) from products group by Manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg (products.price) as avg_price, Manufacturers.Name from products join Manufacturers 
on products.Manufacturer = Manufacturers.Code
group by products.Manufacturer;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select avg (products.price) as avg_price, Manufacturers.Name from products join Manufacturers 
on products.Manufacturer = Manufacturers.Code
group by products.Manufacturer
having avg_price >= 150;

-- 1.15 Select the name and price of the cheapest product.
select Name,price from products 
order by price limit 1;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select products.price,products.Name, Manufacturers.Name from products join Manufacturers 
on products.Manufacturer = Manufacturers.Code
where products.price in (select max(price) from products group by Manufacturer);

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products (Code,Name, Price, Manufacturer)
VALUES (11,'Loudspeakers', 70, 2);

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products set Name = 'Laser Printer'
where Code = 8;

-- 1.19 Apply a 10% discount to all products
select Name , price * 0.90  from products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
select Name , price * 0.90  from products
where price >= 120;


-- 2 **********

-- 2.1 Select the last name of all employees.
select LastName from Employees;


-- 2.2 Select the last name of all employees, without duplicates.
select distinct LastName from employees;


-- 2.3 Select all the data of employees whose last name is "Smith".
select * from employees where lastname = 'Smith';


-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select * from Employees where lastname in ('Smith', 'Doe');

-- 2.5 Select all the data of employees that work in department 14.
select * from Employees where department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select * from employees where department in (37, 77);


-- 2.7 Select all the data of employees whose last name begins with an "S".
select * from employees where LastName like 'S%';


-- 2.8 Select the sum of all the departments' budgets.
select sum(budget) from Departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select Department, count(*) from employees group by department;


select * from employees;
select * from departments;
-- 2.10 Select all the data of employees, including each employee's department's data.
select * from employees a 
join departments b on a.department = b.code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select a.name, a.lastname, b.name Department_name, b.Budget
from employees a join departments b
on a.department = b.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select name, lastname from employees 
where department in (select code from departments where Budget>60000);

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select * from departments 
where budget > (select avg(budget) from departments);

-- 2.14  Select the names of departments with more than two employees.
select b.name from departments b
where code in (select department from employees
group by department having count(*)>2);

-- 2.15
-- Very Important
-- Select the name and last name of employees working for departments with second lowest budget.

select name, lastname from employees
where department =(select temp.code 
from (select * from departments order by budget limit 2) temp
order by temp.budget desc limit 1
);

-- 2.16
-- Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into departments values(11, 'Quality Assurance', 40000);
insert into employees values(847219811, 'Mary', 'Moore', 11);

-- 2.17
-- Reduce the budget of all departments by 10%.
update departments 
set budget = 0.9 * budget;

-- 2.18
-- Reassign all employees from the Research department (code 77) to the IT department (code 14).
update employees
set department = 14
where department = 77;

-- 2.19
-- Delete from the table all employees in the IT department (code 14).

delete from employees
where department = 14;

-- 2.20
-- Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees
where department in (select code from departments where budget>=60000);


-- 2.21
-- Delete from the table all employees.
   drop table employees;



-- 3*****
 -- 3.1 Select all warehouses.
 select * from warehouses;
 
 -- 3.2 Select all boxes with a value larger than $150.
 select * from boxes where value > 150;
 
 -- 3.3 Select all distinct contents in all the boxes.
 select distinct contents from boxes;
 
 -- 3.4 Select the average value of all the boxes
 select avg(value) from boxes;
 
 -- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
 select warehouses.code, avg(boxes.value) from warehouses
 join boxes
 on warehouses.Code=boxes.warehouse
 group by warehouses.code;
 
 -- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
 select warehouses.code, avg(boxes.value) from warehouses
 join boxes
 on warehouses.Code=boxes.warehouse
 group by warehouses.code
 having avg(boxes.value)>150;
 
 -- 3.7 Select the code of each box, along with the name of the city the box is located in.
 select boxes.code, warehouses.location from boxes
 join warehouses
 on boxes.warehouse=warehouses.code;
 select * from warehouses;
 --  3.8 Select the warehouse codes, along with the number of boxes in each warehouse.
select warehouses.code, count(boxes.warehouse), warehouses.capacity from warehouses
join boxes
on warehouses.code=boxes.warehouse
group by warehouse;
 select * from warehouses;
 select * from boxes;
 
 
 -- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
 select warehouses.code, count(boxes.warehouse), warehouses.capacity from warehouses
join boxes
on warehouses.code=boxes.warehouse
group by warehouse
having capacity< count(boxes.warehouse);

-- 3.10 Select the codes of all the boxes located in Chicago.
select boxes.code, warehouses.location from boxes
join warehouses
on boxes.warehouse=warehouses.code
where warehouses.location= 'chicago';

select * from boxes;
-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(6,'New York',3);
 
 select * from warehouses;
 select * from boxes;

 
 -- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('H5RT','Papers',200,2);
 
 SELECT * FROM boxes;
 
 -- 3.13 Reduce the value of all boxes by 15%.
  select value * 0.85 from boxes;
  
  -- 3.14 Remove all boxes with a value lower than $100.
delete from boxes where value < '100';

-- 3.15 Remove all boxes from saturated warehouses
delete from boxes where warehouse= 1;

-- 3.16 Add Index for column "Warehouse" in table "boxes"
create index idx_warehouse on boxes (Warehouse);

-- 3.17 Print all the existing indexes
show index from boxes;

-- 3.18 Remove (drop) the index you added just
drop index  idx_warehouse on boxes;


-- 4*******
-- 4.1 Select the title of all movies.
 select title from movies;
 
 -- 4.2 Show all the distinct ratings in the database.
 select distinct rating from movies;
 
 -- 4.3  Show all unrated movies.
 select title, rating from movies where Rating is null;
 
 -- 4.4 Select all movie theaters that are not currently showing a movie.
 select name from movietheaters where movie is null;
 
 -- 4.5 Select all data from all movie theaters 
 select name, movie, title  from movietheaters
 join movies
 on movietheaters.code=movies.code
 where movie is not null;
 
 -- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
 select title, rating , name from movies
 join movietheaters
 on movies.code=movietheaters.code
 where movie is not null;
 
 -- 4.7 Show the titles of movies not currently being shown in any theaters.
 select title from movies
 join movietheaters
 on movies.code=movietheaters.code
 where movie is null;
 
 select * from movies;
 -- 4.8 Add the unrated movie "One, Two, Three".
 INSERT INTO Movies(Code,Title,Rating) VALUES(9,'One, Two, Three',NULL);
 
 -- 4.9 Set the rating of all unrated movies to "G".
 update movies 
 set rating = 'G'
 where rating is null;
 
 -- 4.10 Remove movie theaters projecting movies rated "NC-17".
 delete from movietheaters where code = 4;
 
 -- 5****
 -- 5.1 Select the name of all the pieces.
select name from pieces;

-- 5.2  Select all the providers' data.
select * from providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
 select piece, avg(price) from provides group by Piece;
 
 -- 5.4  Obtain the names of all providers who supply piece 1.
 select name from providers
 join provides
 on providers.Code=provides.Provider
 where Piece=1;
 
 -- 5.5 Select the name of pieces provided by provider with code "HAL".
 select name from pieces
 join provides
 on pieces.Code=provides.piece
 where provider='HAL';
 
 -- 5.6 For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
 select pieces.name , max(price) , providers.name from provides
 join pieces
 on provides.piece=pieces.Code
 join providers
 on provides.Provider=providers.Code
 group by piece;
 
 -- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'TNBC',7);
 
 -- 5.8 Increase all prices by one cent.
 update provides
 set price= price+ 0.01;
 
 --  5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
 delete from provides where Provider = "RBT" and piece = 4;
 
 -- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
delete from provides where Provider = "RBT";


-- 6*****

-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
    select (scientists.name) as "SCIENTISTS NAME" , (projects.name) as "PROJECTS NAME", projects.hours from scientists
    inner join assignedTo on scientists.SSN= assignedto.scientist
    inner join projects on assignedTo.project = projects.code;
    
-- 6.2 Select the project names which are not assigned yet
select name from projects where code not in (select project from assignedto );


-- 7*****

-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
    
    select client.name from client join package on client.accountnumber = package.recipient where package.weight = 1.5;

-- 7.2 What is the total weight of all the packages that he sent?
select sum(package.weight) as "total packages" from client join package on client.accountnumber = package.sender where client.name =  "Al Gore's Head";

-- 9***

-- 9.1 give the total number of recordings in this table
select count(date) as recordings from workflow;

-- 9.2 the number of packages listed in this table?
select count(distinct(package)) from workflow;

-- 9.3 How many times the package "Rcpp" was downloaded?
select count(package) from workflow where package= 'Rcpp';

-- 9.4 How many recordings are from China ("CN")?
select count(date) from workflow where country = 'CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select package, count(package) from workflow group by package order by count(package) desc;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select package, count(package) from workflow where time between '09:00:00' and '11:00:00' group by package order by count(package) desc;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
select count(date) from workflow where country in ('CN', 'JP', 'SG');

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN") -------------
select country, count(date) from workflow where count(date) > (select count(date) from workflow where country = 'CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages -------
select avg(LENGTH(package)) as average_package_name_length
from (select distinct package from workflow) as unique_packages;



-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
select package,count(package) from workflow group by package order by count(package) desc limit 1,1;


-- 9.11 Print the name of the package whose download count is bigger than 1000.
  select package, count(package) from workflow group by package having count(package) > 1000;

-- 9.12 The field "r_os" is the operating system of the users.-------------
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
select r_os ,(count(*)/62324)*100 as Main_Sys_Percentage from workflow group by r_os ;

-- 10****
-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
  select people.id, address, updatedate from address 
  join people
  on address.id=people.id
  group by people.id;
  
 
  -- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
  
  select people.id, people.name, TEMP.address from people left join (select id, address, MAX(updatedate)FROM address group by id) AS TEMP on people.id = TEMP.id;