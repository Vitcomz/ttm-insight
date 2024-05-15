<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ID=UCASE(REQUEST("ID"))
ART22=REQUEST("ART22")
ANTI=REQUEST("ANTI")
DIRECCION=UCASE(REQUEST("DIRECCION"))

PASSWORD=REQUEST.Form("PASSWORD")
RUT=REQUEST("RUT")
TXTSRC=REQUEST("TXTSRC")
DV=UCASE(REQUEST("DV"))
NOMBRES=UCASE(REQUEST("NOMBRES"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
NIVEL=UCASE(REQUEST("NIVEL"))
APELLIDOS=UCASE(REQUEST("APELLIDOS"))
CLIENTE=REQUEST("CLIENTE")
ESTADO=REQUEST("ESTADO")
SIND=REQUEST("SIND")
CUAD=REQUEST("CUAD")
CARGO=REQUEST("CARGO")
DISP=REQUEST("DISP")
ETAPA=REQUEST("ETAPA")
ESP=REQUEST("ESP")
EMPRESA=REQUEST("EMPRESA")
EXCEL=REQUEST("EXCEL")
MES=REQUEST("MES")
ANHO=REQUEST("ANHO")
OBS=REQUEST("OBS")
PRE_GR=REQUEST("PRE_GR")
PRE_RRHH=REQUEST("PRE_RRHH")
PRE_APR_GR=REQUEST("PRE_APR_GR")
PRE_APR_RRHH=REQUEST("PRE_APR_RRHH")
APR_GR=REQUEST("APR_GR")
APR_RRHH=REQUEST("APR_RRHH")


FDH=REPLACE(REQUEST("FDH"),",",".")
FDH_T=REQUEST("FDH_T")

FNH=REPLACE(REQUEST("FNH"),",",".")
FNH_T=REQUEST("FNH_T")

FDF=REPLACE(REQUEST("FDF"),",",".")
FDF_T=REQUEST("FDF_T")

FNF=REPLACE(REQUEST("FNF"),",",".")
FNF_T=REQUEST("FNF_T")
FONOS=REQUEST("FONOS")

ACCESO_DB=REQUEST("ACCESO_DB")
ACCESO_EMP=REQUEST("ACCESO_EMP")
AFP=REQUEST("AFP")
SUELDO_BASE=REQUEST("SUELDO_BASE")
SSALUD=REQUEST("SSALUD")
BASED=REPLACE(REQUEST("BASED"),",",".")
BASED_T=REQUEST("BASED_T")

FECHA=REQUEST("FECHA")
FECHA_INI=REQUEST("FECHA_INI")
FECHA_FIN=REQUEST("FECHA_FIN")
FCONTRATO=REQUEST("FCONTRATO")
FANEXO=REQUEST("FANEXO")
FNAC=REQUEST("FNAC")
PERIODO=REQUEST("PERIODO")

H_INI=REQUEST("H_INI")
H_FIN=REQUEST("H_FIN")
EMAIL=REQUEST("EMAIL")
EMPRESA=REQUEST("EMPRESA")
IND_PAGO=REQUEST("IND_PAGO")
IND_BASED=REQUEST("IND_BASED")
IND_CON=REQUEST("IND_CON")
IND_FEST=REQUEST("IND_FEST")
IND_NOCHE=REQUEST("IND_NOCHE")
IND_ESP=REQUEST("IND_ESP")
IND_ST=REQUEST("IND_ST")
TIPO=REQUEST("TIPO")
LUGAR=REQUEST("LUGAR")
AREA=UCASE(REQUEST("AREA"))
CUADRILLA=UCASE(REQUEST("CUADRILLA"))
CLIENTE=UCASE(REQUEST("CLIENTE"))
CODIGO_OS=UCASE(REQUEST("CODIGO_OS"))
CODIGO=UCASE(REQUEST("CODIGO"))
COD_TRAB=UCASE(REQUEST("COD_TRAB"))
COLOR=UCASE(REQUEST("COLOR"))
GRUPO=UCASE(REQUEST("GRUPO"))
SUCURSAL=UCASE(REQUEST("SUCURSAL"))
CANTIDAD=UCASE(REQUEST("CANTIDAD"))
CANTIDAD_V=UCASE(REQUEST("CANTIDAD_V"))
CARGO=REQUEST("CARGO")
OS=REQUEST("OS")
USUARIO=REQUEST("USUARIO")
USERNAME=REQUEST("USERNAME")
RECURSO=REQUEST("RECURSO")
VALOR=UCASE(REQUEST("VALOR"))
VALOR_V=UCASE(REQUEST("VALOR_V"))
UBICACION=UCASE(REQUEST("UBICACION"))

select case RECURSO

	case "progHH"
		  progHH()
		  
	case "progHHCal"
		  progHHCal()
		  
	case "newDesbloq"
		newDesbloq()
	
	case "newBono"
		 newBono()
		
	case "setDesbloq"
		  setDesbloq()
	
	case "setAprob"
		  setAprob()
	
		case "setObs"
		  setObs()
		  				
						  					
	case "newTurnoUsr"
		newTurnoUsr()
	
	Case "getSTime"
		  getSTime()
		  
	case "getHora"
		  getHora()
	
	case "getEvent"
		  getEvent()
		  
		  	  
	case "getDesbloq"
		  getDesbloq()
		  	
	case "getPersonal"
		  getPersonal()
	
	case "getCuadrilla"
		  getCuadrilla()
	
	case "getCorreos"
		  getCorreos()
		  
		  	  
	case "newPersonal"
		  newPersonal()
		  	  
	case "newHora"
		  newHora()
	
	case "newHoraM"
		  newHoraM()
		  
	case "newUsrCuadrilla"
		  newUsrCuadrilla()
		  
	case "updateHora"
		  updateHora()
	
	case "updateCuadrilla"
		  updateCuadrilla()
	
	case "updateCorreos"
		  updateCorreos()
		  	  	
	case "updateEvent"
		  updateEvent()
		  
	case "updatePersonal"
		  updatePersonal()
	
			  
	case "updatePersonalBN"
		  updatePersBN()
		  	  
	case "delHora"
		  delHora()
	
	case "delBono"
		  delBono()
		  		  
	case "delUsrC"
		  delUsrC()
		
	case "delEvent"
		  delEvent()
		  
	case "delUsrEvent"
		 delUsrEvent()	  
		  
		  
	case "delEventCua"
		  delEventCua()
		    	  
	case "listPersonal"
		  listPersonal()
	
	case "listBonos"
		  listBonos()
		  	  
	case "listUsrCuadrilla"
			listUsrCuadrilla()
	
	case "listUsrCuadrillaP"
		listUsrCuadrillaP()
		
	case "listDesbloq"
		  listDesbloq()
	
	case "listAprobacion"
		  listAprob()
		  	  
	case "listPlanilla"
		  listPlanilla()
		  
	case "planillaPago"
		  planillaPago()  
		  
	case "planillaPagoXls"
		  planillaPagoXls()  
		  
	case "getPersonalOS"
		  getPersonalOS()
		  
	case "listHoras"
		  listHoras()

	case "listPersonalOS"
		  listPersOS()
	
		case "listDisp"
		  listDisp()
		  
		  	  
	case "listCargos"
		  listCargos()
		  
	case "listCuadrilla"
		  listCuadrilla()
		  
	case "insertPersonalOS"
		 insertPersonalOS()

	case "delPersonalOS"
		  delPersonalOS()
		
	case "listEmpresas"
		  listEmpresas()
		
	case "infHorasOS"
		  infHorasOS()

	case "infNochera"
		  infNochera()
	
		case "infCond"
		  infCond()
		  	  
	case "infHorasTr"
		  infHorasTr()
	
	case "infHorasTr2"
		  infHorasTr2()
		  	  
	case "infHorasSeg"
		  infHorasSeg()
		  	  
	case "UsuariosSistemas"
		  UsuariosSistemas()
		
	case "ExisteUsuario"
		  ExisteUsuario()
		
	case "validateHora" 
	 	  validateHora() 
		  
end select

function progHH()

	Set Cn = oDB.Conexion
	STR = "DBO.SP_SCI_progHH "
	STR = STR & " @INICIO=" & strNvl(FECHA_INI)
	STR = STR & ", @FINAL =" & strNvl(FECHA_FIN)
		
    Set ORs = Cn.Execute (STR)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	   Response.Write "<ROW>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<NOMBRES>" & ORs.Fields.Item(2).Value & "</NOMBRES>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"

		  Response.Write "<ESP>" & ORs.Fields.Item(4).Value & "</ESP>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function progHHCal()

	Set Cn = oDB.Conexion
	
	IF LEN(CODIGO)>0 THEN
		STR = "DBO.SP_SCI_progHHCal "
		STR = STR & "  @CODIGO=" & strNvl(CODIGO)
		STR = STR & ", @CUAD=" & strNvl(CUAD)
		STR = STR & ", @GRUPO=" & strNvl(GRUPO)
		STR = STR & ", @INICIO=" & strNvl(FECHA_INI)
		STR = STR & ", @FINAL =" & strNvl(FECHA_FIN)
	
	ELSE
		STR = "DBO.SP_SCI_progHHCal_all "
		STR = STR & " @CUAD=" & strNvl(CUAD)
		STR = STR & ", @GRUPO=" & strNvl(GRUPO)
		STR = STR & ", @INICIO=" & strNvl(FECHA_INI)
		STR = STR & ", @FINAL =" & strNvl(FECHA_FIN)
	
	END IF

	

		
    Set ORs = Cn.Execute (STR)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<xml>" & STR
	While Not ORs.EOF 
	   Response.Write "<event>"
		  Response.Write "<id>" & ORs.Fields.Item(0).Value & "</id>"
		  Response.Write "<start>" & ORs.Fields.Item(1).Value & "</start>"
		  Response.Write "<end>" & ORs.Fields.Item(2).Value & "</end>"
		  Response.Write "<title>" & mid(ORs.Fields.Item(3).Value,1,15) & "</title>"
		  Response.Write "<ubi>" & ORs.Fields.Item(4).Value & "</ubi>"
		  Response.Write "<esp>" & mid(ORs.Fields.Item(5).Value,1,10) & "</esp>"
		  Response.Write "<color>" & ORs.Fields.Item(7).Value & "</color>"
		 
	    Response.Write "</event>"
	  ORs.MoveNext
	Wend
	Response.Write "</xml>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listDisp()

	Set Cn = oDB.Conexion
 	dim i
	i=1
		STR = "DBO.SP_SCI_progHHCal_dis "
		STR = STR & "  @CODIGO=" & strNvl(CODIGO)
		STR = STR & ", @CARGO='" & CARGO & "'"
		STR = STR & ", @CLIENTE=" & strNvl(CLIENTE)
		STR = STR & ", @INICIO=" & strNvl(FECHA)
		STR = STR & ", @FINAL =" & strNvl(FECHA)
 
    Set ORs = Cn.Execute (STR)
	
	IF (EXCEL="YES") THEN
	
	Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=DIS_" &  FECHA & ".xls"
		
	 
	Response.Write "<TABLE border=0>" '& query
	Response.Write "<TR>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
	Response.Write "</TR>"
	
	Response.Write "<TR>"
		Response.Write "<TD> </TD>"
	  	Response.Write "<TD>N°</TD>"
	  	Response.Write "<TD>CARGO</TD>"' cod_cargo
	  	Response.Write "<TD>NOMBRE </TD>"
	  	Response.Write "<TD>FONO </TD>"
	  	Response.Write "<TD>DIRECCION</TD>"
		 
		  
	Response.Write "</TR>"
	
	While Not ORs.EOF 
	Response.Write "<TR>"
		Response.Write "<TD> </TD>"
	  	Response.Write "<TD>" & i & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
	 
		  
		i=i+1
	  ORs.MoveNext
  	Response.Write "</TR>"
	Wend
	Response.Write "</TABLE>"
	
	ELSE
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<xml>" & STR
	While Not ORs.EOF 
	   Response.Write "<ROW>"
		  Response.Write "<COD>" & ORs.Fields.Item(0).Value & "</COD>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<ESP>" & ORs.Fields.Item(2).Value & "</ESP>"
		  Response.Write "<FONO>" & ORs.Fields.Item(3).Value & "</FONO>"
		  Response.Write "<DIR>" & ORs.Fields.Item(4).Value & "</DIR>"
		  
		 
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</xml>"
	
	End If
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getSTime()

	query = "SELECT getdate() "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	Response.Write "<ROW>"
	 Response.Write "<STIME>" & ORs.Fields.Item(0).Value & "</STIME>"
  	Response.Write "</ROW>"
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function 

function newDesbloq()

	query = " DELETE DESBLOQUEOS WHERE ID=" & strNvl(ID)
	query = query & " AND FECHA=" & strNvl(FECHA)
	Set ORs =oDB.EjecutaSql(query)

	query = "INSERT INTO DESBLOQUEOS (" 
	query = query & " ID, "
	query = query & " FECHA,"
	query = query & " OS,"
	query = query & " USERNAME, USERDATE) "
	query = query & " VALUES ("
	query = query & strNvl(ID) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(OS) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & "GETDATE())"
	
	Set ORs =oDB.EjecutaSql(query)
	'Response.ContentType = "text/html"
	'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	'Response.Write "<REGISTROS>"
	'Response.Write "<ROW>ok</ROW>"
	'Response.Write "</REGISTROS>"
	 Response.Write "{""j"":[{""__type"":""Cliente""," & _
							"""CompanyName"":""" & 1 & """," & _
							"""Address"":""" & 2 & """," & _
							"""Tel"":""" & "Mensaje Enviado." & _
					        """}]}"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function newTurnoUsr()

	query = "DELETE TURNOS_USUARIOS WHERE USUARIO=" & strNvl(USUARIO) & " AND FECHA=" & strNvl(FECHA) 
	Set ORs =oDB.EjecutaSql(query)
	
	query = "INSERT INTO TURNOS_USUARIOS (" 
	query = query & " USUARIO, "
	query = query & " FECHA, VALOR, USERNAME, USERDATE) "
	query = query & " VALUES ("
	query = query & strNvl(USUARIO) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & "GETDATE())"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function newUsrCuadrilla()

	'query = "DELETE TURNOS_USUARIOS WHERE USUARIO=" & strNvl(USUARIO) & " AND FECHA=" & strNvl(FECHA) 
	'Set ORs =oDB.EjecutaSql(query)
	
	query = "INSERT INTO USUARIOS_CUADRILLA (" 
	query = query & " CODIGO, "
	query = query & " USUARIO, USERNAME, USERDATE) "
	query = query & " VALUES ("
	query = query & strNvl(CUADRILLA) & ","
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & "GETDATE())"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function newBono()
 
 
 	query = " DELETE BONOS WHERE COD_TRAB=" & strNvl(COD_TRAB) & " AND CODIGO=" & strNvl(CODIGO)
	Set ORs =oDB.EjecutaSql(query)
	
	query = "INSERT INTO BONOS (" 
	query = query & " CODIGO, "
	query = query & " VALOR, COD_TRAB) "
	query = query & " VALUES ("
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(COD_TRAB) & ")"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function listPersonal()

	query = "SELECT T.CODIGO, T.NOMBRE, C.DESCRIPCION, T.BASEDIA, T.HDN "
	query = query & " FROM TRABAJADORES AS T "
	query = query & " LEFT OUTER JOIN  CARGOS  AS C ON T.COD_CARGO = C.CODIGO AND C.EMPRESA='SIMMA' "
	query = query & " WHERE T.NOMBRE LIKE '%" & 	TXTSRC & "%'"
	'query = query & " AND T.SUCURSAL=" & strNvl(SUCURSAL)
	query = query & " AND T.EMPRESA='SIMMA'"
	
	IF ROL<>"TOD" AND LEN(ROL)>0 THEN
		query = query & " AND ROL = " & strNvl(ROL)
	END IF
	
	query = query & " ORDER BY NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
	  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
	  Response.Write "<VALOR_V>" & ORs.Fields.Item(4).Value & "</VALOR_V>"
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 


function listCuadrilla()

	query = "SELECT CODIGO, NOMBRE, COLOR, GRUPO "
	query = query & " FROM CUADRILLAS "
	query = query & " WHERE 1=1 "
	IF len(GRUPO)>0 THEN
		query = query & " AND GRUPO=" & strNvl(GRUPO)
	END IF
	
	IF LEN(ESTADO)>0 THEN
		query = query & " AND ESTADO='ACT'"
	END IF
		
	query = query & " ORDER BY NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<COLOR>" & ORs.Fields.Item(2).Value & "</COLOR>"

	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 


function listUsrCuadrillaP()


	query = query & "SELECT T.CODIGO, T.NOMBRE, T.COD_CARGO,  T.FONOS, T.DIRECCION "
	query = query & ", min(TU.FECHA), max(TU.FECHA_FIN)  "
	query = query & " FROM TURNOS_USUARIOS AS TU "
	query = query & " INNER JOIN TRABAJADORES AS T ON TU.USUARIO=T.CODIGO "
	query = query & " LEFT OUTER JOIN CARGOS AS C ON C.CODIGO=T.COD_CARGO "
	query = query & " WHERE TU.VALOR=" & strNvl(CODIGO)
	query = query & " AND TU.FECHA BETWEEN " & strNvl(FECHA_INI) & " AND " & strNvl(FECHA_FIN)
	query = query & " GROUP BY T.CODIGO, T.NOMBRE, T.COD_CARGO,  T.FONOS, T.DIRECCION "
	
	query = query & " ORDER BY T.COD_CARGO "
	
	Set ORs =oDB.EjecutaSql(query)
	i=1
	
	IF (EXCEL="YES") THEN
	
	Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=CU_" &  FECHA_INI & ".xls"
		
	 
	Response.Write "<TABLE>" '& query
	Response.Write "<TR>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
		Response.Write "<TD> </TD>"
	Response.Write "</TR>"
	
	Response.Write "<TR>"
		Response.Write "<TD> </TD>"
	  	Response.Write "<TD>N°</TD>"
	  	Response.Write "<TD>CARGO</TD>"' cod_cargo
	  	Response.Write "<TD>NOMBRE </TD>"
	  	Response.Write "<TD>FONO </TD>"
	  	Response.Write "<TD>DIRECCION</TD>"
		Response.Write "<TD>FECHA INI</TD>"
		Response.Write "<TD>FECHA FIN</TD>"
		  
	Response.Write "</TR>"
	
	While Not ORs.EOF 
	Response.Write "<TR>"
		Response.Write "<TD> </TD>"
	  	Response.Write "<TD>" & i & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
	  	Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
		Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
		Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
		  
		i=i+1
	  ORs.MoveNext
  	Response.Write "</TR>"
	Wend
	Response.Write "</TABLE>"
	
	ELSE

	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	
	  Response.Write "<N>" & i & "</N>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
	  Response.Write "<FONO>" & ORs.Fields.Item(3).Value & "</FONO>"
	  Response.Write "<DIRECCION>" & ORs.Fields.Item(4).Value & "</DIRECCION>"
		Response.Write "<FECHA>" & ORs.Fields.Item(5).Value & "</FECHA>"
		Response.Write "<FECHA_FIN>" & ORs.Fields.Item(6).Value & "</FECHA_FIN>"
		  
		i=i+1
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	
	END IF
	
	
	Set ORs = Nothing
	Set oDB = Nothing
end function 

function listUsrCuadrilla()

	query = "SELECT T.CODIGO, T.NOMBRE, T.COD_CARGO "
	query = query & " FROM USUARIOS_CUADRILLA AS C "
	query = query & " INNER JOIN TRABAJADORES AS T ON C.USUARIO=T.CODIGO "
	query = query & " WHERE C.CODIGO=" & CODIGO
	
	'query = query & " UNION " 
	'query = query & "SELECT T.CODIGO, T.NOMBRE, T.CARGO "
	'query = query & " FROM TURNOS_USUARIOS AS TU "
	'query = query & " INNER JOIN TRABAJADORES AS T ON TU.USUARIO=T.CODIGO "
	'query = query & " WHERE TU.VALOR=" & strNvl(CODIGO)
	
	query = query & " ORDER BY NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	i=1
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	
	  Response.Write "<N>" & i & "</N>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
		i=i+1
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 

function listTrabCargo()

	query = "SELECT T.CODIGO, T.NOMBRE, T.CARGO, T.COD_CARGO "
	query = query & " FROM TRABAJADORES  AS T "
	query = query & " INNER JOIN dbo.SCI.CARGOS AS C ON C.CODIGO = T.COD_CARGO "
	query = query & " WHERE C.CODIGO=" & CODIGO	
	query = query & " ORDER BY NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	i=1
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	
	  Response.Write "<N>" & i & "</N>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
		i=i+1
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 


function setDesbloq()

	query = " UPDATE DESBLOQUEOS "
	query = query & " SET IND_DESBLQ='TRUE',"
	query = query & " DESBLQ_DATE = GETDATE() WHERE ID=" & strNvl(ID)
	query = query & " AND FECHA=" & strNvl(FECHA)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/html"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"
	' Response.Write "{""j"":[{""__type"":""Cliente""," & _
	'						"""CompanyName"":""" & 1 & """," & _
	'						"""Address"":""" & 2 & """," & _
	'						"""Tel"":""" & "Mensaje Enviado." & _
	'				        """}]}"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function setAprob()


	SELECT CASE TIPO
	
		CASE "PRE_GR"
			query = " UPDATE TRABAJADORES "
			query = query & " SET PRE_GR=" & strNvl(VALOR) & ","
			query = query & "      USER_PRE_GR =" & strNvl(USERNAME) & ","
			query = query & "      DATE_PRE_GR = GETDATE() "
			query = query & " WHERE CODIGO=" & strNvl(CODIGO)
	 
	 	
		CASE "PRE_RRHH"
			query = " UPDATE TRABAJADORES "
			query = query & " SET PRE_RRHH=" & strNvl(VALOR) & ","
			query = query & "      USER_PRE_RRHH =" & strNvl(USERNAME) & ","
			query = query & "      DATE_PRE_RRHH = GETDATE() "
				query = query & " WHERE CODIGO=" & strNvl(CODIGO)
		
		CASE "APR_GR"
			query = " UPDATE TRABAJADORES "
			query = query & " SET APR_GR=" & strNvl(VALOR) & ","
			query = query & "      USER_APR_GR =" & strNvl(USERNAME) & ","
			query = query & "      DATE_APR_GR = GETDATE() "
			query = query & " WHERE CODIGO=" & strNvl(CODIGO)
			
		CASE "APR_RRHH"
			query = " UPDATE TRABAJADORES "
			query = query & " SET APR_RRHH=" & strNvl(VALOR) & ","
			query = query & "      USER_APR_RRHH =" & strNvl(USERNAME) & ","
			query = query & "      DATE_APR_RRHH = GETDATE() "
			query = query & " WHERE CODIGO=" & strNvl(CODIGO)
			
	END SELECT
	
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/html"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"
	' Response.Write "{""j"":[{""__type"":""Cliente""," & _
	'						"""CompanyName"":""" & 1 & """," & _
	'						"""Address"":""" & 2 & """," & _
	'						"""Tel"":""" & "Mensaje Enviado." & _
	'				        """}]}"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function getPersonalOS()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	Dim BASEDIA
    DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0

	STR =	"SP_SG_INF_HORAS_OS "
	STR = STR & " @os=" & strNvl(OS)
	STR = STR & ",@anho=" & strNvl(ANHO)
	STR = STR & ",@sucursal='" & UBICACION & "'"

	
 	Set ORs = Cn.Execute (STR)
   	
	'Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	   Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
	    
		Response.Write "<BASED>" & ORs.Fields.Item(3).Value & "</BASED>"
		BASED_T = CDBL(ORs.Fields.Item(11).Value)* ORs.Fields.Item(3).Value
		Response.Write "<BASED_T>" & formatNumber(BASED_T,0)  & "</BASED_T>"
			
			FDH = CDBL( ORs.Fields.Item(4).Value) '+ CDBL(ORs.Fields.Item(5).Value) + CDBL(ORs.Fields.Item(6).Value) 
			Response.Write "<FDH>" & FDH & "</FDH>"
			Response.Write "<FDH_T>" & FORMATNUMBER(FDH*ORs.Fields.Item(10).Value,1) & "</FDH_T>"
			
			FNH = ROUND(CDBL(ORs.Fields.Item(5).Value) + CDBL(ORs.Fields.Item(6).Value),1)
			
			Response.Write "<FNH>" & FNH & "</FNH>"
			Response.Write "<FNH_T>" & FORMATNUMBER(FNH*ORs.Fields.Item(10).Value,1) & "</FNH_T>"
			
			FDF = CDBL( ORs.Fields.Item(7).Value) '+ CDBL(ORs.Fields.Item(5).Value) + CDBL(ORs.Fields.Item(6).Value) 
			Response.Write "<FDF>" & FDF & "</FDF>"
			Response.Write "<FDF_T>" & FORMATNUMBER(FDF*ORs.Fields.Item(10).Value,01) & "</FDF_T>"
			
			
			FNF = ROUND(CDBL( ORs.Fields.Item(8).Value) + CDBL(ORs.Fields.Item(9).Value),1)
			Response.Write "<FNF>" & FNF & "</FNF>"
			Response.Write "<FNF_T>" & FORMATNUMBER(FNF*ORs.Fields.Item(10).Value,0) & "</FNF_T>"
						
			Response.Write "<TOTAL>" & FORMATNUMBER((FDH + FNH + FDF + FNF)* CDBL(ORs.Fields.Item(10).Value) + BASED_T,1) & "</TOTAL>"
			Response.Write "<TOTALN>" & (FDH + FNH + FDF + FNF)* CDBL(ORs.Fields.Item(10).Value) + BASED_T & "</TOTALN>"
			
			
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 


function listCargos()

	query = "SELECT CODIGO, DESCRIPCION "
	'query = query & " FROM Transbandred.DBO.CARGOS  "
	query = query & " FROM CARGOS  "
	query = query & " WHERE EMPRESA='SIMMA'"
	query = query & " ORDER BY DESCRIPCION "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 

function listBonos()

	query = "SELECT B.CODIGO, B.VALOR, D.DESCRIPCION, B.COD_TRAB, T.NOMBRE  "
	query = query & " FROM BONOS  AS B "
	query = query & " INNER JOIN BONOS_DESC AS D ON B.CODIGO = D.CODIGO"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO = B.COD_TRAB"
	
	If(Len(COD_TRAB))>0 Then
		query = query & " WHERE B.COD_TRAB = " & strNvl(COD_TRAB)
	End If
	
	If(Len(CODIGO))>0 Then
		query = query & " WHERE B.CODIGO = " & strNvl(CODIGO)
	End If
		
	'query = query & " ORDER BY DESCRIPCION "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  	Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	 	Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
 		Response.Write "<DESC>" & ORs.Fields.Item(2).Value & "</DESC>"
		Response.Write "<TRAB>" & ORs.Fields.Item(4).Value & "</TRAB>"
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 


function listPersOS()

	query = "SELECT T.CODIGO, T.NOMBRE, T.CARGO,"
	query = query & " TT.BASED, TT.BASED_T , TT.FDH, ISNULL(TT.FDH_T,0) , "
	query = query & " ISNULL(TT.FNH,0) , ISNULL(TT.FNH_T,0) , ISNULL(TT.FDF,0) , "
	query = query & " isNull(TT.FDF_T,0), isNull(TT.FNF,0) ,  isNull(TT.FNF_T,0) "
	query = query & " FROM TURNOS_REALIZADOS AS TT "
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO = TT.USUARIO "
	query = query & " WHERE TT.ORDEN_SERVICIO ='" & CODIGO & "'"
	query = query & " AND TT.ANHO ='" & ANHO & "'"
	query = query & " AND T.EMPRESA ='SIMMA'" 
	query = query & " ORDER BY T.NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	 Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	 Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	 Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
	 Response.Write "<BASED>" & ORs.Fields.Item(3).Value & "</BASED>"
	 BASED_T = ORs.Fields.Item(4).Value
	 Response.Write "<BASED_T>" & formatNumber(BASED_T,0)   & "</BASED_T>"
	 
'		BASED_V = 	ROUND(ORs.Fields.Item(4).Value / ORs.Fields.Item(3).Value,0)
		
			Response.Write "<FDH>" & ORs.Fields.Item(5).Value  & "</FDH>"
			Response.Write "<FDH_T>" & formatNumber( ORs.Fields.Item(6).Value,0)  & "</FDH_T>"
			
			FDH=ORs.Fields.Item(6).Value
			
			Response.Write "<FNH>" & ORs.Fields.Item(7).Value & "</FNH>"
			Response.Write "<FNH_T>" & formatNumber(ORs.Fields.Item(8).Value,0)  & "</FNH_T>"
			FNH = ORs.Fields.Item(8).Value
			
			Response.Write "<FDF>" & ORs.Fields.Item(9).Value & "</FDF>"
			Response.Write "<FDF_T>" & formatNumber(ORs.Fields.Item(10).Value,0)  & "</FDF_T>"
			FDF = ORs.Fields.Item(10).Value

			Response.Write "<FNF>" & ORs.Fields.Item(11).Value  & "</FNF>"
			Response.Write "<FNF_T>" & formatNumber(ORs.Fields.Item(12).Value,0)  & "</FNF_T>"
			FNF = ORs.Fields.Item(12).Value
	 
			Response.Write "<TOTAL>" & FORMATNUMBER(FDH + FNH + FDF + FNF + BASED_T,0) & "</TOTAL>"
	  		Response.Write "<TOTAL_N>" & FDH + FNH + FDF + FNF + BASED_T & "</TOTAL_N>"
	 
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	
	'Response.Write "<ROW>"
'	 Response.Write "<CODIGO>--</CODIGO>"
'	 Response.Write "<NOMBRE>TOTAL PERSONAL </NOMBRE>"
'	 Response.Write "<CARGO>--</CARGO>"
'	 Response.Write "<CANTIDAD>--</CANTIDAD>"
'	 Response.Write "<VALOR>--</VALOR>"
'	 Response.Write "<TOTAL>" & TOTAL & "</TOTAL>"
'	 Response.Write "<TOTAL_N>" & TOTAL & "</TOTAL_N>"
'	 
'	 Response.Write "<CANTIDAD_V>--</CANTIDAD_V>"
'	 Response.Write "<VALOR_V>--</VALOR_V>"
'	 Response.Write "<TOTAL_V>" & TOTAL_V & "</TOTAL_V>"
'	 Response.Write "<TOTAL_V_N>" & TOTAL_V & "</TOTAL_V_N>"
'	 
'  	Response.Write "</ROW>"
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function

function listPlanilla()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
   

	STR =	"SP_SG_PLANILLA_TR @empresa='SIMMA' "
	
 	Set ORs = Cn.Execute (STR)
   	
	'Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
	  Response.Write "<SUELDO_PRO>" & ORs.Fields.Item(3).Value & "</SUELDO_PRO>"
	  Response.Write "<BASED>" & ORs.Fields.Item(4).Value & "</BASED>"
	  Response.Write "<FDH>" & ORs.Fields.Item(5).Value & "</FDH>"
	  Response.Write "<FNH>" & ORs.Fields.Item(6).Value & "</FNH>"
	  Response.Write "<FDF>" & ORs.Fields.Item(7).Value & "</FDF>"
      Response.Write "<FNF>" & ORs.Fields.Item(8).Value & "</FNF>"	
	  Response.Write "<SIND>" & ORs.Fields.Item(9).Value & "</SIND>"		
	  
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function 

function planillaPago()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	Dim DT
    Dim DIAS_H

	DIAS_H = getDaysInMonth("01/" & MES & "/2014")
			
	STR =	"SP_SG_PLANILLA_PAGO @empresa='SIMMA', @mes=" & strNvl(MES) 
	STR = STR & ", @anho=" & strNvl(ANHO)
	STR = STR & ", @sucursal='ADM-ANTF'"  
	
 	Set ORs = Cn.Execute (STR)
   	
	IF EXCEL="YES" THEN	
	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=SabanaRenumeracion" & MES & "-" & ANHO & ".xls"
		
		Response.Write "<TABLE BORDER=1>"
 
 		Response.Write "<TR>"
			Response.Write "<TD>CARGO</TD>"
			Response.Write "<TD>CLIENTE</TD>"  
			Response.Write "<TD>RUT</TD>"
	 		Response.Write "<TD>NOMBRE</TD>"
	 		Response.Write "<TD>SUELDO B.</TD>"
			Response.Write "<TD>VALOR HORA</TD>"
			Response.Write "<TD>DIAS TRAB.</TD>"
			Response.Write "<TD>FALLAS/LIC.</TD>"
			Response.Write "<TD>H011 50% Hrs</TD>"
			Response.Write "<TD>H011 50% Valor</TD>"	
			Response.Write "<TD>H103 Informe Sup.</TD>"
			Response.Write "<TD>H106 Partic.</TD>"
			Response.Write "<TD>H108 Spence</TD>"
			Response.Write "<TD>H110 Faena</TD>"
			Response.Write "<TD>H111 Otros</TD>"
			
			Response.Write "<TD>H117 Q1</TD>"
			Response.Write "<TD>H118 Q2</TD>"
			Response.Write "<TD>H119 Q3</TD>"
			Response.Write "<TD>H131 Q4</TD>"
			
	 		Response.Write "<TD>H122 Nocheras</TD>"
	  		Response.Write "<TD>H122 $</TD>"
			
	  		Response.Write "<TD>H125 Conducción</TD>"
	  		Response.Write "<TD>H125 $</TD>"
			
			Response.Write "<TD>H133 Gest Spence</TD>"
			Response.Write "<TD>H144 KPIs</TD>"
			
	  		Response.Write "<TD>H145 Pend.</TD>"
			Response.Write "<TD>H145 $</TD>"
						
	  		Response.Write "<TD>H147 7x7 Hrs </Td>"
	  		Response.Write "<TD>H147 $</TD>"
			
			Response.Write "<TD>H149</TD>"
			Response.Write "<TD>H149</TD>"
			Response.Write "<TD>H152 Pend. 7x7</TD>"
			Response.Write "<TD>H152 $</TD>"
			Response.Write "<TD>H156 SG</TD>"
						
			Response.Write "</TR>"	
			
	While Not ORs.EOF 
	
			Response.Write "<TR>"
			Response.Write "<TD>" & ORs.Fields.Item(27).Value & "</TD>"  ' CARGO
			Response.Write "<TD>" & ORs.Fields.Item(13).Value & "</TD>"  ' CLIENTE
			Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"  ' RUT 
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"	 ' NOMBRE
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value  & "</TD>"	 ' SUELDO
	 		Response.Write "<TD>" & ORs.Fields.Item(12).Value & "</TD>"  ' VALOR H
			Response.Write "<TD>" & ORs.Fields.Item(2).Value  & "</TD>"	 ' DIAS TRAB.
			Response.Write "<TD>" & ORs.Fields.Item(28).Value & "</TD>"  ' DIAS FALLA
			
			DT = ORs.Fields.Item(2).Value
			VALOR_H = ORs.Fields.Item(12).Value
			
			
		    Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(5).Value,1)  & "</TD>" ' 50% hrs
		 	Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(5).Value*VALOR_H,0) & "</TD>" '50% Valor

			Response.Write "<TD>" & ORs.Fields.Item(15).Value & "</TD>" ' H103
			Response.Write "<TD>" & 0 & "</TD>" ' H106
			Response.Write "<TD>" & FormatNumber((ORs.Fields.Item(16).Value/DIAS_H)*DT,0) & "</TD>"	' H108
			
			Response.Write "<TD>" & ORs.Fields.Item(18).Value & "</TD>" ' H110
			Response.Write "<TD>" & ORs.Fields.Item(19).Value & "</TD>" ' H111
			Response.Write "<TD>" & ORs.Fields.Item(29).Value & "</TD>"	' H117 Q1
			Response.Write "<TD>" & ORs.Fields.Item(30).Value & "</TD>"	' H118 Q2
			Response.Write "<TD>" & ORs.Fields.Item(31).Value & "</TD>"	' H119 Q3
			Response.Write "<TD>" & ORs.Fields.Item(31).Value & "</TD>"	' H131 Q4
			
			Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>" ' H122
			Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(10).Value*VALOR_H,0)  & "</TD>"
			
			Response.Write "<TD>" & ORs.Fields.Item(4).Value 		& "</TD>" 	'H125
	 		Response.Write "<TD>" & ORs.Fields.Item(4).Value*5000 	& "</TD>"	'H125
		  		
	  		Response.Write "<TD>" & ORs.Fields.Item(17).Value & "</TD>"	' H133
	  		Response.Write "<TD>" & ORs.Fields.Item(21).Value & "</TD>" ' H144
			
	  		Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(22).Value,0) & "</TD>" 'H145
	  		Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(22).Value*VALOR_H,0) & "</TD>"
					
			Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(14).Value,1) & "</TD>" 'H147
	  		Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(14).Value*VALOR_H,0) & "</TD>"
	  
			Response.Write "<TD>" & ORs.Fields.Item(25).Value & "</TD>" ' H149 Special
			Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(25).Value*VALOR_H,0) & "</TD>" 'H149 
	 
			Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(32).Value,0) & "</TD>"' H152 Pen7x7
	  		Response.Write "<TD>" & FormatNumber(ORs.Fields.Item(32).Value*VALOR_H,0) & "</TD>"
	  
			Response.Write "<TD>" & FormatNumber((ORs.Fields.Item(26).Value/DIAS_H)*DT,0) & "</TD>" 'H156 SG
			
			
			Response.Write "</TR>"	
		ORs.MoveNext
			
	Wend
		
		Response.Write "</TABLE>"
	
	ELSE
	
	
	'Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & STR
	While Not ORs.EOF 
	Response.Write "<ROW>"
	
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<CANT>" & ORs.Fields.Item(2).Value & "</CANT>"
	  DT = ORs.Fields.Item(2).Value
	  VALOR_H = ORs.Fields.Item(12).Value
	  Response.Write "<SUELDO_PRO>" & formatNumber(ORs.Fields.Item(3).Value,0) & "</SUELDO_PRO>"
	 
	
	  Response.Write "<DH>" & FormatNumber(ORs.Fields.Item(5).Value,1) & "</DH>"
	  Response.Write "<DH_VALOR>" & FormatNumber((ORs.Fields.Item(5).Value) *VALOR_H,0) & "</DH_VALOR>"
	
	  Response.Write "<NOCHE>" & FormatNumber(ORs.Fields.Item(10).Value,1) & "</NOCHE>"
	  Response.Write "<N_VALOR>" & FormatNumber(ORs.Fields.Item(10).Value*VALOR_H,0) & "</N_VALOR>"	
	  	  
	  Response.Write "<NH>" & ORs.Fields.Item(7).Value & "</NH>"
	  Response.Write "<DF>" & ORs.Fields.Item(8).Value & "</DF>"
	  Response.Write "<NF>" & ORs.Fields.Item(9).Value & "</NF>"
     
	  IF ORs.Fields.Item(10).Value ="true" then
	  		cond = "Si"
	  else
	  		cond ="No"
	  End If
	  
	  Response.Write "<SIS_TUR>" & cond & "</SIS_TUR>"		
	  Response.Write "<VALOR>" & FormatNumber(ORs.Fields.Item(12).Value,1) & "</VALOR>"
	  
	  Response.Write "<CLIENTE>" & ORs.Fields.Item(13).Value & "</CLIENTE>"
	  
	  Response.Write "<T7>" & FormatNumber(ORs.Fields.Item(14).Value,1) & "</T7>" 'H147
	  Response.Write "<T7_VALOR>" & FormatNumber(ORs.Fields.Item(14).Value*VALOR_H,0) & "</T7_VALOR>"
	  
	  Response.Write "<H103>" & FormatNumber(ORs.Fields.Item(15).Value,0) & "</H103>"
	  Response.Write "<H108>" & FormatNumber((ORs.Fields.Item(16).Value/DIAS_H)*DT,0) & "</H108>"
	  
	  Response.Write "<H133>" & FormatNumber(ORs.Fields.Item(17).Value,0) & "</H133>"
	  Response.Write "<H110>" & FormatNumber(ORs.Fields.Item(18).Value,0) & "</H110>"
	  Response.Write "<H111>" & FormatNumber(ORs.Fields.Item(19).Value,0) & "</H111>"
	  
	  Response.Write "<H117>" & FormatNumber(ORs.Fields.Item(29).Value,0) & "</H117>"
	  Response.Write "<H118>" & FormatNumber(ORs.Fields.Item(30).Value,0) & "</H118>"
	  Response.Write "<H119>" & FormatNumber(ORs.Fields.Item(31).Value,0) & "</H119>"
	  
	  Response.Write "<COND>" & ORs.Fields.Item(4).Value & "</COND>" ' H125
	  Response.Write "<C_VALOR>" & ORs.Fields.Item(4).Value*5000 & "</C_VALOR>"
	  
	 
	  Response.Write "<H144>" & FormatNumber(ORs.Fields.Item(21).Value,0) & "</H144>" 'KPIs
	  
	  Response.Write "<H145>" & FormatNumber(ORs.Fields.Item(22).Value,0) & "</H145>"
	  Response.Write "<H145_V>" & FormatNumber(ORs.Fields.Item(22).Value*VALOR_H,0) & "</H145_V>"
	   
	  
	  Response.Write "<H149>" & FormatNumber(ORs.Fields.Item(25).Value,1) & "</H149>"  
	  Response.Write "<H149_V>" & FormatNumber(ORs.Fields.Item(25).Value*VALOR_H,0) & "</H149_V>" 
	    
	  
	  
	  Response.Write "<CARGO>" & ORs.Fields.Item(27).Value & "</CARGO>"
	  Response.Write "<FALLA>" & ORs.Fields.Item(28).Value & "</FALLA>"
	 
	  Response.Write "<H152>" & FormatNumber(ORs.Fields.Item(32).Value,0) & "</H152>"
	  Response.Write "<H152_V>" & FormatNumber(ORs.Fields.Item(32).Value*VALOR_H,0) & "</H152_V>"
	  Response.Write "<H156>" & FormatNumber((ORs.Fields.Item(26).Value/DIAS_H)*DT,0) & "</H156>" 
	  
	  ORs.MoveNext
  	Response.Write "</ROW>"
	Wend
	Response.Write "</REGISTROS>"
	END IF
	
	Set ORs = Nothing
	Set oDB = Nothing
