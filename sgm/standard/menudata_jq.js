/*** 
This is the menu creation code - place it right after you body tag
Feel free to add this to a stand-alone js file and link it to your page.
**/
var browser =  DetectBrowser();
var id_br = browser.substring(0,2);  

function loadxml(xmlfile){
	var xmldoc;
	var xhttp;
	if (id_br == "FF" || id_br == "OP" || id_br == "SF")
	{//Mozilla
		xmldoc = document.implementation.createDocument("", "", null);
		xmldoc = new window.XMLHttpRequest();
		xmldoc.open("GET",xmlfile,false);
		xmldoc.send("");
		xhttp=xmldoc.responseText;
		parser = new DOMParser();
		xmlDoc = parser.parseFromString(xhttp, "text/xml"); 
		return xmlDoc.responseXML;
//		return xmldoc.responseXML;
	}
	else if (id_br == "IE")
	{//IExplorer
		xmldoc = new ActiveXObject("Microsoft.XMLDOM");
		xmldoc.async = false;
		xmldoc.load(xmlfile);
		//alert('explorer');
		return xmldoc;
	}
	else{
		alert('Your browser can\'t handle this script');
	}

}

//function loadXMLDoc(myURL)
// {
// if (window.XMLHttpRequest)
//   {
//   xhttp=new XMLHttpRequest();
//   }
// else
//   {
//   xhttp=new ActiveXObject("Microsoft.XMLHTTP");
//   }
// xhttp.open("GET",myURL,false);
// xhttp.send("");
// //------------------------------
//	 if (document.implementation && document.implementation.createDocument){
//		 xmlDoc=xhttp.responseText;
//		 parser = new DOMParser();
//		 xhttp = parser.parseFromString(xmlDoc, "text/xml"); 
//		 return xhttp.responseXML;
//	 }else{
//		 return xhttp.responseXML;
//	 }
// //------------------------------
// //return xhttp.responseXML; (Ver. old)
// } 
 
function loadXMLDoc(myURL)
 {
 if (window.XMLHttpRequest)
   {
   xhttp=new XMLHttpRequest();
   }
 else
   {
   xhttp=new ActiveXObject("Microsoft.XMLHTTP");
   }
 xhttp.open("GET",myURL,false);
 xhttp.send();
 return xhttp.responseXML;
 } 
   
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

function getEmpresa(){
	var ID = GetCookie('emp');
	//alert(ID);
	if(ID == null)
			return "DESCONOCIDO";
	else 
		return ID.toUpperCase();
}

//Globals Var 
//Crea el Encabezado

var Usuario = GetSession();
var empresa = getEmpresa();
if (getParametro("EMPRESA")!=''){empresa = getParametro("EMPRESA");};
var Nombres;
var Cargo;
var Bodega;
var desBodega;
var rol;



		var	url = "/sci/xml/Usuarios.asp?RECURSO=GetUsuario&ID=" + Usuario;
		
		xmlTmp = loadXMLDoc(url);
		  
	if (xmlTmp){
		var tree = xmlTmp.documentElement;
           if (tree.childNodes.length>0){
					for (var i = 0; i < tree.childNodes.length; i++){
									var node = tree.childNodes.item(i);
									Nombres = getChildNodeValue(node,'NOMBRES')  + " " + getChildNodeValue(node,'APELLIDOS') ; 
									Cargo = getChildNodeValue(node,'DESC_CARGO') ; 
									rol = getChildNodeValue(node,'ROL');
									}
		   				}				
		}
	else
		window.open(url);

	/*url = "/sci/xml/Bodegas.asp?RECURSO=GetBodegaActual";
	var res = xmlTmp.load(url);
	if (res){var tree = xmlTmp.documentElement;
           if (tree.childNodes.length>0){
					for (var i = 0; i < tree.childNodes.length; i++){
														var node = tree.childNodes.item(i);
														Bodega = getChildNodeValue(node,'CODIGO');
														desBodega = getChildNodeValue(node,'NOMBRE'); 
														}
		   				}				
		}
	else
		window.open(url);
		*/	

