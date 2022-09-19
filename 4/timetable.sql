USE UNIVER;
CREATE table TIMETABLE 
(  IDGroup int foreign key references GROUPA(IDGroup),
   Auditorium char(20) foreign key references AUDITORIUM(Auditorium),
   Subjectt char(10) foreign key references SUBJECTT(Subjectt),
   Teacher char(10) foreign key references TEACHER(Teacher),
   DayWeek date,
   Class int
)

 INSERT into TIMETABLE(IDGroup, Auditorium, Subjectt, Teacher, DayWeek, Class)
   values (22, '301-1', '��', '����', '14.03.2022', 1),
          (23, '314-4', '��', '����', '15.03.2022', 2),
		  (24, '320-4', '���', '���', '16.03.2022', 3),
		  (25, '413-1', '����', '����', '17.03.2022', 4),
		  (26, '304-4', '��', '����', '18.03.2022', 5)

--��������� ���������
SELECT AUDITORIUM.Auditorium, SUBJECTT.Subjectt_Name, TEACHER.Teacher_Name, GROUPA.IDGroup, GROUPA.Faculty
   FROM TIMETABLE FULL JOIN SUBJECTT On TIMETABLE.Subjectt = SUBJECTT.Subjectt
                  FULL JOIN AUDITORIUM On TIMETABLE.Auditorium = AUDITORIUM.Auditorium
				  FULL JOIN TEACHER On TIMETABLE.Teacher = TEACHER.Teacher
				  FULL JOIN GROUPA On TIMETABLE.IDGroup = GROUPA.IDGroup
   Where SUBJECTT.Subjectt_Name is null AND TEACHER.Teacher_Name is null AND GROUPA.IDGroup is null


--���� � ��������
SELECT AUDITORIUM.Auditorium, SUBJECTT.Subjectt_Name, TEACHER.Teacher_Name, GROUPA.IDGroup, GROUPA.Faculty
   FROM TIMETABLE FULL JOIN SUBJECTT On TIMETABLE.Subjectt = SUBJECTT.Subjectt
                  FULL JOIN AUDITORIUM On TIMETABLE.Auditorium = AUDITORIUM.Auditorium
				  FULL JOIN TEACHER On TIMETABLE.Teacher = TEACHER.Teacher
				  FULL JOIN GROUPA On TIMETABLE.IDGroup = GROUPA.IDGroup
   Where AUDITORIUM.Auditorium is null AND SUBJECTT.Subjectt_Name is null AND GROUPA.IDGroup is null


--���� � ���������
SELECT AUDITORIUM.Auditorium, SUBJECTT.Subjectt_Name, TEACHER.Teacher_Name, GROUPA.IDGroup, GROUPA.Faculty
   FROM TIMETABLE FULL JOIN SUBJECTT On TIMETABLE.Subjectt = SUBJECTT.Subjectt
                  FULL JOIN AUDITORIUM On TIMETABLE.Auditorium = AUDITORIUM.Auditorium
				  FULL JOIN TEACHER On TIMETABLE.Teacher = TEACHER.Teacher
				  FULL JOIN GROUPA On TIMETABLE.IDGroup = GROUPA.IDGroup
   Where AUDITORIUM.Auditorium is null AND SUBJECTT.Subjectt_Name is null AND TEACHER.Teacher_Name is null