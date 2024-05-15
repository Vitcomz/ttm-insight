<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO= UCASE(REQUEST("CODIGO"))
COD_ARTICULO= UCASE(REQUEST("COD_ARTICULO"))
COD_BODEGA = UCASE(REQUEST("COD_BODEGA"))
NRO_DOCUMENTO = UCASE(REQUEST("NRO_DOCUMENTO"))
FOLIO=UCASE(REQUEST("FOLIO"))
ORDEN_COMPRA=REQUEST("ORDEN_COMPRA")
RESPONSABLE=REQUEST("RESPONSABLE")
PARCIAL=REQUEST("PARCIAL")
EMPRESA=REQUEST("EMPRESA")
APROBADA=REQUEST("APROBADA")
FECHA=REQUEST("FECHA")
TIPO=REQUEST("TIPO")
UBICACION=UCASE(REQUEST("UBICACION"))
SECCION=UCASE(REQUEST("SECCION"))
IND_BODEGA=UCASE(REQUEST("IND_BODEGA"))
VALOR=UCASE(REQUEST("VALOR"))
CANTIDAD=UCASE(REQUEST("CANTIDAD"))
PROVEEDOR=REQUEST("PROVEEDOR") 
OBSERVACION=REQUEST("OBSERVACION")
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetIngreso"
			GetIngreso()
		
	Case "NewIngreso"
		 	NewIngreso()
			
	Case "InsertArticulos"
		 InsertArticulos()
	
	Case "InsertNroDocumento"
		  InsertNroDocumento()
		 
	Case "UpdateArticulos"
		 UpdateArticulos()
		
	Case "UpdateIngreso"
			UpdateIngreso()
	
	Case "OCPendiente"
			OCPendiente()
			
		
	Case "ListIngresos"
			ListIngresos()
			
	Case "ListArticulos"
			ListArticulos()
		
	Case "DelArticulo"
		DelArticulo()
End Select

function NewIngreso()

Dim N 

	query = "SELECT MAX(FOLIO) AS NUM FROM INGRESOS "
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO INGRESOS (FOLIO, FECHA, PROVEEDOR, ORDEN_COMPRA, RECEPTOR, OBSERVACION, NRO_DOCUMENTO, TIPO_DOC ) "
	query = query & " VALUES ("
	query = query & N & "," 
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(PROVEEDOR) & ","
	query = query & strNvl(ORDEN_COMPRA) & ","
	query = query & strNvl(RESPONSABLE)  & ","
	query = query & strNvl(OBSERVACION)  & ","
	query = query & strNvl(NRO_DOCUMENTO) & "," 
	query = query & strNvl(TIPO) & " );" 
	
	Set ORs =oDB.EjecutaSql(query)
	
	IF PENDIENTE="FALSE" THEN
		query = "UPDATE ORDEN_COMPRA SET IND_PENDIENTE='FALSE' WHERE FOLIO='" & ORDEN_COMPRA & "' "
		Set ORs =oDB.EjecutaSql(query)
	END IF
	Set ORs = Nothing
	
	InsertNroDocumento()
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<FOLIO_ING>" & N  & "</FOLIO_ING>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
end function

function InsertNroDocumento()
	
	query = "SELECT * FROM DOCUMENTOS WHERE TIPO_DOCUMENTO=" & strNvl(TIPO) 
	query = query & " AND FOLIO=" & strNvl(NRO_DOCUMENTO)
	query = query & " AND ORDEN_COMPRA=" & strNvl(ORDEN_COMPRA)
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	If ORs.Eof Then
		query = "INSERT INTO DOCUMENTOS (ORDEN_COMPRA, TIPO_DOCUMENTO, FOLIO, EMPRESA, USERNAME, USERDATE ) VALUES ( "
		query = query & strNvl(ORDEN_COMPRA) & ","
		query = query & strNvl(TIPO) & ","
		query = query & strNvl(NRO_DOCUMENTO) & ","
		query = query & strNvl(EMPRESA) & ","
		query = query & strNvl(RESPONSABLE) & ","
		query = query & "GETDATE() ) "
	End If
	
	Set ORs =oDB.EjecutaSql(query)
	Set ORs = Nothing
	
