﻿<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
FOLIO=REQUEST("FOLIO")
ESTADOS=REQUEST("ESTADOS")
CANTIDAD=REQUEST("CANTIDAD")
EMPRESA=REQUEST("EMPRESA")
APROBADO=UCASE(REQUEST("APROBADO"))
TIPO=REQUEST("TIPO")
VALOR=REQUEST("VALOR")
CODIGO=REQUEST("CODIGO")
FECHA=REQUEST("FECHA")
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
ESTADO=UCASE(REQUEST("ESTADO"))
SERVICIO=UCASE(REQUEST("SERVICIO"))
OBSERVACION=UCASE(REQUEST("OBSERVACION"))
RESPONSABLE=REQUEST("RESPONSABLE")
TIPO_MONEDA=REQUEST("TIPO_MONEDA")
COND_PAGO=REQUEST("COND_PAGO")
USERNAME=UCASE(REQUEST("USERNAME"))

C=UCASE(REQUEST("c"))



Select Case RECURSO

	Case "GetSolicitud"
		GetSolicitud()
		
	Case "NewSolicitud"
		 NewSolicitud()
		 
	Case "NullSolicitud"
		 NullSolicitud()
		
	Case "UpdateSolicitud"
		 UpdateSolicitud()
				
	Case "UpdateEstadoSolicitud"
		 UpdateEstadoSolicitud()
				
	Case "ListSolicitud"
		ListSolicitud()
	
	Case "ListSolicitudes"
		ListSolicitudes()
	
	Case "ConsultaSolicitudes"
		ConsultaSolicitudes()
		
	Case "ListArticulosOT"
		ListArticulosOT()
		
				
End Select

