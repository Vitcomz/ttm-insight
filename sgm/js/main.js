//POWERED BY VITCOMZ.
var total_registros_lista;
var bloque_listado = 1;
var total_bloque_listado = 1;

var total_registros_lista2;
var bloque_listado2 = 1;
var total_bloque_listado2 = 1;

var expDays = 5;
var expHours = 8;
var expMinutes = 60;
var expSeg = 60;
var exp = new Date();
var _empresa;
var _rol;
var faena;
var ind_sgi;

exp.setTime(exp.getTime() + (expHours*expMinutes*expSeg*1000));

if(getEmpresa()=="DESCONOCIDO")
	this.location.href="/index.html";

function login(_plt){

	
	var url="/sgm/js/usuarios.asp?RECURSO=ValidaPass&ID=" + formulario.usuario.value;
		url += "&PASSWORD=" + formulario.password.value;
		//url += "&EMPRESA=" + formulario.listFaenas.value;
		url +="&VTZ=" + Math.random();
			
		_url=url;
		
	//window.open(url);
	
	 $.get(url, function(theXML){
			$('REGISTROS',theXML).each(function(i){
			var _value = $(this).find("ROW").text();
			delSession(document.getElementById('usuario').value);
			delSessionEmpresa();
			
			if (_value=="True"){
				
				var user = document.getElementById('usuario').value;
				
				crearSession(user);
				//crearSessionArea(formulario.listFaenas.value);		
				_rol = $(this).find("ROL").text();
				faena = $(this).find("FAENA").text();
				ind_sgi = $(this).find("IND_SGI").text();
				ind_conf = $(this).find("IND_CONF").text();
				crearIndSGI(ind_sgi);
				crearIndConf(ind_conf);
				//alert(getEmpresa());
				crearRol(_rol);
				//alert();
				if(_rol=="INFCHUQUI"){
					
					crearSessionEmpresa("CODELCO CHUQUICAMATA");	
					 window.location.href="/sgm/equipos.html";
				}else{
				window.location.href="intranet.html";
				}
											
					 
				}
			else{
				alert("Usuario o Password Invalidos!");
				formulario.usuario.focus();
			
			}//end If
		});//End Each
	});	//End $.get
	 
	 
	 
	/* $.ajax({

    	url: _url,
    	//data: myData,
		dataType: "text",
    	type: 'GET',
    	crossDomain: true,
   		dataType: 'jsonp',
    	success: function(data) { alert(data); },
   		error: function() { alert('Failed!'); },
  		beforeSend: setHeader
		
	});
	 
	 */
	  
}

function acccli(){
	window.location.href="/clientes";
}

var divName = 'mouseFollow'; // div that is to follow the mouse2. 
			// (must be position:absolute)
		
	var offX = 15;          // X offset from mouse position
	var offY = 15;          // Y offset from mouse position

	var zx = 0;          // X offset from mouse position
	var zy = 0; 
	
	
	function mouseX(evt) {
	if (!evt) evt = window.event; 
	if (evt.pageX) return evt.pageX; 
	else if (evt.clientX) return evt.clientX + 
				(document.documentElement.scrollLeft ?  document.documentElement.scrollLeft : document.body.scrollLeft);
		else return 0;
	}
	
	function mouseY(evt) {
		if (!evt) evt = window.event;
		if (evt.pageY) return evt.pageY;
		else if (evt.clientY) return evt.clientY + 
				(document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop);
		else return 0;
	}
		
		

function follow(evt) {
		
		if (document.getElementById){
			var obj = document.getElementById(divName).style; 
			obj.visibility = 'visible';
			x = (parseInt(mouseX(evt))+offX);
			y = (parseInt(mouseY(evt))+offY);
			
			//document.getElementById(divName).innerText= x + "," + y
			//obj.left = x + 'px';
			
			if(x>1200) zx++;
			if(x<200) zx--;
			if(y>300) zy++;
			if(y<300) zy--;
		//	setTimeout("window.scroll("+ zx +"," + zy +");",5);
			//obj.top = y + 'px';
			
		}
}
		



