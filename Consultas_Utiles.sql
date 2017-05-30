#Consulta Oracle SQL sobre la vista que muestra el estado de la base de datos:
Select * from v$instance

#Consulta Oracle SQL que muestra si la base de datos está abierta
Select status from v$instance

#Consulta Oracle SQL sobre la vista que muestra los parámetros generales de Oracle
Select * from v$system_parameter

#Consulta Oracle SQL para conocer la Versión de Oracle
Select value from v$system_parameter where name = 'compatible'

#Consulta Oracle SQL para conocer la Ubicación y nombre del fichero spfile
Select value from v$system_parameter where name = 'spfile'

#Consulta Oracle SQL para conocer la Ubicación y número de ficheros de control
Select value from v$system_parameter where name = 'control_files'

#Consulta Oracle SQL para conocer el Nombre de la base de datos
Select value from v$system_parameter where name = 'db_name'

#Consulta Oracle SQL sobre la vista que muestra las conexiones actuales a Oracle Para visualizarla es necesario entrar con privilegios de administrador
select osuser, username, machine, program
from v$session
order by osuser

#Consulta Oracle SQL que muestra el número de conexiones actuales a Oracle agrupado por aplicación que realiza la conexión
select program Aplicacion, count(program) Numero_Sesiones
from v$session
group by program
order by Numero_Sesiones desc

#Consulta Oracle SQL que muestra los usuarios de Oracle conectados y el número de sesiones por usuario
select username Usuario_Oracle, count(username) Numero_Sesiones
from v$session
group by username
order by Numero_Sesiones desc
Propietarios de objetos y número de objetos por propietario
select owner, count(owner) Numero
from dba_objects
group by owner
order by Numero desc

#Consulta Oracle SQL sobre el Diccionario de datos (incluye todas las vistas y tablas de la Base de Datos)
select * from dictionary

#Consulta Oracle SQL que muestra los datos de una tabla especificada (en este caso todas las tablas que lleven la cadena "XXX"
select * from ALL_ALL_TABLES where upper(table_name) like '%XXX%'

#Consulta Oracle SQL para conocer las tablas propiedad del usuario actual
select * from user_tables

#Consulta Oracle SQL para conocer todos los objetos propiedad del usuario conectado a Oracle
select * from user_catalog

#Últimas consultas SQL ejecutadas en Oracle y usuario que las ejecutó:
select distinct vs.sql_text, vs.sharable_mem, 
  vs.persistent_mem, vs.runtime_mem,  vs.sorts,
  vs.executions, vs.parse_calls, vs.module,  
  vs.buffer_gets, vs.disk_reads, vs.version_count, 
  vs.users_opening, vs.loads,  
  to_char(to_date(vs.first_load_time,
  'YYYY-MM-DD/HH24:MI:SS'),'MM/DD  HH24:MI:SS') first_load_time,  
  rawtohex(vs.address) address, vs.hash_value hash_value , 
  rows_processed  , vs.command_type, vs.parsing_user_id  , 
  OPTIMIZER_MODE  , au.USERNAME parseuser  
from v$sqlarea vs , all_users au   
where (parsing_user_id != 0)  AND 
(au.user_id(+)=vs.parsing_user_id)  
and (executions >= 1) order by   buffer_gets/executions desc 

#Todos los ficheros de datos y su ubicación:
select * from V$DATAFILE

#Ficheros temporales:
select * from V$TEMPFILE

#Tablespaces:
select * from V$TABLESPACE

#Otras vistas muy interesantes:
select * from V$BACKUP

select * from V$ARCHIVE   

select * from V$LOG   

select * from V$LOGFILE    

select * from V$LOGHIST          

select * from V$ARCHIVED_LOG    

select * from V$DATABASE

#Memoria Share_Pool libre y usada:
select name,to_number(value) bytes 
from v$parameter where name ='shared_pool_size'
union all
select name,bytes 
from v$sgastat where pool = 'shared pool' and name = 'free memory'
  
