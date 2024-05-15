<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include virtual="/sgm/standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
'
RECURSO=REQUEST("RECURSO")
FAENA=REQUEST("FAENA")
BITACORAS=UCASE(REQUEST("BITACORAS"))
FOLIO=REQUEST("FOLIO")
EXCEL=REQUEST("EXCEL")
FECHA=UCASE(REQUEST("FECHA"))
USUARIO=UCASE(REQUEST("USUARIO"))

'DESC_SECCION_DES=REQUEST("SECCION_DES")
'FECHA_INI=UCASE(REQUEST("FECHA_INI"))
'FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
'
'
'CODIGO=UCASE(REQUEST("CODIGO"))
'CONDICION=UCASE(REQUEST("CONDICION"))
'COLOR=UCASE(REQUEST("COLOR"))
'EQUIPO=UCASE(REQUEST("EQUIPO"))
'EQUIPOS=UCASE(REQUEST("EQUIPOS"))
'FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
'IND_SOLUCION=UCASE(REQUEST("IND_SOLUCION"))
'INICIO=UCASE(REQUEST("INICIO"))
'TERMINO=UCASE(REQUEST("TERMINO"))
'NUM=UCASE(REQUEST("NUM"))
'ESTADO=UCASE(REQUEST("ESTADO"))
'DESCRIPCION=REQUEST("DESCRIPCION")
'SECCION=REQUEST("SECCION")
'
'response.write("<html><body>")
'for each x in Request.ServerVariables
'  response.write(x & "<br>")
'next
'response.End()
'
select case RECURSO
	case "infDiario"
		infDiario()
	case "listInformesDia"
		  listInformesDia()
	case "getInfDiario"
		  getInfDiario()
	case "listBitDia"
		  listBitDia()
	case "updateInfDiario"
		updateInfDiario()		
	case "newInfDiario"
		newInfDiario()
		  
	case "updateCriticidad"
		updateCriticidad()
	case "getInfDiario"
		getInfDiario()
	case "ListTipos"
		ListTipos()
end select
'****************************************************************************************

