
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
function GetCookieMoz(name) {
	  var ca = document.cookie.split(';');
	  var nameEQ = name + "=";
	  for(var i=0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1, c.length); //delete spaces
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
		}
	  return "";
}
function getCookieVal(offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
			endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}

function GetSession(){
	var ID = GetCookie('log');
	if(ID == null)
		return "DESCONOCIDO";
	else 
		return ID.toUpperCase();
}

var username=GetSession();
//  alert(username);
  if (username!=null && username!="DESCONOCIDO")
  {

  }
else 
  {
	  	//alert("Session Cerrada");
		document.location ='/index.html?logs=out';
  }
  
  
function DelSession(){
	DeleteCookie('log');
	DeleteCookie('emp');
	document.location ='/index.html?logs=out';
}  
function DeleteCookie (name) { 
	var exp = new Date(); 
	exp.setTime (exp.getTime() - 1); 
	var cval = GetCookie (name); 
	document.cookie = name + "=" + cval + "; expires=" + 
	exp.toGMTString();
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