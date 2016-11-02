create table Clientes (
	MSISDN varchar2(15) NOT NULL,
	BONO varchar2(10),
	FECHA_UPDATE date NOT NULL,
	CONSTRAINT Clientes_pk PRIMARY KEY (MSISDN)
	);