function NewSolicitud()
	
	query = "SELECT MAX(FOLIO) AS NUM FROM SOLICITUD_COMPRA WHERE EMPRESA=" & strNvl(EMPRESA)
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO SOLICITUD_COMPRA (" 
	query = query & " FOLIO, "
	query = query & " FECHA, "
	query = query & " OBSERVACION, "
	query = query & " ESTADO, "
	query = query & " FECHA_VENCIMIENTO, "
	query = query & " RESPONSABLE,"
	query = query & " TIPO_MONEDA,"
	query = query & " EMPRESA,"
	query = query & " USERNAME, "
	query = query & " USERDATE) "
	query = query & " VALUES ("
	query = query &  N & ","
	query = query &  strNvl(FECHA) & "," 
	query = query &  strNvl(OBSERVACION) & "," 
	query = query &  strNvl(ESTADO) & ","
	query = query &  "GETDATE()+15 ," 
	query = query &  strNvl(RESPONSABLE) & "," 
	query = query &  strNvl(TIPO_MONEDA) & "," 
	query = query &  strNvl(EMPRESA) & ","
	query = query & strNvl(USERNAME) & ","
 	query = query & "getdate())"  
		
	Set ORs =oDB.EjecutaSql(query)
	

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<FOLIO>" & N  & "</FOLIO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function



function ListSolicitud()

	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	Set ORs =oDB.EjecutaSql(query)
	
	ACCESO_DB =  ORs.Fields.Item(0).Value
	AREA =  ORs.Fields.Item(1).Value
	RESPONSABLE_AREA =  ORs.Fields.Item(2).Value

	query = "SELECT S.FOLIO, RTRIM(CONVERT(CHAR, S.FECHA, 103)) AS FECHA, S.RESPONSABLE, S.ESTADO, S.OBSERVACION, "
	query = query & " U.ACCESO_DB, U.AREA AS AREA_USUARIO "
	query = query & " FROM SOLICITUD_COMPRA AS S "
	query = query & " LEFT OUTER JOIN SCI.dbo.USUARIOS AS U ON U.ID = S.RESPONSABLE "
	query = query & " LEFT OUTER JOIN SCI.dbo.AREAS AS A ON A.CODIGO = U.AREA "
	query = query & " WHERE S.ESTADO IN (" & ESTADOS & ") "
	
	If ACCESO_DB <> "true" Then
		If RESPONSABLE_AREA = USERNAME Then
			query = query & " AND A.CODIGO = " & AREA
		Else
			query = query & " AND S.RESPONSABLE = " & strNvl(USERNAME)
		End If
	End If
	
	query = query & " AND S.EMPRESA=" & strNvl(EMPRESA)
	query = query & " ORDER BY S.FOLIO DESC "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
		  Select Case ORs.Fields.Item(3).Value
		  
		  	Case "ING"
		    		Response.Write "<ESTADO>INGRESADA</ESTADO>"
					
			Case "SOL"
 				  	Response.Write "<ESTADO>SOLICITADA</ESTADO>"
				  
		  	Case "APR"
		    		Response.Write "<ESTADO>APROBADA</ESTADO>"
					
			Case "GEN"
		    		Response.Write "<ESTADO>GENERADA</ESTADO>"
			
		  End Select
		Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListSolicitudes()

	query = "SELECT S.FOLIO, RTRIM(CONVERT(CHAR, S.FECHA, 103)) AS FECHA, S.RESPONSABLE, S.ESTADO, S.OBSERVACION, A.DESCRIPCION"
	query = query & " FROM SOLICITUD_COMPRA AS S, SCI.DBO.USUARIOS AS U, SCI.DBO.AREAS AS A"
	query = query & " WHERE S.RESPONSABLE=U.ID AND U.AREA=A.CODIGO"
	query = query & " AND S.ESTADO IN (" & ESTADOS & ") "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
		  Select Case ORs.Fields.Item(3).Value
		  
		  	Case "ING"
		    	 	Response.Write "<ESTADO>INGRESADA</ESTADO>"
					
			Case "SOL"
 				  	Response.Write "<ESTADO>SOLICITADA</ESTADO>"
				  			
			Case "GEN"
		    		Response.Write "<ESTADO>GENERADA</ESTADO>"
					
		  	Case "ENV"
		    		Response.Write "<ESTADO>ENV</ESTADO>"
			
		  End Select
		Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		Response.Write "<AREA>" & ORs.Fields.Item(5).Value & "</AREA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ConsultaSolicitudes()

	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	Set ORs =oDB.EjecutaSql(query)
	
	ACCESO_DB =  ORs.Fields.Item(0).Value
	AREA =  ORs.Fields.Item(1).Value
	RESPONSABLE_AREA =  ORs.Fields.Item(2).Value
	
	query = "SELECT	S.FOLIO, C.FOLIO AS FOLIO_OC, RTRIM(CONVERT(CHAR, S.FECHA, 103)) AS FECHA_SOLICITUD, "
	query = query & "S.ESTADO AS ESTADO_ST,"
	query = query & "	S.OBSERVACION, RTRIM(CONVERT(CHAR, c.FECHA, 103)) AS FECHA_OC, "
	query = query & "	P.NOMBRE, C.ESTADO AS ESTADO_OC, S.RESPONSABLE, A.DESCRIPCION, "
	query = query & "	C.TIPO_MONEDA, C.IND_VB1, A.RESPONSABLE "
	query = query & " FROM	SOLICITUD_COMPRA AS S "
	query = query & " LEFT OUTER JOIN ORDEN_COMPRA AS C ON S.FOLIO=C.FOLIO_ST AND C.EMPRESA=" & strNvl(EMPRESA)
	query = query & " LEFT OUTER JOIN SCI.DBO.USUARIOS AS U ON S.RESPONSABLE=U.ID "
	query = query & " LEFT OUTER JOIN SCI.DBO.AREAS AS A ON U.AREA=A.CODIGO "
	query = query & " LEFT OUTER JOIN PROVEEDORES AS P ON C.PROVEEDOR = P.RUT "
	
	If TIPO = "PENDIENTES" Then
			query = query & " WHERE S.ESTADO IN ('ING','SOL','GEN') "
	else
			query = query & " WHERE S.ESTADO IN ('ENV') "
	End If

	query = query & " AND S.EMPRESA=" & strNvl(EMPRESA)
	
	If ACCESO_DB <> "true" Then
		If RESPONSABLE_AREA = USERNAME Then
			query = query & " AND A.CODIGO = " & AREA
		Else
			query = query & " AND S.RESPONSABLE = " & strNvl(USERNAME)
		End If
	End If
	
	query = query & " ORDER BY S.FOLIO DESC, C.FOLIO DESC"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	FolioSt = 0
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_ST>" & ORs.Fields.Item(0).Value & "</FOLIO_ST>"
		  Response.Write "<FECHA_ST>" & ORs.Fields.Item(2).Value & "</FECHA_ST>"
		  Select Case ORs.Fields.Item(3).Value
		  	Case "ING"
		    	 	ESTADO ="INGRESADA"
			Case "SOL"
 				  	ESTADO ="SOLICITADA"
			Case "GEN"
		    		ESTADO ="GENERADA"
		  	Case "ENV"
		    		ESTADO ="ENVIADA"
			Case "NUL"
		    		ESTADO ="ANULADA"
		  End Select
		  Response.Write "<ESTADO_ST>" & ESTADO & "</ESTADO_ST>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(4).Value & "</OBSERVACION>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(8).Value & "</RESPONSABLE>"
		  Response.Write "<AREA>" & Mid(ORs.Fields.Item(9).Value,1,35) & "</AREA>"
		  Response.Write "<FOLIO_OC>" & ORs.Fields.Item(1).Value & "</FOLIO_OC>"
		  Response.Write "<FECHA_OC>" & ORs.Fields.Item(5).Value & "</FECHA_OC>"
		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(6).Value & "</PROVEEDOR>"
		  Select Case ORs.Fields.Item(7).Value
		  	Case "ING"
		    	 	ESTADO ="INGRESADA"
					VB1 = "Solicitud sin Generar"
			Case "SOL"
 				  	ESTADO ="SOLICITADA"
					VB1 = "Solicitud sin Generar"
			Case "GEN"
		    		ESTADO ="GENERADA"
					VB1 = "Falta Autorizaci�n"
		  	Case "ENV"
		    		ESTADO ="ENVIADA"
			Case "REC"
		    		ESTADO ="RECEPCIONADA"
			Case "NUL"
		    		ESTADO ="ANULADA"
					VB1 = "Solicitud Anulada"
		  End Select
		  Response.Write "<ESTADO_OC>" & ESTADO & "</ESTADO_OC>"
		  Response.Write "<MONEDA>" & ORs.Fields.Item(10).Value & "</MONEDA>"
		  
		  If ORs.Fields.Item(11).Value = "true" Then
		  		VB1 = "Autorizada por Jefatura"
		  End If
		  
		  Response.Write "<AUTORIZA>" & ORs.Fields.Item(12).Value & "</AUTORIZA>"
		  Response.Write "<VB1>" & VB1 & "</VB1>"
		  
		  FolioSt = ORs.Fields.Item(0).Value
	 Response.Write "</ROW>"

	 ORs.MoveNext
	If Not ORs.EOF Then 
	 	If FolioSt = ORs.Fields.Item(0).Value  Then
			Response.Write "<ROW>"
			 	Response.Write "<FOLIO_OC>" & ORs.Fields.Item(1).Value & "</FOLIO_OC>"
		  		Response.Write "<FECHA_OC>" & ORs.Fields.Item(5).Value & "</FECHA_OC>"
		  		Response.Write "<PROVEEDOR>" & ORs.Fields.Item(6).Value & "</PROVEEDOR>"
				
		  	Select Case ORs.Fields.Item(7).Value
		  		Case "ING"
		    	 	ESTADO ="INGRESADA"
					VB1 = "Solicitud sin Generar"
				Case "SOL"
 				  	ESTADO ="SOLICITADA"
					VB1 = "Solicitud sin Generar"
				Case "GEN"
		    		ESTADO ="GENERADA"
					VB1 = "Falta Autorizaci�n"
			  	Case "ENV"
		    		ESTADO ="ENVIADA"
				Case "REC"
		    		ESTADO ="RECEPCIONADA"
				Case "NUL"
		    		ESTADO ="ANULADA"
					VB1 = "Solicitud Anulada"
		  End Select
			  
		 	 If ORs.Fields.Item(11).Value = "true" Then
		  		VB1 = "Autorizada por Jefatura"
		 	 End if
			 
		  	Response.Write "<VB1>" & VB1 & "</VB1>"
			Response.Write "<ESTADO_OC>" & ESTADO & "</ESTADO_OC>"
		   	Response.Write "<AUTORIZA>" & ORs.Fields.Item(12).Value & "</AUTORIZA>"
			Response.Write "</ROW>"
			ORs.MoveNext
		 End If 'END FolioSt
	 End If
		   
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function DeleteArticulosST()

	query = "DELETE FROM ARTICULOS_ST WHERE FOLIO_ST = " & FOLIO
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function
	
function GetSolicitud()
	
	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	Set ORs =oDB.EjecutaSql(query)
	
	ACCESO_DB =  ORs.Fields.Item(0).Value
	AREA =  ORs.Fields.Item(1).Value
	RESPONSABLE_AREA =  ORs.Fields.Item(2).Value
	

	query = "SELECT OC.FOLIO, RTRIM(CONVERT(CHAR, OC.FECHA, 103)) AS FECHA, OC.ESTADO, OC.OBSERVACION,"
	query = query & "  OC.RESPONSABLE, OC.TIPO_MONEDA, A.DESCRIPCION, A.RESPONSABLE AS AUTORIZA, OC.EMPRESA "
	query = query & "  FROM SOLICITUD_COMPRA AS OC "
	query = query & " 	INNER JOIN SCI.[DBO].USUARIOS AS U ON OC.RESPONSABLE = U.ID "
	query = query & " 	INNER JOIN SCI.[DBO].AREAS AS A ON U.AREA = A.CODIGO "
	query = query & " WHERE OC.FOLIO=" & FOLIO & " "
	query = query & " AND OC.EMPRESA=" & strNvl(EMPRESA)
	
	If ACCESO_DB <> "true" Then
		If RESPONSABLE_AREA = USERNAME Then
			query = query & " AND A.CODIGO = " & AREA
		Else
			query = query & " AND OC.RESPONSABLE = " & strNvl(USERNAME)
		End If
	End If
	
	'RESPONSE.Write(query & "//")
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(3).Value & "</OBSERVACION>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(4).Value & "</RESPONSABLE>"
		  Response.Write "<TIPO_MONEDA>" & ORs.Fields.Item(5).Value & "</TIPO_MONEDA>"
  		  Response.Write "<AREA>" & ORs.Fields.Item(6).Value & "</AREA>"
   		  Response.Write "<AUTORIZA>" & ORs.Fields.Item(7).Value & "</AUTORIZA>"
		  Response.Write "<EMPRESA>" & ORs.Fields.Item(8).Value & "</EMPRESA>"
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

function UpdateSolicitud()

	query = "UPDATE SOLICITUD_COMPRA SET ESTADO = " & strNvl(ESTADO) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	query = query & "TIPO_MONEDA=" & strNvl(TIPO_MONEDA) & ","
	query = query & "EMPRESA=" & strNvl(EMPRESA) & ","
	query = query & "COND_PAGO=" & strNvl(COND_PAGO) & ","
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ","
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "DATEUP=GETDATE()"
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
		Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NullSolicitud()

	query = "UPDATE SOLICITUD_COMPRA SET ESTADO = 'NUL'," 
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "DATEUP=GETDATE()"
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
		Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateEstadoSolicitud()

	query = "UPDATE SOLICITUD_COMPRA SET ESTADO = " & strNvl(ESTADO) & ","
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "DATEUP=GETDATE()"
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
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

