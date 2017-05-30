#Para poder realizar listados de tablas podemos consultar varias tablas del data dictionary:

#DBA_TABLES: Contiene todas las tablas de la base de datos
#ALL_TABLES: Contiene todas las tablas accesibles por el usuario (las propias más las que tiene permisos sobre ellas)
#USER_TABLES: Contiene totas las tablas del usuario
#DBA_SEGMENTS: Contiene todos los segmentos de la base de datos, esto incluye tablas, indices y segmentos de rollback entre otros

Select distinct(SEGMENT_TYPE) from DBA_SEGMENTS;

#OWNER: Propietario del segmento
#SEGMENT_NAME: Nombre del segmento
#TABLESPACE_NAME: Nombre del tablespace al que pertenece

Desc DBA_TABLES;

#Listar el nombre de todas las tablas de la BD Oracle:
Select TABLE_NAME from DBA_TABLES;

#Contar todas las tablas del tablespace
Select count(*) from DBA_TABLES where TABLESPACE_NAME='UNIT001';

#Contar las tablas de cada usuario
Select count(*), OWNER from DBA_TABLES group by OWNER;
