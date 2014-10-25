/***********************************I-DAT-RCM-POA-1-25/10/2014*****************************************/

--CREACION DEL SISTEMA
--INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
--VALUES (E'POA', E'Planificación de Operaciones', E'2014-10-25', E'POA', E'activo', E'poa', NULL);

--DEFINICION DE INTERFACES
select pxp.f_insert_tgui ('PLANIFICACIÓN DE OPERACIONES', '', 'POA.1', 'si',1 , '', 1, '../../../lib/imagenes/alma32x32.png', '', 'POA');
select pxp.f_insert_tgui ('Catálogos', 'Catálogos', 'POA.1.1', 'si', 1, '', 2, '', '', 'POA');
select pxp.f_insert_tgui ('Dirección General', 'Interfaz para el registro de Dirección General', 'POA.1.1.1', 'si', 1, 'sis_poa/vista/direccion_general/DireccionGeneral.php', 3, '', 'DireccionGeneral', 'POA');

select pxp.f_insert_testructura_gui ('POA', 'SISTEMA');
select pxp.f_insert_testructura_gui ('POA.1', 'POA');
select pxp.f_insert_testructura_gui ('POA.1.1', 'POA.1');
select pxp.f_insert_testructura_gui ('POA.1.1.1', 'POA.1.1');


/***********************************F-DAT-RCM-POA-1-25/10/2014*****************************************/