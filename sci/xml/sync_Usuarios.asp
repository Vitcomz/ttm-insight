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
TIPO=REQUEST("TIPO")
CELULAR=REQUEST("CELULAR")
AREA=UCASE(REQUEST("AREA"))
LUGAR=UCASE(REQUEST("LUGAR"))
CARGO=UCASE(REQUEST("CARGO"))
ROL=REQUEST("ROL")
RECURSO=REQUEST("RECURSO")
FAENA=UCASE(REQUEST("FAENA"))

select case RECURSO
	case "GetUsuario"
		  GetUsuario()
			
end select

function GetUsuario()
	query = "SELECT ID, PASSWORD, RUT, DV, NOMBRES, APELLIDOS, ESTADO,"
	query = query & " CARGO, ROL, E_MAIL,  UBICACION,"
	query = query & " FONO, CELULAR, AREA, USERDATE,"
	query = query & " C.DESCRIPCION AS DESC_CARGO, A.DESCRIPCION AS DESC_AREA,"
	query = query & " SEXO, FECHA_NAC, ACCESO_DB, EMPRESA, ACCESO_EMP, ACCESO_EMP "
	query = query & " FROM USUARIOS AS U"
	query = query & " LEFT OUTER JOIN AREAS AS A ON A.CODIGO=U.AREA"
	query = query & " LEFT OUTER JOIN CARGOS AS C ON U.CARGO = C.CODIGO"
	query = query & " WHERE ESTADO = 'ACTIVO'" 'U.ID='" & ID & "'"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
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
		  Response.Write "<RECEPTOR_SOL>" & ORs.Fields.Item(22).Value & "</RECEPTOR_SOL>"
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

