<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

AREA=UCASE(REQUEST("AREA"))
ID=UCASE(REQUEST("ID"))
IND_OT=UCASE(REQUEST("IND_OT"))
IND_SGI = REQUEST("IND_SGI")
IND_CONF= REQUEST("IND_CONF")
PASSWORD=REQUEST.Form("PASSWORD")
RUT=REQUEST("RUT")
TXTSRC=REQUEST("TXTSRC")
DV=UCASE(REQUEST("DV"))
NOMBRES=UCASE(REQUEST("NOMBRES"))
APELLIDOS=UCASE(REQUEST("APELLIDOS"))
ESTADO=REQUEST("ESTADO")
ESP=REQUEST("ESP")
EMPRESA=REQUEST("EMPRESA")
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
CLIENTE=REQUEST("CLIENTE")
UBICACION=UCASE(REQUEST("UBICACION"))
LUGAR=UCASE(REQUEST("LUGAR"))
CODIGO=UCASE(REQUEST("CODIGO"))
CARGO=UCASE(REQUEST("CARGO"))
ROL=REQUEST("ROL")
RECURSO=REQUEST("RECURSO")
RECEPTOR_SOL=UCASE(REQUEST("RECEPTOR_SOL"))

select case RECURSO

	case "getUsuario"
		  getUsuario()
			
	case "newUsuario"
		  newUsuario()
		
	case "updateUsuario"
		  updateUsuario
	
	case "updatePassword"
		  updatePassword()	
		  	
	case "listUsuarios"
		  listUsuarios()
	
	case "listUsuariosArea"
		  listUsuariosArea()

	case "listRoles"
		  listRoles()
		
	case "listEmpresas"
		  listEmpresas()
		
	case "listCargos"
		  listCargos()

	case "listFaenas"
		  listFaenas()
		  
	case "UsuariosSistemas"
		  UsuariosSistemas()
		
	case "ExisteUsuario"
		  ExisteUsuario()
		
	case "ValidaPass" 
	 	  ValidaPass() 
		  
end select

function ValidaPass() 

Dim sIPAddress

 

 'If sHost="" Then sIPAddress = Request.ServerVariables("REMOTE_ADDR") 
  
	
	'Set ORs1 =oDB.EjecutaSql(query)
	
	
	query = "SELECT PASSWORD, AREA, ROL, ROL, IND_SGI, IND_CONF"
	query = query & " FROM USUARIOS WHERE ID =" & strNvl(ID) 
	query = query & " AND ESTADO='ACTIVO'"
	 
		
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	If Not ORs.EOF Then
		  	If ORs.Fields.Item(0).Value  = PASSWORD Then
				  Response.Write "<ROW>True</ROW>"
				  Response.Write "<AREA>" &  ORs.Fields.Item(1).Value & "</AREA>"
				  Response.Write "<ROL>" &  ORs.Fields.Item(3).Value & "</ROL>"
				  Response.Write "<IND_SGI>" &  ORs.Fields.Item(4).Value & "</IND_SGI>"
				  Response.Write "<IND_CONF>" &  ORs.Fields.Item(5).Value & "</IND_CONF>"
				  Response.Write "<UPDATE_PASS>" &  ORs.Fields.Item(2).Value & "</UPDATE_PASS>"
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
	
	Response.ContentType = "text/xml"
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

function newUsuario()

	query = "insert into usuarios (id, rut, dv, nombres, apellidos,sexo, fecha_nac, empresa,  "
	query = query & " estado, cargo, rol, password,  e_mail, acceso_db, ubicacion, fono, "
	query = query & " celular, area, userdate, username) "
	query = query & " VALUES ('" & CODIGO & "'," & strNvl(RUT) & "," & strNvl(DV) & "," 
	query = query & strNvl(NOMBRES) & ",'" & APELLIDOS & "', '" 
	query = query & SEXO & "', " & strNvl(FECHA_NAC) & ",'SIMMA'," 
	query = query & "'ACTIVO'," & strNvl(CARGO) & "," & strNvl(ROL) & "," & strNvl(PASSWORD) & "," 
	query = query & strNvl(EMAIL) & "," & strNvl(ACCESO_DB) & "," & strNvl(LUGAR) & "," 
	query = query & strNvl(FONO) & "," & strNvl(CELULAR) & "," & strNvl(AREA) & ", getdate(), 'system');"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<ROW>"
	Response.Write "<CODIGO>" & CODIGO & "</CODIGO>"
	Response.Write "<NOMBRE>" & NOMBRES & "</NOMBRE>"
	Response.Write "</ROW>"

	Set ORs = Nothing
	Set oDB = Nothing
end function

