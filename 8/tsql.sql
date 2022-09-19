DECLARE @a int = 3,
        @b varchar(4) = 'БГТУ',
		@c datetime = getdate(),
		@d char,
		@e time,
		@f smallint,
		@g tinyint = 1, 
		@h numeric(12,5) = 12.5;
SET @d = 'd'; SET @e = '3:12'
SELECT @a a, @b b, @c c, @d d;
print 'e= ' + cast(@e as varchar(10));
print 'f= ' + cast(@f as varchar(10));
print 'g= ' + cast(@g as varchar(10));
print 'h= ' + cast(@h as varchar(10));

----------------------------------------------------------
USE UNIVER;
DECLARE @capacity numeric(8,3) = (select cast(sum(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM),
@total int,
@avgcapacity numeric(8,3),
@totallessavg int,
@procent numeric(8,3)
if @capacity > 200
begin
	set @total = (select cast(count(*) as numeric(8,3)) from AUDITORIUM);
	set @avgcapacity = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
	set @totallessavg = (select cast(count(*) as numeric(8,3)) from AUDITORIUM where AUDITORIUM_CAPACITY < @avgcapacity);
	set @procent = @totallessavg / @total;
	select @capacity 'Общая вместимость',
	@total 'Всего аудиторий',
	@avgcapacity 'Средняя вместимость',
	@totallessavg 'Аудиторий с вместимостью ниже средней',
	@procent 'процент таких аудиторий'
end
else print 'Общая вместимость < 200'

-------------------------------------------------------------------------
print 'Число обработанных строк: ' + cast(@@rowcount as varchar);
print 'Версия SQL Server: ' + cast(@@version as varchar);
print 'Системный идентификатор процесса: ' + cast(@@spid as varchar);
print 'Код последней ошибки: ' + cast(@@error as varchar);
print 'Имя сервера: ' + cast(@@servername as varchar);
print 'Уровень вложенности транзакции: ' + cast(@@trancount as varchar);
print 'Проверка результата считывания строк результирующего набора: ' + cast(@@fetch_status as varchar);
print 'Уровень вложенности текущей процедуры: ' + cast(@@nestlevel as varchar);

---------------------------------------------------------------------------
DECLARE @t float = 10.4, @x float = 2.5, @z float 
        IF @t > @x 
		   SET @z = sin(@t)*sin(@t)
		ELSE IF @t < @x 
		   SET @z = 4*(@t + @x)
		ELSE 
		   SET @z = 1 - exp(@x-2)
SELECT @z

---------------------------------------------------------------------------
GO
CREATE FUNCTION dbo.ShortName (@nameFull nvarchar(50))  
RETURNS nvarchar(50)   
as   
begin
    DECLARE @nameShort nvarchar(50) = '',
			@symbol nchar(1),
			@i int = 1,
			@wordCount int = 0,
			@isFirstLetter int = 0;
	WHILE @i < len(@nameFull)
		begin
			SET @symbol = substring(@nameFull, @i ,1);
			IF (@symbol = ' ')
				begin
					SELECT @wordCount = @wordCount + 1, 
					@isFirstLetter = 1, 
					@nameShort = @nameShort + @symbol
				end
			ELSE IF (@isFirstLetter = 1)
				begin
					SELECT @isFirstLetter = 0, 
					@nameShort = @nameShort + @symbol
				end
			ELSE IF (@wordCount = 0)
				begin
					SELECT @nameShort = @nameShort + @symbol
				end			
			SET @i = @i + 1
		end   
    RETURN @nameShort; 
end
GO

DECLARE @fullName nvarchar(50) = 'Шумова Елизавета Игоревна',
		@shortName nvarchar(50);
SET @shortName = dbo.ShortName(@fullName)
print @shortName

--------------------------------------------------------------------------
USE UNIVER;
SELECT STUDENT.Namee, STUDENT.Bday, (datediff(YY, STUDENT.Bday, sysdatetime())) as Возраст
       From STUDENT 
	   Where month(STUDENT.BDay) = month(sysdatetime()) + 1 

--------------------------------------------------------------------------
DECLARE @groupNumber int = 23;

SELECT distinct PROGRESS.PDATE[Дата прохождения экзамена], case 
    when DATEPART(dw,PROGRESS.PDATE) = 1 then 'Понедельник'
    when DATEPART(dw,PROGRESS.PDATE) = 2 then 'Вторник'
    when DATEPART(dw,PROGRESS.PDATE) = 3 then 'Среда'
    when DATEPART(dw,PROGRESS.PDATE) = 4 then 'Четверг'
    when DATEPART(dw,PROGRESS.PDATE) = 5 then 'Пятница'
    when DATEPART(dw,PROGRESS.PDATE) = 6 then 'Суббота'
    when DATEPART(dw,PROGRESS.PDATE) = 7 then 'Воскресенье'
end [День недели]
from GROUPA inner join STUDENT on STUDENT.IDGROUP = GROUPA.IDGROUP
      inner join PROGRESS on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
  where GROUPA.IDGROUP = @groupNumber

--------------------------------------------------------------------------
DECLARE @A int = (SELECT count(*) From AUDITORIUM) 
       if @A > 50
	     begin 
		     print 'много аудиторий'
		 end
		 begin
		     print 'мало аудиторий'
		 end

---------------------------------------------------------------------------
USE UNIVER;
SELECT CASE
       when NOTE between 0 and 3 then 'hasnt passed'
       when NOTE between 4 and 5 then 'passed'
       when NOTE between 6 and 7 then 'good'
       when NOTE between 8 and 10 then 'brilliant'
       end Оценка, count(*) [Количество] 
From PROGRESS
GROUP BY CASE
      when NOTE between 0 and 3 then 'hasnt passed'
      when NOTE between 4 and 5 then 'passed'
      when NOTE between 6 and 7 then 'good'
      when NOTE between 8 and 10 then 'brilliant'
      end

----------------------------------------------------------------------------
CREATE TABLE #TEMPORARY 
(
   ID int,
   FullName varchar(100),
   City varchar(50)
);
SET nocount on;
DECLARE @i int = 0;
   While @i<1000 
   begin 
      INSERT #TEMPORARY(ID, FullName, City)
      values(FLOOR(10*rand()), REPLICATE('имя', 10), REPLICATE('город', 10));
   IF(@i % 100 = 0)
   print @i;
   SET @i = @i + 1;
   end;
   SELECT * FROM #TEMPORARY

----------------------------------------------------------------------------
DECLARE @x int = 2
  print @x+10 
  RETURN 
  print @x+4

----------------------------------------------------------------------------
begin TRY
	UPDATE PROGRESS set NOTE = 'lmao' where NOTE = 4
end try
begin CATCH
	print ERROR_NUMBER()
	print ERROR_MESSAGE()
	print ERROR_LINE()
	print ERROR_PROCEDURE()
	print ERROR_SEVERITY()
	print ERROR_STATE()
end catch

