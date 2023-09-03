
select * from employee;
select * from contact;

-- 1. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus.   
select EmployeeID, FirstName,LastName, bonus  from contact
join employee 
on contact.ContactID=employee.ContactID 
join salesperson
on contact.ContactID=employee.ContactID 
where Bonus > 2000;

select * from address;
select * from stateprovince;
-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A. 
select Addressline1, IFNULL(Addressline2,'N/A'), CountryRegionCode from address 
join stateprovince
on address.StateProvinceID=stateprovince.StateProvinceID
where CountryRegionCode='CA';


 select * from product;
 select * from salesorderdetail;
 select * from productsubcategory;
 select * from vendor;
 
-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.
 select Name , SalesOrderDetailID from product
 join salesorderdetail
 on product.ProductID=salesorderdetail.ProductID;
 
 
 -- 4. Find the subcategories that have at least two different prices less than $15. 
 select productsubcategory.name as name, product.listprice as price from productsubcategory join product on 
productsubcategory.ProductSubcategoryID = product.ProductSubcategoryID where listPrice < 15 order by price desc limit 2;

 -- 5. A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name.
-- B. Display the employee id and employee name of employees who do not have manager. 
 select EmployeeID, FirstName, ManagerID  from contact
join employee 
on contact.ContactID=employee.ContactID ;
  select EmployeeID, FirstName, ManagerID  from contact
join employee 
on contact.ContactID=employee.ContactID 
where ManagerID is null;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
-- B. Find the products that have more than one vendor. 
select product.productsubcategoryid,productvendor.ProductID,productvendor.VendorID,vendor.Name from vendor 
join productvendor on productvendor.VendorID=vendor.VendorID
join product on productvendor.productid = product.productid 
where product.ProductSubcategoryID=15;
select product.ProductID, product.name, count(productvendor.VendorID) as vendors from productvendor
join product on productvendor.ProductID=product.ProductID 
group by product.ProductID
having count(productvendor.VendorID) > 1 ;


-- 7. Find all the customers who do not belong to any store. 
select customer.CustomerID from customer left join  store on customer.CustomerID = store.CustomerID where store.CustomerID is null group by customer.CustomerID;

-- 8. Find sales prices of product 718 that are less than the list price recommended for that product. 
select * from salesorderdetail where ProductID =718;
select product.ProductID, salesorderdetail.UnitPrice 
from salesorderdetail join product on salesorderdetail.productID= product.ProductID
where salesorderdetail.UnitPrice < product.ListPrice  and product.ProductID=718;

select * from productdescription ;
select * from product;
select* from salesorderdetail;

-- 9. Display product number, description and sales of each product in the year 2001. 
select productID, description , linetotal, year(salesorderdetail.ModifiedDate) as 'year' from productdescription
join salesorderdetail
on productdescription.ProductDescriptionID=salesorderdetail.ProductID
where year(salesorderdetail.ModifiedDate) = 2001;

-- 10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003. 
select product.productID, product.name ,  year(salesorderdetail.ModifiedDate) as year from product
join salesorderdetail
on product.ProductID=salesorderdetail.ProductID
where year(salesorderdetail.ModifiedDate) in (2001, 2002, 2003);




