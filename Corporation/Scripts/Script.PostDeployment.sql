-- This file contains SQL statements that will be executed after the build script.
PRINT 'Running post-deployment script for Corporation database...'

--  Categories
INSERT INTO Categories (CategoryID, CategoryName) VALUES (1, 'Printers');
INSERT INTO Categories (CategoryID, CategoryName) VALUES (2, 'Cameras');
INSERT INTO Categories (CategoryID, CategoryName) VALUES (3, 'Consummables');
GO

--  Departments
INSERT INTO Departments (DepartmentID,DepartmentLocation,DepartmentName) VALUES ('00001', 'Phoenix', 'User Acceptance Testing');
INSERT INTO Departments (DepartmentID,DepartmentLocation,DepartmentName) VALUES ('00002', 'London',  'Accounts');
INSERT INTO Departments (DepartmentID,DepartmentLocation,DepartmentName) VALUES ('00003', 'Paris',   'Pet food');
GO

--  Employees
INSERT INTO Employees (EmployeeID,FirstName,LastName,Address,City,PostCode,Phone,Salary,DepartmentID,DateJoined) VALUES ('00001', 'Tony',    'Gyles',    '29 Cyprus Road',        'Basingstoke', 'RG22 4WT', '01256 468552', 56000.45,   '00001', '01 June 1991');
INSERT INTO Employees (EmployeeID,FirstName,LastName,Address,City,PostCode,Phone,Salary,DepartmentID,DateJoined) VALUES ('00002', 'Steve',   'Gyles',    '37 Cairngorm Close',    'Basingstoke', 'RG22 6TT', '01256 352752', 15000.00,   '00002', '09 July 1995');
INSERT INTO Employees (EmployeeID,FirstName,LastName,Address,City,PostCode,Phone,Salary,DepartmentID,DateJoined) VALUES ('00003', 'Claudia', 'Schiffer', '101 All SaINTs Avenue', 'London',      'SW12 6YY', '0161 7499439', 2500000.00, '00003', '17 April 1993');
INSERT INTO Employees (EmployeeID,FirstName,LastName,Address,City,PostCode,Phone,Salary,DepartmentID,DateJoined) VALUES ('00004', 'Pamela',  'Anderson', '66 Sunset Boulevard',   'Los Angeles', '239810',   '0272 828282',  780000,     '00001', '29 December 1996');
INSERT INTO Employees (EmployeeID,FirstName,LastName,Address,City,PostCode,Phone,Salary,DepartmentID,DateJoined) VALUES ('00005', 'James',   'Gyles',    '9 Turnberry Drive',     'Basingstoke', 'RG44 9HH', '01256 768546', 24000,      '00001', '2 March 2002');
GO

--  Suppliers
INSERT INTO Suppliers (SupplierID,SupplierName,Address,City,PostCode,Country,Phone,Fax,PaymentTerms,EMail,WebAddress,Notes)  VALUES ( 1, 'Hewlett Packard', '1 Bailey Street',       'Basingstoke', 'RG22 4FF','United Kingdom','01256 434557','01256 468559','ASAP','','www.ford.com',      'Large motor vehicle company');
INSERT INTO Suppliers (SupplierID,SupplierName,Address,City,PostCode,Country,Phone,Fax,PaymentTerms,EMail,WebAddress,Notes)  VALUES ( 2, 'Epson',           '229 Nutcracker Avenue', 'Notts',       'NT33 9LL','United Kingdom','0566 43531',  '0566 43539',  'ASAP','','www.lloydstsb.com', 'Financial company');
INSERT INTO Suppliers (SupplierID,SupplierName,Address,City,PostCode,Country,Phone,Fax,PaymentTerms,EMail,WebAddress,Notes)  VALUES ( 3, 'Canon',           '401 Jaz Street',        'London',      'SW11 3RE','United Kingdom','01 234567',   '01 234568',   'ASAP','','www.sainsburys.com','Food company');
GO

--  Products
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES (   1, 'HP Photosmart 7550',     1, 1, 221.00, 1000, '1 Jan 2002' ,0);
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES (   2, 'HP DeskJet 3820',        1, 1,  73.00, 1000, '2 Feb 2002' ,0);
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES (   3, 'HP DeskJet 5550   ',     1, 1, 115.00, 1000, '3 Mar 2003' ,0);
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES ( 101, 'Epson Stylus Photo 925', 2, 1, 185.00, 1000, '17 Dec 2003',0);
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES ( 102, 'Epson Stylus Photo 950', 2, 1, 281.00, 1000, '21 Apr 2004',0);
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES ( 201, 'Canon i320',             3, 1,  59.00, 1000, '1 May 2005' ,0);
INSERT INTO Products (ProductID,ProductName,SupplierID,CategoryID,UnitPrice,UnitsInStock,CreateDT,Discontinued) VALUES ( 202, 'Canon S9000',            3, 1, 365.00, 1000, '11 Nov 2006',0);
GO

-- Accounts
INSERT Accounts VALUES ( 12345, 190)
INSERT Accounts VALUES ( 22445,  30)
INSERT Accounts VALUES ( 32446, 980)
INSERT Accounts VALUES ( 45567, 213)
GO

-- Users
INSERT INTO Users values('tony','tony','Manager')
INSERT INTO Users values('paula','superwife','Admin')
INSERT INTO Users values('james','chessmaster','User')
GO

-- Customers
INSERT INTO Customers values(1, 'Tony Gyles',     '9 Turnberry Drive',    'Basingstoke', 'RG22 4WT','UK', '01256444661', 'tonygyles@btinternet.com')
INSERT INTO Customers values(2, 'Jasper Conran',  '50 Primrose Hill',     'London',      'EN1 9KL', 'UK', '019875612',   'jasper9@gmail.com')
INSERT INTO Customers values(3, 'Sid Viscount',   '5678 Lavendar Street', 'Reading',     'RG1 8UJ', 'UK', '01872345678', 'sviscount@tiscali.co.uk')
INSERT INTO Customers values(4, 'Charlie Brooks', '22 Green Road',        'Edingburgh',  'ED1 3QE', 'UK', '0304567431',  'charlie.brooks@vmedia.com')
INSERT INTO Customers values(5, 'Tessa Hook',     '6 Hardwicke Drice',    'Southampton', 'SO2 1EE', 'UK', '0054312561',  'thook@btinternet.com')
INSERT INTO Customers values(6, 'Edward Ark',     '1 Acacia Avenue',      'Cardiff',     'CA55 8LK','UK', '0177891012',  'edwardark@tiscali.co.uk')
INSERT INTO Customers values(7, 'John Doe',       '55 Dunbard Street',    'Newcastle',   'NE07 6UI','UK', '08516828282', 'jdoe@btinternet.com')
INSERT INTO Customers values(8, 'Craig White',    '69 Hanover Place',     'Plymouth',    'PL92 7HG','UK', '03251717178', 'craig.white@sky.com')
INSERT INTO Customers values(9, 'Harry Hoover',   '15 Isles Way',         'Derby',       'DE45 9KA','UK', '06257851611', 'hhoover@gmail.com')
INSERT INTO Customers values(10,'Jane Fonda',     '29 Dover Road',        'Andover',     'SO16 2XX','UK', '01768765265', 'janefonda@btinternet.com')
GO