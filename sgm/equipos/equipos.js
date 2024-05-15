// JavaScript Document


xmlDoc.async = false;
var option = "New";
var indCalculo = false;

//  var codEquipo;
function LimpiaF(){
formulario.TxtCodigo.value="";
formulario.txtSecuencia.value="";
//formulario.txtPatente.value="";
formulario.TxtDescripcion.value="";
formulario.TxtHorometro.value="";
formulario.TxtHorometroMan.value="";
formulario.TxtHorometroVen.value="";
formulario.TxtHorometroAlarm.value="";
//formulario.ListHorometroPadre.value="";
formulario.TxtCodEquipoPadre.value="";
formulario.TxtDesEquipoPadre.value="";
formulario.TxtFecha.value="";
formulario.TxtRutProveedor.value="";
formulario.TxtProveedor.value="";
formulario.TxtFecha.value=_hoy();
formulario.txtFechaUltima.value="";
}



function Guardar(){

	if(formulario.TxtCodigo.value=="")
					{alert("Ingrese el Codigo.");
					return;}
					
	if(formulario.TxtDescripcion.value=="")
					{alert("Ingrese la Descripción.");
					return;}

	if(indCalculo==true){
			x=confirm("Desea Actualizar la fecha de Vencimiento");
			if(!x)
				return;
			}
			
	indCalculo=false;
	
	xmlTemp.async=false;
	var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=existeEquipo&CODIGO=" + formulario.TxtCodigo.value;
		url += "&FAENA=" + getEmpresa();
		url += "&VTZ=" + Math.random(); 
		
		
    xmlestado = xmlDso.load(url);
	if (xmlestado){
			var tree = xmlDso.documentElement;
    	    var node = tree.childNodes.item(0);
			}
	else
		window.open(url);
	    
				
if (getChildNodeValue(node,"RETURN")=="NOT")
			NewEquipo();
else
	if (option=="Edit")
					UpdateEquipo();
			else
					alert("Codigo de equipo existente!");
			
option = "New"
formulario.TxtCodigo.focus();

}

function GetEquipo(){

	xmlDoc.async=false;
	var xmlDso = xmlDoc.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=GetEquipo&CODIGO=" + formulario.TxtCodigo.value;
	 	url += "&FAENA=" + getEmpresa();
		url += "&VTZ=" + Math.random();
		
    xmlestado = xmlDso.load(url);
	if (!xmlestado)
				window.open(url);
	
//	var obj = document.getElementById("TabEquipos");
//	setTimeout("TabEquipos.ActualizaGrid(formulario.TxtCodigo.value);",700);

	setTimeout("changeTipoHrm();",500);
	setTimeout("listArchivos();",500);

//	alert( "TabEquipos.html?CODIGO=" + formulario.TxtCodigo.value);

option = "Edit";

}

function color(){

//return;
var myDate = new Date();

var difer = formulario.TxtHorometroVen.value-formulario.TxtHorometro.value;

if (parseFloat(difer)<=0)
		formulario.TxtHorometroVen.style.color='#FF0000';


if (!formulario.TxtHorometroVen.value)
			return;
			
if (formulario.listTipoHr.value=='CRO'){
			formulario.TxtHorometro.value = _hoy();
			myDate.setTime(formulario.TxtHorometroVen.value);
  		 	formulario.TxtHorometroVen.value= formatoFechaCorta(myDate);

			if(formulario.listEscala.value=='H')
				formulario.TxtHorometroMan.value = (formulario.TxtHorometroMan.value)/(1000*60*60);
				
			if(formulario.listEscalaAlr.value=='H')
				formulario.TxtHorometroAlarm.value = (formulario.TxtHorometroAlarm.value)/(1000*60*60);

				
			if(formulario.listEscala.value=='D')
				formulario.TxtHorometroMan.value = (formulario.TxtHorometroMan.value)/(1000*60*60*24);
				
			if(formulario.listEscalaAlr.value=='D')
				formulario.TxtHorometroAlarm.value = (formulario.TxtHorometroAlarm.value)/(1000*60*60*24);
		
				
			if(formulario.listEscala.value=='M')
				formulario.TxtHorometroMan.value = (formulario.TxtHorometroMan.value)/(1000*60*60*24*30.41666);
				
			if(formulario.listEscalaAlr.value=='M')
				formulario.TxtHorometroAlarm.value = (formulario.TxtHorometroAlarm.value)/(1000*60*60*24*30.41666);

				
			if(formulario.listEscala.value=='A')
				formulario.TxtHorometroMan.value = (formulario.TxtHorometroMan.value)/(1000*60*60*24*30.41666*12);

			if(formulario.listEscalaAlr.value=='A')
				formulario.TxtHorometroAlarm.value = (formulario.TxtHorometroAlarm.value)/(1000*60*60*24*30.41666*12);

		}

}


