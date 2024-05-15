// JavaScript Document


var deviceIphone = "iphone";
var deviceIpod = "ipod";

//Initialize our user agent string to lower case.
var uagent = navigator.userAgent.toLowerCase();

function inicio(){
		if (DetectIphoneOrIpod())
		document.location ='/sgm/movil/index.html';
	}
//**************************
// Detects if the current device is an iPhone.
function DetectIphone()
{
   if (uagent.search(deviceIphone) > -1)
      return true;
   else
      return false;
}
//**************************
// Detects if the current device is an iPod Touch.
function DetectIpod()
{
   if (uagent.search(deviceIpod) > -1)
      return true;
   else
      return false;
}
//**************************
// Detects if the current device is an iPhone or iPod Touch.
function DetectIphoneOrIpod()
{
    if (DetectIphone())
       return true;
    else if (DetectIpod())
       return true;
    else
       return false;
}
//**************************
function DetectBrowser()
{
	var nav
	if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
		 var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
		 if (ieversion>=9)
		  nav = "IE9"
		 else if (ieversion>=8)
		  nav = "IE8"
		 else if (ieversion>=7)
		  nav = "IE7"
		 else if (ieversion>=6)
		  nav = "IE6"
		 else if (ieversion>=5)
		  nav = "IE5"
	}else if (/Firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Firefox/x.x or Firefox x.x (ignoring remaining digits);
		 var ffversion=new Number(RegExp.$1) // capture x.x portion and store as a number
		 if (ffversion>=5)
		  nav = "FF5"
		 else if (ffversion>=4)
		  nav = "FF4"
		 else if (ffversion>=3)
		  nav = "FF3"
		 else if (ffversion>=2)
		  nav = "FF2"
		 else if (ffversion>=1)
		  nav = "FF1"
	}else if (/Opera[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Opera/x.x or Opera x.x (ignoring remaining decimal places);
		 var oprversion=new Number(RegExp.$1) // capture x.x portion and store as a number
		 if (oprversion>=10)
		  nav = "OP10"
		 else if (oprversion>=9)
		  nav = "OP9"
		 else if (oprversion>=8)
		  nav = "OP8"
		 else if (oprversion>=7)
		  nav = "OP7"
	}else if (/Safari[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Safari/x.x or Safari x.x (ignoring remaining decimal places);
		 var oprversion=new Number(RegExp.$1) // capture x.x portion and store as a number
		 if (oprversion>=5)
		  nav = "SF5"
		 else if (oprversion>=4)
		  nav = "SF4"
		 else if (oprversion>=3)
		  nav = "SF3"
		 else if (oprversion>=2)
		  nav = "SF2"
	}else if (/Chrome[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Chrome/x.x or Chrome x.x (ignoring remaining decimal places);
		 var oprversion=new Number(RegExp.$1) // capture x.x portion and store as a number
		 if (oprversion>=19)
		  nav = "CR19"
		 else if (oprversion>=18)
		  nav = "CR18"
		 else if (oprversion>=17)
		  nav = "CR17"
		 else if (oprversion>=16)
		  nav = "CR16"
//	}else if (/Netscape[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Netscape/x.x or Netscape x.x (ignoring remaining decimal places);
//		 var oprversion=new Number(RegExp.$1) // capture x.x portion and store as a number
//		 if (oprversion>=10)
//		  nav = "SF10"
//		 else if (oprversion>=9)
//		  nav = "SF9"
//		 else if (oprversion>=8)
//		  nav = "SF8"
//		 else if (oprversion>=7)
//		  nav = "SF7"
//	}else if (/Konqueror[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Konqueror/x.x or Konqueror x.x (ignoring remaining decimal places);
//		 var oprversion=new Number(RegExp.$1) // capture x.x portion and store as a number
//		 if (oprversion>=10)
//		  nav = "SF10"
//		 else if (oprversion>=9)
//		  nav = "SF9"
//		 else if (oprversion>=8)
//		  nav = "SF8"
//		 else if (oprversion>=7)
//		  nav = "SF7"

	}else{
		  nav = "NA"
	}
	return nav
}


function DetectAcento(texto) 
{
	texto=texto.replace(/(À|Á|Â|Ã|Ä|Å|Æ)/gi,'A'); // cambio las "A"s exoticas por "A"s 
	texto=texto.replace(/(È|É|Ê|Ë)/gi,'E'); //lo mismo con las "E" y resto de vocales y la "Ñ"
	texto=texto.replace(/(Ì|Í|Î|Ï)/gi,'I');
	texto=texto.replace(/(Ò|Ó|Ô|Ö)/gi,'O');
	texto=texto.replace(/(Ù|Ú|Û|Ü)/gi,'U');
	texto=texto.replace(/(À|á|Â|Ã|Ä|Å|Æ)/gi,'a'); // cambio las "A"s exoticas por "A"s 
	texto=texto.replace(/(È|é|Ê|Ë)/gi,'e'); //lo mismo con las "E" y resto de vocales y la "Ñ"
	texto=texto.replace(/(Ì|í|Î|Ï)/gi,'i');
	texto=texto.replace(/(Ò|ó|Ô|Ö)/gi,'o');
	texto=texto.replace(/(Ù|ú|Û|Ü)/gi,'u');	
	texto=texto.replace(/(Ñ)/gi,'N'); 
	texto=texto.replace(/(ñ)/gi,'n'); 	
	textof = texto
//	longitud = texto.length; //tomo la longitud de la cadena contenida en la caja
//	patolin = new Array(); //creo un array llamado "patolin"
//	for (i=0; i<longitud; i++) //inicio un FOR que tenga como limite la longitud de mi cadena
//		{
//		patolin[i]=texto.charAt(i); //guardo cada caracter en una posicion del array
//		 codigo_tecla=texto.charCodeAt(i); //obtengo el ASCII DECIMAL de el caracter...
//		 if ((codigo_tecla < 48 || codigo_tecla > 57) && (codigo_tecla < 65 || codigo_tecla > 90) && (codigo_tecla < 96 ||  codigo_tecla > 122) && (codigo_tecla != 13) && (codigo_tecla != 44)&& (codigo_tecla != 45) && (codigo_tecla != 46) && (codigo_tecla != 47) && (codigo_tecla != 8)  && (codigo_tecla != 16) && (codigo_tecla != 32)) //Si el codigo ASCII DECIMAL esta fuera de este rango...
//			{
//			patolin[i]=''; //cambiamos ese caracter por un nulo...
//			} 
//			
//		}
//	var textof=''; //declaro una cariable textof (texto final)
//	for (i=0;i<longitud;i++) //con otro FOR construyo la nueva cadena
//	{
//	textof=textof+patolin[i]; 
//	}
	return textof; //envio la cadena final a la caja...
}