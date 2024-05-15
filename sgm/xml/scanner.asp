<!--#include file="../standard/DBConnScanner.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

CODIGO=UCASE(REQUEST("CODIGO"))
COMPONENTE=UCASE(REQUEST("COMPONENTE"))

RECURSO=REQUEST("RECURSO")
ID=REQUEST("ID")
FECHA=REQUEST("FECHA")
EQUIPO=REQUEST("EQUIPO")
SECCION=REQUEST("SECCION")
EXCEL=REQUEST("EXCEL")
FAENA=REQUEST("FAENA")
ID1=REQUEST("ID1")
ID2=REQUEST("ID2")
ID3=REQUEST("ID3")
ID4=REQUEST("ID4")
eq=REQUEST("eq")
emp=REQUEST("emp")
canal=REQUEST("canal")
seg=REQUEST("SEG")

Select case RECURSO
	case "GetSeccion" 
	 	  GetSeccion() 
	
	case "GetAmplitud" 
	 	  GetAmplitud() 
	
	case "getParada" 
	 	  getParada()
		  	  
	case "listScanner"
	 	  listScanner()
	
End Select



function listScanner()


	query = "SELECT "
	if EQUIPO <> "TOD" and  FECHA <> "" then 
		query = query & " top 50 "
	end if
	query = query & " DATA_SCANNER.ID_SCANNER, DATA_SCANNER.FECHA, DATA_SCANNER.EQUIPO, DATA_SCANNER.FAENA, SCANNER.COMENT FROM DATA_SCANNER INNER JOIN SCANNER ON DATA_SCANNER.ID_SCANNER = SCANNER.ID "
	query = query & " WHERE "

	query = query & " DATA_SCANNER.FAENA = " & strNvl(FAENA)

	IF EQUIPO <> "TOD" THEN
		query = query & " AND DATA_SCANNER.EQUIPO = " & strNvl(EQUIPO)
	END IF

	IF FECHA <> "" THEN
		query = query & " AND Convert(varchar(10), FECHA, 103)=" & strNvl(FECHA) 
	END IF

	query = query & " group by DATA_SCANNER.ID_SCANNER, DATA_SCANNER.FECHA, DATA_SCANNER.EQUIPO, DATA_SCANNER.FAENA, SCANNER.COMENT "
	query = query & " ORDER BY CONVERT(DATETIME,FECHA,103) "
	'response.Write query
	'response.end
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
	  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
	  Response.Write "<FECHASHORT>" & replace(replace(ORs.Fields.Item(1).Value,"/","-")," ","$") & "</FECHASHORT>"
	  Response.Write "<EQUIPO>" & trim(ORs.Fields.Item(2).Value) & "</EQUIPO>"
	  Response.Write "<FAENA>" & ORs.Fields.Item(3).Value & "</FAENA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetAmplitud()
seg = ID1 & " " & ID2
if canal = "-1" then
		if (ID2 - ID1) < 7 then
			query2 = "SELECT SEGUNDOS, left((SELECT MAX(columnx) FROM ( VALUES(CH1),(CH2),(CH3),(CH4),(CH5),(CH6),(CH7),(CH8)) AS UNIQUECOLUMN(columnx)),4) AS DANOS FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & ID3 & "%'  and Convert(varchar(8), FECHA, 108) like '%" & ID4 & "%'"
			if eq <> "" and eq <> "undefined" then
				query2 =  query2 & " and EQUIPO = '" & eq & "' "
			end if
			if emp <> "" and emp <> "undefined" then
				query2 = query2 & " and FAENA= '" & emp & "' "
			end if
			if seg <> "" and seg <> "undefined" then
				query2 = query2 & " and segundos between " &ID1& " and " &ID2&  " "
			else
				query2 = query2 & " and segundos between 0 and 30 "
			end if
			query2 = query2 & " order by SEGUNDOS "
		elseif ((ID2 - ID1) >= 7) and ((ID2 - ID1) <= 16) then
			query2 = "SELECT SEGUNDOS,MAX(DANOS) FROM(SELECT convert(decimal(5,1),round(SEGUNDOS,1)) AS SEGUNDOS, left((SELECT MAX(columnx) FROM ( VALUES(CH1),(CH2),(CH3),(CH4),(CH5),(CH6),(CH7),(CH8)) AS UNIQUECOLUMN(columnx)),4) AS DANOS  FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & ID3 & "%'  and Convert(varchar(8), FECHA, 108) like '%" & ID4 & "%'"
			if eq <> "" and eq <> "undefined" then
				query2 =  query2 & " and EQUIPO = '" & eq & "' "
			end if
			if emp <> "" and emp <> "undefined" then
				query2 = query2 & " and FAENA= '" & emp & "' "
			end if
			if seg <> "" and seg <> "undefined" then
				query2 = query2 & " and segundos between " &ID1& " and " &ID2&  " "
			else
				query2 = query2 & " and segundos between 0 and 30 "
			end if
			query2 = query2 & " ) AS A GROUP BY SEGUNDOS Order by SEGUNDOS  "		
		elseif ((ID2 - ID1) > 16) then
			query2 = "SELECT SEGUNDOS,MAX(DANOS) FROM(SELECT convert(decimal(5,0),round(SEGUNDOS,0)) AS SEGUNDOS, left((SELECT MAX(columnx) FROM ( VALUES(CH1),(CH2),(CH3),(CH4),(CH5),(CH6),(CH7),(CH8)) AS UNIQUECOLUMN(columnx)),4) AS DANOS  FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & ID3 & "%'  and Convert(varchar(8), FECHA, 108) like '%" & ID4 & "%'"
			if eq <> "" and eq <> "undefined" then
				query2 =  query2 & " and EQUIPO = '" & eq & "' "
			end if
			if emp <> "" and emp <> "undefined" then
				query2 = query2 & " and FAENA= '" & emp & "' "
			end if
			if seg <> "" and seg <> "undefined" then
				query2 = query2 & " and segundos between " &ID1& " and " &ID2&  " "
			else
				query2 = query2 & " and segundos between 0 and 30 "
			end if
			query2 = query2 & " ) AS A GROUP BY SEGUNDOS Order by SEGUNDOS  "
		end if