var script = "<div style='Z-INDEX: 10000;POSITION: absolute; TOP: 0px;LEFT: 2px;text-align:left;width:100%'>";
	script = script + "<style>.txtTitle{font-family:Verdana, Tahoma, Arial;font-size:10px;font-weight:bold;color:#00000;}</style>";
	script = script + "<style>.txt{font-family:Verdana, Tahoma, Arial;font-size:10px;font-weight:bold;color:#000000;}</style>";
	script = script + "<TABLE width='100%' cellpadding='0' cellspacing='0'><TR>";
	script = script + "<TD align='left' class=txtTitle>SISTEMA DE CONFIABILIDAD TTM CHILE</TD><TD class=txtTitle> FAENA : " + empresa + "</TD>";
	script = script + "<TD align='right' class=txt>" + FechaActual() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR>";
	script = script + "<TR><TD class=txtTitle>USUARIO : " + Nombres + "</TD><TD class=txtTitle></TD>";
	//script = script + "<TR><TD class=txtTitle>USUARIO : " + Nombres + "</TD><TD class=txtTitle>ZONA :" + desBodega + "</TD>";
	script = script + "<TD align='right' class=txt>" + Cargo + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD><TR>";
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
oCMenu.barHeight="menu" 
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
url = "/sci/xml/Menu.asp?RECURSO=ListMenuxRol&SISTEMA=SGM&EMPRESA="+getEmpresa();
url += "&ROL=" + rol;
url += "&VTZ=" + Math.random();

//var xmlDso = xmlMenu.XMLDocument;

//url = "/sci/xml/Menu.xml";
//window.open(url);

 
 
var emp = getEmpresa();

 

	$.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
					var codigo = $(this).find("CODIGO").text();
					var cod_padre = $(this).find("COD_MENU_PADRE").text();
					var nombre = $(this).find("NOMBRE").text();
					var lnk = $(this).find("LINK").text();
					
					if (codigo == 'INFMEL' && 
							(emp == 'ESCONDIDA' || 
							 emp == 'ESCONDIDA OLAP'  || 
							 emp == 'ESCONDIDA OXIDO')){
						//str = getChildNodeValue(node,'CODIGO');
							oCMenu.makeMenu(codigo,cod_padre, nombre, lnk );
	//					str = str + "," + getChildNodeValue(node,'COD_MENU_PADRE');
	//					str = str + "," + getChildNodeValue(node,'NOMBRE');
	//					str = str + "," + getChildNodeValue(node,'LINK');
						//alert(getChildNodeValue(node,'CODIGO'), getChildNodeValue(node,'COD_MENU_PADRE'),getChildNodeValue(node,'NOMBRE'),getChildNodeValue(node,'LINK'));
						//alert(getChildNodeValue(node,'CODIGO'));									
					}else if (codigo != 'INFMEL'){
						//str = getChildNodeValue(node,'CODIGO');
						oCMenu.makeMenu(codigo, cod_padre, nombre, lnk );
	//					str = str + "," + getChildNodeValue(node,'COD_MENU_PADRE');
	//					str = str + "," + getChildNodeValue(node,'NOMBRE');
	//					str = str + "," + getChildNodeValue(node,'LINK');
					}
					
				 
	 }) , cont();//end each
 })//end $get

