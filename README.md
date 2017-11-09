# PL-SQL
Oracle SQL Examples

- **Anotaciones_Sql.sql** Notas de Arquitectura de BBDD y Querys en general. 
- **Clientes.txt** Son los datos que se van a cargar en la BBDD, la data.
- **Consultas_Utiles.sql** Consultas sobre la infraestructura de DB 
- **Create_Clientes.sql** Es la creacion de la tabla.
- **Clientes.ctl** Archivo de cofiguracion de los parametros en la BBDD _Simple!!_
- **Listar_Tablas.sql** Consultas sobres las tablas de BD de Oracle 


- Se ejecuta desde consola con el siguiente formato:

sqlldr user/pass control=/home/CTLs/Clientes.ctl DATA=/home/txtin/Clientes.txt log=/home/LOGs/logs.log bad=/home/txtout/err.bad rows=5000 errors=99999
