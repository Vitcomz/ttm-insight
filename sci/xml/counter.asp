<!--#include file="../standard/DBConn.asp" -->

<%

Dim oDB, ORs
Set oDB = New DBConn
Dim query, CODIGO 

   

RECURSO=REQUEST("RECURSO")
REFERRER=REPLACE(REQUEST("R"),"&","_")
SISTEMA=UCASE(REQUEST("S"))
AGENT=UCASE(REQUEST("A"))
LOCATION=REQUEST("L")
IP= Request.ServerVariables("REMOTE_ADDR") 
HOSTNAME= Request.ServerVariables("REMOTE_HOST") 

OS=REQUEST("P")

USERNAME=REQUEST("USERNAME")
USERDATE=REQUEST("USERDATE")

Select case RECURSO
	case "NewCount"
		NewCount()
		
	case "UpdateSistema"
		UpdateSistema()
		
	case "GetSistema"
		GetSistema()
		
	case "ListCount"
		ListCount
End select

Function NewCount()
	
	query = "INSERT INTO COUNT (SISTEMA, REFERRER, AGENT,"
	query = query & "LOCATION, IP, HOSTNAME, OS, USERDATE) VALUES ("
	query = query & strNvl(SISTEMA) & ","
	query = query & strNvl(REFERRER) & "," 
	query = query & strNvl(AGENT) & "," 
	query = query & strNvl(LOCATION) & "," 
	query = query & strNvl(IP) & "," 
	query = query & strNvl(HOSTNAME) & "," 
	query = query & strNvl(OS) & "," 
	query = query & "GETDATE());"
	
	Set ORs =oDB.EjecutaSql(query)
	Set ORs = Nothing
	Set ODB = Nothing

End Function

Function ListCount()
	
	query = "SELECT SISTEMA, REFERRER, AGENT,"
	query = query & "LOCATION, IP, HOSTNAME, OS, USERDATE FROM COUNT "
	
	If LEN(SISTEMA)>0 Then
		query = query & " WHERE SISTEMA=" & strNvl(SISTEMA)
	End If
	
	query = query & " ORDER BY USERDATE DESC"
	
	Set ORs =oDB.EjecutaSql(query)
Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	COUNT = 0
	While Not ORs.EOF 
	  COUNT = COUNT +1
	  Response.Write "<ROW>"
		  Response.Write "<ROWCOUNT>" & COUNT & "</ROWCOUNT>"
		  Response.Write "<SISTEMA>" & ORs.Fields.Item(0).Value & "</SISTEMA>"
		  Response.Write "<REFERRER>" & ORs.Fields.Item(1).Value & "</REFERRER>"
		  Response.Write "<AGENT>" & ORs.Fields.Item(2).Value & "</AGENT>"
		  Response.Write "<LOCATION>" & ORs.Fields.Item(3).Value & "</LOCATION>"
		  Response.Write "<IP>" & ORs.Fields.Item(4).Value & "</IP>"
		  Response.Write "<HOSTNAME>" & ORs.Fields.Item(5).Value & "</HOSTNAME>"
		  Response.Write "<OS>" & ORs.Fields.Item(6).Value & "</OS>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>"

	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

End Function

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

%>

