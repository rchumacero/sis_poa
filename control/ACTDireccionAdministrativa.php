<?php
/**
*@package pXP
*@file gen-ACTDireccionAdministrativa.php
*@author  (admin)
*@date 25-10-2014 22:11:15
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDireccionAdministrativa extends ACTbase{    
			
	function listarDireccionAdministrativa(){
		$this->objParam->defecto('ordenacion','id_direccion_administrativa');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_direccion_general')!=''){
			$this->objParam->addFiltro("diradm.id_direccion_general = ".$this->objParam->getParametro('id_direccion_general'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDireccionAdministrativa','listarDireccionAdministrativa');
		} else{
			$this->objFunc=$this->create('MODDireccionAdministrativa');
			
			$this->res=$this->objFunc->listarDireccionAdministrativa($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDireccionAdministrativa(){
		$this->objFunc=$this->create('MODDireccionAdministrativa');	
		if($this->objParam->insertar('id_direccion_administrativa')){
			$this->res=$this->objFunc->insertarDireccionAdministrativa($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDireccionAdministrativa($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDireccionAdministrativa(){
			$this->objFunc=$this->create('MODDireccionAdministrativa');	
		$this->res=$this->objFunc->eliminarDireccionAdministrativa($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>