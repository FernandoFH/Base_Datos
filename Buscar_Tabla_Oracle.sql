## Buscar Tabla en Oracle ##

select owner, table_name
from all_tables
where table_name like ('%%')
order by owner, table_name;
