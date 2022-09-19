USE UNIVER;
GO
CREATE VIEW [�������������]
     as SELECT Teacher [���], Teacher_Name [��� �������������], Gender [���], Pulpit [��� �������] 
	 From TEACHER
GO
SELECT * From �������������

------------------------------------------------------------------------------------------------
USE UNIVER;
GO
CREATE VIEW [���������� ������]
     as SELECT FACULTY.Faculty_Name [���������], count(*) [���������� ������]
	 From FACULTY join PULPIT On FACULTY.Faculty = PULPIT.Faculty
	 GROUP BY FACULTY.Faculty_Name
GO 
SELECT * From [���������� ������]

------------------------------------------------------------------------------------------------
USE UNIVER;
GO
CREATE VIEW [���������]
     as SELECT AUDITORIUM.Auditorium [���], AUDITORIUM.Auditorium_Name [������������ ���������]
	 From AUDITORIUM
	 Where AUDITORIUM.Auditorium_Type Like '��%' with check option 
GO
SELECT * From ���������;
INSERT ��������� values ('102-1', '��', 60, '102-1')

------------------------------------------------------------------------------------------------
USE UNIVER;
GO
CREATE VIEW [����������]
    as SELECT TOP 10 SUBJECTT.Subjectt [���], SUBJECTT.Subjectt_Name [��� ����������], SUBJECTT.Pulpit [��� �������]
	From SUBJECTT
	ORDER BY [��� ����������]
GO 
SELECT * From ����������

------------------------------------------------------------------------------------------------
use UNIVER;
GO
ALTER VIEW [���������� ������] with schemabinding
     as SELECT FACULTY.Faculty_Name [���������], count(*) [���������� ������]
	 From dbo.FACULTY join dbo.PULPIT On FACULTY.Faculty = PULPIT.Faculty
	 GROUP BY FACULTY.Faculty_Name
GO 
SELECT * From [���������� ������]

------------------------------------------------------------------------------------------------
use UNIVER;
GO
CREATE VIEW [����������]
     as SELECT TIMETABLE.Class [����� ����], TIMETABLE.Subjectt [�������], TIMETABLE.Auditorium [���������]
	 From TIMETABLE
	 GROUP BY TIMETABLE.Class, TIMETABLE.Subjectt, TIMETABLE.Auditorium
GO
SELECT * From ����������

SELECT [���������], [1] as [8.00-9.35], [2] as [9.50-11.25], 
[3] as [11.40-13.15], [4] as [13.50-15.25]
from [����������]
pivot(count([�������]) for [����� ����] in([1], [2], [3], [4])) as pivott