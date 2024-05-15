
var imgA = new Array(10);
var imgNom = new Array(10);
var imgId = new Array(10);
var indx = 0;
var sucess=false;
var total=0;var total1=0;var total2=0;var total3=0;var total4=0;var total5=0
var totalPr=0;
var totalMo=0
var totalNe=0;
var totalAm=0;


$(document).ready(function() {

	
    $("#idFechaIni").datepicker({
    showOn: 'both',
    buttonImage: 'mg/calendar.jpg',
    buttonImageOnly: true,
    changeYear: true,
	currentText: "Now",
    numberOfMonths: 1,
    onSelect: function(textoFecha, objDatepicker){	//alert(textoFecha);
   				 }
 	}); 
 
	 $("#idFechaFin").datepicker({
    showOn: 'both',
    buttonImage: 'mg/calendar.jpg',
    buttonImageOnly: true,
    changeYear: true,
	currentText: "Now",
    numberOfMonths: 1,
    onSelect: function(textoFecha, objDatepicker){
			//alert(textoFecha);
    			}
 		}); 

 });
 
 jQuery(function($){
    $.datepicker.regional['es'] = {
       closeText: 'Cerrar',
       prevText: '<Ant',
       nextText: 'Sig>',
       currentText: 'Hoy',
       monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
	   								   'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
       monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
       dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
       dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
       dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
       weekHeader: 'Sm',
       dateFormat: 'dd/mm/yy',
       firstDay: 1,
       isRTL: false,
       showMonthAfterYear: false,
       yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['es']);
 }); 


function move(_left, _top){
//alert(_top);
$('.toMove').offset( {left:_left , top: _top} );

}




function inicio(){

//parent._equipo = document.getElementById("txtEquipoAv");

if(getSession()=='UNDEFINED')window.location.href='index.html';


//document.getElementById("idResponsable").value = getSession();

	if(getParametro("CODIGO")){
		getServicio();
		//listArchivos();
		}
	else{
		document.getElementById("idFechaIni").value = _hoy();
		document.getElementById("idCliente").focus();
		
		}
		

}

function guardar(){

if (!formulario.txtDescripcion.value){
alert("Ingrese la descripción");
return;
}

 switch (getRol()){
 
 	case 'VISITA':
		alert("Sin Privilejios");
		return;
 	break;
	case 'REGHH':
	alert("Sin Privilejios");
		return;
 	break;
	
	case 'REPORT':
	alert("Sin Privilejios");
		return;
 	break;
	

}
 
 
if (document.getElementById('idCodigo').value)
		updateServicio(document.getElementById('idCodigo').value);
else
		newServicio();
		

}


function guardarProductos(codigo_os){

 var tbl = document.getElementById('tblArticulos');
 var lastRow = tbl.rows.length;
 var sucess = false;
 
	
//window.open(url);
//alert(lastRow);

 for (i=0; i<lastRow; i++){
 
		url = "js/servicios.asp?RECURSO=insertProductosOS";
		url += "&CODIGO=" + codigo_os;
		url += "&ID=" + tbl.rows[i].children[0].children[0].innerText;
		url += "&CORR=" + tbl.rows[i].children[0].children[1].innerText;
		url += "&COD_ITEM=" + tbl.rows[i].children[0].children[0].innerText;
		url += "&UNIDAD=" + tbl.rows[i].children[3].children[0].innerText;
		url += "&CANTIDAD=" + tbl.rows[i].children[4].children[0].innerText;
		url += "&VALOR=" + tbl.rows[i].children[5].children[0].innerText;
		url += "&VTZ=" + Math.random();
		//window.open(url);
		
	    $.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
			})//End each
		});//end $.get
	
	
  }//for

	guardarPersonal(codigo_os);
	guardarAmortz(codigo_os);
}

function guardarPersonal(codigo_os){

 var tbl = document.getElementById('tblPersonal');
 var lastRow = tbl.rows.length-1;
 var sucess = false;

	
 for (i=1; i<lastRow; i++){
 
		url = "js/personal.asp?RECURSO=insertPersonalOS";
		url += "&CODIGO_OS=" + codigo_os;
		url += "&CODIGO=" + tbl.rows[i].children[0].innerText;
		url += "&BASED=" + tbl.rows[i].children[3].innerText.replace(".","");
		url += "&BASED_T=" + tbl.rows[i].children[4].innerText.replace(".","");
		
		url += "&FDH=" + tbl.rows[i].children[5].innerText.replace(".","");
		url += "&FDH_T=" + tbl.rows[i].children[6].innerText.replace(".","");
		url += "&FNH=" + tbl.rows[i].children[7].innerText.replace(".","");
		url += "&FNH_T=" + tbl.rows[i].children[8].innerText.replace(".","");
		
		url += "&FDF=" + tbl.rows[i].children[9].innerText.replace(".","");
		url += "&FDF_T=" + tbl.rows[i].children[10].innerText.replace(".","");
		url += "&FNF=" + tbl.rows[i].children[11].innerText.replace(".","");
		url += "&FNF_T=" + tbl.rows[i].children[12].innerText.replace(".","");
		
		//window.open(url);
		
	    $.get(url, function(theXML){
			$('ROW',theXML).each(function(j){
			})//End each
		});//end $.get
		

}//for

setTimeout("suc()",500);

}

function guardarAmortz(codigo_os){

 
 url = "js/servicios.asp?RECURSO=delAmortizOS";
		url += "&OS=" + codigo_os;
		
    $.get(url, function(theXML){
			$('ROW',theXML).each(function(j){
			}), insertAmortiz();//End each
		});//end $.get
}

