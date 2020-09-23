create table Employees
   (
      id int not null,
      age int not null,
      first varchar (255),
      last varchar (255),
      site varchar (255)
   );
   
ALTER TABLE Employees 
ADD site varchar (255);
   
INSERT INTO Employees VALUES (100, 18, 'Shashi', 'Ramachandra', 'onpremdb');

INSERT INTO Employees VALUES (101, 25, 'Mile', 'Zhu', 'onpremdb');

INSERT INTO Employees VALUES (102, 30, 'Cathy', 'Xing', 'onpremdb');

INSERT INTO Employees VALUES (103, 28, 'Ashish', 'Denny', 'onpremdb');

INSERT INTO Employees VALUES (100, 18, 'Shashi', 'Ramachandra', 'onpremdb');

select * from employees;
