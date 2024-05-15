<!--#include file="../standard/DBConn.asp" -->
<%

Dim oDB, ORs
Set oDB = New DBConn
Dim query, ID, AUTOR, NOMBRE, VERSION

ID=UCASE(REQUEST("ID"))
AUTOR=REQUEST("AUTOR")
NOMBRE=REQUEST("NOMBRE")
VERSION=REQUEST("VERSION")
DESCRIPCION=REQUEST("DESCRIPCION")
FECHA=REQUEST("FECHA")
BD=REQUEST("BD")
UBICACION=REQUEST("UBICACION")
RECURSO=REQUEST("RECURSO")
ESTADO=REQUEST("ESTADO")

select case RECURSO
	case "NewSistema"
		NewSistema()
	case "UpdateSistema"
		UpdateSistema()
	case "GetSistema"
		GetSistema()
	case "ListSistemas"
		ListSistemas
end select
		
function NewSistema()
	query = "INSERT INTO SISTEMAS (ID, NOMBRE, AUTOR, VERSION, ESTADO, DESCRIPCION, FECHA, BD, UBICACION) VALUES ('"
	query = query & ID & "','" & NOMBRE & "','" & AUTOR & "','" & VERSION & "', 'ACTIVO','" & DESCRIPCION & "','" & FECHA & "','" & BD & "','" & UBICACION & "');"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateSistema()
	query = "UPDATE SISTEMAS SET NOMBRE = '" & NOMBRE & "',"
	query = query & "VERSION='" & VERSION & "',"
	query = query & "AUTOR='" & AUTOR & "',"
	query = query & "ESTADO='" & ESTADO & "',"
	query = query & "DESCRIPCION='" & DESCRIPCION & "',"
	query = query & "FECHA='" & FECHA & "',"
	query = query & "BD='" & BD & "',"
	query = query & "UBICACION='" & UBICACION & "' "
	query = query & "WHERE ID='" & ID & "'"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetSistema
	query = "SELECT ID, AUTOR, NOMBRE, VERSION, DESCRIPCION, ESTADO, FECHA , BD, UBICACION " 
	query = query & "FROM SISTEMAS WHERE ID='" & ID & "'"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<AUTOR>" & ORs.Fields.Item(1).Value & "</AUTOR>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<VERSION>" & ORs.Fields.Item(3).Value & "</VERSION>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(6).Value & "</FECHA>"
		  Response.Write "<BD>" & ORs.Fields.Item(7).Value & "</BD>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(8).Value & "</UBICACION>"
		  
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListSistemas()
	query = "SELECT ID, NOMBRE, DESCRIPCION, VERSION, ESTADO,"
	query = query & " AUTOR, FECHA, BD, UBICACION FROM SISTEMAS WHERE ESTADO='ACTIVO'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<VERSION>" & ORs.Fields.Item(3).Value & "</VERSION>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(4).Value & "</ESTADO>"
		  Response.Write "<AUTOR>" & ORs.Fields.Item(5).Value & "</AUTOR>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(6).Value & "</FECHA>"
		  Response.Write "<BD>" & ORs.Fields.Item(7).Value & "</BD>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(8).Value & "</UBICACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

%>

