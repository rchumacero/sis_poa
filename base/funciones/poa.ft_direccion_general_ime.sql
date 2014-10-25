CREATE OR REPLACE FUNCTION "poa"."ft_direccion_general_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Planificación de Operaciones
 FUNCION: 		poa.ft_direccion_general_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'poa.tdireccion_general'
 AUTOR: 		 (admin)
 FECHA:	        25-10-2014 22:10:42
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
	v_id_direccion_general	integer;
			    
BEGIN

    v_nombre_funcion = 'poa.ft_direccion_general_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'POA_dirgen_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:10:42
	***********************************/

	if(p_transaccion='POA_dirgen_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into poa.tdireccion_general(
			estado_reg,
			estado_codigo,
			correl_da,
			descripcion,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.estado_codigo,
			v_parametros.correl_da,
			v_parametros.descripcion,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null
							
			
			
			)RETURNING id_direccion_general into v_id_direccion_general;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dirección General almacenado(a) con exito (id_direccion_general'||v_id_direccion_general||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_direccion_general',v_id_direccion_general::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'POA_dirgen_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:10:42
	***********************************/

	elsif(p_transaccion='POA_dirgen_MOD')then

		begin
			--Sentencia de la modificacion
			update poa.tdireccion_general set
			estado_codigo = v_parametros.estado_codigo,
			correl_da = v_parametros.correl_da,
			descripcion = v_parametros.descripcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_direccion_general=v_parametros.id_direccion_general;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dirección General modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_direccion_general',v_parametros.id_direccion_general::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'POA_dirgen_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:10:42
	***********************************/

	elsif(p_transaccion='POA_dirgen_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from poa.tdireccion_general
            where id_direccion_general=v_parametros.id_direccion_general;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Dirección General eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_direccion_general',v_parametros.id_direccion_general::varchar);
              
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
ALTER FUNCTION "poa"."ft_direccion_general_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
