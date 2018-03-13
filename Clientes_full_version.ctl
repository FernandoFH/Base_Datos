LOAD DATA
INFILE 'Clientes.dat'
BADFILE 'Clientes.bad'
DISCARDFILE 'Clientes.dsc'
APPEND
INTO TABLE Clientes
fields terminated by "|"  TRAILING NULLCOLS
( MSISDN,
  Bono,
  FECHA_UPDATE "SYSDATE"
)
