<!-- 
METADATA 
TYPE="typelib" 
UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" 
NAME="CDO for Windows 2000 Library" 
--> 

<!--#include file="DBConn.asp" -->
 
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

P_FROM=LCASE(REQUEST("FROM"))
P_TO= REQUEST("TO")
P_TO= REQUEST("P_TO")
SUBJECT=REQUEST("SUBJECT")
FOLIO=REQUEST("FOLIO")
APROBADO=UCASE(REQUEST("APROBADO"))
NOMBRES=REQUEST("NOMBRES")
APELLIDOS=REQUEST("APELLIDOS")
CLIENTE=REQUEST("CLIENTE")
ID=REQUEST("ID")
ID_USER=REQUEST("ID_USER")
BODY=REQUEST("BODY")
EQUIPO=REQUEST("EQUIPO")
CRITICIDAD=REQUEST("CRITICIDAD")
CONTACTO=REQUEST("CONTACTO")
P_CRITICIDAD=REQUEST("P_CRITICIDAD")
PASSWORD=REQUEST("PASSWORD")
DES_EQUIPO=REQUEST("DES_EQUIPO")
E_MAIL=REQUEST("E_MAIL")
FECHA=REQUEST("FECHA")
FECHA_FIN=REQUEST("FECHA_FIN")
IND_SOL=REQUEST("IND_SOL")
EXCEL=REQUEST("EXCEL")

