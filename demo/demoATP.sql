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
   
INSERT INTO Employees VALUES (100, 18, 'Shashi', 'Ramachandra', 'cloudatp');

INSERT INTO Employees VALUES (101, 25, 'Mile', 'Zhu', 'cloudatp');

INSERT INTO Employees VALUES (102, 30, 'Cathy', 'Xing', 'cloudatp');

INSERT INTO Employees VALUES (103, 28, 'Ashish', 'Denny', 'cloudatp');

INSERT INTO Employees VALUES (100, 18, 'Shashi', 'Ramachandra', 'cloudatp');

select * from employees;
