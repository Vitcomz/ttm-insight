<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<TITLE>Bitacora</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Cache-Control" content="no-cache">




</HEAD>
<STYLE TYPE="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {
	color: #FF0000;
	font-weight: bold;
}
-->
</STYLE>
<xml id = xmlNew></xml>
<xml id = xmlResponsables></xml>
<xml id = xmlTemp></xml>
<xml id = xmlImages></xml>
<xml id = xmlDel></xml>
<LINK REL="stylesheet" HREF="standard/menu.css" TYPE="text/css">
<LINK REL="stylesheet" HREF="sci.css" TYPE="text/css">
<script type="text/javascript" src="/Scripts/deteccion.js"></script>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="standard/coolmenus4.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="standard/vitcomz.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">

  mydate = new Date();
  hour      = mydate.getHours();
  minute    = mydate.getMinutes();
  day_month = mydate.getDate();
  month     = mydate.getMonth()+1;
  year      = mydate.getYear();    
  day       = mydate.getDay(); 
  indHorometro = false;
  var _opener = dialogArguments;
  var indOT;

function guardar(){


if (getParametro("ROL")=='INVITADO'){
					alert("No tiene privilegios suficientes para realizar esta acci�n");
					return;
					}

if (!formulario.txtCodEquipo.value){
				alert('Ingrese el equipo.');
				return;}

//alert(formulario.txtEquipoPrincipal.value);
if (!formulario.txtEquipoPrincipal.value){
				alert('Debe atribuir la inspeccion al componenete, no al equipo principal.');
				return;}
				
				
if (formulario.txtID.value)
		updateBitacora(formulario.txtID.value);
else
		newBitacora();

}

function danhos(){
if(!formulario.txtID.value){
		alert("Debe guardar antes.");
		return;
		}
		
formulario.chkIncidente.checked=true;
frameDanos.mostrarVentana(formulario.txtID,formulario.txtEquipo, divDanos,'');

}
							  
function inicio(){

ListHoras();

formulario.TxtObservacion.value="";
formulario.TxtObservacion.focus();

if (getParametro("ID")){
		getBitacora(getParametro("ID"));
		formulario.txtID.value = getParametro("ID");
		return;
		}
			
if (getParametro("COD_EQUIPO")){
		formulario.txtCodEquipo.value = getParametro("COD_EQUIPO");
		formulario.txtEquipo.value = getParametro("EQUIPO");
		}

if (getParametro("IND_OT")){
					indOT = true;
					formulario.ChkIncidente.checked=true;
					}
					
if ((hour+"").length==1) hour = '0' + hour;
formulario.ListHora.value = hour;
var fiveMin=minute/5;		
fiveMin=parseInt(fiveMin)*5;		
if ((day_month+"").length==1) day_month ='0'+day_month;
if ((month+"").length==1) month ='0' + month;
if ((fiveMin+"").length==1) fiveMin ='0'+fiveMin;
formulario.ListMin.value = fiveMin;
formulario.txtFecha.value = day_month + "/" + month +"/"+ year;
document.getElementById("idResponsable").innerText = GetSession();


}

function ListHoras(){

var sHora="";

var Hora = 0
 for(var i = 0; i < 24; i++){
	   if ((Hora+"").length==1) sHora = '0' + Hora;
	   else	sHora = Hora;
       opcion = new Option(sHora,sHora);
	   formulario.ListHora.options[i] = opcion; 
	   Hora = Hora +1;
	}

var sMin ="";
var Min=0;

for(var i = 0; i < 12; i++){
	   if ((Min+"").length==1) sMin = '0' + Min;
	   else	sMin = Min;
       opcion = new Option(sMin,sMin);
	   formulario.ListMin.options[i] = opcion; 
 	Min = Min + 5;
	}
	
} 
 
