<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
MARCA=REQUEST("MARCA")
MODELO=REQUEST("MODELO")
C=UCASE(REQUEST("c"))
UBICACION=UCASE(REQUEST("UBICACION"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=REQUEST("VALOR")
PROVEEDOR=REQUEST("PROVEEDOR") '
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
RECURSO=REQUEST("RECURSO")

select case RECURSO
	case "GetInsumo"
		GetInsumo()
	case "NewInsumo"
		NewInsumo()
	case "UpdateInsumo"
		UpdateInsumo()
	case "ListProv"
		ListProv()
	case "ListInsumos"
		ListInsumos()
	case "DelInsumo"
		DelInsumo()
end select

function NewInsumo()
	query = "INSERT INTO INSUMOS (CODIGO, NOMBRE, MARCA, MODELO, UBICACION,  SECCION, "
	query = query & " PROVEEDOR, VALOR) VALUES ('"
	query = query & CODIGO & " ','" 
	query = query & strNvl(NOMBRE) & ","
	query = query & strNvl(MARCA) & ","
	query = query & strNvl(MODELO) & ","
	query = query & strNvl(UBICACION)  & ","
	query = query & strNvl(SECCION)  & ", "
	query = query & RUT_PROVEEDOR & " ," 
	query = query & VALOR & ");" 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ListInsumos()
	query = "SELECT CODIGO, NOMBRE, MARCA, MODELO,"
	query = query & " UBICACION, SECCION, STOCK, PROVEEDOR, VALOR FROM INSUMOS"
	query = query & " WHERE UPPER(NOMBRE) LIKE '%" & C & "%'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
  		  Response.Write "<UBICACION>" & ORs.Fields.Item(4).Value & "</UBICACION>"
   		  Response.Write "<SECCION>" & ORs.Fields.Item(5).Value & "</SECCION>"
   		  Response.Write "<STOCK>" & ORs.Fields.Item(6).Value & "</STOCK>"
  		  Response.Write "<MARCA>" & ORs.Fields.Item(2).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(3).Value & "</MODELO>"
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(7).Value & "</RUT_PROVEEDOR>"  
		  Response.Write "<VALOR>" & ORs.Fields.Item(8).Value & "</VALOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetInsumo()
	query = "SELECT I.CODIGO, I.NOMBRE, I.MARCA, I.MODELO, I.UBICACION, I.SECCION, "
	query = query & " I.PROVEEDOR, I.VALOR, P.NOMBRE "
	query = query & " FROM INSUMOS I, PROVEEDORES P"
	query = query & " WHERE I.CODIGO='" & CODIGO & "' AND I.PROVEEDOR = P.RUT_PROVEEDOR " 

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<MARCA>" & ORs.Fields.Item(2).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(3).Value & "</MODELO>"
  		  Response.Write "<UBICACION>" & ORs.Fields.Item(4).Value & "</UBICACION>"
  		  Response.Write "<SECCION>" & ORs.Fields.Item(5).Value & "</SECCION>"
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(6).Value & "</RUT_PROVEEDOR>"  
		  Response.Write "<VALOR>" & ORs.Fields.Item(7).Value & "</VALOR>"
		  Response.Write "<NOMBRE_PROVEEDOR>" & ORs.Fields.Item(8).Value & "</NOMBRE_PROVEEDOR>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateInsumo()
	query = "UPDATE INSUMOS SET NOMBRE = '" & NOMBRE & "', "
	query = query & "MARCA='" & MARCA & "', "
	query = query & "MODELO='" & MODELO & "', "
	query = query & "UBICACION='" & UBICACION & "', "
	query = query & "SECCION='" & SECCION & "', "
	query = query & "PROVEEDOR=" & RUT_PROVEEDOR & ", "
	query = query & "VALOR=" & VALOR & " "
	query = query & "WHERE CODIGO='" & CODIGO & "' " 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListProv()
	query = "SELECT RUT_PROVEEDOR, NOMBRE FROM PROVEEDORES"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelInsumo()
	query = "DELETE FROM INSUMOS WHERE CODIGO='" & CODIGO & "' "
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