function insertAmortiz(){

 var tbl = document.getElementById('tblAmortz');
 var lastRow = tbl.rows.length;
 var sucess = false;

 for (i=2; i<lastRow; i++){
 
		url = "js/servicios.asp?RECURSO=insertAmortizOS";
		url += "&OS=" + codigo_os;
		url += "&TIPO=" + tbl.rows[i].children[1].innerText;
		url += "&CANTIDAD=" + tbl.rows[i].children[2].innerText;
		url += "&ANCHO=" + tbl.rows[i].children[3].innerText;
		
		url += "&LARGO=" + tbl.rows[i].children[4].innerText;
		url += "&TOTAL=" + tbl.rows[i].children[5].innerText;
		url += "&UF=" + tbl.rows[i].children[7].innerText;
		
		
	//	window.open(url);
		
	    $.get(url, function(theXML){
			$('ROW',theXML).each(function(j){
			})//End each
		});//end $.get
		

}//for



}

function suc(){


//*************TODOS LOS TOTALES
totalNe = parseFloat(document.getElementById("idTotalNe").value.replace(".",""));

total = parseFloat(total5) + parseFloat(totalPr) + parseFloat(totalAm);
margen = totalNe - total;



	var url = "js/servicios.asp?RECURSO=updateServicio";
		url += "&CODIGO=" + document.getElementById('idCodigo').value;
		url += "&CLIENTE=" + document.getElementById('idRutCliente').value;
		url += "&DESCRIPCION=" + document.getElementById("idDescripcion").value;
		url += "&FECHA_INI=" + document.getElementById("idFechaIni").value;
		url += "&FECHA_FIN=" + document.getElementById("idFechaFin").value;
		url += "&FACTURA=" + document.getElementById("idFactura").value;
		TOTAL = document.getElementById("idTotalGa").value.replace(".","")
		
		//
			url += "&TOTAL=" + document.getElementById("idTotalGa").value.replace(".","");
			url += "&TOTAL_NETO=" + document.getElementById("idTotalNe").value;
			if (document.getElementById("idMargen").value!='NaN'){
			url += "&MARGEN=" + document.getElementById("idMargen").value.replace(".","");
			if(document.getElementById("idPr").value!="-Infinity")
						url += "&MARGEN_P=" + document.getElementById("idPr").value;
		}
		
		url += "&USERNAME=" + getSession();
		url += "&VTZ=" + Math.random();
//alert(url);

//window.open(url);
		
 $.get(url, function(theXML){
			$('ROW',theXML).each(function(j){
			}),alert("Actualización realizada.");//End each
		});getServicio();//end $.get
	
	

}



function saveTotal(){


total = parseFloat(totalMo) + parseFloat(totalPr);

margen = totalNe - total;

document.getElementById("idTotalGa").value = addPnt(total);
document.getElementById("idMargen").value = addPnt(totalNe - total);
document.getElementById("idPr").value = redond((((totalNe - total)/totalNe)*100),2);

var url = "js/servicios.asp?RECURSO=updateServicio";
		url += "&CODIGO=" + document.getElementById('idCodigo').value;
		url += "&CLIENTE=" + document.getElementById('idRutCliente').value;
		url += "&DESCRIPCION=" + scape(document.getElementById("idDescripcion").value);
		url += "&FECHA_INI=" + document.getElementById("idFechaIni").value;
		url += "&FECHA_FIN=" + document.getElementById("idFechaFin").value;
		url += "&FACTURA=" + document.getElementById("idFactura").value;
	//	alert(total);
		url += "&TOTAL=" +total;
		url += "&TOTAL_NETO=" + totalNe;
		url += "&MARGEN=" + margen;
		url += "&MARGEN_P=" + document.getElementById("idPr").value;
		url += "&USERNAME=" + getSession();
		url += "&VTZ=" + Math.random();

//window.open(url);
	
	$.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
			
		})	
	});//end $.get
	
}


