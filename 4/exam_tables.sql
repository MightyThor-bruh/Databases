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
   values (101, '���'),
          (102, '��'),
		  (103, '���'),
		  (104, '���'),
		  (105, '����')

INSERT into EXAMENATOR (ExID, Examenator_Name)
   values (1, '�����'),
          (2, '�������'),
		  (3, '�����������'),
		  (4, '������'),
		  (5, '�������')

INSERT into EXAM (Num, ExID, SubID)
   values (1, 1, 101),
          (2, 2, 102),
		  (3, 3, null),
		  (4, 4, 104),
		  (5, null, 105)
