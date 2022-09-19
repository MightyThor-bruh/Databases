USE UNIVER;
GO
CREATE VIEW [Преподаватели]
     as SELECT Teacher [Код], Teacher_Name [Имя преподавателя], Gender [Пол], Pulpit [Код кафедры] 
	 From TEACHER
GO
SELECT * From Преподаватели

------------------------------------------------------------------------------------------------
USE UNIVER;
GO
CREATE VIEW [Количество кафедр]
     as SELECT FACULTY.Faculty_Name [Факультет], count(*) [Количество кафедр]
	 From FACULTY join PULPIT On FACULTY.Faculty = PULPIT.Faculty
	 GROUP BY FACULTY.Faculty_Name
GO 
SELECT * From [Количество кафедр]

------------------------------------------------------------------------------------------------
USE UNIVER;
GO
CREATE VIEW [Аудитории]
     as SELECT AUDITORIUM.Auditorium [Код], AUDITORIUM.Auditorium_Name [Наименование аудитории]
	 From AUDITORIUM
	 Where AUDITORIUM.Auditorium_Type Like 'ЛК%' with check option 
GO
SELECT * From Аудитории;
INSERT Аудитории values ('102-1', 'ЛБ', 60, '102-1')

------------------------------------------------------------------------------------------------
USE UNIVER;
GO
CREATE VIEW [Дисциплины]
    as SELECT TOP 10 SUBJECTT.Subjectt [код], SUBJECTT.Subjectt_Name [имя дисциплины], SUBJECTT.Pulpit [код кафедры]
	From SUBJECTT
	ORDER BY [имя дисциплины]
GO 
SELECT * From Дисциплины

------------------------------------------------------------------------------------------------
use UNIVER;
GO
ALTER VIEW [Количество кафедр] with schemabinding
     as SELECT FACULTY.Faculty_Name [Факультет], count(*) [Количество кафедр]
	 From dbo.FACULTY join dbo.PULPIT On FACULTY.Faculty = PULPIT.Faculty
	 GROUP BY FACULTY.Faculty_Name
GO 
SELECT * From [Количество кафедр]

------------------------------------------------------------------------------------------------
use UNIVER;
GO
CREATE VIEW [Расписание]
     as SELECT TIMETABLE.Class [Номер пары], TIMETABLE.Subjectt [Предмет], TIMETABLE.Auditorium [Аудитория]
	 From TIMETABLE
	 GROUP BY TIMETABLE.Class, TIMETABLE.Subjectt, TIMETABLE.Auditorium
GO
SELECT * From Расписание

SELECT [Аудитория], [1] as [8.00-9.35], [2] as [9.50-11.25], 
[3] as [11.40-13.15], [4] as [13.50-15.25]
from [Расписание]
pivot(count([Предмет]) for [Номер пары] in([1], [2], [3], [4])) as pivott