function newBitacora(){

 /*
 var tbl = document.getElementById('tabCheckList');
 
 var lastRow = tbl.rows.length;
 for (i=0; i<lastRow; i++){
		if(tbl.rows[i].children[0])
			if(tbl.rows[i].children[0].children[0].checked==false)
								formulario.chkIncidente.checked=true;
			
		if(tbl.rows[i].children[1])
			if(tbl.rows[i].children[1].children[0].checked==false)
								formulario.chkIncidente.checked=true;
			
		if(tbl.rows[i].children[2])
			if(tbl.rows[i].children[2].children[0].checked==false)
								formulario.chkIncidente.checked=true;
		
		if(tbl.rows[i].children[3])
			if(tbl.rows[i].children[3].children[0].checked==false)
								formulario.chkIncidente.checked=true;
		

		 }
	
if (formulario.chkIncidente.checked==true)
	if(formulario.TxtObservacion.value.length<3){
		alert("Debe Ingresar una Observaci�n.");
		return;
		}
	*/
						
	xmlNew.async = false;
	var xmlDso = xmlNew.XMLDocument;
	var url = "xml/Bitacoras.asp?RECURSO=NewBitacora";
		url +="&FECHA=" + formulario.txtFecha.value.substr(0,10) + 
			 " " + formulario.ListHora.value + ":" + formulario.ListMin.value;
		//url += "&TURNO=" + formulario.ListTurnos.value;
		url += "&EJECUTOR=" + formulario.listEjecutor.value;
		url += "&ULT_INSPECCION=" + formulario.txtUltInspeccion.value;
		url += "&EQUIPO=" + formulario.txtCodEquipo.value;
		url += "&USERNAME=" + GetSession();
		url += "&DESCRIPCION=" + scape(formulario.TxtObservacion.value);
		url += "&RECOMENDACION=" + scape(formulario.TxtRecomendacion.value);
		url += "&CAUSA=" + scape(formulario.TxtCausa.value);
		url += "&IND_INCIDENTE=" + formulario.chkIncidente.checked;
		url += "&IND_SOLUCION=" + formulario.chkSolucion.checked;
		url += "&FAENA=" + getEmpresa();
		url += "&REPORT=" + formulario.txtReport.value;
		//url += "&COMBUSTIBLE=" + formulario.txtCombustible.value.replace(",",".");
		//url += "&VALOR_COMBUSTIBLE=" + formulario.txtValorCombustible.value.replace(",",".");
		//url += "&DOC_COMBUSTIBLE=" + formulario.txtDocCombustible.value.replace(",",".");
		
		xmlestado = xmlDso.load(url);
		
		if (!xmlestado)
			window.open(url);	

	//alert(xmlDso.documentElement.childNodes.item(0).text);
	formulario.txtID.value = xmlDso.documentElement.childNodes.item(0).text;
			
		
}


function updateBitacora(ID){

		 		
	xmlTemp.async = false;
	var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Bitacoras.asp?RECURSO=UpdateBitacora";
		url += "&ID=" + ID;
		url += "&FECHA=" + formulario.txtFecha.value.substr(0,10) +
		" " + formulario.ListHora.value + ":" + formulario.ListMin.value;
		url += "&ULT_INSPECCION=" + formulario.txtUltInspeccion.value;
		url += "&EQUIPO=" + formulario.txtCodEquipo.value;
		//url += "&TURNO=" + formulario.ListTurnos.value;
		url += "&EJECUTOR=" + formulario.listEjecutor.value;
		url += "&DESCRIPCION=" + scape(formulario.TxtObservacion.value);
		url += "&RECOMENDACION=" + scape(formulario.TxtRecomendacion.value);
		url += "&CAUSA=" + scape(formulario.TxtCausa.value);
		url += "&COLOR=" + formulario.txtColor.value;
		url += "&CRITICIDAD=" + formulario.txtCriticidad.value.replace(",",".");
		url += "&IND_INCIDENTE=" + formulario.chkIncidente.checked;
		url += "&IND_SOLUCION=" + formulario.chkSolucion.checked;
		url += "&REPORT=" + formulario.txtReport.value;
		url += "&USERNAME=" + GetSession();
		url += "&FAENA=" + getEmpresa();
		//url += "&COMBUSTIBLE=" + formulario.txtCombustible.value.replace(",",".");
		//url += "&VALOR_COMBUSTIBLE=" + formulario.txtValorCombustible.value.replace(",",".");
		//url += "&DOC_COMBUSTIBLE=" + formulario.txtDocCombustible.value.replace(",",".");
		

		xmlestado = xmlDso.load(url);
		
		if (!xmlestado)
				window.open(url);
		else
			alert("Bitacora Actualizada.");
}


function guardarCheck(ID){
				
	xmlNew.async = false;
	var xmlDso = xmlNew.XMLDocument;
	var url = "xml/Checklist.asp?RECURSO=NewCheckBitacora";
		url += "&ID=" + ID;
		url += "&FOLIO=" + formulario.txtID.value;
		

		xmlestado = xmlDso.load(url);
		
		if (!xmlestado)
				window.open(url);
				
}

