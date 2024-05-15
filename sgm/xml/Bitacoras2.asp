<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
CAUSA=UCASE(REQUEST("CAUSA"))
COLOR=UCASE(REQUEST("COLOR"))
VALOR_COMBUSTIBLE=UCASE(REQUEST("VALOR_COMBUSTIBLE"))
DOC_COMBUSTIBLE=UCASE(REQUEST("DOC_COMBUSTIBLE"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
NAVE=UCASE(REQUEST("NAVE"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
PORTALONERO=UCASE(REQUEST("PORTALONERO"))
DANO=UCASE(REQUEST("DANO"))
TIPO_TURNO=UCASE(REQUEST("TIPO_TURNO"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
ESTADO=UCASE(REQUEST("ESTADO"))
USUARIO=UCASE(REQUEST("USUARIO"))
CINTA=UCASE(REQUEST("CINTA"))
MES=UCASE(REQUEST("MES"))
TURNO=UCASE(REQUEST("TURNO"))
RESPONSABLE=REQUEST("RESPONSABLE")
USERNAME=REQUEST("USERNAME")
DESCRIPCION=REQUEST("DESCRIPCION")
IND_DANO=UCASE(REQUEST("IND_DANO"))
IND_INCIDENTE=UCASE(REQUEST("IND_INCIDENTE"))
PRIORIDAD=UCASE(REQUEST("PRIORIDAD"))
ESTADO=UCASE(REQUEST("ESTADO"))


select case RECURSO
	case "GetBitacora"
		GetBitacora()
		
	case "NewBitacora"
		NewBitacora()
		
	case "InsertCintaBitacora"
		 InsertCintaBitacora()

 	case "DelCintaBitacora"
		 DelCintaBitacora()

  	case "GetCintasBitacora"
		 GetCintasBitacora()
		
	case "UpdateBitacora"
		UpdateBitacora()
		
	case "ListBitacora"
		ListBitacora()
	
	case "InfSemInspec"
	      InfSemInspec()
	
	case "ListEquiposBitacoras"
		ListEquiposBitacora()

	case "ListIncidentes"
		ListIncidentes()
		
	case "ListIncidentesOT"
		ListIncidentesOT()
	
	case "ListNaves"
		ListNaves()
	
end select

function NewBitacora()

	query = "SELECT MAX(ID) AS N FROM BITACORAS"
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO BITACORAS (ID, FECHA, TURNO, RESPONSABLE, OPERADOR_NAVE, "
	query = query & " OPERADOR_GRUA, PORTALONERO, DANO,"
	query = query & " DESCRIPCION, ESTADO, EQUIPO, REPORT, NAVE, TIPO_TURNO,"
	query = query & " IND_INCIDENTE, IND_DANO, COMBUSTIBLE, VALOR_COMBUSTIBLE, CAUSA,  PRIORIDAD) VALUES ("
	query = query & N & "," 
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(TURNO) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & strNvl(OPERADOR_NAVE) & ","
	query = query & strNvl(OPERADOR_GRUA) & ","
	query = query & strNvl(PORTALONERO) & ","
	query = query & strNvl(DANO) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & "'ING',"
	query = query & strNvl(EQUIPO) & ","
	query = query & strNvl(REPORT) & ","
	query = query & strNvl(NAVE) & ","
	query = query & strNvl(TIPO_TURNO) & ","
	query = query & strNvl(IND_INCIDENTE) & ","
	query = query & strNvl(IND_DANO) & ","
	query = query & strNvl(COMBUSTIBLE) & ","
	query = query & strNvl(VALOR_COMBUSTIBLE) & ","
	query = query & strNvl(CAUSA) & ","
	query = query & strNvl(PRIORIDAD) & ");"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & N  & "</ID>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function ListBitacora()

	query = "SELECT ID,"
	query = query & "rtrim(convert(char,fecha,103)) + ' ' + "
	query = query & " substring(convert(char,fecha,108),1,5) as FECHA"
	query = query & ", TURNO, RESPONSABLE,"
	query = query & " DESCRIPCION, ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " FROM BITACORAS AS B, EQUIPOS_USUARIOS AS EU "
	'query = query & " WHERE MONTH(FECHA)=" & MES
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " AND  DBO.EquipoPrincipal(B.EQUIPO) = EU.EQUIPO"
	query = query & " AND  EU.USUARIO=" & strNvl(USUARIO)
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If TURNO<>"TOD" Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else		
			query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPAL(B.EQUIPO)=" & strNvl(EQUIPO_PRIN)
	End if
	
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_INCIDENTE<>"TOD" Then
		query = query & " AND IND_INCIDENTE=" & strNvl(IND_INCIDENTE)
	End if
	
	query = query & " ORDER BY convert(char,fecha,101)"
	
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
		  IF ORs.Fields.Item(7).Value ="SER" THEN
	  		  Response.Write "<TIPO_TURNO>SERVICIO</TIPO_TURNO>"
			ELSE
			  Response.Write "<TIPO_TURNO>MANTENCION</TIPO_TURNO>"
		  END IF
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InfSemInspec()

	query = "SELECT ID,"
	query = query & "rtrim(convert(char,fecha,103)) + ' ' + "
	query = query & " substring(convert(char,fecha,108),1,5) as FECHA"
	query = query & ", TURNO, RESPONSABLE,"
	query = query & " DESCRIPCION, ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " FROM BITACORAS AS B, EQUIPOS_USUARIOS AS EU "
	'query = query & " WHERE MONTH(FECHA)=" & MES
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " AND  DBO.EquipoPrincipal(B.EQUIPO) = EU.EQUIPO"
	query = query & " AND  EU.USUARIO=" & strNvl(USUARIO)
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If TURNO<>"TOD" Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	
	If EQUIPO<>"TOD"  Then
		If strNvl(EQUIPO)="NULL" Then
				query = query & " AND B.EQUIPO IS NULL"
		Else		
			query = query & " AND RTRIM(B.EQUIPO)=" & strNvl(EQUIPO)
		End If	
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPAL(B.EQUIPO)=" & strNvl(EQUIPO_PRIN)
	End if
	
	
	If IND_DANO<>"TOD" Then
		query = query & " AND IND_DANO=" & strNvl(IND_DANO)
	End if

	If IND_INCIDENTE<>"TOD" Then
		query = query & " AND IND_INCIDENTE=" & strNvl(IND_INCIDENTE)
	End if
	
	query = query & " ORDER BY convert(char,fecha,101)"
	
	Set ORs =oDB.EjecutaSql(query)
	 
	Response.Write "<?xml version='1.0' encoding='UTF-8' ?>" & VbCrLf & VbCrLf
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/Inspecciones.xsl'?>"
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
		  IF ORs.Fields.Item(7).Value ="SER" THEN
	  		  Response.Write "<TIPO_TURNO>SERVICIO</TIPO_TURNO>"
			ELSE
			  Response.Write "<TIPO_TURNO>MANTENCION</TIPO_TURNO>"
		  END IF
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value,1)
		  sFALLA=""
		  
		  While Not oRsChk.EOF
		  		Response.Write "<FALLAS>" 
		  		Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
				Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR
				oRsChk.MoveNext
				Response.Write "</FALLAS>" 
		  Wend
		  'Response.Write sFALLA
		  
		  Response.Write "</ROW>"
	  
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


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

function ListEquiposBitacora()

	query = "SELECT DISTINCT "
	query = query & " EQUIPO FROM BITACORAS "
	query = query & " WHERE CONVERT(DATETIME,(CONVERT(CHAR,FECHA,103))) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN)
	
	if (EQUIPO)<>"TOD" AND LEN(EQUIPO)>0 Then
	query = query & " AND DBO.EquipoPrincipal(EQUIPO)= " & strNvl(EQUIPO)
	end If
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If TURNO<>"TOD" Then
		query = query & " AND TURNO=" & strNvl(TURNO)
	End if
	
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
	'Response.Write "<QUERY>" & query & "</QUERY>"
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


function GetBitacora()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA,"
	query = query & " B.TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.EQUIPO, E.DESCRIPCION AS DESC_EQUIPO,"
	query = query & " B.REPORT, B.NAVE, B.TIPO_TURNO, B.OPERADOR_NAVE, "
	query = query & " B.OPERADOR_GRUA, B.PORTALONERO, B.DANO, B.PRIORIDAD, B.IND_DANO, "
	query = query & " B.COMBUSTIBLE, B.VALOR_COMBUSTIBLE, B.DOC_COMBUSTIBLE, B.CAUSA, B.COLOR "
	query = query & " FROM BITACORAS AS B LEFT OUTER JOIN  EQUIPOS AS E "
	query = query & " ON B.EQUIPO = E.CODIGO"
	query = query & " WHERE ID=" & ID 


	Set ORs =oDB.EjecutaSql(query)
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
  		  Response.Write "<NAVE>" & ORs.Fields.Item(10).Value & "</NAVE>"
  		  Response.Write "<TIPO_TURNO>" & ORs.Fields.Item(11).Value & "</TIPO_TURNO>"
   		  Response.Write "<OPERADOR_NAVE>" & ORs.Fields.Item(12).Value & "</OPERADOR_NAVE>"
   		  Response.Write "<OPERADOR_GRUA>" & ORs.Fields.Item(13).Value & "</OPERADOR_GRUA>"
   		  Response.Write "<PORTANOLERO>" & ORs.Fields.Item(14).Value & "</PORTANOLERO>"
   		  Response.Write "<DANO>" & ORs.Fields.Item(15).Value & "</DANO>"
   		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(16).Value & "</PRIORIDAD>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(17).Value & "</IND_DANO>"
		  Response.Write "<COMBUSTIBLE>" & ORs.Fields.Item(18).Value & "</COMBUSTIBLE>"
		  Response.Write "<VALOR_COMBUSTIBLE>" & ORs.Fields.Item(19).Value & "</VALOR_COMBUSTIBLE>"
		  Response.Write "<DOC_COMBUSTIBLE>" & ORs.Fields.Item(20).Value & "</DOC_COMBUSTIBLE>"
 		  Response.Write "<CAUSA>" & ORs.Fields.Item(21).Value & "</CAUSA>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(22).Value & "</COLOR>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateBitacora()

	query = "UPDATE BITACORAS SET FECHA = " & strNvl(FECHA) & ","
	query = query & "TURNO=" & strNvl(TURNO) & ","
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "IND_INCIDENTE=" & strNvl(IND_INCIDENTE) & ","
	query = query & "IND_DANO=" & strNvl(IND_DANO) & ","
	query = query & "EQUIPO=" & strNvl(EQUIPO) & ","
	query = query & "REPORT=" & strNvl(REPORT) & ","
	query = query & "NAVE=" & strNvl(NAVE) & ","
	query = query & "TIPO_TURNO=" & strNvl(TIPO_TURNO) & ","
	query = query & "PRIORIDAD=" & strNvl(PRIORIDAD) & ","
	query = query & "COLOR=" & strNvl(COLOR) & ","
	query = query & "OPERADOR_GRUA=" & strNvl(OPERADOR_GRUA) & ","
	query = query & "PORTALONERO=" & strNvl(PORTALONERO) & ","
	query = query & "COMBUSTIBLE=" & strNvl(COMBUSTIBLE) & ","
	query = query & "VALOR_COMBUSTIBLE=" & strNvl(VALOR_COMBUSTIBLE) & ","
	query = query & "CAUSA=" & strNvl(CAUSA) & ","
	query = query & "DANO=" & strNvl(DANO) 
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

%>

