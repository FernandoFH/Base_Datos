#Cofiguracion de entorno

Set lines 10000 pages 50000 colsep '|'  null null

#Cofiguracion de fecha
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set nls_date_format='dd/mm/yyyy';

#Validar formato
Select sysdate from dual;

#Cuenta la cantidad de tipos de Bonos - Sin Duplicados
SELECT count(DISTINCT(TIP_BONO)) FROM Bonos;

#Contamos las llamadas con fecha de escritura de ayer y Post-Proceso 1
SELECT COUNT(1) FROM PPCS_LLAMADAS WHERE TRUNC(FEH_ESCRITURA)=TRUNC(Sysdate-1) AND POSTPROCES = '1';

#Agupa y cuenta
select Cantidad, count(*) from CantidadPorAbonado group by Cantidad;

#Imprimimos en una linea campos agrupados
select A.MSISDN||'|'||rtrim (xmlagg(xmlelement (e, A.TIP_BONO || '|')).extract ('//text()'), '|')||'|' from BONOS A group by A.MSISDN;

#Buscar Nombre de la tabla con algunas letras del nombre
SELECT table_name FROM dba_tables WHERE table_name like '%CONT%';

SELECT * from TAB where Tname LIKE 'TI%' ;

#Descipcion de tabla
DESC Bonos;

#Imprime Table espace con espacios disponibles
SELECT tablespace_name, largest_free_chunk
      , nr_free_chunks, sum_alloc_blocks, sum_free_blocks
      , to_char(100*sum_free_blocks/sum_alloc_blocks, '09.99') || '%'
        AS pct_free
 FROM ( SELECT tablespace_name
             , sum(blocks) AS sum_alloc_blocks
        FROM dba_data_files
        GROUP BY tablespace_name
      )
    , ( SELECT tablespace_name AS fs_ts_name
             , max(blocks) AS largest_free_chunk
             , count(blocks) AS nr_free_chunks
             , sum(blocks) AS sum_free_blocks
                FROM dba_free_space
                GROUP BY tablespace_name )
 WHERE tablespace_name = fs_ts_name
 ORDER BY pct_free ;
 
 #Imprime Table espace especifico con espacios disponibles
  SELECT df.tablespace_name,
   df.file_name,
   df.bytes/1024 Allocated_kb,
   free.free_kb,
   Round(free.free_kb/(df.bytes/1024)*100) Percent_Free
FROM
   dba_data_files df,
   (SELECT file_id, SUM(bytes)/1024 free_kb
    FROM dba_free_space GROUP BY file_id) free
WHERE
   df.file_id=free.file_id
   AND df.tablespace_name='TABLE_SPACE'
ORDER BY
   Percent_Free;

#Lista todos los Table Space de la BBDD
select tablespace_name from dba_tablespaces;

#Ver los datafiles de un tablespace
select tablespace_name, file_name, bytes/1024/1024 from dba_data_files where tablespace_name='TTGGAA';

#Para asignar un datafile nuevo
alter database add datafile ‘/home/AR/dat_001/APP_tg_1_00.dbf’ size 100M ;   -- en este caso lo crea de 100 megas.

#Para cambiar el tamaño del datafile
alter database datafile '/home/AR/dat_001/APP_tg_1_00.dbf' resize 4G;   -- en este caso le cambia el tamaño a 4 gigas.

#Correr script externo desde sqlplus
sqlplus user/pass @/home/AR/Insert.sql

#Expresión regular
SELECT REGEXP_SUBSTR('XXXX-jjjjjjjjjjjj-uuuuu-kkk-llll','[^-]+',1,4) AS REG FROM DUAL;
##  REG
##  ---
##  kkk
SELECT REGEXP_SUBSTR('XXXX-jjjjjjjjjjjj-uuuuu-kkk-llll','[^-]+',1,5) AS REG FROM DUAL;
##  REG
##  ----
##  llll