end Function

function UpdateIngreso()

	query = "UPDATE INGRESOS SET  "
	query = query & "RECEPTOR=" & strNvl(RESPONSABLE) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ","
	query = query & "NRO_DOCUMENTO=" & strNvl(NRO_DOCUMENTO) & ","
	query = query & "TIPO_DOC=" & strNvl(TIPO)
	 
	query = query & "WHERE FOLIO = " & FOLIO 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<FOLIO_ING>" & FOLIO  & "</FOLIO_ING>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs =oDB.EjecutaSql(query)
	
	IF PENDIENTE="FALSE" THEN
		query = "UPDATE ORDEN_COMPRA SET IND_PENDIENTE='FALSE' WHERE FOLIO='" & ORDEN_COMPRA & "' "
		Set ORs =oDB.EjecutaSql(query)
	END IF
	
	Set ORs = Nothing
	
	InsertNroDocumento()
	
end function

function ListIngresos()
	query = "SELECT I.FOLIO, P.NOMBRE, I.FECHA, I.RECEPTOR, I.OBSERVACION "
	query = query & " FROM INGRESOS AS I, PROVEEDORES AS P"
	query = query & " WHERE I.PROVEEDOR = P.RUT "
	query = query & " ORDER BY FOLIO DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<PROVEDOR>" & ORs.Fields.Item(1).Value & "</PROVEDOR>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
   		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(4).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetIngreso()

	query = "SELECT I.FOLIO, RTRIM(CONVERT(CHAR, I.FECHA, 103)) AS FECHA, I.PROVEEDOR, P.NOMBRE, I.ORDEN_COMPRA,"
	query = query & " I.TIPO_DOC, I.OBSERVACION, I.NRO_DOCUMENTO, OC.ESTADO "
	query = query & " FROM INGRESOS AS I "
	query = query & " LEFT OUTER JOIN  PROVEEDORES AS P ON I.PROVEEDOR = P.RUT " 
	query = query & " LEFT OUTER JOIN  ORDEN_COMPRA AS OC ON I.ORDEN_COMPRA=OC.FOLIO"
	query = query & " WHERE I.FOLIO='" & FOLIO & "'"

	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_ING>" & ORs.Fields.Item(0).Value & "</FOLIO_ING>"
		  Response.Write "<FECHA_INGRESO>" & ORs.Fields.Item(1).Value & "</FECHA_INGRESO>"
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(2).Value & "</RUT_PROVEEDOR>"
		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(3).Value & "</PROVEEDOR>"
   		  Response.Write "<FOLIO>" & ORs.Fields.Item(4).Value & "</FOLIO>"
  		  Response.Write "<TIPO>" & ORs.Fields.Item(5).Value & "</TIPO>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(6).Value & "</OBSERVACION>"
   		  Response.Write "<NRO_DOCUMENTO>" & ORs.Fields.Item(7).Value & "</NRO_DOCUMENTO>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(8).Value & "</ESTADO>"  
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InsertArticulos()

