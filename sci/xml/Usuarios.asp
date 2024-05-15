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
			
	case "NewUsuario"
		  NewUsuario()
		
	case "newLogin"
		  newLogin()
		  
	case "UpdateUsuario"
		  UpdateUsuario()
		  
	case "updatePassword"
		  updatePassword()	  
		
	case "ListUsuarios"
		  ListUsuarios()

	case "ListRoles"
		  ListRoles()
		
	case "listFaenas"
		  listFaenas()
		  
	case "listLogins"
		  listLogins()
		
	case "ListCargos"
		  ListCargos()

	case "UsuariosSistemas"
		  UsuariosSistemas()
		
	case "ExisteUsuario"
		  ExisteUsuario()
		
	case "ValidaPass" 
	 	  ValidaPass() 
		
	case "ValidaPassETOC" 
	 	  ValidaPassETOC() 
end select

function ValidaPass() 

	query = "SELECT PASSWORD, ROL FROM USUARIOS WHERE ID =" & strNvl(ID) & " AND ESTADO='ACTIVO'" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	If Not ORs.EOF Then
		  	If ORs.Fields.Item(0).Value  = PASSWORD Then
				  Response.Write "<ROW>True</ROW>"
				  Response.Write "<ROL>" & ORs.Fields.Item(1).Value & "</ROL>"
				  
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

function ValidaPassETOC() 

	query = "SELECT PASSWORD,UBICACION,EMPRESA FROM USUARIOS WHERE ID =" & strNvl(ID) & " AND ESTADO='ACTIVO'" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	If Not ORs.EOF Then
		  	If ORs.Fields.Item(0).Value  = PASSWORD AND ORs.Fields.Item(1).Value=4 AND FAENA = "CHUQUICAMATA" Then
				  Response.Write "<ROW>CHUQUI</ROW>"
			ElseIF ORs.Fields.Item(0).Value  = PASSWORD AND FAENA <> "CHUQUICAMATA" Then
				  Response.Write "<ROW>True</ROW>"
			Else
				  Response.Write "<ROW>False</ROW>"
			End If
	Else
		  Response.Write "<ROW>False</ROW>"
	End If
	Response.Write "<ROW>"&ORs.Fields.Item(2).Value&"</ROW>"
	
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

function NewUsuario()

	query = "insert into usuarios (id, rut, dv, nombres, apellidos,sexo, fecha_nac, RECEPTOR_SOL, "
	query = query & " estado, cargo, rol, password,  e_mail, acceso_db, ubicacion, fono, celular, area, userdate,"
	query = query & " username) VALUES ('"
	query = query & ID & "'," & RUT & ",'" & DV & "','" 
	query = query & NOMBRES & "','" & APELLIDOS & "', '" 
	query = query & SEXO & "', " & strNvl(FECHA_NAC) & "," & strNvl(RECEPTOR_SOL) & ",'ACTIVO'," 
	query = query & strNvl(CARGO) & "," & strNvl(ROL) & "," & strNvl(PASSWORD) & "," 
	query = query & strNvl(EMAIL) & "," & strNvl(ACCESO_DB) & "," & strNvl(LUGAR) & "," 
	query = query & strNvl(FONO) & "," & strNvl(CELULAR) & "," & strNvl(AREA) & ",getdate(),'system');"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function newLogin()

	query = "insert into logins (id, tipo, date ) "
	query = query & "  VALUES ('"
	query = query & ID & "','" & TIPO & "',GETDATE())" 
	
	Set ORs =oDB.EjecutaSql(query)

	Response.ContentType = "text/xml"
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
	query = query & " WHERE NOMBRES LIKE '%" & 	TXTSRC & "%'"
	query = query & " AND ESTADO<>'ELIMINADO'"
	
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

function listLogins()

	query ="SET DATEFORMAT DMY SELECT ID, TIPO, DATEADD(hh,2, DATE) FROM LOGINS "
		
	IF ID<>"TOD" THEN
		query = query & " WHERE ID=" & strNvl(ID)
		
	ELSE
		IF SISTEMA<>"TOD" THEN
			query = query & " WHERE TIPO=" & strNvl(SISTEMA)
		END IF
	END IF
	
	
		query = query & " ORDER BY DATE DESC"
		
	
	
	Set ORs =oDB.EjecutaSql(query)
	N=1

	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<N>" & N & "</N>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<TIPO>" & ORs.Fields.Item(1).Value & "</TIPO>"
	  Response.Write "<DATE>" & ORs.Fields.Item(2).Value & "</DATE>"
	  ORs.MoveNext
	  N=N+1
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

function GetUsuario()
	query = "SELECT ID, PASSWORD, RUT, DV, NOMBRES, APELLIDOS, ESTADO,"
	query = query & " CARGO, ROL, E_MAIL,  UBICACION,"
	query = query & " FONO, CELULAR, AREA, USERDATE,"
	query = query & " C.DESCRIPCION AS DESC_CARGO, A.DESCRIPCION AS DESC_AREA,"
	query = query & " SEXO, FECHA_NAC, ACCESO_DB, EMPRESA, ACCESO_EMP, ACCESO_EMP "
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
	query = query & "RECEPTOR_SOL=" & strNvl(RECEPTOR_SOL) & ","
	query = query & "EMPRESA=" & strNvl(EMPRESA) & ","
	query = query & "FONO=" & strNvl(FONO) & ", "
	query = query & "CELULAR=" & strNvl(CELULAR) & ", "
	query = query & "AREA=" & strNvl(AREA) & ","
	query = query & "PASSWORD=" & strNvl(PASSWORD) & ","
	query = query & "USERDATE=getdate() "
	query = query & "WHERE ID='" & ID & "'" 

	Set ORs =oDB.EjecutaSql(query)
	'response.Write(query)
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
	'response.Write(query)
	
	Response.ContentType = "text/xml"
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
	query = "SELECT ID, DESCRIPCION FROM FAENAS "
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

function ListCargos()
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

