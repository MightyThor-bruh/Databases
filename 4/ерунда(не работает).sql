USE UNIVER;
CREATE table DAYWEEK
( ID int primary key, 
  DayWeek nvarchar(20)
)

CREATE table LESSONTIME 
( LTID int primary key, 
  Beginning Time, 
  Ending Time
)

CREATE table TIMETABLE 
( ID int primary key,
  Groupa int foreign key references GROUPA(IDGroup),
  Auditorium char(20) foreign key references AUDITORIUM(Auditorium),
  Subjectt char(10) foreign key references SUBJECTT(Subjectt),
  Teacher char(10) foreign key references TEACHER(Teacher),
  DayWeek int foreign key references DAYWEEK(ID),
  Lesson_Time int foreign key references LESSONTIME(LTID)
)

INSERT into DAYWEEK (ID, DayWeek)
   values (1, 'MONDAY'),
          (2, 'TUESDAY'), 
		  (3, 'WEDNESDAY'), 
		  (4, 'THURSDAY'), 
		  (5, 'FRIDAY'),	
		  (6, 'SATURDAY'), 
		  (7, 'SUNDAY')

INSERT into LESSONTIME(LTID, Beginning, Ending)
   values (1, '8:00', '9:30'),
          (2, '9:40', '11:05'), 
		  (3, '11:25', '12:45'), 
		  (4, '13:00', '14:20'), 
		  (5, '14:40', '16:00'),	
		  (6, '16:30', '17:50'), 
		  (7, '18:05', '19:25'),
		  (8, '19:40', '21:00')

INSERT into TIMETABLE(ID, Groupa, Auditorium, Subjectt, Teacher, DayWeek, Lesson_Time)
   values (1, 22, '301-1', 'ПЗ', 'НСКВ', 1, 1),
          (2, 23, '314-4', 'ЭП', 'РЖКВ', 1, 2),
		  (3, 24, '320-4', 'ТРИ', 'ЧРН', 1, 3),
		  (4, 25, '413-1', 'СУБД', 'СМЛВ', 1, 4),
		  (5, 26, '304-4', 'ЭТ', 'КРЛВ', 1, 5)

--свободные аудитории
SELECT AUDITORIUM.AUDITORIUM_NAME, DAYWEEK.DayWeek, LESSONTIME.Beginning 
     From (AUDITORIUM CROSS JOIN LESSONTIME CROSS JOIN DAYWEEK) LEFT OUTER JOIN  TIMETABLE 
	 On AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM AND DAYWEEK.ID = TIMETABLE.DayWeek AND LESSONTIME.LTID = TIMETABLE.Lesson_Time
     where TIMETABLE.ID is null
     order by AUDITORIUM.AUDITORIUM_NAME, DAYWEEK.ID, LESSONTIME.Beginning

--занятые аудитории
SELECT AUDITORIUM.AUDITORIUM_NAME, DAYWEEK.DayWeek, LESSONTIME.Beginning, TIMETABLE.Groupa 
    From (AUDITORIUM CROSS JOIN LESSONTIME CROSS JOIN DAYWEEK) inner join TIMETABLE 
	On AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM AND LESSONTIME.LTID = TIMETABLE.Lesson_Time AND DAYWEEK.ID = TIMETABLE.DayWeek
    order by AUDITORIUM.AUDITORIUM_NAME, DAYWEEK.ID, LESSONTIME.Beginning

--окна у групп
SELECT GROUPA.IDGroup, DAYWEEK.DayWeek, LESSONTIME.Beginning 
    From (GROUPA CROSS JOIN LESSONTIME CROSS JOIN DAYWEEK) LEFT OUTER JOIN  TIMETABLE 
    On GROUPA.IDGroup = TIMETABLE.Groupa AND LESSONTIME.LTID = TIMETABLE.Lesson_Time AND DAYWEEK.ID = TIMETABLE.DayWeek
    where TIMETABLE.Groupa is null
    order by GROUPA.IDGroup, DAYWEEK.ID, LESSONTIME.Beginning

--занятые пары у студентов
SELECT GROUPA.IDGroup, DAYWEEK.DayWeek, LESSONTIME.Beginning 
    From (GROUPA CROSS JOIN LESSONTIME CROSS JOIN DAYWEEK) LEFT OUTER JOIN  TIMETABLE 
	On GROUPA.IDGroup = TIMETABLE.Groupa
    where LESSONTIME.LTID = TIMETABLE.Lesson_Time AND DAYWEEK.ID = TIMETABLE.DayWeek
    order by GROUPA.IDGroup, DAYWEEK.ID, LESSONTIME.Beginning

--окна у преподов
SELECT TEACHER.TEACHER_NAME, DAYWEEK.DayWeek, LESSONTIME.Beginning
    From (TEACHER CROSS JOIN LESSONTIME CROSS JOIN DAYWEEK) LEFT OUTER JOIN  TIMETABLE 
    On TEACHER.TEACHER = TIMETABLE.TEACHER AND LESSONTIME.LTID = TIMETABLE.Lesson_Time AND DAYWEEK.ID = TIMETABLE.DayWeek
    where TIMETABLE.Groupa is null
    order by TEACHER.TEACHER, DAYWEEK.ID, LESSONTIME.Beginning

--занятые пары у преподов
SELECT TEACHER.TEACHER_NAME, DAYWEEK.DayWeek, LESSONTIME.Beginning
    From (TEACHER CROSS JOIN LESSONTIME CROSS JOIN DAYWEEK) LEFT OUTER JOIN TIMETABLE 
    On TEACHER.TEACHER = TIMETABLE.TEACHER AND LESSONTIME.LTID = TIMETABLE.Lesson_Time AND DAYWEEK.ID = TIMETABLE.DayWeek
    where TIMETABLE.Groupa is not null
    order by TEACHER.TEACHER, DAYWEEK.ID, LESSONTIME.Beginning