end function 

function planillaPagoXls()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
   

	STR =	"SP_SG_PLANILLA_P_XLS @empresa='SIMMA', @mes=" & strNvl(MES) 
	STR = STR & ", @anho=" & strNvl(ANHO)
	STR = STR & ", @anti=" & strNvl(ANTI)
	STR = STR & ", @sucursal='ADM-ANTF'"  
	
	If ANTI="true" Then
		filename = "ANTICIPOS_" & ANHO &  MES 
	Else
		filename = "SUELDOS_" & ANHO &  MES
	End If
	
 	Set ORs = Cn.Execute (STR)
	Dim ceros12
	Dim ceros8
	Dim ceros3
	
	Dim rut
	Dim monto
	
	ceros12 ="000000000000"
	ceros8  ="00000000"
	ceros3  ="000"
	
   	 'SUBSTRING(@CERO12, 0, 12-LEN(T.RUT)) +
	 
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition", "attachment;filename=" & filename & ".xls"
	Response.Write "<TABLE BORDER=0 cellpadding='1' cellspacing='2'>"
 			
	While Not ORs.EOF 
			
			Response.Write "<TR>"
			rut = ORs.Fields.Item(0).Value
			codBono = ORs.Fields.Item(2).Value
			monto = ROUND(ORs.Fields.Item(3).Value,0)
			
			response.Write("<td width=500  align='left' >=""" & mid(ceros12, 1, 12 - len(rut)) &  rut  & _
			
			ORs.Fields.Item(1).Value & mid(ceros3, 1, 3 - len(codBono)) &  codBono & _
			mid(ceros8, 1, 8 - len(monto)) & monto & MES  &  ANHO  & "00000.000" & _
			
			 """</td>")
			
	 	'	Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"
		'	
	 	'	response.Write("<td width=30  align='left' >=""" & mid(ceros3, 1, 3 - len(codBono)) &  codBono  & """</td>")
		'	 
		'	monto = ROUND(ORs.Fields.Item(3).Value,0)
		'	response.Write("<td width=100 align='left' >=""" & mid(ceros8, 1, 8 - len(monto)) & monto  & """</td>")
		'	
	 	 '	response.Write("<td width=50 align='left' >=""" & MES  & """</td>")
		'	response.Write("<td width=50 align='left' >=""" & ANHO  & """</td>")
		'	response.Write("<td width=80 align='left' >=""" & mid(ceros8, 1, 5)   & ".00""</td>")
		'	response.Write("<td width=50 align='left' >=""" & mid(ceros3, 1, 1)   & """</td>")
				    
			Response.Write "</TR>"	
		ORs.MoveNext
			
	Wend
		
	
		Response.Write "</TABLE>"
	
	
	Set ORs = Nothing
	Set oDB = Nothing
