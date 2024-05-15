<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- 
METADATA 
TYPE="typelib" 
UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" 
NAME="CDO for Windows 2000 Library" 
--> 

<!--#include file="..\standard\DBConn.asp" -->
 
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

P_FROM=LCASE(REQUEST("FROM"))
P_TO= REQUEST("TO")
SUBJECT=REQUEST("SUBJECT")
FOLIO=REQUEST("FOLIO")
APROBADO=UCASE(REQUEST("APROBADO"))
ID=REQUEST("ID")
BODY=REQUEST("BODY")
EQUIPO=REQUEST("EQUIPO")
CRITICIDAD=REQUEST("CRITICIDAD")
P_CRITICIDAD=REQUEST("P_CRITICIDAD")
DES_EQUIPO=REQUEST("DES_EQUIPO")
FECHA=REQUEST("FECHA")
FAMILIA=REQUEST("FAMILIA")
FAENA=REQUEST("FAENA")
INSPECTOR=REQUEST("INSPECTOR")
'OBSERVACION=REQUEST("OBSERVACION")
'RECOMENDACION=REQUEST("RECOMENDACION")
'CAUSA_R=REQUEST("CAUSA_R")
SUB_FAMILIA=REQUEST("SUB_FAMILIA")
C=UCASE(REQUEST("c"))
UBICACION=UCASE(REQUEST("UBICACION"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=REQUEST("VALOR")
PROVEEDOR=REQUEST("PROVEEDOR") 
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
RECURSO=REQUEST("RECURSO")


Select Case RECURSO

	Case "NewMail"
		  NewMail()
		  
	Case "NewMailBitacora"
		  NewMailBitacora()

	Case "destBitacora"
		  destBitacora()
		
End Select


function destBitacora()

query = " SELECT A.FAENA, U.NOMBRES + ' ' + U.APELLIDOS, U.E_MAIL "
query = query & " FROM AVISO_BITACORA AS A, USUARIOS AS U "
query = query & " WHERE A.USUARIO COLLATE SQL_Latin1_General_CP1_CI_AS = U.ID "
query = query & " AND A.FAENA = " & strNvl(FAENA)

Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<MAIL>" & ORs.Fields.Item(2).Value & "</MAIL>"
	  Response.Write "</ROW>"
	  ORs.movenext
	Wend
	Response.Write "</REGISTROS>"
end function


function NewMail()
Dim MailServer
Dim toMail

'MailServer = oDB.GetMailServer()
'***************************************************************
MailServer = "mail.ttminsight.cl"

'***************************************************************

Const cdoSendUsingMethod        = _
	"http://schemas.microsoft.com/cdo/configuration/sendusing"
Const cdoSendUsingPort          = 2
Const cdoSMTPServer             = _
	"http://schemas.microsoft.com/cdo/configuration/smtpserver"
Const cdoSMTPServerPort         = _
	"http://schemas.microsoft.com/cdo/configuration/smtpserverport"
Const cdoSMTPConnectionTimeout  = _
	"http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout"
Const cdoSMTPAuthenticate       = _
	"http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"
Const cdoBasic                  = 1
Const cdoSendUserName           = _
	"http://schemas.microsoft.com/cdo/configuration/sendusername"
Const cdoSendPassword           = _
	"http://schemas.microsoft.com/cdo/configuration/sendpassword"

Dim objConfig  ' As CDO.Configuration
Dim objMessage ' As CDO.Message
Dim Fields     ' As ADODB.Fields

' Get a handle on the config object and it's fields
Set objConfig = Server.CreateObject("CDO.Configuration")
Set Fields = objConfig.Fields

' Set config fields we care about
With Fields
	.Item(cdoSendUsingMethod)       = cdoSendUsingPort
	.Item(cdoSMTPServer)            = MailServer
	.Item(cdoSMTPServerPort)        = 25
	.Item(cdoSMTPConnectionTimeout) = 10
	.Item(cdoSMTPAuthenticate)      = cdoBasic
	.Item(cdoSendUserName)          = "info@ttminsight.cl" 	' USUARIO DE CORREO QUE ENVIA
	.Item(cdoSendPassword)          = "r3m0lin0"          	' PASSWORD DE USUARIO
	



	.Update
End With

Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

With objMessage
	.To       = P_TO
	.Cc = "info@ttminsight.cl;"
	.From     = P_FROM
	.Subject  = SUBJECT 
	.HTMLBody = BODY
	.Send
End With

Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing

	
	If Err.number <> 0 Then
		'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<ERROR>" & Err.NUMBER & " " & Err.DESCRIPCION & "</ERROR>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	End If
	On error Goto 0

	Set ORS = nothing
		

end function

function NewMailBitacora()
Dim MailServer
Dim toMail

'MailServer = oDB.GetMailServer()
'***************************************************************
MailServer = "mail.ttminsight.cl"
'MailServer = "mail.vitcomz.com"
'***************************************************************

Const cdoSendUsingMethod        = _
	"http://schemas.microsoft.com/cdo/configuration/sendusing"
Const cdoSendUsingPort          = 2
Const cdoSMTPServer             = _
	"http://schemas.microsoft.com/cdo/configuration/smtpserver"
Const cdoSMTPServerPort         = _
	"http://schemas.microsoft.com/cdo/configuration/smtpserverport"
Const cdoSMTPConnectionTimeout  = _
	"http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout"
Const cdoSMTPAuthenticate       = _
	"http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"
Const cdoBasic                  = 1
Const cdoSendUserName           = _
	"http://schemas.microsoft.com/cdo/configuration/sendusername"
Const cdoSendPassword           = _
	"http://schemas.microsoft.com/cdo/configuration/sendpassword"

Dim objConfig  ' As CDO.Configuration
Dim objMessage ' As CDO.Message
Dim Fields     ' As ADODB.Fields

' Get a handle on the config object and it's fields
Set objConfig = Server.CreateObject("CDO.Configuration")
Set Fields = objConfig.Fields

' Set config fields we care about
With Fields
	.Item(cdoSendUsingMethod)       = cdoSendUsingPort
	.Item(cdoSMTPServer)            = MailServer
	.Item(cdoSMTPServerPort)        = 25
	.Item(cdoSMTPConnectionTimeout) = 10
	.Item(cdoSMTPAuthenticate)      = cdoBasic
	.Item(cdoSendUserName)          = "info@ttminsight.cl" 	' USUARIO DE CORREO QUE ENVIA'
	.Item(cdoSendPassword)          = "r3m0lin0"          	' PASSWORD DE USUARIO'
	
	.Update
End With

Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

	BODY =  "</br>"
	BODY = BODY & "Estimado Usuario: </br>"
	BODY = BODY & "Le informamos que se ha registrado una nueva inspecci�n en TTMInsight.</br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "FAENA :<strong>" & FAENA & "</strong><BR>"
	BODY = BODY & "COMPONENTE: <strong> " & EQUIPO & "</strong><BR>"

	query = "SELECT B.DESCRIPCION, B.CAUSA, B.RECOMENDACION, E.SECCION, DBO.EQUIPOPRINCIPALFAENA(E.CODIGO,E.UBICACION) "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND B.UBICACION = E.UBICACION "
	query = query & " WHERE B.ID=" & strNvl(ID)
	
	Set ORt =oDB.EjecutaSql(query)
	
	if Not ORt.EOF then
		OBSERVACION=ORt.Fields.Item(0).Value
		CAUSA_R=ORt.Fields.Item(1).Value
		RECOMENDACION=ORt.Fields.Item(2).Value
		SECCION=ORt.Fields.Item(3).Value
		EQ_PRINCIPAL=ORt.Fields.Item(4).Value
	end if

	set ORt = nothing
	
	BODY = BODY & "EQUIPO: <strong> " & SECCION & "&nbsp; " & EQ_PRINCIPAL & "&nbsp; " & DES_EQUIPO & "</strong><BR>"
	BODY = BODY & "FECHA INSPECCI�N: <strong>" & FECHA & "</strong><BR><BR>"
	BODY = BODY & "<strong>CRITICIDAD: " & CRITICIDAD &  " " & P_CRITICIDAD & " %"
	BODY = BODY & "INSPECTOR: " & INSPECTOR & "</strong><BR><BR>"
	BODY = BODY & "OBSERVACI�N:<strong> " & OBSERVACION & "</strong><BR><BR><BR>"
	BODY = BODY & "RECOMENDACION:<strong> " & RECOMENDACION & "</strong><BR><BR><BR>"
	BODY = BODY & "CAUSA RAIZ:<strong> " & CAUSA_R & "</strong><BR><BR><BR>"
	BODY = BODY & "FOTOGRAFIAS :<BR>"
	
	Set ORs = ListFiles("BITACORAS",ID)
	
	While Not ORs.EOF 
		tFile = ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value 
		BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl/sgm/Files/" & tFile & "'>" & tFile & "</a><BR>"
		ORs.MoveNext
	Wend
	  
	BODY = BODY & " <BR><BR>"
	BODY = BODY & "Ud. podra visualizar mas detalles en el modulo de Bitacoras as� lo desea.<BR><BR>"
	BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl/loginSGM.html'>http://www.ttminsight.cl</a><BR>"
	BODY = BODY & "<BR><BR>"
	BODY = BODY & "<BR><BR>Depto. de Sistemas<BR>"
	BODY = BODY & "TTMChile S.A.<BR>" 
	BODY = BODY & "Casa Matriz Fono 02-6805900.<BR>" 



	BODY = BODY & "</body></html> "
	'RESPONSE.WRITE BODY
	'RESPONSE.END()

With objMessage
	.To       = P_TO
	.Cc = "info@ttminsight.cl;"
	.From     = P_FROM
	.Subject  = SUBJECT 
	.HTMLBody = BODY
	.Send
End With

Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing

	
	If Err.number <> 0 Then
		'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<ERROR>" & Err.NUMBER & " " & Err.DESCRIPCION & "</ERROR>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	End If
	On error Goto 0

	Set ORs = nothing

end function

function ListFiles(FAMILIA, IDENTIFICADOR)

	query = "SELECT ID, NOMBRE, EXT, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECH, RUTA, FAMILIA, IDENTIFICADOR, SIZE, EXT "
	query = query & "FROM ARCHIVOS "
	query = query & " WHERE FAMILIA = " & strNvl(FAMILIA)
	
	If (LEN(IDENTIFICADOR)>0) Then
		query = query & " AND IDENTIFICADOR = " & strNvl(IDENTIFICADOR)
	End If
	
	query = query & " ORDER BY FECHA DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Set ListFiles = oDB.EjecutaSql(query)
	
	
end function

function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>