--*
--* 6.4 ������ ����
--*



--*
--* A. �⺻���� ������ ����
--*


-- 1) ���� �Լ� ���

USE HRDB
GO

-- �ٹ� ���� �������� �޿��� �� ���ϱ�
SELECT SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
GO

--  �ٹ� ���� �������� �޿��� �ִ밪, �ּҰ�, �ִ밪 - �ּҰ��� ���ϴ� ������ �ۼ�����.

SELECT MAX(Salary) AS 'Max_Salary', MIN(Salary) AS ' Min_Salary',
			 MAX(Salary) - MIN(Salary) AS ' Diff_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
GO


-- 2) ���� �Լ��� NULL �� ����

UPDATE dbo.Employee
	SET Salary = NULL
	WHERE EmpID = 'S0020'
GO

SELECT COUNT(*) AS 'EmpCount'
	FROM dbo.Employee
	WHERE RetireDate IS NULL --> 16
GO

SELECT COUNT(EmpID) AS 'EmpCount'
	FROM dbo.Employee
	WHERE RetireDate IS NULL --> 16
GO
	
SELECT COUNT(Salary) AS 'EmpCount'
	FROM dbo.Employee
	WHERE RetireDate IS NULL --> 15
GO
/*
���: ���� �Ǵ� �ٸ� SET �۾��� ���� Null ���� ���ŵǾ����ϴ�.
*/

-- �ٹ� ���� �������� �޿��� ����� ���ϴ� ������ �ۼ��ϰ� �ִ�. 
-- ���� �� ������ �������� ��������.

SELECT SUM(Salary) / COUNT(EmpID) AS 'Avg_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL --> 5,681
GO

SELECT SUM(Salary) / COUNT(Salary) AS 'Avg_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL --> 6,060
GO

-- ���� 
SELECT AVG(Salary) AS 'Avg_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL --> 6,060
GO
 

-- 3) �׷캰 ����: GROUP BY

-- �μ��� �ٹ� ���� ���� �� ���ϱ�
SELECT DeptID, COUNT(*) AS 'Emp_Count'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
GO

-- �����ϴ� GROUP BY ��
SELECT DeptID, EmpName, COUNT(*) AS 'Emp_Count'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
GO
/*
�޽��� 8120, ���� 16, ���� 1, �� 2
�� 'dbo.Employee.EmpName'��(��) ���� �Լ��� GROUP BY ���� �����Ƿ� SELECT ��Ͽ��� ����� �� �����ϴ�.
*/

-- �μ��� �ٹ��ϴ� ������ �޿��� ���� ������.
SELECT DeptID, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID 
GO

-- �μ��� �ٹ��ϴ� ������ �ִ밪, �ּҰ�, �ִ밪 - �ּҰ��� ������
SELECT DeptID, MAX(Salary) AS 'Max_Salary', MIN(Salary) AS ' Min_Salary',
			 MAX(Salary) - MIN(Salary) AS ' Diff_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
GO

--  �μ��� �ٹ��ϴ� ������ �޿��� 5000 �̻��� ������ ����������
SELECT DeptID, COUNT(EmpID) AS 'Max_Salary'
	FROM dbo.Employee
	WHERE Salary > 5000
	GROUP BY DeptID;
GO


-- 4) �׷��� ����� ���� ���͸�: HAVING

SELECT DeptID, COUNT(*) AS 'Emp_Count'
	FROM dbo.Employee
	GROUP BY DeptID
	HAVING COUNT(*) >= 3
GO

-- �μ����� ���� �ٹ� ���� ������ ��� �޿��� ��� ������ �ۼ�����.
SELECT DeptID, AVG(Salary) AS 'Avg_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
GO

-- ������ ���� �μ� ��� �޿��� ���� ��� �޿����� ���� �μ��� ��� �޿���?
SELECT DeptID, AVG(Salary) AS 'Avg_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
	HAVING AVG(Salary) > (SELECT AVG(Salary) FROM dbo.Employee WHERE RetireDate IS NULL)
GO


-- 5) ���ο� �׷� �� ���� ���: GROUPING SETS

SELECT DeptID, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
GO

SELECT Gender, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY Gender
GO

-- ��� ����
SELECT DeptID, NULL AS 'Gender', SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID

UNION

SELECT NULL, Gender, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY Gender
	ORDER BY Gender, DeptID
GO

-- GROUPING SETS ���
SELECT DeptID, Gender, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	GROUP BY GROUPING SETS(DeptID, Gender)
	ORDER BY Gender, DeptID
GO

-- ��ü ���踸 �����ֱ�
SELECT DeptID, Gender, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	GROUP BY GROUPING SETS((DeptID, Gender), ())
GO

-- �μ� �Ұ� + ��ü ���� �����ֱ�
SELECT DeptID, Gender, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	GROUP BY GROUPING SETS((DeptID, Gender), (DeptID), ())
GO

-- �μ� �Ұ踸 �����ֱ�(��ü ���� ����)
SELECT DeptID, Gender, SUM(Salary) AS 'Tot_Salary'
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	GROUP BY GROUPING SETS((DeptID, Gender), (DeptID))
GO



