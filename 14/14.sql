USE UNIVER;
drop trigger TR_TEACHER_INS;
drop trigger TR_TEACHER_DEL;
drop trigger TR_TEACHER_UPD;
drop trigger TR_TEACHER;
drop trigger TR_TEACHER_DEL1;
drop trigger TR_TEACHER_DEL2;
drop trigger TR_TEACHER_DEL3;
drop trigger TRAN_TRIG;
drop trigger FAC_INSTEAD_TRIGGER;
drop trigger DDL_UNIVER;

GO

CREATE TABLE TR_AUDIT 
(
   ID int identity, --íîìåğ
   STMT varchar(20) check(STMT in ('INS', 'DEL', 'UPD')),  --äìë îïåğàòîğ
   TRNAME varchar(50),  --èìÿ òğèããåğà
   CC varchar(300) --êîììåíòàğèé
)

GO
CREATE TRIGGER TR_TEACHER_INS On TEACHER after INSERT
as
begin
  DECLARE @id char(10), @name varchar(100), @gndr char(1), @pulp char(20), @all nvarchar(300);
  set @id = rtrim((SELECT [Teacher] From inserted));
  set @name = (SELECT [Teacher_Name] From inserted);
  set @gndr = (SELECT [Gender] From inserted);
  set @pulp = (SELECT [Pulpit] From inserted);
  set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));
  INSERT INTO TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_TEACHER_INS',@all)
  return
end

GO
insert into TEACHER(Teacher, Teacher_Name, Gender, Pulpit) values
                   ('ØÌÂ', 'Øóìîâà Åëèçàâåòà Èãîğåâíà', 'æ', 'ĞÈÒ')

SELECT * From TR_AUDIT

-----------------------------------------task 2-------------------------------------------------------------

GO
CREATE TRIGGER TR_TEACHER_DEL On TEACHER after DELETE
as
begin
  DECLARE @id char(10), @name varchar(100), @gndr char(1), @pulp char(20), @all nvarchar(300);
  set @id = rtrim((SELECT [Teacher] From deleted));
  set @name = (SELECT [Teacher_Name] From deleted);
  set @gndr = (SELECT [Gender] From deleted);
  set @pulp = (SELECT [Pulpit] From deleted);
  set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));
  INSERT INTO TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_INS',@all)
  return
end

GO
DELETE TEACHER where Teacher_Name = 'Øóìîâà Åëèçàâåòà Èãîğåâíà'

SELECT * From TR_AUDIT

-----------------------------------------task 3-------------------------------------------------------------

GO
CREATE TRIGGER TR_TEACHER_UPD On TEACHER after UPDATE
as
begin
  DECLARE @id char(10), @name varchar(100), @gndr char(1), @pulp char(20), @all nvarchar(300);
  --DECLARE @id_ char(10), @name_ varchar(100), @gndr_ char(1), @pulp_ char(20), @all_ nvarchar(300);
  set @id = rtrim((SELECT [Teacher] From inserted));
  set @name = (SELECT [Teacher_Name] From inserted);
  set @gndr = (SELECT [Gender] From inserted);
  set @pulp = (SELECT [Pulpit] From inserted);
  set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));

  set @id = rtrim((SELECT [Teacher] From deleted));
  set @name = (SELECT [Teacher_Name] From deleted);
  set @gndr = (SELECT [Gender] From deleted);
  set @pulp = (SELECT [Pulpit] From deleted);
  set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));
  INSERT INTO TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_TEACHER_UPD',@all)
  return
end

GO
UPDATE TEACHER set Teacher_Name = '×ûâôàààà' where Teacher = 'ØÌÂ'
SELECT * From TR_AUDIT

drop trigger TR_TEACHER_UPD

-----------------------------------------task 4-------------------------------------------------------------

