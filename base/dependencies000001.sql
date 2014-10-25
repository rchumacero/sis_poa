/***********************************I-DEP-RCM-POA-1-25/10/2014*****************************************/
ALTER TABLE ONLY poa.tdireccion_administrativa
    ADD CONSTRAINT fk_tdireccion_administrativa__id_direccion_general
    FOREIGN KEY (id_direccion_general) REFERENCES poa.tdireccion_general(id_direccion_general);
/***********************************F-DEP-RCM-POA-1-25/10/2014*****************************************/