function calcular(){
	var myDate = new Date();
	
		switch (formulario.listEscala.value){
		
			case "H" :
				HorometroMan = formulario.TxtHorometroMan.value*1000*60*60;
				break;
				
			case "D" :
				HorometroMan = formulario.TxtHorometroMan.value*1000*60*60*24;
				break;
				
			case "M" :
				HorometroMan = formulario.TxtHorometroMan.value*1000*60*60*24*30.41666;
				break;
				
			case "A" :
				HorometroMan = formulario.TxtHorometroMan.value*1000*60*60*24*30.41666*12;
				break;
			}
			
		if (confirm("Desea Calcular la fecha de Vencimiento desde la ultima mantención")){
				if(formulario.TxtFechaUltMan.value!=""){
							var FechaUltMan = formulario.TxtFechaUltMan.value;
							var myDate = new Date(FechaUltMan.substr(6,4), 
								FechaUltMan.substr(3,2)-1,
								FechaUltMan.substr(0,2))
								}

				}
				
		myDate.setTime(myDate.getTime() + HorometroMan);				
		formulario.TxtHorometroVen.value = formatoFechaCorta(myDate);
			
		indCalculo = true;	
}


function ListEquipo(){
	var xmlDso = xmlDoc.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=GetEquipo";
		url += "&VTZ=" + Math.random();
    //window.open(url);
	xmlestado = xmlDso.load(url);
}

function DelEquipo()
{
	var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=DelEquipo&CODIGO=" + formulario.TxtCodigo.value;
    //window.open(url);
	if(confirm("Desea Eliminar?")){
		xmlestado = xmlDso.load(url);
		if (!xmlestado)
				window.open(url);
		else{
			alert("Equipo Eliminado.");
			LimpiaF();
			option = "New"
			}
	}
}


function listArchivos(){
	xmlImages.async = false;
	var xmlDso = xmlImages.XMLDocument;
	var url = "xml/archivos.asp?RECURSO=listArchivos";
		url += "&FAMILIA=EQUIPOS"; 
		url += "&IDENTIFICADOR="+formulario.TxtCodigo.value;
		url += "&VTZ=" + Math.random();
    
	xmlestado = xmlImages.load(url);
	//window.open(url);
	if(!xmlestado){
			window.open(url);}
	else{		
	   total_registros_lista = xmlImages.documentElement.childNodes.length;
		document.getElementById("ID_list_cant_reg").innerText = total_registros_lista;
		bloque_listado = 1;
		total_bloque_listado = Math.ceil(total_registros_lista/1);
		var objLabelReg = document.getElementById("ID_list_fraccion_reg");
		objLabelReg.innerText = "1/" + total_bloque_listado;
		}

}


function newFile(){
document.frameFiles.mostrarVentana(formulario.TxtCodigo,"EQUIPOS",divFiles);
}

function delFile(){
xmlImages.async = false;
	var xmlDso = xmlImages.XMLDocument;
	var url = "xml/archivos.asp?RECURSO=delFile";
		url += "&FAMILIA=EQUIPOS"; 
		url += "&IDENTIFICADOR="+formulario.TxtCodigo.value;
		url += "&ID=" + document.getElementById("txtID").innerText;
		url += "&VTZ=" + Math.random();
    
	xmlestado = xmlImages.load(url);
	//window.open(url);
	if(!xmlestado){
			window.open(url);
		}

listArchivos();
}

