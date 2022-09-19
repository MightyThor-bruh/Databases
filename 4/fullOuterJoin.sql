USE examnotes;
SELECT SUBJECTT.Subject_Name [�������], EXAMENATOR.Examenator_Name [�����������]
   FROM EXAMENATOR FULL OUTER JOIN EXAM On EXAM.ExID = EXAMENATOR.ExID
                   FULL OUTER JOIN SUBJECTT On SUBJECTT.SubID = EXAM.SubID

SELECT SUBJECTT.Subject_Name [������� (left outer)], EXAMENATOR.Examenator_Name [����������� (left outer)]
   FROM EXAMENATOR LEFT OUTER JOIN EXAM on EXAM.ExID = EXAMENATOR.ExID
                   LEFT OUTER JOIN SUBJECTT on SUBJECTT.SubID = EXAM.SubID

SELECT SUBJECTT.Subject_Name [������� (right outer)], EXAMENATOR.Examenator_Name [����������� (right outer)] 
   FROM EXAMENATOR RIGHT OUTER JOIN EXAM on EXAM.ExID = EXAMENATOR.ExID
                   RIGHT OUTER JOIN SUBJECTT on SUBJECTT.SubID = EXAM.SubID

SELECT SUBJECTT.Subject_Name [�������], EXAMENATOR.Examenator_Name [�������������]
   FROM EXAMENATOR INNER JOIN EXAM on EXAM.ExID = EXAMENATOR.ExID                           
                   INNER JOIN SUBJECTT on SUBJECTT.SubID = EXAM.SubID

--�������� ������ ����� � �� �������� ������ ������
SELECT SUBJECTT.Subject_Name [�������], EXAMENATOR.Examenator_Name [�������������]
   FROM SUBJECTT FULL OUTER JOIN EXAM on SUBJECTT.SubID = EXAM.SubID                           
                 FULL OUTER JOIN EXAMENATOR on EXAM.ExID = EXAMENATOR.ExID
				 where EXAM.SubID is NULL

--�������� ������ ������ � �� �������� ������ �����
SELECT SUBJECTT.Subject_Name [�������], EXAMENATOR.Examenator_Name [�������������]
   FROM SUBJECTT FULL OUTER JOIN EXAM on SUBJECTT.SubID = EXAM.SubID                           
                 FULL OUTER JOIN EXAMENATOR on EXAM.ExID = EXAMENATOR.ExID
				 where EXAM.ExID is NULL

SELECT SUBJECTT.Subject_Name [�������], EXAMENATOR.Examenator_Name [�������������]
   FROM SUBJECTT FULL OUTER JOIN EXAM on SUBJECTT.SubID = EXAM.SubID                           
                 FULL OUTER JOIN EXAMENATOR on EXAM.ExID = EXAMENATOR.ExID
				 where EXAM.SubID is not NULL and EXAM.ExID is not NULL