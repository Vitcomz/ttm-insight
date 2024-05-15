<!--  
    METADATA  
    TYPE="typelib"  
    UUID="CD000000-8B95-11D1-82DB-00C04FB1625D"  
    NAME="CDO for Windows 2000 Library"  
--> 

<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

AUTORIZA=REQUEST("AUTORIZA")
APROBADO=UCASE(REQUEST("APROBADO"))
APORTE_EMP=UCASE(REQUEST("APORTE_EMP"))
APORTE_CLI=UCASE(REQUEST("APORTE_CLI"))
GARANTIA=UCASE(REQUEST("GARANTIA"))
VIAJE_FALL=UCASE(REQUEST("VIAJE_FALL"))
STAND_BY=UCASE(REQUEST("STAND_BY"))
RECURSO=REQUEST("RECURSO")
CLIENTE=REQUEST("CLIENTE")
FOLIO=REQUEST("FOLIO")
EXCEL=REQUEST("EXCEL")
ESTADO=UCASE(REQUEST("ESTADO"))
ESTADOS=UCASE(REQUEST("ESTADOS"))
EMAIL=UCASE(REQUEST("EMAIL"))
NO_AUTORIZADA=REQUEST("NO_AUTORIZADA")
FOLIO_ST=REQUEST("FOLIO_ST")
FECHA_INI=REQUEST("FECHA_INI")
FECHA_FIN=REQUEST("FECHA_FIN")
FONO_CONTACTO=REQUEST("FONO_CONTACTO")
FECHA=REQUEST("FECHA")
MAIL=REQUEST("MAIL")
CANTIDAD=REQUEST("CANTIDAD")
CONTACTO=REQUEST("CONTACTO")
SUCURSAL=REQUEST("SUCURSAL")
CODIGO=REQUEST("CODIGO")
COND_PAGO=REQUEST("COND_PAGO")
FECHA=REQUEST("FECHA")
IND_IMPRESION=REQUEST("IND_IMPRESION")
IND_EXENTA=REQUEST("IND_EXENTA")
IND_DIRECTA=REQUEST("IND_DIRECTA")
IND_EXISTENCIA=REQUEST("IND_EXISTENCIA")
IND_PENDIENTE=REQUEST("IND_PENDIENTE")
LUGAR_ENTREGA=REQUEST("LUGAR_ENTREGA")
PLAZO=REQUEST("PLAZO")
RUT_CLIENTE=REQUEST("RUT_CLIENTE")
SERVICIO=UCASE(REQUEST("SERVICIO"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
RESPONSABLE=REQUEST("RESPONSABLE")
TIPO=REQUEST("TIPO")
TIPO_MONEDA=REQUEST("TIPO_MONEDA")
OBSERVACIONES=UCASE(REQUEST("OBSERVACIONES"))
USERNAME=UCASE(REQUEST("USERNAME"))
VALOR=REQUEST("VALOR")
VB1=REQUEST("VB1")
VB2=REQUEST("VB2")
VALIDEZ=REQUEST("VALIDEZ")
C=UCASE(REQUEST("c"))

Select Case RECURSO
		
	Case "getCotizacion"
		  getCotizacion()
		
	Case "setEnvio"
		  setEnvio()
		 
	Case "setImprime"
		  setImprime()
		 
	Case "SetRecepcion"
		 SetRecepcion()
		 
	Case "SetAprueba"
		 SetAprueba()
		 
	Case "GenerarOrden"
		 GenerarOrden()
		 
	Case "newCotizacion"
		  newCotizacion()
		
	Case "updateCotizacion"
		  updateCotizacion()
	
	Case "nullOrdenCompra"
		  nullOrdenCompra()
			
	Case "listCotizacion"
		  listCotizacion()
	
	Case "queryCotizaciones"
		  queryCotizaciones()
		
	Case "ListOCPendientes"
		  ListOCPendientes()
			
End Select


Function GenerarOrden()


query = "SELECT DISTINCT T.FOLIO, T.OBSERVACION, T.PROVEEDOR, T.RESPONSABLE, T.TIPO_MONEDA , T.COND_PAGO, T.EMPRESA, T.IND_EXENTA, T.PLAZO_ENTREGA"
query = query & " FROM (SELECT DISTINCT SC.FOLIO, SC.OBSERVACION, A.PROVEEDOR, SC.RESPONSABLE, A.TIPO_MONEDA, "
query = query & " A.COND_PAGO, SC.EMPRESA, A.IND_EXENTA, A.PLAZO_ENTREGA "
query = query & " 		FROM SOLICITUD_COMPRA AS SC, ARTICULOS_ST AS A "
query = query & " 		WHERE SC.FOLIO=A.FOLIO_ST AND FOLIO=" & FOLIO_ST & " AND  A.EMPRESA=SC.EMPRESA AND A.EMPRESA=" & strNvl(EMPRESA)
query = query & " 		UNION"
query = query & " 		SELECT DISTINCT SC.FOLIO, SC.OBSERVACION, S.PROVEEDOR, SC.RESPONSABLE, S.TIPO_MONEDA, "
query = query & " S.COND_PAGO, SC.EMPRESA, S.IND_EXENTA, S.PLAZO_ENTREGA "
query = query & " 		FROM SOLICITUD_COMPRA AS SC, SERVICIOS_ST AS S "
query = query & " 		WHERE SC.FOLIO=S.FOLIO_ST  AND FOLIO=" & FOLIO_ST & " AND S.EMPRESA=SC.EMPRESA AND S.EMPRESA=" & strNvl(EMPRESA) & ") AS T"

Set ORs1 =oDB.EjecutaSql(query)
	While Not ORs1.EOF 
		OBSERVACION = ORs1.Fields.Item(1).Value 
		RUT_PROVEEDOR = ORs1.Fields.Item(2).Value 
		RESPONSABLE = ORs1.Fields.Item(3).Value 
		TIPO_MONEDA = ORs1.Fields.Item(4).Value 
		COND_PAGO = ORs1.Fields.Item(5).Value
		EMPRESA = ORs1.Fields.Item(6).Value
		IND_EXENTA = ORs1.Fields.Item(7).Value
		PLAZO_ENTREGA = ORs1.Fields.Item(8).Value
		NewOrdenCompra()
		oRs1.MoveNext
	Wend
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	  Response.Write "<ROW>" 
		  Response.Write "<RETURN>YES</RETURN>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs1 = Nothing
	Set oDB = Nothing
End Function


function newCotizacion()

	Dim MailServer
	'MailServer = oDB.GetMailServer()
	
	query = "SELECT MAX(FOLIO) AS NUM FROM COTIZACIONES "

	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "SET DATEFORMAT dmy INSERT INTO COTIZACIONES (" 
	query = query & " FOLIO, "
	query = query & " CLIENTE, "
	query = query & " FECHA, "
	query = query & " DESCRIPCION, "
	query = query & " ESTADO, "
	query = query & " RESPONSABLE, "
	query = query & " SUCURSAL,"
	query = query & " TIPO_MONEDA, "
	query = query & " COND_PAGO, "
	query = query & " IND_DIRECTA, "
	query = query & " LUGAR_ENTREGA, "
	query = query & " PLAZO, "
	query = query & " CONTACTO, "
	query = query & " EMAIL, "
	query = query & " FONO_CONTACTO, "
	query = query & " VB1, "
	query = query & " VALIDEZ, "
	query = query & " USERNAME, "
	query = query & " USERDATE) "
	query = query & " VALUES ("
	query = query &  N & ","
	query = query &  strNvl(RUT_CLIENTE) & "," 
	query = query &  strNvl(FECHA) & "," 
	query = query &  strNvl(DESCRIPCION) & "," 
	query = query &  "'ING'," 
	query = query & strNvl(RESPONSABLE) & "," 
	query = query & strNvl(SUCURSAL) & "," 
	query = query & strNvl(TIPO_MONEDA) & "," 
	query = query & strNvl(COND_PAGO) & "," 
	query = query & strNvl(IND_DIRECTA) & "," 
	query = query & strNvl(LUGAR_ENTREGA) & "," 
	query = query & strNvl(PLAZO) & ","
	query = query & strNvl(CONTACTO) & ","
	query = query & strNvl(EMAIL) & ","
	query = query & strNvl(FONO_CONTACTO) & ","
	query = query & strNvl(VB1) & ","
	query = query & strNvl(VALIDEZ) & ","
	query = query & strNvl(USERNAME) & ","
 	query = query & "getdate())"  
		
	Set ORs =oDB.EjecutaSql(query)
	Set ORs = Nothing
	
	'On Error Resume Next
	
	'Set cdoConfig = CreateObject("CDO.Configuration")  
 
   ' With cdoConfig.Fields  
    '    .Item(cdoSendUsingMethod) = cdoSendUsingPort  
    '    .Item(cdoSMTPServer) = MailServer 
	'	.Item(cdoSMTPconnectiontimeout) = 4
    '    .Update  
    'End With  
 
   ' Set cdoMessage = CreateObject("CDO.Message")  
 
 			Body = "Se ha generado una nueva Cotizaci�n para su aprobaci�n.<br>"
			Body = Body & "<a target='_blank' href='http://www.iskcon.cl/ventas/cotizacion.html?folio=" & N & "'>"
			Body = Body & "Visualizar Cotizaci�n N� " & N & "</a><br><br><br><br><br><br><br>"
			Body = Body & "<font size=-1>Sistema de Compras </font>" & SUCURSAL & "<br>"
			Body = Body & "<font size=-1>Depto. de Sistemas.</font>"  
			
    'With cdoMessage  
    '    Set .Configuration = cdoConfig  
    '    .From = oDB.GetMailAdress(RESPONSABLE)
    '    .To =  oDB.GetMailAdress(AUTORIZA)
     '   .Subject = "Cotizaci�n N� " & N & " ( Autoriza :" & oDB.GetMailAdress(AUTORIZA) & ")"
     '   .HTMLBody = Body
	'	
	'	IF MAIL="NO" THEN
			'DONT SEND.
   '	ELSE
   '   	.Send 
   '	END IF 
   '  End With  
 
   ' Set cdoMessage = Nothing  
   ' Set cdoConfig = Nothing  

'If Err.number <> 0 Then
'	response.Write(err.Description) 
'End If

'On error Goto 0
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<FOLIO>" & N  & "</FOLIO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
End Function


function queryCotizaciones()

Dim strName
Dim TOTAL

query = "SELECT DISTINCT C.FOLIO, RTRIM(CONVERT(CHAR,C.FECHA,103)) AS FECHA,"
query = query & " ESTADO, CL.NOMBRE, C.DESCRIPCION, C.RESPONSABLE, "
query = query & "	 A_CT.VALOR, "
query = query & "	 S_CT.VALOR, C.TIPO_MONEDA, C.SUCURSAL "
query = query & "	FROM COTIZACIONES AS C "
query = query & "	LEFT OUTER JOIN CLIENTES AS CL ON CL.RUT = C.CLIENTE "
query = query & "   LEFT OUTER JOIN (SELECT SUM(VALOR*CANTIDAD) AS VALOR, FOLIO FROM ARTICULOS_CT "
query = query & "		GROUP BY FOLIO) AS A_CT ON A_CT.FOLIO = C.FOLIO "
query = query & "   LEFT OUTER JOIN (SELECT SUM(VALOR*CANTIDAD) AS VALOR, FOLIO FROM SERVICIOS_CT "
query = query & "		GROUP BY FOLIO) AS S_CT ON S_CT.FOLIO = C.FOLIO "
query = query & "	WHERE ESTADO IN ('" & ESTADO & "')"
query = query & "	AND C.SUCURSAL=" & strNvl(SUCURSAL) & ""

	If Len(CLIENTE)>0 Then
		query = query & "	AND CLIENTE =" & CLIENTE 
	End If
	
query = query & "	ORDER BY C.FOLIO DESC"

Set ORs =oDB.EjecutaSql(query)

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = strName & ".xls"
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Folio</TD>"
   				   Response.Write "<TD>Fecha</TD>"
   				   Response.Write "<TD>Estado</TD>"
   				   Response.Write "<TD>Proveedor</TD>"
   				   Response.Write "<TD ALIGN='RIGHT' >Total Neto</TD>"
   				   Response.Write "<TD>Guia</TD>"
  				   Response.Write "<TD>Boleta</TD>"
				   Response.Write "<TD>Factura</TD>"
				   Response.Write "<TD>Tipo Moneda</TD>"
				   Response.Write "<TD>Fecha Recepci�n</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
							  
		Select Case ORs.Fields.Item(2).Value
			Case "ING"
 				  Response.Write "<ESTADO>INGRESADA</ESTADO>"  
			Case "ENV"
 				  Response.Write "<ESTADO>ENVIADA</ESTADO>"
			Case "APR"
		    		Response.Write "<ESTADO>APROBADA</ESTADO>"  
		  	Case "EFE"
		    		Response.Write "<ESTADO>EFECTUADA</ESTADO>"
			Case "NUL"
		    		Response.Write "<ESTADO>ANULADA</ESTADO>"
	   	End Select 
		
		 Response.Write "<CLIENTE>" & ORs.Fields.Item(3).Value & "</CLIENTE>"
		 Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		
		 Response.Write "<RESPONSABLE>" & ORs.Fields.Item(5).Value & "</RESPONSABLE>"

		   If IsNull(ORs.Fields.Item(6).Value) Then
				 		 Response.Write "<TOTAL_NETO>" & formatNumber(numNvl(ORs.Fields.Item(7).Value),2) & "</TOTAL_NETO>"
						 TOTAL = TOTAL +  CDBL(numNvl(ORs.Fields.Item(7).Value))
				  Else
				  		 Response.Write "<TOTAL_NETO>" & formatNumber(numNvl(ORs.Fields.Item(6).Value),2) & "</TOTAL_NETO>"
						 TOTAL = TOTAL +  CDBL(numNvl(ORs.Fields.Item(6).Value))
				  End If
	
		 
		 Response.Write "<TIPO_MONEDA>" & ORs.Fields.Item(8).Value & "</TIPO_MONEDA>"
		 Response.Write "<SUCURSAL>" & ORs.Fields.Item(9).Value & "</SUCURSAL>"
	 
	  	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	 	Response.Write "<ROW>"
		Response.Write "<TOTAL_NETO>" & formatNumber(TOTAL,2) & "</TOTAL_NETO>"
	  	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	End If
	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

function listCotizacion()

	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	' Set ORs =oDB.EjecutaSql(query)
	
	'ACCESO_DB =  ORs.Fields.Item(0).Value
	'AREA =  ORs.Fields.Item(1).Value
	'RESPONSABLE_AREA =  ORs.Fields.Item(2).Value
	

	query = "SELECT DISTINCT C.FOLIO, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECHA, CL.NOMBRE,"
	query = query & " C.DESCRIPCION, C.RESPONSABLE, C.ESTADO, C.SUCURSAL "
	query = query & " FROM COTIZACIONES AS C"
	query = query & " LEFT OUTER JOIN CLIENTES AS CL ON C.CLIENTE = CL.RUT"
	
	IF ESTADOS <> "TOD" THEN
		query = query & " WHERE C.ESTADO IN ('" & ESTADOS & "')  " 'AND C.IND_VB1 IS NULL" 
	END IF
	
	IF NO_AUTORIZADA = "TRUE" THEN
		query = query & " AND C.IND_VB1 IS NULL" 
	END IF
	

	query = query & " AND C.SUCURSAL = " & strNvl(SUCURSAL)

	query = query & " ORDER BY C.FOLIO DESC"
	

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<CLIENTE>" & ORs.Fields.Item(2).Value & "</CLIENTE>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(3).Value & "</DESCRIPCION>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(4).Value & "</RESPONSABLE>"
		  
	  Select Case ORs.Fields.Item(5).Value
			Case "ING"
 				  Response.Write "<ESTADO>INGRESADA</ESTADO>"
			Case "ENV"
 				  Response.Write "<ESTADO>ENVIADA CLIENTE</ESTADO>"
			Case "APR"
		    		Response.Write "<ESTADO>APROBADO</ESTADO>"  
		  	Case "EFE"
		    		Response.Write "<ESTADO>EFECTUADA</ESTADO>"
			Case "NUL"
		    		Response.Write "<ESTADO>ANULADA</ESTADO>"

	  End Select
	  
	  Response.Write "<SUCURSAL>" & ORs.Fields.Item(6).Value & "</SUCURSAL>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function queryCotizacion()

	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	Set ORs =oDB.EjecutaSql(query)
	
	ACCESO_DB =  ORs.Fields.Item(0).Value
	AREA =  ORs.Fields.Item(1).Value
	RESPONSABLE_AREA =  ORs.Fields.Item(2).Value
	

	query = "SELECT C.FOLIO_ST, C.FOLIO, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECHA, P.NOMBRE,"
	query = query & " C.PROJECTO, A.DESCRIPCION, C.RESPONSABLE, C.ESTADO, C.EMPRESA,"
	query = query & " C.IND_VB1, C.IND_VB2, C.IND_IMPRESION, OC_E.IND_EXISTENCIA, A_ST.VALOR, S_ST.VALOR"
	query = query & " FROM ORDEN_COMPRA AS C"
	query = query & " LEFT OUTER JOIN PROVEEDORES AS P ON C.PROVEEDOR = P.RUT"
	query = query & " LEFT OUTER JOIN OC_EXISTENCIAS AS OC_E ON OC_E.FOLIO_OC = C.FOLIO"
	query = query & " LEFT OUTER JOIN (SELECT SUM(VALOR*CANTIDAD) AS VALOR, FOLIO_OC FROM ARTICULOS_ST "
	query = query & "		GROUP BY FOLIO_OC) AS A_ST ON A_ST.FOLIO_OC = C.FOLIO "
	query = query & " LEFT OUTER JOIN (SELECT SUM(VALOR*CANTIDAD) AS VALOR, FOLIO_OC FROM SERVICIOS_ST "
	query = query & "		GROUP BY FOLIO_OC) AS S_ST ON S_ST.FOLIO_OC = C.FOLIO "
	query = query & " 	INNER JOIN SCI.[DBO].USUARIOS AS U ON C.RESPONSABLE = U.ID "
	query = query & " 	INNER JOIN SCI.[DBO].AREAS AS A ON U.AREA = A.CODIGO "
	
	
	IF ESTADOS <> "TOD" THEN
		query = query & " WHERE C.ESTADO IN ('" & ESTADOS & "')  " 'AND C.IND_VB1 IS NULL" 
	END IF
	
	IF NO_AUTORIZADA = "TRUE" THEN
		query = query & " AND C.IND_VB1 IS NULL" 
	END IF
	
	If ACCESO_DB <> "true" Then
		If RESPONSABLE_AREA = USERNAME Then
			query = query & " AND A.CODIGO = " & AREA
		Else
			query = query & " AND C.RESPONSABLE = " & strNvl(USERNAME)
		End If
	End If
	
	IF IND_PENDIENTE = "TRUE" THEN
		query = query & " AND OC_E.IND_EXISTENCIA = 'TRUE'"
		query = query & " AND C.IND_PENDIENTE = 'TRUE'"
	END If
	
	query = query & " AND C.EMPRESA = " & strNvl(EMPRESA)
	query = query & "		  AND C.FECHA >= '" & FECHA_INI & "'"
	query = query & "		  AND C.FECHA <= '" & FECHA_FIN & "'"
	
	query = query & " GROUP BY FOLIO_ST, C.FOLIO, RTRIM(CONVERT(CHAR,FECHA,103)), P.NOMBRE, "
	query = query & " C.PROJECTO, A.DESCRIPCION, C.RESPONSABLE, C.ESTADO, C.EMPRESA, "
	query = query & " C.IND_VB1, C.IND_VB2, C.IND_IMPRESION, OC_E.IND_EXISTENCIA, A_ST.VALOR, S_ST.VALOR "
	query = query & " ORDER BY C.FOLIO DESC"
	

	Set ORs =oDB.EjecutaSql(query)
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>FOLIO</TD>"
   				   Response.Write "<TD>FECHA</TD>"
   				   Response.Write "<TD>PROVEEDOR</TD>"
   				   Response.Write "<TD>PROJECTO</TD>"
   				   Response.Write "<TD>AREA</TD>"
   				   Response.Write "<TD>SOLICITANTE</TD>"
   				   Response.Write "<TD>ESTADO</TD>"
   				   Response.Write "<TD>TOTAL NETO</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
			  	 	Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			  		Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
			  		If IsNull(ORs.Fields.Item(13).Value) Then
				 		 Response.Write "<TD>" & ORs.Fields.Item(14).Value & "</TD>"
				  Else
				  		 Response.Write "<TD>" & ORs.Fields.Item(13).Value & "</TD>"
				  End If
   			 		Response.Write "</TR>"
	 		 	 ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	ELSE
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_ST>" & ORs.Fields.Item(0).Value & "</FOLIO_ST>"
		  Response.Write "<FOLIO>" & ORs.Fields.Item(1).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
  		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(3).Value & "</PROVEEDOR>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(4).Value & "</OBSERVACION>"
		  Response.Write "<AREA>" & ORs.Fields.Item(5).Value & "</AREA>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
		  
	  Select Case ORs.Fields.Item(7).Value
	  
			Case "GEN"
 				  Response.Write "<ESTADO>GENERADA.</ESTADO>"
				  
			Case "ENV"
 				  Response.Write "<ESTADO>ENVIADA PROV.</ESTADO>"
			Case "PRC"
		    		Response.Write "<ESTADO>P. RECEPCIONADA</ESTADO>"  
		  	Case "REC"
		    		Response.Write "<ESTADO>RECEPCIONADA</ESTADO>"
			Case "NUL"
		    		Response.Write "<ESTADO>ANULADA</ESTADO>"

	  End Select
	  			  Response.Write "<EMPRESA>" & ORs.Fields.Item(8).Value & "</EMPRESA>"
	     		  Response.Write "<IND_VB1>" & ORs.Fields.Item(9).Value & "</IND_VB1>"
				  Response.Write "<IND_VB2>" & ORs.Fields.Item(10).Value & "</IND_VB2>"
				  Response.Write "<IND_IMPRESION>" & ORs.Fields.Item(11).Value & "</IND_IMPRESION>"
				  
				  If IsNull(ORs.Fields.Item(13).Value) Then
				 		 Response.Write "<TOTAL_NETO>" & ORs.Fields.Item(14).Value & "</TOTAL_NETO>"
				  Else
				  		 Response.Write "<TOTAL_NETO>" & ORs.Fields.Item(13).Value & "</TOTAL_NETO>"
				  End If
				  
			If ORs.Fields.Item(7).Value="ENV" OR ORs.Fields.Item(7).Value="REC" OR ORs.Fields.Item(7).Value="PRC" Then
   			  		IMAGEN = "images\generado.gif"
				  Else
			  		IMAGEN = "images\generar.gif"
   			End If
	
	 Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	END IF
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getCotizacion()

	query = "SELECT C.FOLIO, RTRIM(CONVERT(CHAR,C.FECHA,103)), C.ESTADO, C.DESCRIPCION,"
	query = query & " C.RESPONSABLE, CL.RUT, CL.DV, CL.NOMBRE, C.TIPO_MONEDA, "
	query = query & " PLAZO, C.VALIDEZ, C.LUGAR_ENTREGA, C.CONTACTO, C.EMAIL, "
	query = query & " C.COND_PAGO, C.VB1, C.SUCURSAL, CL.FONO, C.IND_DIRECTA, C.GARANTIAS, "
	query = query & " C.APORTE_EMP, C.APORTE_CLI, C.VIAJE_FALL, C.STAND_BY, C.FONO_CONTACTO, C.OBSERVACIONES "
	query = query & " FROM COTIZACIONES AS C "
	query = query & " LEFT OUTER JOIN CLIENTES AS CL ON C.CLIENTE=CL.RUT "
	query = query & " WHERE C.FOLIO=" & FOLIO & " "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(3).Value & "</DESCRIPCION>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(4).Value & "</RESPONSABLE>"
  		  Response.Write "<RUT_CLIENTE>" & ORs.Fields.Item(5).Value & "</RUT_CLIENTE>"
   		  Response.Write "<CLIENTE>" & ORs.Fields.Item(7).Value & "</CLIENTE>"	
		  Response.Write "<TIPO_MONEDA>" & ORs.Fields.Item(8).Value & "</TIPO_MONEDA>"
		  Response.Write "<PLAZO>" & ORs.Fields.Item(9).Value & "</PLAZO>"  
		  Response.Write "<VALIDEZ>" & ORs.Fields.Item(10).Value & "</VALIDEZ>"
		  Response.Write "<LUGAR_ENTREGA>" & ORs.Fields.Item(11).Value & "</LUGAR_ENTREGA>" 
		  Response.Write "<CONTACTO>" & ORs.Fields.Item(12).Value & "</CONTACTO>" 
		  Response.Write "<EMAIL>" & ORs.Fields.Item(13).Value & "</EMAIL>"  
		  Response.Write "<COND_PAGO>" & ORs.Fields.Item(14).Value & "</COND_PAGO>"
		  Response.Write "<VB1>" & ORs.Fields.Item(15).Value & "</VB1>"
		  Response.Write "<SUCURSAL>" & ORs.Fields.Item(16).Value & "</SUCURSAL>"
		  Response.Write "<FONO>" & ORs.Fields.Item(17).Value & "</FONO>"
		  Response.Write "<IND_DIRECTA>" & ORs.Fields.Item(18).Value & "</IND_DIRECTA>"
		  Response.Write "<GARANTIA>" & ORs.Fields.Item(19).Value & "</GARANTIA>"
		  Response.Write "<APORTE_EMP>" & ORs.Fields.Item(20).Value & "</APORTE_EMP>"
		  Response.Write "<APORTE_CLI>" & ORs.Fields.Item(21).Value & "</APORTE_CLI>"
		  Response.Write "<VIAJE_FALL>" & ORs.Fields.Item(22).Value & "</VIAJE_FALL>"
		  Response.Write "<STAND_BY>" & ORs.Fields.Item(23).Value & "</STAND_BY>"
		  Response.Write "<FONO_CONTACTO>" & ORs.Fields.Item(24).Value & "</FONO_CONTACTO>"
		  Response.Write "<OBSERVACIONES>" & ORs.Fields.Item(25).Value & "</OBSERVACIONES>"
		 
		  SELECT CASE ORs.Fields.Item(16).Value 
		  		CASE "IQUIQUE"
				Response.Write "<DIR_SUCURSAL>Ruta A-16 Km 8,5 Parcela 2, Alto Hospicio</DIR_SUCURSAL>"
				Response.Write "<FONO_SUCURSAL>57 497403 - 490792</FONO_SUCURSAL>"
				CASE "ANTOFAGASTA"
				Response.Write "<DIR_SUCURSAL>El Salitre 7765</DIR_SUCURSAL>"
				Response.Write "<FONO_SUCURSAL>55 477704 - 477682</FONO_SUCURSAL>"
				
				CASE "CALAMA"
				Response.Write "<DIR_SUCURSAL>Calama</DIR_SUCURSAL>"
				Response.Write "<FONO_SUCURSAL>57 497403 - 490792</FONO_SUCURSAL>"
				
				CASE "SANTIAGO"
				Response.Write "<DIR_SUCURSAL>UNION LATINOAMERICANA 448, STGO.</DIR_SUCURSAL>"
				Response.Write "<FONO_SUCURSAL>Tel: 56-2-680 59 00. Fax: 56-2-689 4686.</FONO_SUCURSAL>"
		  END SELECT 
		  
		 
		  SELECT CASE ORs.Fields.Item(8).Value 
		  		CASE "PE"
				Response.Write "<DES_TIPO_MONEDA>PESOS CHILENOS</DES_TIPO_MONEDA>"
				CASE "EU"
				Response.Write "<DES_TIPO_MONEDA>EUROS</DES_TIPO_MONEDA>"				
				CASE "DO"
				Response.Write "<DES_TIPO_MONEDA>US DOLAR</DES_TIPO_MONEDA>"	
				CASE "LB"
				Response.Write "<DES_TIPO_MONEDA>LIBRA</DES_TIPO_MONEDA>"	
				CASE "UF"
				Response.Write "<DES_TIPO_MONEDA>U.F.</DES_TIPO_MONEDA>"
		  END SELECT 
		  
		  IF UCASE(ORs.Fields.Item(18).Value)="TRUE" THEN
		  		Response.Write "<DESC_EXENTA>NO INCLUYEN IVA</DESC_EXENTA>"
		  ELSE
		  		Response.Write "<DESC_EXENTA>INCLUYEN IVA</DESC_EXENTA>"
		  END IF
		  
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

function updateCotizacion()

	query = "UPDATE COTIZACIONES SET ESTADO = " & strNvl(ESTADO) & ", "
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	query = query & "TIPO_MONEDA=" & strNvl(TIPO_MONEDA) & ","
	query = query & "COND_PAGO=" & strNvl(COND_PAGO) & ","
	query = query & "CONTACTO=" & strNvl(CONTACTO) & ","
	query = query & "EMAIL=" & strNvl(EMAIL) & ","
	query = query & "FONO_CONTACTO=" & strNvl(FONO_CONTACTO) & ","
	query = query & "PLAZO=" & strNvl(PLAZO) & ","
	query = query & "CLIENTE=" & strNvl(RUT_CLIENTE) & ","
	query = query & "IND_DIRECTA=" & strNvl(IND_DIRECTA) & ","
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ","
	query = query & "SUCURSAL=" & strNvl(SUCURSAL) & ","
	query = query & "VB1=" & strNvl(VB1) & ","
	query = query & "VALIDEZ=" & strNvl(VALIDEZ) & ","
	query = query & "LUGAR_ENTREGA=" & strNvl(LUGAR_ENTREGA) & ","
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "GARANTIAS=" & strNvl(GARANTIA) & ","
	query = query & "APORTE_EMP=" & strNvl(APORTE_EMP) & ","
	query = query & "APORTE_CLI=" & strNvl(APORTE_CLI) & ","
	query = query & "VIAJE_FALL=" & strNvl(VIAJE_FALL) & ","
	query = query & "STAND_BY=" & strNvl(STAND_BY) & ","
	query = query & "OBSERVACIONES=" & strNvl(OBSERVACIONES) & ","
	query = query & "DATEUP=GETDATE()"
	query = query & " WHERE FOLIO=" & FOLIO 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS><ROW>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</ROW></REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function nullCotizacion()

	query = "UPDATE COTIZACION SET ESTADO = 'NUL' , "
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "DATEUP=GETDATE()"
	query = query & " WHERE FOLIO=" & FOLIO 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function SetImprime()

	query = "UPDATE ORDEN_COMPRA SET IND_IMPRESION = 'TRUE' "
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND EMPRESA = " & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function SetAprueba()

	query = "UPDATE ORDEN_COMPRA SET IND_VB1 = " & strNvl(VB1) & ","
	query = query & " FECHA_VB1 = GETDATE() " 
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND EMPRESA = " & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function SetRecepcion()

	query = "UPDATE ORDEN_COMPRA SET ESTADO = 'REC', FECHA_RECEPCION= " & strNvl(FECHA_RECEPCION)
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND EMPRESA = " & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function SetEnvio()

	query = "UPDATE ORDEN_COMPRA SET ESTADO = 'ENV', FECHA_ENVIO = GETDATE() "
	query = query & " WHERE FOLIO=" & FOLIO
	query = query & " AND EMPRESA = " & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)
	
	query = "UPDATE SOLICITUD_COMPRA SET ESTADO='ENV'"
	query = query & " WHERE FOLIO = (SELECT FOLIO_ST FROM ORDEN_COMPRA WHERE FOLIO=" & FOLIO & " AND EMPRESA=" & strNvl(EMPRESA) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
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

Function numNvl(Valor)
	if isNull(Valor) then
		numNvl = 0
	else
		numNvl =  Valor	
	end if
end function

function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