function getBitacora(ID){

	xmlNew.async = false;
	var xmlDso = xmlNew.XMLDocument;
	var url = "xml/Bitacoras.asp?RECURSO=GetBitacora";
		url +="&ID=" + ID;
		url +="&VTZ=" + Math.random();

	//window.open(url);
	xmlestado = xmlDso.load(url);
	if (!xmlestado)
			window.open(url);

setTimeout("getHora();",800);
setTimeout("getColor();",800);
setTimeout("getTipoEquipo();",800);
  		
}

function getColor(){
if(formulario.txtColor.value=="ALTA")
	formulario.txtColor.style.background="FF0000";

if(formulario.txtColor.value=="MEDIA")
	formulario.txtColor.style.background="FFFF00";

if(formulario.txtColor.value=="BAJA")
	formulario.txtColor.style.background="#3366FF";
}


function getTipoEquipo(){

	xmlTemp.async = false;
	var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=GetTipo&CODIGO=" + formulario.txtCodEquipo.value;
    xmlestado = xmlDso.load(url);
	if (!xmlestado)
			window.open(url);
	
	var tree = xmlDso.documentElement;	
	var node = tree.childNodes.item(0);
/*	
	var tbl = document.getElementById('tabChecklist');
			limpiarTablaCheck('tabChecklist');*/
			
	if(node){
			formulario.txtCodTipoEquipo.value =  getChildNodeValue(node,"CODIGO");
			formulario.txtTipoEquipo.value =  getChildNodeValue(node,"DESCRIPCION");
			formulario.txtEquipoPrincipal.value =  getChildNodeValue(node,"EQUIPO_PADRE");
			//mostrarCheckList();
	}

}


function getHora(){
//alert(formulario.txtFecha.value.substr(11,2));
formulario.ListHora.value = formulario.txtFecha.value.substr(11,2);  
formulario.ListMin.value =  formulario.txtFecha.value.substr(14,2);
}


function mostrarCheckList(){

//Equipo = formulario.txtCodEquipo.value;

	var tbl = document.getElementById('tabChecklist');
		
    xmlTemp.async = false;
    var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Checklist.asp?RECURSO=ListCheck";
		url += "&TIPO_EQUIPO=" + formulario.txtCodTipoEquipo.value;
		url += "&FOLIO=" + formulario.txtID.value;
		url +="&VTZ=" + Math.random();
		
    var res =xmlDso.load(url);
	//window.open(url);
	
      if (res){
        var tree = xmlDso.documentElement;
        if (tree.childNodes.length > 0){
		i=0;j=1;var row = tbl.insertRow(-1);
		while (i< tree.childNodes.length){
                
				if  (j==5) {
					row = tbl.insertRow(-1);
					j=1;
          		 }
				
				var node = tree.childNodes.item(i);
				var cell = row.insertCell(0);
				if(getChildNodeValue("BITACORA",node)){
						cell.innerHTML =  "<INPUT class='LitleText' type='checkbox' >"+
										  "<span class='LitleText' >" +
										  " " + getChildNodeValue(node,"DESCRIPCION") + "</span>"+
										  "<INPUT  class='hidden' value='" + getChildNodeValue(node,"ID") + "' >";
										  }
					else{
					cell.innerHTML =  "<INPUT class='LitleText' type='checkbox' checked=true>"+
										"<span class='LitleText' >" +
										" " + getChildNodeValue(node,"DESCRIPCION") + "</span>"+
										"<INPUT  class='hidden' value='" + getChildNodeValue(node,"ID") + "' >";
									 }
					
				cell.width = 150;  
				i=i+1;j=j+1;
				
			}//end while
		}//end if mq 0
	}// end if res
}//end function

function limpiarTablaCheck(tabla){
	var tbl = document.getElementById(tabla);
	var lastRow = tbl.rows.length;
	for (i=0; i<lastRow; i++){
	  var row = tbl.deleteRow(0);
	 }
}

function verNaves(){

	
document.FrameNaves.mostrarVentana(formulario.txtNave,10,'COR',DivNaves,'inicio();');

}

function verPersonal(){
if (!getParametro("ID")){
	alert("Debe Guardar Bitacora antes.");
	return;
	}
document.FramePersonal.mostrarVentana(getParametro("ID"),10,'COR',DivPersonal,'inicio();');

}


