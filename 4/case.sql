USE UNIVER;
SELECT FACULTY.Faculty [Факультет], PULPIT.Pulpit [Кафедра], PROFESSION.Profession_Name [Специальность], STUDENT.Namee [Имя студента], PROGRESS.Subjectt [Предмет],
       Case
       when (PROGRESS.Note = 6) then 'шесть'
       when (PROGRESS.Note = 7) then 'семь'
       when (PROGRESS.Note = 8) then 'восемь'
       else '-'
       end [Оценка]
       From FACULTY 
            INNER JOIN PROFESSION on PROFESSION.Faculty = FACULTY.Faculty
            INNER JOIN GROUPA on GROUPA.Faculty = FACULTY.Faculty
            INNER JOIN STUDENT on GROUPA.IDGroup = STUDENT.IDGroup
            INNER JOIN PROGRESS on PROGRESS.IDStudent = STUDENT.IDStudent
            INNER JOIN SUBJECTT on PROGRESS.Subjectt = SUBJECTT.Subjectt
            INNER JOIN PULPIT on SUBJECTT.Pulpit = PULPIT.Pulpit and (PROGRESS.Note = 6 or PROGRESS.Note = 7 or PROGRESS.Note = 8)
            ORDER BY PROGRESS.Note DESC, FACULTY.Faculty, PULPIT.Pulpit, PROFESSION.Profession, STUDENT.Namee;

--ордер через кейсы

SELECT FACULTY.Faculty [Факультет], PULPIT.Pulpit [Кафедра], PROFESSION.Profession_Name [Специальность], STUDENT.Namee [Имя студента], PROGRESS.Subjectt [Предмет],
       Case
       when (PROGRESS.Note = 6) then 'шесть'
       when (PROGRESS.Note = 7) then 'семь'
       when (PROGRESS.Note = 8) then 'восемь'
       else '-'
       end [Оценка]
       From FACULTY 
            INNER JOIN PROFESSION on PROFESSION.Faculty = FACULTY.Faculty
            INNER JOIN GROUPA on GROUPA.Faculty = FACULTY.Faculty
            INNER JOIN STUDENT on GROUPA.IDGroup = STUDENT.IDGroup
            INNER JOIN PROGRESS on PROGRESS.IDStudent = STUDENT.IDStudent
            INNER JOIN SUBJECTT on PROGRESS.Subjectt = SUBJECTT.Subjectt
            INNER JOIN PULPIT on SUBJECTT.Pulpit = PULPIT.Pulpit and (PROGRESS.Note = 6 or PROGRESS.Note = 7 or PROGRESS.Note = 8)
            ORDER BY 
			( Case 
			      when (PROGRESS.Note = 6) then 3
				  when (PROGRESS.Note = 7) then 2
				  else 1
			  end
			)