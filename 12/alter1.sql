USE [UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 03.05.2022 15:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = NULL, @c int output
as 
  begin
     DECLARE @k int=(SELECT count(*) From SUBJECTT where Pulpit = @p);
	 print 'Параметры: @p = ' + @p + ', @c = ' + cast(@c as varchar(3));
     SELECT Subjectt [Код], Subjectt_Name [Дисциплина], Pulpit [Кафедра] from SUBJECTT where Pulpit = @p;
	 set @c = @@ROWCOUNT;
     return @k;
  end;

DECLARE @y int = 0, @z varchar(20) = 'РИТ', @w int = 0;
EXEC @y = PSUBJECT @p = @z, @c = @w output
print 'Всего строк: ' + cast(@y as nvarchar)
print 'Строк с факультетом ' + @z + ': '+ cast(@w as nvarchar)