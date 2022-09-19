USE UNIVER;
GO
CREATE PROCEDURE PSUBJECT
as 
  begin
     DECLARE @k int=(SELECT count(*) From SUBJECTT);
     SELECT Subjectt [Код], Subjectt_Name [Дисциплина], Pulpit [Кафедра] from SUBJECTT;
     return @k;
  end;
GO
DECLARE @y int = 0;
EXEC @y = PSUBJECT;
print 'количество строк: ' + cast(@y as varchar(3));

drop procedure PSUBJECT;

------------------------------------------------------------------------------------------------------------

CREATE TABLE #SUBJECT 
( 
   Subjectt nvarchar(20),
   Subjectt_Name nvarchar(50),
   Pulpit nvarchar(20)
)

GO
ALTER procedure PSUBJECT @p varchar(20) = null 
as
begin 
     SELECT Subjectt [Код], Subjectt_Name[Дисциплина], Pulpit [Кафедра] from SUBJECTT where Pulpit = @p;
end;
GO

GO 
INSERT #SUBJECT exec PSUBJECT @p = 'РИТ';
INSERT #SUBJECT exec PSUBJECT @p = 'ЭТиМ';
SELECT * From #SUBJECT;
GO
 
DROP table #SUBJECT;

-----------------------------------------------------------------------------------------------------------
USE UNIVER;
GO

CREATE PROCEDURE PAUDITORIUM_INSERT @a char(20), @n varchar(50), @t char(10), @c int = 0
as 
begin
    begin try
          INSERT into AUDITORIUM(Auditorium, Auditorium_Name, Auditorium_Capacity, Auditorium_Type)
          values(@a, @n, @c, @t)
          return 1;
    end try
    begin catch
          print cast(error_number() as varchar(10));
	      print cast(error_severity() as varchar(6));
	      print error_message();
	      return -1;
    end catch
end
GO
declare @rc int;  
exec @rc = PAUDITORIUM_INSERT @a  = '206-1', @n = '206-1', @c = 90, @t = 'ЛК';  
print 'код ошибки : ' + cast(@rc as varchar(3)); 

-----------------------------------------------------------------------------------------------------------
USE UNIVER;
GO

CREATE PROCEDURE SUBJECT_REPORT @p nvarchar(10)
as
begin
DECLARE @counter int = 0;
begin try 
   DECLARE @sub nvarchar(10), @line_sub nvarchar(500) = ''
   DECLARE SUBJECTS cursor local static for
   SELECT Subjectt From SUBJECTT where Pulpit = @p
   if not exists (SELECT Pulpit From SUBJECTT where Pulpit = @p)
   begin
      raiserror('ошибка! Таких кафедр нет', 11, 1);
   end
   else
   begin
      open SUBJECTS;
	  fetch SUBJECTS into @sub
	  set @line_sub = trim(@sub)
	  set @counter +=1
	  fetch SUBJECTS into @sub
	  while @@FETCH_STATUS = 0
	  begin 
	       set @line_sub = '' + trim(@sub) + ', ' + @line_sub
		   set @counter +=1
		   fetch SUBJECTS into @sub
	  end
	  print 'Предметы на кафедре ' + @p + ': ' + @line_sub
	  return @counter
	end
end try
begin catch
        print 'Ошибка в параметрах' 
        if error_procedure() is not null   
			print 'Имя процедуры : ' + error_procedure()
        return @counter
end catch
end
GO

declare @c int
exec @c =  SUBJECT_REPORT @p = 'ХТЭПиМЭЕ'
print 'Количество предметов на специальности: ' + cast(@c as nvarchar)

drop procedure SUBJECT_REPORT;

-----------------------------------------------------------------------------------------------------------
USE UNIVER;
GO

CREATE PROCEDURE PAUDITORIUM_INSERTX @a_ char(20), @n_ varchar(50), @c_ int = 0, @t_ char(10), @tn_ varchar(50)
as
begin
	DECLARE @err nvarchar(50) = 'Ошибка: '
	DECLARE @rez int
		set transaction isolation level serializable
			begin tran
				begin try
					INSERT into AUDITORIUM_TYPE values (@t_, @tn_)
						exec @rez = PAUDITORIUM_INSERT @a = @a_, @n = @n_, @c = @c_, @t = @t_
						if (@rez = -1)
							begin
								return -1
							end
				end try
				begin catch
					set @err = @err + error_message()
					raiserror(@err, 11, 1)
					rollback
					return -1
				end catch
			commit tran
		return 1
end
GO

DECLARE @rez int
begin tran
exec @rez = PAUDITORIUM_INSERTX @a_ = '208-1', @n_ = '208-1', @c_ = 90, @t_ = '208-1', @tn_ = 'SDGHFD' 
print @rez
if @rez = 1
	SELECT * From AUDITORIUM
	SELECT * From AUDITORIUM_TYPE
rollback
GO

-----------------------------------------------------------------------------------------------------------

