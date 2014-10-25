CREATE OR REPLACE FUNCTION "poa"."ft_direccion_administrativa_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Planificación de Operaciones
 FUNCION: 		poa.ft_direccion_administrativa_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'poa.tdireccion_administrativa'
 AUTOR: 		 (admin)
 FECHA:	        25-10-2014 22:11:15
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_direccion_administrativa	integer;
			    
BEGIN

    v_nombre_funcion = 'poa.ft_direccion_administrativa_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'POA_diradm_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:11:15
	***********************************/

	if(p_transaccion='POA_diradm_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into poa.tdireccion_administrativa(
			estado_reg,
			codigo,
			correl_unidad,
			descripcion,
			proceso_codigo,
			id_direccion_general,
			estado_codigo,
			fecha_reg,
			id_usuario_ai,
			id_usuario_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.codigo,
			v_parametros.correl_unidad,
			v_parametros.descripcion,
			v_parametros.proceso_codigo,
			v_parametros.id_direccion_general,
			v_parametros.estado_codigo,
			now(),
			v_parametros._id_usuario_ai,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_direccion_administrativa into v_id_direccion_administrativa;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dirección Administrativa almacenado(a) con exito (id_direccion_administrativa'||v_id_direccion_administrativa||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_direccion_administrativa',v_id_direccion_administrativa::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'POA_diradm_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:11:15
	***********************************/

	elsif(p_transaccion='POA_diradm_MOD')then

		begin
			--Sentencia de la modificacion
			update poa.tdireccion_administrativa set
			codigo = v_parametros.codigo,
			correl_unidad = v_parametros.correl_unidad,
			descripcion = v_parametros.descripcion,
			proceso_codigo = v_parametros.proceso_codigo,
			id_direccion_general = v_parametros.id_direccion_general,
			estado_codigo = v_parametros.estado_codigo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_direccion_administrativa=v_parametros.id_direccion_administrativa;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dirección Administrativa modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_direccion_administrativa',v_parametros.id_direccion_administrativa::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'POA_diradm_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:11:15
	***********************************/

	elsif(p_transaccion='POA_diradm_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from poa.tdireccion_administrativa
            where id_direccion_administrativa=v_parametros.id_direccion_administrativa;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dirección Administrativa eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_direccion_administrativa',v_parametros.id_direccion_administrativa::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "poa"."ft_direccion_administrativa_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
