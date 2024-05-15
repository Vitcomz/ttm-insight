<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Library" -->
<!--METADATA TYPE="typelib" UUID="00000205-0000-0010-8000-00AA006D2EA4" NAME="ADODB Type Library" -->

<!--#include file="..\standard\DBConnExist.asp" -->
 
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

MailServer = oDB.GetMailServer()
MailFrom = oDB.GetMailAdress(P_FROM)

IF P_TO ="ADQUISICIONES" THEN 
        	toMail = oDB.GetMailAdquisiciones() 
		ELSE
			toMail = P_TO
END IF 
while len(MailServer)<1
x=x+1
wend	
 

  Set cdoConfig = CreateObject("CDO.Configuration")  
 
    With cdoConfig.Fields  
        .Item(cdoSendUsingMethod) = cdoSendUsingPort  
        .Item(cdoSMTPServer) = MailServer  
		.Item(cdoSMTPconnectiontimeout) = 4
        .Update  
    End With  
 
    Set cdoMessage = CreateObject("CDO.Message")  
 	
	On Error Resume Next
	
    With cdoMessage  
        Set .Configuration = cdoConfig  
        .From = MailFrom 
		.To = toMail
        .Subject = SUBJECT 
        .HTMLBody = BODY  
		'.AddAttachment "C:\files\another.doc"
        .Send  
    End With  
 
    Set cdoMessage = Nothing  
    Set cdoConfig = Nothing  
	
	If Err.number <> 0 Then
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 	 	Response.Write "<ROW>" 
			Response.Write "<ERROR>" & ERR.NUMBER & " " & ERR.DESCRIPCION & "</ERROR>"
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

