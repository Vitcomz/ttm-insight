<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
CATEGORIA=UCASE(REQUEST("CATEGORIA"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetMarca"
		GetMarca()
		
	Case "existeArticulo"
		existeArticulo()
		
	Case "NewMarca"
		 NewMarca()
		
	Case "UpdateMarca"
		 UpdateMarca()
		
	Case "ListMarcas"
		ListMarcas()
			
	Case "DelMarca"
		DelMarca()
		
End Select

function NewMarca()

	query = "INSERT INTO MARCAS (CODIGO, DESCRIPCION, CATEGORIA)"
	query = query & " VALUES ("
	query = query & strNvl(CODIGO) & "," 
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(CATEGORIA) & ")"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ListMarcas()
	query = "SELECT CODIGO, DESCRIPCION "
	query = query & " FROM MARCAS"
	
	IF Len(CATEGORIA)>0 THEN
		query = query & " WHERE CATEGORIA=" & strNvl(CATEGORIA)
	END IF

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetMarca()
	query = "SELECT A.CODIGO, A.DESCRIPCION, A.MARCA, "
	query = query & " A.MODELO, A.TIPO, E.ESTANTE, E.SECCION, "
	query = query & " A.FECHA, A.PROVEEDOR, A.VALOR, P.NOMBRE "
	query = query & " FROM Articulos as A, PROVEEDORES P, EXISTENCIA AS E"
	query = query & " WHERE A.CODIGO='" & CODIGO & "' AND A.PROVEEDOR = P.RUT_PROVEEDOR " 
	query = query & " AND A.CODIGO = E.COD_ARTICULO "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<MARCA>" & ORs.Fields.Item(2).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(3).Value & "</MODELO>"
   		  Response.Write "<TIPO>" & ORs.Fields.Item(4).Value & "</TIPO>"
  		  Response.Write "<ESTANTE>" & ORs.Fields.Item(5).Value & "</ESTANTE>"
  		  Response.Write "<SECCION>" & ORs.Fields.Item(6).Value & "</SECCION>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(7).Value & "</FECHA>"
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(8).Value & "</RUT_PROVEEDOR>"  
		  Response.Write "<VALOR>" & ORs.Fields.Item(9).Value & "</VALOR>"
		  Response.Write "<NOMBRE_PROVEEDOR>" & ORs.Fields.Item(10).Value & "</NOMBRE_PROVEEDOR>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function existeArticulo()

	query = "SELECT A.CODIGO "
	query = query & "FROM ARTICULOS AS A "
	query = query & "WHERE A.CODIGO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<RETURN>YES</RETURN>"
	  Response.Write "</ROW>"
	Else
		  Response.Write "<ROW>" 
		  Response.Write "<RETURN>NOT</RETURN>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateMarca()
	query = "UPDATE Articulos SET DESCRIPCION = " & strNvl(NOMBRE) & ", "
	query = query & "MARCA=" & strNvl(MARCA) & ", "
	query = query & "MODELO=" & strNvl(MODELO) & ", "
	query = query & "FECHA=" & strNvl(FECHA) & ", "
	query = query & "TIPO=" & strNvl(TIPO) & ", "
	query = query & "PROVEEDOR=" & strNvl(RUT_PROVEEDOR) & ", "
	query = query & "VALOR=" & strNvl(VALOR) & " "
	query = query & "WHERE CODIGO=" & strNvl(CODIGO) 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelMarca()
	query = "DELETE FROM MARCAS WHERE CODIGO='" & CODIGO & "' "
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