end function 

function insertPersonalOS()

	query = "DELETE FROM TURNOS_REALIZADOS WHERE ORDEN_SERVICIO = " & strNvl(CODIGO_OS) 
	query = query & " AND USUARIO=" & strNvl(CODIGO)
	query = query & " AND ANHO=" & strNvl(ANHO)
	
	Set ORs =oDB.EjecutaSql(query)
	

	query = "INSERT INTO TURNOS_REALIZADOS (ORDEN_SERVICIO, USUARIO,"
	query = query & "BASED, BASED_T,"
	query = query & " FDH, FDH_T, FNH, FNH_T, FDF, FDF_T, FNF, FNF_T, ANHO,"
	query = query & " USERNAME, USERDATE) VALUES ("
	query = query & strNvl(CODIGO_OS) & ","
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(BASED) & ","
	query = query & strNvl(BASED_T) & ","
	query = query & strNvl(replace(FDH,",",".")) & ","
	query = query & strNvl(replace(FDH_T,",",".")) & ","
	query = query & strNvl(replace(FNH,",",".")) & ","
	query = query & strNvl(replace(FNH_T,",",".")) & ","
	
	query = query & strNvl(replace(FDF,",",".")) & ","
	query = query & strNvl(replace(FDF_T,",",".")) & ","
	query = query & strNvl(replace(FNF,",",".")) & ","
	query = query & strNvl(replace(FNF_T,",",".")) & ","
	query = query & strNvl(ANHO) & ","
	query = query & strNvl(USERNAME) & ",getdate())"
	'query = query & strNvl(TIPO) & ")"

	if (CODIGO="--") Then	
	Else
		Set ORs =oDB.EjecutaSql(query)
	End If
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & CODIGO  & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function delPersonalOS()

	query = "DELETE FROM TURNOS_REALIZADOS WHERE ORDEN_SERVICIO = " & strNvl(CODIGO_OS) 
	query = query & " AND USUARIO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & CODIGO  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	
