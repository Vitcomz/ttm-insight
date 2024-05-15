<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
CAUSA=UCASE(REQUEST("CAUSA"))
COLOR=UCASE(REQUEST("COLOR"))
MES=UCASE(REQUEST("MES"))
ANHO=UCASE(REQUEST("ANHO"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
FAENA=UCASE(REQUEST("FAENA"))
SECCION=UCASE(REQUEST("SECCION"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
MUESTREO=UCASE(REQUEST("MUESTREO"))
PROYEC=UCASE(REQUEST("PROYEC"))
RETORNO=UCASE(REQUEST("RETORNO"))
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))

Select Case RECURSO
	case "Criticidad_BAR"
		  Criticidad_BAR()
	
	case "Criticidad_PIE"
		  Criticidad_PIE()
	
	case "Criticidad_LINE"
		  Criticidad_LINE()
		  
	case "listIndicadores"
		  listIndicadores()
	
	case "listAnalisis"
		  listAnalisis()
		  
	case "graphMTBF"
		  graphMTBF()
		  
	case "graphMTTR"
		  graphMTTR()
		  
	case "graphDispUtil"
		  graphDispUtil()
		  
	case "graphAnalisis"
		  graphAnalisis()
		  
	case "graphDispersion"
		  graphDispersion()	 
		  
	case "graphJack"
		  graphJack()	 	  	  
	
	case "grEspesor"
		  grEspesor()
		  
	case "grProyec"
		  grProyec()
		  		  
end select

function Criticidad_BAR()

	query = "SELECT LTRIM(CONVERT(CHAR, FECHA, 103)) " 
	query = query & " FROM BITACORAS"
	query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	query = query & " AND FECHA BETWEEN " & strNvl(INICIO) & " AND " &  strNvl(TERMINO) 
	query = query & " GROUP BY  FECHA "
	query = query & " ORDER BY  FECHA DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Criticidad' shownames='1' showvalues='0' showSum='1' decimals='0' overlapBars='1' showShadow='1' showLabels='1' yAxisMaxValue='25'>"
	Response.Write "<categories>"
	While Not Rs.EOF 
		Response.Write "<category label='" & trim(Rs.Fields.Item(0).Value) & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</categories>"
	
	query = "SELECT LTRIM(CONVERT(CHAR, B.FECHA, 103)), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, FECHA"
	query = query & " 		FROM BITACORAS WHERE COLOR='ALTA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 		GROUP BY FECHA, COLOR) AS B1 ON B1.FECHA = B.FECHA " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY  B.FECHA, B1.COLOR "
	query = query & " ORDER BY  B.FECHA DESC"
	 
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='ALTA'  showValues='0' color='FF0000'>" 
	While Not Rs.EOF 
	     If Not Rs.Fields.Item(1).Value Then
		 	Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Else
		 	Response.Write "<set value='0' />"
		 End If
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"

	query = "SELECT LTRIM(CONVERT(CHAR, B.FECHA, 103)), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, FECHA"
	query = query & " 		FROM BITACORAS WHERE COLOR='MEDIA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 		GROUP BY FECHA, COLOR) AS B1 ON B1.FECHA = B.FECHA " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY  B.FECHA, B1.COLOR "
	query = query & " ORDER BY  B.FECHA DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='MEDIA'  showValues='0' color='FFFF00'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	query = "SELECT LTRIM(CONVERT(CHAR, B.FECHA, 103)), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, FECHA"
	query = query & " 		FROM BITACORAS WHERE COLOR='BAJA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 		GROUP BY FECHA, COLOR) AS B1 ON B1.FECHA = B.FECHA " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY  B.FECHA, B1.COLOR "
	query = query & " ORDER BY  B.FECHA DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='BAJA'  showValues='0' color='00FF33'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function Criticidad_PIE()

	query = "SELECT COLOR, COUNT(*) " 
	query = query & " FROM BITACORAS"
	query = query & " WHERE COLOR IS NOT NULL AND UBICACION=" & strNvl(FAENA)
	query = query & " AND FECHA BETWEEN " & strNvl(INICIO) & " AND " &  strNvl(TERMINO) 
	query = query & " GROUP BY  COLOR "
	query = query & " ORDER BY  COLOR "
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' showPercentageValues='1' caption='Criticidad' shownames='1' showvalues='1' showSum='1' decimals='0' overlapBars='1' showShadow='1'>"
	While Not Rs.EOF
		 If Rs.Fields.Item(0).Value = "ALTA" Then
		 	Response.Write "<set color='FF0000' label='" & Rs.Fields.Item(0).Value 
			Response.Write "' value='" & Rs.Fields.Item(1).Value & "' />"
		 End If
		 If Rs.Fields.Item(0).Value = "MEDIA" Then
		 	Response.Write "<set color='FFFF00' label='" & Rs.Fields.Item(0).Value 
			Response.Write "' value='" & Rs.Fields.Item(1).Value & "' />"
		 End If
		 If Rs.Fields.Item(0).Value = "BAJA" Then
		 	Response.Write "<set color='00FF33' label='" & Rs.Fields.Item(0).Value 
			Response.Write "' value='" & Rs.Fields.Item(1).Value & "' />"
		 End If
		 Rs.MoveNext
	Wend

	Response.Write "</chart>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function Criticidad_LINE()

	query = "SELECT LTRIM(CONVERT(CHAR, FECHA, 103)) " 
	query = query & " FROM BITACORAS"
	query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	query = query & " AND FECHA BETWEEN " & strNvl(INICIO) & " AND " &  strNvl(TERMINO) 
	query = query & " GROUP BY  FECHA "
	query = query & " ORDER BY  FECHA DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Criticidad' shownames='1' showvalues='0' showSum='1' decimals='0' overlapBars='1' showShadow='1' showLabels='0' yAxisMaxValue='25'>"
	Response.Write "<categories>"
	While Not Rs.EOF 
		Response.Write "<category label='" & trim(Rs.Fields.Item(0).Value) & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</categories>"
	
	query = "SELECT LTRIM(CONVERT(CHAR, B.FECHA, 103)), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, FECHA"
	query = query & " 		FROM BITACORAS WHERE COLOR='ALTA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 		GROUP BY FECHA, COLOR) AS B1 ON B1.FECHA = B.FECHA " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY  B.FECHA, B1.COLOR "
	query = query & " ORDER BY  B.FECHA DESC"
	 
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='ALTA'  showValues='0' color='FF0000'>" 
	While Not Rs.EOF 
	     If Not Rs.Fields.Item(1).Value Then
		 	Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Else
		 	Response.Write "<set value='0' />"
		 End If
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"

	query = "SELECT LTRIM(CONVERT(CHAR, B.FECHA, 103)), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, FECHA"
	query = query & " 		FROM BITACORAS WHERE COLOR='MEDIA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 		GROUP BY FECHA, COLOR) AS B1 ON B1.FECHA = B.FECHA " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY  B.FECHA, B1.COLOR "
	query = query & " ORDER BY  B.FECHA DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='MEDIA'  showValues='0' color='FFFF00'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	query = "SELECT LTRIM(CONVERT(CHAR, B.FECHA, 103)), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, FECHA"
	query = query & " 		FROM BITACORAS WHERE COLOR='BAJA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 		GROUP BY FECHA, COLOR) AS B1 ON B1.FECHA = B.FECHA " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY  B.FECHA, B1.COLOR "
	query = query & " ORDER BY  B.FECHA DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='BAJA'  showValues='0' color='00FF33'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function InfSemInspec()

	query = "SELECT ID,"
	query = query & "rtrim(convert(char,fecha,103)) + ' ' + "
	query = query & " substring(convert(char,fecha,108),1,5) as FECHA"
	query = query & ", TURNO, RESPONSABLE,"
	query = query & " DESCRIPCION, ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " FROM BITACORAS AS B, EQUIPOS_USUARIOS AS EU "
	'query = query & " WHERE MONTH(FECHA)=" & MES
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " AND  DBO.EquipoPrincipal(B.EQUIPO) = EU.EQUIPO"
	query = query & " AND  EU.USUARIO=" & strNvl(USUARIO)
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If TURNO<>"TOD" Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else		
			query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPAL(B.EQUIPO)=" & strNvl(EQUIPO_PRIN)
	End if
	
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_INCIDENTE<>"TOD" Then
		query = query & " AND IND_INCIDENTE=" & strNvl(IND_INCIDENTE)
	End if
	
	
	query = query & " GROUP BY ID,"
	query = query & " FECHA,"
	query = query & " TURNO, RESPONSABLE,"
	query = query & " DESCRIPCION, ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " ORDER BY convert(char,fecha,101)"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/Inspecciones.xsl'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value,1)
		  sFALLA=""
		  While Not oRsChk.EOF
		  		Response.Write "<FALLAS>" 
		  		Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
				Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR
				oRsChk.MoveNext
				Response.Write "</FALLAS>" 
		  Wend
		  Response.Write "</ROW>"
	  
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InfDiaInspec()

	query = "SELECT B.ID,"
	query = query & " RTRIM(CONVERT(char,B.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,B.fecha,108),1,5) as FECHA,"
	query = query & " B.TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " FROM BITACORAS AS B"
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) = " & strNvl(FECHA_INI) & ")"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	

	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else		
			query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPAL(B.EQUIPO)=" & strNvl(EQUIPO_PRIN)
	End if
	

	query = query & " ORDER BY convert(char,B.fecha,101)"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  		  
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value,1)
		  While Not oRsChk.EOF
		  		Response.Write "<FALLAS>" 
		  		Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
				Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR
				oRsChk.MoveNext
				Response.Write "</FALLAS>" 
		  Wend
		 
		  Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  While Not oRsFiles.EOF
		  		Response.Write "<FILES>" 
		  		Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				oRsFiles.MoveNext
				Response.Write "</FILES>" 
		  Wend
		 
		  Response.Write "</ROW>"
	 
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listIndicadores()

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION = " & strNvl(SECCION)
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FECHA>" & ORs.Fields.Item(0).Value & "/" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<TC>" & ORs.Fields.Item(2).Value & "</TC>"
		  Response.Write "<TT>" & ORs.Fields.Item(3).Value & "</TT>"
		  Response.Write "<ST>" & ORs.Fields.Item(4).Value & "</ST>"
		  Response.Write "<FM>" & ORs.Fields.Item(5).Value & "</FM>"
		  Response.Write "<MP>" & ORs.Fields.Item(6).Value & "</MP>"
		  Response.Write "<FO>" & ORs.Fields.Item(7).Value & "</FO>"
		  Response.Write "<OP>" & ORs.Fields.Item(8).Value & "</OP>"
		  Response.Write "<NF>" & ORs.Fields.Item(9).Value & "</NF>"
		  Response.Write "<TP>" & ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value & "</TP>"
		  
		  Response.Write "<DISP>" & ROUND(((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value) / isCero(ORs.Fields.Item(2).Value))*100,2) & "</DISP>"
		  
		  Response.Write "<UTIL>" & ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value)/ isCero(ORs.Fields.Item(2).Value)*100,2) & "</UTIL>"
		  Response.Write "<MTBF>" & ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value)/ isCero(ORs.Fields.Item(9).Value),2) & "</MTBF>"
		  Response.Write "<MTTR>" & ROUND(ORs.Fields.Item(3).Value / isCero(ORs.Fields.Item(9).Value),2) & "</MTTR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function graphMTBF()

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION = " & strNvl(SECCION)
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='MTBF' shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst
	
	Response.Write "<dataset seriesName='MTBF'  showValues='1' color='FF0000'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value)/ isCero(ORs.Fields.Item(9).Value),2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing

end function

function graphMTTR()

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION = " & strNvl(SECCION)
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='MTTR' shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst

	Response.Write "<dataset seriesName='MTTR'  showValues='1' color='94B0BE'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(3).Value / isCero(ORs.Fields.Item(9).Value),2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grEspesor()

    Dim aMuestreo
	Dim aProyec
	Dim aRetorno
	
	aMuestreo = Split(MUESTREO, ";")
	aProyec = Split(PROYEC, ";")
	aRetorno = Split(RETORNO, ";")
	
	'response.Write(ubound(aMuestreo))
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Espesores' shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='0' color='009933' displayvalue='Carcasa' /> "
	Response.Write "</trendLines>"
	 
	i=1
	Response.Write "<categories>"
	While i<=ubound(aMuestreo) 
		 	Response.Write "<category label='" & i & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</categories>"

	i=1
	Response.Write "<dataset seriesName='MUESTREO'  showValues='0' color='94B0BE'>" 
	While i<=ubound(aMuestreo) 
		 	Response.Write "<set label='" & i & "' value='" & aMuestreo(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	i=1
	Response.Write "<dataset seriesName='PROYECCION'  showValues='0' color='FF0000'>" 
	While i<=ubound(aProyec) 
		 	Response.Write "<set label='" & i & "' value='" & aProyec(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	i=1
	Response.Write "<dataset seriesName='RETORNO'  showValues='0' color='000000'>" 
	While i<=ubound(aRetorno) 
		 	Response.Write "<set label='" & i & "' value='" & aRetorno(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</dataset>"
	  
   
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grProyec()

    Dim aMuestreo
	Dim aProyec
	
	aMuestreo = Split(MUESTREO, ";")
	aProyec = Split(PROYEC, ";")
	
	'response.Write(ubound(aMuestreo))
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Proyecciones' shownames='1' yAxisMinValue='200909' showvalues='1' formatNumberScale='0' showShadow='1' formatNumber='0' showYAxisValues='1' showDivLineValues='1' divLineThickness='3'>"
	i=1
	Response.Write "<categories>"
	While i<=ubound(aMuestreo) 
		 	Response.Write "<category label='" & aMuestreo(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</categories>"

	
	i=1
	Response.Write "<dataset seriesName='PROYECCION' showValues='1' color='FF0000'>" 
	While i<=ubound(aProyec) 
		 	Response.Write "<set label='" & aMuestreo(i) & "' value='" & aProyec(i) & "' />"
			'Response.Write(aProyec(i)))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function graphDispUtil()

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION = " & strNvl(SECCION)
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Indicadores' shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst

	Response.Write "<dataset seriesName='Disponibilidad'  RenderAs='Line'  >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value) / isCero(ORs.Fields.Item(2).Value))*100,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Mantenci�n Programada'  showValues='0' color='FF0000'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(6).Value,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Fallas x Mantenci�n'  showValues='0' color='94B0BE'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(5).Value,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Fallas x Operaci�n'  showValues='0' color='00FF33'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(7).Value,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listAnalisis()

query =	" SELECT P.EQUIPO, MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION = " & strNvl(SECCION) 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY P.EQUIPO, MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY FM DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	While Not ORs.EOF
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value  & "</EQUIPO>"
		  Response.Write "<TC>" & ORs.Fields.Item(3).Value & "</TC>"
		  Response.Write "<TT>" & ORs.Fields.Item(4).Value & "</TT>"
		  Response.Write "<ST>" & ORs.Fields.Item(5).Value & "</ST>"
		  Response.Write "<FM>" & ORs.Fields.Item(6).Value & "</FM>"
		  Response.Write "<PORC>" & ROUND(ORs.Fields.Item(6).Value/isCero(TTotalFM)*100,2) & "%</PORC>"
		  ProcAcum = ProcAcum + (ORs.Fields.Item(6).Value/isCero(TTotalFM))
		  Response.Write "<PORC_ACUM>" & ROUND(ProcAcum*100,2) & "%</PORC_ACUM>"
		  Response.Write "<MP>" & ORs.Fields.Item(7).Value & "</MP>"
		  Response.Write "<FO>" & ORs.Fields.Item(8).Value & "</FO>"
		  Response.Write "<OP>" & ORs.Fields.Item(9).Value & "</OP>"
		  Response.Write "<NF>" & ORs.Fields.Item(10).Value & "</NF>"
		  Response.Write "<TP>" & ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value & "</TP>"
		  MTBF = ROUND((ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value)/ isCero(ORs.Fields.Item(10).Value),2)
		  T_MTBF = T_MTBF + MTBF
		  MTTR = ROUND(ORs.Fields.Item(4).Value / isCero(ORs.Fields.Item(10).Value),2)
		  T_MTTR = T_MTTR + MTTR
		  Response.Write "<MTBF>" & MTBF & "</MTBF>"
		  Response.Write "<MTTR>" & MTTR & "</MTTR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	 Response.Write "<ROW>"
	 		Response.Write "<EQUIPO>TOTALES </EQUIPO>"
	 		Response.Write "<FM>" & TTotalFM & "</FM>"
			Response.Write "<TT>" & TTotal & "</TT>"
			Response.Write "<NF>" & TTotalNF & "</NF>"
			Response.Write "<PORC>100%</PORC>"
			Response.Write "<MTBF>" & ROUND(T_MTBF/C,2) & "</MTBF>"
		  	Response.Write "<MTTR>" & ROUND(T_MTTR/C,2) & "</MTTR>"
			Response.Write "<PORC_ACUM>�</PORC_ACUM>"
	 Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function
		 
function graphAnalisis()

query =	" SELECT P.EQUIPO, MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION = " & strNvl(SECCION) 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY P.EQUIPO, MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY FM DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	While Not ORs.EOF
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Pareto Tiempo Fuera de Servicios' shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & CStr(ORs.Fields.Item(0).Value) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Fallas x Mantenci�n'  showValues='1' color='94B0BE'>" 
	While Not ORs.EOF 
		Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(6).Value/TTotalFM*100,2),",",".") & "' />"
		ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Acumulado'  showValues='1' color='FFF000' RenderAs='Line' >" 
	While Not ORs.EOF 
		ProcAcum = ProcAcum + (ORs.Fields.Item(6).Value/TTotalFM)
		Response.Write "<set value='" & REPLACE(ROUND(ProcAcum*100,2),",",".") & "' />"
		ORs.MoveNext
	Wend
	Response.Write "</dataset>"

	Response.Write "</chart>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function graphDispersion()

query =	" SELECT P.EQUIPO, MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION = " & strNvl(SECCION) 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY P.EQUIPO, MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY FM DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	While Not ORs.EOF
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Grafica de Dispersi�n' shownames='1'  numDivLines='10' yAxisName='MTTR'  rotateNames='1' bgColor='FFFFFF' showBorder='0' anchorRadius='5' anchorBorderThickness='2'>"
	Response.Write "<categories verticalLineThickness='1'>"
	While Not ORs.EOF 
		 MTBF = ROUND((ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value)/ isCero(ORs.Fields.Item(10).Value),2)
		Response.Write "<category x='" & REPLACE(MTBF,",",".") &  "' label='" & REPLACE(MTBF,",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	While Not ORs.EOF 
		  Response.Write "<dataset seriesName='" & ORs.Fields.Item(0).Value & "'  showValues='1' >"
	      MTBF = ROUND((ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value)/ isCero(ORs.Fields.Item(10).Value),2)
		  T_MTBF = T_MTBF + MTBF
		  MTTR = ROUND(ORs.Fields.Item(4).Value / isCero(ORs.Fields.Item(10).Value),2)
		  T_MTTR = T_MTTR + MTTR
		Response.Write "<set x='" & REPLACE(ROUND(MTBF,2),",",".") & "' y='" &  REPLACE(ROUND(MTTR,2),",",".") & "' label='" & ORs.Fields.Item(0).Value & "' />"
		Response.Write "</dataset>"
		ORs.MoveNext
	Wend
	
	Response.Write "<vTrendlines>"
    Response.Write " <line startValue='" & REPLACE(T_MTBF/C,",",".") & "' endValue='" & REPLACE((T_MTBF/C)+2,",",".") & "' displayValue='LIM.MTBF " & REPLACE(ROUND(T_MTBF/C,2),",",".") & "' color='FF0000'  /> "
    Response.Write "</vTrendlines>"
	
	Response.Write "<hTrendlines>"
    Response.Write " <line startValue='" & REPLACE(T_MTTR/C,",",".") & "' displayValue='LIM.MTTR " & REPLACE(ROUND(T_MTTR/C,2),",",".") & "' lineThickness='2' color='FF0000' valueOnRight='1' dashed='1' dashGap='5' /> "
    Response.Write "</hTrendlines>"
  
	
	Response.Write "</chart>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function graphJack()

query =	" SELECT P.EQUIPO, MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION = " & strNvl(SECCION) 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY P.EQUIPO, MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY FM DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	While Not ORs.EOF
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Grafica de Jack Knife' shownames='1'  numDivLines='10' XAxisName='N� FALLAS' yAxisName='MTTR' bgColor='FFFFFF' showBorder='0' anchorRadius='5' anchorBgAlpha='50' anchorBorderThickness='2'>"
	Response.Write "<categories verticalLineThickness='1'>"
	While Not ORs.EOF 
		 MTBF = ROUND((ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value)/ isCero(ORs.Fields.Item(10).Value),2)
		Response.Write "<category x='" & CDbl(ORs.Fields.Item(10).Value) &  "' label='" & CDbl(ORs.Fields.Item(10).Value) & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	While Not ORs.EOF 
		  Response.Write "<dataset seriesName='" & ORs.Fields.Item(0).Value & "'  showValues='1' >"
	      NF = CINT(ORs.Fields.Item(10).Value)
		  T_NF = T_NF + NF
		  MTTR = ROUND(ORs.Fields.Item(4).Value / isCero(ORs.Fields.Item(10).Value),2)
		  T_MTTR = T_MTTR + MTTR
		Response.Write "<set x='" & CDbl(ORs.Fields.Item(10).Value) & "' y='" &  REPLACE(ROUND(MTTR,2),",",".") & "' label='" & ORs.Fields.Item(0).Value & "' />"
		Response.Write "</dataset>"
		ORs.MoveNext
	Wend
	
	Response.Write "<vTrendlines>"
    Response.Write " <line startValue='" & REPLACE(T_NF/C,",",".") & "' endValue='" & REPLACE((T_NF/C)+0.05,",",".") & "' displayValue='LIM.NF " & REPLACE(ROUND(T_NF/C,2),",",".") & "' color='FF0000'  /> "
    Response.Write "</vTrendlines>"
	
	Response.Write "<hTrendlines>"
    Response.Write " <line startValue='" & REPLACE(ROUND(T_MTTR/C,2),",",".") & "' displayValue='LIM.MTTR " & REPLACE(ROUND(T_MTTR/C,2),",",".") & "' lineThickness='2' color='FF0000' valueOnRight='1' dashed='1' dashGap='5' /> "
    Response.Write "</hTrendlines>"
  
	
	Response.Write "</chart>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function numNvl(Valor)
	if Len(Valor) <1 then
		numNvl = 0
	else
		numNvl =  Valor	
	end if
end function

Function isCero(Valor)
	if Valor=0 then
		isCero = 1
	else
		isCero =  Valor	
	end if
end function

Function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