function ListPersonal(){

  xmlResponsables.async = false;
  var xmlDso = xmlResponsables.XMLDocument;
  var url = "/sci/xml/usuarios.asp?RECURSO=ListUsuarios&ROL=SUPERVISOR";
  var res = xmlDso.load(url);

	  if (res){
    	      var tree = xmlDso.documentElement;
	          for(var i = 0; i < tree.childNodes.length; i++){
    	        var node = tree.childNodes.item(i);
        	    opcion = new Option(getChildNodeValue(node,"ID") ,getChildNodeValue(node,"ID"));
	            formulario.ListOpNave.options[i] = opcion;
        	    opcion = new Option(getChildNodeValue(node,"ID") ,getChildNodeValue(node,"ID"));
				formulario.ListOpGrua.options[i] = opcion;
        	    opcion = new Option(getChildNodeValue(node,"ID") ,getChildNodeValue(node,"ID"));
				formulario.ListPortanolero.options[i] = opcion;
				 }
    	     }
		else
			  window.open(url);

 } 


function guardarCheckList(){

var tbl = document.getElementById('tabCheckList');
var lastRow = tbl.rows.length;
 
for (i=0; i<lastRow; i++){
	
		if(tbl.rows[i].children[0])
			if(tbl.rows[i].children[0].children[0].checked==false)
								guardarCheck(tbl.rows[i].children[0].children[2].value);
			
		if(tbl.rows[i].children[1])
			if(tbl.rows[i].children[1].children[0].checked==false)
								guardarCheck(tbl.rows[i].children[1].children[2].value);
			
		if(tbl.rows[i].children[2])
			if(tbl.rows[i].children[2].children[0].checked==false)
								guardarCheck(tbl.rows[i].children[2].children[2].value);
		
		if(tbl.rows[i].children[3])
			if(tbl.rows[i].children[3].children[0].checked==false)
								guardarCheck(tbl.rows[i].children[3].children[2].value);
		

		 }

}



function chkAll(){

 var tbl = document.getElementById('tabCheckList');
 var chk = document.getElementById('chckAll');


 var lastRow = tbl.rows.length;
 for (i=0; i<lastRow; i++){
	if (chk.checked){
		if(tbl.rows[i].children[0])
			tbl.rows[i].children[0].children[0].checked=true;
			
		if(tbl.rows[i].children[1])
			tbl.rows[i].children[1].children[0].checked=true;
			
		if(tbl.rows[i].children[2])
			tbl.rows[i].children[2].children[0].checked=true;
		
		if(tbl.rows[i].children[2])
			tbl.rows[i].children[3].children[0].checked=true;
		

		 }
	else{
		if(tbl.rows[i].children[0])
			tbl.rows[i].children[0].children[0].checked=false;
			
		if(tbl.rows[i].children[1])
			tbl.rows[i].children[1].children[0].checked=false;
			
		if(tbl.rows[i].children[2])
			tbl.rows[i].children[2].children[0].checked=false;
			
		if(tbl.rows[i].children[3])
			tbl.rows[i].children[3].children[0].checked=false;
		}
	}
	 
} 

function guardarHorometro(){
	
	xmlTemp.async = false;
	var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=UltimoValorHorometro";
		url += "&HOROMETRO=MOT"; // + 	formulario.TxtHorometro.value;
		url += "&COD_EQUIPO=" + formulario.txtCodEquipo.value;
	 xmlestado = xmlDso.load(url);		
	 Valor = formulario.txtHorometroValor.value;
	 Fecha = formulario.txtFecha.value;
	  if (xmlestado){
			if (xmlDso.documentElement.childNodes.length>0){
		   	        var node = xmlDso.documentElement.childNodes.item(0);
					   fechaAnt = getChildNodeValue(node,"FECHA");
		   			   valorAnt = getChildNodeValue(node,"VALOR");				
					   }
				else{
					valorAnt = 0;
					}
			   }			
		else
			window.open(url);
	if (Valor < valorAnt){
						alert("Error en Kilometraje, valor anterior = " + valorAnt);
						return;
						}
						
	xmlTemp.async = false;
	var xmlDso = xmlTemp.XMLDocument;
	var url = "xml/Equipos.asp?RECURSO=InsertValorHorometro";
		url += "&HOROMETRO=MOT"; // + formulario.TxtHorometro.value;
		url += "&COD_EQUIPO=" + formulario.txtCodEquipo.value;
		url += "&CODIGO=" + formulario.txtCodEquipo.value;
		url += "&FECHA=" + Fecha;
		url += "&VALOR=" + Valor;
		url += "&USUARIO=" + GetSession();
		
	   xmlestado = xmlDso.load(url);		
		  if (!xmlestado)
				window.open(url);
		  else{
				alert("Kilometraje " + Valor + " " + " ingresado.");
				//parent.indHorometro=true;
				}
				
				//window.open(url);
		
}