GO
CREATE TRIGGER TR_TEACHER On TEACHER after INSERT, DELETE, UPDATE
as
  DECLARE @id char(10), @name varchar(100), @gndr char(1), @pulp char(20), @all nvarchar(300);
  DECLARE @ins int = (SELECT count(*) from inserted), @del int = (SELECT count(*) from deleted); 
  if  @ins > 0 and  @del = 0  

  begin
     print 'Ñîáûòèå: INSERT';
	 set @id = rtrim((SELECT [Teacher] From inserted));
     set @name = (SELECT [Teacher_Name] From inserted);
     set @gndr = (SELECT [Gender] From inserted);
     set @pulp = (SELECT [Pulpit] From inserted);
     set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));
	 INSERT INTO TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_INS',@all);
   end;
   
   else 
   if @ins = 0 and  @del > 0  

  begin
     print 'Ñîáûòèå: DELETE';
	 set @id = rtrim((SELECT [Teacher] From deleted));
     set @name = (SELECT [Teacher_Name] From deleted);
     set @gndr = (SELECT [Gender] From deleted);
     set @pulp = (SELECT [Pulpit] From deleted);
     set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));
     INSERT INTO TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_INS',@all);
  end;

  else
  if @ins > 0 and  @del > 0  

  begin
      print 'Ñîáûòèå: UPDATE'; 
	  set @id = rtrim((SELECT [Teacher] From inserted));
      set @name = (SELECT [Teacher_Name] From inserted);
      set @gndr = (SELECT [Gender] From inserted);
      set @pulp = (SELECT [Pulpit] From inserted);
      set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20));

      set @id = rtrim((SELECT [Teacher] From deleted));
      set @name = (SELECT [Teacher_Name] From deleted);
      set @gndr = (SELECT [Gender] From deleted);
      set @pulp = (SELECT [Pulpit] From deleted);
      set @all = cast(@id as varchar(20)) + ' ' + @name + ' ' + cast(@gndr as varchar(20)) + ' ' + cast(@pulp as varchar(20)) + ' ' + @all;
      INSERT INTO TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_TEACHER_UPD',@all);
  end;
  return;

GO
insert into TEACHER (Teacher, Teacher_Name, Gender, Pulpit) values
			('ÏÏÊ','Ïóïêèí Âàñèëèé Èâàíîâè÷','æ','ĞÈÒ')
update TEACHER set Teacher = 'ÏÏÊÍ' where Teacher = 'ÏÏÊ'
delete TEACHER where Teacher = 'ÏÏÊÍ'

SELECT * from TR_AUDIT

drop table TR_AUDIT

-----------------------------------------task 5-------------------------------------------------------------

insert into TEACHER (Teacher, Teacher_Name, Gender, Pulpit) values
('ÁÌ','Îáàìà Áàğàê','6543','ĞÈÒ')

SELECT * from TR_AUDIT

-----------------------------------------task 6-------------------------------------------------------------

GO
CREATE TRIGGER TR_TEACHER_DEL1 On TEACHER after DELETE
as
   begin
      print 'Òğèããåğ 1';
	  DECLARE @a nvarchar(50) = (SELECT Teacher from deleted)
	  insert into TR_AUDIT values
		('DEL','TR_TEACHER_DEL1',@a)
	end
GO

GO
CREATE TRIGGER TR_TEACHER_DEL2 On TEACHER after DELETE
as
   begin
      print 'Òğèããåğ 2';
	  DECLARE @a nvarchar(50) = (SELECT Teacher from deleted)
	  insert into TR_AUDIT values
		('DEL','TR_TEACHER_DEL2',@a)
	end
GO

GO
CREATE TRIGGER TR_TEACHER_DEL3 On TEACHER after DELETE
as
   begin
      print 'Òğèããåğ 3';
	  DECLARE @a nvarchar(50) = (SELECT Teacher from deleted)
	  insert into TR_AUDIT values
		('DEL','TR_TEACHER_DEL3',@a)
	end
GO

exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL3', @order = 'First', @stmttype = 'DELETE';
exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL2', @order = 'Last', @stmttype = 'DELETE';