function infDiario()

	query = " SELECT LTRIM(RTRIM(DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION))) AS [TAG_CORREA], FECHA_ULT_MAN AS [FECHA_ULT_CAMBIO], "
	query = query & " DATEDIFF(MONTH, FECHA_ULT_MAN, GETDATE()) AS [MESES_OPERACION], E.ESPESOR AS [ESPESOR_NOMINAL_CORREA_CARGA], "
	query = query & " Z.VALOR AS [ESPESOR_MINIMO], Z.FECHA AS [FECHA], B.ID AS [NUMERO_DE_BITACORA], B.REPORT AS [NUMERO_DE_AVISO], "
	query = query & " B.OT AS [NUMERO_DE_OT], CASE B.CONDICION  WHEN 'B' THEN 'VERDE' WHEN 'C' THEN 'AMARILLO' WHEN 'D' THEN 'AMARILLO' "
	query = query & " WHEN 'E' THEN 'ROJO' WHEN 'P' THEN 'ROJO' ELSE 'VERDE' END AS [Prioridad_SAP], B.DESCRIPCION AS [OBSERVACIONES], "
	query = query & " B.CAUSA AS [CAUSA_RAIZ], B.RECOMENDACION AS [RECOMENDACIONES], B.CRITICIDAD AS [CRITICIDAD_TTM], "
	query = query & " CASE WHEN B.CRITICIDAD <= 33.3 THEN 'baja.png' WHEN B.CRITICIDAD <= 66.7 THEN 'media.png' ELSE 'alta.png' END AS [COLOR_TTM], "
	query = query & " CAST(A.ID AS varchar(30)) +'.'+ CAST(EXT AS varchar(3)) AS [REGISTRO_FOTOGRAFICO] "
	query = query & " FROM BITACORAS B INNER JOIN EQUIPOS E ON B.EQUIPO = E.CODIGO AND B.UBICACION = E.UBICACION "
	query = query & " LEFT JOIN (SELECT M.EQUIPO, M.FAENA, M.FECHA_ULTM_MANTENCION, MAX(M.FECHA) AS FECHA, MIN(MV.VALOR) AS VALOR "
	query = query & " FROM MEDICIONES M INNER JOIN MEDICIONES_VALOR MV ON M.FOLIO = MV.FOLIO "
	query = query & " WHERE M.FAENA = " & strNvl(FAENA)
	query = query & " GROUP BY M.EQUIPO, M.FAENA, M.FECHA_ULTM_MANTENCION) AS Z ON B.EQUIPO = Z.EQUIPO AND B.UBICACION = Z.FAENA "
	query = query & " LEFT JOIN (SELECT A.ID,A.EXT,A.IDENTIFICADOR,A.FAMILIA FROM ARCHIVOS AS A INNER JOIN( SELECT IDENTIFICADOR ,MAX(ORDEN) "
	query = query & " AS ORDEN FROM ARCHIVOS WHERE FAMILIA = 'BITACORAS' AND IDENTIFICADOR IN (" & BITACORAS & ") "
	query = query & " GROUP BY IDENTIFICADOR) AS A2 ON A.IDENTIFICADOR = A2.IDENTIFICADOR AND A.ORDEN = A2.ORDEN) AS A "
	query = query & " ON A.FAMILIA = 'BITACORAS' AND B.ID = A.IDENTIFICADOR "
	query = query & " WHERE B.UBICACION = " & strNvl(FAENA)
	query = query & " AND B.ID IN (" & BITACORAS & ") "
	query = query & " ORDER BY DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION),B.ID, A.ID "

	Set ORs =oDB.EjecutaSql(query)
	if EXCEL="YES" then	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=diario.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no'?>" & VbCrLf
	else
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf
	end if

	Response.Write "<REGISTROS>"  & VbCrLf '& query 
	N=0
	While Not ORs.EOF 
		Response.Write "<ROW>"  & VbCrLf 
		N=N+1 
		Response.Write "<N>" & N & "</N>"  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(0).Name&">" &  ORs.Fields.Item(0).Value &  "</"&ORs.Fields.Item(0).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(1).Name&">" &  ORs.Fields.Item(1).Value &  "</"&ORs.Fields.Item(1).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(2).Name&">" &  ORs.Fields.Item(2).Value &  "</"&ORs.Fields.Item(2).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(3).Name&">" &  ORs.Fields.Item(3).Value &  "</"&ORs.Fields.Item(3).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(4).Name&">" &  ORs.Fields.Item(4).Value &  "</"&ORs.Fields.Item(4).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(5).Name&">" &  ORs.Fields.Item(5).Value &  "</"&ORs.Fields.Item(5).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(6).Name&">" &  ORs.Fields.Item(6).Value &  "</"&ORs.Fields.Item(6).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(7).Name&">" &  ORs.Fields.Item(7).Value &  "</"&ORs.Fields.Item(7).Name&"> "  & VbCrLf
		Response.Write "<"&ORs.Fields.Item(8).Name&">" &  ORs.Fields.Item(8).Value &  "</"&ORs.Fields.Item(8).Name&"> "  & VbCrLf
		
		Response.Write "<"&ORs.Fields.Item(9).Name&">/sgm/Informes/MEL/images/" &  ORs.Fields.Item(9).Value &  ".png</"&ORs.Fields.Item(9).Name&"> "  & VbCrLf
		
		Response.Write "<"&ORs.Fields.Item(10).Name&">" & ORs.Fields.Item(10).Value & "</"&ORs.Fields.Item(10).Name&"> " & VbCrLf
		Response.Write "<"&ORs.Fields.Item(11).Name&">" & ORs.Fields.Item(11).Value & "</"&ORs.Fields.Item(11).Name&"> " & VbCrLf
		Response.Write "<"&ORs.Fields.Item(12).Name&">" & ORs.Fields.Item(12).Value & "</"&ORs.Fields.Item(12).Name&"> " & VbCrLf
		Response.Write "<"&ORs.Fields.Item(13).Name&">" & ORs.Fields.Item(13).Value & "</"&ORs.Fields.Item(13).Name&"> " & VbCrLf
		Response.Write "<"&ORs.Fields.Item(14).Name&">/sgm/Informes/MEL/images/" &  ORs.Fields.Item(14).Value &  "</"&ORs.Fields.Item(14).Name&"> "  & VbCrLf
		Set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
		if IsNull(ORs.Fields.Item(15).Value) then
'			Response.Write "<"&ORs.Fields.Item(15).Name&">imagen.aspx?image=/sgm/images/noDisponible.png</"&ORs.Fields.Item(15).Name&">"  & VbCrLf
			url = "http://" & request.ServerVariables("HTTP_HOST") & "/sgm/Informes/MEL/imagen.aspx?image=/sgm/images/noDisponible.png" 
		else
'			Response.Write "<"&ORs.Fields.Item(15).Name&">imagen.aspx?image=/sgm/Files/" & ORs.Fields.Item(15).Value & "</"&ORs.Fields.Item(15).Name&">"  & VbCrLf
			url = "http://" & request.ServerVariables("HTTP_HOST") & "/sgm/Informes/MEL/imagen.aspx?image=/sgm/Files/" & ORs.Fields.Item(15).Value 
		end if
		req.open "GET", url, False
		req.send()
		Response.Write "<"&ORs.Fields.Item(15).Name&"> "& req.responseText & "</"&ORs.Fields.Item(15).Name&">"  & VbCrLf
		set req = nothing
		Response.Write "</ROW>"  & VbCrLf
		ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"  & VbCrLf
	Set ORs = Nothing
	Set oDB = Nothing
end function
'/****************************************************************************************/
function listInformesDia()

query = " SELECT FOLIO, FECHA, RESPONSABLE, IDS "
query = query & " FROM INFORMES AS I"
query = query & " WHERE INFORME='INFDIARIOMEL' AND FAENA=" & strNvl(FAENA) 
query = query & " ORDER BY FOLIO DESC " 

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" ' & query
	While Not ORs.EOF 
	   Response.Write "<ROWS>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
  		  Response.Write "<IDS>" & ORs.Fields.Item(3).Value & "</IDS>"

	   Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing

End Function
'/****************************************************************************************/
function getInfDiario()
	
	query = "SELECT FOLIO, IDS, FECHA, RESPONSABLE FROM INFORMES "
	query = query & " WHERE INFORME='INFDIARIOMEL' AND FOLIO = " & strNvl(FOLIO)
	query = query & " AND FAENA=" & strNvl(FAENA)
	 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query '
	
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<BITACORAS>" & ORs.Fields.Item(1).Value & "</BITACORAS>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing

End Function
'/****************************************************************************************/
function listBitDia()

query = " SELECT B.ID, RTRIM(CONVERT(CHAR,ISNULL(HB.FECHA,B.FECHA), 103)), B.EQUIPO, B.COLOR, SUBSTRING(B.DESCRIPCION,0,40)+ '...', B.UBICACION "
query = query & " FROM BITACORAS AS B LEFT JOIN HISTORIAL_BITACORA HB ON B.ID = HB.ID"
query = query & " WHERE RTRIM(CONVERT(CHAR,ISNULL(HB.FECHA,B.FECHA), 103)) = CONVERT(CHAR," & strNvl(FECHA) & ", 103) "
query = query & " AND B.UBICACION=" & strNvl(FAENA) 
query = query & " ORDER BY dbo.EquipoPrincipal(EQUIPO) " 

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	While Not ORs.EOF 
	   Response.Write "<ROWS>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<EQUIPO>" & ORs.Fields.Item(2).Value & "</EQUIPO>"
  		  Response.Write "<COLOR>" & ORs.Fields.Item(3).Value & "</COLOR>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(5).Value & "</UBICACION>"
	   Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing

End Function
'/****************************************************************************************/
function updateInfDiario()
	
	query = "UPDATE INFORMES SET "
	query = query & " IDS = " & strNvl(BITACORAS) & ","
	query = query & " FECHA = " & strNvl(FECHA) & ","
	query = query & " USERNAME = " & strNvl(USUARIO) & ", USERDATE = GETDATE()"  
	query = query & " WHERE INFORME='INFDIARIOMEL' AND FOLIO = " & strNvl(FOLIO)
	query = query & " AND FAENA=" & strNvl(FAENA)
	 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf 
	Response.Write "<REGISTROS> <ROWS> <FOLIO>OK</FOLIO> </ROWS> </REGISTROS>"
	
	Set ORs = Nothing
	Set oDB = Nothing

End Function
'/****************************************************************************************/
function newInfDiario()

	query = "SELECT MAX(FOLIO) AS NUM FROM INFORMES WHERE FAENA= " & strNvl(FAENA) 
	
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO INFORMES  (INFORME, FOLIO, FECHA, RESPONSABLE, IDS, FAENA, USERDATE, USERNAME) "
	query = query & " VALUES ('INFDIARIOMEL'," & strNvl(N) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(USUARIO) & ","
	query = query & strNvl(BITACORAS) & ","
	query = query & strNvl(FAENA) & ", GETDATE(), " & strNvl(USUARIO) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS> <ROW>" & N & "</ROW> </REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
End function

'/****************************************************************************************/
'function updateCriticidad()
'	
'	query = "UPDATE BITACORAS SET "
'	query = query & " CRITICIDAD2 = " & strNvl(CRITICIDAD) & " "
'	query = query & " ,REPORT = " & strNvl(REPORT) & " "
'	query = query & " WHERE ID = " & strNvl(ID)
'	 
'	Set ORs = oDB.EjecutaSql(query)
'	
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS> <ROWS> <FOLIO>OK</FOLIO> </ROWS> </REGISTROS>"
'	
'	Set ORs = Nothing
'	Set oDB = Nothing
'
'End Function
'/****************************************************************************************/
'function getInfDiario()
'	
'	query = "SELECT FOLIO, IDS, FECHA, RESPONSABLE FROM INFORMES "
'	query = query & " WHERE INFORME='INFDIARIO' AND FOLIO = " & strNvl(FOLIO)
'	query = query & " AND FAENA=" & strNvl(FAENA)
'	 
'	Set ORs = oDB.EjecutaSql(query)
'	
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS>" '& query '
'	
'	While Not ORs.EOF 
'	  Response.Write "<ROWS>" 
'		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
'		  Response.Write "<BITACORAS>" & ORs.Fields.Item(1).Value & "</BITACORAS>"
'   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
'		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
'	 Response.Write "</ROWS>"
'	  ORs.MoveNext
'	Wend
'	Response.Write "</REGISTROS>"
'	Set ORs = Nothing
'	Set ODB = Nothing
'End Function
'/****************************************************************************************/
'function ListTipos()
'	query = "SELECT CODIGO, DESCRIPCION, CRITICIDAD "
'	query = query & "FROM TIPO_EQUIPOS WHERE ACTIVO='ACT' ORDER BY DESCRIPCION"
'	Set ORs =oDB.EjecutaSql(query)
'	Response.ContentType = "text/xml"
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS>"
'	While Not ORs.EOF 
'		Response.Write "<ROW>" 
'		Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
'		Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
'		Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>"
'		Response.Write "</ROW>"
'		ORs.MoveNext
'	Wend
'	Response.Write "</REGISTROS>"
'	Set ORs = Nothing
'	Set ODB = Nothing
'end function
'/****************************************************************************************/
'
'function listEquipos()
'
'	 query = "SELECT CODIGO, DESCRIPCION, E.FECHA_INSTALACION, E.FECHA_ULT_MAN,  "
'	 query = query & " isNull((SUM(P.MINUTOS)/60)/24,0),isNull((SUM(P.MINUTOS)/60)/24,0),"
'	 query = query & " DATEDIFF(dd,'" & FECHA_INI & "','" & FECHA_FIN & "')+1 "
'	 query = query & " FROM EQUIPOS AS E"
'	 query = query & " LEFT OUTER JOIN PARADAS AS P ON E.CODIGO=P.COMPONENTE "
'	 query = query & " AND FECHA_INI BETWEEN '" & FECHA_INI & "' AND '" & FECHA_FIN & "'"
'	 query = query & " WHERE UBICACION=" & strNvl(FAENA) 
'	 ' query = query & " AND DBO.SecEquipoPrincipal(CODIGO) IN (" & strNvl(SECCION) & ")"'
'	 
'	 If LEN(TIPO)>0 Then
'	    query = query & " AND TIPO_EQUIPO=" & TIPO
'	 End If
'	 query = query & " GROUP BY CODIGO, DESCRIPCION, FECHA_INSTALACION, FECHA_ULT_MAN "
'	 query = query & " ORDER BY CODIGO "
'	 
'	Set ORs =oDB.EjecutaSql(query)
'	
'	If EXCEL="YES" Then
'		Response.ContentType = "application/vnd.ms-excel"
'		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
'	    Response.Write "<TABLE BORDER=1>"
'			 Response.Write "<TR>"
'				   Response.Write "<TD>Equipo</TD>"
'   				   Response.Write "<TD>Fecha Instalaci�n</TD>"
'   				   Response.Write "<TD>Fecha Ult. Mantenci�n</TD>"
'   				   Response.Write "<TD>Total Fallas</TD>"
'   				   Response.Write "<TD>Fallas OP.</TD>"	
'				   Response.Write "<TD>Tiempo Calendario</TD>"	
'				   Response.Write "<TD>Disponibiliad</TD>"
'				   Response.Write "<TD>Utilizaci�n</TD>"
'				   
'			 Response.Write "</TR>"
'		While Not ORs.EOF 
'				 Response.Write "<TR>"
'				 Response.Write "<TD>" & ORs.Fields.Item(0).Value & " " & ORs.Fields.Item(1).Value & "</TD>"
'   		 		 Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
'   		 		 Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
'				 Response.Write "<TD>" & ROUND(ORs.Fields.Item(4).Value,2) & "</TD>"
'		 		 Response.Write "<TD>" & ROUND(ORs.Fields.Item(5).Value,2) & "</TD>"
'		 		 Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
'		 		 DISP = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100
' 		 		 Response.Write "<TD>" & ROUND(DISP,2)& "</TD>"
'		 		 UTIL = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100 
'	  	 		 Response.Write "<TD>" & ROUND(UTIL,2) & "</TD>"
'   				 Response.Write "</TR>"
'	 		  ORs.MoveNext
'		Wend
'	    Response.Write "</TABLE>"
'	Else
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS>"
'	While Not ORs.EOF 
'	   Response.Write "<ROWS>" 
'		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & " " & ORs.Fields.Item(1).Value & "</CODIGO>"
'   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
'   		  Response.Write "<ULT_MAN>" & ORs.Fields.Item(3).Value & "</ULT_MAN>"
'  		  Response.Write "<TIEMPO_MAN>" & ROUND(ORs.Fields.Item(4).Value,2) & "</TIEMPO_MAN>"
'		  Response.Write "<TIEMPO_OP>" & ROUND(ORs.Fields.Item(5).Value,2) & "</TIEMPO_OP>"
'		  Response.Write "<TIEMPO_TT>" & ORs.Fields.Item(6).Value & "</TIEMPO_TT>"
'		  DISP = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100
' 		  Response.Write "<DISPONIBILIDAD>" & ROUND(DISP,2)& "</DISPONIBILIDAD>"
'		  UTIL = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100 
'	  	  Response.Write "<UTILIZACION>" & ROUND(UTIL,2) & "</UTILIZACION>"
'	   Response.Write "</ROWS>"
'	  ORs.MoveNext
'	Wend
'	Response.Write "</REGISTROS>"
'  End If
'	Set ORs = Nothing
'	Set ODB = Nothing
'end function
'
'function ListEquiposManCro()
'
'	 query = "SELECT CODIGO, DESCRIPCION, FECHA_ULT_MAN, HOROMETRO, "
'	 query = query & " HOROMETRO_VEN, DIFERENCIA, FOLIO_OT, PRIORIDAD "
'  	 query = query & " FROM VI_EQUIPOS_MAN_CRO AS V LEFT OUTER JOIN "
'   	 query = query & " (SELECT FOLIO_OT, EQUIPO, ESTADO FROM OT WHERE ESTADO IN ('PRO','PEN') AND TIPO='PRE') AS OT "
'   	 query = query & " ON V.CODIGO = OT.EQUIPO"
'	 query = query & " WHERE dbo.EquipoPrincipal(CODIGO)=" & strNvl(CODIGO) & " "
'	 query = query & " ORDER BY DIFERENCIA DESC "
'
'	Set ORs =oDB.EjecutaSql(query)
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS>"
'	While Not ORs.EOF 
'	  Response.Write "<ROWS>" 
'		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
'		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
'   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
'   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
'   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
'   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
'		  If ORs.Fields.Item(6).Value<>"NULL" Then
'   		  		IMAGEN = "images\generado.gif"
'		  Else
'		  		IMAGEN = "images\generar.gif"
'		  End If
'		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
'  		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(7).Value & "</PRIORIDAD>"
'	 Response.Write "</ROWS>"
'	  ORs.MoveNext
'	Wend
'	Response.Write "</REGISTROS>"
'	Set ORs = Nothing
'	Set ODB = Nothing
'end function
'
'
'function fechasCriticidad()
'
'query = " select convert(varchar, fecha, 103) "
'query = query & " from historial_criticidad group by fecha order by fecha desc"
'
'Set ORs =oDB.EjecutaSql(query)
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS>"
'	While Not ORs.EOF 
'	  Response.Write "<ROWS>" 
'		  Response.Write "<FECHA>" & ORs.Fields.Item(0).Value & "</FECHA>"
'	 Response.Write "</ROWS>"
'	  ORs.MoveNext
'	Wend
'	Response.Write "</REGISTROS>"
'	Set ORs = Nothing
'	Set ODB = Nothing
'end function
'
'function empalmes()
'
'	query = " SELECT T.EQUIPO, T.COMPONENTE, B.FECHA, B.DESCRIPCION FROM ( "
' 	query = query & " SELECT   DBO.EQUIPOPRINCIPAL(E1.CODIGO) AS EQUIPO,  E1.CODIGO AS COMPONENTE, E.SECUENCIA"
'	query = query & "  FROM  EQUIPOS AS E1, EQUIPOS AS E "
'	query = query & "  WHERE E1.TIPO_EQUIPO=23  AND DBO.EQUIPOPRINCIPAL(E1.CODIGO)=E.CODIGO"
' 	query = query & " AND E1.UBICACION='SPENCE' AND LEN(E1.CODIGO)>9) AS T"
' 	query = query & " LEFT OUTER JOIN BITACORAS AS B ON T.COMPONENTE = B.EQUIPO"
'	query = query & " AND B.IND_SOLUCION='false'"
' 	query = query & "  ORDER BY T.SECUENCIA"
'
'	Set ORs =oDB.EjecutaSql(query)
'	
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
'	Response.Write "<REGISTROS>"
'	While Not ORs.EOF 
'	  Response.Write "<ROWS>" 
'		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
'	 Response.Write "</ROWS>"
'	  ORs.MoveNext
'	Wend
'	Response.Write "</REGISTROS>"
'	Set ORs = Nothing
'	Set ODB = Nothing
'end function
'
'function getHistorial(ID)
'
'    query = "SELECT RTRIM(INSPECTOR), RTRIM(CONVERT(CHAR,FECHA,103)), STATUS FROM HISTORIAL_BITACORA "
'	query = query & " WHERE ID = " & ID  
'	query = query & " ORDER BY FECHA DESC "
'	
'	Set getHistorial =oDB.EjecutaSql(query)
'
'End Function
'
'function getChecklist(Id, TipoEquipo)
'
'	query = "SELECT CHK.ID, CHK.DESCRIPCION, CHK_E.BITACORA , CHK_E.VALOR "
'	query = query & " FROM CHECKLIST AS CHK "
'	query = query & " LEFT OUTER JOIN CHECK_EQUIPOS AS CHK_E ON CHK_E.BITACORA=" & strNvl(Id)
'	query = query & " 		AND CHK.ID = CHK_E.CHECKLIST "
'	query = query & " WHERE TIPO_EQUIPO=" & TipoEquipo
'	query = query & " AND CHK_E.VALOR<>0 "
'	query = query & " ORDER BY ID"
'	 
'	Set getChecklist =oDB.EjecutaSql(query)
'
'End Function
'
function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

