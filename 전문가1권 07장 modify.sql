/*
	�������� ���� ������ 1 / �����ڿ�
	�� 7�� �ҽ� ��ũ��Ʈ 
	������ 2000.1
*/



USE tempdb
GO
CREATE TABLE t1
(
	id	int	
,	name	char(20)	NOT NULL
,	city	char(10)	
)
GO

INSERT t1 VALUES (1, '��ö��', '����')
SELECT * FROM t1


INSERT t1 VALUES (2, '�۱���', '����')
SELECT * FROM t1


DROP TABLE t1
GO

CREATE TABLE t1
(
	id	int	IDENTITY		PRIMARY KEY
,	name	char(20)	NOT NULL
,	city	char(10)	DEFAULT '����'
,	photo	image	NULL
)
GO

INSERT t1 VALUES ('������', DEFAULT, NULL)
SELECT * FROM t1

INSERT t1 (name) VALUES ('������')
INSERT t1 (name) VALUES ('�ּҿ�')
INSERT t1 (name) VALUES ('ȫ����')
SELECT * FROM t1
GO



INSERT t1 (city, name) VALUES ('����', '�迵��')	        --�÷� ���� ����




CREATE TABLE timeS (
	id	INT	IDENTITY	PRIMARY KEY
,	TIMESTAMP
,	qty	INT	NOT NULL
)
GO

INSERT timeS (qty) VALUES (3)
INSERT timeS (qty) VALUES (4)
INSERT timeS (qty) VALUES (10)

SELECT * FROM timeS


INSERT t1 DEFAULT VALUES


CREATE TABLE tblDef (
	id	INT	IDENTITY
,	TIMESTAMP
,	[�Է�����]	DATETIME	NOT NULL
		DEFAULT	getdate()
,	photo	IMAGE	NULL
)
GO
INSERT tblDef	DEFAULT VALUES 
INSERT tblDef	DEFAULT VALUES 
INSERT tblDef	DEFAULT VALUES
SELECT * FROM tblDef 




DROP TABLE t1
GO
CREATE TABLE t1
(
	id	int	IDENTITY		PRIMARY KEY
,	name	char(20)	NOT NULL
,	city	char(10)	DEFAULT '����'
,	photo	image	NULL
)
GO

INSERT t1 VALUES ('����ȭ', DEFAULT, NULL)
INSERT t1 (name) VALUES ('������')
INSERT t1 (name) VALUES ('�ڿ���')
SELECT * FROM t1
GO

 
SELECT * 
INTO t2
FROM t1

SELECT * FROM t2
GO



SELECT * 
INTO t3
FROM t1
where 1=2

select * from t3

INSERT t2 
	SELECT * FROM t1
GO



INSERT t2 
	SELECT name, city, photo FROM t1
GO


----------------------

DELETE t1
WHERE id = 3

SELECT * FROM t1


BEGIN TRAN
	DELETE �����߿������̺�
	SELECT * FROM �����߿������̺�
ROLLBACK TRAN 

ROLLBACK 
COMMIT  TRAN
COMMIT



SELECT * FROM t1
SELECT * FROM t2
GO


BEGIN TRAN
	DELETE t2
	WHERE id IN (
		SELECT id FROM t1
	)
	SELECT * FROM t1
	SELECT * FROM t2
ROLLBACK TRAN 	--�Ǵ� COMMIT TRAN		


BEGIN TRAN
	DELETE t2
	FROM t1 JOIN t2  ON t1.id = t2.id

	SELECT * FROM t1
	SELECT * FROM t2
COMMIT TRAN		--ROLLBACK TRAN
TRUNCATE TABLE


BEGIN TRAN
	TRUNCATE TABLE t1
	SELECT * FROM t1
ROLLBACK TRAN
SELECT * FROM t1




SELECT * FROM t2

update t2
set	name = 'kkk', city = '����'
where 	id = 3

SELECT * FROM t2

USE pubs
BEGIN TRAN
	UPDATE titles 
	SET price = price * 2
	WHERE title_id = 'BU1032'

	SELECT title_id, price
	FROM titles
	WHERE title_id = 'BU1032'
ROLLBACK 
-- �Ǵ� COMMIT



USE tempdb
GO
CREATE TABLE source (sid INT, sValue INT)
CREATE TABLE target (tid INT PRIMARY KEY, tValue INT)
GO
INSERT source VALUES(1, 10)
INSERT target VALUES(1, 0)
SELECT * FROM target
SELECT * FROM source
GO

UPDATE target 
SET tValue = tValue + sValue
FROM target JOIN source ON (tid = sid)
GO
SELECT * FROM target
SELECT * FROM source


UPDATE target 
SET tValue = tValue + sValue
FROM target, source
WHERE tid = sid



UPDATE target SET tValue = 0	-- 0���� �ʱ�ȭ �Ѵ�.
INSERT source VALUES(1, 20)	-- ���� 20�̶� ���� source ���̺� �Է�

SELECT * FROM target
SELECT * FROM source
GO

UPDATE target 
SET tValue = tValue + sValue
FROM target JOIN source        ON (tid = sid)
GO

SELECT * FROM target
GO



UPDATE target SET tValue = 0
SELECT * FROM target

