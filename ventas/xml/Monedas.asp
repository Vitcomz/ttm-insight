<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

SIMBOLO=UCASE(REQUEST("SIMBOLO"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetMoneda"
		GetMoneda()
		
		
	Case "NewMoneda"
		 NewMoneda()
				
	Case "ListMonedas"
		ListMonedas()
			
	Case "DelMoneda"
		DelMoneda()
		
End Select

function NewMoneda()

	query = "INSERT INTO MONEDAS (SIMBOLO, NOMBRE)"
	query = query & " VALUES ("
	query = query & strNvl(SIMBOLO) & "," 
	query = query & strNvl(NOMBRE) & ")"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ListMonedas()
	query = "SELECT SIMBOLO, NOMBRE "
	query = query & " FROM MONEDAS"
	

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<SIMBOLO>" & ORs.Fields.Item(0).Value & "</SIMBOLO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
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

function DelMoneda()
	query = "DELETE FROM MONEDAS WHERE SIMBOLO='" & SIMBOLO & "' "
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