#Cursores abiertos por usuario:
select b.sid, a.username, b.value Cursores_Abiertos
      from v$session a,
           v$sesstat b,
           v$statname c
      where c.name in ('opened cursors current')
      and   b.statistic# = c.statistic#
      and   a.sid = b.sid 
      and   a.username is not null
      and   b.value >0
      order by 3

#Aciertos de la caché (no debe superar el 1 por ciento):
select sum(pins) Ejecuciones, sum(reloads) Fallos_cache,
  trunc(sum(reloads)/sum(pins)*100,2) Porcentaje_aciertos 
from v$librarycache
where namespace in ('TABLE/PROCEDURE','SQL AREA','BODY','TRIGGER');

#Sentencias SQL completas ejecutadas con un texto determinado en el SQL:
SELECT c.sid, d.piece, c.serial#, c.username, d.sql_text 
FROM v$session c, v$sqltext d 
WHERE  c.sql_hash_value = d.hash_value 
  and upper(d.sql_text) like '%WHERE CAMPO LIKE%'
ORDER BY c.sid, d.piece

#Una sentencia SQL concreta (filtrado por sid):
SELECT c.sid, d.piece, c.serial#, c.username, d.sql_text 
FROM v$session c, v$sqltext d 
WHERE  c.sql_hash_value = d.hash_value and sid = 105
ORDER BY c.sid, d.piece

#Tamaño ocupado por la base de datos
select sum(BYTES)/1024/1024 MB 
from DBA_EXTENTS  

#Tamaño de los ficheros de datos de la base de datos:
select sum(bytes)/1024/1024 MB 
from dba_data_files

#Tamaño ocupado por una tabla concreta sin incluir los índices de la misma
select sum(bytes)/1024/1024 MB 
from user_segments
where segment_type='TABLE' and segment_name='NOMBRETABLA'

#Tamaño ocupado por una tabla concreta incluyendo los índices de la misma
select sum(bytes)/1024/1024 Table_Allocation_MB 
from user_segments
where segment_type in ('TABLE','INDEX') and
  (segment_name='NOMBRETABLA' or segment_name in
    (select index_name 
     from user_indexes 
     where table_name='NOMBRETABLA'))

#Tamaño ocupado por una columna de una tabla:
select sum(vsize('NOMBRECOLUMNA'))/1024/1024 MB 
from NOMBRETABLA

#Espacio ocupado por usuario:
SELECT owner, SUM(BYTES)/1024/1024 
FROM DBA_EXTENTS MB
GROUP BY owner

#Espacio ocupado por los diferentes segmentos (tablas, índices, undo, rollback, cluster, ...):
SELECT SEGMENT_TYPE, SUM(BYTES)/1024/1024 
FROM DBA_EXTENTS MB
GROUP BY SEGMENT_TYPE

#Espacio ocupado por todos los objetos de la base de datos, muestra los objetos que más ocupan primero:
SELECT SEGMENT_NAME, SUM(BYTES)/1024/1024 
FROM DBA_EXTENTS MB
GROUP BY SEGMENT_NAME
ORDER BY 2 DESC

#Obtener todas las funciones de Oracle: NVL, ABS, LTRIM, ...:
SELECT distinct object_name 
FROM all_arguments 
WHERE package_name = 'STANDARD'
order by object_name

#Obtener los roles existentes en Oracle Database:
select * from DBA_ROLES

#Obtener los privilegios otorgados a un rol de Oracle:
select privilege 
from dba_sys_privs 
where grantee = 'NOMBRE_ROL'

#Obtener la IP del servidor de la base de datos Oracle Database:
select utl_inaddr.get_host_address IP
from dual 

#Mostrar datos de auditoría de la base de datos Oracle (inicio y desconexión de sesiones):
select username, action_name, priv_used, returncode
from dba_audit_trail

#Comprobar si la auditoría de la base de datos Oracle está activada:
select name, value
from v$parameter
where name like 'audit_trail'

                                                                     
