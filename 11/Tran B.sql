----------------------------4-5-------------------------------

--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRAN;
--t1

SELECT Value 
FROM Table1
WHERE Id = 1;

COMMIT TRAN;

----------------------------6-------------------------------

BEGIN TRAN;
--t1

UPDATE Table1 
SET Value = 42
WHERE Id = 1;
--t2

COMMIT TRAN;

----------------------------7-------------------------------

BEGIN TRAN;
--t1

INSERT INTO Table1 (Value)
VALUES(100)
--t2

COMMIT TRAN;