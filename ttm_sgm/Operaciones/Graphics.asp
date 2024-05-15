
<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
CAUSA=UCASE(REQUEST("CAUSA"))
CUBIERTA=UCASE(REQUEST("CUBIERTA"))
COLOR=UCASE(REQUEST("COLOR"))
MES=UCASE(REQUEST("MES"))
ANHO=UCASE(REQUEST("ANHO"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FOLIO=UCASE(REQUEST("FOLIO"))
FOLIO_R=UCASE(REQUEST("FOLIO_R"))
FOLIOS=UCASE(REQUEST("FOLIOS"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INST=UCASE(REQUEST("FECHA_INST"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
FONDO=UCASE(REQUEST("FONDO"))
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
ESPESOR_SEG=UCASE(REQUEST("ESPESOR_SEG"))

Session.LCID = 2057

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
		  
	case "graphIND"
		  graphIND()
		  
	case "graphMTTR"
		  graphMTTR()
		  
	case "graphDispUtil"
		  graphDispUtil()
		  
	case "graphPareto"
		  graphPareto()
		  
	case "graphDispersion"
		  graphDispersion()	 
		  
	case "graphJack"
		  graphJack()	 	  	  
	
	case "grEspesor"
		  grEspesor()
		
	case "grEspesor2"
		  grEspesor2()
		    
	case "grProyec"
		  grProyec()
		  
	case "toExcel"
		toExcel()
		  		  
end select

function Criticidad_BAR()

	query = "SELECT  MONTH(FECHA) " 
	query = query & " FROM BITACORAS"
	query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	query = query & " AND FECHA BETWEEN " & strNvl(INICIO) & " AND " &  strNvl(TERMINO) 
	query = query & " GROUP BY  MONTH(FECHA) "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Criticidad' shownames='1' showvalues='1' showSum='1' decimals='0' overlapBars='1' showShadow='1' showLabels='1' yAxisMaxValue='25'>"
	Response.Write "<categories>"
	While Not Rs.EOF 
		Response.Write "<category label='" & trim(Rs.Fields.Item(0).Value) & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</categories>"
	
	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='ALTA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	 
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='ALTA'  showValues='1' color='FF0000'>" 
	While Not Rs.EOF 
	     If Not Rs.Fields.Item(1).Value Then
		 	Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Else
		 	Response.Write "<set value='0' />"
		 End If
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"

	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='MEDIA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='MEDIA'  showValues='1' color='FFFF00'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='BAJA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='BAJA'  showValues='1' color='3366FF'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function



function Criticidad_LINE()

	query = "SELECT  MONTH(FECHA) " 
	query = query & " FROM BITACORAS"
	query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	query = query & " AND FECHA BETWEEN " & strNvl(INICIO) & " AND " &  strNvl(TERMINO) 
	query = query & " GROUP BY  MONTH(FECHA) "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Criticidad' shownames='1' showvalues='1' showSum='1' decimals='0' overlapBars='1' showShadow='1' showLabels='1' yAxisMaxValue='25'>"
	Response.Write "<categories>"
	While Not Rs.EOF 
		Response.Write "<category label='" & trim(Rs.Fields.Item(0).Value) & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</categories>"
	
	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='ALTA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	 
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='ALTA'  showValues='1' color='FF0000'>" 
	While Not Rs.EOF 
	     If Not Rs.Fields.Item(1).Value Then
		 	Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Else
		 	Response.Write "<set value='0' />"
		 End If
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"

	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='MEDIA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON B1.MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='MEDIA'  showValues='1' color='FFFF00'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='BAJA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON B1.MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='BAJA'  showValues='1' color='3366FF'>"
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

Session.LCID = 1036
 

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
query = query  & " WHERE P.SECCION IN (" & SECCION & ")"
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
		  Response.Write "<DISP>" & ROUND(((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value + ORs.Fields.Item(4).Value) / isCero(ORs.Fields.Item(2).Value))*100,2) & "</DISP>"
		  
		  Response.Write "<UTIL>" & ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value )/ isCero(ORs.Fields.Item(2).Value)*100,2) & "</UTIL>"
		  Response.Write "<MTBF>" & ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value)/ isCero(ORs.Fields.Item(9).Value),2) & "</MTBF>"
		  Response.Write "<MTTR>" & ROUND(ORs.Fields.Item(3).Value / isCero(ORs.Fields.Item(9).Value),2) & "</MTTR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function graphIND()

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
query = query  & " WHERE P.SECCION IN (" & SECCION & ")"
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='MTBF/MTTR' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php' PYAxisName='MTBF' SYAxisName='MTTR'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst
	
	Response.Write "<dataset seriesName='MTBF'  showValues='1' color='99CC33'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value)/ isCero(ORs.Fields.Item(9).Value),2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='MTTR'  showValues='1' color='94B0BE' parentYAxis='S'>" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(3).Value / isCero(ORs.Fields.Item(9).Value),2),",",".") & "' />"
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
	Response.Write "<chart palette='2' caption='MTTR' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php'>"
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
	
	If FONDO="-" THEN
		FONDO = 0
	END IF
	'response.Write(ubound(aMuestreo))
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Espesores' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' yAxisMaxValue='" & CUBIERTA & "' yAxisMinValue='" & FONDO & "'  imageSave='1' imageSaveURL='FCExporter.php'>"
		 
	i=1
	Response.Write "<categories>"
	While i<=ubound(aMuestreo) 
		 	Response.Write "<category label='" & i & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</categories>"

	i=1
	Response.Write "<dataset seriesName='MUESTREO'  showValues='0' color='94B0BE' anchorRadius='2'>" 
	While i<=ubound(aMuestreo) 
		 	Response.Write "<set label='" & i & "' value='" & aMuestreo(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	i=1
	Response.Write "<dataset seriesName='PROYECCION'  showValues='0' color='FF0000' anchorRadius='2'>" 
	While i<=ubound(aProyec) 
		 	Response.Write "<set label='" & i & "' value='" & aProyec(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	i=1
	Response.Write "<dataset seriesName='RETORNO'  showValues='0' color='000000' anchorRadius='2'>" 
	While i<=ubound(aRetorno) 
		 	Response.Write "<set label='" & i & "' value='" & aRetorno(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</dataset>"
	  
   	Response.Write "<trendLines>"
    Response.Write "<line startValue='0' color='FF0000' displayvalue='Carcasa' valueOnRight='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & CUBIERTA & "' color='000099' displayvalue='Fecha Muestra " + FECHA + "' thickness='1' valueOnRight='1' showOnTop='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & FONDO & "' color='000099' displayvalue='Retorno' thickness='1' valueOnRight='1' showOnTop='1'/> "
	Response.Write "</trendLines>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grEspesor2()
    
	Dim aMuestreo(100)
	Dim aProyec
	Dim aRetorno
	Dim desgMax
	Dim media
	Dim min
		
	query = "SET DATEFORMAT DMY SELECT M.FOLIO, M.FECHA, M.TIPO "
	query = query & " FROM MEDICIONES AS M "
	query = query & " WHERE M.FOLIO IN (" & FOLIOS & ")"
	query = query & " ORDER BY M.FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	FLAT=0
	TIPO="CAR"
	vect = array("663300","33CC00","3399FF","666600")
	y = 0
	swX = 0
	if Not ORs.Eof then 
		FOLIO = ORs.Fields.Item(0).Value
		FECHAx = ORs.Fields.Item(1).Value
	end if
	While Not ORs.Eof
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value

		query = "SELECT MV.ID, MV.VALOR, MV.RETORNO"
		query = query & " FROM MEDICIONES_VALOR AS MV "
		query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
		query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
		query = query & " ORDER BY MV.ID "
	 
		Set ORsLecturas =oDB.EjecutaSql(query)
		
		IF FLAT=0 THEN
			FLAT = 1
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<chart palette='1' caption='MEDICION DE ESPESORES   " & EQUIPO & " - " & FAENA & "' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' yAxisMaxValue='" & CUBIERTA & "' yAxisMinValue='" & FONDO & "'  imageSave='1' imageSaveURL='FCExporter.php' legendPosition='BOTTOM'>"

			i=1
			desgMax = 0
			media=0
			min=100
			Response.Write "<categories>"
			While Not ORsLecturas.Eof
		 		Response.Write "<category label='" & i & "' />"
				aMuestreo(i) = ORsLecturas.Fields.Item(1).Value
				If desgMax<CUBIERTA - ORsLecturas.Fields.Item(1).Value Then
					desgMax = CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value)
				End If
				
				If min>ORsLecturas.Fields.Item(1).Value Then
				min = ORsLecturas.Fields.Item(1).Value
				End IF
				i=i+1
				media=media+ORsLecturas.Fields.Item(1).Value
				ORsLecturas.MoveNext
			Wend
			media = media/(i-1)
			
			Response.Write "</categories>"
		
			j=i
			
		  END IF
		i=1
		ORsLecturas.MoveFirst
		Response.Write "<dataset seriesName='MUESTREO " & ORs.Fields.Item(1).Value & "'  showValues='0' anchorRadius='2' lineThickness='2' color='" & vect(y) & "'>" 
		While Not ORsLecturas.eof
		 		Response.Write "<set label='" & ORsLecturas.Fields.Item(0).Value _
					 & "' value='" & ORsLecturas.Fields.Item(1).Value & "' />"
				'Response.Write(aMuestreo(i))
			i=i+1
			ORsLecturas.movenext
		Wend
		
		Response.Write "</dataset>"
		ORs.MoveNext	
		y = y + 1
		if y = 4 then y = 0 end if
		swX = 1
	Wend
	
	i=1
	
	'response.write  FECHA_INST & " " & FECHAx & " " & FOLIO & " " & FOLIOS
	
	diasOP = ROUND(DATEDIFF("d", FECHA_INST, FECHAx),0)
	tasa   = desgMax / diasOP 
	
	diasP  = (CUBIERTA-ESPESOR_SEG) / tasa
	
    fechaT = dateAdd("d",diasP,FECHA_INST)
	
	Response.Write "<dataset seriesName='PROYECCION " &  fechaT & " Tasa " & round(tasa,3) & "mm/dia   Media " & round(media,3) & " Min " & min & "'  showValues='0' anchorRadius='2' color='FFCC00'>" 


			
	While i<=j 'GRAFICAR
			valor = aMuestreo(i)
			desgaste = CUBIERTA - valor
			desgastePr = CUBIERTA - (desgaste / diasOP) * diasP
			
		 	Response.Write "<set label='" & i & "' value='" & desgastePr & "' />"
		    'Response.Write "<set label='" & i & "' value='" & desgaste & "' />"
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	IF LEN(FOLIO_R)>0 THEN
		query = "SELECT MV.ID, MV.VALOR, MV.RETORNO"
		query = query & " FROM MEDICIONES_VALOR AS MV "
		query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO_R)
		query = query & " AND MV.TIPO='RET'" '& strNvl(TIPO)
		query = query & " ORDER BY MV.ID "
		Set ORsRetorno =oDB.EjecutaSql(query)
		
		i=1
		Response.Write "<dataset seriesName='RETORNO'  showValues='0' color='000000' anchorRadius='1'>" 
		While Not ORsRetorno.eof 
		 	Response.Write "<set label='" & i & "' value='" & ORsRetorno.Fields.Item(1).Value & "' />"
			ORsRetorno.MoveNext
			i=i+1
		Wend
		Response.Write "</dataset>"
		
	END IF ' RETORNO
	
   	Response.Write "<trendLines>"
    Response.Write "<line startValue='0' color='FF0000' displayvalue='CARCASA' valueOnRight='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & ESPESOR_SEG & "' color='FFFF00' displayvalue='SEGURIDAD' valueOnRight='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & CUBIERTA & "' color='000099' displayvalue='CUBIERTA' thickness='1' valueOnRight='1' showOnTop='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & FONDO & "' color='000099' displayvalue='RETORNO' thickness='1' valueOnRight='1' showOnTop='1'/> "
	Response.Write "</trendLines>"
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
	Response.Write "<chart palette='2' caption='Proyecciones' shownames='1' formatNumberScale='0' formatNumber='0' showShadow='1'  rotateLabels='1' showDivLineValues='1' divLineThickness='3' yAxisMinValue='200000' numberSuffix=' YYYYMM' imageSave='1' imageSaveURL='FCExporter.php'>"
	i=1
	Response.Write "<categories>"
	While i<=ubound(aMuestreo) 
		 	Response.Write "<category label='" & aMuestreo(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</categories>"

	
	i=1
	Response.Write "<dataset seriesName='PROYECCION' showValues='0' rotateLabels='1' >" 
	While i<=ubound(aProyec) 
		 	Response.Write "<set label='" & aMuestreo(i) & "' value='" & aProyec(i) & "' />"
			'Response.Write(aProyec(i)))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='200900' color='000000' displayvalue='A�o Actual 2009' valueOnRight='1'/> "
	Response.Write "</trendLines>"
	
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
	Response.Write "<chart palette='2' caption='Indicadores' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst

	Response.Write "<dataset seriesName='Disponibilidad'  RenderAs='Line'  >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value + ORs.Fields.Item(4).Value) / isCero(ORs.Fields.Item(2).Value))*100,2),",",".") & "' />"
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

query =	" SELECT dbo.equipoprincipal(P.EQUIPO), MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION IN (" & SECCION & ")" 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY dbo.equipoprincipal(P.EQUIPO), MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY TT DESC "
	
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
		 
function graphPareto()

query =	" SELECT P.EQUIPO, MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION in (" & SECCION & ")" 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY P.EQUIPO, MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY TT DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TTotalC = 0
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
		TTotalC = TTotalC + CDbl(ORs.Fields.Item(3).Value)
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Pareto Tiempo Fuera de Servicios' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php' rotateLabels='1' showBorder='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & CStr(ORs.Fields.Item(0).Value) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Horas Total Tiempo FS'  showValues='1' color='94B0BE'>" 
	While Not ORs.EOF 
		Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(4).Value/TTotal*100,2),",",".") & "' />"
		ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Acumulado'  showValues='1' color='FFF000' RenderAs='Line' >" 
	While Not ORs.EOF 
		ProcAcum = ProcAcum + (ORs.Fields.Item(4).Value/TTotal)
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
query = query & " WHERE  P.SECCION in (" & SECCION & ")"
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
	Response.Write "<chart palette='2' caption='Grafica de Dispersi�n' shownames='1'  numDivLines='10' yAxisName='MTTR'  rotateNames='1'  anchorRadius='5' anchorBorderThickness='2' imageSave='1' imageSaveURL='FCExporter.php' showBorder='1' borderColor='000000' borderThickness='1' bgColor='FFFFFF'>"
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
    Response.Write " <line startValue='" & REPLACE(T_MTTR/C,",",".") & "' displayValue=' " & REPLACE(ROUND(T_MTTR/C,2),",",".") & "' lineThickness='2' color='FF0000' valueOnRight='1' dashed='1' dashGap='5' /> "
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
query = query & " WHERE  P.SECCION IN (" & SECCION & ")" 
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
	Response.Write "<chart palette='2' caption='Grafica de Jack Knife' shownames='1'  numDivLines='10' XAxisName='N� FALLAS' yAxisName='MTTR' bgColor='FFFFFF' showBorder='1' anchorRadius='5' anchorBgAlpha='50'  imageSave='1' imageSaveURL='FCExporter.php'>"
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

Function toExcel()
Set oExcel = Server.CreateObject("Excel.Application")
oExcel.Workbooks.Open "C:\1.xls"
oExcel.CELLS(1, 1)="25772"


End Function

%>

