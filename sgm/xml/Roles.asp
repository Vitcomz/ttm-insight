<!--#include file="../standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ID=UCASE(REQUEST("ID"))
RECURSO=REQUEST("RECURSO")
NOMBRE=REQUEST("NOMBRE")
COD_ROL=REQUEST("COD_ROL")
COD_MENU=REQUEST("COD_MENU")

select case RECURSO
	case "GetRol" 
	 	GetRol() 
	case "UpdateRol" 
	 	UpdateRol()
	case "InsertRol" 
	 	InsertRol()
	case "DeleteRol"
		DeleteRol()
	case "ListRol"
	 	ListRol()
	case "ListMenuRol"
		ListMenuRol()
	case "NewMenuRol"
		NewMenuRol()
end select

function ListMenuRol()
	query = "SELECT MR.COD_MENU, M.NOMBRE FROM MENUROL MR, MENU M "
	query = query & " WHERE MR.COD_MENU=M.CODIGO AND MR.COD_ROL ='" & COD_ROL & "' "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<COD_MENU>" & ORs.Fields.Item(1).Value & "</COD_MENU>"
	  Response.Write "<COD_ROL>" & ORs.Fields.Item(0).Value & "</COD_ROL>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListRol()
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

function GetRol()
	query = "SELECT ID, NOMBRE FROM ROLES WHERE ID= '" & ID & "'" 
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

function UpdateRol()
	query = "UPDATE ROLES  SET NOMBRE = '" & NOMBRE & "' WHERE ID = '" & ID & "' "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InsertRol()
	query = "INSERT INTO ROLES (ID, NOMBRE) VALUES ('" & ID & "','" & NOMBRE & "')"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewMenuRol()
	query = "INSERT INTO MENUROL (COD_MENU, COD_ROL) VALUES ('" & COD_MENU & "','" & COD_ROL & "')"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DeleteRol()
	query = "DELETE FROM ROLES WHERE ID='" & ID & " ' "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

%>