//oCMenu.makeMenu('top0','','&nbsp;| Home','home.html','content')
//oCMenu.makeMenu('top1','','&nbsp;| Über uns', 'wir.html','content')
//  oCMenu.makeMenu('sub00','top1','Wir über uns', 'wir.html', 'content')
//    //oCMenu.makeMenu('sub001','sub00','- New DHTML API released','','',160,0)
//		//oCMenu.makeMenu('sub002','sub00','- Explorer 7 is out','','',160,0)
//		//oCMenu.makeMenu('sub003','sub00','- Opera 6 supports innerHTML','','',160,0)
//	oCMenu.makeMenu('sub01','top1','Kunden über uns','kunden.html', 'content')
//	//oCMenu.makeMenu('sub02','top1','Kooperationspartner über uns','partner.html', 'content')
//	
//oCMenu.makeMenu('top2','','&nbsp;| Aktuelles','aktuelles.html', 'content')
//	oCMenu.makeMenu('sub10','top2','Information','aktuelles.html', 'content')
//	oCMenu.makeMenu('sub11','top2','Presse','presse.html', 'content')
////	oCMenu.makeMenu('sub12','top1','Popular scripts','/scripts/index.asp?show=pop')
//	
//oCMenu.makeMenu('top3','','&nbsp;| Produkte','angebot.html', 'content')
//	oCMenu.makeMenu('sub21','top2','Tutorials','/tutorials/index.asp')
//		oCMenu.makeMenu('sub210','sub21','New tutorials','/tutorials/index.asp')
//		oCMenu.makeMenu('sub211','sub21','Tutorials archive','/tutorials/archive.asp')
//	oCMenu.makeMenu('sub22','top2','Other articles','/articles/index.asp')
//		oCMenu.makeMenu('sub220','sub22','New articles','/articles/index.asp?show=new')
//		oCMenu.makeMenu('sub221','sub22','Article archive','/articles/archive.asp')
//
//oCMenu.makeMenu('top4','','&nbsp;| Leistung','/leistung_kunde.html', 'content')
//	oCMenu.makeMenu('sub30','top4','für unsere Kunden','leistung_kunde.html', 'content')
//	//oCMenu.makeMenu('sub31','top4','für unsere Kooperationspartner','leistung_partner.html', 'content')
//	oCMenu.makeMenu('sub32','top4','Leistungsbilanz','leistung_leistungsbilanz.html', 'content')
////	oCMenu.makeMenu('sub33','top3','CoolMenus','/forums/forum.asp?FORUM_ID=2&CAT_ID=1&Forum_Title=CoolMenus')
////	oCMenu.makeMenu('sub34','top3','dhtmlcentral.com','/forums/forum.asp?FORUM_ID=5&CAT_ID=1&Forum_Title=dhtmlcentral%2Ecom')
////	oCMenu.makeMenu('sub35','top3','Cool sites','/forums/forum.asp?FORUM_ID=1&CAT_ID=1&Forum_Title=Cool+sites')
//
//oCMenu.makeMenu('top5','','&nbsp;| Kontakt','kontakt.html', 'content')
////	oCMenu.makeMenu('sub50','top5','Examples','/coolmenus/examples.asp')
////		oCMenu.makeMenu('sub500','sub50','With frames','/coolmenus/examples.asp?show=with')
////		oCMenu.makeMenu('sub501','sub50','Without frames','/coolmenus/examples.asp?show=without')
////	oCMenu.makeMenu('sub51','top5','Download','/coolmenus/download.asp')
////		oCMenu.makeMenu('sub510','sub51','Download the source code to this menu','/coolmenus/download.asp','',150,40)
////	oCMenu.makeMenu('sub52','top5','Tutorial','/coolmenus/tutorial.asp')
////		oCMenu.makeMenu('sub520','sub52','Learn how to set up the menu','/coolmenus/tutorial.asp','',150,40)
////	oCMenu.makeMenu('sub53','top5','MenuMaker','','',0,0,'','','','','','','','window.open("/coolmenus/maker/","","width=800,height=600")')
////		oCMenu.makeMenu('sub530','sub53','Use the menuMaker to make the menu code for you','','',150,40,'','','','','','','','window.open("/coolmenus/maker/","","width=800,height=600")')
////	oCMenu.makeMenu('sub54','top5','FAQ','/coolmenus/faq.asp')
////		oCMenu.makeMenu('sub540','sub54','Frequently asked questions','coolmenus/faq.asp','',150,40)
////	oCMenu.makeMenu('sub55','top5','Help forum','/forums/forum.asp?FORUM_ID=2&CAT_ID=1&Forum_Title=CoolMenus')
////		oCMenu.makeMenu('sub550','sub55','Go to this forum and post you problems or suggestions regarding the CoolMenus','/forum/forum.asp?forum_id=2','',150,40)
//oCMenu.makeMenu('top51','','&nbsp;| Glossar','glossar.html', 'content')
//oCMenu.makeMenu('top6','','&nbsp;| Impressum','impressum.html', 'content')
////oCMenu.makeMenu('top11','','&nbsp;','#', 'content', '10', '', '', '', '', '', '', '', '0')
//oCMenu.makeMenu('top7','','&nbsp;| <b>Login</b>','secret/login_home.html', 'content')
//oCMenu.makeMenu('top8','','&nbsp;| <b>Newsletter</b>','newsletter.html', 'content')
////oCMenu.makeMenu('top9','','&nbsp;','#', 'content', '40', '', '', '', '', '', '', '', '0')
////oCMenu.makeMenu('top10','','&nbsp;<b>Infocenter</font>','#', 'content', '', '', '', '', '', '', '', '', '0')
////Leave this line - it constructs the menu

function cont(){
	
//setTimeout(oCMenu.construct(),1);
oCMenu.construct();
}
//if(Usuario == "DESCONOCIDO")
//	self.location.href="Login.html";
//		
//if(empresa=="DESCONOCIDO")
//	this.location.href="Login.html";
if(Usuario == "DESCONOCIDO")
	self.location.href="/index.html";
		
if(empresa=="DESCONOCIDO")
	this.location.href="/index.html";
	
