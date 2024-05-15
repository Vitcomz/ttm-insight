<!--#include file="../standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

CODIGO=UCASE(REQUEST("CODIGO"))
COMPONENTE=UCASE(REQUEST("COMPONENTE"))

RECURSO=REQUEST("RECURSO")
ID=REQUEST("ID")
FOLIO=REQUEST("FOLIO")
MES=REQUEST("MES")
ANO=REQUEST("ANO")
FECHA_INI=REQUEST("FECHA_INI")
FECHA_FIN=REQUEST("FECHA_FIN")
TIPO=REQUEST("TIPO")
TIPO_EQUIPO=REQUEST("TIPO_EQUIPO")
TIPO_FALLA=REQUEST("TIPO_FALLA")
EQUIPO=REQUEST("EQUIPO")
CAUSA=REQUEST("CAUSA")
SECCION=REQUEST("SECCION")
OT=REQUEST("OT")
EXCEL=REQUEST("EXCEL")
FAENA=REQUEST("FAENA")
OBSERVACION=REQUEST("OBSERVACION")
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))

Select case RECURSO
	case "GetSeccion" 
	 	  GetSeccion() 
	
	case "getParada" 
	 	  getParada()
		  	
	case "updateParada" 
	 	  updateParada()
		
	case "newParada" 
	 	  newParada()
		  
	case "newTipoParada"
		  newTipoParada()
	
	case "existParada" 
	 	  existParada()
		
	case "delParada"
		  delParada()
		  
	case "delTipoParada"
		  delTipoParada()
		  
	case "listParadas"
	 	  listParadas()
	
	case "infParadas"
	 	  infParadas()
		  
	case "infTopTen"
	 	  infTopTen()
		  		
	case "listTipoParadas"
	 	  listTipoParadas()
		  
	case "listParadasxTipo"
	 	  listParadasxTipo()
		
End Select


