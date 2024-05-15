
<!--#include file="../standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ID=UCASE(REQUEST("ID"))
PASSWORD=REQUEST.Form("PASSWORD")
RUT=REQUEST("RUT")
TXTSRC=REQUEST("TXTSRC")
DV=UCASE(REQUEST("DV"))
NOMBRES=UCASE(REQUEST("NOMBRES"))
APELLIDOS=UCASE(REQUEST("APELLIDOS"))
ESTADO=REQUEST("ESTADO")
ACCESO_DB=REQUEST("ACCESO_DB")
ACCESO_EMP=REQUEST("ACCESO_EMP")
SEXO=REQUEST("SEXO")
SISTEMA=REQUEST("SISTEMA")
PASSWORD=REQUEST("PASSWORD")
FECHA=REQUEST("FECHA")
FECHA_NAC=REQUEST("FECHA_NAC")
EMAIL=REQUEST("EMAIL")
EMPRESA=REQUEST("EMPRESA")
FONO=REQUEST("FONO")
CELULAR=REQUEST("CELULAR")
AREA=UCASE(REQUEST("AREA"))
LUGAR=UCASE(REQUEST("LUGAR"))
CARGO=UCASE(REQUEST("CARGO"))
ROL=REQUEST("ROL")
RECURSO=REQUEST("RECURSO")

select case RECURSO
	case "GetUsuario"
		  GetUsuario()
			
	case "NewUsuario"
		  NewUsuario()
		
	case "UpdateUsuario"
		  UpdateUsuario
		
	case "ListUsuarios"
		  ListUsuarios()
	
	case "updatePassword"
		updatePassword()
		
	case "passwordMassive"
		passwordMassive()
		
	case "mail"
		mail()

	case "mailPassword"
		  mailPassword()
		
	case "ListRoles"
		  ListRoles()
		
	case "listFaenas"
		  listFaenas()
		
	case "ListCargos"
		  ListCargos()

	case "UsuariosSistemas"
		  UsuariosSistemas()
		
	case "ExisteUsuario"
		  ExisteUsuario()
		
	case "ValidaPass" 
	 	  ValidaPass() 
end select

function ValidaPass() 

	query = "SELECT PASSWORD FROM USUARIOS WHERE ID =" & strNvl(ID) & " AND ESTADO='ACTIVO'" 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	If Not ORs.EOF Then
		  	If ORs.Fields.Item(0).Value  = PASSWORD Then
				  Response.Write "<ROW>True</ROW>"
			Else
				  Response.Write "<ROW>False</ROW>"
			End If
	Else
		  Response.Write "<ROW>False</ROW>"
	End If
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ExisteUsuario() 

	query = "SELECT * FROM USUARIOS WHERE ID ='" & ID & "'"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "<ROW>"
	
	If Not ORs.EOF Then
				  Response.Write "<Exist>True</Exist>"
	ELSE
				  Response.Write "<Exist>False</Exist>"
	End If
	
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewUsuario()

	query = "insert into usuarios (id, rut, dv, nombres, apellidos,sexo, fecha_nac, "
	query = query & " estado, cargo, rol, password,  e_mail, acceso_db, ubicacion, fono, celular, area, userdate,"
	query = query & " username) VALUES ('"
	query = query & ID & "'," & RUT & ",'" & DV & "','" 
	query = query & NOMBRES & "','" & APELLIDOS & "', '" 
	query = query & SEXO & "', " & strNvl(FECHA_NAC) & ",'ACTIVO'," 
	query = query & strNvl(CARGO) & "," & strNvl(ROL) & "," & strNvl(PASSWORD) & "," 
	query = query & strNvl(EMAIL) & "," & strNvl(ACCESO_DB) & "," & strNvl(LUGAR) & "," 
	query = query & strNvl(FONO) & "," & strNvl(CELULAR) & "," & strNvl(AREA) & ",getdate(),'system');"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function ListUsuarios()
	query = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO,"
	query = query & " ROL, E_MAIL, UBICACION, FONO, CELULAR, AREA, USERDATE "
	query = query & " FROM USUARIOS "
	query = query & " WHERE NOMBRES LIKE '%" & 	TXTSRC & "%' AND ROL<>'DEVOTO'"
	
	IF ROL<>"TOD" AND LEN(ROL)>0 THEN
		query = query & " AND ROL = " & strNvl(ROL)
	END IF
	
	query = query & " ORDER BY NOMBRES, APELLIDOS "
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<RUT>" & ORs.Fields.Item(1).Value & "</RUT>"
	  Response.Write "<NOMBRES>" & ORs.Fields.Item(2).Value & "</NOMBRES>"
	  Response.Write "<APELLIDOS>" & ORs.Fields.Item(3).Value & "</APELLIDOS>"
	  Response.Write "<ESTADO>" & ORs.Fields.Item(4).Value & "</ESTADO>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(5).Value & "</CARGO>"
	  Response.Write "<ROLES>" & ORs.Fields.Item(6).Value & "</ROLES>"
	  Response.Write "<E_MAIL>" & ORs.Fields.Item(7).Value & "</E_MAIL>"
	  Response.Write "<UBICACION>" & ORs.Fields.Item(8).Value & "</UBICACION>"
	  Response.Write "<FECHA>" & ORs.Fields.Item(9).Value & "</FECHA>"
	  Response.Write "<FONO>" & ORs.Fields.Item(10).Value & "</FONO>"
	  Response.Write "<CELULAR>" & ORs.Fields.Item(11).Value & "</CELULAR>"
	  Response.Write "<AREA>" & ORs.Fields.Item(12).Value & "</AREA>"
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end Function