--*
--* B. ���� ���ϱ�
--*


-- 1) ���� ǥ��: RANK

-- ��ü ����
SELECT EmpID, EmpName, Gender, Salary, RANK() OVER(ORDER BY Salary DESC) AS 'Rnk'
   FROM dbo.Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO

-- ������ ����
SELECT EmpID, EmpName, Gender, Salary, 
	RANK() OVER(PARTITION BY Gender ORDER BY Salary DESC) AS 'Rnk'
   FROM dbo.Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO


-- 2) ���� ǥ��: DENSE_RANK

-- ��ü ����
SELECT EmpID, EmpName, Gender, Salary,  DENSE_RANK() OVER(ORDER BY Salary DESC) AS 'Rnk'
   FROM dbo.Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO

-- ������ ����
SELECT EmpID, EmpName, Gender, Salary, 
	DENSE_RANK() OVER(PARTITION BY Gender ORDER BY Salary DESC) AS 'Rnk'
   FROM dbo.Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO


-- 3) ��ȣ ǥ��: ROW_NUMBER

-- ��ü ��ȣ
SELECT ROW_NUMBER() OVER(ORDER BY EmpName DESC) AS 'Num',
			 EmpName, EmpID, Gender, Salary
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO

-- ������ ��ȣ
SELECT ROW_NUMBER() OVER(PARTITION BY DeptID
			 ORDER BY EmpName DESC) AS 'Num',
			 DeptID, EmpName, Empid, Gender, Salary
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO


-- 4) ���� ǥ��: NTILE

-- ��ü ����
SELECT EmpID, EmpName, Gender, Salary, NTILE(3) OVER(ORDER BY Salary DESC) AS 'Band'
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO

-- ������ ����
SELECT EmpID, EmpName, Gender, Salary, 
			 NTILE(3) OVER(PARTITION BY Gender ORDER BY Salary DESC) AS 'Band'
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
GO



--*
--* C. PIVOT�� UNPIVOT
--*


-- 1) PIVOT

-- �μ� �ڵ带 ������ �������� �ް� ��Ȳ
SELECT v.EmpID, e.DeptID, Year(v.BeginDate) AS 'Year', v.Duration
	FROM dbo.Vacation AS v
	INNER JOIN  dbo.Employee AS e ON v.EmpID = e.EmpID
GO

-- �μ��� +������ �ް� ��Ȳ ����
SELECT e.DeptID, Year(v.BeginDate) AS 'Year', SUM(v.Duration) AS 'Duration'
	FROM dbo.Vacation AS v
	INNER JOIN  dbo.Employee AS e ON v.EmpID = e.EmpID
	GROUP BY e.DeptID, Year(BeginDate) 
GO

-- �ǹ� ���·� ǥ���ϱ�
SELECT DeptID, [2007], [2008], [2009], [2010], [2011]
	FROM (
		SELECT e.DeptID, Year(v.BeginDate) AS 'Year', SUM(v.Duration) AS 'Duration'
			FROM dbo.Vacation AS v
			INNER JOIN  dbo.Employee AS e ON v.EmpID = e.EmpID
			GROUP BY e.DeptID, Year(BeginDate) 
	) AS Src
	PIVOT(SUM(Duration) 
	FOR Year IN([2007], [2008], [2009], [2010], [2011])) AS Pvt
GO

-- �ǹ� ���·� ǥ���ϱ�(NULL �� ó��)
SELECT DeptID, ISNULL([2007], 0) AS '2007', ISNULL([2008], 0) AS '2008', ISNULL([2009], 0) AS '2009', ISNULL([2010], 0) AS '2010', ISNULL([2011], 0) AS '2011'
	FROM (
		SELECT e.DeptID, Year(v.BeginDate) AS 'Year', SUM(v.Duration) AS 'Duration'
			FROM dbo.Vacation AS v
			INNER JOIN  dbo.Employee AS e ON v.EmpID = e.EmpID
			GROUP BY e.DeptID, Year(BeginDate) 
	) AS Src
	PIVOT(SUM(Duration) 
	FOR Year IN([2007], [2008], [2009], [2010], [2011])) AS Pvt
GO


-- 2) UNPIVOT

 -- �ǹ� ���� ���̺� �����
 SELECT DeptID, [2007], [2008], [2009], [2010], [2011]
	INTO dbo.YearVacation
	FROM (
		SELECT e.DeptID, Year(v.BeginDate) AS 'Year', SUM(v.Duration) AS 'Duration'
			FROM dbo.Vacation AS v
			INNER JOIN  dbo.Employee AS e ON v.EmpID = e.EmpID
			GROUP BY e.DeptID, Year(BeginDate) 
	) AS Src
	PIVOT(SUM(Duration) 
	FOR Year IN([2007], [2008], [2009], [2010], [2011])) AS Pvt
GO

SELECT * FROM dbo.YearVacation
GO

-- UNPIVOT
SELECT DeptID, Year, Duration
	FROM dbo.YearVacation
	UNPIVOT (Duration FOR Year IN ([2007], [2008], [2009], [2010], [2011])) AS uPvt
GO