CREATE table  #EXPLRE
 (    TIND int,  
      TFIELD varchar(100) 
  );
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 1000
begin
    INSERT #EXPLRE(TIND, TFIELD)
	     values(floor(20000*rand()), replicate('string', 10));
	IF(@i % 100 = 0) print @i;
	SET @i = @i + 1;
end;

SELECT * FROM #EXPLRE where TIND between 1500 and 2500 order by TIND 

checkpoint;  --фиксация БД
 DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

CREATE clustered index #EXPLRE_CL on #EXPLRE(TIND asc) 
DROP index #EXPLRE_CL on #EXPLRE

----------------------------------------------------------

CREATE index #EXPLRE_NONCLU on #EXPLRE(TIND, TFIELD);
SELECT * From #EXPLRE order by TIND, TFIELD
SELECT * From #EXPLRE where TIND = 556;
DROP index #EXPLRE_NONCLU on #EXPLRE

----------------------------------------------------------
CREATE table #tb 
(
     tkey int, 
	 cc int identity(1,1), 
	 tf varchar(100)
	 )                 --некластеризованный индекс покрытия (включает значения одного или нескольких неиндексированных столбцов)
SET nocount on
DECLARE @k int = 0
while @k < 10000
begin
	INSERT #tb(tkey, tf) values (floor(30000*rand()), replicate('hello', 10))
	IF (@k % 100 = 0) print @k;
	SET @k = @k + 1
end

SELECT * From #tb

CREATE index #tb_tkey_x on #tb(tkey) include (cc) 

SELECT cc From #tb where tkey > 15000

DROP index #tb_tkey_x on #tb

---------------------------------------------------------------------------

SELECT tkey From #tb where tkey between 5000 and 10000 --некластеризованный фильтруемый индекс (если запрос на where фильтрации строк)
SELECT tkey From #tb where tkey > 3000 and tkey < 5000
SELECT tkey From #tb where tkey = 1000

CREATE index #tb_where on #tb(tkey) where (tkey >= 3000 and tkey <= 5000)

DROP index #tb_where on #tb

----------------------------------------------------------------------------

CREATE index #tb_tkey on #tb(tkey)

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)] --степень фрагментации индекса
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#tb'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;

INSERT top(10000000) #tb(tkey, tf) SELECT tkey, tf From #tb

ALTER index #tb_tkey on #tb reorganize --реорганизация

ALTER index #tb_tkey on #tb rebuild with (online = off) --(меняет ветки местами) проходит через все дерево => фрагм=0

-----------------------------------------------------------------------------

DROP index #tb_tkey on #tb 
--процент заполнения индексных страниц нижнего уровня

CREATE index #tb_tkey on #tb(tkey) with fillfactor = 65

INSERT top(50) percent #tb(tkey, tf) SELECT tkey, tf from #tb

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        from sys.dm_db_index_physical_stats(db_id(N'TEMPDB'), 
        object_id(N'#tb'), NULL, NULL, NULL) ss
        join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;



use univer;

SELECT Note From PROGRESS where Note > 5

CREATE index #student_index on PROGRESS(Note) where Note > 5

drop index #student_index on PROGRESS