function guardarCinta(Cinta, ID){

	xmlTemp.async = false;
	var xmlDso = xmlTemp.XMLDocument;
	url = "xml/Bitacoras.asp?RECURSO=InsertCintaBitacora";
	url += "&ID=" + ID;
	url += "&CINTA=" + Cinta;
	xmlestado = xmlDso.load(url);
			
		  if (!xmlestado)
				window.open(url);
		
} 
 
function verPlanificacion(){

//url = "boxPlanificacion.html?vtz=" +  Math.random();
//framePlanificacion.src= url;

framePlanificacion.showWin(formulario.txtID, divPlanificacion);

}

function enviar(){

if (getParametro("ROL")=='INVITADO'){
					alert("No tiene privilegios suficientes para realizar esta acci�n");
					return;
					}
					
frameMail.showWin(formulario.txtID,document.getElementById("divMail"));
return false;
}


function enviarAviso(){

xmlResponsables.async = false;
  var xmlDso = xmlResponsables.XMLDocument;
  var url = "xml/Mail.asp?RECURSO=destBitacora";
  	  url += "&FAENA=" + getEmpresa();
	//window.open(url);
  var res = xmlDso.load(url);

	  if (res){
    	      var tree = xmlDso.documentElement;
	          for(var i = 0; i < tree.childNodes.length; i++){
    	        var node = tree.childNodes.item(i);
        	    sendMail(getChildNodeValue(node,"MAIL"), getChildNodeValue(node,"NOMBRE"));
				 }
    	     }
		else
			  window.open(url);
			  
			  
}

function sendMail(_to){

	xmlTemp.async = false;
	var xmlDso = xmlTemp.XMLDocument;
	var _fotos = new Array();
	 
 
 	url = "xml/Mail.asp?RECURSO=NewMailBitacora";
	url += "&FROM=info@ttminsight.cl";
	url += "&TO=" + _to; 
	url += "&SUBJECT=Aviso de Inspecci�n N�: "+ formulario.txtID.value + "  EQUIPO: " + formulario.txtCodEquipo.value;
	url += "&ID="+ formulario.txtID.value;
	url += "&FAENA="+ getEmpresa();
	url += "&EQUIPO="+ formulario.txtCodEquipo.value;
	url += "&DES_EQUIPO="+ formulario.txtEquipo.value;
	url += "&FECHA="+ formulario.txtFecha.value;
	url += "&CRITICIDAD="+ formulario.txtColor.value;
	url += "&P_CRITICIDAD="+ formulario.txtCriticidad.value;
	url += "&INSPECTOR="+ document.getElementById("idResponsable").innerText;
	//url += "&OBSERVACION="+ formulario.TxtObservacion.value;
	//url += "&RECOMENDACION="+ formulario.TxtRecomendacion.value;
	//url += "&CAUSA_R="+ formulario.TxtCausa.value;
	
	
	 
	    var res =xmlDso.load(url);
		
		if(res){
		 	alert("Aviso enviado por Mail a  " + _to );
			}
		 else
		 		window.open(url);
}



function getArchivos(){

var fotos = new Array();

xmlImages.async = false;
	var xmlDso = xmlImages.XMLDocument;
	var url = "xml/archivos.asp?RECURSO=listArchivos";
		url += "&FAMILIA=BITACORAS"; 
		url += "&IDENTIFICADOR="+formulario.txtID.value;
		xmlestado = xmlImages.load(url);
	//window.open(url);
	 if (xmlestado){
		
	       
    	      var tree = xmlDso.documentElement;
	          for(var i = 0; i < tree.childNodes.length; i++){
			  var node = tree.childNodes.item(i);
    	       fotos[i]=getChildNodeValue(node,"FILEIMAGE");
			 }
			 
			 return fotos;
		}
	
fotos[0] = "SIN ARCHIVOS ADJUNTOS.";
return fotos;

}