function listProductos(){

	codigo_os = document.getElementById('idCodigo').value;
	if(!codigo_os)return;
	//alert(folio_ot);

	var tbl = document.getElementById('tblArticulos');
	var lastRow = tbl.rows.length;
	limpiarTabla2(tbl);

	var url = "js/servicios.asp?RECURSO=listProductosOS&CODIGO=" + codigo_os;
		url += "&VTZ=" + Math.random();
	  //  window.open(url);
	var j=1;
		
 $.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
			
			 var row = tbl.insertRow(-1);
          
		  	if (j==1){_bgColor="#f4fafe";j=2;}
	 		else{_bgColor="#d2f2ea";j=1;}
			 row.bgColor= _bgColor;
		
			var cell = row.insertCell(0);
			cell.innerHTML = "<SPAN class='tinyText'>" + $(this).find("ID").text() + "</SPAN>"+
							"<SPAN  style='color:"+_bgColor+"'>" + $(this).find("CORR").text() + "</SPAN>";
			cell.width="50px";
				 
		  	var cell = row.insertCell(1);
			cell.innerHTML = "<SPAN class='texto'>" + $(this).find("CODIGO").text() + "</SPAN>";
			cell.width="30px";
			
			var cell = row.insertCell(2);
				cell.innerHTML = "<SPAN class='texto'>" + $(this).find("DESCRIPCION").text() + "</SPAN>";	
				cell.width="250px";	
									
			var cell = row.insertCell(3);
				cell.innerHTML = "<SPAN class='texto'>" + $(this).find("UNIDAD").text() + "</SPAN>";
				cell.width="20px";	 
				
			var cell = row.insertCell(4);
				cell.innerHTML = "<SPAN class='texto'>" + $(this).find("CANTIDAD").text() + "</SPAN>";
				cell.width="20px";	
			
			var cell = row.insertCell(5);
				cell.innerHTML = "<SPAN class='texto'>" + $(this).find("VALOR").text() + "</SPAN>";
				cell.width="30px";	
				cell.align="right";	 	 
			//var total = parseFloat($(this).find("CANTIDAD").text())*parseFloat($(this).find("VALOR").text());
			
			var cell = row.insertCell(6);
				cell.innerHTML = "<SPAN class='texto'>" + $(this).find("TOTAL").text()  + "</SPAN>";
				cell.width="20px";	
				cell.align="right";
			
			if ($(this).find("ID").text()!="--"){	 				
				var cell = row.insertCell(7);
				cell.innerHTML ="<IMG onclick='delProducto(this)' alt='Eliminar' src='mg/trash.jpg' align='middle' style='CURSOR:pointer'/>";
				cell.width="15px";
			
				var cell = row.insertCell(8);
				cell.innerHTML ="<IMG onclick='adjuntar(this)' alt='Adjuntar Doc.'"
								+ " src='mg/clip.png' align='middle' style='CURSOR:pointer' />";
				cell.width="15px";
					
				var cell = row.insertCell(9);
				cell.innerHTML ="<IMG onclick='obs(this)' alt='Observaciones' src='mg/tip.png' "
							      + " align='middle' style='CURSOR:pointer' />";
				cell.width="15px";
			
				var cell = row.insertCell(10);
					cell.innerHTML = "<SPAN class='tinyTexto'>" + $(this).find("FAMILIA").text() + "</SPAN>";
					cell.width="200px";	 
			}
			
			totalPr = parseFloat($(this).find("TOTAL_N").text());
			document.getElementById("idTotalPr").value = addPnt(totalPr);	//alert($(this).find("TOTAL_N").text());
					  
		}),listPersonal()  //End each
		
	});//end $.get
	
	

 
}

