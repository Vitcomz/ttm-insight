/*
Necesita software de calidad y a precio justo?
Visiteme www.vitcomz.com
*/

var browser =  DetectBrowser();
var id_br = browser.substring(0,2);  

var cod = new Array();
var codP = new Array();
var nom = new Array();
var lnk = new Array();


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


//Globals Var 
//Crea el Encabezado

var usuario = getSession();
var empresa = getEmpresa();
var _nombres;
var _user;
var _cargo;
var Bodega;
var desBodega;
var _rol;

//alert(getSession());

if (getSession()=='UNDEFINED'){
			window.location.href="login.html";
		//	return;
}
		
var url;
	url = "/sci/xml/usuarios.asp?RECURSO=getUsuario&ID=" + usuario;
	url += "&EMPRESA=1";// + empresa;
	url += "&VTZ=" + Math.random();
		
	//window.open(url);

	 $.get(url, function(theXML){
			$('ROW',theXML).each(function(i){
			 _user = $(this).find("NOMBRES").text()+ " " + $(this).find("APELLIDOS").text();
			 document.getElementById("idUser").innerText = _user;
			 _rol  = $(this).find("ROL").text();
			document.getElementById("idCargo").innerText =  $(this).find("DESC_CARGO").text();
		 
		}),makeMn();//
	});	//End $.get
	 

		 
											

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
function makeMn(){
	
var url;
var _cod;
var _codP;
var _nom;
var _lnk;
url = "/sci/xml/Menu.asp?RECURSO=ListMenuxRol&SISTEMA=SGM";
url += "&ROL=" + _rol;
url += "&VTZ=" + Math.random();

//url = "js/test.xml";
//window.open(url);
 $.get(url, function(theXML2){
			$('ROW',theXML2).each(function(i){			
										   
				_cod  = $(this).find("CODIGO").text();
				_codP = $(this).find("COD_MENU_PADRE").text();
				_nom = $(this).find("NOMBRE").text();
				_lnk = $(this).find("LINK").text();
				
				cod[i]  = _cod;
				codP[i] = _codP;
				nom[i]  = _nom;
				lnk[i]  = _lnk;
							
				}),fin();//End Each
	});	//End $.get
	 

}

function fin(){
	
for(i=0;i<cod.length;i++){
	//alert(cod[i]);
	oCMenu.makeMenu(cod[i], codP[i], nom[i], lnk[i]);	
}
oCMenu.construct();
}
