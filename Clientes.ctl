LOAD DATA
INFILE '/home/txtin/Clientes.txt'
INTO TABLE Clientes
fields terminated by "|"  TRAILING NULLCOLS
( MSISDN,
  Bono,
  FECHA_UPDATE "SYSDATE"
)
