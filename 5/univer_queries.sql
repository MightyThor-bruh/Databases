USE UNIVER;
SELECT PULPIT.Pulpit_Name, FACULTY.Faculty, PROFESSION.Profession_Name
    From PULPIT, PROFESSION, FACULTY
	Where FACULTY.Faculty = PULPIT.Faculty and FACULTY.Faculty = PROFESSION.Faculty and
	PROFESSION.Profession_Name In(SELECT PROFESSION.Profession_Name From PROFESSION 
	                                                                Where (PROFESSION.Profession_Name Like '%технолог%'))

SELECT PULPIT.Pulpit_Name, FACULTY.Faculty, PROFESSION.Profession_Name
    From PULPIT INNER JOIN FACULTY On FACULTY.Faculty = PULPIT.Faculty
	            INNER JOIN PROFESSION On FACULTY.Faculty = PROFESSION.Faculty
    Where PROFESSION.Profession_Name In(SELECT PROFESSION.Profession_Name From PROFESSION 
	                                                                Where (PROFESSION.Profession_Name Like '%технолог%'))

SELECT PULPIT.Pulpit_Name, FACULTY.Faculty, PROFESSION.Profession_Name
    From PULPIT INNER JOIN FACULTY On FACULTY.Faculty = PULPIT.Faculty
	            INNER JOIN PROFESSION On FACULTY.Faculty = PROFESSION.Faculty
	Where (PROFESSION.Profession_Name Like '%технолог%')

--?????????????????????????????????????????????????????????????????????
SELECT Auditorium_Capacity, Auditorium_Type 
    From AUDITORIUM a
	Where Auditorium_Name = (SELECT Top(1) Auditorium_Name From AUDITORIUM aa
	      Where aa.Auditorium_Type = a.Auditorium_Type ORDER BY a.Auditorium_Capacity desc)

--где нет ни одной кафедры (предикат exists)
SELECT FACULTY.Faculty_Name
    From FACULTY 
	Where not exists(SELECT * From PULPIT Where PULPIT.Faculty = FACULTY.Faculty)


SELECT Top 1
    (SELECT avg(NOTE) From PROGRESS Where Subjectt like 'СУБД') [СУБД],
	(SELECT avg(NOTE) From PROGRESS Where Subjectt like 'ПСП') [ПСП],
	(SELECT avg(NOTE) From PROGRESS Where Subjectt like 'ПЭХ') [ПЭХ]
	From PROGRESS

SELECT AUDITORIUM.Auditorium, AUDITORIUM.Auditorium_Capacity
    From AUDITORIUM
	Where AUDITORIUM.Auditorium_Capacity >=all (SELECT AUDITORIUM.Auditorium_Capacity 
	                                                   From AUDITORIUM
													   Where AUDITORIUM.Auditorium_Capacity like '90%')

SELECT AUDITORIUM.Auditorium, AUDITORIUM.Auditorium_Capacity
    From AUDITORIUM
	Where AUDITORIUM.Auditorium_Capacity >=any (SELECT AUDITORIUM.Auditorium_Capacity 
	                                                   From AUDITORIUM
													   Where AUDITORIUM.Auditorium_Capacity like '95%')

--день рождения в один день
SELECT Namee, Bday 
    From STUDENT
	Where Bday In(SELECT Bday From STUDENT group by Bday having (count(Bday) > 1))