GO
CREATE PROCEDURE PFACULTY_REPORT @f char(10) = null, @p char(10) = null
as
begin
	DECLARE @faculty nvarchar(10), @pulpitcount int, @i int = 0
	DECLARE @pulpitName nvarchar(50), @teacherCount int, @j int = 0
	DECLARE @subjectName nvarchar(15), @subjectline nvarchar(150) = '', @subjectPulpit nvarchar(50)

	DECLARE facultyCount cursor local dynamic
	for
	SELECT FACULTY.FACULTY, count(*) from FACULTY
		   inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY order by FACULTY.FACULTY asc

	DECLARE pulpits cursor local dynamic
	for
	SELECT PULPIT.PULPIT, count(*) from PULPIT
		   left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
		   group by FACULTY, PULPIT.PULPIT
		   order by FACULTY asc

	DECLARE @rezcount int = 0

	open facultyCount
	open pulpits

		if (@f is null AND @p is null)
		begin
			fetch from facultyCount into @faculty, @pulpitcount
			print 'Факультет: ' + @faculty

			while @@FETCH_STATUS = 0
			begin
				set @i = 0
					while @i < @pulpitcount
						begin
							set @subjectline = ''
							fetch from pulpits into @pulpitName,@teacherCount
							print char(9) + 'Кафедра: ' + @pulpitName
							print char(9) + char(9) + 'Количество преподавателей: ' + cast(@teacherCount as nvarchar(10))
							exec PSubject @p = @pulpitName
							set @i = @i + 1
						end

				fetch from facultyCount into @faculty, @pulpitcount
				if (@@FETCH_STATUS = 0)
					print 'Факультет: ' + @faculty
					set @rezcount = @rezcount + 1
			end

		return @rezcount
		end

		if(@p is not null)
		begin
			if (@p not in (select PULPIT from PULPIT))
			begin
				raiserror('Кафедра не найдена', 11, 1)
				return -1
			end
			fetch from facultyCount into @faculty, @pulpitcount
			if (@p in (SELECT PULPIT from FACULTY
							  inner join PULPIT on PULPIT.FACULTY = FACULTY.FACULTY
							  where FACULTY.FACULTY = @faculty))
			begin
				begin
					set @i = 0
		
						while @i < @pulpitcount
							begin
								set @subjectline = ''
								fetch from pulpits into @pulpitName,@teacherCount
								if (@pulpitName = @p)
									begin
										print char(9) + 'Кафедра: ' + @pulpitName
										print char(9) + char(9) + 'Количество преподавателей: ' + cast(@teacherCount as nvarchar(10))
										exec @rezcount = PSubject @p = @pulpitName
										return @rezcount
									end
							end


					fetch from facultyCount into @faculty, @pulpitcount
					if (@@FETCH_STATUS = 0)
						print 'Факультет: ' + @faculty
						return @pulpitCount
			
				end
			end
		while (@@FETCH_STATUS = 0)
		begin
			fetch from facultyCount into @faculty, @pulpitcount
			if (@p in (SELECT PULPIT from FACULTY
							  inner join PULPIT on PULPIT.FACULTY = FACULTY.FACULTY
							  where FACULTY.FACULTY = @faculty))
			begin
				begin
				set @i = 0
		
				while @i < @pulpitcount
					begin
						set @subjectline = ''
						fetch from pulpits into @pulpitName,@teacherCount
						if (@pulpitName = @p)
						begin
							print char(9) + 'Кафедра: ' + @pulpitName
							print char(9) + char(9) + 'Количество преподавателей: ' + cast(@teacherCount as nvarchar(10))
							exec @rezcount = PSubject @p = @pulpitName
							return @rezcount
						end
					end 


			fetch from facultyCount into @faculty, @pulpitcount
			if (@@FETCH_STATUS = 0) print 'Факультет: ' + @faculty
			return @pulpitCount
			
				end
			end
		end		
	end
	
	close facultyCount
	close pulpits

end
GO

DECLARE @rez int
exec @rez = PFACULTY_REPORT 
print 'Код процедуры: ' + cast (@rez as nvarchar(10)) 
GO

DECLARE @rez int
exec @rez = PFACULTY_REPORT @p = 'ИСиТ'
print 'Код процедуры: ' + cast (@rez as nvarchar(10)) 
GO

DECLARE @rez int
exec @rez = PFACULTY_REPORT @p = 'qwerty'
print 'Код процедуры: ' + cast (@rez as nvarchar(10)) 
GO







go
create procedure aud_proc @number char(10)
as
  begin 
  declare @type int = (select count(Auditorium_Type) from AUDITORIUM);
  select Auditorium [Номер аудитории], Auditorium_TypeName [Имя аудитории] From AUDITORIUM inner join AUDITORIUM_TYPE
    On AUDITORIUM.Auditorium_Type = Auditorium_Type.Auditorium_Type where AUDITORIUM.Auditorium = @number;
  return @type;
  end;
go

declare @aud_type int;
exec @aud_type = aud_proc @number = '301-1';
print ' ' + cast(@aud_type as varchar(10))
 
drop procedure aud_proc;


go
create function aud_func(@number char(10)) returns table
as
  return 
  select Auditorium [Номер аудитории], Auditorium_TypeName [Имя аудитории] From AUDITORIUM inner join AUDITORIUM_TYPE
    On AUDITORIUM.Auditorium_Type = Auditorium_Type.Auditorium_Type where AUDITORIUM.Auditorium = @number;
go

select * from dbo.aud_func('301-1');


go
create trigger insert_trig On AUDITORIUM_TYPE after INSERT
as
  begin
  declare @type char(10), @name varchar(30);
  set @type = (SELECT Auditorium_Type [Тип аудитории] from inserted);
  set @name = (SELECT Auditorium_TypeName [Имя аудитории] from inserted);
  insert into AUDITORIUM_TYPE(Auditorium_Type, Auditorium_TypeName) values ('1', '2');
  return;
  end;
go

insert into AUDITORIUM_TYPE(Auditorium_Type, Auditorium_TypeName) values ('helloooooo', 'world');
select * from AUDITORIUM_TYPE;

drop trigger insert_trig