function historial(){

frameHistorial.showWin(formulario.txtID, divHistorial);
}



</SCRIPT>
<BODY onload="inicio();" topmargin="0" rightmargin="0">
<DIV ID="divCalendar" onClick="event.cancelBubble=true" 
  STYLE="position: absolute; visibility: hidden; width: 10; z-index: 100; left: 95; top: 2; height: 23; border-style: ridge; border-width: 2px">
  <IFRAME frameBorder="0" HEIGHT="185" NAME="FrameCalendar" SCROLLING="no" SRC="DTPicker.htm" WIDTH="180"></IFRAME>
</DIV>
<DIV ID="DivHorometro" STYLE="position: absolute; visibility: hidden; width: 10; z-index: 100; left: 95; top: 278; height: 23; border-style: ridge; border-width: 2px" onClick="event.cancelBubble=true">
<IFRAME NAME="ListFrameHorometro" SRC="ListHorometro.html" frameBorder="0" WIDTH="250" SCROLLING="no" HEIGHT="180"></IFRAME>
</DIV>
<DIV ID="divMail" STYLE="VISIBILITY: hidden; BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 145; LEFT: 50px; ; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 30px; width: 500px; height: 450px;" onclick="event.cancelBubble=true">
  <IFRAME NAME="frameMail" SRC="boxMails.html" frameBorder="0" WIDTH="500" SCROLLING="no" HEIGHT="450"> </IFRAME>
</DIV>
<DIV ID="divCriticidad" STYLE="VISIBILITY: hidden; BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 145; LEFT: 212px; ; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 33px; height: 450px;"
onclick="event.cancelBubble=true">
  <IFRAME NAME="FrameCriticidad" SRC="Criticidad.html" frameBorder="0" WIDTH="250" SCROLLING="no" HEIGHT="450"></IFRAME>
</DIV>
<DIV ID="divDanos" STYLE="VISIBILITY: hidden;BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 145; LEFT: 65px; ; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 5px"
onclick="event.cancelBubble=true">
  <IFRAME NAME="frameDanos" SRC="boxDanos.html" frameBorder="0" WIDTH="580" SCROLLING="no" HEIGHT="380"></IFRAME>
</DIV>
<DIV ID="divEquipos" STYLE="BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 1045; LEFT: 55px; VISIBILITY: hidden; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 49px; width: 375px; height: 290px;"	onclick="event.cancelBubble=true">
  <IFRAME NAME="frameEquipos" SRC="ListEquiposPadres.html" FRAMEBORDER="0" WIDTH="375" SCROLLING="no" HEIGHT="290">
  </IFRAME>
</DIV>

<DIV ID="divPlanificacion" STYLE="BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 1045; LEFT: 74px; VISIBILITY: hidden; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 60px;"
	onclick="event.cancelBubble=true">
  <IFRAME NAME="framePlanificacion"  SRC="boxPlanificacion1.html" FRAMEBORDER="0" WIDTH="530" SCROLLING="no" HEIGHT="375">
  </IFRAME>
</DIV>

<DIV ID="divHistorial" STYLE="BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 1045; LEFT: 74px; VISIBILITY: hidden; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 60px;"
	onclick="event.cancelBubble=true">
  <IFRAME NAME="frameHistorial"  SRC="boxHistorial.html" FRAMEBORDER="0" WIDTH="530" SCROLLING="no" HEIGHT="375">
  </IFRAME>
</DIV>