function listPersonal(){

	codigo_os = document.getElementById('idCodigo').value;
	if(!codigo_os)return;
	//alert(folio_ot);

	var tbl = document.getElementById('tblPersonal');
	var lastRow = tbl.rows.length;
	limpiarTabla2(tbl);

	var url = "js/personal.asp?RECURSO=listPersonalOS&CODIGO=" + codigo_os;
		url += "&VTZ=" + Math.random();
	//    window.open(url);
	
		
 var j=1;	
 	row = tbl.insertRow(-1);
												
					row.bgColor= "#d2f2ee";
					cell = row.insertCell(0);
					cell.innerHTML =  "CODIGO "
					cell.width = 10;
					
					cell = row.insertCell(1);
					cell.innerHTML = "NOMBRE"
					cell.width = 230;	
							
					cell = row.insertCell(2);
					cell.innerHTML = "Cargo"
					cell.width = "180";
															
					cell = row.insertCell(3);
					cell.innerHTML = "BASE "
					cell.width = "5";
						cell.colSpan=2;
					cell.align="center";
		
										
					cell = row.insertCell(4);
					cell.innerHTML = "Faena Dia Hab. (FDH)"
					cell.width = 10;
					cell.colSpan=2;
					cell.align="center";
					
					cell = row.insertCell(5);
					cell.innerHTML = "Faena Noche Hab.(FNH)"
					cell.width = 10;
					cell.colSpan=2;
					cell.align="center";
					
					cell = row.insertCell(6);
					cell.innerHTML = "Faena Dia Fest. (FDF)"
					cell.width = 10;
					cell.colSpan=2;
					cell.align="center";
					
					cell = row.insertCell(7);
					cell.colSpan=2;
					cell.innerHTML = "Faena Noche Fest.(FNF)"
					cell.width = 10;
					cell.align="center";
					
					cell = row.insertCell(8);
					cell.innerHTML = "Total "
					cell.width = "10";
					
							
		total=0;total1=0;total2=0;total3=0;total4=0;total5=0;	
					
$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){
				
					//var title = $(this).find("firstname").attr("title");
					var _item = i +1 ;
			
					
					row = tbl.insertRow(-1);
					row.style.cursor = 'pointer';
					//row.onclick = function (){verHH(_codigo)};
													
					if (j==1){row.bgColor= "#f4fafe";j=2;}
					else{row.bgColor= "#d2f2ea";j=1;}
					
						
										
					cell = row.insertCell(0);
					cell.innerHTML =  $(this).find("CODIGO").text();
				
					
					cell = row.insertCell(1);
					cell.innerHTML =  $(this).find("NOMBRE").text();
				
									
					cell = row.insertCell(2);
					cell.innerHTML = $(this).find("CARGO").text();
				
									
					cell = row.insertCell(3);
					cell.innerHTML = $(this).find("BASED").text();
					cell.align="center";
					
					cell = row.insertCell(4);
					cell.innerHTML = $(this).find("BASED_T").text();
					cell.align="right";
						
					h = ($(this).find("BASED_T").text()).replace(".","");
					total = total + parseInt(h);
					
					
					cell = row.insertCell(5);
					cell.innerHTML = $(this).find("FDH").text();
					cell.align="center";
					
					cell = row.insertCell(6);
					cell.innerHTML = $(this).find("FDH_T").text();			
					cell.align="right";
					
					h = ($(this).find("FDH_T").text()).replace(".","");
					total1 = total1 + parseInt(h);
					
					cell = row.insertCell(7);
					cell.innerHTML = $(this).find("FNH").text()
					cell.align="center";
					
					cell = row.insertCell(8);
					cell.innerHTML = $(this).find("FNH_T").text()
					cell.align="right";
					
					
					
					h = ($(this).find("FNH_T").text()).replace(".","");
					total2 = total2 + parseInt(h)
										
					cell = row.insertCell(9);
					cell.innerHTML = $(this).find("FDF").text();
					cell.align="center";
					
					cell = row.insertCell(10);
					cell.innerHTML = $(this).find("FDF_T").text();
					cell.align="right";
					
					h = ($(this).find("FDF_T").text()).replace(".","");
					total3 = total3 + parseInt(h)
									
					cell = row.insertCell(11);
					cell.innerHTML = $(this).find("FNF").text();
					cell.align="center";
					
					cell = row.insertCell(12);
					cell.innerHTML = $(this).find("FNF_T").text();
					cell.align="right";
					h = ($(this).find("FNF_T").text()).replace(".","");
					total4 = total4 + parseInt(h)
					
					
					cell = row.insertCell(13);
					cell.innerHTML = $(this).find("TOTAL").text();
					cell.align="right";
					
					h = ($(this).find("TOTAL").text()).replace(".","");
					total5 = total5 + parseInt(h)
					
					
					if (j==1){row.bgColor= "#f4fafe";}
					else{row.bgColor= "#d2f2ea";row.borderColor="#d2f2ea";}
	

					//$(cell).click(function(event) {verAviso(this);});
					
					
									  										  					  
					i=i+1;
			
			 
			}), listAmortiz(); //end each
		})//end $get
 
}

 
function listAmortiz(){

	codigo_os = document.getElementById('idCodigo').value;
	if(!codigo_os)return;
	//alert(folio_ot);

	var tbl = document.getElementById('tblAmortz');
	var lastRow = tbl.rows.length;
	limpiarTabla2(tbl);

	var url = "js/servicios.asp?RECURSO=listAmortiz&OS=" + codigo_os;
		url += "&VTZ=" + Math.random();
	   // window.open(url);
	var j=1;
	
	 var row = tbl.insertRow(-1);
	
			var cell = row.insertCell(0);
			cell.innerHTML = "<SPAN class='HIDDEN'></SPAN>";
			cell.width="5px";
			
			var cell = row.insertCell(1);
			cell.innerHTML = "<SPAN class='tinyText'>TIPO</SPAN>";
			cell.width="50px";
				 
		  	var cell = row.insertCell(2);
			cell.innerHTML = "<SPAN class='texto'>CANTIDAD</SPAN>";
			cell.width="30px";
			
			var cell = row.insertCell(3);
			cell.innerHTML = "<SPAN class='texto'>ANCHO</SPAN>";	
			cell.width="30px";	
									
			var cell = row.insertCell(4);
			cell.innerHTML = "<SPAN class='texto'>LARGO</SPAN>";
			cell.width="30px";	 
				
			var cell = row.insertCell(5);
			cell.innerHTML = "<SPAN class='texto'>TOTAL</SPAN>";
			cell.width="30px";	
			cell.align="right";	 	 
			
			
		
					 				
			var cell = row.insertCell(6);
			cell.innerHTML = ""
			cell.width="15px";
			
			var cell = row.insertCell(7);
				cell.innerHTML = "<SPAN class='texto'>UF</SPAN>";
				cell.width="30px";	
				cell.align="right";
	
	totalAm=0;
		
 $.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
			
			 var row = tbl.insertRow(-1);
          
		  	if (j==1){_bgColor="#f4fafe";j=2;}
	 		else{_bgColor="#d2f2ea";j=1;}
			 row.bgColor= _bgColor;
		
			var cell = row.insertCell(0);
			cell.innerHTML = "<SPAN class='HIDDEN'>" + $(this).find("ID").text() + "</SPAN>";
		
			
			var cell = row.insertCell(1);
			cell.innerHTML = "<SPAN class='tinyText'>" + $(this).find("TIPO").text() + "</SPAN>";
				 
		  	var cell = row.insertCell(2);
			cell.innerHTML = "<SPAN class='texto'>" + $(this).find("CANTIDAD").text() + "</SPAN>";
			
			var cell = row.insertCell(3);
			cell.innerHTML = "<SPAN class='texto'>" + $(this).find("ANCHO").text() + "</SPAN>";	
									
			var cell = row.insertCell(4);
			cell.innerHTML = "<SPAN class='texto'>" + $(this).find("LARGO").text() + "</SPAN>";
				
			var cell = row.insertCell(5);
			cell.innerHTML = "<SPAN class='texto'>" + $(this).find("TOTAL").text() + "</SPAN>";
		 
			 totalAm = totalAm + parseInt($(this).find("TOTAL").text());
					 				
			var cell = row.insertCell(6);
			cell.innerHTML = "<IMG onclick='delRow(this)' src='mg/trash.jpg' align='middle' style='CURSOR:hand' />";
			cell.width="15px";
			
			var cell = row.insertCell(7);
			cell.innerHTML = "<SPAN class='texto'>" + $(this).find("UF").text()  + "</SPAN>";
			cell.align="right";
						
					  
		}) , totalHH()//End each
		
	});//end $.get
	
	

 
}


