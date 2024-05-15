<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
COD_BODEGA=UCASE(REQUEST("COD_BODEGA"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
ADQUISICIONES=UCASE(REQUEST("ADQUISICIONES"))
CONTABILIDAD=UCASE(REQUEST("CONTABILIDAD"))
MAIL_SERVER=REQUEST("MAIL_SERVER")
MAIL_ADQUI=REQUEST("MAIL_ADQUI")
MAIL_CONTA=REQUEST("MAIL_CONTA")
ANO_PROCESO=REQUEST("ANO_PROCESO")
MES_PROCESO=REQUEST("MES_PROCESO")
DIRECCION=UCASE(REQUEST("DIRECCION"))
ENCARGADO=UCASE(REQUEST("ENCARGADO"))
UBICACION=UCASE(REQUEST("UBICACION"))
IND_ACTUAL=UCASE(REQUEST("IND_ACTUAL"))

RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetBodega"
		GetBodega()
		
	Case "GetParametros"
		GetParametros()
		
	Case "GetAutorizaCompras"
		GetAutorizaCompras()

	Case "SetParametros"
		SetParametros()
	
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
	
	Case "Existencia"
		 Existencia()
		
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

function Existencia() 

	query = "SELECT  E.COD_BODEGA, E.COD_ARTICULO, A.DESCRIPCION, "
	query = query & "E.STOCK, A.VALOR, E.STOCK * A.VALOR AS TOTAL,"
	query = query & "E.UBICACION, E.SECCION "
	query = query & "FROM EXISTENCIA AS E, ARTICULOS AS A "
	query = query & "WHERE E.COD_ARTICULO = A.ID "
	query = query & "ORDER BY UBICACION, SECCION "
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  	Response.Write "<COD_BODEGA>" & ORs.Fields.Item(0).Value & "</COD_BODEGA>"
		  	Response.Write "<COD_ARTICULO>" & ORs.Fields.Item(1).Value & "</COD_ARTICULO>"
 		  	Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  	Response.Write "<STOCK>" & ORs.Fields.Item(3).Value & "</STOCK>"
			Response.Write "<VALOR>" & ORs.Fields.Item(4).Value & "</VALOR>"
			Response.Write "<TOTAL>" & ORs.Fields.Item(5).Value & "</TOTAL>"
			Response.Write "<UBICACION>" & ORs.Fields.Item(6).Value & "</UBICACION>"
			Response.Write "<SECCION>" & ORs.Fields.Item(7).Value & "</SECCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
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

function GetParametros()

	query = "SELECT ADQUISICIONES, CONTABILIDAD, MAIL_ADQUI,"
	query = query & "MAIL_CONTA, MAIL_SERVER, ANO_PROCESO, MES_PROCESO "
	query = query & " FROM PARAMETROS "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ADQUISICIONES>" & ORs.Fields.Item(0).Value & "</ADQUISICIONES>"
		  Response.Write "<CONTABILIDAD>" & ORs.Fields.Item(1).Value & "</CONTABILIDAD>"
		  Response.Write "<MAIL_ADQUI>" & ORs.Fields.Item(2).Value & "</MAIL_ADQUI>"
		  Response.Write "<MAIL_CONTA>" & ORs.Fields.Item(3).Value & "</MAIL_CONTA>"
		  Response.Write "<MAIL_SERVER>" & ORs.Fields.Item(4).Value & "</MAIL_SERVER>"
		  Response.Write "<ANO_PROCESO>" & ORs.Fields.Item(5).Value & "</ANO_PROCESO>"
		  Response.Write "<MES_PROCESO>" & ORs.Fields.Item(6).Value & "</MES_PROCESO>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetAutorizaCompras()

	query = "SELECT  P.CONTABILIDAD, U.NOMBRES, U.APELLIDOS"
	query = query & " FROM PARAMETROS AS P, SCI.DBO.USUARIOS AS U "
	query = query & " WHERE P.CONTABILIDAD = U.ID "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CONTABILIDAD>" & ORs.Fields.Item(0).Value & "</CONTABILIDAD>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(1).Value & "</NOMBRES>"
		  Response.Write "<APELLIDOS>" & ORs.Fields.Item(2).Value & "</APELLIDOS>"
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

function SetParametros()

	query = "UPDATE PARAMETROS SET ADQUISICIONES = " & strNvl(ADQUISICIONES) & ","
	query = query & " CONTABILIDAD =" & strNvl(CONTABILIDAD)  & ","
	query = query & " MAIL_ADQUI =" & strNvl(MAIL_ADQUI)  & ","
	query = query & " MAIL_CONTA =" & strNvl(MAIL_CONTA)  & ","
	query = query & " ANO_PROCESO =" & strNvl(ANO_PROCESO)  & ","
	query = query & " MES_PROCESO =" & strNvl(MES_PROCESO)  & ","
	query = query & " MAIL_SERVER =" & strNvl(MAIL_SERVER)  & " "
	
	Set ORs =oDB.EjecutaSql(query)
	
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

