/*
	�������� ���� ������ 1 / �����ڿ�
	�� 3�� �ҽ� ��ũ��Ʈ 
	������ 2000.1
*/

use pubs
SELECT * FROM titles


SELECT * 
FROM titles


EXEC sp_help titles
EXEC sp_columns titles

SELECT title_id, title, price, pub_id 
FROM titles

SELECT title_id, pub_id, price, title 
FROM titles


SELECT 'å ��ȣ:' as ���������÷�, title_id, pub_id, price, title 
FROM titles


SELECT 	title_id  Title_no
	, pub_id [���ǻ� ��ȣ]  
	, price
	, title 
FROM titles


SELECT 	title_id AS Title_no , pub_id AS [���ǻ� ��ȣ] , price, title 
FROM titles


SELECT title_id AS Title_no, pub_id AS '���ǻ� ��ȣ', price, title 
FROM titles
---
SELECT title_id AS Title_no, pub_id AS [(���ǻ� ��ȣ)], price, title 
FROM titles


SELECT 	title_id Title_no, pub_id [���ǻ� ��ȣ] , price, title 
FROM titles
------
SELECT 	Title_no = title_id, [���ǻ� ��ȣ] = pub_id, price, title 
FROM titles

--//����2

SELECT  city as ����, state  FROM  publishers
SELECT  city ����, state  FROM  publishers

--3. 
sp_help publishers
sp_columns publishers

--5.
SELECT  *  FROM  sales

--6.
SELECT  title_id, stor_id, ord_date, '����:', qty
FROM  sales



--//����
DECLARE @id INT, @name CHAR(10)
SET @id = 0
SET @name = '������'
SELECT @id, @name




--// �ڷ���
--��¥
declare @a datetime
set @a = '2002.8.10'
select @a

declare @a smalldatetime
set @a = '2002.8.10'
select @a

declare @a datetime
set @a = '2002.8.10 13:34:28.999'
select @a

declare @a datetime
set @a = '02.8.10 13:34:28.999'
select @a

declare @a datetime
set @a = '8/10/02'
select @a

set dateformat mdy
declare @a datetime
set @a = '8/10/02'
select @a
set dateformat ymd

--char vs varchar
declare @a char(10), @b varchar(10)
set @a  = 'a'
set @b = 'b'
select @a + '*' 
select @b + '*'



--//SELECT������ �ڷ��� �ٲٱ�

select 1 + 3 
select 'a' + 'b'
select 1 + '4'
select 'a' + 'b'  + 4
select 'a' + 'b'  + convert(char(1), 4)

select 10/ 3
select 10.0 / 3
select 10. / 3
select convert(decimal(10, 8) , 10) / 3

--1)
SELECT 	title_id AS Title_no
	, pub_id AS '���ǻ� ��ȣ'  
	, price
	, CONVERT(char(30), title) AS '���� ����'
	, convert(varchar(10), price) + '��'
FROM titles

--2)
SELECT 	title_id AS Title_no
	, pub_id AS '���ǻ� ��ȣ'  
	, price
	, SUBSTRING(title, 1, 30) AS '���� ����'
FROM titles

SELECT 	title_id AS Title_no
	, pub_id AS '���ǻ� ��ȣ'  
	, price * 1.1 AS '����(�ΰ��� ����)'
	, SUBSTRING(title, 1, 30) AS '���� ����'
FROM titles

SELECT 	title_id AS Title_no
	, pub_id AS '���ǻ� ��ȣ'  
	, price * 1.1 AS '����(�ΰ��� ����)'
	, CAST ( title AS char(30) ) AS [���� ����]
FROM titles





SELECT 	CONVERT( float, '32.2')
SELECT 	CONVERT( int, '32.2')
SELECT 	CONVERT( int, '32')
SELECT 	CONVERT( varchar(5), 32.2)
SELECT 	CONVERT( varchar(3), 32.2)
SELECT 	CONVERT( float, 32 )


SELECT title_id, price
, FLOOR(price) as floor, CEILING(price) as ceiling, ROUND(price, 0) as round
from titles


SELECT SUBSTRING('abcdef', 1, 2)  
SELECT SUBSTRING('�ѱ�abcd����Ÿ', 1, 2)  --1)
SELECT SUBSTRING('�ѱ�abcd����Ÿ', 3, 3)  --2)

SELECT REPLICATE('�ݺ�', 10)

SELECT STUFF('123456', 3, 2, 'abcde')
SELECT replace('123456', '34', 'abcde')

select title 
from titles


SELECT GETDATE()
SELECT year(GETDATE()), month (getdate()), day(getdate())
SELECT year(GETDATE())+1, getdate() + 1
2002�� 8�� 12�� 
SELECT year(GETDATE()) + '��'--, month (getdate()), day(getdate())
SELECT CONVERT( varchar(30), GETDATE(), 9)