function NewEquipo(){		

	if(formulario.listTipos.value=="SEL"){
						alert("Seleccione el Tipo de Equipo");
						return;
						}
															
	if (formulario.listTipoHr.value=='CRO'){
		Horometro = (new Date()).getTime();
		sHorometroVen =formulario.TxtHorometroVen.value;
		HorometroVen = (new Date(sHorometroVen.substr(6,4), 
								sHorometroVen.substr(3,2)-1,
								sHorometroVen.substr(0,2))).getTime();
																	
		switch (formulario.listEscala.value){
			case "D" :
				HorometroMan 	= formulario.TxtHorometroMan.value*1000*60*60*24;	
				break;
			case "M" :
				HorometroMan 	= formulario.TxtHorometroMan.value*1000*60*60*24*30.41666;
				break;
			case "A" :
				HorometroMan 	= formulario.TxtHorometroMan.value*1000*60*60*24*30.41666*12;
				break;
			}

		switch (formulario.listEscalaAlr.value){
			case "D" :
				HorometroAlarm 	= formulario.TxtHorometroAlarm.value*1000*60*60*24;			
				break;
			case "M" :
				HorometroAlarm 	=  formulario.TxtHorometroAlarm.value*1000*60*60*24*30.41666;
				break;
			case "A" :
				HorometroAlarm 	=  formulario.TxtHorometroAlarm.value*1000*60*60*24*30.41666*12;
				break;
			}
	
	if (!formulario.TxtHorometroVen.value){
				HorometroMan = '';
				HorometroVen = '';
				Horometro = '';
				HorometroAlarm = '';
			}	
			
	}
	else{
		HorometroMan = formulario.TxtHorometroMan.value;
		HorometroVen = formulario.TxtHorometroVen.value;
		Horometro = formulario.TxtHorometro.value;
		HorometroAlarm = formulario.TxtHorometroAlarm.value;
		}
				
	var xmlDso = xmlDoc.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=NewEquipo&CODIGO=" + formulario.TxtCodigo.value;
		url += "&COD_EQUIPO_PADRE=" + formulario.TxtCodEquipoPadre.value;
		url += "&ESTADO=" + formulario.ListEstado.value;
		url += "&DESCRIPCION=" + formulario.TxtDescripcion.value;
		url += "&DIMENSIONES=" + formulario.txtDimensiones.value;
		url += "&HOROMETRO=" + Horometro;
		url += "&HOROMETRO_MAN=" + HorometroMan;
		url += "&HOROMETRO_VEN=" + HorometroVen;
		url += "&HOROMETRO_ALARM=" + HorometroAlarm;
		//url += "&HOROMETRO_PADRE=" + formulario.ListHorometroPadre.value;
		url += "&HOROMETRO_PADRE=MOT";
 	    url += "&FECHA=" + formulario.TxtFecha.value;
		url += "&TIPO_HOR=" + formulario.listTipoHr.value;
		url += "&TIPO_EQUIPO=" + formulario.listTipos.value;
		//url += "&TIPO_COMBUSTIBLE=" + formulario.listCombustible.value;
		//url += "&ESCALA=" + formulario.listEscala.value;
		url += "&ESCALA_ALARM=" + formulario.listEscalaAlr.value;
		url += "&ANCHO=" + formulario.txtAncho.value.replace(",",".");
		url += "&ESPESOR=" + formulario.txtEspesor.value;
		url += "&ESPESOR_R=" + formulario.txtEspesorR.value;
		url += "&FECHA_ULT_MAN=" + formulario.txtFechaUltima.value;
		url += "&GSAP=" + formulario.txtGSAP.value;
		url += "&RUT_PROVEEDOR=" + getNumberRut(formulario.TxtRutProveedor.value);
		//url += "&RESPONSABLE=" + formulario.txtResponsable.value;
		url += "&UBICACION=" + formulario.ListFaenas.value;
		//url += "&POLIZA=" + formulario.txtPoliza.value;
		url += "&SECCION=" + formulario.ListSecciones.value;
		url += "&CRITICIDAD=" + formulario.txtCriticidad.value;
		url += "&OBSERVACION=" + scape(formulario.txtObservacion.value);
		url += "&MARCA=" + formulario.txtMarca.value;
		url += "&MODELO=" + formulario.txtModelo.value;
		url += "&SECUENCIA=" + formulario.txtSecuencia.value;
		url += "&VTZ=" + Math.random();

		//url += "&VALOR_NETO=" + formulario.txtValorNeto.value;		
   		
		//formulario.txtObservacion.value
	    xmlestado = xmlDso.load(url);		
		
	    if (!xmlestado){
				window.open(url);
				return;}
				
		var url = "xml/equipos.asp?RECURSO=NewEquipoUsuario"
			url += "&CODIGO=" + formulario.TxtCodigo.value;
			url += "&USUARIO=" + GetSession();
			url += "&TIPO_HOR=" + formulario.listTipoHr.value;
			url += "&VTZ=" + Math.random();
	
		xmlestado = xmlDso.load(url);
	
	    if (!xmlestado)
				window.open(url);
		else{
			alert("Equipo Ingresado.");
			LimpiaF();
			}
}




