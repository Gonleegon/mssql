use tempdb
go

create table �л�(�й� int, �а� int)
go
create table �а� (�а� int)
go

insert �л� values (1, 1)
insert �л� values (2, 1)
insert �л� values (3, 2)
insert �л� values (99, 4)
go


insert �а� values (1)
insert �а� values (2)
insert �а� values (3)
go

select *
from �л� s	inner join �а� m	on s.�а� = m.�а�



select *
from �л� s	right outer join �а� m	on s.�а� = m.�а�

select *
from �л� s	left outer join �а� m	on s.�а� = m.�а�
where m.�а� is null

select *
from �л� s	left outer join �а� m	on s.�а� = m.�а�
where s.�а� is null





select *
from �л� s	full outer join �а� m	on s.�а� = m.�а�
