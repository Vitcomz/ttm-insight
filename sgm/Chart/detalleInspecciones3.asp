<%@LANGUAGE="VBSCRIPT"%>
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
		FECHA_FIN="01/12/2015"
		CRITICIDAD="TOD"
		RESPONSABLE="TOD"
		TURNO="TOD"
		
'		if (DT = "1") THEN
'			EQUIPO=UCASE(REQUEST("SUB_EQUIPO"))
'		else
'			EQUIPO="TOD"
'		END IF
'		EQUIPO_PRIN = UCASE(REQUEST("EQUIPO"))
'		
'		FAENA=UCASE(REQUEST("FAENA"))
'		if FAENA = "" then
'			dim x,y
'			for each x in Request.Cookies
'			  if x = "emp" then
'				FAENA = Request.Cookies(x)
'			  elseif  x = "log" then
'				USUARIO = Request.Cookies(x)
'			  end if
'			next
'		end if
'		IND_DANO="TOD"
'		IMG="1"
'		IND_SOLUCION="false"
'
'
'
'	query = "SELECT B.ID,"
'	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
'	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA, "
'	query = query & " TURNO, B.RESPONSABLE,"
'	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
'	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
'	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipal(B.EQUIPO),"
'	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
'	query = query & " FROM BITACORAS AS B "
'	query = query & " INNER JOIN EQUIPOS_USUARIOS AS EU ON "
'	query = query & " DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION) = EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
'	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
'	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103),103) BETWEEN " & strNvl(FECHA_INI)
'	query = query & " AND " & strNvl(FECHA_FIN) & ")"
'	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
'	
'	If RESPONSABLE<>"TOD" AND LEN(RESPONSABLE)>0 Then
'		query = query & " AND B.RESPONSABLE =" & strNvl(RESPONSABLE)
'	End if
'	
'	'If TURNO<>"TOD" Then'
'	'	query = query & " AND TURNO=" & strNvl(TURNO)'
''	End if'
'	
'	If EQUIPO<>"TOD"  Then
'		If strNvl(EQUIPO)="NULL" Then
'				query = query & " AND B.EQUIPO IS NULL"
'		Else
'			if IMG = "1" Then		
'				query = query & " AND SUBSTRING(E.LAYOUT, 0, LEN(E.LAYOUT)-3)=" & EQUIPO & ""
'			else
'				query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
'			End if
'		End If	
'	End if
'	
'	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
'		query = query & " AND DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION)=" & EQUIPO_PRIN & ""
'		
'	ELSE
'			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
'				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
'			End if
'	End if
'	
'	If CRITICIDAD<>"TOD"  Then
'		query = query & " AND B.COLOR=" & strNvl(CRITICIDAD)
'	End if
'	
'	If IND_DANO<>"TOD" Then
'		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
'	End if
'
'	If IND_SOLUCION<>"TOD" Then
'		query = query & " AND IND_SOLUCION=" & strNvl(IND_SOLUCION)
'	End if
'	
'	
'	query = query & " GROUP BY B.ID,B.FECHA, TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
'	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
'	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, X, Y, EJECUTOR"
'	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO), B.FECHA DESC  "
'	Set ORs =oDB.EjecutaSql(query)
''	response.write query
''	response.end
''------------------------------------------------------------------------------------------------------------------------------------------------	
'	Dim strName
'
''	strName = Date()
''	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
'	'strName = strName & ".xls"
'	
'				context =  "<table width='714' BORDER='0' CELLPADDING='5' CELLSPACING='0' bordercolor='#666666'  CLASS='texto' ID='tabEquipo' align='center'>"
'				N=0
'				While Not ORs.EOF 
'					N=N+1
'				  context = context &  "<tr>"



'				  context = context &  "<td WIDTH='75' height='82' VALIGN='TOP' class='tinyTextSub'>EQUIPO COMPONENTE FECHA<br />DIAS PEND. CRITICIDAD</td><td WIDTH='111' VALIGN='TOP' class='tinyTextSub'>:<span class='normal'>" & ORs.Fields.Item(14).Value 
'				  context = context &  "</span><br>:<span class='normal'>" & ORs.Fields.Item(8).Value
'				  context = context &  "</span><br>:<span class='normal'>" & ORs.Fields.Item(1).Value
'				  context = context &  "</span><br>:<span class='normal'>" & ORs.Fields.Item(13).Value
'				  context = context &  "</span><br>:<span class='normal'>" & ORs.Fields.Item(10).Value
'				  if ORs.Fields.Item(16).Value <> NULL then
'				  	context = context &  "</span>&nbsp<span class='normal'>" & ORs.Fields.Item(16).Value 
'				  else 
'				  	context = context &  "</span>&nbsp<span class='normal'>"
'				  end if
'				  context = context &  "</span>%</td>"
'				
'				  context = context &  "<td WIDTH='374' VALIGN='TOP' class='tinyTextSub'><span class='normal'>" & ORs.Fields.Item(4).Value 
'				  context = context &  "</span><br />RECOMENDACION :<span class='normal'>" & ORs.Fields.Item(15).Value 
'				  context = context &  "</span> <br/>  <br /> </td>"
'				  Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
'				  If Not oRsFiles.EOF Then
'					  context = context &  "<td WIDTH='106'><p><a href='../FILES/" & ORsFiles.Fields.Item(0).Value & "'  rel='facebox'  id='screenfile"&N&"_href'>"
'					  context = context & "<img id='screenfile"&N&"_img' src='../FILES/"& ORsFiles.Fields.Item(0).Value 
'					  context = context &  "' WIDTH='100' border='1' onerror='loadImage(this)' /><br /><br />"
'					  context = context &  "</a></p></td>"
'				  elseif oRsFiles.EOF Then
'					  context = context &  "<td WIDTH='106'><p><a href='../images/noDisponible.png'  rel='facebox'  id='screenfile"&N&"_href'>"
'					  context = context & "<img id='screenfile"&N&"_img' src='../images/noDisponible.png' "
'					  context = context &  "WIDTH='100' border='1'/><br /><br />"
'					  context = context &  "</a></p></td>"
'				  end if
'				  'context = context &  "' WIDTH='100' border='1'  ONERROR='this.src='images/noDisponible.png''/><br /><br />"
'				  'context = context &  "</a></p></td>"
'				  
'				  context = context &  "</tr>"
'				  ORs.MoveNext 
'				Wend
'				context = context &  "</table>"
'
''response.write 	context
''response.end
''	Response.Write "<table width='714' BORDER='0' CELLPADDING='5' CELLSPACING='0' bordercolor='#666666'  CLASS='texto' ID='tabEquipo' align='center'>"
''	N=0
''	While Not ORs.EOF 
''		N=N+1
''	  Response.Write "<ROW>" 
''	  	Response.Write "<N>" & N & "</N>"
''		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
''		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
''  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
''   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
''   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
''  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
''		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
''		  IF ORs.Fields.Item(7).Value ="SER" THEN
''	  		  Response.Write "<TIPO_TURNO>SERVICIO</TIPO_TURNO>"
''			ELSE
''			  Response.Write "<TIPO_TURNO>MANTENCION</TIPO_TURNO>"
''		  END IF
''  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
''		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
''		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
''		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
''		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
''		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
''		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
''		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(15).Value & "</RECOMENDACION>"
''		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
''		  
''		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
''		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
''		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
''		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(20).Value & "</EJECUTOR>" 
''		  
''		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
''		  If Not oRsFiles.EOF Then
''		  		If EXCEL = "YES" Then
''					Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
''				Else
''		  			Response.Write "<FILE>Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
''				End If
''		  Else
''		  		If EXCEL = "YES" Then
''					Response.Write "<FILE>../images/noDisponible.png</FILE>"
''				Else
''		  			Response.Write "<FILE>images/noDisponible.png</FILE>"
''				End If
''				
''		  End If 
''	  Response.Write "</ROW>"
''	  ORs.MoveNext 
''	Wend
''  Response.Write  "</table>"
'	Set ORs = Nothing
'	Set ORsFiles = Nothing
'	Set ODB = Nothing
'	
'function strNvl(Valor)
'	if Len(Valor) <1 then
'		strNvl = "NULL"
'	else
'		strNvl = "'" & Valor & "'"	
'	end if
'end function
'Function getFiles(Bitacora)
'
'    query = "SELECT (RTRIM(CAST(A.ID AS CHAR)) + '.' + CAST(A.EXT AS CHAR)) AS FILENAME FROM ARCHIVOS AS A "
'	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
'	query = query & " AND A.FAMILIA='BITACORAS' and A.EXT<>'pdf'"
'	
'	Set getFiles =oDB.EjecutaSql(query)
'
'End Function
%>
<div  ID="tabEquipos"  style=" visibility:visible"><img src="p_semaforo_BAJA.jpg" width="120" height="95" /></div>