MES=MONTH(FECHA)
ANHO=YEAR(FECHA)

	query = "UPDATE ARTICULOS_ST SET CANTIDAD_PENDIENTE = CANTIDAD_PENDIENTE - " &  CANTIDAD
	query = query & " WHERE FOLIO_OC = " &  ORDEN_COMPRA
	query = query & " AND CODIGO=" & COD_ARTICULO
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	If IND_BODEGA<>"TRUE" Then
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		Response.Write "<FOLIO>OK</FOLIO>"
		Response.Write "</REGISTROS>"
		Exit Function 
	End If
	
	query = "SELECT MAX(FOLIO_MOV) AS NUM FROM MOVIMIENTOS "
	Set ORs =oDB.EjecutaSql(query)		
	
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO MOVIMIENTOS (FOLIO_MOV, FOLIO, COD_ARTICULO, COD_BODEGA, TIPO, FECHA,"
	query = query & " CANTIDAD, VALOR, UBICACION, SECCION ) VALUES ("
	query = query & N & ","
	query = query & strNvl(FOLIO) & ","
	query = query & strNvl(COD_ARTICULO) & ","
	query = query & strNvl(COD_BODEGA) & ",'ING', GETDATE(),"
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(UBICACION) & ","
	query = query & strNvl(SECCION) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	query = "SELECT STOCK FROM EXISTENCIA WHERE "
	query = query & " COD_ARTICULO = " & strNvl(COD_ARTICULO) & " "
	query = query & " AND COD_BODEGA = " & strNvl(COD_BODEGA) & " "
	query = query & " AND UBICACION = " & strNvl(UBICACION) & " "
	query = query & " AND SECCION = " & strNvl(SECCION) & " "
	
	Set ORs =oDB.EjecutaSql(query)
	
	If (ORs.eof) Then
	
		query = "INSERT INTO EXISTENCIA (COD_BODEGA, COD_ARTICULO, UBICACION, SECCION, STOCK) VALUES ("
		query = query &  strNvl(COD_BODEGA) & ","
		query = query &  strNvl(COD_ARTICULO) & ", "
		query = query &  strNvl(UBICACION) & ", "
		query = query &  strNvl(SECCION) & ", "
		query = query &  strNvl(CANTIDAD) & ")"
	
		Set ORs =oDB.EjecutaSql(query)
	Else
		query = "UPDATE EXISTENCIA SET STOCK = STOCK + " &  CANTIDAD
		query = query & " WHERE COD_BODEGA = " & strNvl(COD_BODEGA) & " "
		query = query & " AND COD_ARTICULO = " &  strNvl(COD_ARTICULO) & " "
		IF strNvl(UBICACION)="NULL" THEN
				query = query & " AND UBICACION IS NULL " 
		ELSE
				query = query & " AND UBICACION = " & strNvl(UBICACION) 
		END IF
	
		IF strNvl(SECCION)="NULL" THEN
			query = query & " AND SECCION IS NULL " 
		ELSE
			query = query & " AND SECCION = " & strNvl(SECCION) & " " 
		END IF
	
		Set ORs =oDB.EjecutaSql(query)
	
	End If
	
		
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & N & "</FOLIO>"
	Response.Write "</REGISTROS>"
	
	Set cmd = Server.CreateObject("ADODB.Command")
   	Set cmd.ActiveConnection = oDB.Conexion

   	cmd.CommandText = "EXISTENCIAS.CalculoSaldo"
   	cmd.CommandType = 4
   
   	cmd.Parameters.Append = cmd.CreateParameter("CODIGO",3,1,,COD_ARTICULO)
   	cmd.Parameters.Append = cmd.CreateParameter("MES",200,1,2,CINT(MES))
  	cmd.Parameters.Append = cmd.CreateParameter("ANHO",200,1,4,CINT(ANHO))
 
   	cmd.Execute
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function UpdateArticulos()

MES=MONTH(FECHA)
ANHO=YEAR(FECHA)

Dim OldCantidad 

	query = "SELECT CANTIDAD FROM MOVIMIENTOS "
	query = query & " WHERE FOLIO=" & strNvl(FOLIO) 
	query = query & " AND COD_ARTICULO=" & strNvl(COD_ARTICULO) 
	
	Set ORs =oDB.EjecutaSql(query)
	



	rem response.Write("<script>alert(" & ORs.Fields.Item(0).Value & ")</script>")
	
	if not ORs.Eof Then
		OldCantidad =  Cint(ORs.Fields.Item(0).Value) 
	else
		OldCantidad = 0
	End If
	
	NUEVO_STOCK = CANTIDAD - OldCantidad
	
	query = "UPDATE ARTICULOS_ST SET CANTIDAD_PENDIENTE = CANTIDAD_PENDIENTE - " &   NUEVO_STOCK
	query = query & " WHERE FOLIO_OC = " &  ORDEN_COMPRA
	query = query & " AND CODIGO=" & COD_ARTICULO
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)
		
	Set ORs =oDB.EjecutaSql(query)
	If IND_BODEGA<>"TRUE" Then
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		Response.Write "<FOLIO>OK</FOLIO>"
		Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	query = "UPDATE MOVIMIENTOS SET CANTIDAD = " & strNvl(CANTIDAD) & ", "
	query = query & "VALOR=" & VALOR & ", "
	query = query & "UBICACION=" &  strNvl(UBICACION) & ", "
	query = query & "SECCION="  & strNvl(SECCION) & " " 
	query = query & "WHERE FOLIO=" & strNvl(FOLIO) 
	query = query & "AND COD_ARTICULO=" & strNvl(COD_ARTICULO) 
	
	Set ORs =oDB.EjecutaSql(query)
	
	
	'query = "UPDATE EXISTENCIA SET STOCK = STOCK + " & (NUEVO_STOCK)
	'query = query & " WHERE COD_BODEGA = " & strNvl(COD_BODEGA) & " "
	'query = query & " AND COD_ARTICULO = " &  strNvl(COD_ARTICULO) & " "
	'query = query & " AND UBICACION = " &  strNvl(UBICACION) & " "
	'query = query & " AND SECCION = " & strNvl(SECCION) & " " 
	
	'Set ORs =oDB.EjecutaSql(query)
	
		
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	
	Set cmd = Server.CreateObject("ADODB.Command")
   	Set cmd.ActiveConnection = oDB.Conexion

   	cmd.CommandText = "EXISTENCIAS.CalculoSaldo"
   	cmd.CommandType = 4
   
   	cmd.Parameters.Append = cmd.CreateParameter("CODIGO",3,1,,COD_ARTICULO)
   	cmd.Parameters.Append = cmd.CreateParameter("MES",200,1,2,CINT(MES))
  	cmd.Parameters.Append = cmd.CreateParameter("ANHO",200,1,4,CINT(ANHO))
 
   	cmd.Execute
	
	Set ORs = Nothing	
	Set ODB = Nothing
	
