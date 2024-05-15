<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
CODIGO=UCASE(REQUEST("CODIGO"))
ID=UCASE(REQUEST("ID"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))

select case RECURSO
	case "listCiudades"
		listCiudades()
		
	case "newCiudad"
		newCiudad()
		
	case "delCiudad"
		  delCiudad()
		
		
end select

function listCiudades()
	query = "SELECT ID, DESCRIPCION FROM SCI.dbo.CIUDADES" 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function delCiudad()
	query = "DELETE FROM SCI.DBO.CIUDADES WHERE ID='" & ID & "' "
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function newCiudad()

	query = "INSERT INTO SCI.DBO.CIUDADES (ID, DESCRIPCION)"
	query = query & " VALUES ("
	query = query & strNvl(ID) & "," 
	query = query & strNvl(DESCRIPCION) & ")"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

%>

