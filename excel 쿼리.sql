/*
http://sqlsrv4living.blogspot.kr/2013/12/read-excel-file-excel-2010-2013.html
���� 2007, sql 2008 ���� ���� �̻� ���� �߻�
�ַ� 64bit���� �߻�.


���� 2007 ���� �������� 2010 ������ �����Ϸ��� 
�ٿ�ε�(ACCESS 2010 ����)
http://www.microsoft.com/ko-kr/download/details.aspx?id=13255



SSMS �� ������ �������� �����ؾ� �ذ�Ǳ⵵ �Ѵ�.
���� ���� ������ �ƿ� �������� ��쵵 �߻��Ѵ�. �׷��ٸ�, ���� ������ ���� ������ �Ѵ�.
*/
sp_configure 'show advanced options', 1
go
reconfigure
go
sp_configure 'Ad Hoc Distributed Queries', 1
go
reconfigure
go




/*
�Ʒ��� ���� ������ ����� ���ι��̴��� �� ��� �ؾ� �Ѵ�.
Msg 7399, Level 16, State 1, Line 1

The OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)" reported an error. The provider did not give any information about the error. 
*/
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

--Excel 2007 ����
SELECT * 
--INTO #myTalbe
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0 Xml;HDR=YES;Database=d:\tmp\excel.xlsx',
    'SELECT * FROM [sheet1$]');
go

--csv �б�, SQL 2008 64bit����
select * 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Text;Database=d:\tmp;', 'SELECT * FROM excel_csv.csv')
go



--���� ������ ���� ������ ����ȼ����� ����� �Ŀ� ���� ("excel ���.sql")

--���簪 Ȯ��
select * from x1...sheet1$
where DATE <= '01/19/2004 22:07:37.228'
go

--������ ������ ������Ʈ �Ѵ�.
update a
set sent = sent + 1
from OPENROWSET('Microsoft.ACE.OLEDB.12.0',
				'Excel 12.0 Xml;HDR=YES;Database=d:\tmp\excel.xlsx',
				'SELECT * FROM [sheet1$]'
	) a 
where DATE <= '01/19/2004 22:07:37.228'
go

--Ȯ��: �ʿ��ϸ� ���� ������ ���� ���� Ȯ���ص� �ȴ�.
select * from x1...sheet1$
where DATE <= '01/19/2004 22:07:37.228'
go
