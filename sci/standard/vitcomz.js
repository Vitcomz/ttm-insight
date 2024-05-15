/*** 
Author : TTM Chile
http://www.ttmchile.cl
**/

var total_registros_lista;
var bloque_listado = 1;
var total_bloque_listado = 1;

var total_registros_lista2;
var bloque_listado2 = 1;
var total_bloque_listado2 = 1;

var expDays = 1;
var expHours = 72;
var expMinutes = 60;
var expSeg = 60;
var exp = new Date(); 

exp.setTime(exp.getTime() + (expHours*expMinutes*expSeg*1000));
//exp.setTime(exp.getTime() + 1800000); // solo en 30 adicional
//var dt = new Date(), expiryTime = dt.setTime( dt.getTime() + 1800000 );


function cambiaListado(cant, idTabla)
{
	//var obj = document.getElementById("ID_bots_listado");
	var objTabla = document.getElementById("idTabla");
	var objLabel = document.getElementById("ID_list_fraccion_reg");
	
	objTabla.dataPageSize = cant;
	if (cant == 0) {
		//obj.className = "oculto";
		objLabel.innerText = "Todos";
	} else {
		//obj.className = "";
		objLabel.innerText = "1/" + total_bloque_listado;
	}
}

function irInicio(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	objTabla.firstPage();
	bloque_listado = 1;
	objLabelReg.innerText = "1/" + total_bloque_listado;
}

function irInicioV(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	objTabla.firstPage();
	bloque_listado2 = 1;
	objLabelReg.innerText = "1/" + total_bloque_listado2;
}

function irFinal(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	
	for (var i=bloque_listado; i<total_bloque_listado; i++) {
		objTabla.nextPage();
		bloque_listado++;
	}
	objLabelReg.innerText = total_bloque_listado +"/" + total_bloque_listado;	
}

function irFinalV(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	
	for (var i=bloque_listado2; i<total_bloque_listado2; i++) {
		objTabla.nextPage();
		bloque_listado2++;
	}
	objLabelReg.innerText = total_bloque_listado2 +"/" + total_bloque_listado2;	
}

function irAdelante(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	
	if ( bloque_listado < total_bloque_listado ) {
		objTabla.nextPage();
		bloque_listado++;
		objLabelReg.innerText = bloque_listado + "/" + total_bloque_listado;
	}
}

function irAdelanteV(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	
	if ( bloque_listado2 < total_bloque_listado2 ) {
		objTabla.nextPage();
		bloque_listado2++;
		objLabelReg.innerText = bloque_listado2 + "/" + total_bloque_listado2;
	}
}

function irAtras(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	
	if ( bloque_listado > 1 ) {
		objTabla.previousPage();
		bloque_listado--;
		objLabelReg.innerText = bloque_listado + "/" + total_bloque_listado;
	}
}

function irAtrasV(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	
	if ( bloque_listado2 > 1 ) {
		objTabla.previousPage();
		bloque_listado2--;
		objLabelReg.innerText = bloque_listado2 + "/" + total_bloque_listado2;
	}
}

function irA(idTabla)
{
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	var numBloque = formulario.numIrA.value;
    if ( numBloque >= 1  && numBloque <= total_bloque_listado) {
		objTabla.firstPage();		
		for (var i=1; i<numBloque; i++) {
			objTabla.nextPage();
		}
		bloque_listado = numBloque
		objLabelReg.innerText = numBloque + "/" + total_bloque_listado;
	} else
		alert("Favor de ingresar bloque entre 1 y "+total_bloque_listado);
}


function getChildNodeValue(parentnode, nodename){
        for (var i = 0; i < parentnode.childNodes.length; i++){
          if (parentnode.childNodes.item(i).nodeName == nodename){
			  if (parentnode.childNodes.item(i).text==undefined)
            	return(parentnode.childNodes.item(i).textContent)
			  else
            	return(parentnode.childNodes.item(i).text);
            //return(parentnode.childNodes.item(i).text)
          }
        }
        return("");
      }
	  
function cantCaracteres(obj, maximo){	
		total_length = (obj.value.length);
		if(total_length >= maximo){
			window.event.keyCode = 0;
			alert("Ha exedido el numero maximo de caracteres.");
		}
	}
	
function LimpiarForm(){
		for (var i=0;i<document.formulario.length;i++){
			if (document.formulario.elements[i].className=="input")
							document.formulario.elements[i].value="";
			}
	}
	