UPDATE target 
SET tValue = tValue + (
	SELECT sum(sValue) 
	FROM source JOIN target 
	ON tid = sid 
)
GO

SELECT * FROM target
GO



INSERT source VALUES(2, 10)	-- ���� ���� source ���̺� �Է�
INSERT source VALUES(2, 200)	-- ���� ���� source ���̺� �Է�
INSERT target VALUES(2, 0)	-- ���� ���� target ���̺� �Է�
UPDATE target SET tValue = 0
SELECT * FROM target
SELECT * FROM source

UPDATE target 
SET tValue = tValue + (
	SELECT sum(sValue) 
	FROM source JOIN target 
	ON tid = sid 
)
GO

SELECT * FROM target
GO


UPDATE target SET tValue = 0
SELECT * FROM target

UPDATE target 
SET tValue = tValue + (
	SELECT sum(sValue) 
	FROM source 
	WHERE sid = target.tid)
GO

SELECT * FROM target
GO



USE pubs	-- ����!
GO
BEGIN TRAN
	--1)
	UPDATE titles SET ytd_sales = 0

	--2)
	SELECT t.title_id, qty, ytd_sales, ord_date FROM titles t 
		JOIN sales s ON t.title_id = s.title_id
		ORDER BY t.title_id
/*
	SELECT MAX(sales.ord_date) FROM sales
	SELECT t.title_id, qty, ytd_sales, ord_date FROM titles t 
		JOIN sales s ON t.title_id = s.title_id
		WHERE ord_date = '1994-09-14 00:00:00.000'
		ORDER BY t.title_id
*/
	--3)
	UPDATE titles
	SET ytd_sales = titles.ytd_sales + sales.qty
	FROM titles, sales
	WHERE titles.title_id = sales.title_id
		AND sales.ord_date = 
			(SELECT MAX(sales.ord_date) FROM sales)
		--AND sales.ord_date = '1994-09-14 00:00:00.000'

	--4)
	SELECT t.title_id, qty, ytd_sales FROM titles t 
		JOIN sales s ON t.title_id = s.title_id
		ORDER BY t.title_id
	SELECT title_id, ytd_sales FROM titles
ROLLBACK

UPDATE titles
SET ytd_sales = 0

UPDATE titles
SET ytd_sales = ytd_sales + ( 
	SELECT qty
	FROM sales
	WHERE sales.title_id = titles.title_id
	AND ord_date BETWEEN '94.1.1' AND '94.12.31'
	)



UPDATE titles
SET ytd_sales = ( 
	SELECT SUM(qty)
	FROM sales
	WHERE sales.title_id = titles.title_id
	AND ord_date BETWEEN '94.1.1' AND '94.12.31 23:59:59.997'
	)

SELECT title_id, ytd_sales
FROM titles


USE pubs
SELECT * 
FROM sales 
WHERE stor_id = '7067'
GO

SELECT * 
INTO #sales
FROM sales 
WHERE stor_id = '7067'
GO

SELECT *
FROM #sales
GO


EXEC sp_helpindex sales

EXEC sp_helpindex #sales


USE tempdb
EXEC sp_helpindex #sales
USE pubs



SELECT * 
INTO #sales
FROM sales 
WHERE stor_id = '6380'




INSERT #sales
SELECT *
FROM sales 
WHERE stor_id = '6380'

SELECT * FROM #sales



SELECT * 
INTO sales2
FROM sales 
WHERE 1=0





SELECT * FROM sales2


DELETE #sales WHERE stor_id = '6380'


SELECT * FROM #sales WHERE stor_id = '6380'


BEGIN TRAN
	DELETE #sales
	SELECT * FROM #sales
ROLLBACK
SELECT * FROM #sales


BEGIN TRAN
	TRUNCATE TABLE #sales
	SELECT * FROM #sales
COMMIT
SELECT * FROM #sales



USE pubs
BEGIN TRAN
	SELECT stor_name, state, qty 
	FROM sales s JOIN stores st
		ON s.stor_id = st.stor_id
	WHERE state = 'WA'

	DELETE sales
	FROM stores
	WHERE sales.stor_id = stores.stor_id
		AND state = 'WA'

	SELECT stor_name, state, qty 
	FROM sales s JOIN stores st
		ON s.stor_id = st.stor_id
	WHERE state = 'WA'
ROLLBACK


USE pubs
BEGIN TRAN
	SELECT * FROM 
	sales 
	WHERE stor_id = '6380'

	UPDATE sales
	SET qty = qty * 2, ord_date = getdate()
	WHERE stor_id = '6380'

	SELECT * FROM 
	sales 
	WHERE stor_id = '6380'
ROLLBACK



SELECT emp_id, job_id, hire_date
FROM employee
WHERE emp_id IN ('PMA42628M', 'PSA89086M')

BEGIN TRAN
	UPDATE employee 
	SET job_id =
	(	SELECT job_id
		FROM employee
		WHERE emp_id = 'PMA42628M'
	)
	, hire_date = (
		SELECT hire_date
		FROM employee
		WHERE emp_id = 'PMA42628M'
	)
	WHERE emp_id = 'PSA89086M'

	SELECT emp_id, job_id, hire_date
	FROM employee
	WHERE emp_id IN ('PMA42628M', 'PSA89086M')
ROLLBACK