<FORM NAME="formulario">
  <TABLE height="35" DATASRC="#xmlNew">
    <TR>
      <TD WIDTH="211" height="29"  CLASS="titulo"> Inspecci&oacute;n&nbsp;N&ordm;
           <INPUT NAME="txtID" TYPE="TEXT" CLASS="inputBold" SIZE="5" READONLY /></TD>
      <TD WIDTH="216"  CLASS="titulo">
       Responsable : <SPAN ID="idResponsable" CLASS="Campo" DATAFLD="RESPONSABLE"></SPAN> </TD>
      <TD WIDTH="309" CLASS="LitleText"><div align="right">
        <input  type="button" class="botonBlanco" onClick="danhos();"  value="Fotografias" >      
      </div></TD>
    </TR>
  </TABLE>
  <TABLE WIDTH="794" HEIGHT="411" BORDER="0" CLASS="texto"  DATASRC="#xmlNew">
    <!--DWLayoutTable-->
    <TR>
      <TD WIDTH="52" HEIGHT="24" ALIGN="left" VALIGN="top">EQUIPO </TD>
      <TD width="468" VALIGN="top"><INPUT  class="input" ID="idCodEquipo" 
            		type="text" SIZE="20"  name="txtCodEquipo" DATAFLD="EQUIPO">
        <INPUT CLASS="input" ID="idEquipo" TYPE="text" SIZE="50"
            			 name="txtEquipo"  datafld="DESC_EQUIPO">
        <IMG STYLE="CURSOR: hand" 
							  onclick="frameEquipos.mostrarVentana(txtCodEquipo,
							  txtEquipo, divEquipos,'getTipoEquipo();'); return false;" 
                              		src="images/lupa.jpg" ALIGN="top"></TD>
      <TD width="206" VALIGN="top">Ejecutor :
        <SELECT NAME="listEjecutor" CLASS="input" DATAFLD="EJECUTOR">
          <OPTION VALUE="" selected>(vacio)</OPTION>
          <OPTION VALUE="TTM">TTM</OPTION>
          <OPTION VALUE="FAM">FAM</OPTION>
          <OPTION VALUE="CAUCHO_TEC">CAUCHO TECNICA</OPTION>
          <OPTION VALUE="INSER">INSER TS</OPTION>
          <OPTION VALUE="METSO">METSO</OPTION>
          <OPTION VALUE="SIMMATRANS">SIMMATRANS</OPTION>
        </SELECT></TD>
      <TD WIDTH="48" VALIGN="top"><!--DWLayoutEmptyCell-->&nbsp;</TD>
    </TR>
    <TR>
      <TD HEIGHT="22" VALIGN="middle">FECHA</TD>
      <TD COLSPAN="3" VALIGN="middle" >
      <INPUT NAME="txtFecha" TYPE="text" CLASS="input" SIZE="15" 
	  				readonly="true" DATAFLD="FECHA"/>
        &nbsp;<IMG STYLE="CURSOR: hand"  src="images/calendar.jpg" ALIGN="top"
					  onclick="FrameCalendar.fPopCalendar(txtFecha,txtFecha,divCalendar);return false"> HORA :
        <SELECT NAME="ListHora" CLASS="input">
        </SELECT>
        <SELECT NAME="ListMin" CLASS="input">
        </SELECT>
        ULTIMA INSPECCION:
        <INPUT NAME="txtUltInspeccion" TYPE="text" CLASS="input" SIZE="12" 
	  				readonly="true" DATAFLD="ULT_INSPECCION"/> 
        <IMG  src="images/calendar.jpg" alt="Calendar" ALIGN="top" STYLE="CURSOR: hand"
					  onclick="FrameCalendar.fPopCalendar(txtUltInspeccion,txtUltInspeccion,divCalendar);return false"> 
               TIPO EQ.:
        <INPUT NAME="txtTipoEquipo" TYPE="text" CLASS="input" SIZE="25"  datafld="DESC_TIPO_EQUIPO"/>
        <INPUT NAME="txtCodTipoEquipo"  type="hidden" DATAFLD="TIPO_EQUIPO"/>
        <INPUT NAME="txtEquipoPrincipal"  type="hidden" /></TD>
    </TR>
    <TR>
      <TD HEIGHT="29" COLSPAN="2" VALIGN="bottom">
           <INPUT  type="button" CLASS="botonBlanco" 
        		onclick="FrameCriticidad.mostrarVentana(txtID,txtCodTipoEquipo,divCriticidad);return false"
                value="Criticidad" >
           <INPUT  TYPE="text"  CLASS="bordes" SIZE="8"  ALIGN="MIDDLE"
   			NAME="txtColor" DATAFLD="COLOR" VALUE="BAJA">
           <!--&nbsp;COMBUSTIBLE (Ltrs):
        <INPUT  type="text" CLASS="input" SIZE="7"
        			name="txtCombustible" DATAFLD="COMBUSTIBLE" >
        VALOR :
        <INPUT  type="text" CLASS="input" SIZE="12" NAME="txtValorCombustible" 
        		 DATAFLD="VALOR_COMBUSTIBLE" >
        &nbsp;NRO. DOC. :
        <INPUT  type="text" CLASS="input" SIZE="12" NAME="txtDocCombustible"  datafld="DOC_COMBUSTIBLE"-->
        <INPUT  TYPE="text"  CLASS="bordes" SIZE="4"  ALIGN="MIDDLE"
   			NAME="txtCriticidad" DATAFLD="CRITICIDAD" ID="txtCriticidad">
        % 
        <INPUT  type="button" CLASS="botonBlanco" onclick="verPlanificacion();"  value="Planificaci&oacute;n" >
        <SPAN CLASS="style3">DA&Ntilde;O  </SPAN>
        <INPUT NAME="chkIncidente"  TYPE="checkbox" CLASS="input" DATAFLD="IND_INCIDENTE"/>    
        <STRONG>SOLUCIONADO</STRONG>
        <INPUT NAME="chkSolucion"  TYPE="checkbox" CLASS="input" DATAFLD="IND_SOLUCION" ID="chkSolucion"/>      </TD>
    <TD COLSPAN="2" VALIGN="BOTTOM">AVISO/OT:
      <INPUT  TYPE="text" CLASS="input" SIZE="14" 
   			NAME="txtReport" DATAFLD="REPORT">      </TD>
    </TR>
    
    
    <TR >
      <TD HEIGHT="140"  COLSPAN="4" VALIGN="top">
        <STRONG>OBSERVACIONES</STRONG>
        <TEXTAREA id="TxtObservacion" NAME="TxtObservacion"  ROWS="8"
		  COLS="120" CLASS="textArea" DATAFLD="DESCRIPCION"
		   onKeyPress="validaKeys(this,1500, window.event);"></TEXTAREA>
        <!--DIV ALIGN="right"><STRONG>APROBAR TODO
          <INPUT TYPE="checkbox"  id="chckAll" CLASS="campoNum" onClick="chkAll();" />
          </STRONG></DIV-->
        <!--TABLE ID="tabCheckList"  CLASS="LitleText">
        </TABLE--></TD></TR>
    <TR>
      <TD HEIGHT="15" COLSPAN="4">
      <DIV ALIGN="left"><STRONG>RECOMENDACIONES</STRONG></DIV></TD>
    </TR>
    <TR>
      <TD HEIGHT="67" COLSPAN="4" VALIGN="middle">
        <TEXTAREA id="TxtRecomendacion" NAME="TxtRecomendacion"  ROWS="4"
		  COLS="120" CLASS="textArea" DATAFLD="RECOMENDACION"
		   onKeyPress="validaKeys(this,749, window.event);"></TEXTAREA>      
           </TD>
    </TR>
    <TR>
      <TD HEIGHT="15" COLSPAN="4"><STRONG>CAUSA RAIZ</STRONG></TD>
    </TR>
    <TR>
      <TD HEIGHT="67" COLSPAN="4">
        <TEXTAREA id="TxtCausa" NAME="TxtCausa"  ROWS="4"
		  COLS="120" CLASS="textArea" DATAFLD="CAUSA"
		   onKeyPress="validaKeys(this,749, window.event);"></TEXTAREA>
           <%