function UpdateEquipo(){


	if (formulario.listTipoHr.value=='CRO'){
		Horometro = (new Date()).getTime();
		sHorometroVen = formulario.TxtHorometroVen.value;
		HorometroVen = (new Date(sHorometroVen.substr(6,4), 
								sHorometroVen.substr(3,2)-1,
								sHorometroVen.substr(0,2))).getTime();
								
/*		switch (formulario.listEscala.value){
			case "D" :
				HorometroMan 	= formulario.TxtHorometroMan.value*1000*60*60*24;	
				break;
			case "M" :
				HorometroMan 	= formulario.TxtHorometroMan.value*1000*60*60*24*30.41666;
				break;
			case "A" :
				HorometroMan 	= formulario.TxtHorometroMan.value*1000*60*60*24*30.41666*12;
				break;
			}*/

		switch (formulario.listEscalaAlr.value){
			case "D" :
				HorometroAlarm 	= formulario.TxtHorometroAlarm.value*1000*60*60*24;			
				break;
			case "M" :
				HorometroAlarm 	=  formulario.TxtHorometroAlarm.value*1000*60*60*24*30.41666;
				break;
			case "A" :
				HorometroAlarm 	=  formulario.TxtHorometroAlarm.value*1000*60*60*24*30.41666*12;
				break;
			}

  if (!formulario.TxtHorometroVen.value){
				HorometroMan = '';
				HorometroVen = '';
				Horometro = '';
				HorometroAlarm = '';
			}
		
	}
	else{
		HorometroMan = formulario.TxtHorometroMan.value;
		HorometroVen = formulario.TxtHorometroVen.value;
		Horometro = formulario.TxtHorometro.value;
		HorometroAlarm = formulario.TxtHorometroAlarm.value;
		}
		


	xmlDoc.async=false;
	var xmlDso = xmlDoc.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=UpdateEquipo&CODIGO=" + formulario.TxtCodigo.value;
		url += "&COD_EQUIPO_PADRE=" + formulario.TxtCodEquipoPadre.value;
		url += "&CAPACIDAD=" + formulario.txtCapacidad.value;
		url += "&ESTADO=" + formulario.ListEstado.value;
		url += "&DESCRIPCION=" + formulario.TxtDescripcion.value;
		url += "&DIMENSIONES=" + formulario.txtDimensiones.value;
		url += "&HOROMETRO=" + Horometro;
		url += "&HOROMETRO_MAN=" + HorometroMan;
		url += "&HOROMETRO_VEN=" + HorometroVen;
		url += "&HOROMETRO_ALARM=" + HorometroAlarm;
		//url += "&HOROMETRO_PADRE=" + formulario.ListHorometroPadre.value;
 	    url += "&FECHA=" + formulario.TxtFecha.value;
		url += "&FECHA_INST=" + formulario.TxtFechaInstalacion.value;
		url += "&GSAP=" + formulario.txtGSAP.value;
		url += "&TIPO_HOR=" + formulario.listTipoHr.value;
		url += "&TIPO_EQUIPO=" + formulario.listTipos.value;
		url += "&FAENA=" + getEmpresa();
		//url += "&ESCALA=" + formulario.listEscala.value;
		url += "&ESCALA_ALARM=" + formulario.listEscalaAlr.value;
		url += "&ANCHO=" + formulario.txtAncho.value.replace(",",".");
		url += "&ESPESOR=" + formulario.txtEspesor.value;
		url += "&ESPESOR_R=" + formulario.txtEspesorR.value;
		url += "&FECHA_ULT_MAN=" + formulario.txtFechaUltima.value;
		//url += "&GRUPO=" + formulario.ListGrupo.value;
		url += "&RUT_PROVEEDOR=" + getNumberRut(formulario.TxtRutProveedor.value);
		//url += "&RESPONSABLE=" + formulario.txtResponsable.value;
		
		url += "&UBICACION=" + formulario.ListFaenas.value;
		url += "&SECCION=" + formulario.ListSecciones.value;
		url += "&CRITICIDAD=" + formulario.txtCriticidad.value.replace(',','.');
		url += "&OBSERVACION=" + scape(formulario.txtObservacion.value);
		url += "&MARCA=" + formulario.txtMarca.value;
		url += "&MODELO=" + formulario.txtModelo.value;
		url += "&VIDA_UTIL=" + formulario.txtVidaUtil.value;
		url += "&TON_SEMANAL=" + formulario.txtTonSemanal.value;
		url += "&SECUENCIA=" + formulario.txtSecuencia.value;
		url += "&VTZ=" + Math.random();
		
		//url += "&VALOR_NETO=" + formulario.txtValorNeto.value;
					
		//window.open(url);
		//alert(url);
	    xmlestado = xmlDso.load(url);
	    if (!xmlestado)
				window.open(url);
		else{
			alert("Equipo Actualizado.");
			option = "New"
			LimpiaF();
			}
			
}

