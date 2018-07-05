 #!/bin/bash
 export ANI=$1

 sqlplus user/pass <<ENDOFSQL
 set lines 500;
 set pages 500;
 colsep '|' ;
 alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
 column NUMERO_A format A11;
 column FECHA_y_HORA format A20;
 column SERVICIO format A32;
 column PL format A3;

 select A.ID_GRUPO_SERVICIO SERVICIO, A.MSISDN NUMERO_A, A.RATING_GROUP RG, A.FEH_LLAMADA FECHA_y_HORA, A.TIP_LLAMADA TIPO, A.TIP_PREPAGO PL, A.CLASE_TARIFA CT, A.ID_TIPO_DESTINO TIPO_DEST, A.TYPEOFPREPAIDUSED PT, A.GEOGRAPHICLOCATION GEO_LOC,  B.NOM_ARCHIVO from ppcs_diameter A  INNER JOIN PPCS.PPCS_ARCHIVOS B ON (A.SEC_ARCHIVO=B.SEC_ARCHIVO) where msisdn like '$ANI' order by FEH_LLAMADA;
 exit
 ENDOFSQL