end function

function delHora()

		query = "UPDATE HORAS_TRABAJADOR SET ESTADO='ELI' WHERE ID = " & strNvl(ID) 
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & ID & "</ID>"
	Response.Write "</REGISTROS>"
	
end function

function delBono()
	
	query = "DELETE BONOS  "
	query = query & " WHERE COD_TRAB = " & strNvl(COD_TRAB)
	query = query & " AND CODIGO=" & strNvl(CODIGO)
 	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & ID & "</ID>"
	Response.Write "</REGISTROS>"
	
end function


function delEvent()

	query = "DELETE FROM TURNOS_USUARIOS WHERE ID = " & strNvl(ID) 
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & ID & "</ID>"
	Response.Write "</REGISTROS>"
	
end function

function delUsrEvent()

	query = "DELETE FROM TURNOS_USUARIOS WHERE USUARIO = " & strNvl(ID) 
	query = query & " AND VALOR=" & strNvl(CUADRILLA)
	query = query & " AND FECHA between  " & strNvl(FECHA_INI) 
	query = query & " AND  " & strNvl(FECHA_FIN) 
	 
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & ID & "</ID>"
	Response.Write "</REGISTROS>"
	
end function


function delEventCua()

	query = " DELETE dbo.TURNOS_USUARIOS "
	query = query & " WHERE FECHA between  " & strNvl(FECHA_INI) 
	query = query & " AND  " & strNvl(FECHA_FIN) 
	query = query & " AND VALOR = " & strNvl(CUADRILLA)
			
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<ROW>" & query
	Response.Write "<ID>" & ID & "</ID>"
	Response.Write "</ROW>"

End Function

function delUsrC()

	query = "DELETE FROM USUARIOS_CUADRILLA WHERE CODIGO = " & strNvl(CUADRILLA) 
	query = query & " AND USUARIO=" & strNvl(CODIGO)
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & CODIGO & "</ID>"
	Response.Write "</REGISTROS>"
	
end function


function listHoras()

DIM MES1
DIM ANHO1

If MES=1 Then
	ANHO1 = ANHO - 1
	MES1 = 12
Else
	ANHO1 = ANHO
	MES1 =  MES - 1
End if

	query = "SELECT H.ID, H.FECHA, C.NOMBRE, H.ORDEN_SERVICIO, "
	query = query & " H.ETAPA, H.USUARIO + '-' + T.NOMBRE , H.IND_CON,"
    query = query & " H.IND_BASED,  H.IND_FEST, "
	query = query & " H.IND_PAGO, H.LUGAR, H.H_ENTRADA, H.H_SALIDA, OS.OBSERVACION, "
	query = query & " H.IND_NOCHE, T.SINDICATO, H.USUARIO "
	query = query & " FROM  dbo.HORAS_TRABAJADOR AS H"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO=H.USUARIO"
	query = query & " 	AND T.SUCURSAL= " & strNvl(UBICACION) 
	query = query & " INNER JOIN ORDEN_SERVICIO AS OS ON OS.CODIGO=H.ORDEN_SERVICIO "
	query = query & " LEFT OUTER JOIN CLIENTES AS C ON C.RUT_CLIENTE=OS.CLIENTE AND C.EMPRESA='SIMMA' "
	
	If len(FECHA)>0 THEN
		query = query & " WHERE CONVERT(DATETIME," & strNvl(FECHA) & " ,105) = H.FECHA " 
		query = query & " 	AND YEAR(OS.FECHA)= YEAR(H.FECHA)" 
		
	Else
		
		'query = query & "AND coalesce(MONTH(H.FECHA),'') "
		'query = query & "		   LIKE (CASE WHEN " & strNvl(MES) & "<>'0' "
		'query = query & " THEN convert(varchar(2),CONVERT(INT," & strNvl(MES) & ")) ELSE '%' END)"
		
		query = query & " WHERE  H.FECHA BETWEEN "
		query = query & " '16/' + CONVERT(varchar,  " & MES1 & ") + '/' + "
		query = query & "  convert(varchar," & ANHO1 & ")"
		query = query & "  AND  '15/' + CONVERT(varchar, " & MES & ") + '/' +convert(varchar," & ANHO & ")"
		query = query & " 	AND YEAR(OS.FECHA)= YEAR(H.FECHA)" 
	End If
	
	query = query & " AND H.ESTADO is null "
		
	IF OS<>"TOD" THEN
			query = query & " AND OS.CODIGO=" & strNvl(OS)
	END IF
	
	
   IF IND_BASED="true" THEN
  		 query = query & " AND H.IND_BASED=1"
   END IF
	
   If IND_CON="true" then
	 query = query & " AND H.IND_CON IN ('Cond','SI') "
   END IF
   
   If IND_PAGO="true" then
	 query = query & " AND H.IND_PAGO IN ('Si','SI') "
   END IF
   
   IF IND_NOCHE="true" THEN
  		 query = query & " AND H.IND_NOCHE='true'"
   END IF
   
	
	IF LEN(USUARIO)>0 THEN
			query = query & " AND H.USUARIO=" & strNvl(USUARIO)
	END IF
	
	query = query & " ORDER BY 2 "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"& query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	 		Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
	 		Response.Write "<CLIENTE>" & ORs.Fields.Item(2).Value & "</CLIENTE>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(3).Value & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(4).Value & "</ETAPA>"
	 		Response.Write "<USUARIO>" & ORs.Fields.Item(5).Value & "</USUARIO>"
	 		Response.Write "<IND_CON>" & ORs.Fields.Item(6).Value & "</IND_CON>"
	 		Response.Write "<IND_BASED>" & ORs.Fields.Item(7).Value & "</IND_BASED>"
	 		Response.Write "<IND_FEST>" & ORs.Fields.Item(8).Value & "</IND_FEST>"
	 		Response.Write "<IND_PAGO>" & ORs.Fields.Item(9).Value & "</IND_PAGO>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(10).Value & "</LUGAR>"
	 		Response.Write "<H_ENTRADA>" & ORs.Fields.Item(11).Value & "</H_ENTRADA>"
	 		Response.Write "<H_SALIDA>" & ORs.Fields.Item(12).Value & "</H_SALIDA>"
			Response.Write "<OBS>" & ORs.Fields.Item(13).Value & "</OBS>"
			Response.Write "<SIND>" & ORs.Fields.Item(15).Value & "</SIND>"
			Response.Write "<CODIGO>" & ORs.Fields.Item(16).Value & "</CODIGO>"
			
			If ORs.Fields.Item(14).Value="true" Then
				Response.Write "<IND_NOCHE>Noche</IND_NOCHE>"
			Else
				Response.Write "<IND_NOCHE>Dia</IND_NOCHE>"
	 		End If
			
			
			ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function


function listDesbloq()

	query = "SELECT  TOP 200 D.ID + ' ' + T.NOMBRE, D.FECHA, D.IND_DESBLQ, D.OS, D.USERNAME, D.USERDATE "
	query = query & " FROM    dbo.DESBLOQUEOS AS D"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO = D.ID  "
	query = query & " WHERE D.ID =" & strNvl(ID)
		
	query = query & " ORDER BY FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	 		Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
	 		Response.Write "<IND>" & ORs.Fields.Item(2).Value & "</IND>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(3).Value & "</ORDEN>"
			Response.Write "<USERNAME>" & ORs.Fields.Item(4).Value & "</USERNAME>"
			Response.Write "<USERDATE>" & ORs.Fields.Item(5).Value & "</USERDATE>"
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function

function listAprob()

	query = "SELECT  T.CODIGO , T.NOMBRE, T.COD_CARGO + ' ' + CA.DESCRIPCION, "
	query = query & " C.NOMBRE, PRE_GR, PRE_RRHH, APR_GR, APR_RRHH "
	query = query & " FROM TRABAJADORES AS T   "
	query = query & " LEFT OUTER JOIN CLIENTES AS C ON C.RUT_CLIENTE = T.CLIENTE AND C.EMPRESA='SIMMA' "
	query = query & " LEFT OUTER JOIN CARGOS AS CA ON CA.CODIGO = T.COD_CARGO   "
	query = query & " WHERE ESTADO<>'true' AND T.EMPRESA='SIMMA'"
	
	IF ESTADO="APR" THEN
		query = query & " AND (PRE_GR='TRUE' "
		query = query & "  AND PRE_RRHH='TRUE'"  
		query = query & "  AND APR_GR='TRUE'" 
		query = query & "  AND APR_RRHH='TRUE')"
		 
	ELSE
		query = query & " AND NOT (PRE_GR='TRUE' "
		query = query & "  AND PRE_RRHH='TRUE'"  
		query = query & "  AND APR_GR='TRUE'" 
		query = query & "  AND APR_RRHH='TRUE')"
		query = query & "  OR PRE_GR IS NULL"
		query = query & "  OR PRE_RRHH IS NULL"
		query = query & "  OR APR_GR IS NULL"
		query = query & "  OR APR_RRHH IS NULL" 
	END IF
	
	query = query & " ORDER BY T.NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<COD>" & ORs.Fields.Item(0).Value & "</COD>"
			Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	 		Response.Write "<CARGO>" & ORs.Fields.Item(2).Value & "</CARGO>"
	 		Response.Write "<CLIENTE>" & ORs.Fields.Item(3).Value & "</CLIENTE>"
	 		Response.Write "<PRE_GR>" & ORs.Fields.Item(4).Value & "</PRE_GR>"
			Response.Write "<PRE_RRHH>" & ORs.Fields.Item(5).Value & "</PRE_RRHH>"
			Response.Write "<APR_GR>" & ORs.Fields.Item(6).Value & "</APR_GR>"
			Response.Write "<APR_RRHH>" & ORs.Fields.Item(7).Value & "</APR_RRHH>"
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function

