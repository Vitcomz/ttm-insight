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

RECURSO=REQUEST("RECURSO")
FOLIO=REQUEST("FOLIO")
EXCEL=REQUEST("EXCEL")
NO_AUTORIZADA=REQUEST("NO_AUTORIZADA")
FOLIO_ST=REQUEST("FOLIO_ST")
FECHA_INI=REQUEST("FECHA_INI")
FECHA_FIN=REQUEST("FECHA_FIN")
FECHA_RECEPCION=REQUEST("FECHA_RECEPCION")
ESTADOS=REQUEST("ESTADOS")
MAIL=REQUEST("MAIL")
CANTIDAD=REQUEST("CANTIDAD")
APROBADO=UCASE(REQUEST("APROBADO"))
VALOR=REQUEST("VALOR")
EMPRESA=REQUEST("EMPRESA")
CODIGO=REQUEST("CODIGO")
FECHA=REQUEST("FECHA")
VB1=REQUEST("VB1")
VB2=REQUEST("VB2")
IND_IMPRESION=REQUEST("IND_IMPRESION")
IND_EXENTA=REQUEST("IND_EXENTA")
IND_EXISTENCIA=REQUEST("IND_EXISTENCIA")
IND_PENDIENTE=REQUEST("IND_PENDIENTE")
AUTORIZA=REQUEST("AUTORIZA")
LUGAR_ENTREGA=REQUEST("LUGAR_ENTREGA")
PLAZO_ENTREGA=REQUEST("PLAZO_ENTREGA")
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
ESTADO=UCASE(REQUEST("ESTADO"))
ESTADOS=UCASE(REQUEST("ESTADOS"))
SERVICIO=UCASE(REQUEST("SERVICIO"))
OBSERVACION=UCASE(REQUEST("OBSERVACION"))
RESPONSABLE=REQUEST("RESPONSABLE")
TIPO=REQUEST("TIPO")
TIPO_MONEDA=REQUEST("TIPO_MONEDA")
COND_PAGO=REQUEST("COND_PAGO")
USERNAME=UCASE(REQUEST("USERNAME"))

C=UCASE(REQUEST("c"))



Select Case RECURSO
		
	Case "GetOC"
		GetOC()
		
	Case "existeOrdenCompra"
		existeOrdenCompra()
		
	Case "SetEnvio"
		SetEnvio()
		 
	Case "SetImprime"
		 SetImprime()
		 
	Case "SetRecepcion"
		 SetRecepcion()
		 
	Case "SetAprueba"
		 SetAprueba()
		 
	Case "GenerarOrden"
		 GenerarOrden()
		 
	Case "NewOrdenCompra"
		 NewOrdenCompra()
		
	Case "UpdateOrdenCompra"
		 UpdateOrdenCompra()
	
	Case "nullOrdenCompra"
		  nullOrdenCompra()
			
	Case "ListOrdenCompra"
		ListOrdenCompra()
	
	Case "ConsultaOC"
		ConsultaOC()
		
		
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


