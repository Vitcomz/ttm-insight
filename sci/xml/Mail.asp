
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
BODY=REQUEST("BODY")
FAMILIA=REQUEST("FAMILIA")
SUB_FAMILIA=REQUEST("SUB_FAMILIA")
C=UCASE(REQUEST("c"))
UBICACION=UCASE(REQUEST("UBICACION"))
APROBADO=UCASE(REQUEST("APROBADO"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=REQUEST("VALOR")
PROVEEDOR=REQUEST("PROVEEDOR") 
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "NewMail"
		NewMail()

End Select

function NewMail()
Dim MailServer
Dim toMail

'***************************************************************'
MailServer = "mail.ttminsight.cl"
'MailServer = "200.113.109.76"'
'***************************************************************'

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

Dim objConfig  ' As CDO.Configuration'
Dim objMessage ' As CDO.Message'
Dim Fields     ' As ADODB.Fields'

' Get a handle on the config object and it's fields
Set objConfig = Server.CreateObject("CDO.Configuration")
Set Fields = objConfig.Fields

' Set config fields we care about'
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

With objMessage
	.To       = P_TO
	.Bcc = "hsandoval@ttmchile.cl"
	.From     = P_FROM
	.Subject  = SUBJECT 
	.HTMLBody = BODY
	.Send
End With

Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing

	
	If Err.number <> 0 Then
		'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf'
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
%>

