
select * from titles WHERE price BETWEEN 10 AND 20
select * from titles WHERE price >= 10 AND price <= 20

[pubs].[dbo].[titles].[price]>=CONVERT_IMPLICIT(money,[@1],0) AND [pubs].[dbo].[titles].[price]<=CONVERT_IMPLICIT(money,[@2],0)


[pubs].[dbo].[titles].[price]>=CONVERT_IMPLICIT(money,[@1],0) AND [pubs].[dbo].[titles].[price]<=CONVERT_IMPLICIT(money,[@2],0)



WHERE name BETWEEN '������' AND '�����'

WHERE name IN ('june', 'joy', 'soul')
WHERE name = 'june' OR name = 'joy' OR name = 'soul'

WHERE name LIKE '%����'
WHERE name LIKE '��%'
WHERE name >= '��' AND name < '��'