function validaKeys(field, nCaracteres, event) {
  var keyCode = event.keyCode ? event.keyCode : 
                event.which ? event.which : event.charCode;
				//alert(event.keyCode);
				cantCaracteres(field, nCaracteres);
			switch (event.keyCode) {
					case 241 :
						window.event.keyCode = 0;
					case 37 :
						window.event.keyCode = 0;
					/*case 186 :
						window.event.keyCode = 0;*/
					case 38 :
						window.event.keyCode = 0;				
					case 35 : //#
						window.event.keyCode = 0;
					case 39 :
						window.event.keyCode = 0;
					case 60 :
						window.event.keyCode = 0;
					case 62 :
						window.event.keyCode = 0;
					case 250 :
						window.event.keyCode = 0;
					case 237 :
						window.event.keyCode = 0;
					case 205 :
						window.event.keyCode = 0;
					case 211 :
						window.event.keyCode = 0;
					case 225 :
						window.event.keyCode = 0;
					case 193 :
						window.event.keyCode = 0;
					case 201 :
						window.event.keyCode = 0;
					case 233 :
						window.event.keyCode = 0;
					case 243 :
						window.event.keyCode = 0;
					case 17 :// ALT
						window.event.keyCode = 0;
					


				default :
						return true;
				}
		
}


function daysOfMonth(year, month) {
	var days = new makeArray(12);

	days[1] = 31;  days[2] = 28;  days[3] = 31;
	days[4] = 30;  days[5] = 31;  days[6] = 30;
	days[7] = 31;  days[8] = 31;  days[9] = 30; 
	days[10] = 31; days[11] = 30; days[12] = 31;

	if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
		days[2] = 29;

	return days[month];
}

function GetCookie (name) { 
var arg = name + "="; 
var alen = arg.length; 
var clen = document.cookie.length; 
var i = 0; 
while (i < clen) {
			var j = i + alen; 
			if (document.cookie.substring(i, j) == arg) 
											return getCookieVal (j); 
			i = document.cookie.indexOf(" ", i) + 1; 
			if (i == 0) break; 
	} 
return null;
}

