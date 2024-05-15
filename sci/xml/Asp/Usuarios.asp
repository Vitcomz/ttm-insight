<!--#include file="../../standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ID=UCASE(REQUEST("ID"))
PASSWORD=REQUEST("PASSWORD")
RUT=REQUEST("RUT")
NOMBRES=REQUEST("NOMBRES")
APELLIDOS=REQUEST("APELLIDOS")
ESTADO=REQUEST("ESTADO")
FECHA=REQUEST("FECHA")
EMAIL=REQUEST("EMAIL")
FONO=REQUEST("FONO")
CELULAR=REQUEST("CELULAR")
AREA=REQUEST("AREA")
LUGAR=REQUEST("LUGAR")
CARGO=REQUEST("CARGO")
ROLES=REQUEST("ROLES")
RECURSO=REQUEST("RECURSO")

select case RECURSO
	case "GetUsuario"
		GetUsuario()
	case "ListUsuario"
		ListUsuario()
	case "NewUsuario"
		NewUsuario
	case "UpdateUsuario"
		UpdateUsuario
	case "ListRoles"
		ListRoles()
	case "ValidaPass" 
	 	ValidaPass() 
end select

function ValidaPass() 

	query = "SELECT PASSWORD FROM USUARIOS WHERE ID ='" & ID & "'"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	If Not ORs.EOF Then
		  	If ORs.Fields.Item(0).Value  = PASSWORD Then
				  Response.Write "<ROW>True</ROW>"
			Else
				  Response.Write "<ROW>False</ROW>"
			End If
	End If
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewUsuario()
	query = "insert into usuarios (id, rut, nombres, apellidos, estado, cargo, rol, e_mail, ip, fono, celular, area, userdate) VALUES ('"
	query = query & ID & "','" & RUT & "','" & NOMBRES & "','" & APELLIDOS & "', 'ACTIVO','" & CARGO & "','" & ROLES & "','" & EMAIL & "','" & LUGAR & "','" & FONO & "','" & CELULAR & "','" & AREA & "','" & FECHA & "');"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ListUsuario()
	query = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO, ROL, E_MAIL, IP, FONO, CELULAR, AREA, USERDATE FROM USUARIOS "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<RUT>" & ORs.Fields.Item(1).Value & "</RUT>"
	  Response.Write "<NOMBRES>" & ORs.Fields.Item(2).Value & "</NOMBRES>"
	  Response.Write "<APELLIDOS>" & ORs.Fields.Item(3).Value & "</APELLIDOS>"
	  Response.Write "<ESTADO>" & ORs.Fields.Item(4).Value & "</ESTADO>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(5).Value & "</CARGO>"
	  Response.Write "<ROLES>" & ORs.Fields.Item(6).Value & "</ROLES>"
	  Response.Write "<EMAIL>" & ORs.Fields.Item(7).Value & "</EMAIL>"
	  Response.Write "<IP>" & ORs.Fields.Item(8).Value & "</IP>"
	  Response.Write "<FECHA>" & ORs.Fields.Item(9).Value & "</FECHA>"
	  Response.Write "<FONO>" & ORs.Fields.Item(10).Value & "</FONO>"
	  Response.Write "<CELULAR>" & ORs.Fields.Item(11).Value & "</CELULAR>"
	  Response.Write "<AREA>" & ORs.Fields.Item(12).Value & "</AREA>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function GetUsuario()
	query = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO, ROL, E_MAIL, IP, FONO, CELULAR, AREA, USERDATE FROM USUARIOS WHERE ID='" & ID & "'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<RUT>" & ORs.Fields.Item(1).Value & "</RUT>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(2).Value & "</NOMBRES>"
		  Response.Write "<APELLIDOS>" & ORs.Fields.Item(3).Value & "</APELLIDOS>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(4).Value & "</ESTADO>"
		  Response.Write "<CARGO>" & ORs.Fields.Item(5).Value & "</CARGO>"
		  Response.Write "<ROLES>" & ORs.Fields.Item(6).Value & "</ROLES>"
		  Response.Write "<EMAIL>" & ORs.Fields.Item(7).Value & "</EMAIL>"
		  Response.Write "<LUGAR>" & ORs.Fields.Item(8).Value & "</LUGAR>" 
		  Response.Write "<FONO>" & ORs.Fields.Item(9).Value & "</FONO>"
		  Response.Write "<CELULAR>" & ORs.Fields.Item(10).Value & "</CELULAR>"
		  Response.Write "<AREA>" & ORs.Fields.Item(11).Value & "</AREA>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(12).Value & "</FECHA>" 
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateUsuario()
	query = "UPDATE USUARIOS SET RUT = '" & RUT & "',"
	query = query & "NOMBRES='" & NOMBRES & "',"
	query = query & "APELLIDOS='" & APELLIDOS & "',"
	query = query & "ESTADO='" & ESTADO & "', "
	query = query & "CARGO='" & CARGO & "',"
	query = query & "ROL='" & ROLES & "', "
	query = query & "E_MAIL='" & EMAIL & "', "
	query = query & "IP='" & LUGAR & "',"
	query = query & "FONO='" & FONO & "', "
	query = query & "CELULAR='" & CELULAR & "', "
	query = query & "AREA='" & AREA & "',"
	query = query & "USERDATE='" & FECHA & "' "
	query = query & "WHERE ID='" & ID & "'" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListRoles()
	query = "SELECT ID, NOMBRE FROM ROLES "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function
%>