FAMILIA=REQUEST("FAMILIA")
FAENA=REQUEST("FAENA")
INSPECTOR=REQUEST("INSPECTOR")
OBSERVACION=REQUEST("OBSERVACION")
RECOMENDACION=REQUEST("RECOMENDACION")
CAUSA_R=REQUEST("CAUSA_R")
MAIL=REQUEST("MAIL")
SUB_FAMILIA=REQUEST("SUB_FAMILIA")
C=UCASE(REQUEST("c"))
UBICACION=UCASE(REQUEST("UBICACION"))
USERNAME=UCASE(REQUEST("USERNAME"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=REQUEST("VALOR")
PROVEEDOR=REQUEST("PROVEEDOR") 
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
ROL=REQUEST("ROL")
OBS=REQUEST("OBS")


RECURSO=REQUEST("RECURSO")


Select Case RECURSO

	Case "newMail"
		  newMail()

	Case "newMsj"
		  newMsj()
		  
		  
	Case "newMailAviso"
		  newMailAviso()

	Case "newMailPass"
		  newMailPass()
		  
	Case "newMailSupp"
		newMailSupp()
		
	Case "updateMailSupp"
		updateMailSupp()
	
				  
	Case "getMailPass"
		getMailPass()

	Case "getTicket"
		  getTicket()
		  	
	Case "listTickets"
		  listTickets()
	
	Case "listMsj"
		  listMsj()
		  
		  
	Case "destBitacora"
		  destBitacora()
		
End Select


function destBitacora()

query = " SELECT A.FAENA, U.NOMBRES + ' ' + U.APELLIDOS, U.E_MAIL "
query = query & " FROM AVISO_BITACORA AS A, USUARIOS AS U "
query = query & " WHERE A.USUARIO COLLATE SQL_Latin1_General_CP1_CI_AS = U.ID "
query = query & " AND A.FAENA = " & strNvl(FAENA)



Set ORs =oDB.EjecutaSql(query)

Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"' & query
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<MAIL>" & ORs.Fields.Item(2).Value & "</MAIL>"
	  Response.Write "</ROW>"
	  ORs.movenext
	Wend
	Response.Write "</REGISTROS>"
end function


function newMail()
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
	.Cc = "info@vitcomz.com;"
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

function newMailPass()

Dim MailServer
Dim toMail

	
Set CDO_Mail = CreateObject("CDO.Message")
Set CDO_Config = CreateObject("CDO.Configuration")
CDO_Config.Load -1
Set SMTP_Config = CDO_Config.Fields
 
MailServer = "mail.ttminsight.cl"
'***************************************************************

With SMTP_Config
  .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
  .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.vit.cl"
  .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
  .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "info@vit.cl"
  .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "calama2014.,"
  .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
  .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
	.Update
End With


With CDO_Mail
	Set .Configuration = CDO_Config	
End With

 

Randomize
CODE = "vtz" & MID(CDBL(Rnd),3,15) & MID(E_MAIL,1,10)

query =" SELECT * FROM USUARIOS WHERE ID=" & ucase(strNvl(ID_USER))

Set ORs =oDB.EjecutaSql(query)
	
	'response.Write(query)
 
	If  Not ORs.EOF Then
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		  Response.Write "<ROW>" 
		Response.Write "<ERROR>error id de usuario existente. " & query & "</ERROR>"
		  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
		
	else
	

	query = "INSERT INTO USUARIOS (ID, NOMBRES, APELLIDOS, PASSWORD, E_MAIL, EMPRESA, ROL, ESTADO, USERNAME, USERDATE) "
	query = query & " VALUES (" & strNvl(ID_USER) & "," 
	query = query & strNvl(NOMBRES) & "," 
	query = query & strNvl(APELLIDOS) & ","
	query = query & strNvl(PASSWORD) & ","
	query = query & strNvl(E_MAIL) & ","
	query = query & strNvl(EMPRESA) & ","
	query = query & " 'INFORMES',"
	query = query & " 'ACTIVO',"
	query = query & strNvl(USERNAME) & ","
	query = query & "GETDATE())"
	
	Set ORs =oDB.EjecutaSql(query)
	
	End If
	'response.Write(query)
	Session.CodePage = 65001

	BODY =  "<html><meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
	BODY = BODY & "<style>body{font-family:Calibri;font-size:12px;}</style>"
	BODY = BODY & "<body>"
	BODY = BODY & "</br>"

	BODY = BODY & "Estimado  <strong>" & NOMBRES & " " & APELLIDOS & "</strong>, <br /><br />"
	BODY = BODY & "Hemos recibido su solicitud para activar una cuenta con la siguiente información.</br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "ID USUARIO 	:<strong>" & ID_USER & "</strong><BR>"
	BODY = BODY & "NOMBRE   	:<strong>" & NOMBRES & " " & APELLIDOS & "</strong><BR>"
	BODY = BODY & "MAIL     	: <strong>" & E_MAIL & "</strong><BR>"
	BODY = BODY & "PASSWORD 	: <strong>" & PASSWORD & "</strong><BR>"
  
	BODY = BODY & "<br/><br/><br/>"
	BODY = BODY & "Para ingresar, dirígese al siguiente link "
	BODY = BODY & "<a target='_blank' href='https://www.ttminsight.cl'>www.ttminsight.cl</a>.<br/><br/> "
	BODY = BODY & "Gracias por preferir los servicios de TTM-Chile, esperamos que disfrute su experiencia.<br/><br/><br/>" 
	BODY = BODY & "Departamento de Ingeniería en Mantenimiento<BR>"
	BODY = BODY & "TTMChile S.A.<BR>"
	BODY = BODY & "Contacto Fono +569-66904626."
	BODY = BODY & "</body></html> "
	SUBJECT = "Solicitud de cuenta ttminsight.cl  "  & "(" & ID_USER & ")"
	

	Response.ContentType = "text/xml"
	
	If Err.number <> 0 Then
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<ERROR>" & Err.NUMBER & " " & Err.DESCRIPCION & "</ERROR>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
	 
			Response.Charset="utf-8"
			CDO_Mail.Subject =  SUBJECT 
		
			CDO_Mail.From = "info@vit.cl"
			CDO_Mail.Bcc = "julio@vit.cl"
		
			CDO_Mail.To = E_MAIL
			CDO_Mail.HTMLBody = BODY
			CDO_Mail.BodyPart.Charset = "utf-8"
			CDO_Mail.Send

			Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf & VbCrLf
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
			Response.Write "<MAIL>" & E_MAIL &  "</MAIL>"
			Response.Write "<ERROR>enviada correctamente.</ERROR>"
	  		Response.Write "</ROW>"
		 

	End If
	On error Goto 0
Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing
	Set ORS = nothing
		

end function


function getMailPass()

Dim MailServer
Dim toMail
Dim CDO_Mail  
    Dim CDO_Config  
    Dim SMTP_Config  
    Dim strSubject  
    Dim strFrom  
    Dim strTo  
    Dim strCc  
    Dim strBcc  
    Dim strBody  

	
    Set CDO_Mail = CreateObject("CDO.Message")
    Set CDO_Config = CreateObject("CDO.Configuration")
    CDO_Config.Load -1
	Set SMTP_Config = CDO_Config.Fields
	 
	MailServer = "mail.ttminsight.cl"
	'***************************************************************
	
	With SMTP_Config
      .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.vit.cl"
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
      .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "info@vit.cl"
      .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "calama2014.,"
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
        .Update
    End With

   
	With CDO_Mail
		Set .Configuration = CDO_Config	
	End With

	 

	query = "SELECT ID,"
	query = query & "PASSWORD, "
	query = query & " NOMBRES "
	query = query & " FROM USUARIOS AS U "
	query = query & " WHERE E_MAIL=" & strNvl(MAIL)
	' query = query & " AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.EOF Then
		USUARIO = ORs.Fields.Item(0).Value 
   		PASS = ORs.Fields.Item(1).Value 
   		NOMBRE = ORs.Fields.Item(2).Value 
	End IF
	Session.CodePage = 65001
 

	BODY =  "<style>body{font-family:Calibri;font-size:12px;}</style>"
	BODY = BODY & "<body>"
	BODY = BODY & "</br>"
	BODY = BODY & "Estimado Usuario: <br /><br />"
	BODY = BODY & "Los datos de su cuenta para el sistema de monitoreo ttminsight.cl son los siguientes:</br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "NOMBRE	:<strong>" & NOMBRE & "</strong><BR>"
	BODY = BODY & "EMAIL 	:<strong>" & MAIL & "</strong><BR>"
	BODY = BODY & "USUARIO 	:<strong>" & USUARIO & "</strong><BR>"
	BODY = BODY & "PASSWORD	:<strong>" & PASS & "</strong><BR>"
  
	BODY = BODY & " <BR><BR>"
	BODY = BODY & "Para acceder ingrese en el siguiente link "
	BODY = BODY & "<a target='_blank' href='https://www.ttminsight.cl'>https://ttminsight.cl</a><BR>"
	BODY = BODY & "<BR><BR>"
	BODY = BODY & "<BR>" 
	BODY = BODY & "Soporte Fono +569 6690 4626<BR>" 
	BODY = BODY & "</body></html> "
	
	SUBJECT = "Datos de Cuenta TTM Insight : " & USUARIO
	
	Response.ContentType = "text/xml"
	
	If Err.number <> 0 Then
		'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<ERROR>" & Err.NUMBER & " " & Err.DESCRIPCION & "</ERROR>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
	
		If Not ORs.EOF Then
				 
				Response.Charset="utf-8"
				CDO_Mail.Subject =  SUBJECT 
			   
				CDO_Mail.From = "info@vit.cl"
				CDO_Mail.Bcc = "julio@vit.cl"
			   
				CDO_Mail.To = E_MAIL
				CDO_Mail.HTMLBody = BODY
				CDO_Mail.BodyPart.Charset = "utf-8"
				CDO_Mail.Send

			Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf & VbCrLf
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
			Response.Write "<MAIL>" & MAIL &  "</MAIL>"
	  		Response.Write "</ROW>"
		Else
			Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf & VbCrLf
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>FALSE</RETURN>"
	  		Response.Write "</ROW>"
		End If

	End If
	On error Goto 0
Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing
	Set ORS = nothing
		

end function


function newMailAviso()

'Session.LCID = 11274
Session.LCID = 2057
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
	.Item(cdoSendUserName)          = "info@ttminsight.cl" 	' USUARIO DE CORREO QUE ENVIA
	.Item(cdoSendPassword)          = "r3m0lin0"          	' PASSWORD DE USUARIO
	
	'.Item(cdoSendUserName)          = "info@vitcomz.com" 	' USUARIO DE CORREO QUE ENVIA
	'.Item(cdoSendPassword)          = "julius"          	' PASSWORD DE USUARIO


	.Update
End With



	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA,"
	query = query & " B.TIPO_TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.EQUIPO, E.DESCRIPCION AS DESC_EQUIPO,"
	query = query & " B.REPORT, B.CRITICIDAD, B.TIPO_TURNO,  "
	query = query & " B.DANO, B.PRIORIDAD, B.IND_DANO, "
	query = query & " B.CAUSA, B.RECOMENDACION, B.COLOR, B.IND_SOLUCION "
	query = query & " FROM BITACORAS AS B LEFT OUTER JOIN EQUIPOS AS E "
	query = query & " ON B.EQUIPO = E.CODIGO"
	query = query & " WHERE ID=" & ID 
	
	Set ORs =oDB.EjecutaSql(query)
	

	If Not ORs.EOF Then
	
		FECHA= ORs.Fields.Item(1).Value 
  		 ' Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		RESPONSABLE= ORs.Fields.Item(3).Value 
   		DESCRIPCION= ORs.Fields.Item(4).Value 
  		ESTADO=ORs.Fields.Item(5).Value 
		CRITICIDAD=ORs.Fields.Item(10).Value 
  		CAUSA= ORs.Fields.Item(15).Value
		TRATAMIENTO= ORs.Fields.Item(16).Value 
		  EQUIPO =  ORs.Fields.Item(7).Value 
   		  DESC_EQUIPO= ORs.Fields.Item(8).Value 
	End IF
	
Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

	BODY =  "<!DOCTYPE html>"
	BODY = BODY & "<head>"
	BODY = BODY & "<meta http-equiv='content-type' content='text/html;charset=UTF-8' />"
	BODY = BODY & "<style>body{font-family:Calibri;font-size:12px;}</style>"
	BODY = BODY & "<body>"
	BODY = BODY & "</br>"
	BODY = BODY & "Estimado Usuario: <br /><br />"
	BODY = BODY & "Le informamos que se ha registrado una nueva inspección en sistema www.ttminsight.cl</br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "FAENA :<strong>" & FAENA & "</strong><BR>"
	BODY = BODY & "EQUIPO: <strong>" & EQUIPO & " " & DESC_EQUIPO & "</strong><BR>"
	BODY = BODY & "FECHA INSPECCIÓN: <strong>" & FECHA & "</strong><BR>"
	BODY = BODY & "<strong>CRITICIDAD: " & ESTADO & "</strong><br />"
	BODY = BODY & "RESPONSABLE: " & RESPONSABLE & "<BR><BR>"
	BODY = BODY & "OBSERVACIÓN:<strong> " & DESCRIPCION & "</strong><BR><BR><BR>"
	BODY = BODY & "TRATAMIENTO:<strong> " & TRATAMIENTO & "</strong><BR><BR><BR>"
	BODY = BODY & "CAUSA PROBABLE:<strong> " & CAUSA & "</strong><BR><BR><BR>"
	BODY = BODY & "FOTOGRAFIAS :<BR>"
	
	Set ORs = ListFiles("BITACORAS",ID)
	
	While Not ORs.EOF 
		tFile = ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value 
		BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl/sgm/Files/" & tFile & "'>" & tFile & "</a><BR>"
		ORs.MoveNext
	Wend
	  
	BODY = BODY & " <BR><BR>"
	BODY = BODY & "Ud. podra visualizar mas detalles en el modulo de avisos así lo desea.<BR><BR>"
	BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl'>http://www.ttminsight.cl</a><BR>"
	BODY = BODY & "<BR><BR>"
	BODY = BODY & "<BR><BR>Ingenieria en Mantenimiento<BR>"
	BODY = BODY & "TTM Chile.<BR>" 
	BODY = BODY & "www.web-ttm.com<BR>" 
	BODY = BODY & "</body></html> "
	
	SUBJECT = "TTMInsight.cl Aviso de Inspección N: " & ID & "  EQUIPO: " & EQUIPO
	
With objMessage
	.To       = P_TO
	.Cc = "julio@vitcomz.com"
	.From     = P_FROM
	.Subject  = SUBJECT 
	.HTMLBody = BODY
	.Send
End With

Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing

	Response.ContentType = "text/xml"
	
	If Err.number <> 0 Then
		'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<ERROR>" & Err.NUMBER & " " & Err.DESCRIPCION & "</ERROR>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
	  		Response.Write "</ROW>"

	End If
	On error Goto 0

	Set ORS = nothing
		

end function

function newMsj()
Dim MailServer
Dim toMail


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
	.Item(cdoSendUserName)          = "info@ttminsight.cl" 	' USUARIO DE CORREO QUE ENVIA'
	.Item(cdoSendPassword)          = "r3m0lin0"          	' PASSWORD DE USUARIO'

	.Update
End With

Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

query =" SELECT isnull(MAX(ID),0)+1 FROM MENSAJES " ' WHERE EMPRESA="   &	strNvl(EMPRESA)

Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.EOF Then
			N = ORs.Fields.Item(0).Value
	Else
		N = 1
	End If

query =" SELECT E_MAIL FROM USUARIOS WHERE ID= "  &	strNvl(USERNAME)
Set ORs =oDB.EjecutaSql(query)

E_MAIL = ORs.Fields.Item(0).Value


Set ORs =oDB.EjecutaSql(query)
	
	query = "INSERT INTO MENSAJES (ID, ID_PRI, USERNAME, USERDATE, EMPRESA, DESCRIPCION)"
	query = query & " VALUES (" & strNvl(N) & "," 
	query = query & strNvl(FOLIO) & "," 
	query = query & strNvl(USERNAME) & ", GETDATE()," 
	query = query & strNvl(EMPRESA) & ","
	query = query & strNvl(DESCRIPCION) & ")"
	 

	Set ORs =oDB.EjecutaSql(query)
	
	BODY =  "<style>body{font-family:Calibri;font-size:12px;}</style>"
	BODY = BODY & "<body>"
	BODY = BODY & "</br>"
	'BODY = BODY & "Estimado(a)  " & NOMBRES & " " & APELLIDOS & ", <br /><br />"
	BODY = BODY & "Nueva observaci�n al ticket de atenci�n N� " &  FOLIO & " </br> "
	BODY = BODY & "<br><br>"
  
  	BODY = BODY & "MENSAJE :<strong>" & DESCRIPCION & "</strong><BR>"
  
	BODY = BODY & "<br/><br/><br/>"
	BODY = BODY & "Para ver los tickets de atenci�n dir�gese a :<br/><br/>"
	BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl'>www.ttminsight.cl</a>.<br/><br/> "
	BODY = BODY & "<br/><br/>" 
	BODY = BODY & "Soporte Fono 66904626.<BR>" 
	BODY = BODY & "</body></html> "
	
	SUBJECT = "Mensaje de Soporte N� " & FOLIO
	
	
	
	ON ERROR RESUME NEXT
	

With objMessage
	.To       = E_MAIL
	.Cc = "info@vitcomz.com;"
	.From     = "info@ttminsight.cl"
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
			Response.Write "<ERROR>ERROR " & Err.NUMBER & " / " & E_MAIL & "</ERROR>"
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

function newMailSupp()

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
	.Item(cdoSendUserName)          = "info@ttminsight.cl" 	' USUARIO DE CORREO QUE ENVIA'
	.Item(cdoSendPassword)          = "r3m0lin0"          	' PASSWORD DE USUARIO'

	.Update
End With

	
Randomize

CODE = "vtz" & MID(CDBL(Rnd),3,15) & MID(E_MAIL,1,10)

query =" SELECT isnull(MAX(FOLIO),0)+1 FROM TICKETS " ' WHERE EMPRESA="   &	strNvl(EMPRESA)

Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.EOF Then
			N = ORs.Fields.Item(0).Value
	Else
		N = 1
	End If
	
	query = "INSERT INTO TICKETS (FOLIO, CLIENTE, CONTACTO, DESCRIPCION, IMPORTANCIA, FECHA, FECHA_FIN, "
	query = query & " RESPONSABLE, ESTADO, EMPRESA, SOLUCION, IND_SOL, IND_FAC, USERNAME, USERDATE) "
	query = query & " VALUES (" & strNvl(N) & "," 
	query = query & strNvl(FAENA) & "," 
	query = query & strNvl(CONTACTO) & "," 
	query = query & strNvl(OBS) & ","
	query = query & strNvl(IMPORTANCIA) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(FECHA_FIN) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & "'REG',"
	query = query & strNvl(EMPRESA) & ","
	query = query & strNvl(SOLUCION) & "," 
	query = query & strNvl(IND_SOL) & "," 
	query = query & strNvl(IND_FAC) & "," 
	query = query & strNvl(USERNAME) & ","
	query = query & "GETDATE())"
	

	Set ORs =oDB.EjecutaSql(query)
	
	IF IND_SOL = "TRUE" Then
		ESTADO ="CERRADO"
	Else
		ESTADO ="PENDIENTE"
	End If
	
	SELECT CASE IMPORTANCIA
	
				CASE "1"
					IMPORTANCIA="ALTA"
				CASE "2" 
					IMPORTANCIA="MEDIA"
				CASE "3"
					IMPORTANCIA="BAJA"
	
	END SELECT
			
	
	query =" SELECT NOMBRES, APELLIDOS, E_MAIL FROM USUARIOS WHERE ID="   &	strNvl(CONTACTO)
	Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.EOF Then
			NOMBRES = ORs.Fields.Item(0).Value
			APELLIDOS = ORs.Fields.Item(1).Value
			MAIL = ORs.Fields.Item(2).Value
	Else
			Response.Write "Usuario no existe."
		Exit Function
	End If	
			
	
Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

	BODY =  "<style>body{font-family:Calibri;font-size:12px;}</style>"
	BODY = BODY & "<body>"
	BODY = BODY & "</br>"
	BODY = BODY & "Estimado(a)  " & NOMBRES & " " & APELLIDOS & ", <br /><br />"
	BODY = BODY & "Se ha generado un nuevo ticket de atención N " &  N  & " </br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "FECHA   	:<strong>" & FECHA & "</strong><BR>"
	BODY = BODY & "CLIENTE   	:<strong>" & DESC_FAENA & "</strong><BR>"
	BODY = BODY & "IMPORTANCIA  :<strong>" & IMPORTANCIA & "</strong><BR>"
	BODY = BODY & "ESTADO    	:<strong>" & ESTADO & "</strong><BR>"
	BODY = BODY & "OBSERVACIÓN  :<strong>" & OBS & "</strong><BR>"
  
	BODY = BODY & "<br/><br/><br/>"
	BODY = BODY & "Para ver los tickets de atención dirígese a :<br/><br/>"
	BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl'>www.ttminsight.cl</a>.<br/><br/> "
	BODY = BODY & "<br/><br/>" 
	BODY = BODY & "Soporte Fono 66904626.<BR>" 
	BODY = BODY & "</body></html> "
	
	SUBJECT = "TTMInsight.cl Ticket de Soporte N " & N
	

	ON ERROR RESUME NEXT
	
			With objMessage
				.To = MAIL
				.Cc = "julio@vitcomz.com"
				.From     = "info@ttminsight.cl"
				.Subject  = SUBJECT 
				.HTMLBody = BODY
				.Send
			End With
			
			'Response.Write "<ERROR>" & Err.NUMBER &  "</ERROR>"
			
	If Err.number <> 0 Then
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" & Err.number & " " '& Err.descripcion
			Response.Write "<ER>" &  Err.DESCRIPCION & "</ER>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
	 
			Response.ContentType = "text/xml"
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
			Response.Write "<MAIL>Correo enviado a " & MAIL &  " Folio :" & N & "</MAIL>"
			Response.Write "<ERROR>enviada correctamente.</ERROR>"
	  		Response.Write "</ROW>"
		 

	End If
	On error Goto 0
	
Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing
	Set ORS = nothing
		

end function

function updateMailSupp()

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
	.Item(cdoSendUserName)          = "info@ttminsight.cl" 	' USUARIO DE CORREO QUE ENVIA'
	.Item(cdoSendPassword)          = "r3m0lin0"          	' PASSWORD DE USUARIO'

	.Update
End With

 
	query = "UPDATE  TICKETS SET DESCRIPCION =" & strNvl(OBS) & ","
	query = query & " ESTADO =  " & strNvl(ESTADO) & ","
	query = query & " FECHA =  " & strNvl(FECHA) & ","
	query = query & " CLIENTE = " & strNvl(CLIENTE) & ", " 
	query = query & " SOLUCION = " & strNvl(SOLUCION) & ", " 
	query = query & " CONTACTO= " & strNvl(USERNAME) & ", " 
	query = query & " IND_SOL = " & strNvl(IND_SOL) & ", " 
	query = query & " FECHA_FIN = " & strNvl(FECHA_FIN) & " " 
	query = query & " WHERE FOLIO = " & ID
	
	Set ORs =oDB.EjecutaSql(query)
	
	'response.Write(query)
	query =" SELECT NOMBRES, APELLIDOS, E_MAIL FROM USUARIOS WHERE ID= "   &	strNvl(USERNAME)
	Set ORs =oDB.EjecutaSql(query)
	
	If Not ORs.EOF Then
			NOMBRES = ORs.Fields.Item(0).Value
			APELLIDOS = ORs.Fields.Item(1).Value
			MAIL = ORs.Fields.Item(2).Value
	Else
		Exit Function
	End If	
	
	SELECT CASE IMPORTANCIA
	
				CASE "1"
					IMPORTANCIA="ALTA"
				CASE "2" 
					IMPORTANCIA="MEDIA"
				CASE "3"
					IMPORTANCIA="BAJA"
	
	END SELECT
	
	IF IND_SOL = "TRUE" Then
		ESTADO ="CERRADO"
	Else
		ESTADO ="PENDIENTE"
	End If
	
Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

	BODY =  "<style>body{font-family:Calibri;font-size:12px;}</style>"
	BODY = BODY & "<body>"
	BODY = BODY & "</br>"
	BODY = BODY & "Estimado(a)  " & NOMBRES & " " & APELLIDOS & ", <br /><br />"
	BODY = BODY & "Se ha ACTUALIZADO su ticket de atención N " &  ID  & " </br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "FECHA   	:<strong>" & FECHA & "</strong><BR>"
	BODY = BODY & "CLIENTE   	:<strong>" & CLIENTE & "</strong><BR>"
	BODY = BODY & "IMPORTANCIA  :<strong>" & IMPORTANCIA & "</strong><BR>"
	BODY = BODY & "ESTADO    	:<strong>" & ESTADO & "</strong><BR>"
	BODY = BODY & "FECHA FIN  	:<strong>" & FECHA_FIN & "</strong><BR>"
	BODY = BODY & "OBSERVACIÓN  :<strong>" & OBS & "</strong><BR>"
  
	BODY = BODY & "<br/><br/><br/>"
	BODY = BODY & "Para ver los tickets de atención dirígese a :<br/><br/>"
	BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl'>www.ttminsight.cl</a>.<br/><br/> "
	BODY = BODY & "<br/><br/>" 
	BODY = BODY & "Soporte Fono 66904626.<BR>" 
	BODY = BODY & "</body></html> "

	SUBJECT = "TTMInsight.cl Actualización de Ticket N " & ID

	Response.ContentType = "text/xml"
		 
	 If IND_MAIL="YES" Then
			With objMessage
				.To       = MAIL
				.Cc = "julio@vitcomz.com"
				.From     = "info@ttminsight.cl"
				.Subject  = SUBJECT 
				.HTMLBody = BODY
				.Send
			End With
	End If

	If Err.number <> 0 Then
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" & Err.number & " " '& Err.descripcion
			Response.Write "<ER>" &  Err.DESCRIPCION & "</ER>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	Else
	 
			Response.ContentType = "text/xml"
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	 	 	Response.Write "<ROW>" 
			Response.Write "<RETURN>TRUE</RETURN>"
			Response.Write "<MAIL>Correo enviado a " & MAIL &  " Folio :" & ID & "</MAIL>"
			Response.Write "<ERROR>enviada correctamente.</ERROR>"
	  		Response.Write "</ROW>"
		 

	End If

	On error Goto 0
Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing
	Set ORS = nothing
		

end function

Function getTicket()
	
	query = "SELECT  T.FOLIO, T.DESCRIPCION,  convert(varchar,T.FECHA,103),"
		query = query & " lower(U.E_MAIL), T.IMPORTANCIA, T.CLIENTE, "
		query = query & " T.SOLUCION , T.CONTACTO, T.USERDATE, T.ESTADO,"
		query = query & " U.NOMBRES + ' ' + U.APELLIDOS, T.IND_SOL, convert(varchar,T.FECHA_FIN,103)  "
		query = query & " FROM TICKETS AS T"
		query = query & " LEFT OUTER JOIN FAENAS AS F ON F.ID = T.CLIENTE  "
		query = query & " LEFT OUTER JOIN USUARIOS AS U ON U.ID = T.CONTACTO COLLATE DATABASE_DEFAULT  "
	query = query & " WHERE  T.FOLIO=" & strNvl(FOLIO)
 
 
	Set ORs = oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
	   	  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<IMPORTANCIA>" & ORs.Fields.Item(4).Value & "</IMPORTANCIA>"
		  Response.Write "<CLIENTE>" & ORs.Fields.Item(5).Value & "</CLIENTE>"
		  Response.Write "<SOLUCION>" & ORs.Fields.Item(6).Value & "</SOLUCION>"
		  Response.Write "<CONTACTO>" & ORs.Fields.Item(7).Value & "</CONTACTO>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(8).Value & "</USERDATE>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(9).Value & "</ESTADO>"
		  Response.Write "<NOM_CONTACTO>" & ORs.Fields.Item(10).Value & "</NOM_CONTACTO>"
		  
		  Response.Write "<IND_SOL>" & ORs.Fields.Item(11).Value & "</IND_SOL>"
		  Response.Write "<FECHA_FIN>" & ORs.Fields.Item(12).Value & "</FECHA_FIN>"
		  
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing

End Function

function listMsj()

	query = "SELECT ID, DESCRIPCION, USERNAME,  "
	query = query & " rtrim(convert(char,USERDATE,103)) + ' ' + "
	query = query & " substring(convert(char,USERDATE,108),1,5) as FECHA"
	query = query & " FROM MENSAJES "
	query = query & " WHERE ID_PRI = " & strNvl(FOLIO)
	query = query & " ORDER BY 1 DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8' ?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<TEXTO>" & ORs.Fields.Item(1).Value & "</TEXTO>"
	  Response.Write "<USERNAME>" & ORs.Fields.Item(2).Value & "</USERNAME>"
	  Response.Write "<USERDATE>" & ORs.Fields.Item(3).Value & "</USERDATE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


Function listTickets()
	
	Dim IMPORTANCIA
	
	query1 = " SELECT ROL FROM USUARIOS WHERE UPPER(ID)=" & strNvl(USERNAME)
	
	Set ORs = oDB.EjecutaSql(query1)  
	
	IF Not ORs.Eof Then
	
		ROL = ORs.Fields.Item(0).Value
	
	End If
	
	If EXCEL = "YES" Then
		query = "SELECT  T.FOLIO,  convert(varchar,T.FECHA,103), T.FECHA_FIN, T.DESCRIPCION,"
		query = query & " lower(U.E_MAIL), T.IMPORTANCIA, "
		query = query & " F.DESCRIPCION, T.IND_SOL , lower(T.USERNAME), T.USERDATE, T.ESTADO,"
		query = query & " U.NOMBRES + ' ' + U.APELLIDOS, T.IND_SOL, T.IND_FAC, T.DOC_FAC "
		query = query & " FROM TICKETS AS T"
		query = query & " LEFT OUTER JOIN FAENAS AS F ON F.ID = T.CLIENTE  "
		query = query & " LEFT OUTER JOIN USUARIOS AS U ON U.ID = T.CONTACTO COLLATE DATABASE_DEFAULT  "
		query = query & " WHERE 1=1"
	
	Else
	
		query = "SELECT  T.FOLIO, substring(T.DESCRIPCION,1,200)+'...',  convert(varchar,T.FECHA,103),"
		query = query & " lower(U.E_MAIL), T.IMPORTANCIA, "
		query = query & " F.DESCRIPCION, T.SOLUCION , lower(T.USERNAME), T.USERDATE, T.ESTADO,"
		query = query & " U.NOMBRES + ' ' + U.APELLIDOS, T.IND_SOL, T.IND_FAC, T.DOC_FAC ,"
		query = query & " convert(varchar,T.FECHA_FIN,103)"
		query = query & " FROM TICKETS AS T"
		query = query & " LEFT OUTER JOIN FAENAS AS F ON F.ID = T.CLIENTE  "
		query = query & " LEFT OUTER JOIN USUARIOS AS U ON U.ID = T.CONTACTO COLLATE DATABASE_DEFAULT  "
		query = query & " WHERE 1=1" '& strNvl(EMPRESA)
	
	End If
	
	IF ROL<>"ADMIN" THEN
			query = query & " AND T.RESPONSABLE=" & strNvl(USERNAME)
	ELSE
	
		IF (LEN(CLIENTE)>0) THEN
 	 	'	query = query & " AND T.CLIENTE=" & strNvl(CLIENTE)
		END IF
		
 	END IF

	IF IND_SOL="true" THEN
 	 query = query & " AND T.SOLUCION='true'" 
	 
 	END IF
	
	IF IND_FAC="true" THEN
 		' query = query & " AND T.IND_FAC='true'" 
	Else 
		'query = query & " AND (T.IND_FAC IS NULL OR T.IND_FAC ='false')" 
 	END IF

 	IF ROL<>"ADMIN" THEN
		'query = query & " AND  UPPER(T.CONTACTO) =" & strNvl(USERNAME)
	END IF
	
	query = query & " ORDER BY T.FECHA DESC "
	
	Set ORs = oDB.EjecutaSql(query)
	
	If EXCEL = "YES" Then
	
		strName = Date()
		strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
		strName = "tickets_" & strName & ".xls"
		Call Response.BinaryWrite(ChrB(239) & ChrB(187) & ChrB(191))
	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
		Response.Charset="utf-8"
 
	Response.Write "<TABLE>"  
 	  	Response.Write "<TR>" 
	   	  Response.Write "<TD>Folio</TD>"
		  Response.Write "<TD>Fecha Pedido</TD>"
		  Response.Write "<TD>Fecha Entrega</TD>"
		  Response.Write "<TD>Detalle</TD>"
		  Response.Write "<TD>Usuario</TD>"
		  Response.Write "<TD>Faena</TD>"
		  Response.Write "<TD> </TD>"
		Response.Write "</TR>" 
	While Not ORs.EOF 
	  Response.Write "<TR>" 
	   	  Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
		  Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
		  Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
		  Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
		  Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
		 Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
	 
		 If ORs.Fields.Item(7).Value="true" Then
				EST = "FINALIZADA"
			ELSE
				EST = "PENDIENTE"
		 End If
			
		 Response.Write "<TD>" & EST & "</TD>"
		 Response.Write "</TR>"
	  ORs.MoveNext
	Wend
	
	Response.Write "</TABLE>"
	
	Else
	
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query & VbCrLf
 
	While Not ORs.EOF 
	  Response.Write "<ROWS>"  & VbCrLf
	   	Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>" & VbCrLf
		Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>" & VbCrLf
		Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>" & VbCrLf
		Response.Write "<MAIL_CONTACTO>" & ORs.Fields.Item(3).Value & "</MAIL_CONTACTO>" & VbCrLf
		 
		  SELECT CASE ORs.Fields.Item(4).Value 
	
				CASE "1"
					IMPORTANCIA="ALTA"
				CASE "2" 
					IMPORTANCIA="MEDIA"
				CASE "3"
					IMPORTANCIA="BAJA"
	
			END SELECT
   		 Response.Write "<IMP>" & IMPORTANCIA & " " & "</IMP>" & VbCrLf
		 
		 Response.Write "<CLIENTE>" & ORs.Fields.Item(5).Value & "</CLIENTE>" & VbCrLf
		 Response.Write "<SOLUCION>" & ORs.Fields.Item(6).Value & "</SOLUCION>" & VbCrLf
		 Response.Write "<USERNAME>" & ORs.Fields.Item(7).Value & "</USERNAME>" & VbCrLf
		 Response.Write "<USERDATE>" & ORs.Fields.Item(8).Value & "</USERDATE>" & VbCrLf
		  
		 If ORs.Fields.Item(6).Value="true" Then
				EST = "FINALIZADA"
			ELSE
				EST = "PENDIENTE"
		 End If
			
		 	Response.Write "<ESTADO>" & EST & "</ESTADO>"
		 	Response.Write "<CONTACTO>" & ORs.Fields.Item(10).Value & "</CONTACTO>" & VbCrLf
		 	Response.Write "<IND_SOL>" & ORs.Fields.Item(11).Value & "</IND_SOL>" & VbCrLf
		 	Response.Write "<IND_FAC>" & ORs.Fields.Item(12).Value & "</IND_FAC>" & VbCrLf
			Response.Write "<DOC_FAC>" & ORs.Fields.Item(13).Value & "</DOC_FAC>" & VbCrLf
			Response.Write "<FECHA_FIN>" & ORs.Fields.Item(14).Value & "</FECHA_FIN>" & VbCrLf

		 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	
	End If
	
	Set ORs = Nothing
	Set ODB = Nothing

End Function


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