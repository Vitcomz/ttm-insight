<!--#include file="../../standard/DBConn.asp" -->
<%

Dim oDB, ORs
Set oDB = New DBConn
Dim query, CODIGO 

RECURSO=REQUEST("RECURSO")
CODIGO=UCASE(REQUEST("CODIGO"))
SISTEMA=UCASE(REQUEST("SISTEMA"))
COD_MENU_PADRE=UCASE(REQUEST("COD_MENU_PADRE"))
NOMBRE=REQUEST("NOMBRE")
LINK=REQUEST("LINK")
TARGET=REQUEST("TARGET")
ORDEN=REQUEST("ORDEN")
USERNAME=REQUEST("USERNAME")
USERDATE=REQUEST("USERDATE")
	
select case RECURSO
	case "DelMenu"
		DelMenu()
	case "UpdateMenu"
		UpdateMenu
	case "NewMenu"
		NewMenu()
	case "GetMenu"
		GetMenu()
	case "ListMenu"
		ListMenu()
		
end select

function ListMenu()
	query = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE, ORDEN "
	query = query & " FROM MENU WHERE SISTEMA='" & SISTEMA & "' ORDER BY ORDEN"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<COD_MENU_PADRE>" & ORs.Fields.Item(1).Value & "</COD_MENU_PADRE>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<LINK>" & ORs.Fields.Item(3).Value & "</LINK>"
		  Response.Write "<TARGET>" & ORs.Fields.Item(4).Value & "</TARGET>"
		  Response.Write "<SISTEMA>" & ORs.Fields.Item(5).Value & "</SISTEMA>"
		  Response.Write "<USERNAME>" & ORs.Fields.Item(6).Value & "</USERNAME>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>" 
  		  Response.Write "<ORDEN>" & ORs.Fields.Item(8).Value & "</ORDEN>" 
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelMenu()
	query = "DELETE FROM MENU WHERE CODIGO = '" & CODIGO & "'"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetMenu()
	query = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE, ORDEN " 
	query = query & "FROM MENU WHERE CODIGO='" & CODIGO & "'"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<COD_MENU_PADRE>" & ORs.Fields.Item(1).Value & "</COD_MENU_PADRE>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<LINK>" & ORs.Fields.Item(3).Value & "</LINK>"
		  Response.Write "<TARGET>" & ORs.Fields.Item(4).Value & "</TARGET>"
		  Response.Write "<SISTEMA>" & ORs.Fields.Item(5).Value & "</SISTEMA>"
		  Response.Write "<USERNAME>" & ORs.Fields.Item(6).Value & "</USERNAME>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>" 
  		  Response.Write "<ORDEN>" & ORs.Fields.Item(8).Value & "</ORDEN>" 
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewMenu()
	query = "INSERT INTO MENU (CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE) VALUES ('"
	query = query & CODIGO & "','" & COD_MENU_PADRE & " ','" & NOMBRE & " ','" & LINK & " ','" & TARGET &" ','" & SISTEMA & "','" & USERNAME & " ', date() & ' '& time());"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateMenu()
	query = "UPDATE MENU SET "
	query = query & "COD_MENU_PADRE='" & COD_MENU_PADRE & " ',"
	query = query & "NOMBRE='" & NOMBRE & " ',"
	query = query & "LINK='" & LINK & " ',"
	query = query & "TARGET='" & TARGET & " ',"
	query = query & "USERNAME='DESARROLLO',"
	query = query & "USERDATE=DATE() & ' ' & TIME()"
	If Len(ORDEN) <> 0 Then  query = query & ",ORDEN = " & ORDEN & " " End If
	query = query & "WHERE CODIGO='" & CODIGO & "'"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

%>