Function Base64Encode(inData)
  'rfc1521
  '2001 Antonin Foller, Motobit Software, http://Motobit.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim cOut, sOut, I
  
  'For each group of 3 bytes
  For I = 1 To Len(inData) Step 3
    Dim nGroup, pOut, sGroup
    
    'Create one long from this 3 bytes.
    nGroup = &H10000 * Asc(Mid(inData, I, 1)) + _
      &H100 * MyASC(Mid(inData, I + 1, 1)) + MyASC(Mid(inData, I + 2, 1))
    
    'Oct splits the long To 8 groups with 3 bits
    nGroup = Oct(nGroup)
    
    'Add leading zeros
    nGroup = String(8 - Len(nGroup), "0") & nGroup
    
    'Convert To base64
    pOut = Mid(Base64, CLng("&o" & Mid(nGroup, 1, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 3, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 5, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 7, 2)) + 1, 1)
    
    'Add the part To OutPut string
    sOut = sOut + pOut
    
    'Add a new line For Each 76 chars In dest (76*3/4 = 57)
    'If (I + 2) Mod 57 = 0 Then sOut = sOut + vbCrLf
  Next
  Select Case Len(inData) Mod 3
    Case 1: '8 bit final
      sOut = Left(sOut, Len(sOut) - 2) + "=="
    Case 2: '16 bit final
      sOut = Left(sOut, Len(sOut) - 1) + "="
  End Select
  Base64Encode = sOut
End Function

Function MyASC(OneChar)
  If OneChar = "" Then MyASC = 0 Else MyASC = Asc(OneChar)
End Function

Function BinaryToString(Binary)
  Dim I, S
  For I = 1 To LenB(Binary)
    S = S & Chr(AscB(MidB(Binary, I, 1)))
  Next
  BinaryToString = S
End Function

Function Base64EncodeBinary(inData)
  Base64EncodeBinary = Base64Encode(BinaryToString(inData))
End Function

function cargaImagen(imgNom)
	dim fs
	Set fs = Server.CreateObject("ADODB.Stream")
	fs.Type = 1
	fs.Open imgNom
	'fs.LoadFromFile Server.MapPath(imgNom)
	r = Base64EncodeBinary(fs.Read)
	set fs=nothing
	cargaImagen = r
end function

%>