function infHorasOS()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	
   IF CLIENTE="NULL" THEN
   CLIENTE=""
   END IF
   
   IF OS="TOD" THEN
   		
		STR =	"SP_SG_INF_HORAS @CLIENTE=" & strNvl(CLIENTE)
		STR = STR & ", @mes=" & strNvl(MES)
		STR = STR & ",@anho=" & ANHO
		
	ELSE
		STR =	"SP_SG_INF_HORAS_OS @os=" & strNvl(OS)
	
		
	END IF
 
 	Set ORs = Cn.Execute (STR)
   
	 
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	
	
	'Set ORs =oDB.EjecutaSql(query)
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=informeOS.xls"
		
		Response.Write "<TABLE BORDER=1>"
		Response.Write "<TR>"

	 		Response.Write "<TD>MES</TD>"
	 		Response.Write "<TD>O.S.</TD>"
			Response.Write "<TD>CLIENTE</TD>"
			Response.Write "<TD>BASE DIA</TD>"
			Response.Write "<TD>HH F.DIA HABIL</TD>"
			Response.Write "<TD>HH F.NOCHE HABIL</TD>"
			Response.Write "<TD>HH F.DIA FESTIVO</TD>"
			Response.Write "<TD>HH F.NOCHE FESTIVO</TD>"
			Response.Write "<TD>TOTAL</TD>"
		Response.Write "</TR>"
		
			While Not ORs.EOF 
			Response.Write "<TR>"
	 		Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
			
			FDH = CDBL( ORs.Fields.Item(4).Value) 
			Response.Write "<TD>" & FDH & "</TD>"
			
			FNH = CDBL( ORs.Fields.Item(5).Value) + CDBL(ORs.Fields.Item(6).Value)
			
			Response.Write "<TD>" & FNH & "</TD>"
			
			FDF = CDBL( ORs.Fields.Item(7).Value) 
			Response.Write "<TD>" & FDF & "</TD>"
			
			FNF = CDBL( ORs.Fields.Item(8).Value) + CDBL(ORs.Fields.Item(9).Value)
			Response.Write "<TD>" & FNF & "</TD>"
			
			Response.Write "<TD>" & (FDH + FNH + FDF + FNF)* CDBL(ORs.Fields.Item(10).Value) & "</TD>"
			
	 		ORs.MoveNext
  		Response.Write "</TR>"
	Wend
		
		Response.Write "</TABLE>"
		
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>" & STR
		While Not ORs.EOF 
		Response.Write "<ROW>"

	 		Response.Write "<CLIENTE>" & ORs.Fields.Item(0).Value  & "</CLIENTE>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value & "</ORDEN>"
	 		Response.Write "<USUARIO>" & ORs.Fields.Item(2).Value & "</USUARIO>"
	 		Response.Write "<BASED>" & ORs.Fields.Item(3).Value & "</BASED>"
			
			FDH = CDBL( ORs.Fields.Item(4).Value) 
			Response.Write "<FDH>" & FDH & "</FDH>"
			
			FNH = CDBL( ORs.Fields.Item(5).Value)
			
			Response.Write "<FNH>" & FNH & "</FNH>"
			
			FDF = CDBL( ORs.Fields.Item(6).Value) 
			Response.Write "<FDF>" & FDF & "</FDF>"
			
			FNF = CDBL(ORs.Fields.Item(7).Value)
			Response.Write "<FNF>" & FNF & "</FNF>"
			
			Response.Write "<TOTAL>" & FDH + FNH + FDF + FNF & "</TOTAL>"
			
	 		ORs.MoveNext
  		Response.Write "</ROW>"
		Wend
	
		Response.Write "</REGISTROS>"
	END IF
	
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function

function infHorasTr()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	Dim BASEDIA
	
   	BASEDIA=""
	
   IF IND_BASED="Si" THEN
   	BASEDIA="1"
   END IF
 
   IF IND_BASED="No" THEN
   	BASEDIA="0"
   END IF
     
	 IF IND_NOCHE = "false" Then
		IND_NOCHE =""
	END IF
	
	IF IND_CON = "false" Then
		IND_CON =""
	END IF
	
   IF LEN(USUARIO)>0 THEN
   
   	STR =	"SP_SG_INF_HORAS_TR @USUARIO=" & strNvl(USUARIO)
	STR = STR & ",@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	STR = STR & ",@cond='" & IND_CON & "'"
	STR = STR & ",@noche='" & IND_NOCHE & "'"
	STR = STR & ",@sucursal='" & UBICACION & "'"
	STR = STR & ",@fecha_fin='" & FECHA_FIN & "'"
	STR = STR & ",@esp='" & IND_ESP & "'"
	
   ELSE
   
   	STR =	"SP_SG_INF_HORAS_TRA "
	STR = STR & " @mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	STR = STR & ",@cond='" & IND_CON & "'"
	STR = STR & ",@noche='" & IND_NOCHE & "'"
	STR = STR & ",@sucursal='" & UBICACION & "'"
	STR = STR & ",@fecha_fin='" & FECHA_FIN & "'"
	STR = STR & ",@esp='" & IND_ESP & "'"
	
   END IF
   
    IF LEN(CLIENTE)>0 THEN
   
   	STR =	"SP_SG_INF_HORAS_CLI @CLIENTE=" & strNvl(CLIENTE)
	STR = STR & ",@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
 end if
   

 	Set ORs = Cn.Execute (STR)
    DIM BASED
	DIM TOTAL
	DIM TH
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	DIM ESP
	DIM HESP
	ESP=0
	HESP=0
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	TH=0
	TOTAL=0
	THN=0
	COND=0
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=informeVal.xls"
		
		Response.Write "<TABLE BORDER=1>"
		Response.Write "<TR>"
	 		Response.Write "<TD>FECHA</TD>"
	 		Response.Write "<TD>TRABAJADOR</TD>"
			response.Write "<TD>SERVICIO</TD>"
			response.Write "<TD>CLIENTE</TD>"
			response.Write "<TD>LUGAR</TD>"
			Response.Write "<TD>INDICADOR PAGO</TD>"
			Response.Write "<TD>BASE DIA</TD>"
			Response.Write "<TD>ENTRADA</TD>"
			Response.Write "<TD>SALIDA</TD>"
			Response.Write "<TD>NOCH/DIA</TD>"
			Response.Write "<TD>HORAS</TD>"
			Response.Write "<TD>TOTAL</TD>"
		Response.Write "</TR>"
			
	While Not ORs.EOF 
	
		If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
			Response.Write "<TR>"
			Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"
			
			IF LEN(USUARIO)=0 THEN
				Response.Write "<TD>" & ORs.Fields.Item(17).Value  & "</TD>"
			END IF
			
	 		Response.Write "<TD>" & ORs.Fields.Item(2).Value & "/" &  ORs.Fields.Item(10).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
			
	 		Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<TD>" & BASED & "</TD>"
			
			Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
			'Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
		'	Response.Write "<TD>" & ORs.Fields.Item(16).Value & "</TD>"
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<TD>Noche</TD>"
			 Else
					Response.Write "<TD>Dia</TD>"
			End If
			
			If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
							Response.Write "<TD>0</TD>"									
							Response.Write "<TD>" & ROUND(ORs.Fields.Item(8).Value,1) & "</TD>"
						'	THN = THN +ROUND(ORs.Fields.Item(8).Value,1)			
			Else
			
			
				Response.Write "<TD>" & ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value) & "</TD>"
				TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
					
				Response.Write "<TD>" & ROUND(ORs.Fields.Item(8).Value,1) & "</TD>"
				TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
						
			End If
			
				If ORs.Fields.Item(13).Value ="Cond" Then
					COND= COND + 1
				End If	
					
			Response.Write "</TR>"
			
		Else
		
			If IND_PAGO<>"true" then
			
			Response.Write "<TR>"
			Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"
			IF LEN(USUARIO)=0 THEN
				Response.Write "<TD>" & ORs.Fields.Item(17).Value  & "</TD>"
			END IF
	 		Response.Write "<TD>" & ORs.Fields.Item(2).Value & "/" &  ORs.Fields.Item(10).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<TD>" & BASED & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
		'	Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
		'	Response.Write "<TD>" & ORs.Fields.Item(16).Value & "</TD>"
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<TD>Noche</TD>"
			 Else
					Response.Write "<TD>Dia</TD>"
			End If
						
			If ORs.Fields.Item(13).Value ="Cond"  Then
					COND= COND + 1
			End If	
			
			If ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI" Then 'Ind Pago
		
		
						
				If ORs.Fields.Item(11).Value ="true" Then ' NOCHERA
						Response.Write "<TD>0</TD>"
						Response.Write "<TD>0</TD>"
						THN = THN +ROUND(ORs.Fields.Item(8).Value,1)
				Else
					Response.Write "<TD>" & ROUND(ORs.Fields.Item(8).Value,1) & "</TD>"
						TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
					Response.Write "<TD>" & ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value) & "</TD>"
					TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
					
				End If
				
			
			
			Else
			
				Response.Write "<TD>" & ROUND(ORs.Fields.Item(8).Value,1) & "</TD>"
						TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
				Response.Write "<TD>0</TD>"
				
				If ORs.Fields.Item(11).Value ="true" Then ' NOCHERA
						
						'THN = THN +ROUND(ORs.Fields.Item(8).Value,1)
				End If
				
			End IF
			
			Response.Write "</TR>"
			
			End If
			
		End If
		
		ORs.MoveNext
			
	Wend
		
		Response.Write "<TR>"
		Response.Write "<TD>NOCHERAS</TD>"
		Response.Write "<TD> " & formatNumber(THN) & " Hrs.</TD>"
		Response.Write "</TR>"
		
		Response.Write "<TR>"
		Response.Write "<TD>CONDUCCION  </TD>"
		Response.Write "<TD> " & ROUND(formatNumber(COND),0) & "</TD>"
		Response.Write "<TD> $ " & formatNumber(COND)*5000 & "</TD>"

		Response.Write "</TR>"
		
		
		Response.Write "<TR>"
		Response.Write "<TD>TOTAL*******</TD>"
		Response.Write "<TD>" & formatNumber(TH) & " Hrs.</TD>"
		Response.Write "<TD>$ " & formatNumber(TOTAL,2) & "</TD>"
		Response.Write "</TR>"
'	Response.Write "<tr><td>" & STR & "</td></tr>"
		Response.Write "</TABLE>"
		
	ELSE 'EXCEL
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & STR
	
	While Not ORs.EOF 
	
		If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
		
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			
			If ORs.Fields.Item(19).Value="true" then
				Response.Write "<ESP>Especial</ESP>"
				ESPH = ESPH +ROUND(ORs.Fields.Item(8).Value,1)
				ESP = ESP  + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
			End If
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<NOC>Noche</NOC>"
			 Else
					Response.Write "<NOC>Dia</NOC>"
			End If
			
			If ORs.Fields.Item(11).Value ="true" OR ORs.Fields.Item(19).Value="true" Then ' NOCHERA O ESPECIAL
						'	Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
						'									cdbl(ORs.Fields.Item(12).Value),2) & "</TOTAL>"
							Response.Write "<TOTAL>0</TOTAL>"								
						
							'Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
							Response.Write "<HRS>0</HRS>"
							'THN = THN +ROUND(ORs.Fields.Item(8).Value,1)			
			Else
			
			
				Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value),2) & "</TOTAL>"
				TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
					
				Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
				TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
						
			End If
			
				If ORs.Fields.Item(13).Value ="Cond" Then
					COND= COND + 1
				End If	
					
			Response.Write "</ROW>"
			
		Else
		
		If IND_PAGO<>"true" then
			
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			Response.Write "<SIND>" & ORs.Fields.Item(16).Value & "</SIND>"
			
			If ORs.Fields.Item(19).Value="true" then
				Response.Write "<ESP>Especial</ESP>"
				ESPH = ESPH +ROUND(ORs.Fields.Item(8).Value,1)
				if ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") then
						ESP = ESP  + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				end if
				
			End If
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<NOC>Noche</NOC>"
			 Else
					Response.Write "<NOC>Dia</NOC>"
			End If
						
			If ORs.Fields.Item(13).Value ="Cond"  Then
					COND= COND + 1
				End If	
			
			If ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI" Then 'Ind Pago
		
		 
						
				If ORs.Fields.Item(11).Value ="true" OR ORs.Fields.Item(19).Value="true" Then ' NOCHERA
						Response.Write "<HRS>0</HRS>"
						 
						Response.Write "<TOTAL>0</TOTAL>"
						'THN = THN +ROUND(ORs.Fields.Item(8).Value,1)
				Else
						Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
						TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
					Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value),2) & "</TOTAL>"
					TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
					
				End If
				
			
			
			Else
			
				Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
						TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
				Response.Write "<TOTAL>0</TOTAL>"
				If ORs.Fields.Item(11).Value ="true" Then ' NOCHERA
						
					'	THN = THN +ROUND(ORs.Fields.Item(8).Value,1)
				End If
				
			End IF
			
			Response.Write "</ROW>"
			End If
			
		End If
		
		ORs.MoveNext
			
	Wend
		
	'	Response.Write "<ROW>"
	'	Response.Write "<ENT>NOCHERAS</ENT>"
	'	Response.Write "<SAL> </SAL>"
	'	Response.Write "<HRS> " & formatNumber(THN) & " Hrs.</HRS>"
	'	Response.Write "</ROW>"
		
		Response.Write "<ROW>"
		Response.Write "<ENT>CONDUCCION  </ENT>"
		Response.Write "<SAL></SAL>"
		Response.Write "<SAL> " & ROUND(formatNumber(COND),0) & "</SAL>"
		Response.Write "<TOTAL> $ " & formatNumber(COND)*5000 & "</TOTAL>"

		Response.Write "</ROW>"
		
		Response.Write "<ROW>"
		Response.Write "<ENT>ESPECIALES </ENT>"
		Response.Write "<SAL></SAL>"
		Response.Write "<SAL> " & ROUND(formatNumber(ESPH),1) & "</SAL>"
		Response.Write "<TOTAL> $ " & formatNumber(ESP,2) & "</TOTAL>"

		Response.Write "</ROW>"
		
		
		Response.Write "<ROW>"
		Response.Write "<ENT>TOTAL*******</ENT>"
		Response.Write "<HRS>" & formatNumber(TH) & " Hrs.</HRS>"
		Response.Write "<TOTAL>$ " & formatNumber(TOTAL,2)& "</TOTAL>"
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	END IF 'ENDIF EXCEL
	
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function


