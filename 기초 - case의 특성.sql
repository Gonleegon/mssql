drop table #a
go
create table #a (
	id int identity
,	c1 int
)

insert #a
select top 30 provider_no from charge order by NEWID()

--select * from #a


--id = 6, 12, 18 ... �϶��� case���� ������ ���ñ�?
select *
	, case 
		when id %3 = 0 then 3
		when id %2 = 0 then 2
		else id
	end as case��
from #a

select *
	, case 
		when id %2 = 0 then 2
		when id %3 = 0 then 3
		else id
	end as case��
from #a
