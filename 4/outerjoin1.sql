USE UNIVER;
SELECT isnull(TEACHER.Teacher_Name, '***') [�������������], PULPIT.Pulpit[�������]
   FROM PULPIT LEFT OUTER JOIN TEACHER 
   On PULPIT.Pulpit = TEACHER.Pulpit

SELECT isnull(TEACHER.Teacher_Name, '***') [�������������], PULPIT.Pulpit[�������]
   FROM TEACHER RIGHT OUTER JOIN PULPIT 
   On TEACHER.Pulpit = PULPIT.Pulpit