function ListTipos(){

  xmlTemp.async = false;
  var xmlDso =  xmlTemp.XMLDocument;
  var url = "xml/Equipos.asp?RECURSO=ListTipos";
 	  url += "&VTZ=" + Math.random();
	  	  
  var res = xmlDso.load(url);

  if (res){
    	     var tree = xmlDso.documentElement;
 			  opcion = new Option("SELECCIONAR" ,"SEL");
				if (opcion.value == "SEL") opcion.selected = true;
	            formulario.listTipos.options[0] = opcion; 
				
	          for(var i = 1; i < tree.childNodes.length+1; i++){
    	        var node = tree.childNodes.item(i-1);
        	    opcion = new Option(getChildNodeValue(node,"DESCRIPCION") ,getChildNodeValue(node,"CODIGO"));
	            formulario.listTipos.options[i] = opcion;
 			 }
    	  }
	else
	  window.open(url);
	
 }
 
function ListGrupos(){
	var xmlDso = xmlList.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=ListGrupos";
   //window.open(url);
	 xmlDso.async = false;
	res = xmlDso.load(url);
	if (res){
          var tree = xmlDso.documentElement;
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"DESCRIPCION"),getChildNodeValue(node,"CODIGO"));
            if (opcion.value == "0") opcion.selected = true;
            formulario.ListGrupo.options[i] = opcion;   
          }
                 
         }
}

function ListHorometros(_modo){

return;
	var xmlDso = xmlList.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=ListHorometros";
	
	//alert(_modo);
	if (_modo==1)
		url += "&COD_EQUIPO="+ formulario.TxtCodigo.value;
	else
		url += "&COD_EQUIPO="+ formulario.TxtCodEquipoPadre.value;
		
//   window.open(url);
	formulario.ListHorometroPadre.options.length = 0;
	xmlDso.async = false;
	res = xmlDso.load(url);
	if (res){
          var tree = xmlDso.documentElement;
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"DESCRIPCION"),getChildNodeValue(node,"CODIGO"));
            formulario.ListHorometroPadre.options[i] = opcion;   
          }
                 
         }
		 formulario.ListHorometroPadre.value = formulario.TxtCodHorometro.value;
		 
}



function GetProv()
{
//Function dual para evitar error javascript
}

function verActividades(){
var url = "Actividades.html?Equipo=" + formulario.TxtCodigo.value;
	url += "&Descripcion=" + formulario.TxtDescripcion.value;
window.location.href=url;
}


function verLayout(){
	
	frameLayout.showWin(formulario.TxtCodigo.value, divLayout);
	
	
}


function verHistorial(){
var url = "informes/HistorialMan.html?EQUIPO=" + formulario.TxtCodigo.value;
window.location.href=url;
}

function verSubEquipos(){
var url = "TabEquipos.html?CodEquipo=" + formulario.TxtCodigo.value;
window.location.href=url;
}

function  clrModelo(){
	formulario.txtModelo.value="";
}


function inicio(){
var parametro = getParametro("CODIGO");
if (parametro){
		formulario.TxtCodigo.value = parametro;
		GetEquipo();
		}
		
formulario.TxtFecha.value=_hoy();
ListTipos();
listFaenas();
listSecciones();
}

function listFaenas(){
       xmlListFaenas.async = false;
        var xmlDso =  xmlListFaenas.XMLDocument;
		var url = "xml/Usuarios.asp?RECURSO=listFaenas";
			url +="&ID=" + GetSession();
			
        var res = xmlDso.load(url);
        if (res){
          var tree = xmlDso.documentElement;
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"DESCRIPCION"),getChildNodeValue(node,"DESCRIPCION"));
            if (opcion.value == empresa) opcion.selected = true;
          	formulario.ListFaenas.options[i] = opcion;   
          			}
		  }
		 else
		 	window.open(url); 
}

function listSecciones(){
       xmlListFaenas.async = false;
        var xmlDso =  xmlListFaenas.XMLDocument;
		var url = "xml/Secciones.asp?RECURSO=listSecciones";
			url += "&FAENA=" + empresa;
			
        var res = xmlDso.load(url);
        if (res){
          var tree = xmlDso.documentElement;
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"DESCRIPCION"),getChildNodeValue(node,"CODIGO"));
            if (opcion.value == empresa) opcion.selected = true;
          	formulario.ListSecciones.options[i] = opcion;   
          			}
		  }
		 else
		 	window.open(url); 
}

function changeTipoHrm(){

return;

if (formulario.listTipoHr.value=='SEC'){
	formulario.listEscala.value='H';
	formulario.listEscala.disabled=true;
	formulario.listEscalaAlr.value='H';
	formulario.listEscalaAlr.disabled=true;
	}
else{
	formulario.listEscala.disabled=false;
	formulario.listEscalaAlr.disabled=false;
	}
}
