<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
FOLIO=UCASE(REQUEST("FOLIO"))
CAUSA=UCASE(REQUEST("CAUSA"))
COLOR=UCASE(REQUEST("COLOR"))
MES=UCASE(REQUEST("MES"))
ANHO=UCASE(REQUEST("ANHO"))
SUCURSAL=UCASE(REQUEST("SUCURSAL"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
FAENA=UCASE(REQUEST("FAENA"))
SECCION=UCASE(REQUEST("SECCION"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))


Select Case RECURSO

	case "getObjetivos"
		  getObjetivos()
		
	case "listComportamientos"
		  listComportamientos()
		  
	case "grObjetivosA"
		  grObjetivosA()

	case "grObjetivosB"
		  grObjetivosB()
		  
	case "grObjetivosC"
		  grObjetivosC()
		  
	case "grObjetivosD"
		  grObjetivosD()  
		  		  
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
	
end select

function getObjetivos()

	query = "SELECT O.ID, O.OBJETIVO, O.INDICADOR, O.RESPONSABLE, OV.META, " 
	query = query & " ENE = SUM(CASE OV.MES WHEN 1 THEN OV.VALOR END),"
	query = query & " FEB = SUM(CASE OV.MES WHEN 2 THEN OV.VALOR END),"
	query = query & " MAR = SUM(CASE OV.MES WHEN 3 THEN OV.VALOR END),"
	query = query & " ABR = SUM(CASE OV.MES WHEN 4 THEN OV.VALOR END),"
	query = query & " MAY = SUM(CASE OV.MES WHEN 5 THEN OV.VALOR END),"
	query = query & " JUN = SUM(CASE OV.MES WHEN 6 THEN OV.VALOR END),"
	query = query & " JUL = SUM(CASE OV.MES WHEN 7 THEN OV.VALOR END),"
	query = query & " AGO = SUM(CASE OV.MES WHEN 8 THEN OV.VALOR END),"
	query = query & " SEP = SUM(CASE OV.MES WHEN 9 THEN OV.VALOR END),"
	query = query & " OCT = SUM(CASE OV.MES WHEN 10 THEN OV.VALOR END),"
	query = query & " NOV = SUM(CASE OV.MES WHEN 11 THEN OV.VALOR END),"
	query = query & " DIC = SUM(CASE OV.MES WHEN 12 THEN OV.VALOR END),"
	query = query & " SUM(OV.VALOR) AS ACUM"
	query = query & " FROM OBJETIVOS AS O "
	query = query & " LEFT OUTER JOIN OBJETIVOS_VALOR AS OV ON O.ID=OV.OBJETIVO "
	query = query & " AND OV.ANHO=" & strNvl(ANHO)
	
	If SUCURSAL<>"EMPRESA" Then
		query = query & " AND OV.SUCURSAL=" & strNvl(SUCURSAL)
	End If
	
	query = query & " GROUP BY O.ID, O.OBJETIVO, O.INDICADOR, O.RESPONSABLE, OV.META"
	 
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	'RESPONSE.Write(query)
	Response.Write "<REGISTRO>"
		
	While Not Rs.EOF 
		Response.Write "<ROW>"
		 Response.Write "<ID>" & Rs.Fields.Item(0).Value & "</ID>"
		 Response.Write "<OBJETIVO>" & Rs.Fields.Item(1).Value & "</OBJETIVO>"
		 Response.Write "<INDICADOR>" & Rs.Fields.Item(2).Value & "</INDICADOR>"
		 Response.Write "<RESPONSABLE>" & Rs.Fields.Item(3).Value & "</RESPONSABLE>"
		 Response.Write "<META>" & replace(numNvl(Rs.Fields.Item(4).Value),",",".") & "</META>"
		 Response.Write "<ENE>" &  numNvl(Rs.Fields.Item(5).Value) & "</ENE>"
		 Response.Write "<FEB>" &  numNvl(Rs.Fields.Item(6).Value) & "</FEB>"
		 Response.Write "<MAR>" &  numNvl(Rs.Fields.Item(7).Value) & "</MAR>"
		 Response.Write "<ABR>" &  numNvl(Rs.Fields.Item(8).Value) & "</ABR>"
		 Response.Write "<MAY>" &  numNvl(Rs.Fields.Item(9).Value) & "</MAY>"
		 Response.Write "<JUN>" &  numNvl(Rs.Fields.Item(10).Value) & "</JUN>"
		 Response.Write "<JUL>" &  numNvl(Rs.Fields.Item(11).Value) & "</JUL>"
		 Response.Write "<AGO>" &  numNvl(Rs.Fields.Item(12).Value) & "</AGO>"
		 Response.Write "<SEP>" &  numNvl(Rs.Fields.Item(13).Value) & "</SEP>"
		 Response.Write "<OCT>" &  numNvl(Rs.Fields.Item(14).Value) & "</OCT>"
		 Response.Write "<NOV>" &  numNvl(Rs.Fields.Item(15).Value) & "</NOV>"
		 Response.Write "<DIC>" &  numNvl(Rs.Fields.Item(16).Value) & "</DIC>"
		 Response.Write "<ACUM>" & numNvl(Rs.Fields.Item(17).Value) & "</ACUM>"
		 Response.Write "</ROW>"
		 Rs.MoveNext
	Wend
	
	Response.Write "</REGISTRO>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

Function grObjetivosA()

	query = "SELECT O.ID, O.OBJETIVO, O.INDICADOR, O.RESPONSABLE, OV.META, " 
	query = query & " ENE = SUM(CASE OV.MES WHEN 1 THEN OV.VALOR END),"
	query = query & " FEB = SUM(CASE OV.MES WHEN 2 THEN OV.VALOR END),"
	query = query & " MAR = SUM(CASE OV.MES WHEN 3 THEN OV.VALOR END),"
	query = query & " ABR = SUM(CASE OV.MES WHEN 4 THEN OV.VALOR END),"
	query = query & " MAY = SUM(CASE OV.MES WHEN 5 THEN OV.VALOR END),"
	query = query & " JUN = SUM(CASE OV.MES WHEN 6 THEN OV.VALOR END),"
	query = query & " JUL = SUM(CASE OV.MES WHEN 7 THEN OV.VALOR END),"
	query = query & " AGO = SUM(CASE OV.MES WHEN 8 THEN OV.VALOR END),"
	query = query & " SEP = SUM(CASE OV.MES WHEN 9 THEN OV.VALOR END),"
	query = query & " OCT = SUM(CASE OV.MES WHEN 10 THEN OV.VALOR END),"
	query = query & " NOV = SUM(CASE OV.MES WHEN 11 THEN OV.VALOR END),"
	query = query & " DIC = SUM(CASE OV.MES WHEN 12 THEN OV.VALOR END),"
	query = query & " SUM(OV.VALOR) AS ACUM"
	query = query & " FROM OBJETIVOS AS O "
	query = query & " LEFT OUTER JOIN OBJETIVOS_VALOR AS OV ON O.ID=OV.OBJETIVO "
	query = query & " AND OV.ANHO=" & strNvl(ANHO)
	
	If SUCURSAL<>"EMPRESA" Then
		query = query & " AND OV.SUCURSAL=" & strNvl(SUCURSAL)
	End If
	
	query = query & " WHERE O.ID IN (1) "
	query = query & " GROUP BY O.ID, O.OBJETIVO, O.INDICADOR, O.RESPONSABLE, OV.META"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='1' caption='Disminuci�n de Costos'  shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='Disminuir los costos de Trabajos en Garantia' />"
		ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Programado'  showValues='1' >" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & ORs.Fields.Item(4).Value & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Real'  showValues='1' >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & ORs.Fields.Item(17).Value & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
	

End Function

Function grObjetivosB()

	query = "SELECT O.ID, O.NOMBRE, O.INDICADOR, O.RESPONSABLE, OV.META, " 
	query = query & " ENE = SUM(CASE OV.MES WHEN 1 THEN OV.VALOR END),"
	query = query & " FEB = SUM(CASE OV.MES WHEN 2 THEN OV.VALOR END),"
	query = query & " MAR = SUM(CASE OV.MES WHEN 3 THEN OV.VALOR END),"
	query = query & " ABR = SUM(CASE OV.MES WHEN 4 THEN OV.VALOR END),"
	query = query & " MAY = SUM(CASE OV.MES WHEN 5 THEN OV.VALOR END),"
	query = query & " JUN = SUM(CASE OV.MES WHEN 6 THEN OV.VALOR END),"
	query = query & " JUL = SUM(CASE OV.MES WHEN 7 THEN OV.VALOR END),"
	query = query & " AGO = SUM(CASE OV.MES WHEN 8 THEN OV.VALOR END),"
	query = query & " SEP = SUM(CASE OV.MES WHEN 9 THEN OV.VALOR END),"
	query = query & " OCT = SUM(CASE OV.MES WHEN 10 THEN OV.VALOR END),"
	query = query & " NOV = SUM(CASE OV.MES WHEN 11 THEN OV.VALOR END),"
	query = query & " DIC = SUM(CASE OV.MES WHEN 12 THEN OV.VALOR END),"
	query = query & " AVG(OV.VALOR) AS ACUM"
	query = query & " FROM OBJETIVOS AS O "
	query = query & " LEFT OUTER JOIN OBJETIVOS_VALOR AS OV ON O.ID=OV.OBJETIVO "
	query = query & " AND OV.ANHO=" & strNvl(ANHO)
	
	If SUCURSAL<>"EMPRESA" Then
		query = query & " AND OV.SUCURSAL=" & strNvl(SUCURSAL)
	End If
	
	query = query & " WHERE O.ID IN (2,10, 14) "
	query = query & " GROUP BY O.ID, O.NOMBRE, O.INDICADOR, O.RESPONSABLE, OV.META"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='3' caption='Metas en %'  shownames='1'  showvalues='1' numberPrefix='%' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & ORs.Fields.Item(1).Value &  "' />"
		ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Programado'  showValues='1' >" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(4).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Real'  showValues='1' >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(17).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
	

End Function

Function grObjetivosC()

	query = "SELECT O.ID, O.NOMBRE, O.INDICADOR, O.RESPONSABLE, OV.META, " 
	query = query & " ENE = SUM(CASE OV.MES WHEN 1 THEN OV.VALOR END),"
	query = query & " FEB = SUM(CASE OV.MES WHEN 2 THEN OV.VALOR END),"
	query = query & " MAR = SUM(CASE OV.MES WHEN 3 THEN OV.VALOR END),"
	query = query & " ABR = SUM(CASE OV.MES WHEN 4 THEN OV.VALOR END),"
	query = query & " MAY = SUM(CASE OV.MES WHEN 5 THEN OV.VALOR END),"
	query = query & " JUN = SUM(CASE OV.MES WHEN 6 THEN OV.VALOR END),"
	query = query & " JUL = SUM(CASE OV.MES WHEN 7 THEN OV.VALOR END),"
	query = query & " AGO = SUM(CASE OV.MES WHEN 8 THEN OV.VALOR END),"
	query = query & " SEP = SUM(CASE OV.MES WHEN 9 THEN OV.VALOR END),"
	query = query & " OCT = SUM(CASE OV.MES WHEN 10 THEN OV.VALOR END),"
	query = query & " NOV = SUM(CASE OV.MES WHEN 11 THEN OV.VALOR END),"
	query = query & " DIC = SUM(CASE OV.MES WHEN 12 THEN OV.VALOR END),"
	query = query & " SUM(OV.VALOR) AS ACUM"
	query = query & " FROM OBJETIVOS AS O "
	query = query & " LEFT OUTER JOIN OBJETIVOS_VALOR AS OV ON O.ID=OV.OBJETIVO "
	query = query & " AND OV.ANHO=" & strNvl(ANHO)
	
	If SUCURSAL<>"EMPRESA" Then
		query = query & " AND OV.SUCURSAL=" & strNvl(SUCURSAL)
	End If
	
	query = query & " WHERE O.ID NOT IN (1,2,10,4,5,16,17,14) "
	query = query & " GROUP BY O.ID, O.NOMBRE, O.INDICADOR, O.RESPONSABLE, OV.META"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='1' caption='Real debe superar lo programado'  rotateLabels='1' shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & ORs.Fields.Item(1).Value &  "' />"
		ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Programado'  showValues='1' color='FF0000'>" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(4).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Real'  showValues='1' color='94B0BE'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(17).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
	

End Function

Function grObjetivosD()

	query = "SELECT O.ID, O.NOMBRE, O.INDICADOR, O.RESPONSABLE, OV.META, " 
	query = query & " ENE = SUM(CASE OV.MES WHEN 1 THEN OV.VALOR END),"
	query = query & " FEB = SUM(CASE OV.MES WHEN 2 THEN OV.VALOR END),"
	query = query & " MAR = SUM(CASE OV.MES WHEN 3 THEN OV.VALOR END),"
	query = query & " ABR = SUM(CASE OV.MES WHEN 4 THEN OV.VALOR END),"
	query = query & " MAY = SUM(CASE OV.MES WHEN 5 THEN OV.VALOR END),"
	query = query & " JUN = SUM(CASE OV.MES WHEN 6 THEN OV.VALOR END),"
	query = query & " JUL = SUM(CASE OV.MES WHEN 7 THEN OV.VALOR END),"
	query = query & " AGO = SUM(CASE OV.MES WHEN 8 THEN OV.VALOR END),"
	query = query & " SEP = SUM(CASE OV.MES WHEN 9 THEN OV.VALOR END),"
	query = query & " OCT = SUM(CASE OV.MES WHEN 10 THEN OV.VALOR END),"
	query = query & " NOV = SUM(CASE OV.MES WHEN 11 THEN OV.VALOR END),"
	query = query & " DIC = SUM(CASE OV.MES WHEN 12 THEN OV.VALOR END),"
	query = query & " SUM(OV.VALOR) AS ACUM"
	query = query & " FROM OBJETIVOS AS O "
	query = query & " LEFT OUTER JOIN OBJETIVOS_VALOR AS OV ON O.ID=OV.OBJETIVO "
	query = query & " AND OV.ANHO=" & strNvl(ANHO)
	
	If SUCURSAL<>"EMPRESA" Then
		query = query & " AND OV.SUCURSAL=" & strNvl(SUCURSAL)
	End If
	
	query = query & " WHERE O.ID IN (4,5,16,17) "
	query = query & " GROUP BY O.ID, O.NOMBRE, O.INDICADOR, O.RESPONSABLE, OV.META"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='4' caption='Real no debe superar lo programado'  shownames='1'  showvalues='1' overlapBars='1' showShadow='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & ORs.Fields.Item(1).Value &  "' />"
		ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Programado'  showValues='1' color='FFFF00'>" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(4).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Real'  showValues='1' color='94BBFF'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(17).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
	

End Function

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


function listObservaciones()

query =	" SELECT FOLIO, FECHA, NOMBRE "
query = query  & " FROM OBSERVACIONES "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<OBSERVADOR>" & ORs.Fields.Item(2).Value & "</OBSERVADOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listComportamientos()

	query = "SELECT COM.ID, COM.NOMBRE, C.FOLIO, C.VALOR "
	query = query & " FROM COMPORTAMIENTOS AS COM "
	query = query & " LEFT OUTER JOIN COMP_FOLIO AS C ON C.FOLIO=" & strNvl(FOLIO)
	query = query & " 		AND COM.ID = C.ID "
	query = query & " ORDER BY COM.ID"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<ID>" & ORs.Fields.Item(2).Value & "</ID>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End function
		 
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
	if isNull(Valor) then
		numNvl = 0
	else
		numNvl =  formatNumber(Valor,0)	
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

