CREATE OR REPLACE FUNCTION "poa"."ft_direccion_administrativa_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Planificación de Operaciones
 FUNCION: 		poa.ft_direccion_administrativa_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'poa.tdireccion_administrativa'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'poa.ft_direccion_administrativa_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'POA_diradm_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:11:15
	***********************************/

	if(p_transaccion='POA_diradm_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						diradm.id_direccion_administrativa,
						diradm.estado_reg,
						diradm.codigo,
						diradm.correl_unidad,
						diradm.descripcion,
						diradm.proceso_codigo,
						diradm.id_direccion_general,
						diradm.estado_codigo,
						diradm.fecha_reg,
						diradm.id_usuario_ai,
						diradm.id_usuario_reg,
						diradm.usuario_ai,
						diradm.fecha_mod,
						diradm.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from poa.tdireccion_administrativa diradm
						inner join segu.tusuario usu1 on usu1.id_usuario = diradm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = diradm.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'POA_diradm_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:11:15
	***********************************/

	elsif(p_transaccion='POA_diradm_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_direccion_administrativa)
					    from poa.tdireccion_administrativa diradm
					    inner join segu.tusuario usu1 on usu1.id_usuario = diradm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = diradm.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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
ALTER FUNCTION "poa"."ft_direccion_administrativa_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
