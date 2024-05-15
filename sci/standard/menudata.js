/*** 
This is the menu creation code - place it right after you body tag
Feel free to add this to a stand-alone js file and link it to your page.
**/

function makeArray() {
		for (i = 0; i<makeArray.arguments.length; i++)
		this[i + 1] = makeArray.arguments[i];
	}

function FechaActual() {
		var months = new makeArray('Enero','Febrero','Marzo','Abril','Mayo',
					'Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
		var date = new Date();
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var yy = date.getYear();
		var year = (yy < 1000) ? yy + 1900 : yy;
		var str = day + " de " + months[month] + " de " + year;
		return str;
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
      
   function winError(_Str){
          var win = window.open ("","RepWindow","toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,width=500,height=400");
				var doc = win.document;
				doc.clear();	//clear the window
				doc.write('<html><head><title>Error</title></head>');
				doc.write('<body>' + _Str + '</body>');
				doc.close();
	}
	
function getCookieVal(offset) {
	var endstr = document.cookie.indexOf (";", offset);
	if (endstr == -1)
			endstr = document.cookie.length;
		return unescape(document.cookie.substring(offset, endstr));
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

function GetSession(){
	var ID = GetCookie('log');
	//alert(ID);
	if(ID == null)
			return "DESCONOCIDO";
	else 
		return ID.toUpperCase();
}



	//Crea el Encabezado
var Usuario = GetSession();
var nombres;
var cargo;
var rol;

if (document.implementation && document.implementation.createDocument)
	{//Mozilla
		xmlTmp = document.implementation.createDocument("", "", null);
	}
	else if (window.ActiveXObject)
	{//IExplorer
		xmlTmp = new ActiveXObject("Microsoft.XMLDOM");
	}
	else
		alert('Your browser can\'t handle this script');
	   
	   
	   
var url;
	url = "xml/Usuarios.asp?RECURSO=GetUsuario&ID=" + Usuario;
		if (id_br == "IE")
		{
			var xmlTemp = document.getElementById("xmlTemp");
			xmlTemp.async = false;
		}else if (id_br == "FF" || id_br == "OP" || id_br == "SF"){
			var xmlTemp = document.implementation.createDocument("", "", null);
		}
	 //window.open(url);
		var xmlDso = xmlDoc.XMLDocument;
		if (id_br == "FF" || id_br == "OP" || id_br == "SF")
		{
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.open("GET",url,false);
					xmlhttp.send();
					xmlDoc=xmlhttp.responseText;
                    parser = new DOMParser();
            		xmlDso = parser.parseFromString(xmlDoc, "text/xml"); 
					res = parser.parseFromString(xmlDoc, "text/xml"); 
					//alert(xmlDso);
					//window.open(url);
		}
		else if (id_br == "IE")
		{
			res = xmlDso.load(url);
		}	
		
	if (res){
		var tree = xmlDso.documentElement;	
           if (tree.childNodes.length>0){
					for (var i = 0; i < tree.childNodes.length; i++){
							var node = tree.childNodes.item(i);
							nombres = getChildNodeValue(node,'NOMBRES')  + " " +
								getChildNodeValue(node,'APELLIDOS') ; 
							cargo = getChildNodeValue(node,'DESC_CARGO'); 
							rol = getChildNodeValue(node,'ROL'); 
								}
		   				}				
		}
	else
		window.open(url);


			
			

var script = "<div style='Z-INDEX: 10000;POSITION: absolute; TOP: 0px;LEFT: 2px;text-align:left;'>";
	script = script + "<style>.txtTitle{font-family:Verdana, Tahoma, Arial;font-size:10px;font-weight:bold;color:#00000;}</style>";
	script = script + "<style>.txt{font-family:Verdana, Tahoma, Arial;font-size:10px;font-weight:bold;color:#000000;}</style>";
	script = script + "<TABLE width='100%' cellpadding='0' cellspacing='0'><TR>";
	script = script + "<TD align='left' class=txtTitle>SISTEMA DE CONFIABILIDAD TTM   </TD><TD class=txtTitle> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>";
	script = script + "<TD align='right' class=txt>" + FechaActual() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR>";
	script = script + "<TR><TD class=txtTitle>USUARIO : " + nombres + "</TD><TD class=txtTitle></TD>";
	//script = script + "<TR><TD class=txtTitle>USUARIO : " + Nombres + "</TD><TD class=txtTitle>ZONA :" + desBodega + "</TD>";
	script = script + "<TD align='right' class=txt>" + cargo + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD><TR>";
	script = script + "</TABLE>";
	script = script + "</div>";

this.document.write(script);
//Menu object creation
oCMenu=new makeCM("oCMenu") //Making the menu object. Argument: menuname

oCMenu.frames = 0

//Menu properties   
oCMenu.pxBetween=1
oCMenu.fromLeft=0 
oCMenu.fromTop=30   
oCMenu.rows=1 
oCMenu.menuPlacement="left"
                                                             
oCMenu.offlineRoot="/" 
oCMenu.onlineRoot="/" 
oCMenu.resizeCheck=1 
oCMenu.wait=500 
oCMenu.fillImg="cm_fill.gif"
oCMenu.zIndex=8000

//Background bar properties
oCMenu.useBar=1
oCMenu.barWidth="100%"
oCMenu.barHeight="21" 
oCMenu.barClass="clBar"
oCMenu.barX=0 
oCMenu.barY=30
oCMenu.barBorderX=0
oCMenu.barBorderY=0
oCMenu.barBorderClass="clBar"

//Level properties - ALL properties have to be spesified in level 0
oCMenu.level[0]=new cm_makeLevel() //Add this for each new level
oCMenu.level[0].width=110
oCMenu.level[0].height=19
oCMenu.level[0].regClass="clLevel0"
oCMenu.level[0].overClass="clLevel0over"
oCMenu.level[0].borderX=1
oCMenu.level[0].borderY=1
oCMenu.level[0].borderClass="clLevel0border"
oCMenu.level[0].offsetX=1
oCMenu.level[0].offsetY=1
oCMenu.level[0].rows=0
oCMenu.level[0].arrow=0
oCMenu.level[0].arrowWidth=2
oCMenu.level[0].arrowHeight=2
oCMenu.level[0].align="bottom"

//EXAMPLE SUB LEVEL[1] PROPERTIES - You have to specify the properties you want different from LEVEL[0] - If you want all items to look the same just remove this
oCMenu.level[1]=new cm_makeLevel() //Add this for each new level (adding one to the number)
oCMenu.level[1].width=oCMenu.level[0].width-2
oCMenu.level[1].height=20
oCMenu.level[1].regClass="clLevel1"
oCMenu.level[1].overClass="clLevel1over"
oCMenu.level[1].borderX=1
oCMenu.level[1].borderY=1
oCMenu.level[1].align="right" 
oCMenu.level[1].offsetX=-(oCMenu.level[0].width-2)/2+20
oCMenu.level[1].offsetY=0
oCMenu.level[1].borderClass="clLevel1border"


//EXAMPLE SUB LEVEL[2] PROPERTIES - You have to spesify the properties you want different from LEVEL[1] OR LEVEL[0] - If you want all items to look the same just remove this
oCMenu.level[2]=new cm_makeLevel() //Add this for each new level (adding one to the number)
oCMenu.level[2].width=110
oCMenu.level[2].height=20
oCMenu.level[2].offsetX=0
oCMenu.level[2].offsetY=0
oCMenu.level[2].regClass="clLevel2"
oCMenu.level[2].overClass="clLevel2over"
oCMenu.level[2].borderClass="clLevel2border"


/******************************************
Menu item creation:
myCoolMenu.makeMenu(name, parent_name, text, link, target, width, height, regImage, overImage, regClass, overClass , align, rows, nolink, onclick, onmouseover, onmouseout) 
*************************************/
var url;
url = "/sci/xml/Menu.asp?RECURSO=ListMenuxRol&SISTEMA=SCI";
url += "&ROL=" + rol;


		if (id_br == "IE")
		{
			var xmlTemp2 = document.getElementById("xmlTemp2");
			xmlTemp2.async = false;
		}else if (id_br == "FF" || id_br == "OP" || id_br == "SF"){
			var xmlTemp2 = document.implementation.createDocument("", "", null);
		}
	 //window.open(url);

		if (id_br == "FF" || id_br == "OP" || id_br == "SF")
		{
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.open("GET",url,false);
					xmlhttp.send();
					xmlDoc=xmlhttp.responseText;
                    parser = new DOMParser();
            		xmlDso = parser.parseFromString(xmlDoc, "text/xml"); 
					res = parser.parseFromString(xmlDoc, "text/xml"); 
					//alert(xmlDso);
					//window.open(url);
		}
		else if (id_br == "IE")
		{
			res = xmlDso.load(url);
		}	

if (res){
		var tree = xmlDso.documentElement;	
           if (tree.childNodes.length>0){
			for (var i = 0; i < tree.childNodes.length; i++){
	   			var node = tree.childNodes.item(i);
				str = getChildNodeValue(node,'CODIGO');
				oCMenu.makeMenu(getChildNodeValue(node,'CODIGO'), getChildNodeValue(node,'COD_MENU_PADRE'),getChildNodeValue(node,'NOMBRE'),getChildNodeValue(node,'LINK'));
				str = str + "," + getChildNodeValue(node,'COD_MENU_PADRE');
				str = str + "," + getChildNodeValue(node,'NOMBRE');
				str = str + "," + getChildNodeValue(node,'LINK');
				//alert(str);							
				}//for					
		   }//if
}//if
//else
//window.open(url);
	
//setTimeout(oCMenu.construct(),1);
oCMenu.construct();

if 	(Usuario == "DESCONOCIDO")
		self.location.href="Login.html";
