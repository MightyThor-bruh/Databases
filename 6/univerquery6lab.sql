USE UNIVER;
SELECT min(Auditorium_Capacity) [����������� �����������],
       max(Auditorium_Capacity) [������������ �����������],
	   avg(Auditorium_Capacity) [������� �����������],
	   sum(Auditorium_Capacity) [��������� �����������],
	   count(*)
From AUDITORIUM

--------------------------------------------------------------------------
SELECT AUDITORIUM_TYPE.Auditorium_TypeName, 
       min(Auditorium_Capacity) [����������� �����������],
       max(Auditorium_Capacity) [������������ �����������],
       avg(Auditorium_Capacity) [������� �����������],
       count (*) [���������� ��������� ������� ����]
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
         end [������], count (*) [����������]
         From PROGRESS GROUP BY Case
                                when PROGRESS.Note between 4 and 5 then '4-5'
                                when PROGRESS.Note between 6 and 7 then '6-7'
                                when PROGRESS.Note between 8 and 9 then '8-9'
                                when PROGRESS.Note = 10 then '10'
                                end) as T
ORDER BY
   Case [������]
   when '4-5' then 4
   when '6-7' then 3
   when '8-9' then 2
   when '10' then 1
   end
--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], g.Year_First [��� �����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
      GROUP BY f.Faculty, g.Profession, g.Year_First
      ORDER BY [������� ������] desc

--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], g.Year_First [��� �����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where p.Subjectt = '����'
      GROUP BY f.Faculty, g.Profession, g.Year_First
      ORDER BY [������� ������] desc

--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '���'
      GROUP BY ROLLUP (f.Faculty, g.Profession, p.Subjectt)

--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '���'
      GROUP BY CUBE (f.Faculty, g.Profession, p.Subjectt)

--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '���'
      GROUP BY f.Faculty, g.Profession, p.Subjectt
UNION
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '����'
      GROUP BY f.Faculty, g.Profession, p.Subjectt

--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '���'
      GROUP BY f.Faculty, g.Profession, p.Subjectt
INTERSECT
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '����'
      GROUP BY f.Faculty, g.Profession, p.Subjectt

--------------------------------------------------------------------------
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '���'
      GROUP BY f.Faculty, g.Profession, p.Subjectt
EXCEPT
SELECT f.Faculty [���������], g.Profession [�������������], p.Subjectt [����������], 
      round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
      From FACULTY f inner join GROUPA g On f.Faculty = g.Faculty
                     inner join STUDENT s On s.IDGroup = g.IDGroup
                     inner join PROGRESS p On p.IDStudent = s.IDStudent
	Where f.Faculty = '����'
      GROUP BY f.Faculty, g.Profession, p.Subjectt

--------------------------------------------------------------------------
SELECT p1.Subjectt, p1.Note,
    (SELECT count(*) From PROGRESS p2
            Where p2.NOTE = p1.NOTE and p2.Subjectt = p1.Subjectt) [����������]
    From PROGRESS p1
    GROUP BY p1.Subjectt, p1.Note HAVING Note = 8 or Note = 9

--------------------------------------------------------------------------
--���������� ���������� ��������� � ������ ������, �� ������ ���������� � ����� � ������������ ����� ��������.
SELECT DISTINCT FACULTY.Faculty, GROUPA.IDGroup, count(STUDENT.IDStudent) as [���������� ���������]
     From FACULTY full join GROUPA On GROUPA.Faculty = FACULTY.Faculty
                  full join STUDENT On GROUPA.IDGroup = STUDENT.IDGroup
     GROUP BY ROLLUP (FACULTY.Faculty, GROUPA.IDGroup)

--���������� ���������� ��������� �� ����� � ��������� ����������� � �������� � ����� ����� ��������
SELECT AUDITORIUM_TYPE.Auditorium_Type, COUNT(AUDITORIUM.Auditorium) as [���������� ���������], 
     SUM(AUDITORIUM.Auditorium_Capacity) as [��������� �����������]
     From AUDITORIUM_TYPE inner join AUDITORIUM On AUDITORIUM_TYPE.Auditorium_Type = AUDITORIUM.Auditorium_Type
     GROUP BY ROLLUP (AUDITORIUM_TYPE.Auditorium_Type)