dim myLink
set myLink = new AspSpellLink
myLink.dialogLanguage = "es"  ''Espanol
myLink.dictionary = "Espanol"
myLink.fields="TxtObservacion,TxtRecomendacion,TxtCausa" ''Sets the Field id(s) to be spell-checked
response.write myLink.imageButtonHTML("","","")
response.write myLink.spellAsYouType()
set myLink=nothing
%>
           <span onClick="frameMail.showWin(txtID,divMail);return false">
           </span></TD>
    </TR>
    <TR>
         <TD HEIGHT="10"></TD>
         <TD></TD>
      <TD></TD>
      <TD></TD>
    </TR>
  </TABLE>
  <DIV align="left">
  <TABLE width="90%">
  <TR>
    <TD><INPUT  type="button" CLASS="botonBlanco" onClick="guardar();" VALUE="Guardar" >
      <INPUT  type="button" CLASS="botonBlanco" onClick="enviar();" VALUE="Enviar x Mail" >
      <INPUT  type="button" CLASS="botonBlanco" onClick="historial();" VALUE="Historial" >
      <INPUT  type="button" CLASS="botonBlanco" onClick="window.close();" VALUE="Salir" >    </TD>
  </TR>
  </TABLE>
  </DIV>
</FORM>
</BODY>
</HTML>