function SetCookie (name, value) { 
var argv = SetCookie.arguments; 
var argc = SetCookie.arguments.length; 
var expires = (argc > 2) ? argv[2] : null; 
var path = (argc > 3) ? argv[3] : null; 
var domain = (argc > 4) ? argv[4] : null; 
var secure = (argc > 5) ? argv[5] : false; 
document.cookie = name + "=" + escape (value) + 
((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + 
((path == null) ? "" : ("; path=" + path)) + 
((domain == null) ? "" : ("; domain=" + domain)) + 
((secure == true) ? "; secure" : "");
}

function DeleteCookie (name) { 
	var exp = new Date(); 
	exp.setTime (exp.getTime() - 1); 
	var cval = GetCookie (name); 
	document.cookie = name + "=" + cval + "; expires=" + 
	exp.toGMTString();
}

function getCookieVal(offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
			endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}

function crearRol(ID){
	SetCookie('rol',ID,exp);
}


function CrearSession(ID){
	SetCookie('log',ID,exp);
}

function DelSession(ID){
	DeleteCookie('log');
	DeleteCookie('emp');
}

function getRol(){
	
	var ID = getCookie('rol');
	if(ID == null)
			return "UNDEFINED";
	else 
		return ID.toUpperCase();
}

function GetSession(){
	var ID = GetCookie('log');
	if(ID == null)
			return "DESCONOCIDO";
	else 
		return ID.toUpperCase();
}

function winError(_Str){
          var win = window.open ("","RepWindow","toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,width=500,height=400");
				var doc = win.document;
				doc.clear();	//clear the window
				doc.write('<html><head><title>Error</title></head>');
				doc.write('<body>' + _Str + '</body>');
				doc.close();
	}
	
//
// Validador de Rut
// Descargado desde http://www.juque.cl/
//
function getDv(crut)
{	
	largo = crut.length;	
	if ( largo < 2 )	
	{		
		alert("Debe ingresar el rut completo")		
	  return false;	
	}	
	if ( largo > 2 )		
		rut = crut.substring(0, largo - 1);	
	else		
		rut = crut.charAt(0);	
	dv = crut.charAt(largo-1);	
	return  dv;
}

function getRut(texto)
{	
		var tmpstr = "";	
	for ( i=0; i < texto.length-2 ; i++ )		
		if ( texto.charAt(i) != ' ' && texto.charAt(i) != '.' && texto.charAt(i) != '-' )
			tmpstr = tmpstr + texto.charAt(i);	
	texto = tmpstr;	
	//largo = texto.length;
	return texto;
	
}

function getNumberRut(texto)
{	
		var tmpstr = "";	
		var sigue = false;
		
	for ( i=0; i < texto.length ; i++ )		
		if (texto.charAt(i)=='-')
					sigue = true;
	
	if (sigue){
		for ( i=0; i < texto.length-2 ; i++ )		
			if ( texto.charAt(i) != ' ' && texto.charAt(i) != '.' && texto.charAt(i) != '-' )
							tmpstr = tmpstr + texto.charAt(i);	
			texto = tmpstr;	
		//largo = texto.length;
	}
	
	return texto;
	
}


function revisarDigito( dvr )
{	
	dv = dvr + ""	
	if ( dv != '0' && dv != '1' && dv != '2' && dv != '3' && dv != '4' && dv != '5' && dv != '6' && dv != '7' && dv != '8' && dv != '9' && dv != 'k'  && dv != 'K')	
	{		
		alert("Debe ingresar un digito verificador valido");		
		//window.document.form1.rut.focus();		
		//window.document.form1.rut.select();		
		return false;	
	}	
	return true;
}

function revisarDigito2( crut )
{	
	largo = crut.length;	
	if ( largo < 2 )	
	{		
		alert("Debe ingresar el rut completo")		
	  return false;	
	}	
	if ( largo > 2 )		
		rut = crut.substring(0, largo - 1);	
	else		
		rut = crut.charAt(0);	
	dv = crut.charAt(largo-1);	
	revisarDigito( dv );	

	if ( rut == null || dv == null )
		return 0	

	var dvr = '0'	
	suma = 0	
	mul  = 2	

	for (i= rut.length -1 ; i >= 0; i--)	
	{	
		suma = suma + rut.charAt(i) * mul		
		if (mul == 7)			
			mul = 2		
		else    			
			mul++	
	}	
	res = suma % 11	
	if (res==1)		
		dvr = 'k'	
	else if (res==0)		
		dvr = '0'	
	else	
	{		
		dvi = 11-res		
		dvr = dvi + ""	
	}
	if ( dvr != dv.toLowerCase() )	
	{		
		alert("EL rut es incorrecto")			
		return false	
	}

	return true
}

function validaRut(texto)
{	
	var tmpstr = "";	
	for ( i=0; i < texto.length ; i++ )		
		if ( texto.charAt(i) != ' ' && texto.charAt(i) != '.' && texto.charAt(i) != '-' )
			tmpstr = tmpstr + texto.charAt(i);	
	texto = tmpstr;	
	largo = texto.length;	

	if ( largo < 2 )	
	{		
		alert("Debe ingresar el rut completo")		
		return false;	
	}	

	for (i=0; i < largo ; i++ )	
	{			
		if ( texto.charAt(i) !="0" && texto.charAt(i) != "1" && texto.charAt(i) !="2" && texto.charAt(i) != "3" && texto.charAt(i) != "4" && texto.charAt(i) !="5" && texto.charAt(i) != "6" && texto.charAt(i) != "7" && texto.charAt(i) !="8" && texto.charAt(i) != "9" && texto.charAt(i) !="k" && texto.charAt(i) != "K" )
 		{			
			alert("El valor ingresado no corresponde a un R.U.T valido");				
			return false;		
		}	
	}	

	var invertido = "";	
	for ( i=(largo-1),j=0; i>=0; i--,j++ )		
		invertido = invertido + texto.charAt(i);	
	var dtexto = "";	
	dtexto = dtexto + invertido.charAt(0);	
	dtexto = dtexto + '-';	
	cnt = 0;	

	for ( i=1,j=2; i<largo; i++,j++ )	
	{		
		//alert("i=[" + i + "] j=[" + j +"]" );		
		if ( cnt == 3 )		
		{			
			dtexto = dtexto + '.';			
			j++;			
			dtexto = dtexto + invertido.charAt(i);			
			cnt = 1;		
		}		
		else		
		{				
			dtexto = dtexto + invertido.charAt(i);			
			cnt++;		
		}	
	}	

	invertido = "";	
	for ( i=(dtexto.length-1),j=0; i>=0; i--,j++ )		
		invertido = invertido + dtexto.charAt(i);	

	//window.document.form1.rut.value = invertido.toUpperCase()		

	if ( revisarDigito2(texto) )		
		return true;	

	return false;
}


function fn(form,field)
{
var next=0, found=false
var f=form
if(event.keyCode!=13) return;

for(var i=0;i<f.length;i++) 
	{
		if(field.name==f.item(i).name)
				{
				next=i+1;
				found=true
				break;
				}
		}

while(found)
	{
	if( f.item(next).disabled==false && f.item(next).type!='hidden')
			{
			f.item(next).focus();
			break;
			}
else{
	if(next<f.length-1)
		next=next+1;
	else
		break;
		}
	}
}

function getParametro(variable) {
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
    if (pair[0] == variable) {
      return pair[1];
    }
  } 
  //alert('Query Variable ' + variable + ' not found');
  return false;
}

 function limpiarTabla(tbl){
	var lastRow = tbl.rows.length;
	for (i=1; i<lastRow; i++)
		  var row = tbl.deleteRow(1);
}
 
 function limpiarTablaCabecera(tbl){
	var lastRow = tbl.rows.length;
	for (i=1; i<lastRow; i++){
	  var row = tbl.deleteRow(1);
	 }
 }
 
 function chequearBlancos(val)
{
	var reg = new RegExp(/ /g);

	val = val.replace(reg,"");
	if (val == "")
		return 0
	else
		return 1;
}

 function isFecha(f)
{
	//formato a validar: dd/mm/yyyy
	n = chequearBlancos(f);
	if ( n == 0 ) return -1;
	else {
		len = f.length;
		dia = f.split("/")[0]*1;
		mes = f.split("/")[1]*1;
		anho = f.split("/")[2]*1;

		if ( len > 7 && !(dia > 31) && !(mes > 12) && !(anho < 2004) && !(anho > 2040) ) {//validación general de formato
			if ( (anho%4 != 0) && (mes == 2) && (dia > 28) )//valida anño biciesto (febrero)
				return 0;
			else if ( (mes == 4 || mes == 6 || mes == 9 || mes == 11 ) && dia > 30 ) //valida meses con 30 dias
				return 0;
			else
				return 1;
		}
		else
			return 0;
	}
	//alert ("La fecha de orden debe ser Mes/Dia/Año. Inténtelo de nuevo")
}


 function obtenerPeriodo(f)
{
   if (isFecha(f)){
   		len = f.length;
		dia = f.split("/")[0];
		mes = f.split("/")[1];
		anho = f.split("/")[2];
		if (dia.length==1) dia +='0';
		if (mes.length==1) mes+='0';
		return(anho+mes+dia);
   }	
   else
      return(-1);
      //alert('Error campo Fecha debe ser DD/MM/AAAA');
}

 function formatoFecha(mydate){

  var Hora      = mydate.getHours();
  var Min	    = mydate.getMinutes();
  var day_month = mydate.getDate();
  var month     = mydate.getMonth()+1;
  var year      = mydate.getYear();    
  var day       = mydate.getDay(); 
  
  	if ((Hora+"").length==1) sHora = '0' + Hora;
	   else	sHora = Hora;
	   
  	if ((Min+"").length==1) sMin = '0' + Min;
	   else	sMin = Min;
	   
   	if ((day_month+"").length==1) sDay = '0' + day_month;
	   else	sDay = day_month;
	   
    if ((month+"").length==1) month = '0' + month;
	   
   return(sDay+"/"+month+"/"+year+" "+sHora+":"+sMin);
   
}

 function formatoFechaCorta(mydate){

  var Hora      = mydate.getHours();
  var Min	    = mydate.getMinutes();
  var day_month = mydate.getDate();
  var month     = mydate.getMonth()+1;
  var year      = mydate.getYear();    
  var day       = mydate.getDay(); 
  
  	if ((Hora+"").length==1) sHora = '0' + Hora;
	   else	sHora = Hora;
	   
  	if ((Min+"").length==1) sMin = '0' + Min;
	   else	sMin = Min;
	   
   	if ((day_month+"").length==1) sDay = '0' + day_month;
	   else	sDay = day_month;
	   
    if ((month+"").length==1) month = '0' + month;
	   
   return(sDay+"/"+month+"/"+year);
   
}

 function _hoy(){
 
  var mydate = new Date();
  var Hora      = mydate.getHours();
  var Min	    = mydate.getMinutes();
  var day_month = mydate.getDate();
  var month     = mydate.getMonth() + 1;
  var year      = mydate.getYear();    
  var day       = mydate.getDay(); 
  
  if ((Hora+"").length==1) sHora = '0' + Hora;
	   else	sHora = Hora;
	   
  if ((Min+"").length==1) sMin = '0' + Min;
	   else	sMin = Min;
	   
   if ((day_month+"").length==1) sDay = '0' + day_month;
	   else	sDay = day_month;
	   
    if ((month+"").length==1) month = '0' + month;
	   
   return(sDay+"/"+month+"/"+year);
   
}


function mOvr(src,clrOver) { if (!src.contains(event.fromElement)) { src.style.cursor = 'hand'; src.bgColor = clrOver; }}
function mOut(src,clrIn) { if (!src.contains(event.toElement)) { src.style.cursor = 'default'; src.bgColor = clrIn; } }