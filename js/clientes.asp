<!--#include file="DBConn.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
s=ucase(REQUEST("s"))
P=UCASE(REQUEST("P"))
DV=UCASE(REQUEST("DV"))
RUT=REQUEST("RUT")
NOMBRE=UCASE(REQUEST("NOMBRE"))
NOMBRE_FAN=UCASE(REQUEST("NOMBRE_FAN"))

NOMBRES=UCASE(REQUEST("NOMBRES"))
APELLIDOS=UCASE(REQUEST("APELLIDOS"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
DIRECCION=UCASE(REQUEST("DIRECCION"))
OBSERVACION=REQUEST("OBSERVACION")
FONO=UCASE(REQUEST("FONO"))
FAX=UCASE(REQUEST("FAX"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_PAGO=UCASE(REQUEST("FECHA_PAGO"))
FORMA_PAGO=UCASE(REQUEST("FORMA_PAGO"))
VALOR=UCASE(REQUEST("VALOR"))
EMAIL=REQUEST("EMAIL")
EMPRESA=REQUEST("EMPRESA")
WEB=REQUEST("WEB")
CELULAR=UCASE(REQUEST("CELULAR"))
TXT=UCASE(REQUEST("TXT"))
CLIENTE=UCASE(REQUEST("CLIENTE"))
CONTACTO=UCASE(REQUEST("CONTACTO"))
RUBRO=UCASE(REQUEST("RUBRO"))
ROL=UCASE(REQUEST("ROL"))
INDICE=UCASE(REQUEST("INDICE"))
CIUDAD=UCASE(REQUEST("CIUDAD"))
CODIGO=UCASE(REQUEST("CODIGO"))
CORREOS=REQUEST("CORREOS")
USUARIO=REQUEST("USUARIO")
USERNAME=REQUEST("USERNAME")

select case RECURSO

	case "existeCliente"
		existeCliente()
		
	case "getCliente"
		getCliente()
	
		case "getContacto"
		getContacto()
	
		case "getFaena"
		getFaena()
		
	case "getUbicacion"
		getUbicacion()
			
	case "DelCliente"
		DelProv()
		
	case "newCliente"
		  newCliente()
	
	
	case "newEmpresa"
		  newEmpresa()
	
		case "newFaena"
		  newFaena()
		  
	case "newUbicacion"
		  newUbicacion()
		
	case "newContacto"
		  newContacto()
		  		
	case "updateCliente"
			updateCli()
	
	case "updateCont"
			updateCont()
			
	case "updateUbi"
			updateUbi()
				
	case "listClientes"
		listClientes()
	
	case "listFaenas"
		listFaenas()
		
	case "listContactos"
		  listContactos()
		
	case "listUbicaciones"
		listUbicaciones()
		
end select

Function existeCliente()
	
	query = "SELECT * FROM CLIENTES WHERE RUT_CLIENTE=" & RUT & ""
	query = query & " AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		
	If ORs.Eof Then
		Response.Write "<EXISTE>FALSE</EXISTE>"
	Else
		Response.Write "<EXISTE>TRUE</EXISTE>"
	End If
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
End Function

function newUbicacion()

	query = "SELECT MAX(CODIGO) AS N FROM UBICACION "
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO UBICACION (CODIGO, DESCRIPCION, EMPRESA,  CLIENTE , DIRECCION, "
	query = query & " USERDATE, USERNAME) VALUES ("
	query = query & N & "," 
	query = query & strNvl(NOMBRE) & ","
	query = query & strNvl(EMPRESA) & ","
	query = query & strNvl(CLIENTE) & ","
	query = query & strNvl(DIRECCION) & ","
	query = query & " GETDATE(), " & strNvl(USERNAME) & ")"
	
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" 
	Response.Write "<ID>" & N & "</ID>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function newContacto()

	query = "SELECT MAX(CODIGO) AS N FROM CONTACTOS "
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO CONTACTOS (CODIGO, NOMBRES, APELLIDOS, CLIENTE, EMPRESA,    "
	query = query & " USERDATE, USERNAME) VALUES ("
	query = query & N & "," 
	query = query & strNvl(NOMBRES) & ","
	query = query & strNvl(APELLIDOS) & ","
	query = query & strNvl(CLIENTE) & ","
	query = query & strNvl(EMPRESA) & ","
	query = query & " GETDATE(), " & strNvl(USERNAME) & ")"
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" 
	Response.Write "<ID>" & N & "</ID>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function


function newCliente()


	RUT = REPLACE(RUT,".","")
	
	query = "INSERT INTO CLIENTES (RUT_CLIENTE, DV_CLIENTE, NOMBRE, "
	query = query & "DIRECCION, FONO, FAX, CELULAR, EMAIL, WEB, CONTACTO, RUBRO, CIUDAD, OBSERVACION,"
	query = query & "EMPRESA, USERDATE) VALUES ("
	query = query & RUT & "," & strNvl(DV) & "," & strNvl(NOMBRE) & "," & strNvl(DIRECCION) & "," 
	query = query & strNvl(FONO) & "," & strNvl(FAX) & "," & strNvl(CELULAR) & "," & strNvl(EMAIL) & "," & strNvl(WEB)
	query = query & "," & strNvl(CONTACTO) & "," & strNvl(RUBRO)  & "," & strNvl(CIUDAD)  &  "," & strNvl(OBSERVACION) 
	query = query & "," & strNvl(EMPRESA) & ",getdate());"

	'Response.Write query
	Set ORs =oDB.EjecutaSql(query)
	
 
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<CODIGO>" & RUT & "</CODIGO>"
	Response.Write "<NOMBRE>" & NOMBRE & "</NOMBRE>"
	Response.Write "<DIRECCION>" & DIRECCION & "</DIRECCION>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function newEmpresa()


	RUT = REPLACE(RUT,".","")
	
	query = "INSERT INTO CLIENTES (RUT_CLIENTE, DV_CLIENTE, NOMBRE, "
	query = query & "DIRECCION, FONO, FAX, CELULAR, EMAIL, WEB, CONTACTO, RUBRO, CIUDAD, OBSERVACION,"
	query = query & "EMPRESA, USERDATE) VALUES ("
	query = query & RUT & "," & strNvl(DV) & "," & strNvl(NOMBRE) & "," & strNvl(DIRECCION) & "," 
	query = query & strNvl(FONO) & "," & strNvl(FAX) & "," & strNvl(CELULAR) & "," & strNvl(EMAIL) & "," & strNvl(WEB)
	query = query & "," & strNvl(CONTACTO) & "," & strNvl(RUBRO)  & "," & strNvl(CIUDAD)  &  "," & strNvl(OBSERVACION) 
	query = query & "," & strNvl(EMPRESA) & ",getdate());"

	'Response.Write query
	Set ORs =oDB.EjecutaSql(query)
	
	query = "SELECT MAX(CODIGO) AS N FROM UBICACION WHERE EMPRESA= " & strNvl(EMPRESA)
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO UBICACION (CODIGO, DESCRIPCION, EMPRESA,  CLIENTE , DIRECCION, "
	query = query & " USERDATE, USERNAME) VALUES ("
	query = query & N & "," 
	query = query & strNvl(DIRECCION) & ","
	query = query & strNvl(EMPRESA) & ","
	query = query & strNvl(RUT) & ","
	query = query & strNvl(DIRECCION) & ","
	query = query & " GETDATE(), " & strNvl(USERNAME) & ")"
	
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<CODIGO>" & RUT & "</CODIGO>"
	Response.Write "<NOMBRE>" & NOMBRE & "</NOMBRE>"
	Response.Write "<COD_UBI>" & N & "</COD_UBI>"
	Response.Write "<DIRECCION>" & DIRECCION & "</DIRECCION>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function


function newFaena()

	query = "SELECT MAX(CODIGO) AS N FROM UBICACION WHERE EMPRESA= " & strNvl(EMPRESA)
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	RUT = REPLACE(RUT,".","")
	
	query = "INSERT INTO UBICACION (CODIGO, DESCRIPCION, "
	query = query & "DIRECCION, EMPRESA, USERDATE) VALUES ("
	query = query & N & "," &  strNvl(NOMBRE) & "," & strNvl(DIRECCION) 
	query = query & "," & strNvl(EMPRESA) & ",getdate());"

	'Response.Write query
	Set ORs =oDB.EjecutaSql(query)
	
 
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<CODIGO>" & N & "</CODIGO>"
	Response.Write "<NOMBRE>" & NOMBRE & "</NOMBRE>"
	Response.Write "<DIRECCION>" & DIRECCION & "</DIRECCION>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function


function DelProv()

	query = "DELETE FROM CLIENTES WHERE RUT_CLIENTE="& RUT &""
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write"OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function getCliente()

	query = "SELECT C.RUT_CLIENTE, C.DV_CLIENTE, C.NOMBRE, C.NOMBRE_FAN, C.FONO, C.FAX, "
	query = query & " C.CELULAR, C.EMAIL, C.WEB, C.CONTACTO, C.RUBRO, C.CIUDAD, C.OBSERVACION, "
	query = query & " C.IND_ACTIVACION, U.DIRECCION, U.CODIGO "
	query = query & " FROM CLIENTES AS C"
	query = query & " LEFT OUTER JOIN UBICACION AS U ON U.CLIENTE = C.RUT_CLIENTE AND U.EMPRESA=C.EMPRESA"
	query = query & " WHERE C.RUT_CLIENTE=" & RUT & " " 
	query = query & " 	AND C.EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"  & query 
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value  & "</RUT>"
		  Response.Write "<DV>" & ORs.Fields.Item(1).Value  & "</DV>"  
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<NOMBRE_FAN>" & ORs.Fields.Item(3).Value & "</NOMBRE_FAN>"
		  Response.Write "<FONO>" & ORs.Fields.Item(4).Value & "</FONO>"
		  Response.Write "<FAX>" & ORs.Fields.Item(5).Value & "</FAX>"
  		  Response.Write "<CELULAR>" & ORs.Fields.Item(6).Value & "</CELULAR>"
   		  Response.Write "<MAIL>" & ORs.Fields.Item(7).Value & "</MAIL>"
     	  Response.Write "<WEB>" & ORs.Fields.Item(8).Value & "</WEB>"
       	  Response.Write "<CONTACTO>" & ORs.Fields.Item(9).Value & "</CONTACTO>"
       	  Response.Write "<RUBRO>" & ORs.Fields.Item(10).Value & "</RUBRO>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(11).Value & "</CIUDAD>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(12).Value & "</OBSERVACION>"
		  Response.Write "<INDICE>" & ORs.Fields.Item(13).Value & "</INDICE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(14).Value & "</DIRECCION>"
		  Response.Write "<COD_UBI>" & ORs.Fields.Item(15).Value & "</COD_UBI>"
			 
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getUbicacion()

	query = "SELECT  CODIGO, DESCRIPCION, EMPRESA, RUT, DV, "
	query = query & " CLIENTE, DIRECCION, FECHA, VALOR_MES, FECHA_PAGO, FORMA_PAGO, EMAIL, FONO, "
    query = query & " CORREOS, OBSERVACION, CONTACTO, USERDATE, USERNAME "
	query = query & " FROM UBICACION WHERE CODIGO=" & CODIGO & "" 
	query = query & " 	AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
	 	 Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value  & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<EMPRESA>" & ORs.Fields.Item(2).Value  & "</EMPRESA>"
		  Response.Write "<RUT>" & ORs.Fields.Item(3).Value  & "</RUT>"
		  Response.Write "<DV>" & ORs.Fields.Item(4).Value  & "</DV>"  
		  Response.Write "<CLIENTE>" & ORs.Fields.Item(5).Value & "</CLIENTE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(6).Value & "</DIRECCION>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(7).Value & "</FECHA>"
		  Response.Write "<VALOR_MES>" & ORs.Fields.Item(8).Value & "</VALOR_MES>"
		  Response.Write "<FECHA_PAGO>" & ORs.Fields.Item(9).Value & "</FECHA_PAGO>"
		  Response.Write "<FORMA_PAGO>" & ORs.Fields.Item(10).Value & "</FORMA_PAGO>"
   		  Response.Write "<MAIL>" & ORs.Fields.Item(11).Value & "</MAIL>"
		  Response.Write "<FONO>" & ORs.Fields.Item(12).Value & "</FONO>"
     	  Response.Write "<CORREOS>" & ORs.Fields.Item(13).Value & "</CORREOS>"
       	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(14).Value & "</OBSERVACION>"
       	  Response.Write "<CONTACTO>" & ORs.Fields.Item(15).Value & "</CONTACTO>"
		   
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getFaena()

	query = "SELECT  CODIGO, DESCRIPCION, EMPRESA, RUT, DV, "
	query = query & " CLIENTE, DIRECCION, FECHA, VALOR_MES, FECHA_PAGO, FORMA_PAGO, EMAIL, FONO, "
    query = query & " CORREOS, OBSERVACION, CONTACTO, USERDATE, USERNAME "
	query = query & " FROM UBICACION WHERE CODIGO=" & CODIGO & "" 
	query = query & " 	AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
	 	 Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value  & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<EMPRESA>" & ORs.Fields.Item(2).Value  & "</EMPRESA>"
		  Response.Write "<RUT>" & ORs.Fields.Item(3).Value  & "</RUT>"
		  Response.Write "<DV>" & ORs.Fields.Item(4).Value  & "</DV>"  
		  Response.Write "<CLIENTE>" & ORs.Fields.Item(5).Value & "</CLIENTE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(6).Value & "</DIRECCION>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(7).Value & "</FECHA>"
		  Response.Write "<VALOR_MES>" & ORs.Fields.Item(8).Value & "</VALOR_MES>"
		  Response.Write "<FECHA_PAGO>" & ORs.Fields.Item(9).Value & "</FECHA_PAGO>"
		  Response.Write "<FORMA_PAGO>" & ORs.Fields.Item(10).Value & "</FORMA_PAGO>"
   		  Response.Write "<MAIL>" & ORs.Fields.Item(11).Value & "</MAIL>"
		  Response.Write "<FONO>" & ORs.Fields.Item(12).Value & "</FONO>"
     	  Response.Write "<CORREOS>" & ORs.Fields.Item(13).Value & "</CORREOS>"
       	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(14).Value & "</OBSERVACION>"
       	  Response.Write "<CONTACTO>" & ORs.Fields.Item(15).Value & "</CONTACTO>"
		   
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function getContacto()

	query = "SELECT  CODIGO, NOMBRES, APELLIDOS, EMPRESA, RUT, DV, "
	query = query & " CLIENTE, DIRECCION, FECHA,  FONOS, "
    query = query & " CORREOS, OBSERVACION,  USERDATE, USERNAME "
	query = query & " FROM CONTACTOS WHERE CODIGO=" & CODIGO & "" 
	query = query & " 	AND EMPRESA=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
	 	 Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value  & "</CODIGO>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(1).Value & "</NOMBRES>"
		  Response.Write "<APELLIDOS>" & ORs.Fields.Item(2).Value & "</APELLIDOS>"
		  Response.Write "<EMPRESA>" & ORs.Fields.Item(3).Value  & "</EMPRESA>"
		  Response.Write "<RUT>" & ORs.Fields.Item(4).Value  & "</RUT>"
		  Response.Write "<DV>" & ORs.Fields.Item(5).Value  & "</DV>"  
		  Response.Write "<CLIENTE>" & ORs.Fields.Item(6).Value & "</CLIENTE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(7).Value & "</DIRECCION>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(8).Value & "</FECHA>"
		  Response.Write "<FONO>" & ORs.Fields.Item(9).Value & "</FONO>"
     	  Response.Write "<CORREOS>" & ORs.Fields.Item(10).Value & "</CORREOS>"
       	  Response.Write "<OBSERVACION>" & ORs.Fields.Item(11).Value & "</OBSERVACION>"
       	  Response.Write "<CONTACTO>" & ORs.Fields.Item(12).Value & "</CONTACTO>"
		   
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updateCli()

	query = "UPDATE CLIENTES SET DIRECCION=" & strNvl(DIRECCION) & ","
	query = query & "CIUDAD=" & strNvl(CIUDAD) & ", "
	query = query & "NOMBRE=" & strNvl(NOMBRE) & ","
	query = query & "NOMBRE_FAN=" & strNvl(NOMBRE_FAN) & ","
	query = query & "FONO=" & strNvl(FONO) & ", "
	query = query & "DV_CLIENTE=" & strNvl(DV) & ","
	query = query & "WEB=" & strNvl(WEB) & ","
	query = query & "EMAIL=" & strNvl(EMAIL) & ", "
	query = query & "CELULAR=" & strNvl(CELULAR) & ", "
	query = query & "CONTACTO=" & strNvl(CONTACTO) & ", "
	query = query & "RUBRO=" & strNvl(RUBRO) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ", "
	query = query & "IND_ACTIVACION=" & strNvl(INDICE) & ", "
	query = query & "USERDATE= getdate()  "
	query = query & "WHERE RUT_CLIENTE="& RUT & "" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updateUbi()

	query = "UPDATE UBICACION SET DIRECCION=" & strNvl(DIRECCION) & ","
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "RUT=" & strNvl(RUT) & ", "
	query = query & "DV=" & strNvl(DV) & ","
	query = query & "EMAIL=" & strNvl(EMAIL) & ", "
	query = query & "FONO=" & strNvl(FONO) & ", "
	query = query & "FECHA=" & strNvl(FECHA) & ", "
	query = query & "CLIENTE=" & strNvl(CLIENTE) & ","
	query = query & "CONTACTO=" & strNvl(CONTACTO) & ", "
	query = query & "VALOR_MES=" & strNvl(VALOR) & ", "
	query = query & "FECHA_PAGO=" & strNvl(FECHA_PAGO) & ", "
	query = query & "FORMA_PAGO=" & strNvl(FORMA_PAGO) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ", "
	query = query & "CORREOS=" & strNvl(CORREOS) & ", "
	query = query & "USERDATE= getdate()  "
	query = query & "WHERE CODIGO="& CODIGO & "" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updateCont()

	query = "UPDATE CONTACTOS SET DIRECCION=" & strNvl(DIRECCION) & ","
	query = query & "NOMBRES=" & strNvl(NOMBRES) & ","
	query = query & "APELLIDOS=" & strNvl(APELLIDOS) & ","
	query = query & "RUT=" & strNvl(RUT) & ", "
	query = query & "DV=" & strNvl(DV) & ","
	query = query & "FONOS=" & strNvl(FONO) & ", "
	query = query & "FECHA=" & strNvl(FECHA) & ", "
	query = query & "CLIENTE=" & strNvl(CLIENTE) & ","
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ", "
	query = query & "CORREOS=" & strNvl(CORREOS) & ", "
	query = query & "USERDATE= getdate()  "
	query = query & "WHERE CODIGO="& CODIGO & "" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listClientes()


	query1 = "SELECT CLIENTE FROM USUARIOS WHERE ID=" & strNvl(USERNAME)
	Set ORs =oDB.EjecutaSql(query1)
	
	IF Not ORs.eof THEN
			CLIENTE =  ORs.Fields.Item(0).Value 
	END IF
	
	query = " SELECT RUT_CLIENTE, DV_CLIENTE, NOMBRE, DIRECCION, "
	query = query & " FONO,  OBSERVACION, IND_ACTIVACION FROM CLIENTES"
	query = query & " WHERE EMPRESA= " & strNvl(EMPRESA)
	
	IF Len(s)>0 THEN
			query = query & " AND NOMBRE LIKE '%" & s & "%'"
	END IF
	
	IF ROL<>"ADMIN" THEN
		'	query = query & " AND RUT_CLIENTE=" & strNvl(CLIENTE)
	END IF
	
	query = query & " ORDER BY NOMBRE  " 
	
	 Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(3).Value & "</DIRECCION>"
		  Response.Write "<FONO>" & ORs.Fields.Item(4).Value & "</FONO>"
		  Response.Write "<OBS>" & ORs.Fields.Item(5).Value & "</OBS>"
		  Response.Write "<INDICE>" & ORs.Fields.Item(6).Value & "</INDICE>"
		  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listContactos()

	query = "SELECT CODIGO,  NOMBRES, APELLIDOS "
	query = query & " FROM CONTACTOS "
	query = query & " WHERE EMPRESA= " & strNvl(EMPRESA)
	
	query = query & " AND NOMBRES LIKE '%" & TXT & "%'"
	
	If Len(CLIENTE)>0 Then
		query = query & " AND CLIENTE= " & strNvl(CLIENTE)
	End If
	
	query = query & " ORDER BY NOMBRES, APELLIDOS"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(1).Value & "</NOMBRES>"
		  Response.Write "<APELLIDOS>" & ORs.Fields.Item(2).Value & "</APELLIDOS>"
		  
		  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listUbicaciones()

	query = "SELECT CODIGO,  DESCRIPCION, DIRECCION "
	query = query & " FROM UBICACION "
	query = query & " WHERE EMPRESA= " & strNvl(EMPRESA)
	
	IF Len(s)>0 THEN
			query = query & " AND DESCRIPCION LIKE '%" & s & "%'"
	END IF
	
	If Len(CLIENTE)>0 Then
		query = query & " AND CLIENTE = " & strNvl(CLIENTE)
	End If
	
	query = query & "ORDER BY DESCRIPCION"
	
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(2).Value & "</DIRECCION>"
		  
		  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listFaenas()

	query = "SELECT U.CODIGO,  U.DESCRIPCION  "
	query = query & " FROM UBICACION AS U "
	
	If P="1" Then
		query = query & " INNER JOIN FAENAS_USUARIO AS FU ON FU.USUARIO = " & strNvl(USUARIO)
		query = query & " AND  FU.ID_FAENA = U.CODIGO " 
		
	End If

	 query = query & " WHERE U.EMPRESA= " & strNvl(EMPRESA)
	
	query = query & "ORDER BY U.DESCRIPCION"
	
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
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