function NewOrdenCompra()

	Dim MailServer
	MailServer = oDB.GetMailServer()
	
	query = "SELECT MAX(FOLIO) AS NUM FROM ORDEN_COMPRA WHERE EMPRESA = " & strNvl(EMPRESA)

	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO ORDEN_COMPRA (" 
	query = query & " FOLIO, "
	query = query & " FOLIO_ST, "
	query = query & " PROVEEDOR, "
	query = query & " FECHA, "
	query = query & " PROJECTO, "
	query = query & " ESTADO, "
	query = query & " FECHA_VENCIMIENTO, "
	query = query & " RESPONSABLE,"
	query = query & " TIPO_MONEDA, "
	query = query & " COND_PAGO, "
	query = query & " LUGAR_ENTREGA, "
	query = query & " EMPRESA, "
	query = query & " IND_PENDIENTE, "
	query = query & " IND_EXENTA, "
	query = query & " PLAZO_ENTREGA, "
	query = query & " USERNAME, "
	query = query & " USERDATE) "
	query = query & " VALUES ("
	query = query &  N & ","
	query = query &  strNvl(FOLIO_ST) & "," 
	query = query &  strNvl(RUT_PROVEEDOR) & "," 
	query = query &  "GETDATE() ," 
	query = query &  strNvl(OBSERVACION) & "," 
	query = query &  "'GEN'," 
	query = query &  "GETDATE() ," 
	query = query &  strNvl(RESPONSABLE) & "," 
	query = query &  strNvl(TIPO_MONEDA) & "," 
	query = query &  strNvl(COND_PAGO) & "," 
	query = query & "'RECINTO PORTUARIO AVDA. GRECIA S/N'," 
	query = query & strNvl(EMPRESA) & "," 
	query = query & "'TRUE'," 
	query = query & strNvl(IND_EXENTA) & ","
	query = query & strNvl(PLAZO_ENTREGA) & ","
	query = query & strNvl(USERNAME) & ","
 	query = query & "getdate())"  
		
	Set ORs =oDB.EjecutaSql(query)
	'response.write(query)
	query = "UPDATE ARTICULOS_ST SET FOLIO_OC=" & N
	query = query & " WHERE FOLIO_ST=" & FOLIO_ST & " AND PROVEEDOR=" & strNvl(RUT_PROVEEDOR)
	query = query & " AND PLAZO_ENTREGA=" & strNvl(PLAZO_ENTREGA) 
	query = query & " AND EMPRESA=" & strNvl(EMPRESA) 

	Set ORs =oDB.EjecutaSql(query)
	'response.write(query)
	query = "UPDATE SERVICIOS_ST SET FOLIO_OC=" & N
	query = query & " WHERE FOLIO_ST=" & FOLIO_ST & " AND PROVEEDOR=" & strNvl(RUT_PROVEEDOR)
	query = query & " AND PLAZO_ENTREGA=" & strNvl(PLAZO_ENTREGA)
	query = query & " AND EMPRESA=" & strNvl(EMPRESA) 

	Set ORs =oDB.EjecutaSql(query)
	'response.write(query)
	Set ORs = Nothing
	
	On Error Resume Next
	
	Set cdoConfig = CreateObject("CDO.Configuration")  
 
    With cdoConfig.Fields  
        .Item(cdoSendUsingMethod) = cdoSendUsingPort  
        .Item(cdoSMTPServer) = MailServer 
		.Item(cdoSMTPconnectiontimeout) = 4
        .Update  
    End With  
 
    Set cdoMessage = CreateObject("CDO.Message")  
 
 			Body = "Se ha generado una nueva Orden de Compra para su aprobaci�n.<br>"
			Body = Body & "<a target='_blank' href='http://caspana/existencias/OrdenCompra.html?Folio=" & N & "'>"
			Body = Body & "Visualizar Orden de Compra N� " & N & "</a><br><br><br><br><br><br><br>"
			Body = Body & "<font size=-1>Sistema de Compras </font>" & EMPRESA & "<br>"
			Body = Body & "<font size=-1>Depto. de Sistemas.</font>"  
			
    With cdoMessage  
        Set .Configuration = cdoConfig  
        .From = oDB.GetMailAdress(RESPONSABLE)
        .To =  oDB.GetMailAdress(AUTORIZA)
        .Subject = "Orden de Compra N� " & N & " ( Autoriza :" & oDB.GetMailAdress(AUTORIZA) & ")"
        .HTMLBody = Body
		
		IF MAIL="NO" THEN
			'DONT SEND.
		ELSE
        	.Send 
		END IF 
    End With  
 
    Set cdoMessage = Nothing  
    Set cdoConfig = Nothing  

If Err.number <> 0 Then
	response.Write(err.Description) 
End If

'On error Goto 0

End Function


function ListOCPendientes()

Dim strName

query = "SELECT DISTINCT OC.FOLIO AS ORDEN_COMPRA, RTRIM(CONVERT(CHAR,OC.FECHA,103)) AS FECHA,"
query = query & " ESTADO, P.NOMBRE, OC.OBSERVACION, OC.IND_PENDIENTE, "
query = query & "	 D1.FOLIO AS GUIA,"
query = query & "	 D2.FOLIO AS BOLETA,"
query = query & "	 D3.FOLIO AS FACTURA,"
'query = query & "	 convert(varchar(30),convert(money,A_ST.VALOR),1),"
'query = query & "	 CONVERT(VARCHAR(20),CONVERT(MONEY,S_ST.VALOR),1) , OC.TIPO_MONEDA, OC.FECHA_RECEPCION "
query = query & "	 A_ST.VALOR, "
query = query & "	 S_ST.VALOR, OC.TIPO_MONEDA, OC.FECHA_RECEPCION "

query = query & "	FROM ORDEN_COMPRA AS OC"
query = query & "	LEFT OUTER JOIN DOCUMENTOS AS D1 ON D1.ORDEN_COMPRA = OC.FOLIO AND D1.TIPO_DOCUMENTO='GUI' AND D1.EMPRESA=" & strNvl(EMPRESA)
query = query & "	LEFT OUTER JOIN DOCUMENTOS AS D2 ON D2.ORDEN_COMPRA = OC.FOLIO AND D2.TIPO_DOCUMENTO='BOL'  AND D2.EMPRESA=" & strNvl(EMPRESA)
query = query & "	LEFT OUTER JOIN DOCUMENTOS AS D3 ON D3.ORDEN_COMPRA = OC.FOLIO AND D3.TIPO_DOCUMENTO='FAC'  AND D3.EMPRESA=" & strNvl(EMPRESA) 
query = query & "	LEFT OUTER JOIN PROVEEDORES AS P ON P.RUT = OC.PROVEEDOR"
query = query & " 	LEFT OUTER JOIN OC_EXISTENCIAS AS OC_E ON OC_E.FOLIO_OC = OC.FOLIO AND OC_E.EMPRESA=" & strNvl(EMPRESA)
query = query & "   LEFT OUTER JOIN (SELECT SUM(VALOR*CANTIDAD) AS VALOR, FOLIO_OC FROM ARTICULOS_ST "
query = query & "		GROUP BY FOLIO_OC) AS A_ST ON A_ST.FOLIO_OC = OC.FOLIO "
query = query & "   LEFT OUTER JOIN (SELECT SUM(VALOR*CANTIDAD) AS VALOR, FOLIO_OC FROM SERVICIOS_ST "
query = query & "		GROUP BY FOLIO_OC) AS S_ST ON S_ST.FOLIO_OC = OC.FOLIO "

IF ESTADOS = "PEN"  THEN
		query = query & "	WHERE IND_PENDIENTE = 'TRUE'"
		query = query & " AND OC_E.IND_EXISTENCIA = 'TRUE'"
ELSE
query = query & "	WHERE ESTADO IN ('" & ESTADOS & "')"
END IF

	query = query & "		  AND OC.FECHA >= '" & FECHA_INI & "'"
	query = query & "		  AND OC.FECHA <= '" & FECHA_FIN & "'"
	query = query & "		  AND OC.EMPRESA = " & strNvl(EMPRESA)
	
query = query & "	ORDER BY OC.FOLIO DESC"

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
				   Response.Write "<TD>" & ORs.Fields.Item(11).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(12).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<ORDEN_COMPRA>" & ORs.Fields.Item(0).Value & "</ORDEN_COMPRA>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  
		   Select Case ORs.Fields.Item(2).Value
			Case "GEN"
 				  Response.Write "<ESTADO>GENERADA.</ESTADO>"  
			Case "ENV"
 				  Response.Write "<ESTADO>ENVIADA PROV.</ESTADO>"
			Case "PRC"
		    		Response.Write "<ESTADO>P. RECEPCIONADA</ESTADO>"  
		  	Case "REC"
		    		Response.Write "<ESTADO>RECEPCIONADA</ESTADO>"
	  		End Select 
		
		 Response.Write "<PROVEEDOR>" & ORs.Fields.Item(3).Value & "</PROVEEDOR>"
		 Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		 
		  If ORs.Fields.Item(2).Value = "REC"  Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
    	 End If
		
		 Response.Write "<GUIA>" & ORs.Fields.Item(6).Value & "</GUIA>"
		 Response.Write "<BOLETA>" & ORs.Fields.Item(7).Value & "</BOLETA>"
		 Response.Write "<FACTURA>" & ORs.Fields.Item(8).Value & "</FACTURA>"  
		   If IsNull(ORs.Fields.Item(9).Value) Then
				 		 Response.Write "<TOTAL_NETO>" & ORs.Fields.Item(10).Value & "</TOTAL_NETO>"
				  Else
				  		 Response.Write "<TOTAL_NETO>" & ORs.Fields.Item(9).Value & "</TOTAL_NETO>"
				  End If
	
		 Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
		 
		 Response.Write "<TIPO_MONEDA>" & ORs.Fields.Item(11).Value & "</TIPO_MONEDA>"
		 Response.Write "<FECHA_RECEPCION>" & ORs.Fields.Item(12).Value & "</FECHA_RECEPCION>"
	 
	  	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	End If
	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

function ListOrdenCompra()

	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	Set ORs =oDB.EjecutaSql(query)
	
	ACCESO_DB =  ORs.Fields.Item(0).Value
	AREA =  ORs.Fields.Item(1).Value
	RESPONSABLE_AREA =  ORs.Fields.Item(2).Value
	

	query = "SELECT C.FOLIO_ST, C.FOLIO, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECHA, P.NOMBRE,"
	query = query & " C.OBSERVACION, C.RESPONSABLE, C.ESTADO, C.EMPRESA,"
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

	query = query & " GROUP BY FOLIO_ST, C.FOLIO, RTRIM(CONVERT(CHAR,FECHA,103)), P.NOMBRE, "
	query = query & " C.OBSERVACION, C.RESPONSABLE, C.ESTADO, C.EMPRESA, "
	query = query & " C.IND_VB1, C.IND_VB2, C.IND_IMPRESION, OC_E.IND_EXISTENCIA, A_ST.VALOR, S_ST.VALOR "
	query = query & " ORDER BY C.FOLIO DESC"
	

	Set ORs =oDB.EjecutaSql(query)
	RESPONSE.Write(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_ST>" & ORs.Fields.Item(0).Value & "</FOLIO_ST>"
		  Response.Write "<FOLIO>" & ORs.Fields.Item(1).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
  		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(3).Value & "</PROVEEDOR>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(4).Value & "</OBSERVACION>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(5).Value & "</RESPONSABLE>"
		  
	  Select Case ORs.Fields.Item(6).Value
	  
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
	  			  Response.Write "<EMPRESA>" & ORs.Fields.Item(7).Value & "</EMPRESA>"
	     		  Response.Write "<IND_VB1>" & ORs.Fields.Item(8).Value & "</IND_VB1>"
				  Response.Write "<IND_VB2>" & ORs.Fields.Item(9).Value & "</IND_VB2>"
				  Response.Write "<IND_IMPRESION>" & ORs.Fields.Item(10).Value & "</IND_IMPRESION>"
				  
				  If IsNull(ORs.Fields.Item(12).Value) Then
				 		 Response.Write "<TOTAL_NETO>" & ORs.Fields.Item(13).Value & "</TOTAL_NETO>"
				  Else
				  		 Response.Write "<TOTAL_NETO>" & ORs.Fields.Item(12).Value & "</TOTAL_NETO>"
				  End If
				  
	If ORs.Fields.Item(6).Value="ENV" OR ORs.Fields.Item(6).Value="REC" OR ORs.Fields.Item(6).Value="PRC" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
    End If
	
	 Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function ConsultaOC()

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

function GetOC()

	query = "SELECT U.ACCESO_DB, U.AREA, A.RESPONSABLE "
	query = query & " FROM SCI.dbo.USUARIOS AS U, SCI.dbo.AREAS AS A"
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USERNAME)
	
	
	Set ORs =oDB.EjecutaSql(query)
	
	ACCESO_DB =  ORs.Fields.Item(0).Value
	AREA =  ORs.Fields.Item(1).Value
	RESPONSABLE_AREA =  ORs.Fields.Item(2).Value
	
	query = "SELECT OC.FOLIO, RTRIM(CONVERT(CHAR, OC.FECHA, 103)) AS FECHA, OC.ESTADO, OC.OBSERVACION, OC.PROJECTO, "
	query = query & " OC.RESPONSABLE, OC.PROVEEDOR, P.DV, OC.TIPO_MONEDA, "
	query = query & " OC.COND_PAGO, P.NOMBRE, OC.EMPRESA, P.DIRECCION, C.DESCRIPCION,"
	query = query & " P.RUBRO, P.FONO, OC.IND_VB1, OC.IND_VB2, OC.IND_IMPRESION,"
	query = query & " OC.IND_EXENTA, OC.LUGAR_ENTREGA, OC.PLAZO_ENTREGA, M.NOMBRE, "
	query = query & " U.NOMBRES, U.APELLIDOS, A.RESPONSABLE, A.DESCRIPCION "
	query = query & " FROM ORDEN_COMPRA AS OC"
	query = query & " LEFT OUTER JOIN PROVEEDORES AS P ON OC.PROVEEDOR=P.RUT"
	query = query & " LEFT OUTER JOIN MONEDAS AS M ON  OC.TIPO_MONEDA=M.SIMBOLO"
	query = query & " LEFT OUTER JOIN SCI.dbo.USUARIOS AS U ON OC.RESPONSABLE=U.ID"
	query = query & " LEFT OUTER JOIN SCI.dbo.AREAS AS A ON U.AREA=A.CODIGO"
	query = query & " LEFT OUTER JOIN SCI.dbo.CIUDADES AS C ON P.CIUDAD=C.ID"
	query = query & " WHERE OC.FOLIO=" & FOLIO 
	query = query & " AND OC.EMPRESA=" & strNvl(EMPRESA)

	If ACCESO_DB <> "true" Then
		If RESPONSABLE_AREA = USERNAME Then
			query = query & " AND A.CODIGO = " & AREA
		Else
			query = query & " AND OC.RESPONSABLE = " & strNvl(USERNAME)
		End If
	End If
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(3).Value & "</OBSERVACION>"
		  Response.Write "<PROJECTO>" & ORs.Fields.Item(4).Value & "</PROJECTO>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(5).Value & "</RESPONSABLE>"
  		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(6).Value & _
    		  								"-" & ORs.Fields.Item(7).Value & "</RUT_PROVEEDOR>"
		  Response.Write "<TIPO_MONEDA>" & ORs.Fields.Item(8).Value & "</TIPO_MONEDA>"
   		  Response.Write "<COND_PAGO>" & ORs.Fields.Item(9).Value & "</COND_PAGO>"
   		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(10).Value & "</PROVEEDOR>"
		  Response.Write "<EMPRESA>" & ORs.Fields.Item(11).Value & "</EMPRESA>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(12).Value & "</DIRECCION>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(13).Value & "</CIUDAD>"
		  Response.Write "<GIRO>" & ORs.Fields.Item(14).Value & "</GIRO>"
		  Response.Write "<FONO>" & ORs.Fields.Item(15).Value & "</FONO>"
		  Response.Write "<VB1>" & ORs.Fields.Item(16).Value & "</VB1>"
		  Response.Write "<VB2>" & ORs.Fields.Item(17).Value & "</VB2>"
		  Response.Write "<IND_IMPRESION>" & ORs.Fields.Item(18).Value & "</IND_IMPRESION>"
		  Response.Write "<IND_EXENTA>" & ORs.Fields.Item(19).Value & "</IND_EXENTA>"
	  	  Response.Write "<LUGAR_ENTREGA>" & ORs.Fields.Item(20).Value & "</LUGAR_ENTREGA>"
		  Response.Write "<PLAZO_ENTREGA>" & ORs.Fields.Item(21).Value & "</PLAZO_ENTREGA>"
		  Response.Write "<DES_MONEDA>" & ORs.Fields.Item(22).Value & "</DES_MONEDA>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(23).Value & "</NOMBRES>"
		  Response.Write "<APELLIDOS>" & ORs.Fields.Item(24).Value & "</APELLIDOS>"
		  Response.Write "<RESP_AREA>" & ORs.Fields.Item(25).Value & "</RESP_AREA>"
		  Response.Write "<AREA>" & ORs.Fields.Item(26).Value & "</AREA>"
	      Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetSolicitud()

	query = "SELECT OC.FOLIO, OC.FECHA, OC.ESTADO, OC.OBSERVACION,"
	query = query & "  OC.RESPONSABLE, A.DESCRIPCION, A.RESPONSABLE AS AUTORIZA, "
	query = query & "  OC.PROVEEDOR, P.NOMBRE "
	query = query & "  FROM ORDEN_COMPRA AS OC "
	query = query & " 	INNER JOIN SCI.[DBO].USUARIOS AS U ON OC.RESPONSABLE = U.ID "
	query = query & " 	INNER JOIN SCI.[DBO].AREAS AS A ON U.AREA = A.CODIGO "
	query = query & " 	LEFT OUTER JOIN PROVEEDORES AS P ON OC.PROVEEDOR=P.RUT "
	query = query & " WHERE OC.FOLIO=" & FOLIO & " "

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
  		  Response.Write "<AREA>" & ORs.Fields.Item(5).Value & "</AREA>"
   		  Response.Write "<AUTORIZA>" & ORs.Fields.Item(6).Value & "</AUTORIZA>"
   		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(7).Value & "</RUT_PROVEEDOR>"
   		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(8).Value & "</PROVEEDOR>"
		  
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

function UpdateOrdenCompra()

	query = "UPDATE ORDEN_COMPRA SET ESTADO = " & strNvl(ESTADO) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	query = query & "TIPO_MONEDA=" & strNvl(TIPO) & ","
	query = query & "COND_PAGO=" & strNvl(COND_PAGO) & ","
	query = query & "PROVEEDOR=" & strNvl(RUT_PROVEEDOR) & ","
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ","
	query = query & "EMPRESA=" & strNvl(EMPRESA) & ","
	query = query & "IND_VB1=" & strNvl(VB1) & ","
	query = query & "IND_VB2=" & strNvl(VB2) & ","
	query = query & "IND_EXENTA=" & strNvl(IND_EXENTA) & ","
	query = query & "LUGAR_ENTREGA=" & strNvl(LUGAR_ENTREGA) & ","
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "DATEUP=GETDATE()"
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

function nullOrdenCompra()

	query = "UPDATE ORDEN_COMPRA SET ESTADO = 'NUL' , "
	query = query & "USERUPDATE=" & strNvl(USERNAME) & ","
	query = query & "DATEUP=GETDATE()"
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

function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

