<%
Dim RemotePath
    Set Conexion = Server.CreateObject("ADODB.Connection")
	RemotePath = "\AppWeb\SCI\SCI.MDB;"
	DSNName = "DRIVER=Microsoft Access Driver (*.mdb);DBQ="
	DSNName = DSNName & Server.MapPath(RemotePath)
'   Conexion.Open DSNName'
	
	Conexion.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\SistemasWeb\Vitcomz\AppWeb\SCI\SCI.MDB;User Id=admin;Password=;"
	
	query = "SELECT ID, AUTOR, NOMBRE, VERSION, DESCRIPCION, ESTADO " 
	query = query & "FROM SISTEMAS WHERE ID='" & ID & "'"
	
	Set RS = Server.CreateObject("ADODB.Recordset")
	'RS.Open query, Conexion, 3, 3'
	Set OReg = Conexion.Execute(query)

%>