function totalHH(){
//with (divWait.style){visibility = "hidden"};

var tbl = document.getElementById('tblPersonal');
row = tbl.insertRow(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell.innerHTML = addPnt(total);
cell.align="right";

cell = row.insertCell(-1);cell = row.insertCell(-1);
cell.innerHTML = addPnt(total1);
cell.align="right";

cell = row.insertCell(-1);cell = row.insertCell(-1);
cell.innerHTML = addPnt(total2);
cell.align="right";

cell = row.insertCell(-1);cell = row.insertCell(-1);
cell.innerHTML = addPnt(total3);
cell.align="right";

cell = row.insertCell(-1);cell = row.insertCell(-1);
cell.innerHTML = addPnt(total4);
cell.align="right";

cell = row.insertCell(-1);
cell.innerHTML = addPnt(total5);
cell.align="right";
totalMo = total5;
document.getElementById("idTotalMo").value = addPnt(total5);


//*************TODOS LOS TOTALES
total = parseFloat(total5) + parseFloat(totalPr) + parseFloat(totalAm);
margen = totalNe - total;


var tbl = document.getElementById('tblAmortz');
row = tbl.insertRow(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell = row.insertCell(-1);
cell.innerHTML = addPnt(totalAm);
cell.align="right";



document.getElementById("idTotalGa").value = addPnt(total);
document.getElementById("idMargen").value = addPnt(totalNe - total);
document.getElementById("idPr").value = redond((((totalNe - total)/totalNe)*100),2);

}


function getPersonalOS(){

	codigo_os = document.getElementById('idCodigo').value;
	if(!codigo_os)return;
	//alert(folio_ot);

	var tbl = document.getElementById('tblPersonal');
	var lastRow = tbl.rows.length;
	limpiarTabla2(tbl);

	var url = "js/personal.asp?RECURSO=getPersonalOS&CODIGO=" + codigo_os;
		url += "&VTZ=" + Math.random();
	//  window.open(url);

	var j=1;	
 	row = tbl.insertRow(-1);
												
					row.bgColor= "#d2f2ee";
					cell = row.insertCell(0);
					cell.innerHTML =  "CODIGO "
					cell.width = 10;
					
					cell = row.insertCell(1);
					cell.innerHTML = "NOMBRE"
					cell.width = 230;	
							
					cell = row.insertCell(2);
					cell.innerHTML = "Cargo"
					cell.width = "180";
															
					cell = row.insertCell(3);
					cell.innerHTML = "BASE "
					cell.width = "5";
						cell.colSpan=2;
					cell.align="center";
		
										
					cell = row.insertCell(4);
					cell.innerHTML = "Faena Dia Hab. (FDH)"
					cell.width = 10;
					cell.colSpan=2;
					cell.align="center";
					
					cell = row.insertCell(5);
					cell.innerHTML = "Faena Noche Hab.(FNH)"
					cell.width = 10;
					cell.colSpan=2;
					cell.align="center";
					
					cell = row.insertCell(6);
					cell.innerHTML = "Faena Dia Fest. (FDF)"
					cell.width = 10;
					cell.colSpan=2;
					cell.align="center";
					
					cell = row.insertCell(7);
					cell.colSpan=2;
					cell.innerHTML = "Faena Noche Fest.(FNF)"
					cell.width = 10;
					cell.align="center";
					
					cell = row.insertCell(8);
					cell.innerHTML = "Total "
					cell.width = "10";
					
							
		total=0;total1=0;total2=0;total3=0;total4=0;total5=0;	
					
$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){
				
					//var title = $(this).find("firstname").attr("title");
					var _item = i +1 ;
			
					
					row = tbl.insertRow(-1);
					row.style.cursor = 'pointer';
					//row.onclick = function (){verHH(_codigo)};
													
					if (j==1){row.bgColor= "#f4fafe";j=2;}
					else{row.bgColor= "#d2f2ea";j=1;}
					
						
										
					cell = row.insertCell(0);
					cell.innerHTML =  $(this).find("CODIGO").text();
				
					
					cell = row.insertCell(1);
					cell.innerHTML =  $(this).find("NOMBRE").text();
				
									
					cell = row.insertCell(2);
					cell.innerHTML = $(this).find("CARGO").text();
				
									
					cell = row.insertCell(3);
					cell.innerHTML = $(this).find("BASED").text();
					cell.align="center";
					
					cell = row.insertCell(4);
					cell.innerHTML = $(this).find("BASED_T").text();
					cell.align="right";
						
					h = ($(this).find("BASED_T").text()).replace(".","");
					
					total = total + parseInt(h);
					
					
					cell = row.insertCell(5);
					cell.innerHTML = $(this).find("FDH").text();
					cell.align="center";
					
					cell = row.insertCell(6);
					cell.innerHTML = $(this).find("FDH_T").text();			
					cell.align="right";
					
					h = ($(this).find("FDH_T").text()).replace(".","");
					total1 = total1 + parseInt(h);
					
					cell = row.insertCell(7);
					cell.innerHTML = $(this).find("FNH").text()
					cell.align="center";
					
					cell = row.insertCell(8);
					cell.innerHTML = $(this).find("FNH_T").text()
					cell.align="right";
					
					
					
					h = ($(this).find("FNH_T").text()).replace(".","");
					total2 = total2 + parseInt(h)
										
					cell = row.insertCell(9);
					cell.innerHTML = $(this).find("FDF").text();
					cell.align="center";
					
					cell = row.insertCell(10);
					cell.innerHTML = $(this).find("FDF_T").text();
					cell.align="right";
					
					h = ($(this).find("FDF_T").text()).replace(".","");
					total3 = total3 + parseInt(h)
									
					cell = row.insertCell(11);
					cell.innerHTML = $(this).find("FNF").text();
					cell.align="center";
					
					cell = row.insertCell(12);
					cell.innerHTML = $(this).find("FNF_T").text();
					cell.align="right";
					h = ($(this).find("FNF_T").text()).replace(".","");
					total4 = total4 + parseInt(h)
					
					
					cell = row.insertCell(13);
					cell.innerHTML = $(this).find("TOTAL").text();
					cell.align="right";
					
					h = ($(this).find("TOTAL").text()).replace(".","");
					total5 = total5 + parseInt(h)
					
					
					if (j==1){row.bgColor= "#f4fafe";}
					else{row.bgColor= "#d2f2ea";row.borderColor="#d2f2ea";}
	

					//$(cell).click(function(event) {verAviso(this);});
					
					
									  										  					  
					i=i+1;
			
			 
			}), totalHH() //end each
		})//end $get
					
 
}