function infHorasTr2()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	Dim BASEDIA
	
   	BASEDIA=""
	
   IF IND_BASED="Si" THEN
   	BASEDIA="1"
   END IF
 
   IF IND_BASED="No" THEN
   	BASEDIA="0"
   END IF
   
   IF LEN(USUARIO)>0 THEN
   	STR =	"SP_SG_INF_HORAS_TR @USUARIO=" & strNvl(USUARIO)
	STR = STR & ",@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	
   ELSE
   
   	STR =	"SP_SG_INF_HORAS_TR2 @USUARIO=" & strNvl(USUARIO)
	STR = STR & ",@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	
   END IF
   

	'STR = STR & ",@indPago=" & IND_PAGO
	'	Response.Write  STR
 
 	Set ORs = Cn.Execute (STR)
    DIM BASED
	DIM TOTAL
	DIM TH
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	TH=0
	TOTAL=0
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & STR
	While Not ORs.EOF 
	
		If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
			TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
			
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			
			Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value),2) & "</TOTAL>"
			TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
			
			Response.Write "</ROW>"
			
		Else
		
			If IND_PAGO<>"true" then
			
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			
			Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
			TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
			
			If ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI" Then
				Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * cdbl(ORs.Fields.Item(9).Value),2) & "</TOTAL>"
				TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
			Else
				Response.Write "<TOTAL>" & 0 & "</TOTAL>"
			End IF
			Response.Write "</ROW>"
			End If
		End If
		
  		
		
		ORs.MoveNext
			
	Wend
		Response.Write "<ROW>"
		Response.Write "<HRS>" & formatNumber(TH) & " Hrs.</HRS>"
		Response.Write "<TOTAL>$ " & formatNumber(TOTAL,2) & "</TOTAL>"
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function


function infNochera()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	Dim BASEDIA
	
   	BASEDIA=""
	
   IF IND_BASED="Si" THEN
   	BASEDIA="1"
   END IF
 
   IF IND_BASED="No" THEN
   	BASEDIA="0"
   END IF
     
	 IF IND_NOCHE = "false" Then
		IND_NOCHE =""
	END IF
	
	IF IND_CON = "false" Then
		IND_CON =""
	END IF
	
   IF LEN(USUARIO)>0 THEN
   	STR =	"SP_SG_INF_HORAS_TR @USUARIO=" & strNvl(USUARIO)
	STR = STR & ",@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	STR = STR & ",@cond='" & IND_CON & "'"
	STR = STR & ",@noche='" & IND_NOCHE & "'"
	STR = STR & ",@sucursal='" & UBICACION & "'"
	STR = STR & ",@fecha_fin='" & FECHA_FIN & "'"
	STR = STR & ",@esp='" & IND_ESP & "'"
   ELSE
   
   	STR =	"SP_SG_INF_HORAS_TRA "
	STR = STR & " @mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	STR = STR & ",@cond='" & IND_CON & "'"
	STR = STR & ",@noche='" & IND_NOCHE & "'"
	STR = STR & ",@sucursal='" & UBICACION & "'"
	STR = STR & ",@fecha_fin='" & FECHA_FIN & "'"
	STR = STR & ",@esp='" & IND_ESP & "'"
   END IF
   

	'STR = STR & ",@indPago=" & IND_PAGO
		
 
 	Set ORs = Cn.Execute (STR)
    DIM BASED
	DIM TOTAL
	DIM TH
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	TH=0
	TOTAL=0
	THN=0
	COND=0
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=informeNoch.xls"
		
		Response.Write "<TABLE BORDER=1>"
		Response.Write "<TR>"
	 		Response.Write "<TD>FECHA</TD>"
	 		Response.Write "<TD>TRABAJADOR </TD>"
			Response.Write "<TD>OS </TD>"
			Response.Write "<TD>ETAPA</TD>"
			Response.Write "<TD>LUGAR</TD>"
			Response.Write "<TD>INDICADOR PAGO</TD>"
			Response.Write "<TD>BASE DIA</TD>"
			Response.Write "<TD>ENTRADA</TD>"
			Response.Write "<TD>SALIDA</TD>"
			Response.Write "<TD>NOCHE</TD>"
			Response.Write "<TD>HORAS</TD>"
			Response.Write "<TD>TOTAL</TD>"
		Response.Write "</TR>"
	
	While Not ORs.EOF 
	
		If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
			Response.Write "<TR>"
			Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"
				
				Response.Write "<TD>" & ORs.Fields.Item(17).Value  & "</TD>"
			
	 		Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<TD>" & BASED & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
			'Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
		'	Response.Write "<TD>" & ORs.Fields.Item(16).Value & "</TD>"
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<TD>Noche</TD>"
			 Else
					Response.Write "<TD>Dia</TD>"
			End If
			
						
			If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
							Response.Write "<TD>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(12).Value),2) & "</TD>"								
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
							THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
				Else
					Response.Write "<TD>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value),2) & "</TD>"
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
				End If
			
			
				If ORs.Fields.Item(13).Value ="Cond" Then
					COND= COND + 1
				End If	
					
			Response.Write "</TR>"
			
		Else
		
			If IND_PAGO<>"true" then
			
			Response.Write "<TR>"
			Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(17).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<TD>" & BASED & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
		'	Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
		'	Response.Write "<TD>" & ORs.Fields.Item(16).Value & "</TD>"
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<TD>Noche</TD>"
			 Else
					Response.Write "<TD>Dia</TD>"
			End If
						
			If ORs.Fields.Item(13).Value ="Cond"  Then
					COND= COND + 1
				End If	
			
			If ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI" Then 'Ind Pago
		
				Response.Write "<TD>" & ROUND(ORs.Fields.Item(8).Value,1) & "</TD>"
						TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
						
				If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
							Response.Write "<TD>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(12).Value),2) & "</TD>"								
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
							THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
				Else
					Response.Write "<TD>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value),2) & "</TD>"
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
				End If
			
			
			
			Else
			
				Response.Write "<TD>" & ROUND(ORs.Fields.Item(8).Value,1) & "</TD>"
						TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
				Response.Write "<TD>0</TD>"
				
				If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
						'	Response.Write "<TD>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
						'									cdbl(ORs.Fields.Item(12).Value),2) & "</TD>"								
						'	TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
							THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
				Else
				'	Response.Write "<TD>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
												'			cdbl(ORs.Fields.Item(9).Value),2) & "</TD>"
						'	TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
				End If
			
				
			End IF
			
			Response.Write "</TR>"
			End If
			
		End If
		
		ORs.MoveNext
			
	Wend
		
		Response.Write "<TR>"
		Response.Write "<TD>NOCHERAS</TD>"
		Response.Write "<TD> " & formatNumber(THN) & " Hrs.</TD>"
		Response.Write "</TR>"
		
		Response.Write "<TR>"
		Response.Write "<TD>TOTAL*******</TD>"
		Response.Write "<TD>" & formatNumber(TH) & " Hrs.</TD>"
		Response.Write "<TD>$ " & formatNumber(TOTAL,2)& "</TD>"
		Response.Write "</TR>"
	
		Response.Write "</TABLE>"
		
	ELSE 'EXCEL
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& STR
	While Not ORs.EOF 
	
		If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
		
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
			TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
			
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			Response.Write "<SIND>" & ORs.Fields.Item(16).Value & "</SIND>"
			
			If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
							Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(12).Value),2) & "</TOTAL>"								
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
							THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
				Else
					Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value),2) & "</TOTAL>"
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
			End If
			
				If ORs.Fields.Item(13).Value ="Cond" Then
					COND= COND + 1
					Response.Write "<COND>Conducción</COND>"
		
				End If	
					
			Response.Write "</ROW>"
			
		Else
		
			If IND_PAGO<>"true" then
			
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			Response.Write "<SIND>" & ORs.Fields.Item(16).Value & "</SIND>"
			
			If ORs.Fields.Item(11).Value="true" Then
					Response.Write "<NOC>Noche</NOC>"
			 Else
					Response.Write "<NOC>Dia</NOC>"
			End If
						
			Response.Write "<HRS>" & ROUND(ORs.Fields.Item(8).Value,1) & "</HRS>"
			TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
			
			If ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI" Then
	
				If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
							Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(12).Value),2) & "</TOTAL>"
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
							THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
				Else
					Response.Write "<TOTAL>" & formatNumber(ROUND(cdbl(ORs.Fields.Item(8).Value),1) * _
															cdbl(ORs.Fields.Item(9).Value),2) & "</TOTAL>"
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
				End If
				
				If ORs.Fields.Item(13).Value ="Cond" Then
					COND= COND + 1
					Response.Write "<COND>Conducción</COND>"
					
				End If	
			
			Else
				THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
				Response.Write "<TOTAL>" & 0 & "</TOTAL>"
			End IF
			Response.Write "</ROW>"
			End If
			
		End If
		
  		
		
		ORs.MoveNext
			
	Wend
		
		Response.Write "<ROW>"
		Response.Write "<ENT>NOCHERAS</ENT>"
		Response.Write "<SAL> </SAL>"
		Response.Write "<HRS> " & formatNumber(THN) & " Hrs.</HRS>"
		Response.Write "</ROW>"
		
		Response.Write "<ROW>"
		Response.Write "<ENT>TOTAL*******</ENT>"
		Response.Write "<HRS>" & formatNumber(TH) & " Hrs.</HRS>"
		Response.Write "<TOTAL>$ " & formatNumber(TOTAL,2)& "</TOTAL>"
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	END IF 'EXCEL
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function


function infCond()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	Dim BASEDIA
	
   	BASEDIA=""
	
   IF IND_BASED="Si" THEN
   	BASEDIA="1"
   END IF
 
   IF IND_BASED="No" THEN
   	BASEDIA="0"
   END IF
     
	 IF IND_NOCHE = "false" Then
		IND_NOCHE =""
	END IF
	
	IF IND_CON = "false" Then
		IND_CON =""
	END IF
	
   IF LEN(USUARIO)>0 THEN
   	STR =	"SP_SG_INF_HORAS_TR @USUARIO=" & strNvl(USUARIO)
	STR = STR & ",@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	STR = STR & ",@cond='" & IND_CON & "'"
	STR = STR & ",@noche='" & IND_NOCHE & "'"
	STR = STR & ",@sucursal='" & UBICACION & "'"
	STR = STR & ",@fecha_fin='" & FECHA_FIN & "'"
	STR = STR & ",@esp='" & IND_ESP & "'"
   ELSE
   
   	STR =	"SP_SG_INF_HORAS_TRA "
	STR = STR & " @mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@fecha='" & FECHA & "'"
	STR = STR & ",@based='" & BASEDIA & "'"
	STR = STR & ",@cond='" & IND_CON & "'"
	STR = STR & ",@noche='" & IND_NOCHE & "'"
	STR = STR & ",@sucursal='" & UBICACION & "'"
	STR = STR & ",@fecha_fin='" & FECHA_FIN & "'"
	STR = STR & ",@esp='" & IND_ESP & "'"
   END IF
   

	'STR = STR & ",@indPago=" & IND_PAGO
		
 
 	Set ORs = Cn.Execute (STR)
    DIM BASED
	DIM TOTAL
	DIM TH
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	TH=0
	TOTAL=0
	THN=0
	COND=0
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=infConduccion.xls"
		
		Response.Write "<TABLE BORDER=1>"
		Response.Write "<TR>"
	 		Response.Write "<TD>FECHA</TD>"
	 		Response.Write "<TD>TRABAJADOR / O.S.</TD>"
			Response.Write "<TD>ETAPA</TD>"
			Response.Write "<TD>LUGAR</TD>"
			Response.Write "<TD>INDICADOR PAGO</TD>"
			Response.Write "<TD>BASE DIA</TD>"
			Response.Write "<TD>ENTRADA</TD>"
			Response.Write "<TD>SALIDA</TD>"
			Response.Write "<TD>NOCHE</TD>"
			Response.Write "<TD>HORAS</TD>"
			Response.Write "<TD>TOTAL</TD>"
		Response.Write "</TR>"
	
	While Not ORs.EOF 
	
	If  ORs.Fields.Item(14).Value<>"CHOFER" Then
		'If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
		
			Response.Write "<TR>"
			Response.Write "<TD>" & ORs.Fields.Item(0).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(1).Value  & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
	 		Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<TD>" & BASED & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
			Response.Write "<TD> </TD>"
			TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
			
			Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
			Response.Write "<TD>" & ORs.Fields.Item(16).Value & "</TD>"
			
			If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
																								
				TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
				
				THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
			Else
				
					TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
			End If
			
			If ORs.Fields.Item(13).Value ="Cond" Then
				COND= COND + 1
					Response.Write "<TD>Conducción</TD>"
	
			End If	
							
			Response.Write "</TR>"
	End If		
		
		ORs.MoveNext
			
	Wend
		
			Response.Write "<TR>"
			Response.Write "<TD>TOTAL CONDUCCIÓN.</TD>"
		
			Response.Write "<TD>" & formatNumber(COND) & "</TD>"
			Response.Write "<TD>$ " & formatNumber(COND*5000,2)& "</TD>"
			Response.Write "</TR>"	
			

	
		Response.Write "</TABLE>"
		
	ELSE 'EXCEL
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & STR
	While Not ORs.EOF 
	
	If  ORs.Fields.Item(14).Value<>"CHOFER" Then
		'If IND_PAGO="true" And ( ORs.Fields.Item(4).Value = "Si" or  ORs.Fields.Item(4).Value="SI") Then
		
			Response.Write "<ROW>"
			Response.Write "<FECHA>" & ORs.Fields.Item(0).Value  & "</FECHA>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(1).Value  & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(2).Value & "</ETAPA>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(3).Value & "</LUGAR>"
	 		Response.Write "<PAGO>" & ORs.Fields.Item(4).Value & "</PAGO>"
			If ORs.Fields.Item(5).Value="1" Then BASED="Si" Else BASED="No" End If
			Response.Write "<BASED>" & BASED & "</BASED>"
			Response.Write "<ENT>" & ORs.Fields.Item(6).Value & "</ENT>"
			Response.Write "<SAL>" & ORs.Fields.Item(7).Value & "</SAL>"
			Response.Write "<HRS> </HRS>"
			TH = TH + ROUND(ORs.Fields.Item(8).Value,1)
			
			Response.Write "<FES>" & ORs.Fields.Item(10).Value & "</FES>"
			Response.Write "<SIND>" & ORs.Fields.Item(16).Value & "</SIND>"
			
			If ORs.Fields.Item(11).Value ="true" Then' NOCHERA
					Response.Write "<TOTAL> </TOTAL>"
																			
				TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(12).Value)
				
				THN = THN + ROUND(ORs.Fields.Item(8).Value,1)
			Else
					Response.Write "<TOTAL> </TOTAL>"
							TOTAL = TOTAL + ROUND(cdbl(ORs.Fields.Item(8).Value),1)	* cdbl(ORs.Fields.Item(9).Value)
				
			End If
			
			If ORs.Fields.Item(13).Value ="Cond" Then
				COND= COND + 1
					Response.Write "<COND>Conducción</COND>"
	
			End If	
							
			Response.Write "</ROW>"
	End If		
		
		ORs.MoveNext
			
	Wend
		
			Response.Write "<ROW>"
			Response.Write "<ENT>TOTAL CONDUCCIÓN.</ENT>"
			Response.Write "<SAL> </SAL>"
			Response.Write "<HRS>" & formatNumber(COND) & "</HRS>"
			Response.Write "<TOTAL>$ " & formatNumber(COND*5000,2)& "</TOTAL>"
			Response.Write "</ROW>"	
			
		
		Response.Write "<ROW>"
		Response.Write "<ENT> </ENT>"
	'	Response.Write "<HRS>" & formatNumber(TH) & " Hrs.</HRS>"
	
		Response.Write "</ROW>"
	Response.Write "</REGISTROS>"

  END IF 'EXCEL
  
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function

