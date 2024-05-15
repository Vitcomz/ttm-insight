<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 11274
RECURSO=REQUEST("RECURSO")
FOLIO=UCASE(REQUEST("FOLIO"))
RESPONSABLE=UCASE(REQUEST("USERNAME"))
FAENA=UCASE(REQUEST("FAENA"))
EMPRESA=UCASE(REQUEST("EMPRESA"))
CONTRATO=UCASE(REQUEST("CONTRATO"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
RUT=UCASE(REQUEST("RUT"))
FECHA=UCASE(REQUEST("FECHA"))
SUCURSAL=UCASE(REQUEST("SUCURSAL"))
DISCIPLINA=UCASE(REQUEST("DISCIPLINA"))
AREA=UCASE(REQUEST("AREA"))
OBSERVACION=UCASE(REQUEST("OBSERVACION"))
COMENTARIO=UCASE(REQUEST("COMENTARIO"))
COMP=UCASE(REQUEST("COMP"))

FECHA2=UCASE(REQUEST("FECHA2"))
ACCION=UCASE(REQUEST("ACCION"))
ESTADO=UCASE(REQUEST("ESTADO"))

ID=UCASE(REQUEST("ID"))
EDAD=UCASE(REQUEST("EDAD"))
SECCION=UCASE(REQUEST("SECCION"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
TURNO=UCASE(REQUEST("TURNO"))
MES=UCASE(REQUEST("MES"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
VALOR=UCASE(REQUEST("VALOR"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
TIEMPO=UCASE(REQUEST("TIEMPO"))
CADENA=UCASE(REQUEST("CADENA"))
ANHO=UCASE(REQUEST("ANHO"))

Select Case RECURSO
	case "getObservaciones"
		  getObservaciones()
	
	case "updateObs"
		  updateObs()
	
	case "newObs"
		  newObs()
		  
	case "UpdComp"
		  UpdComp()
		  
	case "newCompValor"
		  newCompValor()
		  
	case "listObservaciones"
		  listObservaciones()
	
	case "listObservacionesChu"
		  listObservacionesChu()
	
	case "listComportamientos"
		  listComportamientos()
	
	case "listComportamientoschuqui"
		  listComportamientoschuqui()
			
	case "listComp"
		  listComp()
		  	  
	case "listCompChuqui"
		  listCompChuqui()
		  	  
	case "delComp"
		  delComportamientos()	 	  	  
	
	case "grComp"
		  grComp()	
	
	case "grCompChuqui"
		  grCompChuqui()	
		  
end select

function getObservaciones()

	query = "SELECT FOLIO, FECHA, RUT, NOMBRE, AREA, DISCIPLINA, EDAD,"
	query = query & "  TIEMPO_OPERANDO, HORA_OBS, AREA, OBSERVACION, FAENA, COMP_RIESGO " 
	
	if FAENA = "CHUQUICAMATA" then
		query = query & ", EMPRESA, CONTRATO, COMENTARIO, FECHA2, ACCION, GERENCIA, RESPONSABLE,ESTADO "
	end if
	
	query = query & " FROM OBSERVACIONES "
	query = query & " WHERE FOLIO=" & strNvl(FOLIO) 
	
	Set Rs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>"
	
	Response.Write "<REGISTRO>"
		
	While Not Rs.EOF 
		Response.Write "<ROW>"
		 Response.Write "<FOLIO>" & Rs.Fields.Item(0).Value & "</FOLIO>"
		 Response.Write "<FECHA>" & Rs.Fields.Item(1).Value & "</FECHA>"
		 Response.Write "<RUT>" & Rs.Fields.Item(2).Value & "</RUT>"
		 Response.Write "<NOMBRE>" & Rs.Fields.Item(3).Value & "</NOMBRE>"
		 Response.Write "<AREA>" & Rs.Fields.Item(4).Value & "</AREA>"
		 Response.Write "<DISIPLINA>" & Rs.Fields.Item(5).Value & "</DISIPLINA>"
		 Response.Write "<EDAD>" & Rs.Fields.Item(6).Value & "</EDAD>"
		 Response.Write "<TIEMPO_OPERANDO>" & Rs.Fields.Item(7).Value & "</TIEMPO_OPERANDO>"
		 Response.Write "<HORA>" & MID(Rs.Fields.Item(8).Value,1,2) & "</HORA>"
		 Response.Write "<MIN>" & MID(Rs.Fields.Item(8).Value,4,2) & "</MIN>"
		 Response.Write "<AREA1>" & Rs.Fields.Item(9).Value & "</AREA1>"
		 Response.Write "<OBSERVACION>" & Rs.Fields.Item(10).Value & "</OBSERVACION>"
		 Response.Write "<FAENA>" & Rs.Fields.Item(11).Value & "</FAENA>"
		 Response.Write "<COMP>" & Rs.Fields.Item(12).Value & "</COMP>"
		 
		 if FAENA = "CHUQUICAMATA" then
			 
			 Response.Write "<CONTRATO>" & Rs.Fields.Item(13).Value & "</CONTRATO>"
			 Response.Write "<COMENTARIO>" & Rs.Fields.Item(14).Value & "</COMENTARIO>"
			 Response.Write "<FECHA2>" & Rs.Fields.Item(15).Value & "</FECHA2>"
			 Response.Write "<ACCION>" & Rs.Fields.Item(16).Value & "</ACCION>"
			 Response.Write "<SUCURSAL>" & Rs.Fields.Item(17).Value & "</SUCURSAL>"
			 Response.Write "<RESPONSABLE>" & Rs.Fields.Item(18).Value & "</RESPONSABLE>"
			 Response.Write "<ESTADO>" & Rs.Fields.Item(19).Value & "</ESTADO>"
		 end if
		 Response.Write "</ROW>"
		 Rs.MoveNext
	Wend
	
	Response.Write "</REGISTRO>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function newObs()

	query = "SELECT MAX(FOLIO) AS NUM FROM OBSERVACIONES"

	Set ORs =oDB.EjecutaSql(query)

	If Len(oRS("NUM"))>0 Then
		CODIGO = oRS("NUM") + 1
	Else
		CODIGO = 1
	End If
	if strNvl(RUT)="NULL" then
		rut = "0"
	end if
	if FAENA = "CHUQUICAMATA" then
		query = "INSERT INTO OBSERVACIONES (FOLIO, NOMBRE, RUT, FECHA, HORA_OBS, AREA, TIEMPO_OPERANDO, EDAD, DISCIPLINA, OBSERVACION, FAENA, EMPRESA, CONTRATO, COMENTARIO, FECHA2, ACCION, GERENCIA, RESPONSABLE) " 
		query = query & " VALUES(" & strNvl(CODIGO)
		query = query & " ," & strNvl(NOMBRE)
		query = query & " ," & strNvl(RUT)
		query = query & " ," & strNvl(FECHA)
		query = query & " ," & strNvl(mid(FECHA,12,5))
		query = query & " ," & strNvl(AREA)
		query = query & " ," & strNvl(TIEMPO)
		query = query & " ," & strNvl(EDAD)
		query = query & " ," & strNvl(DISCIPLINA)
		query = query & " ," & strNvl(OBSERVACION)
		query = query & " ," & strNvl(FAENA) 
		query = query & " ," & strNvl(EMPRESA) 
		query = query & " ," & strNvl(CONTRATO) 
		query = query & " ," & strNvl(COMENTARIO) 
		query = query & " ," & strNvl(FECHA2) 
		query = query & " ," & strNvl(ACCION)
		query = query & " ," & strNvl(SUCURSAL)
		query = query & " ," & strNvl(RESPONSABLE)& ")"
	else
		query = "INSERT INTO OBSERVACIONES (FOLIO, NOMBRE, RUT, FECHA, HORA_OBS, AREA, TIEMPO_OPERANDO, EDAD, DISCIPLINA, OBSERVACION, FAENA) " 
		query = query & " VALUES(" & strNvl(CODIGO)
		query = query & " ," & strNvl(NOMBRE)
		query = query & " ," & strNvl(RUT)
		query = query & " ," & strNvl(FECHA)
		query = query & " ," & strNvl(mid(FECHA,12,5))
		query = query & " ," & strNvl(AREA)
		query = query & " ," & strNvl(TIEMPO)
		query = query & " ," & strNvl(EDAD)
		query = query & " ," & strNvl(DISCIPLINA)
		query = query & " ," & strNvl(OBSERVACION)
		query = query & " ," & strNvl(FAENA) & ")"
	end if

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><FOLIO>" & CODIGO & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateObs()

	if FAENA = "CHUQUICAMATA" then
		query = "UPDATE OBSERVACIONES SET " 
		query = query & " NOMBRE="       & strNvl(NOMBRE)
		query = query & " ,RUT="         & strNvl(RUT)
		query = query & " ,FECHA="       & strNvl(FECHA)
		query = query & " ,AREA="        & strNvl(AREA)
		query = query & " ,OBSERVACION=" & strNvl(OBSERVACION)
		query = query & " ,DISCIPLINA="  & strNvl(DISCIPLINA)
		query = query & " ,EMPRESA="     & strNvl(EMPRESA) 
		query = query & " ,CONTRATO="    & strNvl(CONTRATO) 
		query = query & " ,COMENTARIO="  & strNvl(COMENTARIO) 
		query = query & " ,FECHA2="      & strNvl(FECHA2) 
		query = query & " ,ACCION="      & strNvl(ACCION)
		query = query & " ,GERENCIA="    & strNvl(SUCURSAL)
		query = query & " ,COMP_RIESGO =" & strNvl(COMP)
		query = query & " ,ESTADO="    & strNvl(ESTADO)
		query = query & " WHERE FOLIO="  & strNvl(FOLIO)
	else
		query = "UPDATE OBSERVACIONES SET " 
		query = query & " NOMBRE=" & strNvl(NOMBRE)
		query = query & " ,RUT=" & strNvl(RUT)
		query = query & " ,FECHA=" & strNvl(FECHA)
		query = query & " ,AREA=" & strNvl(AREA)
		query = query & " ,EDAD=" & strNvl(EDAD)
		query = query & " ,OBSERVACION=" & strNvl(OBSERVACION)
		query = query & " ,COMP_RIESGO =" & strNvl(COMP)
		query = query & " ,DISCIPLINA=" & strNvl(DISCIPLINA)
		query = query & " WHERE FOLIO=" & strNvl(FOLIO)
	end if
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><FOLIO>" & FOLIO & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function newCompValor()

	query = "INSERT INTO COMP_FOLIO (" 
	query = query & " FOLIO, "
	query = query & " ID, VALOR) "
	query = query & " VALUES ("
	query = query & strNvl(FOLIO) & ","
	query = query & strNvl(ID) & ","
	query = query & strNvl(VALOR) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

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
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
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
	
	
	query = query & " GROUP BY ID,"
	query = query & " FECHA,"
	query = query & " TURNO, RESPONSABLE,"
	query = query & " DESCRIPCION, ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " ORDER BY convert(char,fecha,101)"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" 
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/Inspecciones.xsl'?>" & VbCrLf & VbCrLf
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
		  Response.Write "</ROW>"
	  
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InfDiaInspec()

	query = "SELECT B.ID,"
	query = query & " RTRIM(CONVERT(char,B.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,B.fecha,108),1,5) as FECHA,"
	query = query & " B.TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA "
	query = query & " FROM BITACORAS AS B"
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) = " & strNvl(FECHA_INI) & ")"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
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
	

	query = query & " ORDER BY convert(char,B.fecha,101)"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>"
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(10).Value & "</COLOR>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  		  
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value,1)
		  While Not oRsChk.EOF
		  		Response.Write "<FALLAS>" 
		  		Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
				Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR
				oRsChk.MoveNext
				Response.Write "</FALLAS>" 
		  Wend
		 
		  Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  While Not oRsFiles.EOF
		  		Response.Write "<FILES>" 
		  		Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				oRsFiles.MoveNext
				Response.Write "</FILES>" 
		  Wend
		 
		  Response.Write "</ROW>"
	 
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listObservaciones()

query =	" SELECT FOLIO, convert(varchar, FECHA, 103), NOMBRE "
query = query  & " FROM OBSERVACIONES "
query = query  & " WHERE FAENA <> 'CHUQUICAMATA' "
query = query  & " ORDER BY FOLIO DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & VbCrLf
	While Not ORs.EOF 
	  Response.Write "<ROW>"  & VbCrLf
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>" & VbCrLf
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>" & VbCrLf
		  Response.Write "<OBSERVADOR>" & ORs.Fields.Item(2).Value & "</OBSERVADOR>" & VbCrLf
	  Response.Write "</ROW>" & VbCrLf
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>" & VbCrLf

	Set ORs = Nothing
	Set ODB = Nothing
end function

function listObservacionesChu()

query =	" SELECT FOLIO, FECHA, NOMBRE, ISNULL(ESTADO,'ABIERTA')"
query = query  & " FROM OBSERVACIONES "
query = query  & " WHERE FAENA = 'CHUQUICAMATA' "
query = query  & " ORDER BY FOLIO DESC"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<OBSERVADOR>" & ORs.Fields.Item(2).Value & "</OBSERVADOR>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(3).Value & "</ESTADO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function listComportamientos()

	query = "SELECT COM.ID, COM.NOMBRE, C.FOLIO, C.VALOR, COM.CATEGORIA "
	query = query & " FROM COMPORTAMIENTOS AS COM "
	query = query & " LEFT OUTER JOIN COMP_FOLIO AS C ON C.FOLIO=" & strNvl(FOLIO)
	query = query & " 		AND COM.ID = C.ID "
	query = query & " WHERE COM.CATEGORIA <> 'CHUQUICAMATA' "
	query = query & " ORDER BY COM.CATEGORIA, COM.NOMBRE"
	 
	Set ORs =oDB.EjecutaSql(query)

Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
	 
	Response.Write "<REGISTROS>"	
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID> "  & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<FOLIO>" & ORs.Fields.Item(2).Value & "</FOLIO>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
		  Response.Write "<CATEGORIA>" & ORs.Fields.Item(4).Value & "</CATEGORIA>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End function
		 
function listComportamientoschuqui()

	query = "SELECT COM.ID, COM.NOMBRE, C.FOLIO, C.VALOR, COM.CATEGORIA "
	query = query & " FROM COMPORTAMIENTOS AS COM "
	query = query & " LEFT OUTER JOIN COMP_FOLIO AS C ON C.FOLIO=" & strNvl(FOLIO)
	query = query & " 		AND COM.ID = C.ID "
	query = query & " WHERE COM.CATEGORIA = 'CHUQUICAMATA' "
	query = query & " ORDER BY COM.ID "
	 
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"	
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID> "  & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<FOLIO>" & ORs.Fields.Item(2).Value & "</FOLIO>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
		  Response.Write "<CATEGORIA>" & ORs.Fields.Item(4).Value & "</CATEGORIA>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End function
		 
function delComportamientos()
	query = "DELETE COMP_FOLIO WHERE FOLIO = " & strNvl(FOLIO) 
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdComp()

	query = "DELETE COMP_FOLIO WHERE FOLIO = " & strNvl(FOLIO) 
	Set ORs = oDB.EjecutaSql(query)

	comportamientos = split(cadena,"L")

	query = "INSERT INTO COMP_FOLIO (" 
	query = query & " FOLIO, N, "
	query = query & " ID, VALOR) "
	query = query & " VALUES "
	for each elemento in comportamientos
		query = query & " (" & strNvl(FOLIO)
		cmp=split(elemento," ")
		for each el in cmp
			query = query & "," & strNvl(el)
		next
		query = query & "),"
	next
	query = Mid(query,1,len(query)-1)
		
	'response.Write(query)
	'response.End()

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing


end function

function grComp()

	query =	" SELECT C.CATEGORIA,"
	query = query & "		   S = SUM(CASE CF.VALOR WHEN 'S' THEN 1 END), "
	query = query & "		   R = SUM(CASE CF.VALOR WHEN 'R' THEN 1 END), "
	query = query & "		   N = SUM(CASE CF.VALOR WHEN 'N' THEN 1 END), "
	query = query & "		   NA = SUM(CASE CF.VALOR WHEN 'NA' THEN 1 END), "
	query = query & "		   COUNT(*) "
	query = query & "		   FROM COMPORTAMIENTOS AS C "
	query = query & "		   LEFT JOIN COMP_FOLIO AS CF ON C.ID=CF.ID "
	query = query & "		   LEFT JOIN OBSERVACIONES AS O ON CF.FOLIO = O.FOLIO "
	query = query & "		   WHERE  "
	query = query & "          YEAR(O.FECHA)=" & strNvl(ANHO)
	query = query & "	       GROUP BY C.CATEGORIA  "

	
	
	Set ORs = oDB.EjecutaSql(query)
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='UTF-8'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>"
	Response.Write "<chart palette='4' caption='Comportamientos' shownames='1'  numDivLines='10'  bgColor='FFFFFF' showBorder='0' anchorRadius='5' anchorBorderThickness='2'>"
	Response.Write "<categories verticalLineThickness='1'>"
	While Not ORs.EOF 
		Response.Write "<category  label='" & ORs.Fields.Item(0).Value & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Seguro'  showValues='1' >" 
	While Not ORs.EOF 
		 Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(1).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Riesgoso'  showValues='1' >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(2).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Nunca'  showValues='1' >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(3).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='No Aplica'  showValues='1' >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(numNvl(ORs.Fields.Item(4).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grCompChuqui()

		query =	" SELECT substring(C.NOMBRE, 0, 20),"
		query = query & " NA = ISNULL(SUM(CASE CF.VALOR WHEN 'NA' THEN 1 END),''), "
		query = query & " B00= ISNULL(SUM(CASE CF.VALOR WHEN 'B00' THEN 1 END),''), "
		query = query & " B01= ISNULL(SUM(CASE CF.VALOR WHEN 'B01' THEN 1 END),''), "
		query = query & " B02= ISNULL(SUM(CASE CF.VALOR WHEN 'B02' THEN 1 END),''), "
		query = query & " B03= ISNULL(SUM(CASE CF.VALOR WHEN 'B03' THEN 1 END),''), "
		query = query & " B04= ISNULL(SUM(CASE CF.VALOR WHEN 'B04' THEN 1 END),''), "
		query = query & " B05= ISNULL(SUM(CASE CF.VALOR WHEN 'B05' THEN 1 END),''), "
		query = query & " B06= ISNULL(SUM(CASE CF.VALOR WHEN 'B06' THEN 1 END),''), "
		query = query & " B07= ISNULL(SUM(CASE CF.VALOR WHEN 'B07' THEN 1 END),''), "
		query = query & " B08= ISNULL(SUM(CASE CF.VALOR WHEN 'B08' THEN 1 END),''), "
		query = query & " B09= ISNULL(SUM(CASE CF.VALOR WHEN 'B09' THEN 1 END),''), COUNT(*) "
		query = query & " FROM COMPORTAMIENTOS AS C LEFT JOIN COMP_FOLIO AS CF ON C.ID=CF.ID "
		query = query & " LEFT JOIN OBSERVACIONES AS O ON CF.FOLIO = O.FOLIO WHERE "
		query = query & " C.CATEGORIA = 'CHUQUICAMATA' AND O.FAENA = 'CHUQUICAMATA' "
		query = query & " AND O.FECHA BETWEEN CONVERT(datetime, "&strNvl(FECHA)&", 103) and CONVERT(datetime, "&strNvl(FECHA2)&", 103)"
		query = query & " GROUP BY C.NOMBRE"
	
	Set ORs = oDB.EjecutaSql(query)
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='UTF-8'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>"

	Response.Write "<chart palette='4' caption='Comportamientos' shownames='1'  numDivLines='10'  bgColor='FFFFFF' showBorder='0' anchorRadius='5' anchorBorderThickness='2'>"
	
	categorias= "<categories verticalLineThickness='1'>"
	uno= "<dataset seriesName='No Aplica'  showValues='1' >"
	dos= "<dataset seriesName='Segura'  showValues='1' >"
	tres= "<dataset seriesName='B01'  showValues='1' >"
	cuatro= "<dataset seriesName='B02'  showValues='1' >"
	cinco= "<dataset seriesName='B03'  showValues='1' >"
	seis= "<dataset seriesName='B04'  showValues='1' >"
	siete= "<dataset seriesName='B05'  showValues='1' >"
	ocho= "<dataset seriesName='B06'  showValues='1' >"
	nueve= "<dataset seriesName='B07'  showValues='1' >"
	diez= "<dataset seriesName='B08'  showValues='1' >"
	once= "<dataset seriesName='B09'  showValues='1' >"
	While Not ORs.EOF 
		categorias=categorias & "<category  label='" & ORs.Fields.Item(0).Value & "' />"
		uno=uno& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(1).Value),",",".") & "' />"
		dos=dos& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(2).Value),",",".") & "' />"
		tres=tres& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(3).Value),",",".") & "' />"
		cuatro=cuatro& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(4).Value),",",".") & "' />"
		cinco=cinco& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(5).Value),",",".") & "' />"
		seis=seis& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(6).Value),",",".") & "' />"
		siete=siete& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(7).Value),",",".") & "' />"
		ocho=ocho& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(8).Value),",",".") & "' />"
		nueve=nueve& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(9).Value),",",".") & "' />"
		diez=diez& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(10).Value),",",".") & "' />"
		once=once& "<set value='" & REPLACE(numNvl(ORs.Fields.Item(11).Value),",",".") & "' />"
		 ORs.MoveNext
	Wend
	categorias=categorias & "</categories>"
	uno=uno& "</dataset>"
	dos=dos& "</dataset>"
	tres=tres& "</dataset>"
	cuatro=cuatro& "</dataset>"
	cinco=cinco& "</dataset>"
	seis=seis& "</dataset>"
	siete=siete& "</dataset>"
	ocho=ocho& "</dataset>"
	nueve=nueve& "</dataset>"
	diez=diez& "</dataset>"
	once=once& "</dataset>"
	
	Response.Write categorias&uno&dos&tres&cuatro&cinco&seis&siete&ocho&nueve&diez&once&"</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listCompChuqui()
		query =	" SELECT C.NOMBRE,"
		query = query & " NA = ISNULL(SUM(CASE CF.VALOR WHEN 'NA' THEN 1 END),0), "
		query = query & " B00= ISNULL(SUM(CASE CF.VALOR WHEN 'B00' THEN 1 END),0), "
		query = query & " B01= ISNULL(SUM(CASE CF.VALOR WHEN 'B01' THEN 1 END),0), "
		query = query & " B02= ISNULL(SUM(CASE CF.VALOR WHEN 'B02' THEN 1 END),0), "
		query = query & " B03= ISNULL(SUM(CASE CF.VALOR WHEN 'B03' THEN 1 END),0), "
		query = query & " B04= ISNULL(SUM(CASE CF.VALOR WHEN 'B04' THEN 1 END),0), "
		query = query & " B05= ISNULL(SUM(CASE CF.VALOR WHEN 'B05' THEN 1 END),0), "
		query = query & " B06= ISNULL(SUM(CASE CF.VALOR WHEN 'B06' THEN 1 END),0), "
		query = query & " B07= ISNULL(SUM(CASE CF.VALOR WHEN 'B07' THEN 1 END),0), "
		query = query & " B08= ISNULL(SUM(CASE CF.VALOR WHEN 'B08' THEN 1 END),0), "
		query = query & " B09= ISNULL(SUM(CASE CF.VALOR WHEN 'B09' THEN 1 END),0), COUNT(*) "
		query = query & " FROM COMPORTAMIENTOS AS C LEFT JOIN COMP_FOLIO AS CF ON C.ID=CF.ID "
		query = query & " LEFT JOIN OBSERVACIONES AS O ON CF.FOLIO = O.FOLIO WHERE "
		query = query & " C.CATEGORIA = 'CHUQUICAMATA' AND O.FAENA = 'CHUQUICAMATA' "
		query = query & " AND O.FECHA BETWEEN CONVERT(datetime, "&strNvl(FECHA)&", 103) and CONVERT(datetime, "&strNvl(FECHA2)&", 103)"
		query = query & " GROUP BY C.NOMBRE"

	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"& VbCrLf
	'response.Write("<ROW>"&query&"</ROW>")
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<CATEGORIA> "  & ORs.Fields.Item(0).Value & "</CATEGORIA>"
	  	  Response.Write "<NA> "  & ORs.Fields.Item(1).Value & "</NA>"
	  	  Response.Write "<B00> "  & ORs.Fields.Item(2).Value & "</B00>"
	  	  Response.Write "<B01> "  & ORs.Fields.Item(3).Value & "</B01>"
	  	  Response.Write "<B02> "  & ORs.Fields.Item(4).Value & "</B02>"
	  	  Response.Write "<B03> "  & ORs.Fields.Item(5).Value & "</B03>"
	  	  Response.Write "<B04> "  & ORs.Fields.Item(6).Value & "</B04>"
	  	  Response.Write "<B05> "  & ORs.Fields.Item(7).Value & "</B05>"
	  	  Response.Write "<B06> "  & ORs.Fields.Item(8).Value & "</B06>"
	  	  Response.Write "<B07> "  & ORs.Fields.Item(9).Value & "</B07>"
	  	  Response.Write "<B08> "  & ORs.Fields.Item(10).Value & "</B08>"
	  	  Response.Write "<B09> "  & ORs.Fields.Item(11).Value & "</B09>"
	  	  Response.Write "<TOTAL> "  & ORs.Fields.Item(12).Value & "</TOTAL>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function






