USE UNIVER;
SELECT isnull(TEACHER.Teacher_Name, '***') [Преподаватель], PULPIT.Pulpit[Кафедра]
   FROM PULPIT LEFT OUTER JOIN TEACHER 
   On PULPIT.Pulpit = TEACHER.Pulpit

SELECT isnull(TEACHER.Teacher_Name, '***') [Преподаватель], PULPIT.Pulpit[Кафедра]
   FROM TEACHER RIGHT OUTER JOIN PULPIT 
   On TEACHER.Pulpit = PULPIT.Pulpit