function infHorasSeg()

	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
   
   
	STR =	"SP_SG_INF_HORAS_SEG "
	STR = STR & "@mes=" & strNvl(MES)
	STR = STR & ",@anho=" & ANHO
		
 
 	Set ORs = Cn.Execute (STR)
   
	 
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	
	
	'Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
		Response.Write "<ROW>"

			Response.Write "<CLIENTE>" & ORs.Fields.Item(0).Value  & "</CLIENTE>"
	 		Response.Write "<TOTAL>" & ORs.Fields.Item(1).Value  & "</TOTAL>"
	 		Response.Write "<COD>" & ORs.Fields.Item(2).Value  & "</COD>"
			
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end Function

function getHora()

	query = "SELECT H.ID, H.FECHA, C.NOMBRE, H.ORDEN_SERVICIO, "
	query = query & " H.ETAPA, H.USUARIO ,  T.NOMBRE , H.IND_CON,"
    query = query & " H.IND_BASED,  H.IND_FEST, H.IND_PAGO, H.LUGAR, H.H_ENTRADA, H.H_SALIDA, H.IND_NOCHE, H.IND_ESP "
	query = query & " FROM  dbo.HORAS_TRABAJADOR AS H"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO=H.USUARIO"
	query = query & " LEFT OUTER JOIN ORDEN_SERVICIO AS OS ON OS.CODIGO=H.ORDEN_SERVICIO "
	query = query & " LEFT OUTER JOIN CLIENTES AS C ON C.RUT_CLIENTE=OS.CLIENTE "
	query = query & " WHERE H.ID=" & strNvl(ID)
	query = query & " ORDER BY 1 "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim iDesblq
	
	If Not ORs.EOF Then
		query = "SELECT D.IND_DESBLQ"
		query = query & " FROM  DESBLOQUEOS AS D"
		query = query & " WHERE D.ID =" & strNvl(ORs.Fields.Item(5).Value)
		query = query & " AND D.FECHA =" & strNvl(ORs.Fields.Item(1).Value)
		
		Set ORs1 =oDB.EjecutaSql(query)
		if Not ORs1.eof Then
			iDesblq = ORs1.Fields.Item(0).Value
		Else
			iDesblq = ""
		End If
	Else
		iDesblq = ""
	End If
	
		
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	 		Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
	 		Response.Write "<CLIENTE>" & ORs.Fields.Item(2).Value & "</CLIENTE>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(3).Value & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(4).Value & "</ETAPA>"
	 		Response.Write "<USUARIO>" & ORs.Fields.Item(5).Value & "</USUARIO>"
			Response.Write "<NOMBRE>" & ORs.Fields.Item(6).Value & "</NOMBRE>"
	 		Response.Write "<IND_CON>" & ORs.Fields.Item(7).Value & "</IND_CON>"
	 		Response.Write "<IND_BASED>" & ORs.Fields.Item(8).Value & "</IND_BASED>"
	 		Response.Write "<IND_FEST>" & ORs.Fields.Item(9).Value & "</IND_FEST>"
	 		Response.Write "<IND_PAGO>" & ORs.Fields.Item(10).Value & "</IND_PAGO>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(11).Value & "</LUGAR>"
	 		Response.Write "<H_ENTRADA>" & ORs.Fields.Item(12).Value & "</H_ENTRADA>"
	 		Response.Write "<H_SALIDA>" & ORs.Fields.Item(13).Value & "</H_SALIDA>"
			Response.Write "<IND_NOCHE>" & ORs.Fields.Item(14).Value & "</IND_NOCHE>"
			Response.Write "<IND_ESP>" & ORs.Fields.Item(15).Value & "</IND_ESP>"
			
			Response.Write "<IND>" & iDesblq & "</IND>"
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function


function validateHora()

	query = "SELECT H.ID, H.FECHA, H.CLIENTE, H.ORDEN_SERVICIO, "
	query = query & " H.ETAPA, H.USUARIO ,  T.NOMBRE , H.IND_CON,"
    query = query & " H.IND_BASED,  H.IND_FEST, H.IND_PAGO, H.LUGAR, H.H_ENTRADA, H.H_SALIDA, H.IND_NOCHE "
	query = query & " FROM  dbo.HORAS_TRABAJADOR AS H"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO=H.USUARIO"
	query = query & " WHERE H.FECHA=" & strNvl(FECHA_INI) & "  " 'AND H.ESTADO IS NULL
	query = query & "  AND H.USUARIO=" & strNvl(USUARIO) & " AND H.ID !=" & strNvl(ID)
	query = query & " 	AND (CONVERT(DATETIME,H.FECHA + " & strNvl(H_INI) & ")"
	query = query & "		BETWEEN DATEADD(mi, 0,CONVERT(DATETIME,H.FECHA + ' ' + H.H_ENTRADA)) "
	query = query & "				AND DATEADD(mi, -1,CONVERT(DATETIME,H.FECHA + + ' ' + H.H_SALIDA))"
	query = query & "		OR"
	query = query & "			CONVERT(DATETIME,H.FECHA +  " & strNvl(H_FIN) & ")"
	query = query & "		BETWEEN DATEADD(mi, 0,CONVERT(DATETIME,H.FECHA + ' ' + H.H_ENTRADA)) "
	query = query & "				AND DATEADD(mi, -1,CONVERT(DATETIME,H.FECHA + + ' ' + H.H_SALIDA)))"
	query = query & " ORDER BY 1 "
	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	 		Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
	 		Response.Write "<CLIENTE>" & ORs.Fields.Item(2).Value & "</CLIENTE>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(3).Value & "</ORDEN>"
	 		Response.Write "<ETAPA>" & ORs.Fields.Item(4).Value & "</ETAPA>"
	 		Response.Write "<USUARIO>" & ORs.Fields.Item(5).Value & "</USUARIO>"
			Response.Write "<NOMBRE>" & ORs.Fields.Item(6).Value & "</NOMBRE>"
	 		Response.Write "<IND_CON>" & ORs.Fields.Item(7).Value & "</IND_CON>"
	 		Response.Write "<IND_BASED>" & ORs.Fields.Item(8).Value & "</IND_BASED>"
	 		Response.Write "<IND_FEST>" & ORs.Fields.Item(9).Value & "</IND_FEST>"
	 		Response.Write "<IND_PAGO>" & ORs.Fields.Item(10).Value & "</IND_PAGO>"
	 		Response.Write "<LUGAR>" & ORs.Fields.Item(11).Value & "</LUGAR>"
	 		Response.Write "<H_ENTRADA>" & ORs.Fields.Item(12).Value & "</H_ENTRADA>"
	 		Response.Write "<H_SALIDA>" & ORs.Fields.Item(13).Value & "</H_SALIDA>"
		 
		 
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function



function getDesbloq()

	query = "SELECT D.ID , T.NOMBRE, D.FECHA, D.IND_DESBLQ, D.OS, D.USERNAME, D.USERDATE "
	query = query & " FROM  DESBLOQUEOS AS D"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO = D.ID  "
	query = query & " WHERE D.ID =" & strNvl(ID)
	query = query & " AND D.FECHA =" & strNvl(FECHA)
		
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
			Response.Write "<TR>" & ORs.Fields.Item(1).Value & "</TR>"
	 		Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
	 		Response.Write "<IND>" & ORs.Fields.Item(3).Value & "</IND>"
	 		Response.Write "<ORDEN>" & ORs.Fields.Item(4).Value & "</ORDEN>"
			Response.Write "<USERNAME>" & ORs.Fields.Item(5).Value & "</USERNAME>"
			Response.Write "<USERDATE>" & ORs.Fields.Item(6).Value & "</USERDATE>"
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function getEvent()

	query = "SELECT E.ID,  E.USUARIO, T.NOMBRE, E.FECHA, E.FECHA_FIN, E.VALOR, E.USERDATE, E.USERNAME "
	query = query & " FROM  dbo.TURNOS_USUARIOS AS E"
	query = query & " INNER JOIN TRABAJADORES AS T ON T.CODIGO = E.USUARIO "
	query = query & " WHERE E.ID=" & strNvl(ID)

	
	Set ORs =oDB.EjecutaSql(query)
	
		
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
			Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
			Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
	 		Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
			Response.Write "<FECHA_FIN>" & ORs.Fields.Item(4).Value & "</FECHA_FIN>"
	 		Response.Write "<VALOR>" & ORs.Fields.Item(5).Value & "</VALOR>"
	 		
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function getCuadrilla()

	query = "SELECT CODIGO, NOMBRE, COLOR, GRUPO , ESTADO"
	query = query & " FROM CUADRILLAS "
	query = query & " WHERE CODIGO =" & strNvl(CODIGO)
	'query = query & " 		AND D.FECHA =" & strNvl(FECHA)
		
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
			Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	 		Response.Write "<COLOR>" & ORs.Fields.Item(2).Value & "</COLOR>"
	 		Response.Write "<GRUPO>" & ORs.Fields.Item(3).Value & "</GRUPO>"
			Response.Write "<ESTADO>" & ORs.Fields.Item(4).Value & "</ESTADO>"
			'Response.Write "<USERDATE>" & ORs.Fields.Item(5).Value & "</USERDATE>"
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function getCorreos()

	query = "SELECT PRE_GR, PRE_RRHH, APR_GR, APR_RRHH "
	query = query & " FROM CORREOS"
	 		
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
			Response.Write "<PRE_GR>" & ORs.Fields.Item(0).Value & "</PRE_GR>"
			Response.Write "<PRE_RRHH>" & ORs.Fields.Item(1).Value & "</PRE_RRHH>"
	 		Response.Write "<APR_GR>" & ORs.Fields.Item(2).Value & "</APR_GR>"
	 		Response.Write "<APR_RRHH>" & ORs.Fields.Item(3).Value & "</APR_RRHH>"
			'Response.Write "<USERDATE>" & ORs.Fields.Item(5).Value & "</USERDATE>"
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function


