<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
COD_BODEGA=UCASE(REQUEST("COD_BODEGA"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
DIRECCION=UCASE(REQUEST("DIRECCION"))
ENCARGADO=UCASE(REQUEST("ENCARGADO"))
UBICACION=UCASE(REQUEST("UBICACION"))
IND_ACTUAL=UCASE(REQUEST("IND_ACTUAL"))

RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetBodega"
		GetBodega()
	
	Case "GetBodegaActual"
		GetBodegaActual()
		
	Case "NewBodega"
		 NewBodega()
	
	Case "NewUbicacion"
		 NewUbicacion()
	
	Case "NewSeccion"
		 NewSeccion()
	
	Case "UpdateBodega"
		 UpdateBodega()
	
	Case "ExisteBodega"
		 ExisteBodega()
		
	Case "ListBodegas"
		ListBodegas()
	
	Case "ListUbicaciones"
		ListUbicaciones()
		
	Case "ListSecciones"
		ListSecciones()
				
	Case "DelBodega"
		DelBodega()
	
	Case "DelUbicacion"
		DelUbicacion()
		
	Case "DelSeccion"
		DelSeccion()
		
End Select

function NewBodega()

	query = "INSERT INTO BODEGAS (CODIGO, NOMBRE, DIRECCION, ENCARGADO, ACTUAL)"
	query = query & " VALUES ("
	query = query & strNvl(CODIGO) & "," 
	query = query & strNvl(NOMBRE) & ","
	query = query & strNvl(DIRECCION) & ","
	query = query & strNvl(ENCARGADO) & ","
	query = query & strNvl(IND_ACTUAL) & ")"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function NewUbicacion()

	query = "INSERT INTO UBICACIONES (BODEGA, UBICACION)"
	query = query & " VALUES ("
	query = query & strNvl(COD_BODEGA) & "," 
	query = query & strNvl(NOMBRE) & ")"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function NewSeccion()

	query = "INSERT INTO SECCIONES (COD_BODEGA, UBICACION, NOMBRE)"
	query = query & " VALUES ("
	query = query & strNvl(COD_BODEGA) & "," 
	query = query & strNvl(UBICACION) & "," 
	query = query & strNvl(NOMBRE) & ")"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ExisteBodega() 

	query = "SELECT * FROM BODEGAS WHERE CODIGO ='" & CODIGO & "'"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "<ROW>"
	
	If Not ORs.EOF Then
				  Response.Write "<Exist>True</Exist>"
	ELSE
				  Response.Write "<Exist>False</Exist>"
	End If
	
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListBodegas()
	query = "SELECT CODIGO, NOMBRE, ENCARGADO "
	query = query & " FROM BODEGAS"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
 		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListUbicaciones()
	query = "SELECT BODEGA, UBICACION  "
	query = query & " FROM UBICACIONES WHERE BODEGA=" & strNvl(COD_BODEGA)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE_UB>" & ORs.Fields.Item(1).Value & "</NOMBRE_UB>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListSecciones()

	query = "SELECT UBICACION, NOMBRE  "
	query = query & " FROM SECCIONES WHERE COD_BODEGA=" & strNvl(COD_BODEGA)
	query = query & " AND UBICACION=" & strNvl(UBICACION)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE_SEC>" & ORs.Fields.Item(1).Value & "</NOMBRE_SEC>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetBodega()

	query = "SELECT CODIGO, NOMBRE, DIRECCION, "
	query = query & " ENCARGADO, ACTUAL "
	query = query & " FROM BODEGAS "
	query = query & " WHERE CODIGO='" & CODIGO & "'"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(2).Value & "</DIRECCION>"
		  Response.Write "<ENCARGADO>" & ORs.Fields.Item(3).Value & "</ENCARGADO>"
   		  Response.Write "<IND_ACTUAL>" & ORs.Fields.Item(4).Value & "</IND_ACTUAL>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetBodegaActual()

	query = "SELECT CODIGO, NOMBRE "
	query = query & " FROM BODEGAS "
	query = query & " WHERE ACTUAL='TRUE'"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateBodega()

	query = "UPDATE BODEGAS SET NOMBRE = " & strNvl(NOMBRE) & ","
	query = query & " DIRECCION =" & strNvl(DIRECCION)  & ","
	query = query & " ENCARGADO =" & strNvl(ENCARGADO)  & " "
	query = query & "WHERE CODIGO=" & strNvl(CODIGO) 
	Set ORs =oDB.EjecutaSql(query)
	
	IF IND_ACTUAL="TRUE" THEN
		query = "UPDATE BODEGAS SET ACTUAL = 'TRUE' " 
		query = query & "WHERE CODIGO=" & strNvl(CODIGO) 
		Set ORs =oDB.EjecutaSql(query)
		
		query = "UPDATE BODEGAS SET ACTUAL = 'FALSE' " 
		query = query & "WHERE CODIGO<>" & strNvl(CODIGO)
		Set ORs =oDB.EjecutaSql(query)
		
	End IF
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelBodega()

	query = "DELETE FROM BODEGAS WHERE CODIGO='" & CODIGO & "' "
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function DelUbicacion()
	query = "DELETE FROM UBICACIONES WHERE UBICACION=" & strNvl(NOMBRE) & " AND BODEGA=" & strNvl(COD_BODEGA)
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function DelSeccion()
	query = "DELETE FROM SECCIONES WHERE COD_BODEGA=" & strNvl(COD_BODEGA) & " AND UBICACION=" & strNvl(UBICACION)
	query = query & " AND NOMBRE=" & strNvl(NOMBRE)
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

