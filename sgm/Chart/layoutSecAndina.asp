<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

EQUIPO=UCASE(REQUEST("EQUIPO"))
valX=REQUEST("X")
valZ=REQUEST("Z")
		
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

	if InStr(1, strNvl(EQUIPO), "CV00A7-PCAR") and valZ=0 then
		TITULO = " Agrupado Mesas Estocada "
		masDetalle = 2
		query = "SELECT E.Z, 'GRUPO '+CAST(E.Z AS VARCHAR) AS DESCRIPCION, E.GCODE, E.X, E.Y, MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)) AS CRITICIDAD "
		query = query & " FROM EQUIPOS AS E "
		query = query & " WHERE E.CODIGO <> 'CV00A7-POL' AND E.LAYOUT like '%"&EQUIPO&"%' " 
		query = query & " AND CODIGO LIKE 'CV00A7-M%' GROUP BY  Z, E.GCODE, E.X, E.Y " 
		query = query & " ORDER BY E.Z "
	else
		TITULO = " Mesas "
		masDetalle = 1
		query = "SELECT E.CODIGO, E.DESCRIPCION, E.GCODE, E.X, E.Y, [dbo].[criticidadEquipo](E.CODIGO, E.UBICACION) AS CRITICIDAD "
		query = query & " FROM EQUIPOS AS E "
		query = query & " WHERE E.CODIGO <> 'CV00A6-POL' AND E.LAYOUT like '%"&EQUIPO&"%'" 
		if InStr(1, strNvl(EQUIPO), "CV00A7") and valZ>0  then
			query = query & " AND E.CODIGO LIKE 'CV00A7-M%' "
		end if
		if valZ<>0 then
			query = query & " AND E.Z = "&valZ
		else
			query = query & " and E.X = "&valX 
		end if 
		query = query & " AND CODIGO NOT LIKE '%-PCAR-%' AND CODIGO NOT LIKE '%-PRET-%' " 
		query = query & " ORDER BY E.CODIGO "
	end if


	Set ORs =oDB.EjecutaSql(query)
'if InStr(1, strNvl(EQUIPO), "CV00A7") and valZ>0  then
'		response.write query
'		response.end
'end if
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	
				context = "<img style='position:absolute; z-index:1; left:10px; top:40px' src='/sgm/Chart/ly/SECCION.png' width='657' height='319' usemap='#seccion'>"
				N=1
'		response.write query
				While Not ORs.EOF
'				response.Write("</br>linea: "&N&"</br>")
					if masDetalle=1 then
						TITULO = ORs.Fields.Item(2).Value
						masDetalle = 0
					elseif masDetalle=2 then
						TITULO = TITULO&ORs.Fields.Item(2).Value
						masDetalle = 0
					end if
					if not(isnull(ORs.Fields.Item(5).Value))  then
							if ORs.Fields.Item(5).Value < 34 then 
								color = "BAJA-"
							elseif ORs.Fields.Item(5).Value < 67 then
								color = "MEDIA-"
							else
								color = "ALTA-"
							end if
							context = context & "<img style='position:absolute; z-index:2; left:10px; top:40px' src='/sgm/Chart/ly/"& color &"SECCION"&N&".png' width='657' height='319' usemap='#seccion'>"
'							response.write "img style='position:absolute; z-index:2; left:10px; top:40px' src='/sgm/Chart/ly/"& color &"SECCION"&N&".png' width='657' height='319' usemap='#seccion'"
					end if
					N=N+1
					ORs.MoveNext
				Wend
'				response.End()
				ORs.MoveFirst
				context = context & " <map id='seccion' name='seccion'> "&chr(13)
				N=0
				While Not ORs.EOF
					x1=0 + N*53
					y1=50 + N*20
					x2=80 + N*53
					y2=20 + N*20
					x3=90 + N*53
					y3=30 + N*20
					x4=90 + N*53
					y4=60 + N*20
					x5=10 + N*53
					y5=90 + N*20
					if N>6 then
						x1=x1 + (N)*5
						x2=x2 + (N)*5
						x3=x3 + (N)*5
						x4=x4 + (N)*5
						x5=x5 + (N)*5
						y1=y1 + (N-3)*5
						y2=y2 + (N-3)*5
						y3=y3 + (N-3)*5
						y4=y4 + (N-3)*5
						y5=y5 + (N-3)*5
					end if
					N=N+1
				  context = context &  "<area shape='poly' coords='"&x1&","&y1&","&x2&","&y2&","&x3&","&y3&","&x4&","&y4&","&x5&","&y5&"' href="
				  if InStr(1, strNvl(EQUIPO), "CV00A7-PCAR") and valZ=0  then
				    'context = context & "javascript:loadrisk('"&EQUIPO&"',2,"&valX&", '"&ORs.Fields.Item(0).Value&"') "
				    context = context &chr(34)& "javascript:loadrisk('"&EQUIPO&"',2,'0000"&valX&"', '"&ORs.Fields.Item(0).Value&"')" &chr(34)
				  else
				    context = context & "'LayoutAndina.html?EQUIPO="&ORs.Fields.Item(0).Value&"' "
				  end if
				    context = context & " alt='"&ORs.Fields.Item(1).Value&"'> "&chr(13)
				  ORs.MoveNext 
				Wend
				context = context & " </map> "
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
	
function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function
%>



<script src="../standard/facebox.js" type="text/javascript"></script>
<link href="../standard/facebox.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    jQuery(document).ready(function($) {
      $('a[rel*=facebox]').facebox() 
    })
</script>	
<script type="text/javascript" src="/Scripts/deteccion.js"></script>	
<script type="text/javascript">
	var browser =  DetectBrowser();
	var id_br = browser.substring(0,2);	
</script>
<table width="705" border="0" align="center">
  <tr>
    <td width="614" align="center"><font class="titulo">Detalle de <%=TITULO%> </font></td>
    <td width="81" align="center"><a href="javascript:alwaysOnTop.hidediv('ajaxdiv')">CERRAR</a></td>
  </tr>
</table>
<div  ID="tabEquipos"  style=" visibility:visible"><%=context%></div>