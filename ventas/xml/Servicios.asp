<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ID= UCASE(REQUEST("ID"))
EMPRESA= UCASE(REQUEST("EMPRESA"))
CODIGO= UCASE(REQUEST("CODIGO"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
CANTIDAD=REQUEST("CANTIDAD")
FOLIO=REQUEST("FOLIO")
FECHA=REQUEST("FECHA")
FAMILIA=REQUEST("FAMILIA")
SUB_FAMILIA=REQUEST("SUB_FAMILIA")
SRCTEXT=UCASE(REQUEST("SRCTEXT"))
UBICACION=UCASE(REQUEST("UBICACION"))
APROBADO=UCASE(REQUEST("APROBADO"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=REQUEST("VALOR")
TIPO_MONEDA=REQUEST("TIPO_MONEDA")
COND_PAGO=REQUEST("COND_PAGO")
IND_EXENTA=UCASE(REQUEST("IND_EXENTA"))
PROVEEDOR=REQUEST("PROVEEDOR") 
PLAZO_ENTREGA=REQUEST("PLAZO_ENTREGA")
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetServicio"
		GetServicio()
		
	Case "existeServicio"
		existeServicio()
		
	Case "NewServicio"
		 NewServicio()

 	Case "InsertServiciosCT"
		 InsertServiciosCT()

  	Case "UpdateServiciosST"
		UpdateServiciosST()
		
	Case "UpdateServiciosOC"
		UpdateServiciosOC()

  	Case "DeleteServiciosCT"
		 DeleteServiciosCT()
		
	Case "UpdateServicio"
		 UpdateServicio()
		
	Case "ListServicios"
		ListServicios()
				
	Case "ListServiciosCT"
		ListServiciosCT()
		
	Case "ListServiciosOC"
		ListServiciosOC()
		
	Case "DelServicio"
		DelServicio()
End Select

function NewServicio()

'	query = "SELECT MAX(CODIGO) AS NUM FROM SERVICIOS "
'	
'	Set ORs =oDB.EjecutaSql(query)		
'	If Len(oRS("NUM"))>0 Then
'		N = oRS("NUM") + 1
'	Else
'		N = 1
'	End If
	

	query = "INSERT INTO SERVICIOS (CODIGO, DESCRIPCION, "
	query = query & "  USERDATE, VALOR, ESTADO) VALUES ("
	query = query & strNvl(ID) & "," 
	query = query & strNvl(DESCRIPCION) & ","
	query = query & "GETDATE()," 
	query = query & strNvl(VALOR) & ", 'ACT');" 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
		  Response.Write "<RETURN>" & N & "</RETURN>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function


function ListServicios()
	query = "SELECT S.CODIGO, S.DESCRIPCION, S.VALOR "
	query = query & " FROM SERVICIOS AS S"
	query = query & " WHERE UPPER(S.DESCRIPCION) LIKE '%" & SRCTEXT & "%' AND S.ESTADO<>'NUL'"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListServiciosCT()

	 query = "SELECT S.CODIGO, S.DESCRIPCION, SO.VALOR, SO.CANTIDAD, "
	 query = query & " SO.APROBADO "
	 query = query & "FROM SERVICIOS AS S, SERVICIOS_CT AS SO "
	 query = query & "WHERE S.CODIGO = SO.CODIGO "
 	 query = query & " AND SO.FOLIO= " & FOLIO
	
	
	IF LEN(APROBADO)>0 THEN
	  	 query = query & " AND SO.APROBADO='TRUE' " 
   	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
   		  Response.Write "<APROBADO>" & ORs.Fields.Item(4).Value & "</APROBADO>"
	
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListServiciosOC()

	 query = "SELECT S.CODIGO, S.DESCRIPCION, SO.VALOR, SO.CANTIDAD, SO.APROBADO, SO.PROVEEDOR "
	 query = query & "FROM SERVICIOS AS S, SERVICIOS_ST AS SO "
	 query = query & "WHERE S.CODIGO = SO.CODIGO "
 	 query = query & " AND SO.FOLIO_OC= " & FOLIO
	 query = query & " AND SO.EMPRESA= " & strNvl(EMPRESA)
	
	IF LEN(APROBADO)>0 THEN
	  	 query = query & " AND SO.APROBADO='TRUE' " 
   	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
   		  Response.Write "<APROBADO>" & ORs.Fields.Item(4).Value & "</APROBADO>"
		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(5).Value & "</PROVEEDOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InsertServiciosCT()

	query = "INSERT INTO SERVICIOS_CT (FOLIO, CODIGO, CANTIDAD, VALOR) "
	query = query & " VALUES ("
	query = query & FOLIO & ","
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(VALOR) & ");"   
	

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateServiciosST()

	
	query = "UPDATE SERVICIOS_ST SET "
	query = query & "CANTIDAD =" & CANTIDAD & ","
	query = query & "VALOR =" & strNvl(VALOR) & " "

	If Len(APROBADO) > 0 Then
		query = query & ", APROBADO =" & strNvl(APROBADO) & " "
	End If
	
	If Len(RUT_PROVEEDOR) > 0 Then
		query = query & ", PROVEEDOR=" & strNvl(RUT_PROVEEDOR) & " "
	End If
	
	query = query & ", TIPO_MONEDA=" & strNvl(TIPO_MONEDA) & " "
	query = query & ", IND_EXENTA=" & strNvl(IND_EXENTA) & " "
	query = query & ", PLAZO_ENTREGA=" & strNvl(PLAZO_ENTREGA) & " "
	query = query & ", COND_PAGO=" & strNvl(COND_PAGO) & " "
	query = query & " WHERE CODIGO = " & strNvl(CODIGO)
	query = query & " AND FOLIO_ST = " & strNvl(FOLIO) 
	query = query & " AND EMPRESA = " & strNvl(EMPRESA) 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateServiciosOC()

	
	query = "UPDATE SERVICIOS_ST SET "
	query = query & "CANTIDAD =" & CANTIDAD & ","
	query = query & "VALOR =" & strNvl(VALOR) & " "

	If Len(APROBADO) > 0 Then
		query = query & ", APROBADO =" & strNvl(APROBADO) & " "
	End If
	
	If Len(RUT_PROVEEDOR) > 0 Then
		query = query & ", PROVEEDOR=" & strNvl(RUT_PROVEEDOR) & " "
	End If
	
	
	query = query & " WHERE CODIGO = " & strNvl(CODIGO)
	query = query & " AND FOLIO_OC = " & strNvl(FOLIO)
	query = query & " AND EMPRESA = " & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function DeleteServiciosCT()

	query = "DELETE SERVICIOS_CT "
	query = query & "WHERE FOLIO=" & FOLIO

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetServicio()
	query = "SELECT S.CODIGO, S.DESCRIPCION, S.VALOR"
	query = query & " FROM SERVICIOS AS S"
	query = query & " WHERE S.CODIGO=" & strNvl(CODIGO)

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function existeArticulo()

	query = "SELECT A.CODIGO "
	query = query & "FROM ARTICULOS AS A "
	
	If Len(CODIGO)>0 THEN
		query = query & "WHERE A.CODIGO=" & strNvl(CODIGO)
	End If
	
	If Len(NOMBRE)>0 THEN
		query = query & "WHERE A.DESCRIPCION=" & strNvl(NOMBRE)
	End If
	
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

function UpdateServicio()
	query = "UPDATE SERVICIO SET DESCRIPCION = " & strNvl(DESCRIPCION) & ", "
	query = query & "VALOR=" & strNvl(VALOR) & ", "
	query = query & "PROVEEDOR=" & strNvl(PROVEEDOR) & " "
	query = query & "WHERE CODIGO=" & CODIGO
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelServicio()
	query = "UPDATE SERVICIOS SET ESTADO='NUL' WHERE CODIGO='" & CODIGO & "' "
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

