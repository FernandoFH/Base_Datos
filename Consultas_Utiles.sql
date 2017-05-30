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
