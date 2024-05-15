<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
FAMILIA=UCASE(REQUEST("FAMILIA"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
IND_EXISTENCIA=UCASE(REQUEST("IND_EXISTENCIA"))

RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetFamilia"
		GetMarca()
		
	Case "NewFamilia"
		 NewFamilia()

 	Case "NewSubFamilia"
		 NewSubFamilia()
		
	Case "UpdateFamilia"
		 UpdateFamilia()
		
	Case "ListFamilias"
		ListFamilias()
		
	Case "ListSubFamilias"
		ListSubFamilias()
			
	Case "DelFamilia"
		DelFamilia()
		
	Case "DelSubFamilia"
		DelSubFamilia()
		
End Select

function NewFamilia()

	query = "INSERT INTO FAMILIAS (CODIGO, DESCRIPCION, IND_EXISTENCIA)"
	query = query & " VALUES ("
	query = query & strNvl(CODIGO) & "," 
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(IND_EXISTENCIA) & ")"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ListFamilias()
	query = "SELECT CODIGO, DESCRIPCION, IND_EXISTENCIA "
	query = query & " FROM FAMILIAS"
	IF IND_EXISTENCIA="YES" THEN
	query = query & " WHERE UPPER(IND_EXISTENCIA) = 'TRUE' "
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
 		  Response.Write "<IND_EXISTENCIA>" & ORs.Fields.Item(2).Value & "</IND_EXISTENCIA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetFamilia()

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


function UpdateFamilia()
	query = "UPDATE FAMILIAS SET IND_EXISTENCIA = " & strNvl(IND_EXISTENCIA) & " "
	query = query & "WHERE CODIGO=" & strNvl(CODIGO) 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelFamilia()
	query = "DELETE FROM FAMILIAS WHERE CODIGO='" & CODIGO & "' "
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function ListSubFamilias()
	query = "SELECT CODIGO, DESCRIPCION "
	query = query & " FROM SUB_FAMILIAS "
	query = query & " WHERE COD_FAMILIA=" & strNvl(FAMILIA)
	query = query & " ORDER BY DESCRIPCION " 

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

function NewSubFamilia()

	Dim N 
	query = "SELECT MAX(CODIGO) AS NUM FROM SUB_FAMILIAS "
	
	Set ORs =oDB.EjecutaSql(query)	

	If Len(oRS("NUM"))> 0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO SUB_FAMILIAS (CODIGO, DESCRIPCION, COD_FAMILIA)"
	query = query & " VALUES ("
	query = query & strNvl(N) & "," 
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(FAMILIA) & ")"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf 
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function DelSubFamilia()
	query = "DELETE FROM SUB_FAMILIAS WHERE CODIGO=" & CODIGO 
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