function listUsuarios()

	query = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO,"
	query = query & " ROL, E_MAIL, UBICACION, FONO, CELULAR, AREA, ESPECIALIDAD "
	query = query & " FROM USUARIOS "
	query = query & " WHERE NOMBRES LIKE '%" & 	TXTSRC & "%'"

	query = query & " ORDER BY NOMBRES, APELLIDOS "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
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
	  Response.Write "<FONO>" & ORs.Fields.Item(9).Value & "</FONO>"
	  Response.Write "<CELULAR>" & ORs.Fields.Item(10).Value & "</CELULAR>"
	  Response.Write "<AREA>" & ORs.Fields.Item(11).Value & "</AREA>"
	  
	  ESPECIAL = ""
	  
	  SELECT CASE ORs.Fields.Item(12).Value
				CASE "ELE"
					ESPECIAL = "(ELECTRICO)"
				CASE "MEC"
					ESPECIAL = "(MECANICO)"
				CASE "TOD"
					ESPECIAL = "(TODOS)"
				CASE null
					ESPECIAL = "  "
				CASE "INS"
					ESPECIAL = "(INSTRUMENTAL)"
	  END SELECT

	  
	  Response.Write "<ESP>" & ESPECIAL & "</ESP>"
	  
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
	
	Response.ContentType = "text/xml"
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

function listUsuariosArea()
	query = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO,"
	query = query & " ROL, E_MAIL, UBICACION, FONO, CELULAR, AREA, USERDATE "
	query = query & " FROM USUARIOS "
	query = query & " WHERE AREA=" & 	strNvl(AREA)  & ""	
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

function getUsuario()

	query = "SELECT ID, PASSWORD, RUT, DV, NOMBRES, APELLIDOS, ESTADO,"
	query = query & " CARGO, ROL, E_MAIL,  UBICACION,"
	query = query & " FONO, CELULAR, AREA, USERDATE,"
	query = query & " C.DESCRIPCION AS DESC_CARGO, A.DESCRIPCION AS DESC_AREA,"
	query = query & " SEXO, FECHA_NAC, ACCESO_DB, EMPRESA, ACCESO_EMP, IND_SGI, IND_CONF "
	query = query & " FROM USUARIOS AS U"
	query = query & " LEFT OUTER JOIN AREAS AS A ON A.CODIGO=U.AREA"
	query = query & " LEFT OUTER JOIN CARGOS AS C ON U.CARGO = C.CODIGO"
	query = query & " WHERE U.ID='" & ID & "'"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<PASSWORD>" & ORs.Fields.Item(1).Value & "</PASSWORD>"
		  Response.Write "<RUT>" & ORs.Fields.Item(2).Value  & "</RUT>"
		 Response.Write "<DV>" & ORs.Fields.Item(3).Value &  "</DV>"
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
		  Response.Write "<IND_SGI>" & ORs.Fields.Item(22).Value & "</IND_SGI>"
		  Response.Write "<IND_CONF>" & ORs.Fields.Item(23).Value & "</IND_CONF>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
	
end function

function updatePassword()

	query = "UPDATE USUARIOS SET PASSWORD = " & strNvl(PASSWORD) & ",  UPDATE_PASS=GETDATE() "
	query = query & " WHERE ID='" & ID & "'" 

	Set ORs =oDB.EjecutaSql(query)
	'response.Write(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateUsuario()

	query = "UPDATE USUARIOS SET RUT = " & strNvl(RUT) & ","
	query = query & "NOMBRES=" & strNvl(NOMBRES) & ","
	query = query & "DV='" & DV & "',"
	query = query & "APELLIDOS=" & strNvl(APELLIDOS) & ","
	query = query & "ESTADO=" & strNvl(ESTADO) & ", "
	query = query & "CARGO="& strNvl(CARGO) & ","
	query = query & "ROL=" & strNvl(ROL) & ", "
	query = query & "E_MAIL=" & strNvl(EMAIL) & ", "
'	query = query & "FECHA_NAC=" & strNvl(FECHA_NAC) & ", "
	'query = query & "SEXO=" & strNvl(SEXO) & ", "
	query = query & "UBICACION=" & strNvl(CLIENTE) & ","
	query = query & "IND_SGI=" & strNvl(IND_SGI) & ","
	query = query & "IND_CONF=" & strNvl(IND_CONF) & ","
 
	'query = query & "EMPRESA=" & strNvl(EMPRESA) & ","
	query = query & "FONO=" & strNvl(FONO) & ", "
	'query = query & "ESPECIALIDAD=" & strNvl(ESP) & ", "
	'query = query & "CELULAR=" & strNvl(CELULAR) & ", "
	'query = query & "AREA=" & strNvl(AREA) & ","
	query = query & "PASSWORD=" & strNvl(PASSWORD) & ","
	query = query & "USERDATE=getdate() "
	query = query & "WHERE ID='" & ID & "'" 

	Set ORs =oDB.EjecutaSql(query)
	'response.Write(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "OK"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listRoles()
	query = "SELECT ID, NOMBRE FROM ROLES "
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
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

	query = "SELECT ID, DESCRIPCION FROM FAENAS A"
	
	IF LEN(ID)>0 THEN
		query = "SELECT ID, DESCRIPCION FROM FAENAS AS F "
		query = query & " INNER JOIN FAENAS_USUARIO AS FU ON F.ID = FU.ID_FAENA and FU.USUARIO=" & strNvl(ID) 
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listEmpresas()

	query = "SELECT RUT, NOMBRE FROM EMPRESAS ORDER BY NOMBRE "
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
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

function listCargos()

	query = "SELECT CODIGO, DESCRIPCION FROM CARGOS "
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
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

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

%>

