<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
RECURSO=REQUEST("RECURSO")
NOMBRE=UCASE(REQUEST("NOMBRE"))
FAENA=REQUEST("FAENA")
PLANTA=REQUEST("PLANTA")
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))

Select case RECURSO
	case "GetSeccion" 
	 	GetSeccion() 
		
	case "UpdateSeccion" 
	 	UpdateSeccion()
		
	case "newSeccion" 
	 	newSeccion()
		
	case "delSeccion"
		  delSeccion()
		
	case "listSecciones"
	 	listSecciones()
		
	case "listSeccionesEquipos"
	 	listSeccionesEquipos()
		
End Select


function listSecciones()

	query = "SELECT CODIGO, DESCRIPCION, PLANTA, SECUENCIA, FAENA FROM SECCIONES "
	'query = query & " WHERE FAENA='" & FAENA & "'"
	query = query & " ORDER BY SECUENCIA " 
	
	'exit function 
	Set ORs =oDB.EjecutaSql(query)
	Response.AddHeader "Content-Type", "text/xml; charset=iso-8859-1"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "<PLANTA>" & ORs.Fields.Item(2).Value & "</PLANTA>"
	  Response.Write "<SECUENCIA>" & ORs.Fields.Item(3).Value & "</SECUENCIA>"
	  Response.Write "<FAENA>" & ORs.Fields.Item(4).Value & "</FAENA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listSeccionesEquipos()

	query = "SELECT DISTINCT E.SECCION, S.DESCRIPCION, S.SECUENCIA "
	query = query & "FROM EQUIPOS AS E "
	query = query & " LEFT OUTER JOIN SECCIONES AS S ON E.SECCION=S.CODIGO AND S.FAENA=" & strNvl(FAENA) 
	query = query & " WHERE E.UBICACION='" & FAENA & "'"
	query = query & "  AND E.SECCION IS NOT NULL "
	query = query & " ORDER BY S.SECUENCIA "
	
	'exit function 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
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

function UpdateSeccion()
	query = "UPDATE SECCIONES SET DESCRIPCION = '" & DESCRIPCION & "' WHERE CODIGO = '" & CODIGO & "' "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewSeccion()

	query = "INSERT INTO SECCIONES (CODIGO, DESCRIPCION, FAENA) VALUES ('" & CODIGO & "','"
	query = query  & DESCRIPCION & "','" 
	query = query  & FAENA & "')"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function delSeccion()
	query = "DELETE FROM SECCIONES WHERE CODIGO='" & CODIGO & " ' AND FAENA ='" & FAENA & "'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

