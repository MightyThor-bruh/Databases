USE UNIVER;
SELECT min(Auditorium_Capacity) [Минимальная вместимость],
       max(Auditorium_Capacity) [Максимальная вместимость],
	   avg(Auditorium_Capacity) [Средняя вместимость],
	   sum(Auditorium_Capacity) [Суммарная вместимость],
	   count(*)
From AUDITORIUM

--------------------------------------------------------------------------
SELECT AUDITORIUM_TYPE.Auditorium_TypeName, 
       min(Auditorium_Capacity) [Минимальная вместимость],
       max(Auditorium_Capacity) [Максимальная вместимость],
       avg(Auditorium_Capacity) [Средняя вместимость],
       count (*) [Количество аудиторий данного типа]
From AUDITORIUM inner join AUDITORIUM_TYPE
       On AUDITORIUM.Auditorium_Type = AUDITORIUM_TYPE.Auditorium_Type
       GROUP BY Auditorium_TypeName 

--------------------------------------------------------------------------
SELECT * From 
   (SELECT
      Case
         when PROGRESS.Note between 4 and 5 then '4-5'
         when PROGRESS.Note between 6 and 7 then '6-7'
         when PROGRESS.Note between 8 and 9 then '8-9'
         when PROGRESS.Note = 10 then '10'
         end [Оценки], count (*) [Количество]
         From PROGRESS GROUP BY Case
                                when PROGRESS.Note between 4 and 5 then '4-5'
                                when PROGRESS.Note between 6 and 7 then '6-7'
                                when PROGRESS.Note between 8 and 9 then '8-9'
                                when PROGRESS.Note = 10 then '10'
                                end) as T
ORDER BY
   Case [Оценки]
   when '4-5' then 4
   when '6-7' then 3
   when '8-9' then 2
   when '10' then 1
   end
--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], g.Year_First [Год поступления], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
      GROUP BY f.Faculty, g.Profession, g.Year_First
      ORDER BY [Средняя оценка] desc

--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], g.Year_First [Год поступления], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where p.Subjectt = 'СУБД'
      GROUP BY f.Faculty, g.Profession, g.Year_First
      ORDER BY [Средняя оценка] desc

--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ЛХФ'
      GROUP BY ROLLUP (f.Faculty, g.Profession, p.Subjectt)

--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ЛХФ'
      GROUP BY CUBE (f.Faculty, g.Profession, p.Subjectt)

--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ЛХФ'
      GROUP BY f.Faculty, g.Profession, p.Subjectt
UNION
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ХТиТ'
      GROUP BY f.Faculty, g.Profession, p.Subjectt

--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ЛХФ'
      GROUP BY f.Faculty, g.Profession, p.Subjectt
INTERSECT
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ХТиТ'
      GROUP BY f.Faculty, g.Profession, p.Subjectt

--------------------------------------------------------------------------
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ЛХФ'
      GROUP BY f.Faculty, g.Profession, p.Subjectt
EXCEPT
SELECT f.Faculty [Факультет], g.Profession [Специальность], p.Subjectt [Дисциплина], 
      round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = 'ХТиТ'
      GROUP BY f.Faculty, g.Profession, p.Subjectt

--------------------------------------------------------------------------
SELECT p1.Subjectt, p1.Note,
    (SELECT count(*) From PROGRESS p2
            Where p2.NOTE = p1.NOTE and p2.Subjectt = p1.Subjectt) [Количество]
    From PROGRESS p1
    GROUP BY p1.Subjectt, p1.Note HAVING Note = 8 or Note = 9

--------------------------------------------------------------------------
--Подсчитать количество студентов в каждой группе, на каждом факультете и всего в университете одним запросом.
SELECT DISTINCT FACULTY.Faculty, GROUPA.IDGroup, count(STUDENT.IDStudent) as [Количество студентов]
     From FACULTY full join GROUPA On GROUPA.Faculty = FACULTY.Faculty
                  full join STUDENT On GROUPA.IDGroup = STUDENT.IDGroup
     GROUP BY ROLLUP (FACULTY.Faculty, GROUPA.IDGroup)

--Подсчитать количество аудиторий по типам и суммарной вместимости в корпусах и всего одним запросом
SELECT AUDITORIUM_TYPE.Auditorium_Type, COUNT(AUDITORIUM.Auditorium) as [Количество аудиторий], 
     SUM(AUDITORIUM.Auditorium_Capacity) as [Суммарная вместимость]
     From AUDITORIUM_TYPE inner join AUDITORIUM On AUDITORIUM_TYPE.Auditorium_Type = AUDITORIUM.Auditorium_Type
     GROUP BY ROLLUP (AUDITORIUM_TYPE.Auditorium_Type)