function process(_d){

alert(_d);

}

function getNumber(value){
		num = 0;
		num = value.replace(".", "");
		num = num.replace(".", "");
		num = Number(num);
		return num;
}
	
function updateServicio(CODIGO){


totalNe = getNumber(document.getElementById("idTotalNe").value)
total 	= getNumber(document.getElementById("idTotalGa").value);

//alert(totalNe);
document.getElementById("idMargen").value = addPnt(totalNe - total);
document.getElementById("idPr").value = redond((((totalNe - total)/totalNe)*100),2);
	
//	window.open(url);
 guardarProductos(CODIGO);
	
		
}

function getServicio(){
	
	if (getParametro("CODIGO")=="undefined")
		var url = "js/servicios.asp?RECURSO=getServicio&CODIGO=" + document.getElementById("idCodigo").value;
	else
		var url = "js/servicios.asp?RECURSO=getServicio&CODIGO=" + getParametro("CODIGO");	
	//window.open(url);
	
$.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
	
		//	document.getElementById("idFolio").value =  $(this).find("ID").text();
			document.getElementById("idCodigo").value =  $(this).find("CODIGO").text();
			document.getElementById("idCliente").value =  $(this).find("CLIENTE").text();
			document.getElementById("idRutCliente").value =  $(this).find("RUT_CLIENTE").text();
			document.getElementById("idResponsable").value =  $(this).find("RESPONSABLE").text();
			document.getElementById("idFechaIni").value =  $(this).find("FECHA_INI").text();
			document.getElementById("idFechaFin").value =  $(this).find("FECHA_FIN").text();
			document.getElementById("idDescripcion").value = $(this).find("OBSERVACION").text();
			document.getElementById("idTotalNe").value = addPnt($(this).find("TOTAL_NETO").text());
			totalNe = $(this).find("TOTAL_NETO").text();
			document.getElementById("idMargen").value = $(this).find("MARGEN").text();
			document.getElementById("idFactura").value = $(this).find("FACTURA").text();	
			
		})//End each
		, listProductos();
	});//end $.get
	
	

	
}

function newCliente(){

}

function newServicio(ID){


	var url = "js/servicios.asp?RECURSO=newServicio";
		url += "&MES=" + getParametro("MES");
		url += "&CLIENTE=" + document.getElementById('idRutCliente').value;
		url += "&DESCRIPCION=" + scape(document.getElementById("idDescripcion").value);
		url += "&FECHA_INI=" + document.getElementById("idFechaIni").value;
		url += "&FECHA_FIN=" + document.getElementById("idFechaFin").value;
		url += "&FACTURA=" + document.getElementById("idFactura").value;
		TOTAL = document.getElementById("idTotalGa").value.replace(".","");
		
		if (document.getElementById("idTotalGa").value!='NaN')
			url += "&TOTAL=" + document.getElementById("idTotalGa").value.replace(".","");
		
		url += "&TOTAL_NETO=" + document.getElementById("idTotalNe").value;
		
		url += "&MARGEN=" + document.getElementById("idMargen").value.replace(".","");
		url += "&USERNAME=" + getSession();
		url += "&UBICACION=" + getEmpresa();
		url += "&VTZ=" + Math.random();

//	window.open(url);
	
var _cod;


if(!document.getElementById('idRutCliente').value){
	alert("Seleccione un cliente.");
	return;
}

//window.open(url);


	$.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
			document.getElementById("idCodigo").value =  $(this).find("CODIGO").text();
			_cod = document.getElementById("idCodigo").value;
		})	, guardarProductos(_cod);
	});//end $.get



			
}

function delPersonal(obj){

tbl = document.getElementById("tblPersonal");
i = obj.parentElement.parentElement.rowIndex;
usr =  tbl.rows[i].children[0].innerText;
	url = "js/personal.asp?RECURSO=delPersonalOS";
		url += "&CODIGO_OS=" + codigo_os;
		url += "&CODIGO=" +usr;
		//window.open(url);
		
		if(confirm("Seguro elimina a " + usr +" " + tbl.rows[i].children[1].innerText)){		
	  	  $.get(url, function(theXML){
				$('ROW',theXML).each(function(j){
				})//End each
			});//end $.get
		obj.parentElement.parentElement.parentElement.deleteRow(i);
		}

}

