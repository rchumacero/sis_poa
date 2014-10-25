<?php
/**
*@package pXP
*@file gen-ACTDireccionGeneral.php
*@author  (admin)
*@date 25-10-2014 22:10:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDireccionGeneral extends ACTbase{    
			
	function listarDireccionGeneral(){
		$this->objParam->defecto('ordenacion','id_direccion_general');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDireccionGeneral','listarDireccionGeneral');
		} else{
			$this->objFunc=$this->create('MODDireccionGeneral');
			
			$this->res=$this->objFunc->listarDireccionGeneral($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDireccionGeneral(){
		$this->objFunc=$this->create('MODDireccionGeneral');	
		if($this->objParam->insertar('id_direccion_general')){
			$this->res=$this->objFunc->insertarDireccionGeneral($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDireccionGeneral($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDireccionGeneral(){
			$this->objFunc=$this->create('MODDireccionGeneral');	
		$this->res=$this->objFunc->eliminarDireccionGeneral($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>