SELECT CONVERT( varchar(30), GETDATE(), 2)
SELECT CONVERT( varchar(30), GETDATE(), 102)
select dateadd( m, 10, getdate())
select datediff(d, '76.2.5', getdate())





SELECT DATEPART(mm, GETDATE())
SELECT MONTH(GETDATE())

SELECT DATEADD(mm, 20, GETDATE())

SELECT DATEADD(dd, 100, GETDATE())
SELECT GETDATE() + 100

SELECT DATEDIFF(dd, GETDATE(), '3000.1.1')

SELECT DATENAME(dw, GETDATE()), DATENAME(mm, GETDATE())







SELECT title_id, qty FROM sales

SELECT title_id, qty 
FROM sales
WHERE qty >= 20

SELECT title_id, qty FROM sales
WHERE title_id = 'BU1032'




SELECT title_id, price
FROM titles
WHERE price IS NULL

SELECT title_id, price
FROM titles
WHERE price = NULL

--- <> NOT NULL�� IS NOT NULL�� ���� �ʴ�.
SELECT title_id, price
FROM titles
WHERE price <> NULL

SELECT title_id, price
FROM titles
WHERE price IS NOT NULL





--//����

SELECT title_id, qty 
FROM sales
ORDER BY qty 

SELECT title_id, qty
FROM sales
ORDER BY qty DESC

SELECT title_id, qty
FROM sales
ORDER BY title_id, qty

SELECT title_id, qty
FROM sales
ORDER BY title_id, qty DESC

SELECT title_id, qty
FROM sales
ORDER BY title_id DESC, qty DESC

SELECT title_id, qty
FROM sales
ORDER BY 1 DESC, 2 DESC

SELECT TOP 6 title_id, qty 
FROM sales 


SELECT TOP 6 title_id, qty 
FROM sales 
ORDER BY qty DESC 


SELECT TOP 6 WITH TIES title_id, qty 
FROM sales 
ORDER BY qty DESC

SELECT TOP 25 PERCENT title_id, qty 
FROM sales 
ORDER BY qty DESC

SELECT TOP 25 PERCENT WITH TIES title_id, qty 
FROM sales 
ORDER BY qty DESC

--//����
SELECT title_id, qty
FROM sales
WHERE qty BETWEEN 10 AND 20
ORDER BY qty

SELECT title_id, qty
FROM sales
WHERE qty >= 10 AND qty <= 20
ORDER BY qty

--//���

SELECT title_id, qty
FROM sales
WHERE title_id IN ('BU1032', 'BU1111', 'MC3021')


SELECT title_id, qty
FROM sales
WHERE title_id = 'BU1032'  OR  'BU1111'  OR  'MC3021'

--���ڿ�
SELECT title_id, title
FROM titles
WHERE title LIKE '%computer%'

SELECT title_id, title
FROM titles
WHERE title LIKE 'computer%'


SELECT PATINDEX('%Mi%', 'James Mike')
SELECT PATINDEX('M[^c]%', 'McAthur')
SELECT PATINDEX('M[^c]%', 'Mike')
SELECT PATINDEX('M[^c]%', 'M') 	-- ����! Ʋ���� ����.


--�ߺ��� ��

SELECT title_id
FROM sales
ORDER BY title_id


SELECT DISTINCT title_id
FROM sales
ORDER BY title_id


SELECT title_id, price
FROM titles
WHERE price * 1.1 < 20.00
ORDER BY price

---
SELECT title_id, price
FROM titles
WHERE price < 20.00 / 1.1
ORDER BY price

SELECT title_id, pubdate, DATEPART(yy, pubdate) AS [����]
FROM titles
WHERE DATEPART(yy, pubdate) = 1991


SELECT title_id, pubdate, YEAR (pubdate) AS [����]
FROM titles
WHERE YEAR (pubdate)  = 1991


SELECT title_id, pubdate, YEAR (pubdate) AS [����]
FROM titles
WHERE pubdate BETWEEN '1991.1.1' AND '1991.12.31'

SET DATEFORMAT 'ymd'
go
SELECT title_id, pubdate, DATEPART(yy, pubdate)
FROM titles
WHERE pubdate BETWEEN '1991.1.1' AND '1991.12.31'

--1)
SELECT title_id, price, pub_id
FROM titles
WHERE title_id LIKE 'BU%' 
	OR ( pub_id = '1389'	AND price = 19.99 )

--2)
SELECT title_id, price, pub_id
FROM titles
WHERE (title_id LIKE 'BU%' OR 	pub_id = '1389' )
	AND price = 19.99

--3)
SELECT title_id, price, pub_id
FROM titles
WHERE title_id LIKE 'BU%'  OR 	pub_id = '1389' 
	AND price = 19.99

