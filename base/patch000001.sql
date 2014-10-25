/***********************************I-SCP-RCM-POA-1-25/10/2014****************************************/
CREATE TABLE poa.tdireccion_general (
    id_direccion_general serial NOT NULL,
    descripcion varchar(100),
    estado_codigo varchar(3),
    correl_da integer,
    CONSTRAINT pk_tdireccion_general__id_direccion_general PRIMARY KEY (id_direccion_general)
) 
INHERITS (pxp.tbase) WITHOUT OIDS;

CREATE TABLE poa.tdireccion_administrativa (
    id_direccion_administrativa serial NOT NULL,
    id_direccion_general integer,
    codigo varchar(15) NOT NULL,
    descripcion varchar(150),
    correl_unidad integer,
    proceso_codigo varchar(10),
    estado_codigo varchar(3),
    CONSTRAINT pk_tdireccion_administrativa__id_direccion_administrativa PRIMARY KEY (id_direccion_administrativa)
) 
INHERITS (pxp.tbase) WITHOUT OIDS;

/***********************************F-SCP-RCM-POA-1-25/10/2014****************************************/