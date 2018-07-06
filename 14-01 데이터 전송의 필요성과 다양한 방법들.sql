/*
������
2013.11.22 
���� ������ pubs..sales ���� ����ǵ��� ��� ����

c:\temp ������ �⺻���� ����Ѵ�. �ʿ��ϸ� ��� ���� ���� ������ ȯ�濡 �°� �ٲ۴�.
*/


--*
--* 14.1 ������ ������ �ʿ伺�� �پ��� �����
--*



--*
--* A. BCP ��ƿ��Ƽ
--*


-- 1) Ʈ����Ʈ�� ����� BCP ��� ��

/*
cmd â���� �����Ѵ�. c:\temp �������� �����Ѵ�. 
(�ʿ��ϸ� 
c:
cd \temp 
�� ����Ѵ�. �� ��ũ��Ʈ������ c:\temp\�� ��� ���Ͽ� �ٿ��� ��� �����ص� �ǵ��� �Ͽ���.)


BCP pubs.dbo.sales out c:\temp\sales.txt -T -c

���� �Ŀ� sales.txt �� ��� ������ Ȯ���� ����.
*/

-- 3) �ؽ�Ʈ ���Ͽ��� ���̺�� ������ �����ϱ�
-- �� ���̺� �����
USE pubs
GO

IF OBJECT_ID('dbo.sales�����̺�') IS NOT NULL
	DROP TABLE dbo.sales�����̺�
GO

SELECT *
	INTO dbo.sales�����̺�
	FROM pubs.dbo.sales
	WHERE 1 = 0
GO
SELECT *	FROM dbo.sales�����̺�	--��� ������ Ȯ���Ѵ�.
GO

-- ������ ����
/*
BCP pubs.dbo.sales�����̺� in c:\temp\sales.txt -T -c 
*/

-- ��� Ȯ��
SELECT *	FROM dbo.sales�����̺�	-- ������ ��� ������ ������ Ȯ���Ѵ�.
GO



-- 4) �������� ����� �ؽ�Ʈ ���Ϸ� �����ϱ�
TRUNCATE TABLE dbo.sales�����̺�
GO
/*
BCP "SELECT stor_id, title_id, qty FROM pubs.dbo.sales WHERE qty >= 20" queryout c:\temp\sales�����̺�.txt -c  -T
*/
--�޸����� ���� sales�����̺�.txt �� ������ Ȯ���Ѵ�.




--*
--* B. BULK INSERT��
--*


-- 1) ������ ���� �� ������ ��������

USE pubs
GO

IF OBJECT_ID('dbo.sales�����̺�') IS NOT NULL
	DROP TABLE dbo.sales�����̺�
GO

SELECT *
	INTO dbo.sales�����̺�
	FROM pubs.dbo.sales
	WHERE 1 = 0
GO

BULK INSERT pubs.dbo.sales�����̺�
   FROM 'c:\temp\sales.txt'
   WITH (
         FIELDTERMINATOR ='\t',
         ROWTERMINATOR ='\n')
GO

SELECT *	FROM dbo.sales�����̺�	-- ������ ��� ������ ������ Ȯ���Ѵ�.
GO


-- 2) ���� ���� ����� ����ϱ�

-- ���� ���� �����
/*
bcp pubs.dbo.sales format nul -c  -fe:\tmp\sales.fmt -T
*/


-- ���� ���� ����� ������ ��������
USE pubs
GO

TRUNCATE TABLE dbo.sales�����̺�
GO

BULK INSERT dbo.sales�����̺� 
   FROM 'c:\temp\sales.txt'
   WITH (FORMATFILE = 'c:\temp\sales.fmt');
GO

SELECT *	FROM dbo.sales�����̺�	-- ������ ��� ������ ������ Ȯ���Ѵ�.
GO


--*
--* C. OPENROWSET
--*
SELECT t.* FROM OPENROWSET(BULK 'c:\temp\sales.txt', 
   FORMATFILE = 'c:\temp\sales.fmt') AS t