function listParadas2()

	query = "SELECT ID, RTRIM(CONVERT(CHAR,FECHA_INI,103)) AS FECHA_INI, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_INI,108),1,5) AS HORA_INI, "
	query = query & " RTRIM(CONVERT(CHAR,FECHA_FIN,103)) AS FECHA_FIN, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_FIN,108),1,5) AS HORA_FIN," 
	query = query & " ROUND(MINUTOS/60,2), EQUIPO, TIPO, CAUSA, P.OBSERVACION, E.DESCRIPCION "
	query = query & " FROM PARADAS AS P "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON P.EQUIPO = E.CODIGO"
	query = query & " WHERE P.SECCION = " & strNvl(SECCION)
	query = query & "  	    AND FAENA = " & strNvl(FAENA)
	query = query & " AND (CONVERT(DATETIME,CONVERT(CHAR,FECHA_INI,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " ORDER BY CONVERT(DATETIME,FECHA_INI,103) "
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<FECHA_INI>" & ORs.Fields.Item(1).Value & "</FECHA_INI>"
	  Response.Write "<HORA_INI>" & ORs.Fields.Item(2).Value & "</HORA_INI>"
	  Response.Write "<FECHA_FIN>" & ORs.Fields.Item(3).Value & "</FECHA_FIN>"
	  Response.Write "<HORA_FIN>" & ORs.Fields.Item(4).Value & "</HORA_FIN>"
	  Response.Write "<MINUTOS>" & ORs.Fields.Item(5).Value & "</MINUTOS>"
	  Response.Write "<EQUIPO>" & ORs.Fields.Item(6).Value & "</EQUIPO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(10).Value & "</DESCRIPCION>"
	  
	  SELECT CASE ORs.Fields.Item(7).Value
	  Case "FM"
			TIPO = "FALLA MECANICA"
		Case "FE"
			TIPO = "FALLA ELECTRICA"
		Case "FI"
			TIPO = "FALLA INSTRUMENTAL"
		Case "FG"
			TIPO = "FALLA GENERAL"
		Case "FO"
			TIPO = "FALLA OPERACIONAL"
		Case "MP"
			TIPO = "MANTENCION PROGRAMADA"
		Case "OP"
			TIPO = "OPERACIONAL PROGRAMADA"
		Case "ST"
			TIPO = "STAND BY"
	  END SELECT
	  
	  Response.Write "<TIPO>" & TIPO & "</TIPO>"
	  Response.Write "<CAUSA>" & ORs.Fields.Item(8).Value & "</CAUSA>"
	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listParadas3()

	query = "SELECT ID, RTRIM(CONVERT(CHAR,FECHA_INI,103)) AS FECHA_INI, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_INI,108),1,5) AS HORA_INI, "
	query = query & " RTRIM(CONVERT(CHAR,FECHA_FIN,103)) AS FECHA_FIN, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_FIN,108),1,5) AS HORA_FIN," 
	query = query & " ROUND(MINUTOS/60,2), EQUIPO, TIPO, CAUSA, P.OBSERVACION, E.DESCRIPCION "
	query = query & " FROM PARADAS AS P "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON P.EQUIPO = E.CODIGO"
	query = query & " WHERE P.SECCION = " & strNvl(SECCION)
	query = query & "  	    AND FAENA = " & strNvl(FAENA)
	query = query & " AND (CONVERT(DATETIME,CONVERT(CHAR,FECHA_INI,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " ORDER BY CONVERT(DATETIME,FECHA_INI,103) "
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<FECHA_INI>" & ORs.Fields.Item(1).Value & "</FECHA_INI>"
	  Response.Write "<HORA_INI>" & ORs.Fields.Item(2).Value & "</HORA_INI>"
	  Response.Write "<FECHA_FIN>" & ORs.Fields.Item(3).Value & "</FECHA_FIN>"
	  Response.Write "<HORA_FIN>" & ORs.Fields.Item(4).Value & "</HORA_FIN>"
	  Response.Write "<MINUTOS>" & ORs.Fields.Item(5).Value & "</MINUTOS>"
	  Response.Write "<EQUIPO>" & ORs.Fields.Item(6).Value & "</EQUIPO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(10).Value & "</DESCRIPCION>"
	  
	  SELECT CASE ORs.Fields.Item(7).Value
	  Case "FM"
			TIPO = "FALLA MECANICA"
		Case "FE"
			TIPO = "FALLA ELECTRICA"
		Case "FI"
			TIPO = "FALLA INSTRUMENTAL"
		Case "FG"
			TIPO = "FALLA GENERAL"
		Case "FO"
			TIPO = "FALLA OPERACIONAL"
		Case "MP"
			TIPO = "MANTENCION PROGRAMADA"
		Case "OP"
			TIPO = "OPERACIONAL PROGRAMADA"
		Case "ST"
			TIPO = "STAND BY"
	  END SELECT
	  
	  Response.Write "<TIPO>" & TIPO & "</TIPO>"
	  Response.Write "<CAUSA>" & ORs.Fields.Item(8).Value & "</CAUSA>"
	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function listParadas()

	query = "SELECT ID, RTRIM(CONVERT(CHAR,FECHA_INI,103)) AS FECHA_INI, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_INI,108),1,5) AS HORA_INI, "
	query = query & " RTRIM(CONVERT(CHAR,FECHA_FIN,103)) AS FECHA_FIN, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_FIN,108),1,5) AS HORA_FIN," 
	query = query & " ROUND(MINUTOS/60,2), EQUIPO, TIPO, CAUSA, P.OBSERVACION, E.DESCRIPCION, E2.CODIGO "
	query = query & " FROM PARADAS AS P "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON P.EQUIPO = E.CODIGO"
	query = query & " LEFT OUTER JOIN EQUIPOS AS E2 ON P.COMPONENTE = E2.CODIGO"
	query = query & " WHERE "
	
	IF SECCION<>"TOD" THEN
		query = query & " P.SECCION = " & strNvl(SECCION) & " AND "
	END IF

	query = query & " FAENA = " & strNvl(FAENA)

	IF EQUIPO<>"TOD" THEN
		query = query & "  	    AND P.EQUIPO = " & strNvl(EQUIPO)
	END IF
	
	query = query & " AND MONTH(FECHA_INI)=" & strNvl(MES) 
	query = query & " AND YEAR(FECHA_INI)=" & strNvl(ANO) 
	query = query & " GROUP BY ID, FECHA_INI, "
	query = query & " FECHA_FIN, "
	query = query & " MINUTOS, " 
	query = query & " EQUIPO, TIPO, CAUSA, P.OBSERVACION, E.DESCRIPCION, E2.CODIGO "
	query = query & " ORDER BY CONVERT(DATETIME,FECHA_INI,103) "
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<FECHA_INI>" & ORs.Fields.Item(1).Value & "</FECHA_INI>"
	  Response.Write "<HORA_INI>" & ORs.Fields.Item(2).Value & "</HORA_INI>"
	  Response.Write "<FECHA_FIN>" & ORs.Fields.Item(3).Value & "</FECHA_FIN>"
	  Response.Write "<HORA_FIN>" & ORs.Fields.Item(4).Value & "</HORA_FIN>"
	  Response.Write "<MINUTOS>" & ORs.Fields.Item(5).Value & "</MINUTOS>"
	  Response.Write "<EQUIPO>" & ORs.Fields.Item(6).Value & "</EQUIPO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(10).Value & "</DESCRIPCION>"
	  Response.Write "<COMPONENTE>" & ORs.Fields.Item(11).Value & "</COMPONENTE>"
	  
	  SELECT CASE ORs.Fields.Item(7).Value
	  Case "FM"
			TIPO = "FALLA MECANICA"
		Case "FE"
			TIPO = "FALLA ELECTRICA"
		Case "FI"
			TIPO = "FALLA INSTRUMENTAL"
		Case "FG"
			TIPO = "FALLA GENERAL"
		Case "FO"
			TIPO = "FALLA OPERACIONAL"
		Case "MP"
			TIPO = "MANTENCION PROGRAMADA"
		Case "OP"
			TIPO = "OPERACIONAL PROGRAMADA"
		Case "ST"
			TIPO = "STAND BY"
	  END SELECT
	  
	  Response.Write "<TIPO>" & TIPO & "</TIPO>"
	  Response.Write "<CAUSA>" & ORs.Fields.Item(8).Value & "</CAUSA>"
	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getParada()

	query = "SELECT ID, RTRIM(CONVERT(CHAR,FECHA_INI,103)) AS FECHA_INI, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_INI,108),1,5) AS HORA_INI, "
	query = query & " RTRIM(CONVERT(CHAR,FECHA_FIN,103)) AS FECHA_FIN, "
	query = query & " SUBSTRING(CONVERT(CHAR,FECHA_FIN,108),1,5) AS HORA_FIN," 
	query = query & " ROUND(MINUTOS/60,2), EQUIPO, TIPO, CAUSA, P.OBSERVACION,"
	query = query & " P.COMPONENTE,  E.DESCRIPCION, E2.DESCRIPCION, P.OT "
	query = query & " FROM PARADAS AS P "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON P.EQUIPO = E.CODIGO"
	query = query & " LEFT OUTER JOIN EQUIPOS AS E2 ON P.COMPONENTE = E2.CODIGO"
	query = query & " WHERE P.ID = " & strNvl(ID)
	query = query & " ORDER BY CONVERT(DATETIME,FECHA_INI,103) "
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<FECHA_INI>" & ORs.Fields.Item(1).Value & "</FECHA_INI>"
	  Response.Write "<HORA_INI>" & ORs.Fields.Item(2).Value & "</HORA_INI>"
	  Response.Write "<FECHA_FIN>" & ORs.Fields.Item(3).Value & "</FECHA_FIN>"
	  Response.Write "<HORA_FIN>" & ORs.Fields.Item(4).Value & "</HORA_FIN>"
	  Response.Write "<MINUTOS>" & ORs.Fields.Item(5).Value & "</MINUTOS>"
	  Response.Write "<EQUIPO>" & ORs.Fields.Item(6).Value & "</EQUIPO>"
	  Response.Write "<COD_TIPO>" & ORs.Fields.Item(7).Value & "</COD_TIPO>"
	 
	  
	  SELECT CASE ORs.Fields.Item(7).Value
	  Case "FM"
			TIPO = "FALLA MECANICA"
		Case "FE"
			TIPO = "FALLA ELECTRICA"
		Case "FI"
			TIPO = "FALLA INSTRUMENTAL"
		Case "FG"
			TIPO = "FALLA GENERAL"
		Case "FO"
			TIPO = "FALLA OPERACIONAL"
		Case "MP"
			TIPO = "MANTENCION PROGRAMADA"
		Case "OP"
			TIPO = "OPERACIONAL PROGRAMADA"
		Case "ST"
			TIPO = "STAND BY"
	  END SELECT
	  
	  Response.Write "<TIPO>" & TIPO & "</TIPO>"
	  Response.Write "<CAUSA>" & ORs.Fields.Item(8).Value & "</CAUSA>"
	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
	  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(11).Value & "</DESC_EQUIPO>"
	  Response.Write "<COD_COMPONENTE>" & ORs.Fields.Item(10).Value & "</COD_COMPONENTE>"
	  Response.Write "<DESC_COMPONENTE>" & ORs.Fields.Item(12).Value & "</DESC_COMPONENTE>"
	  Response.Write "<OT>" & ORs.Fields.Item(13).Value & "</OT>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function infParadas()
	query = "SELECT ID, RTRIM(CONVERT(CHAR,FECHA_INI,103)) + ' ' + SUBSTRING(CONVERT(CHAR,FECHA_INI,108),1,5) AS FECHA_INI, "
	query = query & " RTRIM(CONVERT(CHAR,FECHA_FIN,103)) + ' ' + SUBSTRING(CONVERT(CHAR,FECHA_FIN,108),1,5) AS FECHA_FIN," 
	query = query & " MINUTOS, EQUIPO, TIPO, CAUSA, P.OBSERVACION, E.DESCRIPCION, P.SECCION "
	query = query & " FROM PARADAS AS P "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON P.EQUIPO = E.CODIGO"
	query = query & " WHERE FAENA = " & strNvl(FAENA)
	
	IF SECCION<>"'TOD'" THEN
		query = query & "  	    AND  P.SECCION in (" & SECCION & ")"
	END IF
	
	query = query & "  	    AND  FECHA_INI BETWEEN  " & strNvl(FECHA_INI) 
	query = query & "  	    AND   DATEADD(d,1," & strNvl(FECHA_FIN) & ")"
	
	IF EQUIPO<>"TOD" THEN
		query = query & "  	    AND  P.EQUIPO = " & strNvl(EQUIPO)
	END IF
	
	IF TIPO<>"TO" THEN
		query = query & "  	    AND  P.TIPO = " & strNvl(TIPO)
	END IF
	
	query = query & " ORDER BY CONVERT(DATETIME,FECHA_INI,103) "
	
	
	Set ORs =oDB.EjecutaSql(query)
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = strName & ".xls"
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Inicio</TD>"
   				   Response.Write "<TD>Termino</TD>"
   				   Response.Write "<TD>Tiempo</TD>"
				   Response.Write "<TD>Equipo</TD>"
				   Response.Write "<TD>Tipo</TD>"
				   Response.Write "<TD>Causa</TD>"
				   Response.Write "<TD>Seccion</TD>"
				   Response.Write "<TD>Observacion</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & " " & ORs.Fields.Item(8).Value & "</TD>"
				   Select Case  ORs.Fields.Item(5).Value
	   				Case "FM"
						TIPO = "FALLA MECANICA"
					Case "FE"
							TIPO = "FALLA ELECTRICA"
					Case "FI"
						TIPO = "FALLA INSTRUMENTAL"
					Case "FG"
						TIPO = "FALLA GENERAL"
					Case "FO"
						TIPO = "FALLA OPERACIONAL"
					Case "MP"
						TIPO = "MANTENCION PROGRAMADA"
					Case "OP"
						TIPO = "OPERACIONAL PROGRAMADA"
					Case "ST"
						TIPO = "STAND BY"
	 			 End Select
	 			 Response.Write "<TD>" & TIPO & "</TD>"
				 Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
				 Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
				 Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<FECHA_INI>" & ORs.Fields.Item(1).Value & "</FECHA_INI>"
	  Response.Write "<FECHA_FIN>" & ORs.Fields.Item(2).Value & "</FECHA_FIN>"
	  Response.Write "<MINUTOS>" & ORs.Fields.Item(3).Value & "</MINUTOS>"
	  Response.Write "<EQUIPO>" & ORs.Fields.Item(4).Value & " " & ORs.Fields.Item(8).Value & "</EQUIPO>"
	  Select Case  ORs.Fields.Item(5).Value
	   	Case "FM"
			TIPO = "FALLA MECANICA"
		Case "FE"
			TIPO = "FALLA ELECTRICA"
		Case "FI"
			TIPO = "FALLA INSTRUMENTAL"
		Case "FG"
			TIPO = "FALLA GENERAL"
		Case "FO"
			TIPO = "FALLA OPERACIONAL"
		Case "MP"
			TIPO = "MANTENCION PROGRAMADA"
		Case "OP"
			TIPO = "OPERACIONAL PROGRAMADA"
		Case "ST"
			TIPO = "STAND BY"
	  End Select
	  Response.Write "<TIPO>" & TIPO & "</TIPO>"
	  Response.Write "<CAUSA>" & ORs.Fields.Item(6).Value & "</CAUSA>"
	  Response.Write "<SECCION>" & ORs.Fields.Item(9).Value & "</SECCION>"
	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(7).Value & "</OBSERVACION>"
	  
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	End If
	Set ORs = Nothing
	Set ODB = Nothing
