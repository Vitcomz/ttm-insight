<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
'Session.LCID = 2057
Session.LCID = 11274

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
COMPONENTE=REQUEST("COMPONENTE")
CAUSA=REQUEST("CAUSA")
ACCION=UCASE(REQUEST("ACCION"))
AREA=UCASE(REQUEST("AREA"))
ESTATUS=UCASE(REQUEST("ESTATUS"))
ESTADO=UCASE(REQUEST("ESTADO"))
EJECUTOR=UCASE(REQUEST("EJECUTOR"))
GSAP=UCASE(REQUEST("GSAP"))
CRITICIDAD=UCASE(REQUEST("CRITICIDAD"))
SECCION=UCASE(REQUEST("SECCION"))
CONDICION=UCASE(REQUEST("CONDICION"))
COLOR=UCASE(REQUEST("COLOR"))
VALOR_COMBUSTIBLE=UCASE(REQUEST("VALOR_COMBUSTIBLE"))
DOC_COMBUSTIBLE=UCASE(REQUEST("DOC_COMBUSTIBLE"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
FAENA=UCASE(REQUEST("FAENA"))
NAVE=UCASE(REQUEST("NAVE"))
STR=UCASE(REQUEST("STR"))
HIST=UCASE(REQUEST("HIST"))
REPORT=UCASE(REQUEST("REPORT"))
RESPONSABLE=REQUEST("RESPONSABLE")
TRATAMIENTO=REQUEST("TRATAMIENTO")
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
OT=UCASE(REQUEST("OT"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
NUM=UCASE(REQUEST("NUM"))
DANO=UCASE(REQUEST("DANO"))
TIPO_TURNO=UCASE(REQUEST("TIPO_TURNO"))
TIPO=UCASE(REQUEST("TIPO"))
TURNO=UCASE(REQUEST("TURNO"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
EXCEL=UCASE(REQUEST("EXCEL"))
FECHA_PROGRAMADA=UCASE(REQUEST("FECHA_PROGRAMADA"))
USUARIO=UCASE(REQUEST("USUARIO"))
UBICACION=UCASE(REQUEST("UBICACION"))
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
VALOR=UCASE(REQUEST("VALOR"))


select case RECURSO
	
	case "getAviso"
		getAviso()
		
	case "updateAviso"
		updateAviso()

	case "newAviso"
		  newAviso()
	
	case "delAviso"
		  delAviso()
		
     case "cerrarAviso"
		  cerrarAviso()
		  
	case "InsertCintaBitacora"
		 InsertCintaBitacora()

 	case "DelCintaBitacora"
		 DelCintaBitacora()

  	case "getPlanData"
		 getPlanData()
				
	case "updatePlanData"
		updatePlanData()
		
	case "listAvisos"
		  listAvisos()
	
			
	case "listAvisosLy"
		  listAvisosLy()
		  
	case "listAvisosInd"
		  listAvisosInd()
		  	  
	case "ListBitacoraID"
		  ListBitacoraID()
				  	  
	case "ListIncidentes"
		ListIncidentes()
		
	case "ListIncidentesOT"
		ListIncidentesOT()
		
end select

function newAviso()

	query = "SELECT MAX(ID) AS N FROM BITACORAS"
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO BITACORAS (ID, FECHA,  RESPONSABLE, "
	query = query & " DESCRIPCION, ESTADO, TIPO_TURNO, EQUIPO,  "
	query = query & " UBICACION, RECOMENDACION, CAUSA, "
	query = query & " GSAP, IND_INCIDENTE,  USERDATE, USERNAME) VALUES ("
	query = query & N & "," 
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(ESTADO) & ","
	query = query & strNvl(TIPO_TURNO) & ","
	query = query & strNvl(EQUIPO) & ","
	query = query & strNvl(UBICACION) & ","
	query = query & strNvl(TRATAMIENTO) & ","
	query = query & strNvl(CAUSA) & ","
	query = query & strNvl(GSAP) & ", 'FALSE', GETDATE(), " & strNvl(USERNAME) & ")"
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	
	query = "SELECT TOP 1 ID FROM BITACORAS "
	
	Set ORs =oDB.EjecutaSql(query)
	
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

function updateAviso()

	query = "UPDATE BITACORAS SET FECHA = " & strNvl(FECHA) & ","
	'query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ","
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "RECOMENDACION=" & strNvl(TRATAMIENTO) & ","
	query = query & "COLOR=" & strNvl(COLOR) & ","
	query = query & "CRITICIDAD=" & strNvl(CRITICIDAD) & ","
	query = query & "TIPO_TURNO=" & strNvl(TIPO_TURNO) & ","
	query = query & "EQUIPO=" & strNvl(EQUIPO) & ","
	query = query & "UBICACION=" & strNvl(UBICACION) & ","
	query = query & "IND_SOLUCION=" & strNvl(IND_SOLUCION) & ","
	query = query & "GSAP=" & strNvl(GSAP) & ","
	query = query & "CAUSA=" & strNvl(CAUSA) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE ID=" & ID 
	
	Set ORs =oDB.EjecutaSql(query)
	
		query = "UPDATE CHECK_EQUIPOS SET " 
		query = query & "  VALOR="  & strNvl(VALOR)
		query = query & " WHERE BITACORA = " & strNvl(ID)
		Set ORs =oDB.EjecutaSql(query)


	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" 
	Response.Write "<ID>" & ID & "</ID>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function getAviso()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA,"
	query = query & " B.TIPO_TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.EQUIPO, E.DESCRIPCION AS DESC_EQUIPO,"
	query = query & " B.REPORT, B.CRITICIDAD, B.TIPO_TURNO,  "
	query = query & " B.DANO, B.PRIORIDAD, B.IND_DANO, "
	query = query & " B.CAUSA, B.RECOMENDACION, B.COLOR, B.IND_SOLUCION, B.GSAP, E.TIPO_EQUIPO "
	query = query & " FROM BITACORAS AS B "
	query = query & " LEFT OUTER JOIN EQUIPOS AS E "
	query = query & " ON B.EQUIPO = E.CODIGO"
	query = query & " WHERE ID=" & ID 


	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='UTF-8'?>" & VbCrLf & VbCrLf
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
 		  Response.Write "<CAUSA>" & ORs.Fields.Item(15).Value & "</CAUSA>"
		  Response.Write "<TRATAMIENTO>" & ORs.Fields.Item(16).Value & "</TRATAMIENTO>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(17).Value & "</COLOR>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(18).Value & "</IND_SOLUCION>"
		  Response.Write "<GSAP>" & ORs.Fields.Item(19).Value & "</GSAP>"
		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(20).Value & "</TIPO_EQUIPO>"
		 
		  SELECT CASE ORs.Fields.Item(17).Value
		  	CASE "ALTA" 
			 Response.Write "<IMG_EST>mg/importancia_alta.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Importancia Alta</IMG_TEXT>"
			CASE "MEDIA" 
			 Response.Write "<IMG_EST>mg/importancia_media.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Importancia Media</IMG_TEXT>"
			CASE "BAJA" 
			 Response.Write "<IMG_EST>mg/importancia_baja.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Importancia Baja</IMG_TEXT>"
			 
		  END SELECT 
		  
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listAvisos()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + rtrim(convert(char,b.userdate,114))  "
	query = query & "  as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipalFaena(B.EQUIPO,'" & UBICACION & "'),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E1 ON DBO.EQUIPOPRINCIPALFaena(B.EQUIPO,'" & UBICACION & "') = E1.CODIGO "
	query = query & "  AND E1.UBICACION = B.UBICACION"
	query = query & " INNER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " WHERE B.UBICACION=" & strNvl(UBICACION)
	query = query & " 		AND  B.DESCRIPCION IS NOT NULL "
	
	
	If RESPONSABLE<>"TOD" AND LEN(RESPONSABLE)>0 Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
If LEN(ID)>0  Then
			query = query & " AND B.ID IN (" & ID & ")"
	else
	
		If IND_SOLUCION="FALSE"  Then
			query = query & " AND (B.IND_SOLUCION IS NULL OR B.IND_SOLUCION ='FALSE') "
		End if
	
		If LEN(COMPONENTE)>0  Then
			query = query & " AND E.TIPO_EQUIPO IN (" & COMPONENTE & ")"
		End if
	
		If LEN(ESTADO)>0  Then
			query = query & " AND B.ESTADO=" & strNvl(ESTADO)
	End if
	
	If LEN(EQUIPO)>0  Then
		query = query & " AND ( B.EQUIPO=" & strNvl(EQUIPO)
		query = query & " OR E.COD_EQUIPO_PADRE = " & strNvl(EQUIPO) & ") "
	End if

	If EQUIPO_PRI<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPALFaena(B.EQUIPO, " & strNvl(UBICACION) & ")=" & strNvl(EQUIPO_PRIN)
		
	ELSE
			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
			End if
	End if
	
	
End if
	
	
	
		
	query = query & " GROUP BY E1.SECUENCIA, B.ID, B.FECHA, TURNO, B.RESPONSABLE, "
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO, B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR , b.userdate"
	query = query & " ORDER BY convert(datetime, B.FECHA) desc    "
	
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
		Response.Write "<?xml-stylesheet  type='text/xsl' href='avisos.xsl?'?>" & VbCrLf & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='UTF-8' ?>" & VbCrLf & VbCrLf
		'Response.Write "<?xml-stylesheet  type='text/xsl' href='http://www.vitcomz.com/simma/script/avisos.xsl'?>"
	END IF
	
	Response.Write "<REGISTROS>" & query
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
		  Response.Write "<TIPO_TURNO>" & ORs.Fields.Item(7).Value & "</TIPO_TURNO>"
		 
		  SELECT CASE ORs.Fields.Item(10).Value
				CASE "ALTA" 
				Response.Write "<IMG_EST>mg/importancia_alta.gif</IMG_EST>"
				Response.Write "<IMG_TEXT>Importancia Alta</IMG_TEXT>"
				CASE "MEDIA" 
				Response.Write "<IMG_EST>mg/importancia_media.gif</IMG_EST>"
				Response.Write "<IMG_TEXT>Importancia Media</IMG_TEXT>"
				CASE "BAJA" 
				Response.Write "<IMG_EST>mg/importancia_baja.gif</IMG_EST>"
				Response.Write "<IMG_TEXT>Importancia Baja</IMG_TEXT>"
		 
	 	 END SELECT 
		  
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
		  Response.Write "<TRATAMIENTO>" & ORs.Fields.Item(15).Value & "</TRATAMIENTO>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
		  
		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(20).Value & "</EJECUTOR>" 
		 
			
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		 
		  If Not oRsFiles.EOF Then
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>/sgm/files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				Else
		  			Response.Write "<FILE>/sgm/files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
					  Response.Write "<FILEPR>/sgm/files/" & ORsFiles.Fields.Item(0).Value & "</FILEPR>"
				End If
		  Else
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../mg/noImage.jpg</FILE>"
				Else
		  			Response.Write "<FILE>mg/noImage.jpg</FILE>"
				End If
				
		  End If 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function listAvisosLy()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.CAUSA as color, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipalFaena(B.EQUIPO,'" & UBICACION & "'),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E1 ON DBO.EQUIPOPRINCIPALFaena(B.EQUIPO,'" & UBICACION & "') = E1.CODIGO "
	query = query & "  AND E1.UBICACION = B.UBICACION"
	query = query & " INNER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " WHERE B.UBICACION=" & strNvl(UBICACION)
	query = query & " 		AND  B.DESCRIPCION IS NOT NULL "
	query = query & " AND (B.IND_SOLUCION IS NULL OR B.IND_SOLUCION ='FALSE') "

		If LEN(COMPONENTE)>0  Then
			query = query & " AND E.TIPO_EQUIPO IN (" & COMPONENTE & ")"
		End if
	
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPALFaena(B.EQUIPO, " & strNvl(UBICACION) & ")=" & strNvl(EQUIPO_PRIN)
  
	End if
	
	query = query & " GROUP BY E1.SECUENCIA, B.ID, B.FECHA, TURNO, B.RESPONSABLE, "
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " ORDER BY B.ESTADO  "
	
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
		Response.Write "<?xml-stylesheet  type='text/xsl' href='avisos.xsl?'?>" & VbCrLf & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
		'Response.Write "<?xml-stylesheet  type='text/xsl' href='http://www.vitcomz.com/simma/script/avisos.xsl'?>"
	END IF
	
	Response.Write "<REGISTROS>" & query
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
		  Response.Write "<TIPO_TURNO>" & ORs.Fields.Item(7).Value & "</TIPO_TURNO>"
		 
		  
		  SELECT CASE ORs.Fields.Item(5).Value
		  	CASE "1" 
			 Response.Write "<IMG_EST>mg/importancia_alta.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Alta</IMG_TEXT>"
			CASE "2" 
			 Response.Write "<IMG_EST>mg/importancia_media.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Media</IMG_TEXT>"
			CASE "3" 
			  Response.Write "<IMG_EST>mg/importancia_baja.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Criticidad Baja</IMG_TEXT>"
			CASE "4" 
			 Response.Write "<IMG_EST>mg/importancia_nula.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Buen Estado</IMG_TEXT>"
			 
		  END SELECT 
		  
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
		  Response.Write "<TRATAMIENTO>" & ORs.Fields.Item(15).Value & "</TRATAMIENTO>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
		  
		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(20).Value & "</EJECUTOR>" 
		 
			
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		 
		  If Not oRsFiles.EOF Then
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				Else
		  			Response.Write "<FILE>files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				End If
		  Else
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../mg/noImage.jpg</FILE>"
				Else
		  			Response.Write "<FILE>mg/noImage.jpg</FILE>"
				End If
				
		  End If 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function listAvisosInd()

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.CAUSA as color, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipalFaena(B.EQUIPO,'" & UBICACION & "'),"
	query = query & " RECOMENDACION, B.COLOR, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E1 ON DBO.EQUIPOPRINCIPALFaena(B.EQUIPO,'" & UBICACION & "') = E1.CODIGO "
	query = query & "  AND E1.UBICACION = B.UBICACION"
	query = query & " INNER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " INNER JOIN SECCIONES AS A ON E1.SECCION = A.CODIGO AND A.FAENA=" & strNvl(UBICACION)
	query = query & " WHERE B.UBICACION=" & strNvl(UBICACION)
	query = query & " 		AND  B.DESCRIPCION IS NOT NULL "
	
	'If Len(HIST)=0 THEN
		query = query & " AND (B.IND_SOLUCION IS NULL OR B.IND_SOLUCION ='FALSE') "
	'END IF


	If LEN(COMPONENTE)>0  Then
	
		SELECT CASE COMPONENTE
			CASE "Chutes"
				query = query & " AND E.TIPO_EQUIPO IN (5)"
			CASE "Cinta"
				query = query & " AND E.TIPO_EQUIPO IN (2)"
			CASE "Empalme"
				query = query & " AND E.TIPO_EQUIPO IN (4,13)"
			CASE "Guarderas"
				query = query & " AND E.TIPO_EQUIPO IN (6)"
				
			CASE "Poleas"
				query = query & " AND E.TIPO_EQUIPO IN (7,15, 16, 17,18)"
				
			CASE "Polines"
				query = query & " AND E.TIPO_EQUIPO IN (8)"
			CASE "Raspadores"
				query = query & " AND E.TIPO_EQUIPO IN (11)"
				
			CASE "Tramos"
				query = query & " AND E.TIPO_EQUIPO IN (3)"
					
		END SELECT
			
	End if
	
	If LEN(AREA)>0  Then
			query = query & " AND A.DESCRIPCION IN (" & strNvl(AREA) & ")"
	End if
	
	
	If EQUIPO<>"TOD" AND LEN(EQUIPO)>0 Then
		query = query & " AND B.EQUIPO=" & strNvl(EQUIPO)
  
	End if
	
	If EQUIPO_PRIN<>"TOD" AND LEN(EQUIPO_PRIN)>0 Then
		query = query & " AND DBO.EQUIPOPRINCIPALFaena(B.EQUIPO,'" & UBICACION & "')=" & strNvl(EQUIPO_PRIN)
  
	End if
	
	If  LEN(CRITICIDAD)>0 Then
		query = query & " AND dbo.getCriticidadInt(B.COLOR)=" & strNvl(CRITICIDAD)
  
	End if
	
	query = query & " GROUP BY E1.SECUENCIA, B.ID, B.FECHA, TURNO, B.RESPONSABLE, "
	query = query & " B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.COLOR, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " ORDER BY B.ESTADO  "
	
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
		Response.Write "<?xml-stylesheet  type='text/xsl' href='avisos.xsl?'?>" & VbCrLf & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf
		'Response.Write "<?xml-stylesheet  type='text/xsl' href='http://www.vitcomz.com/simma/script/avisos.xsl'?>"
	END IF
	
	Response.Write "<REGISTROS>" & query
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
		  Response.Write "<TIPO_TURNO>" & ORs.Fields.Item(7).Value & "</TIPO_TURNO>"
		 
		  
		  SELECT CASE ORs.Fields.Item(5).Value
		  	CASE "1" 
			 Response.Write "<IMG_EST>mg/importancia_alta.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Alta</IMG_TEXT>"
			CASE "2" 
			 Response.Write "<IMG_EST>mg/importancia_media.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Media</IMG_TEXT>"
			CASE "3" 
			  Response.Write "<IMG_EST>mg/importancia_baja.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Criticidad Baja</IMG_TEXT>"
			CASE "4" 
			 Response.Write "<IMG_EST>mg/importancia_nula.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Buen Estado</IMG_TEXT>"
			 
		  END SELECT 
		  
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(9).Value & "</IND_DANO>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(11).Value & "</CAUSA>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(12).Value & "</IND_SOLUCION>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(13).Value & "</DIAS>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(14).Value & "</EQUIPO_PRIN>"
		  Response.Write "<TRATAMIENTO>" & ORs.Fields.Item(15).Value & "</TRATAMIENTO>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(16).Value & "</CRITICIDAD>" 
		  
		  Response.Write "<GCODE>" & ORs.Fields.Item(17).Value & "</GCODE>" 
		  Response.Write "<X>" & ORs.Fields.Item(18).Value & "</X>" 
		  Response.Write "<Y>" & ORs.Fields.Item(19).Value & "</Y>" 
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(20).Value & "</EJECUTOR>" 
		 
			
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		 
		  If Not oRsFiles.EOF Then
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>/files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				Else
		  			Response.Write "<FILE>/sgm/files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				End If
		  Else
		  		If EXCEL = "YES" Then
					Response.Write "<FILE>../mg/noImage.jpg</FILE>"
				Else
		  			Response.Write "<FILE>images/noDisponible.jpg</FILE>"
				End If
				
		  End If 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"
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
	Response.Write "<REGISTROS>" & query
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
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function


function InfSemInspec()

	query = "SELECT ID,"
	query = query & "rtrim(convert(char,B.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,B.fecha,108),1,5) as FECHA"
	query = query & ", TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, E.TIPO_EQUIPO,"
	query = query & " RECOMENDACION, B.UBICACION,  DBO.EquipoPrincipal(B.EQUIPO) "
	query = query & " FROM BITACORAS AS B, EQUIPOS_USUARIOS AS EU, EQUIPOS AS E "
	'query = query & " WHERE MONTH(FECHA)=" & MES
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " AND  DBO.EquipoPrincipal(B.EQUIPO) = EU.EQUIPO AND B.IND_SOLUCION <> 'true'"
	query = query & " AND  EU.USUARIO=" & strNvl(USUARIO)
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	query = query & " AND  B.EQUIPO=E.CODIGO" 
	
	If RESPONSABLE<>"TOD" Then
		query = query & " AND B.RESPONSABLE =" & strNvl(RESPONSABLE)
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
	
	If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
	End if
			
	query = query & " GROUP BY ID,"
	query = query & " B.FECHA, TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, "
	query = query & " E.TIPO_EQUIPO, B.RECOMENDACION, B.UBICACION "
	query = query & " ORDER BY convert(char,B.fecha,101) DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/Inspecciones.xsl?x=32324'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
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
		  Response.Write "<FECHA_INI>" & FECHA_INI & "</FECHA_INI>"
		  Response.Write "<FECHA_FIN>" & FECHA_FIN & "</FECHA_FIN>"
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value, ORs.Fields.Item(12).Value)
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
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InfDiaA.xsl?x=44'?>" & VbCrLf & VbCrLf & VbCrLf
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infInspecciones.xsl'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" ' & query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  'Response.Write "<COLOR>" & ORs.Fields.Item(1).Value & "</COLOR>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(2).Value & "</DESC_EQUIPO>"
		  
		  Set oRsDesc = getDescripciones(TERMINO, FAENA, ORs.Fields.Item(0).Value) 
		   ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION 
		  
		  sRECOMENDACION=" "
		  sREPORT =""
		  While Not oRsDesc.EOF
		  		Response.Write "<DESCRIP>" 
		  		Response.Write "<ID>" &  oRsDesc.Fields.Item(0).Value & "</ID> "
				Response.Write "<FECHA>" & oRsDesc.Fields.Item(1).Value & "</FECHA>" 
				Response.Write "<DESCRIPCION>" & oRsDesc.Fields.Item(2).Value & "</DESCRIPCION>" 
				Response.Write "<EQUIPO>" & oRsDesc.Fields.Item(3).Value & "</EQUIPO>" 
				Response.Write "<COLOR>" & oRsDesc.Fields.Item(4).Value & "</COLOR>" 
				'Response.Write "<RECOMENDACION>" & oRsDesc.Fields.Item(5).Value & "</RECOMENDACION>"
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
	'Response.Write "<sql>" & query & "</sql>"
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
	query = query & " FROM BITACORAS AS B, EQUIPOS AS E"
	query = query & " WHERE B.FECHA<=" & strNvl(FECHA)  
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	query = query & " AND  B.EQUIPO=E.CODIGO "
	
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
	'strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	END IF
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf & VbCrLf
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infInspecciones.xsl?x=47'?>" & VbCrLf & VbCrLf
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
		  While Not oRsChk.EOF
		  		Response.Write "<FALLAS>" 
		  		Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
				Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR
				oRsChk.MoveNext
				Response.Write "</FALLAS>" 
		  Wend
		 
		 IF EXCEL<>"YES" THEN	
		  Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		  While Not oRsFiles.EOF
		  		Response.Write "<FILES>" 
		  		Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
				oRsFiles.MoveNext
				Response.Write "</FILES>" 
		  Wend
		 END IF
		  Response.Write "<FECHA_EMI>" & FECHA_EMI & "</FECHA_EMI>"
		  Response.Write "<RECOMENDACION>" & RECOMENDACION & "</RECOMENDACION>"
		  Response.Write "</ROW>"
	 
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function getFiles(Bitacora)

    query = "SELECT RTRIM(A.ID) + '.' +  A.EXT  AS FILENAME FROM ARCHIVOS AS A "
	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
	'query = query & " AND A.FAMILIA='BITACORAS' "
	
	Set getFiles =oDB.EjecutaSql(query)

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

Function getDescripciones(Fecha, Faena, Equipo) ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION

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
	query = query & " WHERE CONVERT(DATETIME,(CONVERT(CHAR,FECHA,103))) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN)
	query = query & " AND UBICACION=" & strNvl(FAENA)
	
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


function getEquipo()

Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
	
exit function
  
	query = "SELECT E.CODIGO, E.ESTADO, E.DESCRIPCION, E.HOROMETRO, E.HOROMETRO_MAN, "
	query = query & " E.HOROMETRO_VEN, E.HOROMETRO_ALARM, E.DESC_PADRE, E.SISTEMA, E.CIUDAD, E.TIPO_HOROMETRO, "
	query = query & " E.HOROMETRO_PADRE, E.CAPACIDAD,  E.PROVEEDOR, E.VIDA_UTIL, E.UBICACION, CONVERT(CHAR,E.FECHA,103),"
	query = query & " E.ESCALA, E.ESCALA_ALARM, CONVERT(CHAR,E.FECHA_ULT_MAN,103), E.COD_EQUIPO_PADRE,"
	query = query & " P.NOMBRE AS DESC_PROVEEDOR, E.GSAP, E.OBSERVACION, "
	query = query & " E.CRITICIDAD, E.RESPONSABLE, E.TIPO_EQUIPO, "
	query = query & " E.SERIE, E.SECCION, E.VALOR_NETO, E.PROPIETARIO, E.DIMENSIONES, "
	query = query & " E.MARCA, E.MODELO, TE.DESCRIPCION, E.FECHA_INSTALACION, E.ANCHO,"
	query = query & " E.ESPESOR, E.TON_SEMANAL, E.ESPESOR_R "
	query = query & "FROM "
	query = query & "  (SELECT E.*, Equipos.DESCRIPCION AS DESC_PADRE "
	query = query & "  FROM EQUIPOS AS E LEFT JOIN Equipos ON E.COD_EQUIPO_PADRE = Equipos.CODIGO "
	query = query & "  WHERE E.CODIGO=" & strNvl(CODIGO) & " AND E.UBICACION=" & strNvl(FAENA) & ") AS E "
	query = query & " LEFT OUTER JOIN TIPO_EQUIPOS AS TE ON E.TIPO_EQUIPO = TE.CODIGO "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(1).Value & "</ESTADO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
  		  Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_MAN>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<HOROMETRO_ALARM>" & ORs.Fields.Item(6).Value & "</HOROMETRO_ALARM>"
	      Response.Write "<EQUIPO_PADRE>" & ORs.Fields.Item(7).Value & "</EQUIPO_PADRE>"
		  Response.Write "<ID_SISTEMA>" & ORs.Fields.Item(8).Value & "</ID_SISTEMA>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(9).Value & "</CIUDAD>"
		  Response.Write "<TIPO_HOROMETRO>" & ORs.Fields.Item(10).Value & "</TIPO_HOROMETRO>"
		  Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(11).Value & "</HOROMETRO_PADRE>" 
  		  Response.Write "<CAPACIDAD>" & ORs.Fields.Item(12).Value & "</CAPACIDAD>" 
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(13).Value & "</RUT_PROVEEDOR>"
		  Response.Write "<VIDA_UTIL>" & ORs.Fields.Item(14).Value & "</VIDA_UTIL>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(15).Value & "</UBICACION>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(16).Value & "</FECHA>"
  		  Response.Write "<ESCALA>" & ORs.Fields.Item(17).Value & "</ESCALA>"
   		  Response.Write "<ESCALA_ALARM>" & ORs.Fields.Item(18).Value & "</ESCALA_ALARM>"
   		  Response.Write "<FECHA_ULT_MAN>" & ORs.Fields.Item(19).Value & "</FECHA_ULT_MAN>"
  		  Response.Write "<COD_EQUIPO_PADRE>" & ORs.Fields.Item(20).Value & "</COD_EQUIPO_PADRE>"
  		  Response.Write "<NOMBRE_PROVEEDOR>" & ORs.Fields.Item(21).Value & "</NOMBRE_PROVEEDOR>"
		  Response.Write "<GSAP>" & ORs.Fields.Item(22).Value & "</GSAP>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(23).Value & "</OBSERVACION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(24).Value & "</CRITICIDAD>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(25).Value & "</RESPONSABLE>"
		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(26).Value & "</TIPO_EQUIPO>"
		  Response.Write "<SERIE>" & ORs.Fields.Item(27).Value & "</SERIE>"
		  Response.Write "<SECCION>" & ORs.Fields.Item(28).Value & "</SECCION>"
		  Response.Write "<VALOR_NETO>" & ORs.Fields.Item(29).Value & "</VALOR_NETO>"
		  Response.Write "<PROPIETARIO>" & ORs.Fields.Item(30).Value & "</PROPIETARIO>"
		  Response.Write "<DIMENSIONES>" & ORs.Fields.Item(31).Value & "</DIMENSIONES>"
		  Response.Write "<MARCA>" & ORs.Fields.Item(32).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(33).Value & "</MODELO>"
		  Response.Write "<DESC_TIPO_EQUIPO>" & ORs.Fields.Item(34).Value & "</DESC_TIPO_EQUIPO>"
		  Response.Write "<FECHA_INST>" & ORs.Fields.Item(35).Value & "</FECHA_INST>"
		  Response.Write "<ANCHO>" & ORs.Fields.Item(36).Value & "</ANCHO>"
		  Response.Write "<ESPESOR>" & ORs.Fields.Item(37).Value & "</ESPESOR>"
		  Response.Write "<TON_SEMANAL>" & ORs.Fields.Item(38).Value & "</TON_SEMANAL>"
		  Response.Write "<ESPESOR_R>" & ORs.Fields.Item(39).Value & "</ESPESOR_R>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function



function delAviso()

	query = "INSERT INTO jrojas.ELIMINADOS (ID, EQUIPO, FECHA, RESPONSABLE, DESCRIPCION, RECOMENDACION, CAUSA, ESTADO, CRITICIDAD, "
	query = query & " USERNAME_1, USERDATE_1, USERNAME, USERDATE) "
	query = query & " SELECT ID, EQUIPO, FECHA, RESPONSABLE, DESCRIPCION, RECOMENDACION, CAUSA, IND_SOLUCION, ESTADO, " 
	query =	query & " USERNAME, USERDATE, '" & USERNAME & "', GETDATE() FROM BITACORAS "
	query = query & " WHERE ID=" & ID
	Set ORs =oDB.EjecutaSql(query)

	query = "DELETE BITACORAS WHERE ID=" & ID
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
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


function cerrarAviso()

	query = "SELECT  ESTADO, IND_SOLUCION "
	query = query & " FROM BITACORAS AS B "
	query = query & " WHERE EQUIPO= ( SELECT EQUIPO FROM BITACORAS "
	query = query & " WHERE ID=" & ID & ")"
	query = query & " AND IND_SOLUCION IS NULL AND ID != " & ID 
	query = query & " ORDER BY ESTADO "   
	 
	Set ORs =oDB.EjecutaSql(query)
	
	IF not  ORs.eof THEN
	
		ESTADO = ORs.Fields.Item(0).Value
	else
		ESTADO =3
	
	End If
	
	query = "UPDATE EQUIPOS SET CRITICIDAD=" & ESTADO  
	query = query & " WHERE CODIGO=" & strNvl(EQUIPO) 
	query = query & " AND UBICACION = " & strNvl(UBICACION) 
	
	Set ORs =oDB.EjecutaSql(query)
	
 
	
	query = "UPDATE BITACORAS SET  "
	query = query & "IND_SOLUCION='TRUE'," 
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ""
	query = query & " WHERE ID=" & ID 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
		  Response.Write "<ID>OK</ID>"
	  Response.Write "</ROW>"
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
	query = query & " B.CAUSA, B.RECOMENDACION, B.COLOR, B.IND_SOLUCION, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B LEFT OUTER JOIN EQUIPOS AS E "
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