function _login(){

	XMLDoc.async = false;
	var xmlDso = XMLDoc.XMLDocument;
	var url="sci/xml/usuarios.asp?RECURSO=ValidaPass&ID=" + formulario.usuario.value;
		url += "&PASSWORD=" + formulario.password.value;
		res = xmlDso.load(url);
		
		DelSession(formulario.TxtID.value);
		
		//window.open(url);
		
		if (res){
            var tree = xmlDso.documentElement;
            if (tree.childNodes(0).childNodes(0).text == 'True'){
					CrearSession(formulario.TxtID.value);
					//CrearSessionEmpresa(formulario.ListFaenas.value);	
					XMLDoc.async = false;
					var xmlDso = XMLDoc.XMLDocument;
					var url="sci/xml/usuarios.asp?RECURSO=newLogin&ID=" + formulario.usuario.value;
						url += "&TIPO=IMPW";
					res = xmlDso.load(url);	
					if(!res)
						window.open(url);
										
					this.location.href="escritorio.html";
					}
			else{
			   alert("Usuario o Password Invalidos!");
			   formulario.usuario.focus();
			   }
	  }
}

function listAvisos(){

	document.getElementById('boxDetAvisos').listAvisos();
		
 }
 
 function visor(src){

var left=60;
var top=20;
var width=950;
var height=550;

var URLStr ="visor.html?PATH="+src;

 popUpSic = open(URLStr, 'popUpFotos', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+', top='+top+',screenX='+left+',screenY='+top+'');
 

}

