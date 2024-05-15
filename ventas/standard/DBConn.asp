<%
Class DBConn
Private Conexion
Private  RS

Private Sub Class_Initialize()
	Dim RemotePath
    Set Conexion = Server.CreateObject("ADODB.Connection")	
	'DSNName ="Provider=SQLOLEDB;Initial Catalog=SCI;Data Source=TTM-HSANDOVAL;User Id=jrojas;Password=SyNaPtIc6532;"
	DSNName ="Provider=SQLOLEDB;Initial Catalog=SCI;Data Source=72.18.135.49,1533;User Id=jrojas;Password=SyNaPtIc6532;"
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

End Class
%>

