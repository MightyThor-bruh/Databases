USE UNIVER;
SELECT AUDITORIUM.Auditorium, AUDITORIUM_TYPE.Auditorium_TypeName 
       From AUDITORIUM CROSS JOIN AUDITORIUM_TYPE
	   Where AUDITORIUM.Auditorium_Type = AUDITORIUM_TYPE.Auditorium_Type