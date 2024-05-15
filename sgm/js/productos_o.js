
var count=0;
var aFile = new Array();
var aFilePr = new Array();
var aName = new Array();
var aFileId = new Array();
var aPrin = new Array();

var k;



xmlDoc.async = false;
var option = "New";
var indCalculo = false;

//  var codEquipo;
function LimpiaF(){
formulario.TxtCodigo.value="";
formulario.txtDescripcion.value="";
formulario.txtValor.value="";
formulario.txtDireccion.value="";
formulario.txtFecha.value=_hoy();
formulario.txtObservacion.value="";
formulario.txtDescripcion.focus();
}


function addPnt(str) {
    var amount = new String(str);
    amount = amount.split("").reverse();

    var output = "";
    for ( var i = 0; i <= amount.length-1; i++ ){
        output = amount[i] + output;
        if ((i+1) % 3 == 0 && (amount.length-1) !== i)output = '.' + output;
    }
    return output;
}


function getPr(){

	
	var url = "js/articulos.asp?RECURSO=getArticulo&ID=" + document.getElementById("idCod").value;
	    url +="&EMPRESA=CYR";
		url += "&VTZ=" + Math.random(); 
	
//	window.open(url);
	
$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){
					var id = $(this).find("ID").text();
					
					document.getElementById("idCod").value = id;
					document.getElementById("idDesc").value = $(this).find("DESCRIPCION").text();
					document.getElementById("idEstado").value = $(this).find("ESTADO").text();
					document.getElementById("listFamilia").value = $(this).find("FAMILIA").text();
					document.getElementById("listTipos").value = $(this).find("SUBFAMILIA").text();
					document.getElementById("idValor").value = addPnt($(this).find("VALOR").text());
					document.getElementById("idDireccion").value = $(this).find("UBICACION").text();
					document.getElementById("idObservacion").value = $(this).find("OBSERVACION").text();
					
	}) , listArchivos();//end each
})//end $get
	
}





function listPr(){

	var _cod = document.getElementById("idCod").value;
	var _des= document.getElementById("idDesc").value;
	
	listFrPr.showWin(_cod, _des, document.getElementById("divPr"));
	
}

function setPrin(){

var url = "js/archivos.asp?RECURSO=setPrin";
		url += "&PRIN=" + document.getElementById("chkPreview").checked;
		url += "&ID=" + aFileId[k];
		url += "&VTZ=" + Math.random();
//alert(url);
//window.open(url);

	$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){	
				}), alert("Archivo Actualizado.") //end each
	})//end $get	
}

function delPr(){

var url = "js/articulos.asp?RECURSO=delArticulo";
		url += "&ID=" + document.getElementById("idCod").value;;
		url += "&VTZ=" + Math.random();
//alert(url);
//window.open(url);

	$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){	
				}), alert("Producto Desactivado."); //end each
	})//end $get	
}

function listArchivos(){

if (!document.getElementById("idCod").value)return;
				
	var url = "js/archivos.asp?RECURSO=listArchivos";
		url += "&FAMILIA=PROPIEDADES"; 
		url += "&IDENTIFICADOR="+document.getElementById("idCod").value;
		url += "&VTZ=" + Math.random();
   
   // window.open(url);
	k=0;
	aFile.length=0;
	aName.length=0;
	aFileId.length=0;
	aFilePr.length=0;
	
	$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){
					aFile[k] = $(this).find("FILEID").text();
					aFilePr[k] = $(this).find("FILEPR").text();
					aName[k] = $(this).find("NOMBRE").text();
					aFileId[k] = $(this).find("ID").text();
					aPrin[k] = $(this).find("PRIN").text();
					k=k+1;
					//document.getElementById("idImg").src = $(this).find("FILEID").text();
					//document.getElementById("idFile").innerText = $(this).find("ID").text();
		}),total(); //end each
})//end $get

}

function total(){

document.getElementById("idTotal").innerText=k;
k=0;
document.getElementById("idK").innerText=k+1;
document.getElementById("idImg").src = aFilePr[k];
document.getElementById("idLnk").href = aFile[k];
document.getElementById("idFileName").innerText = aName[k];
document.getElementById("chkPreview").checked = aPrin[k];
					
}

function next(){
k=k+1;
if(k>=parseInt(document.getElementById("idTotal").innerText)){
	k=k-1;}
	
document.getElementById("idK").innerText=k+1;
document.getElementById("idImg").src = aFilePr[k];
document.getElementById("idLnk").href = aFile[k];
document.getElementById("idFileName").innerText = aName[k];
document.getElementById("chkPreview").checked = aPrin[k];
//alert(aPrin[k]);					
}

function _back(){
k=k-1;
if(k<0){k=k+1;}

document.getElementById("idK").innerText=k+1;
document.getElementById("idImg").src = aFilePr[k];
document.getElementById("idLnk").href = aFile[k];
document.getElementById("idFileName").innerText = aName[k];
document.getElementById("chkPreview").checked = aPrin[k];				
}

function delFile(){

if(!confirm("Seguro Elimina Imagen." + aName[k])){
	return;
	}

	var url = "js/archivos.asp?RECURSO=delFile";
		url += "&FAMILIA=PROPIEDADES"; 
		url += "&IDENTIFICADOR="+document.getElementById("idCod").value;
		url += "&ID=" + aFileId[k];
		url += "&VTZ=" + Math.random();
    
	//window.open(url);
	
		$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){
			});//end each
		})//end $get
		
listArchivos();
}


function newFile(){
document.frameFiles.mostrarVentana(document.getElementById("idCod"),"PROPIEDADES",divFiles);
}

function showNewPr(){
				
	var _cod = document.getElementById("idCod").value;
	var _des= document.getElementById("idDesc").value;
	
document.frameNew.showWin(_cod, _des, document.getElementById("divNew"));

}


function updatePr(){

	var url = "js/articulos.asp?RECURSO=updatePr&ID=" + document.getElementById("idCod").value
		url += "&ESTADO=" + document.getElementById("idEstado").value
		url += "&DESCRIPCION=" + document.getElementById("idDesc").value
		url += "&FECHA=" + document.getElementById("idFecha").value
		url += "&FAMILIA=" + document.getElementById("listFamilia").value;
		url += "&SUB_FAMILIA=" + document.getElementById("listTipos").value;
				
		url += "&OBSERVACION=" + scape(document.getElementById("idObservacion").value);
		url += "&UBICACION=" + document.getElementById("idDireccion").value
		url += "&VALOR=" + document.getElementById("idValor").value 
		url += "&VTZ=" + Math.random(); 
				
							
		//window.open(url);
		
$.get(url, function(theXML){
				$('ROW',theXML).each(function(i){
					var id = $(this).find("ID").text();
			}) , alert("Producto Actualizado.");//end each
	})//end $get
			
}




function inicio(){
var parametro = getParametro("CODIGO");
if (parametro){
		formulario.TxtCodigo.value = parametro;
		getPr();
		}
		
document.getElementById("idCod").focus();	

}

var CreateNewImage = function (_img) {

		  // alert(_img.src);
		   url = _img.src;
		   
            var img = new Image;
            img.src = url;
            img.width =  50;//img.width * (1 + (value / 100));
            img.height = 50//img.height * (1 + (value / 100));

            var container = document.getElementById("container");
			container=img;
			
            //container.appendChild (img);
        }
		
		
function userImage(file) {

    if(document.all)
        document.getElementById('showImage').src = file.value;
    else
        document.getElementById('showImage').src = file.files.item(0).getAsDataURL();
    if(document.getElementById('showImage').src.length > 0)
        document.getElementById('showImage').style.display = 'block';
}