else
		if (ID2 - ID1) < 7 then
			query2 = "SELECT SEGUNDOS, left((SELECT MAX(columnx) FROM ( VALUES(CH" & canal & ")) AS UNIQUECOLUMN(columnx)),4) AS DANOS FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & ID3 & "%'  and Convert(varchar(8), FECHA, 108) like '%" & ID4 & "%'"
			if eq <> "" and eq <> "undefined" then
				query2 =  query2 & " and EQUIPO = '" & eq & "' "
			end if
			if emp <> "" and emp <> "undefined" then
				query2 = query2 & " and FAENA= '" & emp & "' "
			end if
			if seg <> "" and seg <> "undefined" then
				query2 = query2 & " and segundos between " &ID1& " and " &ID2&  " "
			else
				query2 = query2 & " and segundos between 0 and 30 "
			end if
			query2 = query2 & " order by SEGUNDOS "
		elseif ((ID2 - ID1) >= 7) and ((ID2 - ID1) <= 16) then
			query2 = "SELECT SEGUNDOS,MAX(DANOS) FROM(SELECT convert(decimal(5,1),round(SEGUNDOS,1)) AS SEGUNDOS, left((SELECT MAX(columnx) FROM ( VALUES(CH" & canal & ")) AS UNIQUECOLUMN(columnx)),4) AS DANOS  FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & ID3 & "%'  and Convert(varchar(8), FECHA, 108) like '%" & ID4 & "%'"
			if eq <> "" and eq <> "undefined" then
				query2 =  query2 & " and EQUIPO = '" & eq & "' "
			end if
			if emp <> "" and emp <> "undefined" then
				query2 = query2 & " and FAENA= '" & emp & "' "
			end if
			if seg <> "" and seg <> "undefined" then
				query2 = query2 & " and segundos between " &ID1& " and " &ID2&  " "
			else
				query2 = query2 & " and segundos between 0 and 30 "
			end if
			query2 = query2 & " ) AS A GROUP BY SEGUNDOS Order by SEGUNDOS  "		
		elseif ((ID2 - ID1) > 16) then
			query2 = "SELECT SEGUNDOS,MAX(DANOS) FROM(SELECT convert(decimal(5,0),round(SEGUNDOS,0)) AS SEGUNDOS, left((SELECT MAX(columnx) FROM ( VALUES(CH" & canal & ")) AS UNIQUECOLUMN(columnx)),4) AS DANOS  FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & ID3 & "%'  and Convert(varchar(8), FECHA, 108) like '%" & ID4 & "%'"
			if eq <> "" and eq <> "undefined" then
				query2 =  query2 & " and EQUIPO = '" & eq & "' "
			end if
			if emp <> "" and emp <> "undefined" then
				query2 = query2 & " and FAENA= '" & emp & "' "
			end if
			if seg <> "" and seg <> "undefined" then
				query2 = query2 & " and segundos between " &ID1& " and " &ID2&  " "
			else
				query2 = query2 & " and segundos between 0 and 30 "
			end if
			query2 = query2 & " ) AS A GROUP BY SEGUNDOS Order by SEGUNDOS  "		
		end if
end if		
		'response.write query2
		'response.end
		Set ORs2 =oDB.EjecutaSql(query2)
		lineas = 0
		arrdat2 = ""
		arrdat2 = arrdat2 &  "["
		While Not ORs2.EOF 
			arrdat2 = arrdat2 &  "[" & ORs2.Fields.Item(0).Value & "," & ORs2.Fields.Item(1).Value & "]," 
			lineas = lineas + 1		
			ORs2.MoveNext
		Wend
		'Response.ContentType = "text/html"
		response.write  left(arrdat2, len(arrdat2)-1) & "]"
		Set ORs2 = Nothing
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


function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