function cambiaListado(cant, idTabla){
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

function irInicio(idTabla){
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	objTabla.firstPage();
	bloque_listado = 1;
	objLabelReg.innerText = "1/" + total_bloque_listado;
}

function irInicioV(idTabla){
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	objTabla.firstPage();
	bloque_listado2 = 1;
	objLabelReg.innerText = "1/" + total_bloque_listado2;
}

function irFinal(idTabla){
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

function irAdelante(idTabla){
	
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	
	if ( bloque_listado < total_bloque_listado ) {
		objTabla.nextPage();
		bloque_listado++;
		objLabelReg.innerText = bloque_listado + "/" + total_bloque_listado;
	}
}

function irAdelanteV(idTabla){
	
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	
	if ( bloque_listado2 < total_bloque_listado2 ) {
		objTabla.nextPage();
		bloque_listado2++;
		objLabelReg.innerText = bloque_listado2 + "/" + total_bloque_listado2;
	}
	
}

function irAtras(idTabla){
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("ID_list_fraccion_reg");
	
	if ( bloque_listado > 1 ) {
		objTabla.previousPage();
		bloque_listado--;
		objLabelReg.innerText = bloque_listado + "/" + total_bloque_listado;
	}
}

function irAtrasV(idTabla){
	var objTabla = document.getElementById(idTabla);
	var objLabelReg = document.getElementById("IDFraccionReg");
	
	if ( bloque_listado2 > 1 ) {
		objTabla.previousPage();
		bloque_listado2--;
		objLabelReg.innerText = bloque_listado2 + "/" + total_bloque_listado2;
	}
}

function irA(idTabla){
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
            return(parentnode.childNodes.item(i).text)
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

function getCookie (name) { 
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

function setCookie (name, value) { 
var argv = setCookie.arguments; 
var argc = setCookie.arguments.length; 
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

function deleteCookie (name) { 
	var exp = new Date(); 
	exp.setTime (exp.getTime() - 1); 
	var cval = getCookie (name); 
	document.cookie = name + "=" + cval + "; expires=" + 
	exp.toGMTString();
}

function getCookieVal(offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
			endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}

function crearSession(ID){
	setCookie('log',ID,exp);
}

function crearRol(ID){
	setCookie('rol',ID,exp);
}

function crearIndSGI(ID){
	setCookie('sgi',ID,exp);
}

function crearIndConf(ID){
	setCookie('conf',ID,exp);
}

function crearSessionArea(ID){
	setCookie('emp',ID,exp);
}

function crearSessionEmpresa(ID){
	setCookie('emp',ID,exp);
}

function delSession(ID){
	deleteCookie('log');
}

function delSessionEmpresa(ID){
	deleteCookie('emp');
}

function getSession(){
	var ID = getCookie('log');
	if(ID == null)
			return "UNDEFINED";
	else 
		return ID.toUpperCase();
}

function getEmpresa(){
	var ID = getCookie('emp');
	if(ID == null)
			return "UNDEFINED";
	else 
		return ID.toUpperCase();
}

function getSGI(){
	var ID = getCookie('sgi');
	if(ID == null)
			return "UNDEFINED";
	else 
		return ID.toUpperCase();
}

function getConf(){
	var ID = getCookie('conf');
	if(ID == null)
			return "UNDEFINED";
	else 
		return ID.toUpperCase();
}

function getRol(){
	
	var ID = getCookie('rol');
	if(ID == null)
			return "UNDEFINED";
	else 
		return ID.toUpperCase();
}

function scape(texto){
	var tmpstr = "";
	for ( i=0; i < texto.length ; i++ ){		
		if (texto.charAt(i) == '\n')
				char=escape("\n");
		else
				char=texto.charAt(i);
		tmpstr = tmpstr + char;
	} return tmpstr;	
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

  

 function limpiarTabla2(tabla){

	var lastRow = tabla.rows.length;
	for (i=0; i<lastRow; i++){
	  var row = tabla.deleteRow(-1);
	 }
 }
   function limpiarTabla(tabla){

	var lastRow = tabla.rows.length;
	for (i=0; i<lastRow; i++){
	  var row = tabla.deleteRow(-1);
	 }
 }

 function redond(num, ndec) { 
  var fact = Math.pow(10, ndec); // 10 elevado a ndec 

  return Math.round(num * fact) / fact; 
} 

 
function loadxml(url){
var xmldoc;
xmldoc = false;

if (document.implementation && document.implementation.createDocument)
	{//Mozilla
		//xmlTmp = document.implementation.createDocument("", "", null);
		xmldoc = new window.XMLHttpRequest();
		xmldoc.open("GET",url,false);
		xmldoc.send("");
		return xmldoc.responseXML;
	}
	else if (window.ActiveXObject)
	{//IExplorer
		xmldoc = new ActiveXObject("Microsoft.XMLDOM");
		xmldoc.async = false;
		xmldoc.load(url);
		//alert('explorer');
		return xmldoc;
	}
	else
		alert('Your browser can\'t handle this script');

}

function Point(iX, iY){
	this.x = iX;
	this.y = iY;
}

function getXY(oTmp){

  var pt = new Point(0,0);  
  do {
  	pt.x += oTmp.offsetLeft;
  	pt.y += oTmp.offsetTop;
  	oTmp = oTmp.offsetParent;
  } while(oTmp.tagName!="BODY");
  return pt;
}

function _hoy(){
 
  var ua = navigator.userAgent.toLowerCase(); 
  
  var mydate = new Date();
  var Hora      = mydate.getHours();
  var Min	    = mydate.getMinutes();
  var day_month = mydate.getDate();
  var month     = mydate.getMonth() + 1;
 
 
  if (ua.indexOf('msie') != -1)
  	var year      = mydate.getYear();

  	var year      = mydate.getYear()+1900;  
	
  var day       = mydate.getDay();
  
  if (ua.indexOf('opera') != -1) 
  	var year      = mydate.getYear();
  
  
  if ((Hora+"").length==1) sHora = '0' + Hora;
	   else	sHora = Hora;
	   
  if ((Min+"").length==1) sMin = '0' + Min;
	   else	sMin = Min;
	   
   if ((day_month+"").length==1) sDay = '0' + day_month;
	   else	sDay = day_month;
	   
    if ((month+"").length==1) month = '0' + month;
	   
   return(sDay+"/"+month+"/"+year);
   
}

function formatoFecha(mydate){

  var Hora      = mydate.getHours();
  var Min	    = mydate.getMinutes();
  var day_month = mydate.getDate();
  var month     = mydate.getMonth()+1;
  var year      = mydate.getFullYear();    
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

function alltrim(str) {
                return str.replace(/^\s+|\s+$/g, '');
            }
			
			
function fn(form,field){
var next=0, found=false
var f=form
if(event.keyCode!=13) return;

for(var i=0;i<f.length;i++){
		if(field.name==f.item(i).name){
				next=i+1;
				found=true
				break;
				}
		}

while(found){
	if( f.item(next).disabled==false && f.item(next).type!='hidden'){
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

function mOvr(src,clrOver)
{if (!src.contains(event.fromElement)) { src.style.cursor = 'hand'; src.bgColor = clrOver; }}

function mOut(src,clrIn)
{if (!src.contains(event.toElement)) { src.style.cursor = 'default'; src.bgColor = clrIn; }}