function listComp()
	
	query =	" SELECT C.CATEGORIA,"
	query = query & "		   S = SUM(CASE CF.VALOR WHEN 'S' THEN 1 END),"
	query = query & "		   R = SUM(CASE CF.VALOR WHEN 'R' THEN 1 END),"
	query = query & "		   N = SUM(CASE CF.VALOR WHEN 'N' THEN 1 END),"
	query = query & "		   NA = SUM(CASE CF.VALOR WHEN 'NA' THEN 1 END),"
	query = query & "		   COUNT(*) "
	query = query & "	 FROM COMPORTAMIENTOS AS C, "
	query = query & "		COMP_FOLIO AS CF, OBSERVACIONES AS O"
	query = query & "	WHERE C.ID=CF.ID"
	query = query & "	AND CF.FOLIO=O.FOLIO"  
	query = query & " AND YEAR(O.FECHA)=" & strNvl(ANHO)
	
	If MES<>"00"  Then
		query = query & "	AND MONTH(O.FECHA)=" & strNvl(MES) 
	End if

	query = query & "	GROUP BY C.CATEGORIA"
'response.Write(query)
'response.End()
	
	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"	
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<CATEGORIA> "  & ORs.Fields.Item(0).Value & "</CATEGORIA>"
		  Response.Write "<SEGURO>" & ORs.Fields.Item(1).Value & "</SEGURO>"
		  Response.Write "<RIESGOSO>" & ORs.Fields.Item(2).Value & "</RIESGOSO>"
		  Response.Write "<NUNCA>" & ORs.Fields.Item(3).Value & "</NUNCA>"
		  Response.Write "<NOAPLICA>" & ORs.Fields.Item(4).Value & "</NOAPLICA>"
		  Response.Write "<TOTAL>" & ORs.Fields.Item(5).Value & "</TOTAL>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function numNvl(Valor)
	if isNull(Valor) then
		numNvl = 0
	else
		numNvl =  Valor	
	end if
end function

Function isCero(Valor)
	if Valor=0 then
		isCero = 1
	else
		isCero =  Valor	
	end if
end function

Function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