function newPersonal()


	query = "INSERT INTO TRABAJADORES (CODIGO, NOMBRE,"
	query = query & "SUELDO_PRO, BASEDIA, HDN, HNN, HDF, HNF, CARGO, "
	query = query & "USERNAME, USERDATE, EMPRESA, SUCURSAL) VALUES ("
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(NOMBRE) & ","
	query = query & strNvl(SUELDO_PRO) & ","
	query = query & strNvl(BASEDIA) & ","
	query = query & strNvl(HDN) & ","
	query = query & strNvl(HNN) & ","
	query = query & strNvl(HDF) & ","
	query = query & strNvl(HNF) & ","
	query = query & strNvl(CARGO) & ","
	query = query & strNvl(USERNAME) & ",getdate(),'SIMMA','ADM-ANTF')"
	'query = query & strNvl(TIPO) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" 
	Response.Write "<CODIGO>" & CODIGO & "</CODIGO>"
	Response.Write "<NOMBRE>" & NOMBRE & "</NOMBRE>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function getPersonal()

	query = "SELECT CODIGO, T.NOMBRE, SUELDO_PRO, BASEDIA, HDN, HNN, HDF, HNF, COD_CARGO,  "
	query = query & " RUT, T.EMAIL, FONOS, SINDICATO, ART22, T.DIRECCION, ST, T.SUCURSAL, "
	query = query & " T.CLIENTE, C.NOMBRE, T.ESTADO, T.DV, T.PRE_GR, T.PRE_RRHH, T.APR_GR, T.APR_RRHH,  "
	query = query & " T.AFP, T.SSALUD, T.FECHA_CONTRATO, T.FECHA_ANEXO, T.FECHA_NAC, PLAZO, RECHAZADO, "
	query = query & " OBS_RECHAZ, NIVEL "
	query = query & " FROM  TRABAJADORES AS T"
	query = query & " LEFT OUTER JOIN  CLIENTES AS C ON C.RUT_CLIENTE = T.CLIENTE AND C.EMPRESA = 'SIMMA'"
	query = query & " WHERE CODIGO=" & strNvl(CODIGO)
	query = query & " ORDER BY T.NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
		Response.Write "<ROW>"
		
			Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	 		Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	 		Response.Write "<SUELDO_PRO>" & ORs.Fields.Item(2).Value & "</SUELDO_PRO>"
	 		Response.Write "<BASEDIA>" & ORs.Fields.Item(3).Value & "</BASEDIA>"
	 		Response.Write "<FDH>" & ORs.Fields.Item(4).Value & "</FDH>"
	 		Response.Write "<FNH>" & ORs.Fields.Item(5).Value & "</FNH>"
			Response.Write "<FDF>" & ORs.Fields.Item(6).Value & "</FDF>"
	 		Response.Write "<FNF>" & ORs.Fields.Item(7).Value & "</FNF>"
	 		Response.Write "<CARGO>" & ORs.Fields.Item(8).Value & "</CARGO>"
			Response.Write "<RUT>" & ORs.Fields.Item(9).Value & "</RUT>"
	 		Response.Write "<EMAIL>" & ORs.Fields.Item(10).Value & "</EMAIL>"
			Response.Write "<FONOS>" & ORs.Fields.Item(11).Value & "</FONOS>"
			Response.Write "<SIND>" & ORs.Fields.Item(12).Value & "</SIND>"
			Response.Write "<ART22>" & ORs.Fields.Item(13).Value & "</ART22>"
			Response.Write "<DIRECCION>" & ORs.Fields.Item(14).Value & "</DIRECCION>"
			Response.Write "<IND_ST>" & ORs.Fields.Item(15).Value & "</IND_ST>"
			Response.Write "<SUCURSAL>" & ORs.Fields.Item(16).Value & "</SUCURSAL>"
			Response.Write "<COD_CLIENTE>" & ORs.Fields.Item(17).Value & "</COD_CLIENTE>"
			Response.Write "<NOM_CLIENTE>" & ORs.Fields.Item(18).Value & "</NOM_CLIENTE>"
			Response.Write "<ESTADO>" & ORs.Fields.Item(19).Value & "</ESTADO>"
			Response.Write "<DV>" & ORs.Fields.Item(20).Value & "</DV>"
			Response.Write "<PRE_GR>" & ORs.Fields.Item(21).Value & "</PRE_GR>"
			Response.Write "<PRE_RRHH>" & ORs.Fields.Item(22).Value & "</PRE_RRHH>"
			Response.Write "<APR_GR>" & ORs.Fields.Item(23).Value & "</APR_GR>"
			Response.Write "<APR_RRHH>" & ORs.Fields.Item(24).Value & "</APR_RRHH>"
			Response.Write "<AFP>" & ORs.Fields.Item(25).Value & "</AFP>"
			Response.Write "<SSALUD>" & ORs.Fields.Item(26).Value & "</SSALUD>"
			Response.Write "<F_CONTRATO>" & ORs.Fields.Item(27).Value & "</F_CONTRATO>"
			Response.Write "<F_ANEXO>" & ORs.Fields.Item(28).Value & "</F_ANEXO>"
			Response.Write "<F_NAC>" & ORs.Fields.Item(29).Value & "</F_NAC>"
			Response.Write "<PLAZO>" & ORs.Fields.Item(30).Value & "</PLAZO>"
			Response.Write "<RECHAZADO>" & ORs.Fields.Item(31).Value & "</RECHAZADO>"
			Response.Write "<OBS_R>" & ORs.Fields.Item(32).Value & "</OBS_R>"
			Response.Write "<NIVEL>" & ORs.Fields.Item(33).Value & "</NIVEL>"
			
	 		ORs.MoveNext
  		Response.Write "</ROW>"
	Wend
	
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function setObs()

	query = "UPDATE TRABAJADORES SET OBS_RECHAZ = " & strNvl(OBS) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE CODIGO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" 
	Response.Write "<ID>" & CODIGO & "</ID>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function newHora()

	query = "INSERT INTO HORAS_TRABAJADOR (ORDEN_SERVICIO, FECHA,"
	query = query & "ETAPA, USUARIO, IND_FEST, IND_CON, IND_BASED, IND_PAGO, IND_NOCHE, IND_ESP, "
	query = query & "SUCURSAL, LUGAR, H_ENTRADA,"
	query = query & "H_SALIDA, USERNAME, USERDATE) VALUES ("
	query = query & strNvl(OS) & ","
	query = query & strNvl(FECHA_INI) & ","
	query = query & strNvl(ETAPA) & ","
	query = query & strNvl(USUARIO) & ","
	query = query & strNvl(IND_FEST) & ","
	query = query & strNvl(IND_CON) & ","
	query = query & strNvl(IND_BASED) & ","
	query = query & strNvl(IND_PAGO) & ","
	query = query & strNvl(IND_NOCHE) & ","
	query = query & strNvl(IND_ESP) & ","
	query = query & strNvl(UBICACION) & ","
	query = query & strNvl(LUGAR) & ","
	query = query & strNvl(H_INI) & ","
	query = query & strNvl(H_FIN) & ","
	query = query & strNvl(USERNAME) & ",getdate())"
	'query = query & strNvl(TIPO) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	query = " SELECT MAX(ID) FROM HORAS_TRABAJADOR "
	Set ORs1 =oDB.EjecutaSql(query)
	
		 Response.Write "{""j"":[{""__type"":""Cliente""," & _
							"""CompanyName"":""" & 1 & """," & _
							"""Address"":""" & 2 & """," & _
							"""Msg"":""" & "Hora Registrada." & _
					        """}]}"
	
	'Response.ContentType = "text/xml"
	'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	'Response.Write "<REGISTROS>"
	'Response.Write "<ROW>" & ORs.Fields.Item(0).Value & "</ROW>"
	'Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateHora()

	query = "UPDATE HORAS_TRABAJADOR SET FECHA = " & strNvl(FECHA_INI) & ","
	query = query & "ORDEN_SERVICIO=" & strNvl(OS) & ","
	query = query & "ETAPA=" & strNvl(ETAPA) & ","
	query = query & "IND_CON=" & strNvl(IND_CON) & ","
	query = query & "IND_BASED=" & strNvl(IND_BASED) & ","
	query = query & "IND_PAGO=" & strNvl(IND_PAGO) & ","
	query = query & "IND_FEST=" & strNvl(IND_FEST) & ","
	query = query & "LUGAR=" & strNvl(LUGAR) & ","
	query = query & "H_ENTRADA=" & strNvl(H_INI) & ","
	query = query & "H_SALIDA=" & strNvl(H_FIN) & ","
	query = query & "IND_NOCHE=" & strNvl(IND_NOCHE) & ","
	query = query & "IND_ESP=" & strNvl(IND_ESP) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE ID=" & ID 
	

	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & ID & "</ROW>"
	Response.Write "</REGISTROS>"
	
	' Response.Write "{""j"":[{""__type"":""Cliente""," & _
	'						"""CompanyName"":""" & 1 & """," & _
	'						"""Address"":""" & 2 & """," & _
	'						"""Tel"":""" & "Registro Actualizado." & _
	'				        """}]}"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function newHoraM()

	STR =	"SP_SG_saveHHM @user=" & strNvl(USERNAME)
	STR = STR & ",@os=" & strNvl(OS)
	STR = STR & ",@inicio=" & strNvl(FECHA_INI)
	STR = STR & ",@final=" & strNvl(FECHA_FIN)
	STR = STR & ",@h_ini=" & strNvl(H_INI) 
	STR = STR & ",@h_fin=" & strNvl(H_FIN) 
	STR = STR & ",@etapa=" & strNvl(ETAPA) 
	STR = STR & ",@ind_fest= " & strNvl(IND_FEST)
	STR = STR & ",@ind_con= " & strNvl(IND_CON)
	STR = STR & ",@based= " & strNvl(IND_BASED)
  	STR = STR & ",@ind_pago= " & strNvl(IND_PAGO)
  	STR = STR & ",@ind_noche= " & strNvl(IND_NOCHE)
	STR = STR & ",@lugar= " & strNvl(LUGAR)
	STR = STR & ",@sucursal= " & strNvl(UBICACION)
	STR = STR & ",@ind_esp= " & strNvl(IND_ESP)
  
	Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	'STR = STR & ",@indPago=" & IND_PAGO
	'	Response.Write  STR
 
 	Set ORs = Cn.Execute (STR)
    DIM BASED
	DIM TOTAL
	DIM TH
	DIM FDH
	DIM FNH
	DIM FDF
	DIM FNF
	FDH=0
	FNH=0
	FDF=0
	FNF=0
	TH=0
	TOTAL=0
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	Response.Write "<ROW>" & STR & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
	
end function

function updatePersBN()

	query = "UPDATE TRABAJADORES SET "
	query = query & "SUELDO_PRO=" & strNvl(SUELDO_BASE) & ","
	query = query & "BASEDIA=" & strNvl(BASED) & ","
	query = query & "HDN=" & strNvl(FDH) & ","
	query = query & "HNN=" & strNvl(FNH) & ","
	query = query & "HDF=" & strNvl(FDF) & ","
	query = query & "HNF=" & strNvl(FNF) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE CODIGO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & CODIGO & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing

End Function

function updatePersonal()

	query = "UPDATE TRABAJADORES SET NOMBRE = " & strNvl(NOMBRE) & ","
	query = query & "COD_CARGO=" & strNvl(CARGO) & ","
	query = query & "RUT=" & strNvl(RUT) & ","
	query = query & "EMAIL=" & strNvl(EMAIL) & ","
	query = query & "DIRECCION=" & strNvl(DIRECCION) & ","
	query = query & "FONOS=" & strNvl(FONOS) & ","
	query = query & "SINDICATO=" & strNvl(SIND) & ","
	query = query & "ART22=" & strNvl(ART22) & ","
	query = query & "ST=" & strNvl(IND_ST) & ","
	query = query & "ESTADO=" & strNvl(ESTADO) & ","
	query = query & "AFP=" & strNvl(AFP) & ","
	query = query & "SSALUD=" & strNvl(SSALUD) & ","
	query = query & "FECHA_CONTRATO=" & strNvl(FCONTRATO) & ","
	query = query & "FECHA_ANEXO=" & strNvl(FANEXO) & ","
	query = query & "FECHA_NAC=" & strNvl(FNAC) & ","
	query = query & "PLAZO=" & strNvl(PERIODO) & ","
	query = query & "SUCURSAL=" & strNvl(SUCURSAL) & ","
	query = query & "CLIENTE =" & strNvl(CLIENTE) & ","
	query = query & "SUELDO_PRO=" & strNvl(SUELDO_BASE) & ","
	query = query & "NIVEL=" & strNvl(NIVEL) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE CODIGO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & CODIGO & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function



function updateEvent()


	IF LEN(ID)>0 THEN
		query = "UPDATE TURNOS_USUARIOS SET FECHA = " & strNvl(FECHA_INI) & ","
		query = query & "FECHA_FIN=" & strNvl(FECHA_FIN) & ","
		query = query & "VALOR=" & strNvl(VALOR) & ","
		query = query & "USERDATE = getdate(),"
		query = query & "USERNAME =" & strNvl(USERNAME) & ""
		query = query & " WHERE ID=" & ID 
	ELSE
		query = "INSERT INTO TURNOS_USUARIOS (FECHA, FECHA_FIN, USUARIO, VALOR, USERNAME, USERDATE) "
		query = query & "VALUES (" & strNvl(FECHA_INI) & ","
		query = query & strNvl(FECHA_FIN) & ","
		query = query & strNvl(USUARIO) & ","
		query = query & strNvl(VALOR) & ","
		query = query & strNvl(USERNAME) & ","
		query = query & "getdate())"

	END IF

	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & ID & "</ROW>"
	Response.Write "</REGISTROS>"
	
	' Response.Write "{""j"":[{""__type"":""Cliente""," & _
	'						"""CompanyName"":""" & 1 & """," & _
	'						"""Address"":""" & 2 & """," & _
	'						"""Tel"":""" & "Registro Actualizado." & _
	'				        """}]}"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateCuadrilla()

	query = "UPDATE CUADRILLAS SET  NOMBRE = " & strNvl(NOMBRE) & ","
	query = query & "COLOR='#" & COLOR & "',"
	query = query & "GRUPO=" & strNvl(GRUPO) & ", "
	query = query & "ESTADO=" & strNvl(ESTADO) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE CODIGO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & CODIGO & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateCorreos()

	query = "UPDATE CORREOS SET  PRE_GR = " & strNvl(PRE_GR) & ","
	query = query & "PRE_RRHH=" & strNvl(PRE_RRHH) & ","
	query = query & "APR_GR=" & strNvl(APR_GR) & ","
	query = query & "APR_RRHH=" & strNvl(APR_RRHH) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""

	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & query & "</ROW>"
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


Function GetDaysInMonth(dtmDate)

	If IsDate(dtmDate) Then
		dtmFirstOfMonth = DateSerial(Year(dtmDate),Month(dtmDate),1)
		GetDaysInMonth = Day(DateAdd("d",-1,DateAdd("m",1,dtmFirstOfMonth)))
	End If

End Function

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

%>