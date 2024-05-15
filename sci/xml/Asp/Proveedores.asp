<!--#include file="../../standard/DBConn.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn

DV=UCASE(REQUEST("DV"))
RUT=REQUEST("RUT")
NOMBRE=REQUEST("NOMBRE")
DIRECCION=REQUEST("DIRECCION")
OBSERVACION=REQUEST("OBSERVACION")
FONO=REQUEST("FONO")
CIUDAD=REQUEST("CIUDAD")
INDICE=REQUEST("INDICE")
FAX=REQUEST("FAX")
RECURSO=REQUEST("RECURSO")

select case RECURSO
	case "GetProv"
		GetProv()
	case "DelProv"
		DelProv()
	case "NewProv"
		NewProv()
	case "UpdateProv"
		UpdateProv()
	case "ListProv"
		ListProv()
end select

function NewProv()
	query = "INSERT INTO PROVEEDORES(RUT_PROVEEDOR, DV_PROVEEDOR, NOMBRE, DIRECCION, FONO, FAX, CIUDAD, OBSERVACION, IND_ACTIVACION, USERDATE) VALUES ("
	query = query & RUT & ",'" & DV & "','" & NOMBRE & "','" & DIRECCION & "','" & FONO & "','" & FAX & "','" & CIUDAD & "','" & OBSERVACION & "','" & INDICE & "',date() & ' '& time());"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function DelProv()
	query = "DELETE FROM PROVEEDORES WHERE RUT_PROVEEDOR="& RUT &""
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write"OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function GetProv()
	query = "SELECT RUT_PROVEEDOR, DV_PROVEEDOR, NOMBRE, DIRECCION, FONO, FAX, CIUDAD, OBSERVACION, IND_ACTIVACION FROM PROVEEDORES WHERE RUT_PROVEEDOR=" & RUT & "" 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<DV>" & ORs.Fields.Item(1).Value & "</DV>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(3).Value & "</DIRECCION>"
		  Response.Write "<FONO>" & ORs.Fields.Item(4).Value & "</FONO>"
		  Response.Write "<FAX>" & ORs.Fields.Item(5).Value & "</FAX>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(6).Value & "</CIUDAD>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(7).Value & "</OBSERVACION>"
		  Response.Write "<INDICE>" & ORs.Fields.Item(8).Value & "</INDICE>"
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateProv()
	query = "UPDATE PROVEEDORES SET DIRECCION='" & DIRECCION & "',"
	query = query & "CIUDAD='" & CIUDAD & "', "
	query = query & "NOMBRE='" & NOMBRE & "',"
	query = query & "FAX='" & FAX & "',"
	query = query & "OBSERVACION='" & OBSERVACION & "', "
	query = query & "FONO='" & FONO & "', "
	query = query & "IND_ACTIVACION='" & INDICE & "', "
	query = query & "USERDATE= date() & ' '& time() "
	query = query & "WHERE RUT_PROVEEDOR="& RUT & "" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListProv()
	query = "SELECT RUT_PROVEEDOR, DV_PROVEEDOR, NOMBRE, DIRECCION, FONO, FAX, CIUDAD, OBSERVACION, IND_ACTIVACION FROM PROVEEDORES"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(3).Value & "</DIRECCION>"
		  Response.Write "<FONO>" & ORs.Fields.Item(4).Value & "</FONO>"
		  Response.Write "<FAX>" & ORs.Fields.Item(5).Value & "</FAX>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(6).Value & "</CIUDAD>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(7).Value & "</OBSERVACION>"
		  Response.Write "<INDICE>" & ORs.Fields.Item(8).Value & "</INDICE>"
		  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

%>