insert into TEACHER (Teacher, Teacher_Name, Gender, Pulpit) values
('ËÍÑÒĞ','Ëàííèñòåğ Ñåğñåÿ','æ','ĞÈÒ')
DELETE TEACHER where Teacher = 'ËÍÑÒĞ';

SELECT * from TR_AUDIT

SELECT t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
	                                                                        e.type_desc = 'DELETE' ; 

-----------------------------------------task 7-------------------------------------------------------------

GO
CREATE TRIGGER TRAN_TRIG On TEACHER after INSERT, DELETE, UPDATE
as
  begin
     DECLARE @count int = (SELECT count(*) From TEACHER)
	 if (@count > 10)
	    begin 
		   raiserror('Ïğåïîäàâàòåëåé ñëèøêîì ìíîãî äëÿ ñîçäàíèÿ òğèããåğà',10,1);
		   rollback;
		end;
	return;
	end;
GO

insert into TEACHER (Teacher, Teacher_Name, Gender, Pulpit) values
('ÑÍ','Ñíîó Äæîí','ì','ĞÈÒ')

-----------------------------------------task 8-------------------------------------------------------------

GO
CREATE TRIGGER FAC_INSTEAD_TRIGGER On FACULTY instead of DELETE
as
  raiserror (N'Óäàëåíèå çàïğåùåíî', 10, 1);
return
GO

DELETE From FACULTY where Faculty = 'ÕÒèÒ';
SELECT * from TR_AUDIT

-----------------------------------------task 9-------------------------------------------------------------

GO
CREATE TRIGGER DDL_UNIVER On database for DDL_DATABASE_LEVEL_EVENTS
as
  DECLARE @t1 varchar(50), @t2 varchar(50), @t3 varchar(50);
	set @t1 = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)');
	set @t2 = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(50)');
	set @t3 = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(50)');

	print 'Òèï ñîáûòèÿ: ' + @t1;
	print 'Èìÿ îáúåêòà: ' + @t2;
	print 'Òèï îáúåêòà: ' + @t3;

	raiserror ('Èçìåíåíèå áàçû äàííûõ çàïğåùåíî!',10,1);
    rollback;
return;
GO

CREATE TABLE NewTable
(
id int primary key,
line varchar(300)
);

-----------------------------------------task 10-------------------------------------------------------------

CREATE TABLE Weather
(
city varchar(30),
startdate DATETIME,
enddate DATETIME,
temp NUMERIC
);

GO
CREATE TRIGGER WEATHER_TRIG On Weather for INSERT, UPDATE
as
  DECLARE @city varchar(30), @startdate DATETIME, @enddate DATETIME, @temp NUMERIC, @error varchar(300);
  set @city = (SELECT city from inserted);
  set @startdate = (SELECT startdate from inserted);
  set @enddate = (SELECT enddate from inserted);
  set @temp = (SELECT temp from inserted);
  if (exists 
     (SELECT * from Weather where (startdate >=  @startdate AND startdate <= @enddate) OR (enddate >= @startdate AND enddate <= @enddate) 
      except SELECT * from INSERTED))
      begin
	      set @error = 'Íå óäàëîñü âûïîëíèòü INSERT ' + @city + ' ' + cast(@startdate as varchar(20)) + ' ' + 
	      cast(@enddate as varchar(20)) + ' ' + cast(@temp as varchar(10)) + 'Äàííûå óæå ñóùåñòâóşò' 

	      raiserror(@error, 10, 1);
	  rollback;
      end;
return
GO

select * from Weather order by enddate

delete from Weather

insert into Weather values
('Ìèíñê', '20210101 12:00', '20210101 23:59', 13)

insert into Weather values
('Ìèíñê', '20210101 00:00', '20210101 11:59', 7)

insert into Weather values
('Ìèíñê', '20210101 00:00', '20210101 02:00', 7)