end function

function infTopTen()

	query = "SELECT "
	query = query & " ROUND(SUM(MINUTOS)/60,2), EQUIPO,  E.DESCRIPCION "
	query = query & " FROM PARADAS AS P "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON P.EQUIPO = E.CODIGO"
	query = query & " WHERE P.SECCION = " & strNvl(SECCION)
	query = query & "  	    AND  FAENA = " & strNvl(FAENA)
	query = query & "  	    AND  FECHA_INI BETWEEN  " & strNvl(FECHA_INI) 
	query = query & "  	    AND   DATEADD(d,1," & strNvl(FECHA_FIN) & ")"
	query = query & "  	    AND   TIPO=" & strNvl(TIPO) & ""
	query = query & " GROUP BY  EQUIPO,  E.DESCRIPCION  "
	query = query & " ORDER BY 1 DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = strName & ".xls"
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Horas</TD>"
   				   Response.Write "<TD>Equipo</TD>"
   				   Response.Write "<TD>Descripci�n</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<MINUTOS>" & ORs.Fields.Item(0).Value & "</MINUTOS>"
	  Response.Write "<EQUIPO>" & ORs.Fields.Item(1).Value & "</EQUIPO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	End If
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listTipoParadas()

	query = "SELECT ID, P.DESCRIPCION, P.TIPO_EQUIPO, P.TIPO_FALLA "
	query = query & " FROM TIPO_PARADAS AS P, EQUIPOS AS E "
	query = query & " WHERE P.TIPO_EQUIPO = E.TIPO_EQUIPO "
	query = query & " AND E.CODIGO=" & strNvl(EQUIPO) 
	query = query & " AND P.TIPO_FALLA=" & strNvl(TIPO) 
	query = query & " AND  FAENA = " & strNvl(FAENA)
		
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(2).Value & "</TIPO_EQUIPO>"
	  Response.Write "<TIPO_FALLA>" & ORs.Fields.Item(3).Value & "</TIPO_FALLA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listParadasxTipo()

	query = "SELECT P.ID, P.DESCRIPCION, P.TIPO_EQUIPO, P.TIPO_FALLA "
	query = query & " FROM TIPO_PARADAS AS P "
	query = query & " WHERE P.TIPO_EQUIPO=" & strNvl(TIPO_EQUIPO) 
	query = query & "       AND P.TIPO_FALLA=" & strNvl(TIPO) 
	query = query & "  	    AND  FAENA = " & strNvl(FAENA)
		
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(2).Value & "</TIPO_EQUIPO>"
	  Response.Write "<TIPO_FALLA>" & ORs.Fields.Item(3).Value & "</TIPO_FALLA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetSeccion()
	query = "SELECT ID, NOMBRE FROM SECCIONES WHERE ID= '" & ID & "'" 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>" 
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function existParada()
	query = "SELECT * FROM PARADAS WHERE FECHA_INI = " & strNvl(FECHA_INI)  
	query = query & " AND SECCION = " & strNvl(SECCION)
	query = query & " AND FAENA = " & strNvl(FAENA)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" 
	If Not ORs.EOF Then
		Response.Write "TRUE"
	Else 
		Response.Write "FALSE"
	End If
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updateParada()
	query = "UPDATE PARADAS SET FECHA_INI = " & strNvl(FECHA_INI) 
	query = query & " , FECHA_FIN = " & strNVl(FECHA_FIN) 
	query = query & " , EQUIPO = " & strNVl(EQUIPO)
	query = query & " , COMPONENTE= " & strNVl(COMPONENTE)
	query = query & " , MINUTOS = DATEDIFF(MINUTE," & strNvl(FECHA_INI) & "," & strNVl(FECHA_FIN) & ")" 
	query = query & " , TIPO = " & strNVl(TIPO)
	query = query & " , CAUSA = " & strNVl(CAUSA) 
	query = query & " , OT = " & strNVl(OT) 
	query = query & " , OBSERVACION = " & strNVl(OBSERVACION) 
	query = query & " WHERE ID = " & strNVl(ID) 
	query = query & " 	AND FAENA = " & strNVl(FAENA)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function newParada()

 'Format(Text1.Text, "dd/mm/yyyy")
 
 
 	query = " SELECT SECCION FROM EQUIPOS WHERE CODIGO = " & strNvl(EQUIPO) & " AND UBICACION=" & strNvl(FAENA)
	Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.Eof Then
			SECCION =ORs.Fields.Item(0).Value
	End If
	 
	Session.LCID = 2057
	
	If Len(FECHA_FIN)=0 Then
		FECHA_FIN = DATEADD("n",5,CDATE(FECHA_INI))
		'FECHA_FIN = FormatDateTime(FECHA_FIN, "dd/mm/yyyy")
	End If

	query = "INSERT INTO PARADAS (FECHA_INI, FECHA_FIN, MINUTOS, EQUIPO, COMPONENTE, TIPO, "
	query = query  & " OT, CAUSA, OBSERVACION, FAENA, SECCION)"
	query = query  & "VALUES (" & strNvl(FECHA_INI)  
	query = query  & ", " & strNvl(FECHA_FIN)  & "" 
	query = query  & ", DATEDIFF(MINUTE," & strNvl(FECHA_INI) & "," & strNVl(FECHA_FIN) & ")" 
	query = query  & "," & strNvl(EQUIPO) 
	query = query  & "," & strNvl(COMPONENTE) 
	query = query  & "," & strNvl(TIPO)
	query = query  & "," & strNvl(OT)
	query = query  & "," & strNvl(CAUSA)
	query = query  & "," & strNvl(OBSERVACION)
	query = query  & "," & strNvl(FAENA)
	query = query  & "," & strNvl(SECCION) & ")"     

	Set ORs =oDB.EjecutaSql(query)
	
 	query = "Select @@IDENTITY as Ident"
	Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.Eof Then
			ID_NEW =ORs.Fields.Item(0).Value
	End If
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & ID_NEW  & "</ID>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function newTipoParada()
	
	query = "SELECT MAX(ID) FROM TIPO_PARADAS"
	Set ORs =oDB.EjecutaSql(query)
	
    If Not ORs.Eof Then
			N = Cint(ORs.Fields.Item(0).Value) + 1
	Else
			N=1
	End If
	
	query = "INSERT INTO TIPO_PARADAS (ID, DESCRIPCION, TIPO_EQUIPO, FAENA, TIPO_FALLA)"
	query = query  & "VALUES (" & N & "," 
	query = query  & strNvl(DESCRIPCION) & ","
	query = query  & TIPO_EQUIPO & ","
	query = query  & strNvl(FAENA) & ","
	query = query  & strNvl(TIPO_FALLA) & ")" 
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function delParada()
	query = "DELETE PARADAS WHERE ID=" & FOLIO
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<row>OK</row>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelSeccion()
	query = "DELETE FROM SECCIONES WHERE CODIGO='" & CODIGO & " ' AND FAENA ='" & FAENA & "'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function delTipoParada()
	query = "DELETE FROM TIPO_PARADAS WHERE ID=" & ID 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

