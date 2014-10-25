<?php
/**
*@package pXP
*@file gen-MODDireccionAdministrativa.php
*@author  (admin)
*@date 25-10-2014 22:11:15
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDireccionAdministrativa extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDireccionAdministrativa(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='poa.ft_direccion_administrativa_sel';
		$this->transaccion='POA_diradm_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_direccion_administrativa','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('correl_unidad','int4');
		$this->captura('descripcion','varchar');
		$this->captura('proceso_codigo','varchar');
		$this->captura('id_direccion_general','int4');
		$this->captura('estado_codigo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDireccionAdministrativa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='poa.ft_direccion_administrativa_ime';
		$this->transaccion='POA_diradm_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('correl_unidad','correl_unidad','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('proceso_codigo','proceso_codigo','varchar');
		$this->setParametro('id_direccion_general','id_direccion_general','int4');
		$this->setParametro('estado_codigo','estado_codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDireccionAdministrativa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='poa.ft_direccion_administrativa_ime';
		$this->transaccion='POA_diradm_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_direccion_administrativa','id_direccion_administrativa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('correl_unidad','correl_unidad','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('proceso_codigo','proceso_codigo','varchar');
		$this->setParametro('id_direccion_general','id_direccion_general','int4');
		$this->setParametro('estado_codigo','estado_codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDireccionAdministrativa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='poa.ft_direccion_administrativa_ime';
		$this->transaccion='POA_diradm_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_direccion_administrativa','id_direccion_administrativa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>