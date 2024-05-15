<%
Class DBConn
Public Conexion
Private  RS

Private Sub Class_Initialize()
	Dim RemotePath
    Set Conexion = Server.CreateObject("ADODB.Connection")
	
	'DSNName ="Provider=SQLOLEDB;Initial Catalog=SCI_TBR;Data Source=190.96.94.145;User Id=SCI_TBR;Password=vanessa1974.;"
	
	DSNName ="Provider=SQLOLEDB;Initial Catalog=durex;Data Source=190.96.94.145;User Id=durex;Password=calama2014.;"
	
   	Conexion.Open DSNName
	
	'******************************'
	Set RS = Server.CreateObject("ADODB.Recordset")
	'RS.Open sql, Conexion, 3, 3
	Set RS = Conexion.Execute("SET DATEFORMAT dmy")
	
End Sub

Private Sub Class_Terminate()
    If IsObject(RS) then
      Set RS = Nothing
    End If
    If IsObject(Conexion) then
      Set Conexion = Nothing
    End If
End Sub
  
Public Function EjecutaSql(Sql) 
	On Error Resume Next
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open Sql, Conexion, 3, 3
	'Set RS = Conexion.Execute(Sql)'
    Set EjecutaSql = RS
	If Err.number <>0 then
		Response.Write "ERROR " ' Sql &  VbCrLf 
     	Response.Write Err.Description & VbCrLf 
		Response.Flush
	End if
 	On Error Goto 0
End Function

End Class

Dim query, ID
Dim oDB
Set oDB = New DBConn

query = "SELECT top 1 PASSWORD, AREA, UPDATE_PASS, ROL, isnull(UBICACION,'SG-SCM') FROM USUARIOS WHERE " 
query = query & " ESTADO='ACTIVO'"
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<t>conexion realizada</t>"
	
	
%>