function delProducto(obj){

tbl = document.getElementById("tblArticulos");
i = obj.parentElement.parentElement.rowIndex;
corr =  tbl.rows[i].children[0].children[1].innerText;

	url = "js/servicios.asp?RECURSO=delProductoOS";
		url += "&CODIGO=" + document.getElementById("idCodigo").value;
		url += "&CORR=" +corr;
		
	//window.open(url);
		
		if(confirm("Seguro elimina a " + tbl.rows[i].children[1].innerText)){		
	  	  $.get(url, function(theXML){
				$('ROW',theXML).each(function(j){
				})//End each
			});//end $.get
		obj.parentElement.parentElement.parentElement.deleteRow(i);
		}

}

function delRow(obj){

obj.parentElement.parentElement.parentElement.deleteRow(obj.parentElement.parentElement.rowIndex);

}



function delFile(){

	var url = "script/archivos.asp?RECURSO=delFile";
		url += "&FAMILIA=AVISOS"; 
		url += "&ID=" + document.getElementById("idFile").value
		url += "&VTZ=" + Math.random();
    
	if(!confirm("Seguro desea eliminar archivo." + document.getElementById("idFile").value))
			return;
	
	 $.get(url, function(theXML){
				$('ROW',theXML).each(function(j){
					alert("Archivo Eliminado.");
			}) //end each
		})//end $get

listArchivos();
}

function salir(){
parent.document.getElementById('boxDetAvisos').close();
}

function getCliente(){

frameClientes.showWin(divClientes);
}

function verInsumos(){

frameArticulos.popsearchbox(divArticulos); 

			
var url = "BuscarArticulos.html";
//	url += "?FOLIO=" + formulario.folio.value;
	url += "?CODIGO=" + document.getElementById("idCodigo").value;
	url += "&VTZ=" + Math.random();
	//alert(url);	
winCfg = "width=580px,height=290px,left=" + 120 + "px,top=" + 80 +"px,resize=1,scrolling=0";	
//var inlinewin= dhtmlwindow.open("boxInsumos", "iframe", url , "INSUMOS", winCfg, "recal");


}

function verPersonal(obj){
			
framePersonal.popsearchbox(document.getElementById("divPersonal"), obj); 


}


function verAmortiza(obj){
			
frameAmortiza.popsearchbox(document.getElementById("divAmortiza"), obj); 


}

function enviar(){

var url ="boxMail.html?ID=" + formulario.txtFolio.value;
	url += "&VTZ=" + Math.random();
	//alert(id);
	
winCfg = "width=550px,height=430px,left=" + 220 + "px,top=" + 50 +"px,resize=1,scrolling=0";	
var inlinewin2= parent.dhtmlwindow.open("boxFallas", "iframe", url , "AVISO DE INSPECCIÓN", winCfg);

}


function fw(){

indx = indx + 1;

if(!imgA[indx])
	indx = indx - 1 ;

document.getElementById("imgObj").src = imgA[indx];
document.getElementById("ID_list_cant_reg").innerText=imgNom[indx];
document.getElementById("idFile").value = imgId[indx];

}

function rw(){

indx = indx - 1;

//alert(imgA[indx]);

if(!imgA[indx])
	indx = indx + 1;

document.getElementById("imgObj").src = imgA[indx];
document.getElementById("ID_list_cant_reg").innerText=imgNom[indx];
document.getElementById("idFile").value = imgId[indx];

}


function visor(obj){

var left=60;
var top=20;
var width=950;
var height=550;

var URLStr ="visor.html?PATH="+obj.src;

 popUpSic = open(URLStr, 'popUpFotos', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+', top='+top+',screenX='+left+',screenY='+top+'');
 

}

function setCliente(_rut, _nombre){
document.getElementById("idCliente").value = _nombre;
document.getElementById("idRutCliente").value = _rut;
}

function loadArchivos(){

//alert(document.getElementById("frameFiles").src);

document.getElementById("frameFiles").src ='archivos.html?VTZ=' + Math.random();

}


function adjuntar(obj){

index = obj.parentElement.parentElement.rowIndex;

cod = obj.parentElement.parentElement.parentElement.children[index].children[0].children[1].innerText;
v = obj.parentElement.parentElement.parentElement.children[index].children[6].innerText;
name = obj.parentElement.parentElement.parentElement.children[index].children[2].innerText + "  " + v;

//alert(cod);
document.frameFiles.mostrarVentana(cod,name, obj, divFiles);
}

function obs(obj){

index = obj.parentElement.parentElement.rowIndex;

cod = obj.parentElement.parentElement.parentElement.children[index].children[0].children[1].innerText;
v = obj.parentElement.parentElement.parentElement.children[index].children[6].innerText;
name = obj.parentElement.parentElement.parentElement.children[index].children[2].innerText + "  " + v;

//alert(cod);

document.frameObs.mostrarVentana(cod,name, obj, divObs);
}

