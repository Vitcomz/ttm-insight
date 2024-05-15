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
OT=REQUEST("OT")
RESPONSABLE=REQUEST("RESPONSABLE")
PARCIAL=REQUEST("PARCIAL")
FECHA=REQUEST("FECHA")
TIPO=REQUEST("TIPO")
UBICACION=UCASE(REQUEST("UBICACION"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=UCASE(REQUEST("VALOR"))
CANTIDAD=UCASE(REQUEST("CANTIDAD"))
PROVEEDOR=REQUEST("PROVEEDOR") 
OBSERVACION=REQUEST("OBSERVACION")
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetEgreso"
			GetEgreso()
		
	Case "NewEgreso"
		 	NewEgreso()
			
	Case "InsertArticulos"
		 InsertArticulos()
		 
	Case "UpdateArticulos"
		 UpdateArticulos()
		
	Case "UpdateEgreso"
			UpdateEgreso()
			
	Case "ListEgresos"
			ListEgresos()
			
	Case "ListArticulos"
			ListArticulos()
			
	Case "ListOT"
		ListOT()
		
	Case "DelArticulo"
		DelArticulo()
End Select

function NewEgreso()

Dim N 

	query = "SELECT MAX(FOLIO) AS NUM FROM EGRESOS "
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO EGRESOS (FOLIO, FECHA, FOLIO_OT, RESPONSABLE, OBSERVACION, BODEGA) "
	query = query & " VALUES ("
	query = query & N & "," 
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(OT) & ","
	query = query & strNvl(RESPONSABLE)  & ","
	query = query & strNvl(OBSERVACION)  & ","
	query = query & strNvl(COD_BODEGA)  & ""
	query = query & " );" 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "<ROW>"
				Response.Write "<FOLIO>" & N  & "</FOLIO>"
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	
end function


function UpdateEgreso()

	query = "UPDATE EGRESOS SET  "
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & " "
	query = query & "WHERE FOLIO = " & FOLIO 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	
	Set ORs =oDB.EjecutaSql(query)
	

	Set ORs = Nothing
	Set oDB = Nothing
	
	
end function

function ListEgresos()
	query = "SELECT E.FOLIO, E.FECHA, E.OBSERVACION "
	query = query & " FROM EGRESOS AS E"
	query = query & " ORDER BY E.FOLIO DESC "
	
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(2).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetEgreso()

	query = "SELECT E.FOLIO, RTRIM(CONVERT(CHAR, E.FECHA, 103)) AS FECHA, E.RESPONSABLE,"
	query = query & "  E.OBSERVACION, E.BODEGA "
	query = query & " FROM EGRESOS AS E"
	query = query & " WHERE E.FOLIO=" & FOLIO 
	

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(3).Value & "</OBSERVACION>"  
		  Response.Write "<BODEGA>" & ORs.Fields.Item(4).Value & "</BODEGA>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function InsertArticulos()

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
	query = query & strNvl(COD_BODEGA) & ",'SAL', GETDATE(),"
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(UBICACION) & ","
	query = query & strNvl(SECCION) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	query = "UPDATE EXISTENCIA SET STOCK = STOCK - " &  CANTIDAD
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
	
				
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & N & "</FOLIO>"
	Response.Write "</REGISTROS>"
	
   	Set cmd = Server.CreateObject("ADODB.Command")
   	Set cmd.ActiveConnection = oDB.Conexion

   	cmd.CommandText = "dbo.CalculoSaldo"
   	cmd.CommandType = 4
   
   	cmd.Parameters.Append = cmd.CreateParameter("CODIGO",3,1,,COD_ARTICULO)
   	cmd.Parameters.Append = cmd.CreateParameter("MES",200,1,2,"12")
  	cmd.Parameters.Append = cmd.CreateParameter("ANHO",200,1,4,"2008")
 
   	cmd.Execute
   
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function UpdateArticulos()

	query = "SELECT CANTIDAD FROM MOVIMIENTOS "
	query = query & "WHERE FOLIO=" & strNvl(FOLIO) 
	query = query & "AND TIPO='SAL' AND COD_ARTICULO=" & strNvl(COD_ARTICULO) 
	
	Set ORs =oDB.EjecutaSql(query)
	



	rem response.Write("<script>alert(" & ORs.Fields.Item(0).Value & ")</script>")
	
	IF NOT ORs.Eof THEN
		OLD_CANTIDAD =  Cint(ORs.Fields.Item(0).Value) 
	ELSE
		OLD_CANTIDAD = 0
	END IF
		
	query = "UPDATE MOVIMIENTOS SET CANTIDAD = " & strNvl(CANTIDAD) & ", "
	query = query & "VALOR=" & VALOR & " "
	query = query & "WHERE FOLIO=" & strNvl(FOLIO) 
	query = query & "AND TIPO='SAL' AND COD_ARTICULO=" & strNvl(COD_ARTICULO) 
	
	Set ORs =oDB.EjecutaSql(query)
	
	DIFERENCIA = CANTIDAD - OLD_CANTIDAD
	query = "UPDATE EXISTENCIA SET STOCK = STOCK - " & (DIFERENCIA)
	query = query & " WHERE COD_BODEGA = " & strNvl(COD_BODEGA) & " "
	query = query & " AND COD_ARTICULO = " &  strNvl(COD_ARTICULO) & " "
	query = query & " AND UBICACION = " &  strNvl(UBICACION) & " "
	query = query & " AND SECCION = " & strNvl(SECCION) & " " 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Set cmd = Server.CreateObject("ADODB.Command")
   	Set cmd.ActiveConnection = oDB.Conexion

   	cmd.CommandText = "dbo.CalculoSaldo"
   	cmd.CommandType = 4
   
   	cmd.Parameters.Append = cmd.CreateParameter("CODIGO",3,1,,COD_ARTICULO)
   	cmd.Parameters.Append = cmd.CreateParameter("MES",200,1,2,"12")
  	cmd.Parameters.Append = cmd.CreateParameter("ANHO",200,1,4,"2008")
 
   	cmd.Execute
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing	
	Set ODB = Nothing
	
end function


function ListArticulos()
	 
	 query = "SELECT A.ID, A.DESCRIPCION, M.VALOR, M.CANTIDAD, M.UBICACION, M.SECCION "
	 query = query & "FROM ARTICULOS AS A, MOVIMIENTOS AS M  "
 	 query = query & " WHERE A.ID = M.COD_ARTICULO  AND M.FOLIO= " & FOLIO
	 query = query & " AND M.TIPO='SAL'"
	 	 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
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

function ListOT()

	query = "SELECT OT.FOLIO_OT, OT.RESPONSABLE, OT.EQUIPO "
	query = query & " FROM SCI.DBO.OT AS OT, SCI.DBO.ARTICULOS_OT AS A_OT "
	query = query & " WHERE OT.FOLIO_OT = A_OT.FOLIO_OT "
	query = query & " GROUP BY OT.FOLIO_OT, OT.RESPONSABLE, OT.EQUIPO"
	query = query & " ORDER BY OT.FOLIO_OT DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(1).Value & "</RESPONSABLE>"
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(2).Value & "</EQUIPO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
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