end function

function OCPendiente()

	query = "SELECT CANTIDAD_PENDIENTE FROM OC_EXISTENCIAS WHERE FOLIO_OC=" & strNvl(ORDEN_COMPRA)
	query = query & " AND CANTIDAD_PENDIENTE > 0"
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	IF ORs.eof Then 
		query = "UPDATE ORDEN_COMPRA SET IND_PENDIENTE = 'FALSE' WHERE FOLIO=" & strNvl(ORDEN_COMPRA)
		query = query & " AND EMPRESA=" & strNvl(EMPRESA)
		Set ORs =oDB.EjecutaSql(query)
		PENDIENTE = "FALSE"
	Else
		PENDIENTE = "TRUE"
	End If
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
	  	  Response.Write "<PENDIENTE>" & PENDIENTE & "</PENDIENTE>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"

end function

function ListArticulos()
	 
	 query = "SELECT A.ID, A.DESCRIPCION, M.VALOR, M.CANTIDAD, M.UBICACION, M.SECCION "
	 query = query & "FROM ARTICULOS AS A, MOVIMIENTOS AS M  "
 	 query = query & " WHERE A.ID = M.COD_ARTICULO AND M.TIPO='ING' AND M.FOLIO= " & FOLIO
	 
	IF LEN(APROBADO)>0 THEN
	  	 query = query & " AND OC.APROBADO='TRUE' " 
   	END IF
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
   		  Response.Write "<UBICACION>" & ORs.Fields.Item(4).Value & "</UBICACION>"
		  Response.Write "<SECCION>" & ORs.Fields.Item(5).Value & "</SECCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelArticulo()
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