function newInsumo(_id, _cod, _name, _cant, _valor, _familia, _unidad){

	var tbl = document.getElementById('tblArticulos');
	var lastRow = tbl.rows.length;
	
  	//	alert(_cant +" "+ _valor);
          var row = tbl.insertRow(-1);
          		  
		  if (lastRow%2==0){_bgColor="#f4fafe";j=2;}
	 		else{_bgColor="#d2f2ea";j=1;}
		   row.bgColor= _bgColor;
  			
			var cell = row.insertCell(0);
			cell.innerHTML = "<SPAN class='texto'>" + _id + "</SPAN>" +
			 				 "<SPAN class='texto'></SPAN>";
							 
			var cell = row.insertCell(1);
				cell.innerHTML = "<SPAN class='texto'>" + _cod + "</SPAN>";
			var cell = row.insertCell(2);
				cell.innerHTML = "<SPAN class='texto'>" + _name + "</SPAN>";					
			var cell = row.insertCell(3);
				cell.innerHTML = "<SPAN class='texto'>" + _unidad + "</SPAN>";
			var cell = row.insertCell(4);
				cell.innerHTML = "<SPAN class='texto'>" + _cant.replace(".",","); + "</SPAN>";
			
			var cell = row.insertCell(5);
				cell.innerHTML = "<SPAN class='texto'>" + _valor.replace(".",","); + "</SPAN>";
					 	 
			var total = redond(parseFloat(_cant)*parseFloat(_valor),2);
			
			var cell = row.insertCell(6);
				cell.innerHTML = "<SPAN class='texto'>" + total + "</SPAN>";	
					 				
			var cell = row.insertCell(7);
				cell.innerHTML = "<IMG onclick='delRow(this)' src='mg/trash.jpg' align='middle' style='CURSOR:hand' />";
			
						 				
			var cell = row.insertCell(8);
			cell.innerHTML = "<IMG onclick='adjuntar(this)' src='mg/clip.png' align='middle' style='CURSOR:pointer' />";
			cell.width="15px";
					
			var cell = row.insertCell(9);
			cell.innerHTML = "<IMG onclick='obs(this)' src='mg/tip.png' align='middle' style='CURSOR:pointer' />";
			cell.width="15px";
			
			var cell = row.insertCell(10);
				cell.innerHTML = "<SPAN class='tinyTexto'>" + $(this).find("FAMILIA").text() + "</SPAN>";
				cell.width="200px";	  
}

function newPersonal(_cod, _name, _cant, _valor, _cargo, _cant_v, _valor_v ){

	var tbl = document.getElementById('tblPersonal');
	var lastRow = tbl.rows.length;
  	//	alert(_cant +" "+ _valor);
    var row = tbl.insertRow(-1);
          		  
	  if (lastRow%2==0){_bgColor="#f4fafe";j=2;}
			else{_bgColor="#d2f2ea";j=1;}
	   row.bgColor= _bgColor;
  		
		var cell = row.insertCell(0);
			cell.innerHTML = "<SPAN class='texto'>" + _cod + "</SPAN>";
		var cell = row.insertCell(1);
			cell.innerHTML = "<SPAN class='texto'>" + _name + "</SPAN>";		
		
		var cell = row.insertCell(2);
			cell.innerHTML = "<SPAN class='texto'>" + _cargo + "</SPAN>";
		
		var cell = row.insertCell(3);
			cell.innerHTML = "<SPAN class='texto'>" + _cant + "</SPAN>";
		
		var cell = row.insertCell(4);
			cell.innerHTML = "<SPAN class='texto'>" + _valor + "</SPAN>";
		
		var cell = row.insertCell(5);
			cell.innerHTML = "<SPAN class='texto'>" + _valor*_cant + "</SPAN>";
			
		
		var cell = row.insertCell(6);
			cell.innerHTML = "<SPAN class='texto'>" + _cant_v + "</SPAN>";
		
		var cell = row.insertCell(7);
			cell.innerHTML = "<SPAN class='texto'>" + _valor_v + "</SPAN>";
		
		var cell = row.insertCell(8);
			cell.innerHTML = "<SPAN class='texto'>" + _valor_v*_cant_v + "</SPAN>";
			
		var cell = row.insertCell(9);
			cell.innerHTML = "<IMG onclick='delRow(this)' src='mg/trash.jpg' align='middle' style='CURSOR:hand' />";
			
}

function newAmortiza(_tipo, _cant, _ancho, _largo, _uf,  _valor ){


	if(_tipo=="E") tipo="Empalme";
	else tipo="Reparación";
	
	var tbl = document.getElementById('tblAmortz');
	var lastRow = tbl.rows.length;
  	//	alert(_cant +" "+ _valor);
    var row = tbl.insertRow(-1);
          		  
	  if (lastRow%2==0){_bgColor="#f4fafe";j=2;}
			else{_bgColor="#d2f2ea";j=1;}
	   row.bgColor= _bgColor;
  		
		var cell = row.insertCell(0);
			cell.innerHTML = "<SPAN class='texto'></SPAN>";
			
		var cell = row.insertCell(1);
			cell.innerHTML = "<SPAN class='texto'>" + tipo + "</SPAN>";
			
		var cell = row.insertCell(2);
			cell.innerHTML = "<SPAN class='texto'>" + _cant + "</SPAN>";		
		
		var cell = row.insertCell(3);
			cell.innerHTML = "<SPAN class='texto'>" + _ancho + "</SPAN>";
		
		var cell = row.insertCell(4);
			cell.innerHTML = "<SPAN class='texto'>" + _largo + "</SPAN>";
		
		var cell = row.insertCell(5);
			cell.innerHTML = "<SPAN class='texto'>" + _valor + "</SPAN>";
		
			
		var cell = row.insertCell(6);
			cell.innerHTML = "<IMG onclick='delRow(this)' src='mg/trash.jpg' align='middle' style='CURSOR:hand' />";
		
		var cell = row.insertCell(7);
			cell.innerHTML = "<SPAN class='texto'>" + _uf + "</SPAN>";
			
			
}