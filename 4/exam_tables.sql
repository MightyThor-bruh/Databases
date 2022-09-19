USE examnotes;
CREATE table SUBJECTT 
( SubID int primary key,
  Subject_Name nvarchar(100)
)
CREATE table EXAMENATOR 
( ExID int primary key,
  Examenator_Name nvarchar(100)
)
CREATE table EXAM 
( Num int primary key,
  SubID int foreign key references SUBJECTT(SubID),
  ExID int foreign key references EXAMENATOR(ExID)
)

INSERT into SUBJECTT (SubID, Subject_Name)
   values (101, 'ООП'),
          (102, 'БД'),
		  (103, 'РПР'),
		  (104, 'ЭВМ'),
		  (105, 'КСИС')

INSERT into EXAMENATOR (ExID, Examenator_Name)
   values (1, 'Пацей'),
          (2, 'Блинова'),
		  (3, 'ПУстовалова'),
		  (4, 'Шмаков'),
		  (5, 'Миронов')

INSERT into EXAM (Num, ExID, SubID)
   values (1, 1, 101),
          (2, 2, 102),
		  (3, 3, null),
		  (4, 4, 104),
		  (5, null, 105)
