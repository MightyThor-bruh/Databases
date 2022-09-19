USE examnotes;
SELECT SUBJECTT.Subject_Name [Предмет], EXAMENATOR.Examenator_Name [Экзаменатор]
   FROM EXAMENATOR FULL OUTER JOIN EXAM On EXAM.ExID = EXAMENATOR.ExID
                   FULL OUTER JOIN SUBJECTT On SUBJECTT.SubID = EXAM.SubID

SELECT SUBJECTT.Subject_Name [Предмет (left outer)], EXAMENATOR.Examenator_Name [Экзаменатор (left outer)]
   FROM EXAMENATOR LEFT OUTER JOIN EXAM on EXAM.ExID = EXAMENATOR.ExID
                   LEFT OUTER JOIN SUBJECTT on SUBJECTT.SubID = EXAM.SubID

SELECT SUBJECTT.Subject_Name [Предмет (right outer)], EXAMENATOR.Examenator_Name [Экзаменатор (right outer)] 
   FROM EXAMENATOR RIGHT OUTER JOIN EXAM on EXAM.ExID = EXAMENATOR.ExID
                   RIGHT OUTER JOIN SUBJECTT on SUBJECTT.SubID = EXAM.SubID

SELECT SUBJECTT.Subject_Name [Предмет], EXAMENATOR.Examenator_Name [Преподаватель]
   FROM EXAMENATOR INNER JOIN EXAM on EXAM.ExID = EXAMENATOR.ExID                           
                   INNER JOIN SUBJECTT on SUBJECTT.SubID = EXAM.SubID

--содержит данные левой и не содержит данные правой
SELECT SUBJECTT.Subject_Name [Предмет], EXAMENATOR.Examenator_Name [Преподаватель]
   FROM SUBJECTT FULL OUTER JOIN EXAM on SUBJECTT.SubID = EXAM.SubID                           
                 FULL OUTER JOIN EXAMENATOR on EXAM.ExID = EXAMENATOR.ExID
				 where EXAM.SubID is NULL

--содержит данные правой и не содержит данные левой
SELECT SUBJECTT.Subject_Name [Предмет], EXAMENATOR.Examenator_Name [Преподаватель]
   FROM SUBJECTT FULL OUTER JOIN EXAM on SUBJECTT.SubID = EXAM.SubID                           
                 FULL OUTER JOIN EXAMENATOR on EXAM.ExID = EXAMENATOR.ExID
				 where EXAM.ExID is NULL

SELECT SUBJECTT.Subject_Name [Предмет], EXAMENATOR.Examenator_Name [Преподаватель]
   FROM SUBJECTT FULL OUTER JOIN EXAM on SUBJECTT.SubID = EXAM.SubID                           
                 FULL OUTER JOIN EXAMENATOR on EXAM.ExID = EXAMENATOR.ExID
				 where EXAM.SubID is not NULL and EXAM.ExID is not NULL