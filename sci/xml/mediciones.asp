<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
FOLIO=UCASE(REQUEST("FOLIO"))
FECHA=UCASE(REQUEST("FECHA"))
FAENA=UCASE(REQUEST("FAENA"))
FECHA_CAMBIO=UCASE(REQUEST("FECHA"))
FECHA_ULT_MAN=UCASE(REQUEST("FECHA_ULT_MAN"))
DIAS_PROY=UCASE(REQUEST("DIAS_PROY"))

EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
AREA=UCASE(REQUEST("AREA"))
RUT=UCASE(REQUEST("RUT"))
DISCIPLINA=UCASE(REQUEST("DISCIPLINA"))
DIAS_OPERACION=UCASE(REQUEST("DIAS_OPERACION"))

EDAD=UCASE(REQUEST("EDAD"))
INSPECTOR=UCASE(REQUEST("INSPECTOR"))

SECCION=UCASE(REQUEST("SECCION"))
SUCURSAL=UCASE(REQUEST("SUCURSAL"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
TURNO=UCASE(REQUEST("TURNO"))
MES=UCASE(REQUEST("MES"))
MUESTREO=UCASE(REQUEST("MUESTREO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
VALOR=UCASE(REQUEST("VALOR"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))



Select Case RECURSO

	case "getMedicion"
		  getMedicion()
	
	case "updateMedicion"
		  updateMedicion()
	
	case "newMedicion"
		  newMedicion()
		  
	case "newMedValor"
		  newMedValor()
		  
	case "listMediciones"
		  listMediciones()
	
	case "listMedValor"
		  listMedValor()

	case "listComp"
		  listComp()
		  	  
	case "delMedValor"
		  delMedValor()	 	  	  
	
	case "delMedicion"
		  delMedicion()	
		  
end select

function getMedicion()

	query = "SELECT M.FOLIO, M.FECHA , M.EQUIPO, E.DESCRIPCION, M.INSPECTOR, M.FECHA_CAMBIO, "
	query = query & " M.DURACION, M.FECHA_ULTM_MANTENCION, E.ANCHO, E.ESPESOR " 
	query = query & " FROM MEDICIONES AS M, EQUIPOS AS E "
	query = query & " WHERE E.CODIGO = M.FOLIO "
	query = query & " AND FOLIO=" & strNvl(FOLIO) 
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	
	Response.Write "<REGISTRO>"
		
	While Not Rs.EOF 
		Response.Write "<ROW>"
		 Response.Write "<FOLIO>" & Rs.Fields.Item(0).Value & "</FOLIO>"
		 Response.Write "<FECHA>" & Rs.Fields.Item(1).Value & "</FECHA>"
		 Response.Write "<CODIGO>" & Rs.Fields.Item(2).Value & "</CODIGO>"
		 Response.Write "<DESCRIPCION>" & Rs.Fields.Item(3).Value & "</DESCRIPCION>"
		 Response.Write "<INSPECTOR>" & Rs.Fields.Item(4).Value & "</INSPECTOR>"
		 Response.Write "<FECHA_CAMBIO>" & Rs.Fields.Item(5).Value & "</FECHA_CAMBIO>"
		 Response.Write "<DIAS_PROY>" & Rs.Fields.Item(6).Value & "</DIAS_PROY>"
		 Response.Write "<FECHA_ULT_MAN>" & Rs.Fields.Item(7).Value & "</FECHA_ULT_MAN>"
		 Response.Write "<ANCHO>" & Rs.Fields.Item(8).Value & "</ANCHO>"
		 Response.Write "<ESPESOR>" & Rs.Fields.Item(8).Value & "</ESPESOR>"
		 Response.Write "</ROW>"
		 Rs.MoveNext
	Wend
	
	Response.Write "</REGISTRO>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function newMedicion()

	query = "SELECT MAX(FOLIO) AS NUM FROM MEDICIONES "

	Set ORs =oDB.EjecutaSql(query)

	If Len(oRs("NUM"))>0 Then
		N = oRs("NUM") + 1
	Else
		N = 1
	End If
	 
	query = "INSERT INTO MEDICIONES (FOLIO, FECHA, EQUIPO, INSPECTOR, DIAS_OPERACION, "
	query = query & "FECHA_ULTM_MANTENCION, FECHA_CAMBIO, DIAS_PROY, FAENA) VALUES" 
	query = query & " (" & N
	query = query & " ," & strNvl(FECHA)
	query = query & " ," & strNvl(EQUIPO)
	query = query & " ," & strNvl(INSPECTOR)
	query = query & " ," & strNvl(DIAS_OPERACION)
	query = query & " ," & strNvl(FECHA_ULT_MAN)
	query = query & " ," & strNvl(FECHA_CAMBIO)
	query = query & " ," & strNvl(DIAS_PROY)
	query = query & " ," & strNvl(FAENA) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><FOLIO>" & N & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateMedicion()

	query = "UPDATE OBSERVACIONES SET " 
	query = query & " NOMBRE=" & strNvl(NOMBRE)
	query = query & " ,RUT=" & strNvl(RUT)
	query = query & " ,FECHA=" & strNvl(FECHA)
	query = query & " ,AREA=" & strNvl(AREA)
	query = query & " ,EDAD=" & strNvl(EDAD)
	query = query & " ,DISCIPLINA=" & strNvl(DISCIPLINA)
	query = query & " WHERE FOLIO=" & strNvl(FOLIO)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><FOLIO>" & FOLIO & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function newMedValor()

	Dim aMuestreo
	
	aMuestreo = Split(MUESTREO, ";")

	i=1
	
	While i<=ubound(aMuestreo) 
		 
			query = "INSERT INTO MEDICIONES_VALOR (" 
			query = query & " FOLIO, "
			query = query & " ID, VALOR) "
			query = query & " VALUES ("
			query = query & strNvl(FOLIO) & ","
			query = query & strNvl(i) & ","
			query = query & strNvl(aMuestreo(i)) & ")"
	
			Set ORs =oDB.EjecutaSql(query)
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend

	
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function listMediciones()

query =	" SELECT FOLIO, FECHA, INSPECTOR "
query = query  & " FROM MEDICIONES "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<INSPECTOR>" & ORs.Fields.Item(2).Value & "</INSPECTOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listMedValor()

	query = "SELECT ID, VALOR "
	query = query & " FROM MEDICIONES_VALOR "
	query = query & " ORDER BY ID "
	 
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"	
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID> "  & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End function
		 
function delMedValor()
	query = "DELETE MEDICIONES_VALOR WHERE FOLIO = " & strNvl(FOLIO) 
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function grComp()

query =	" SELECT C.CATEGORIA,"
query = query & "		   S = SUM(CASE CF.VALOR WHEN 'S' THEN 1 END),"
query = query & "		   R = SUM(CASE CF.VALOR WHEN 'R' THEN 1 END),"
query = query & "		   COUNT(*) "
query = query & "	 FROM COMPORTAMIENTOS AS C, "
query = query & "		COMP_FOLIO AS CF"
query = query & "	WHERE C.ID=CF.ID"
query = query & "	GROUP BY C.CATEGORIA "
	Set ORs = oDB.EjecutaSql(query)
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Comportamientos' shownames='1'  numDivLines='10'  bgColor='FFFFFF' showBorder='0' anchorRadius='5' anchorBorderThickness='2'>"
	Response.Write "<categories verticalLineThickness='1'>"
	While Not ORs.EOF 
		Response.Write "<category  label='" & ORs.Fields.Item(0).Value & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Seguro'  showValues='1' >" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(1).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Riesgoso'  showValues='1' >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(2).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listComp()

query =	" SELECT C.CATEGORIA,"
query = query & "		   S = SUM(CASE CF.VALOR WHEN 'S' THEN 1 END),"
query = query & "		   R = SUM(CASE CF.VALOR WHEN 'R' THEN 1 END),"
query = query & "		   N = SUM(CASE CF.VALOR WHEN 'N' THEN 1 END),"
query = query & "		   COUNT(*) "
query = query & "	 FROM COMPORTAMIENTOS AS C, "
query = query & "		COMP_FOLIO AS CF, OBSERVACIONES AS O"
query = query & "	WHERE C.ID=CF.ID"
query = query & "	AND CF.FOLIO=O.FOLIO"  
query = query & "	AND MONTH(O.FECHA)=" & strNvl(MES) 
query = query & "	GROUP BY C.CATEGORIA"
	
Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"	
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	 'Response.Write "<ID>" & ORs.Fields.Item(5).Value & "</ID>"
	  	  Response.Write "<CATEGORIA> "  & ORs.Fields.Item(0).Value & "</CATEGORIA>"
		  Response.Write "<SEGURO>" & ORs.Fields.Item(1).Value & "</SEGURO>"
		  Response.Write "<RIESGOSO>" & ORs.Fields.Item(2).Value & "</RIESGOSO>"
		  Response.Write "<NUNCA>" & ORs.Fields.Item(3).Value & "</NUNCA>"
		  Response.Write "<TOTAL>" & ORs.Fields.Item(4).Value & "</TOTAL>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function numNvl(Valor)
	if isNull(Valor) then
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