Function UsuariosSistemas()

	query = "SELECT ID, RUT, NOMBRES, APELLIDOS "
	query = query & " FROM USUARIOS AS U, MENUROL AS MR "
	query = query & " WHERE NOMBRES LIKE '%" & 	TXTSRC & "%'"
	query = query & " AND MR.COD_ROL = U.ROL "
	query = query & " AND MR.SISTEMA= " & strNvl(SISTEMA)
	query = query & " GROUP BY ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO, "
	query = query & " ROL, E_MAIL, UBICACION, FONO, CELULAR, AREA, USERDATE , MR.SISTEMA "
	query = query & " ORDER BY NOMBRES, APELLIDOS "

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<RUT>" & ORs.Fields.Item(1).Value & "</RUT>"
	  Response.Write "<NOMBRES>" & ORs.Fields.Item(2).Value & "</NOMBRES>"
	  Response.Write "<APELLIDOS>" & ORs.Fields.Item(3).Value & "</APELLIDOS>"
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end Function

function GetUsuario()

	query = "SELECT U.ID, PASSWORD, RUT, DV, NOMBRES, APELLIDOS, U.ESTADO,"
	query = query & " CARGO, ROL, E_MAIL,  UBICACION,"
	query = query & " FONO, CELULAR, AREA, USERDATE,"
	query = query & " C.DESCRIPCION AS DESC_CARGO, A.DESCRIPCION AS DESC_AREA,"
	query = query & " SEXO, FECHA_NAC, ACCESO_DB, EMPRESA, ACCESO_EMP, F.DESCRIPCION "
	query = query & " FROM USUARIOS AS U"
	query = query & " LEFT OUTER JOIN AREAS AS A ON A.CODIGO=U.AREA"
	query = query & " LEFT OUTER JOIN CARGOS AS C ON U.CARGO = C.CODIGO"
	query = query & " LEFT OUTER JOIN FAENAS AS F ON U.UBICACION = F.ID"
	query = query & " WHERE U.ID='" & ID & "'"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<PASSWORD>" & ORs.Fields.Item(1).Value & "</PASSWORD>"
		  Response.Write "<RUT>" & ORs.Fields.Item(2).Value & "-" &_
		  					ORs.Fields.Item(3).Value & "</RUT>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(4).Value & "</NOMBRES>"
		  Response.Write "<APELLIDOS>" & ORs.Fields.Item(5).Value & "</APELLIDOS>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(6).Value & "</ESTADO>"
		  Response.Write "<CARGO>" & ORs.Fields.Item(7).Value & "</CARGO>"
		  Response.Write "<ROL>" & ORs.Fields.Item(8).Value & "</ROL>"
		  Response.Write "<E_MAIL>" & ORs.Fields.Item(9).Value & "</E_MAIL>"
		  Response.Write "<LUGAR>" & ORs.Fields.Item(10).Value & "</LUGAR>" 
		  Response.Write "<FONO>" & ORs.Fields.Item(11).Value & "</FONO>"
		  Response.Write "<CELULAR>" & ORs.Fields.Item(12).Value & "</CELULAR>"
		  Response.Write "<AREA>" & ORs.Fields.Item(13).Value & "</AREA>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(14).Value & "</FECHA>" 
  		  Response.Write "<DESC_CARGO>" & ORs.Fields.Item(15).Value & "</DESC_CARGO>" 
   		  Response.Write "<DESC_AREA>" & ORs.Fields.Item(16).Value & "</DESC_AREA>" 
   		  Response.Write "<SEXO>" & ORs.Fields.Item(17).Value & "</SEXO>" 
   		  Response.Write "<FECHA_NAC>" & ORs.Fields.Item(18).Value & "</FECHA_NAC>" 
		  Response.Write "<ACCESO_DB>" & ORs.Fields.Item(19).Value & "</ACCESO_DB>"
		  Response.Write "<EMPRESA>" & ORs.Fields.Item(20).Value & "</EMPRESA>"
		  Response.Write "<ACCESO_EMP>" & ORs.Fields.Item(21).Value & "</ACCESO_EMP>"
		  Response.Write "<DESC_FAENA>" & ORs.Fields.Item(22).Value & "</DESC_FAENA>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateUsuario()

	query = "UPDATE USUARIOS SET RUT = " & RUT & ","
	query = query & "NOMBRES='" & NOMBRES & "',"
	query = query & "DV='" & DV & "',"
	query = query & "APELLIDOS='" & APELLIDOS & "',"
	query = query & "ESTADO=" & strNvl(ESTADO)& ", "
	query = query & "CARGO="& strNvl(CARGO) & ","
	query = query & "ROL=" & strNvl(ROL) & ", "
	query = query & "E_MAIL=" & strNvl(EMAIL) & ", "
	query = query & "FECHA_NAC=" & strNvl(FECHA_NAC) & ", "
	query = query & "SEXO=" & strNvl(SEXO) & ", "
	query = query & "UBICACION=" & strNvl(LUGAR) & ","
	query = query & "ACCESO_DB=" & strNvl(ACCESO_DB) & ","
	query = query & "ACCESO_EMP=" & strNvl(ACCESO_EMP) & ","
	query = query & "EMPRESA=" & strNvl(EMPRESA) & ","
	query = query & "FONO=" & strNvl(FONO) & ", "
	query = query & "CELULAR=" & strNvl(CELULAR) & ", "
	query = query & "AREA=" & strNvl(AREA) & ","
	query = query & "PASSWORD=" & strNvl(PASSWORD) & ","
	query = query & "USERDATE=getdate() "
	query = query & "WHERE ID='" & ID & "'" 

	Set ORs =oDB.EjecutaSql(query)
	response.Write(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updatePassword()

	query = "UPDATE USUARIOS SET PASSWORD = " & strNvl(PASSWORD) & ""
	query = query & " WHERE ID='" & ID & "'" 

	Set ORs =oDB.EjecutaSql(query)
	'response.Write(query)'
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function ListRoles()
	query = "SELECT ID, NOMBRE FROM ROLES "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listFaenas()
	query = "select f.id, f.descripcion, fu.usuario from faenas_usuario as fu, faenas as f "
	query = query & "where fu.id_faena=f.id and f.estado is not null "' & strNvl(ID)

	Set ORs =oDB.EjecutaSql(query)
	Response.AddHeader "Content-Type", "text/xml; charset=utf8"
	'Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "<USER>" & ORs.Fields.Item(2).Value & "</USER>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListCargos()
	query = "SELECT CODIGO, DESCRIPCION FROM CARGOS "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function passwordMassive()

query = "select id from usuarios "

	Set ORs =oDB.EjecutaSql(query)

	While Not ORs.EOF 
	  
	  query1 = "UPDATE USUARIOS SET PASSWORD=CONVERT(INT, RAND() * 10000) "
	  query1 = query1 & " WHERE ID=" & strNvl(ORs.Fields.Item(0).Value) 
	  Set ORs1 =oDB.EjecutaSql(query1)
	  
	  ORs.MoveNext
	
	Wend
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function 

function mailPassword()

Dim myCon , mymail, Body 
'Create the e-mail server object 
Set mymail = Server.CreateObject("cdo.Message") 
Set myCon = Server.CreateObject ("cdo.Configuration") 
'Out going SMTP server 
myCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "72.18.135.50" 
myCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
myCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
myCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60 
myCon.Fields.Update 

on error resume next
'Update the cdoSYS Configuration 
Set mymail.Configuration = myCon 

mymail.From = "info@ttmchile.cl" 

'mymail.To = "info@ttminsight.cl" 

mymail.Subject = "Cambio de Password TTMInsight." 

query = "SELECT ID, RUT, PASSWORD, NOMBRES, APELLIDOS, ESTADO, CARGO,"
query = query & " ROL, E_MAIL, UBICACION, FONO, CELULAR, AREA, USERDATE "
query = query & " FROM USUARIOS WHERE ESTADO='ACTIVO'  "
	
Set ORs =oDB.EjecutaSql(query)

While Not ORs.EOF
	mymail.To =""
	Body = "" 
	Body = Body & "<html>" 
	Body = Body & "<body>" 
	Body = Body & "<p>Estimado usuario,<BR> "
	Body = Body & "   Por motivos de seguridad se ha cambiado su clave de acceso al TTM Insight por la siguiente:</p><BR>" 
	Body = Body & "USER:  " & ORs.Fields.Item(0).Value & "<BR>"
	Body = Body & "PASSWORD: <strong>" & ORs.Fields.Item(2).Value & "</strong><BR><BR>"
	Body = Body & "Ud. podra cambiar la clave en el menu Inicio->Cambio de Password si as� lo desea.<BR><BR>"
	Body = Body & "Atte. <BR><BR>Julio Rojas Araneda <BR>"
	Body = Body & "Ing. de Sistemas TTMChile S.A.<BR>" 
	Body = Body & "Fono 55-477704  Cel. 7667 0392.<BR>" 



	Body = Body & "</body></html> "
	mymail.To = ORs.Fields.Item(8).Value  

	mymail.HTMLBody = Body
	mymail.Send
	ORs.MoveNext
Wend
 
Set mymail = Nothing 
Set myCon = Nothing 

Response.Write("Your mail was sent") 

end function

function mail()

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
	.Item(cdoSMTPServer)            = "mail.ttminsight.cl"
	.Item(cdoSMTPServerPort)        = 25
	.Item(cdoSMTPConnectionTimeout) = 10
	.Item(cdoSMTPAuthenticate)      = cdoBasic
	.Item(cdoSendUserName)          = "info@ttminsight.cl"
	.Item(cdoSendPassword)          = "r3m0lin0"

	.Update
End With

Set objMessage = Server.CreateObject("CDO.Message")

Set objMessage.Configuration = objConfig

With objMessage
	.To       = "info@ttminsight.cl"
	.From     = "info@ttminsight.cl"
	.Subject  = "SMTP Relay Test"
	.TextBody = "SMTP Relay Test Sent @ " & Now()
	.Send
End With

Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing

End Function


function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

%>