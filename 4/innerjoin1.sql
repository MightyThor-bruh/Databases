USE UNIVER;
SELECT AUDITORIUM.Auditorium, AUDITORIUM_TYPE.Auditorium_TypeName 
       From AUDITORIUM INNER JOIN AUDITORIUM_TYPE
	   On AUDITORIUM.Auditorium_Type = AUDITORIUM_TYPE.Auditorium_Type

SELECT AUDITORIUM.Auditorium, AUDITORIUM_TYPE.Auditorium_TypeName 
       From AUDITORIUM INNER JOIN AUDITORIUM_TYPE
	   On AUDITORIUM.Auditorium_Type = AUDITORIUM_TYPE.Auditorium_Type And AUDITORIUM_TYPE.Auditorium_TypeName Like '%компьютер%'

--без иннер джоина
SELECT AUDITORIUM.Auditorium, AUDITORIUM_TYPE.Auditorium_TypeName 
       From AUDITORIUM, AUDITORIUM_TYPE 
	   Where AUDITORIUM.Auditorium_Type = AUDITORIUM_TYPE.Auditorium_Type

SELECT T1.Auditorium, T2.Auditorium_TypeName 
       From AUDITORIUM as T1, AUDITORIUM_TYPE as T2
	   Where T1.Auditorium_Type = T2.Auditorium_Type And T2.Auditorium_TypeName Like '%компьютер%'