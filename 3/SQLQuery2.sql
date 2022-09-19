USE SH_MyBase;
CREATE table ОБОРУДОВАНИЕ
( Название_оборудования nvarchar(50) primary key, 
  Дата_поступления date not null, 
  Количество int not null,
  Дата_списания date not null,
  Причина_списания nvarchar(50) not null
) on FG1;
CREATE table СОТРУДНИКИ 
( id_ответственного int primary key,
  Фамилия nvarchar(50) not null,
  Имя nvarchar(20) not null,
  Отчество nvarchar(50),
  Должность nvarchar(50) not null,
  Дата_приема_на_работу date not null
) on FG1;
CREATE table ОТДЕЛ 
( Подразделение nvarchar(50) primary key,
  Тип_оборудования nvarchar(50) not null foreign key references ОБОРУДОВАНИЕ(Название_оборудования),
  Код_сотрудника int not null foreign key references СОТРУДНИКИ(id_ответственного)
) on FG1;
ALTER table ОТДЕЛ ADD Количество int;
SELECT * FROM ОТДЕЛ;
ALTER table ОТДЕЛ DROP CONSTRAINT UQ__ОТДЕЛ__F11B377B2F8DCC68;
ALTER table ОТДЕЛ DROP COLUMN Количество;