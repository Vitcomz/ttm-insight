<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
CAUSA=UCASE(REQUEST("CAUSA"))
ACCION=UCASE(REQUEST("ACCION"))
ESTATUS=UCASE(REQUEST("ESTATUS"))
EJECUTOR=UCASE(REQUEST("EJECUTOR"))
CRITICIDAD=UCASE(REQUEST("CRITICIDAD"))
SECCION=UCASE(REQUEST("SECCION"))
CONDICION=UCASE(REQUEST("CONDICION"))
COLOR=UCASE(REQUEST("COLOR"))
VALOR_COMBUSTIBLE=UCASE(REQUEST("VALOR_COMBUSTIBLE"))
DOC_COMBUSTIBLE=UCASE(REQUEST("DOC_COMBUSTIBLE"))
DESC_SECCION=UCASE(REQUEST("DESC_SECCION"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
ULT_INSPECCION=UCASE(REQUEST("ULT_INSPECCION"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
FAENA=UCASE(REQUEST("FAENA"))
NAVE=UCASE(REQUEST("NAVE"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
RESPONSABLE=REQUEST("RESPONSABLE")
RECOMENDACION=REQUEST("RECOMENDACION")
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
OT=UCASE(REQUEST("OT"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
NUM=UCASE(REQUEST("NUM"))
DANO=UCASE(REQUEST("DANO"))
TIPO_TURNO=UCASE(REQUEST("TIPO_TURNO"))
TIPO=UCASE(REQUEST("TIPO"))
TURNO=UCASE(REQUEST("TURNO"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
SUB_EQUIPO=UCASE(REQUEST("SUB_EQUIPO"))
ESTADO=UCASE(REQUEST("ESTADO"))
EXCEL=UCASE(REQUEST("EXCEL"))
FECHA_PROGRAMADA=UCASE(REQUEST("FECHA_PROGRAMADA"))
USUARIO=UCASE(REQUEST("USUARIO"))
CINTA=UCASE(REQUEST("CINTA"))
MES=UCASE(REQUEST("MES"))
USERNAME=REQUEST("USERNAME")
DESCRIPCION=REQUEST("DESCRIPCION")
IND_DANO=UCASE(REQUEST("IND_DANO"))
IND_INCIDENTE=UCASE(REQUEST("IND_INCIDENTE"))
IND_SOLUCION=UCASE(REQUEST("IND_SOLUCION"))
PRIORIDAD=UCASE(REQUEST("PRIORIDAD"))
PLANTA=UCASE(REQUEST("PLANTA"))
ESTADO=UCASE(REQUEST("ESTADO"))
IMG=UCASE(REQUEST("IMG"))
DT=UCASE(REQUEST("DT"))

		FECHA_INI="01/01/2009"
		FECHA_FIN="01/12/2090"
		CRITICIDAD="TOD"
		RESPONSABLE="TOD"
		TURNO="TOD"
		
		if (DT = "1") THEN
			EQUIPO=UCASE(REQUEST("SUB_EQUIPO"))
		else
			EQUIPO="TOD"
		END IF
		
		EQUIPO_PRIN = UCASE(REQUEST("EQUIPO"))
		
		FAENA=UCASE(REQUEST("FAENA"))
		if FAENA = "" then
			dim x,y
			for each x in Request.Cookies
			  if x = "emp" then
				FAENA = Request.Cookies(x)
			  elseif  x = "log" then
				USUARIO = Request.Cookies(x)
			  end if
			next
		end if
		IND_DANO="TOD"
		IMG="1"
		IND_SOLUCION="false"



	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' '  " 'substring(convert(char,b.fecha,108),1,5)
	query = query & "  as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE())+1 , DBO.EquipoPrincipal(B.EQUIPO),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.REPORT "
	query = query & " FROM BITACORAS AS B "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " WHERE 1=1"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	If RESPONSABLE<>"TOD" AND LEN(RESPONSABLE)>0 Then
		query = query & " AND B.RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	'If TURNO<>"TOD" Then'
	'	query = query & " AND TURNO=" & strNvl(TURNO)'
'	End if'
	
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else
			if IMG = "1" Then		
				query = query & " AND E.GCODE=" & SUB_EQUIPO & ""
			else
				query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
			End if
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION)=" & trim(EQUIPO_PRIN) & ""
		
	ELSE
			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
			End if
	End if
	
	If CRITICIDAD<>"TOD"  Then
		query = query & " AND B.COLOR=" & strNvl(CRITICIDAD)
	End if
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_SOLUCION<>"TOD" Then
		query = query & " AND IND_SOLUCION=" & strNvl(IND_SOLUCION)
	End if
	
	
	query = query & " GROUP BY B.ID,B.FECHA, TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, X, Y, REPORT "
	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO), B.FECHA DESC  "
	
	Set ORs =oDB.EjecutaSql(query)
	
	'response.write query
	'response.end
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName

'	strName = Date()
'	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
				context = " "'<span class='texto'>" &  query & "</span>"
				context = context &  "<table width='98%' BORDER='0' CELLPADDING='5' CELLSPACING='0' style='font-size:12px' ID='tabEquipo' align='center'>"
				N=0
				Eqx = ""
				While Not ORs.EOF 
					N=N+1
				  	context = context &  "<tr>"
				  	context = context &  "<tr><td>EQUIPO</td><td>" & ORs.Fields.Item(14).Value  & "</td>"
					
					Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
				  	If Not oRsFiles.EOF Then
						  	context = context &  "<td rowspan=10  align='center' valign='top'><span >"
					  		context = context & "<img id='idImg"&N&"' src='../FILES/"& ORsFiles.Fields.Item(0).Value  & "' alt='" & ORs.Fields.Item(4).Value & "' "



					  		context = context &  "width='200' height='200' border='1' style='cursor:pointer;' onerror='loadImage(this)' onclick='zoomImg(this);'/><br /><br />"
					  		context = context &  "</td>"
				  elseif oRsFiles.EOF Then
					  		context = context &  "<td WIDTH='126' colspan=2><p><a href='../images/noDisponible.png'  rel='facebox'  id='screenfile"&N&"_href'>"
					  		context = context & "<img id='screenfile"&N&"_img' src='../images/noDisponible.png' "
					  		context = context &  "WIDTH='100' border='1'/><br /><br />"
					  		context = context &  "</a></p></td>"
				  end if
	  			    context = context &  "</tr>"
					context = context &  "<tr><td>AVISO SAP</td><td>" & ORs.Fields.Item(20).Value & "</td></tr>"
					context = context &  "<tr><td>COMPONENTE</td><td>" & ORs.Fields.Item(8).Value & "</td></tr>"
					context = context &  "<tr><td>FECHA </td><td>" & ORs.Fields.Item(1).Value & "</td></tr>"
					context = context &  "<tr><td>DIAS INFORMADO </td><td>" & ORs.Fields.Item(13).Value & "</td></tr>"
				  	context = context &  "<tr><td>CRITICIDAD</td><td>" & ORs.Fields.Item(10).Value & "</td></tr>"
				 	context = context &  "<tr><td>&nbsp; </td><td> </td><td> </td></tr>"
				 	context = context &  "<tr><td>&nbsp; </td><td> </td><td> </td></tr>"
				 	context = context &  "<tr><td>&nbsp; </td><td> </td><td> </td></tr>"

				  	session("EQUIPO") = ORs.Fields.Item(1).Value
				  	 
				  	if ORs.Fields.Item(16).Value <> NULL then
				'  		context = context &  "<tr><td><span class='normal'>" & ORs.Fields.Item(16).Value & "</span></td></tr>"
				 	 else 
				'  		context = context &  "<tr><td></span>&nbsp<span class='normal'> </td></tr>"
					 end if
					 
				
				  context = context &  "<td  colspan=3 VALIGN='TOP'  style='font-size:12'><br/> " & ORs.Fields.Item(4).Value 
				  context = context &  "</span><br /><br />RECOMENDACION :<span class='normal'>" & ORs.Fields.Item(15).Value 
				  context = context &  "</span>  <br /> </td>"
				  
				  'context = context &  "' WIDTH='100' border='1'  ONERROR='this.src='images/noDisponible.png''/><br /><br />"
				  'context = context &  "</a></p></td>"
				  
				  context = context &  "</tr>"
				 
				  context = context &  "<tr><td colspan=3><hr><br /></td></tr>"
				  ORs.MoveNext 
				Wend
				'response.write context
 
				context = context &  "</table>"

  


	

	
function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function
Function getFiles(Bitacora)

    query = "SELECT (RTRIM(CAST(A.ID AS CHAR)) + '.' + CAST(A.EXT AS CHAR)) AS FILENAME FROM ARCHIVOS AS A "
	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
	query = query & " AND A.FAMILIA='BITACORAS' and A.EXT<>'pdf'"
	
	Set getFiles =oDB.EjecutaSql(query)

End Function
%>
 
 	
<script type="text/javascript" src="/Scripts/deteccion.js"></script>	
<script type="text/javascript">
	var browser =  DetectBrowser();
	var id_br = browser.substring(0,2);	
</script>


<script type="text/javascript">

function showFile(id){

var url = id.src;

var myWindow = window.open(url, "MsgWindow", "width=800,height=500,top=100,left=100,");
myWindow.document.write("<p><center><img src='" + url + "' /></center></p>");

	//window.open(url);

}


	function loadImage(xx)
	{
		var sd = xx.id;
		arr = sd.split("_"); 
		if (id_br == 'IE'){
			eval(arr[0] + "_href").href="../images/noError.png";
			xx.src="../images/noError.png";
		}else if (id_br == "FF" || id_br == "OP" || id_br == "SF"  || id_br == "CR"){
			//var obj = eval(arr[0] + "_href");
			document.getElementById(sd).src="../images/noError.png";
			//xx.src="../images/noDisponible.png";
			document.getElementById(arr[0] + "_href").href="../images/noError.png";
			//obj.href="../images/noDisponible.png";
		}		
	}
</script>
<link rel="stylesheet" href="windowfiles/dhtmlwindow.css" type="text/css" >
 <script language="Javascript1.2" src="windowfiles/dhtmlwindow.js"></script>
 
<style>
body{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-size:10px;
 
}

.hidden{
visibility:hidden;
position: fixed; /* Stay in place */
    z-index: 10000; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}


</style>


<body style="font-size:10px;">


<script>
// Get the modal
var modal = parent.document.getElementById('myModal');

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = document.getElementById('myImg');
var modalImg = parent.document.getElementById("img01");
var captionText = parent.document.getElementById("caption");

function zoomImg(obj){
//alert(obj.src);

    modal.style.display = "block";
    modalImg.src = obj.src;
    captionText.innerHTML = obj.alt;
}

// Get the <span> element that closes the modal
//var span = parent.document.getElementsByClassName("close")[0];
var span = parent.document.getElementById("idClose");

// When the user clicks on <span> (x), close the modal
span.onclick = function() { 
    modal.style.display = "none";
	
	//parent.document.getElementById("myModal").className="hidden";
	//alert("Cerrar");
}
</script>



<div  ID="tabEquipos"  style="font-size:10px; visibility:visible;width:100%;"><%=context%></div>


</body>

