<%
Class DBConn
Public Conexion
Private  RS

Private Sub Class_Initialize()
	Dim RemotePath
    Set Conexion = Server.CreateObject("ADODB.Connection")	
	'DSNName ="Provider=SQLOLEDB;Initial Catalog=TTMDATA;Data Source=TTM-HSANDOVAL;User Id=existencias;Password=SyNaPtIc6532;"
	DSNName ="Provider=SQLOLEDB;Initial Catalog=TTMDATA;Data Source=72.18.135.49,1533;User Id=existencias;Password=SyNaPtIc6532;"
   	Conexion.Open DSNName
	'******************************'

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
	'RS.Open sql, Conexion, 3, 3
	Set RS = Conexion.Execute(Sql)'
    Set EjecutaSql = RS
	If Err.number <>0 then
		Response.Write Sql &  VbCrLf 
     	Response.Write Err.Description & VbCrLf 
		Response.Flush
	End if
 	On Error Goto 0
End Function

Public Function GetMailServer() 
	On Error Resume Next
	Set ORs = Server.CreateObject("ADODB.Recordset")
	'RS.Open sql, Conexion, 3, 3
	Sql = "SELECT MAIL_SERVER FROM PARAMETROS"
	Set ORs = Conexion.Execute(Sql)
     GetMailServer = ORs.Fields.Item(0).Value
	If Err.number <>0 then
		Response.Write Sql &  VbCrLf 
     	Response.Write Err.Description & VbCrLf 
		Response.Flush
	End if
	Set ORs = nothing
 	On Error Goto 0
End Function

Public Function GetMailAdquisiciones() 
	On Error Resume Next
	Set ORs = Server.CreateObject("ADODB.Recordset")
	'RS.Open sql, Conexion, 3, 3
	Sql = "SELECT MAIL_ADQUI FROM PARAMETROS"
	Set ORs = Conexion.Execute(Sql)'
    GetMailAdquisiciones = ORs.Fields.Item(0).Value
	If Err.number <>0 then
		Response.Write Sql &  VbCrLf 
     	Response.Write Err.Description & VbCrLf 
		Response.Flush
	End if
	Set ORs = nothing
 	On Error Goto 0
End Function

Public Function GetMailConta() 
	On Error Resume Next
	Set ORs = Server.CreateObject("ADODB.Recordset")
	'RS.Open sql, Conexion, 3, 3
	Sql = "SELECT MAIL_CONTA FROM PARAMETROS"
	Set ORs = Conexion.Execute(Sql)'
    GetMailAdquisiciones = ORs.Fields.Item(0).Value
	If Err.number <>0 then
		Response.Write Sql &  VbCrLf 
     	Response.Write Err.Description & VbCrLf 
		Response.Flush
	End if
	Set ORs = nothing
 	On Error Goto 0
End Function

Public Function GetMailAdress(User) 
	On Error Resume Next
	Set ORs = Server.CreateObject("ADODB.Recordset")
	'RS.Open sql, Conexion, 3, 3
	Sql = "SELECT E_MAIL FROM SCI.DBO.USUARIOS WHERE ID ='" & UCASE(User) & "'"
	Set ORs = Conexion.Execute(Sql)'
    GetMailAdress = ORs.Fields.Item(0).Value
	If Err.number <>0 then
		Response.Write Sql &  VbCrLf 
     	Response.Write Err.Description & VbCrLf 
		Response.Flush
	End if
	Set ORs = nothing
 	On Error Goto 0
End Function

End Class

%>

