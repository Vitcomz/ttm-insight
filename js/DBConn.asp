<%
Class DBConn
Public Conexion
Private  RS

Private Sub Class_Initialize()
	Dim RemotePath
    Set Conexion = Server.CreateObject("ADODB.Connection")

	DSNName ="Provider=SQLOLEDB;Initial Catalog=SCI_TBR;Data Source=CLOUD-8JOI1VTRC\SQLEXPRESS;User Id=user;Password=pass;"
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
%>
