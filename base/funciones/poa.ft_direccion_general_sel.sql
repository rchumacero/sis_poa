CREATE OR REPLACE FUNCTION "poa"."ft_direccion_general_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Planificación de Operaciones
 FUNCION: 		poa.ft_direccion_general_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'poa.tdireccion_general'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'poa.ft_direccion_general_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'POA_dirgen_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:10:42
	***********************************/

	if(p_transaccion='POA_dirgen_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						dirgen.id_direccion_general,
						dirgen.estado_reg,
						dirgen.estado_codigo,
						dirgen.correl_da,
						dirgen.descripcion,
						dirgen.fecha_reg,
						dirgen.id_usuario_ai,
						dirgen.usuario_ai,
						dirgen.id_usuario_reg,
						dirgen.fecha_mod,
						dirgen.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from poa.tdireccion_general dirgen
						inner join segu.tusuario usu1 on usu1.id_usuario = dirgen.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dirgen.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'POA_dirgen_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		25-10-2014 22:10:42
	***********************************/

	elsif(p_transaccion='POA_dirgen_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_direccion_general)
					    from poa.tdireccion_general dirgen
					    inner join segu.tusuario usu1 on usu1.id_usuario = dirgen.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dirgen.id_usuario_mod
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
ALTER FUNCTION "poa"."ft_direccion_general_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
