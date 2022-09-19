CREATE TABLE Table1  (Id INT IDENTITY, Value INT)

INSERT INTO Table1 (Value) VALUES(1)

----------------------------4-5-------------------------------

BEGIN TRAN;
--t1

UPDATE Table1
SET Value = Value * 10
WHERE Id = 1;

WAITFOR DELAY '00:00:10';

ROLLBACK;
--t2

SELECT Value 
FROM Table1
WHERE Id = 1;

----------------------------6-------------------------------

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN;
--t1

SELECT Value 
FROM Table1
WHERE Id = 1;

WAITFOR DELAY '00:00:10';
--t2

SELECT Value 
FROM Table1
WHERE Id = 1;

COMMIT;

----------------------------7-------------------------------

--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE  
BEGIN TRAN;
--t1

SELECT * FROM Table1  

WAITFOR DELAY '00:00:10'  
--t2

SELECT * FROM Table1

COMMIT;