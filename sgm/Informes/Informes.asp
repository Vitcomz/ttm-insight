<!--#include virtual="/sgm/standard/DBConn.asp" -->

<%
Dim query, ID
Dim oDB
Set oDB = New DBConn


RECURSO=REQUEST("RECURSO")
EXCEL=REQUEST("EXCEL")
BITACORAS=UCASE(REQUEST("BITACORAS"))
CODIGO=UCASE(REQUEST("CODIGO"))
CONDICION=UCASE(REQUEST("CONDICION"))
CRITICIDAD=UCASE(REQUEST("CRITICIDAD"))
COLOR=UCASE(REQUEST("COLOR"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
EQUIPOS=UCASE(REQUEST("EQUIPOS"))
TIPO=UCASE(REQUEST("TIPO"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
IND_SOLUCION=UCASE(REQUEST("IND_SOLUCION"))
INICIO=UCASE(REQUEST("INICIO"))
ID=UCASE(REQUEST("ID"))
TERMINO=UCASE(REQUEST("TERMINO"))
REPORT=UCASE(REQUEST("REPORT"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
NUM=UCASE(REQUEST("NUM"))
USUARIO=UCASE(REQUEST("USUARIO"))
ESTADO=UCASE(REQUEST("ESTADO"))
DESCRIPCION=REQUEST("DESCRIPCION")
FAENA=REQUEST("FAENA")
FOLIO=REQUEST("FOLIO")
SECCION=REQUEST("SECCION")
SECCION_DES=REQUEST("SECCION_DES")

select case RECURSO
			

	case "infDiario"
		 infDiario()

	case "newInfDiario"
		  newInfDiario()
	
	case "getInfDiario"
		  getInfDiario()
		  
	case "updateInfDiario"
		updateInfDiario()
	
	case "updateCriticidad2"
		  updateCriticidad2()
			   
	case "HistorialMan"
		HistorialMan()
		
	case "infMoviles"
		 infMoviles()
	
	case "infPlanificacion"
		 infPlanificacion()
		 
	case "infComponentes"
			infComponentes()
		 
	case "ListEquiposMan"
		  ListEquiposMan()
	
	case "listInformesDia"
		  listInformesDia()
	
	case "listEquipos"
		listEquipos()
		
	case "listBitDia"
		  listBitDia()
		
	case "grListEquipos"
		grListEquipos()
		
	case "ListEquiposManCro"
		ListEquiposManCro()
		
	case "listEqCriticidad"
		listEqCriticidad()
		
	case "listEqCriticidadHist"
		listEqCriticidadHist()
		
	case "EquiposxManCorr"
		EquiposxManCorr()
		
	case "CriticidadPie"
		CriticidadPie()
	
	case "fechasCriticidad"
		  fechasCriticidad()
		
	case "backupCriticidad"
		  backupCriticidad()
	
	case "InfInspecciones"
			InfInspecciones()

	case "ListReportCorreas"
			ListReportCorreas()	

	case "ListReportDiario"
			ListReportDiario()	
				
end select

function newInfDiario()

	query = "SELECT MAX(FOLIO) AS NUM FROM INFORMES WHERE FAENA= " & strNvl(FAENA) 
	
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO INFORMES  (" 
	query = query & " INFORME, "
	query = query & " FOLIO, "
	query = query & " FECHA, RESPONSABLE, IDS, FAENA, USERDATE, USERNAME) "
	query = query & " VALUES ('INFDIARIO'," & strNvl(N) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(USUARIO) & ","
	query = query & strNvl(BITACORAS) & ","
	query = query & strNvl(FAENA) & ", GETDATE(), " & strNvl(USUARIO) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & N & "</ROW>"
	'Response.Write query'
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function infMoviles()

	query = "SELECT B.EQUIPO,  DBO.EquipoPrincipal(B.EQUIPO), E.DESCRIPCION " 
	query = query & "  FROM BITACORAS AS B, EQUIPOS AS E, SECCIONES AS S, EQUIPOS AS EP "
	query = query & "  WHERE  B.UBICACION=" & strNvl(FAENA) 
	query = query & "  AND DBO.SecEquipoPrincipal(E.CODIGO)=S.CODIGO"
	query = query & "  AND DBO.EquipoPrincipal(B.EQUIPO)=EP.CODIGO"
	query = query & "  AND DBO.EquipoPrincipal(B.EQUIPO) IN (" & EQUIPOS & ")"
	query = query & "  AND B.EQUIPO=E.CODIGO AND B.IND_SOLUCION <> 'true' "
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
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InfDiaA.xsl'?>" & VbCrLf & VbCrLf & VbCrLf
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infInspecciones.xsl'?>" & VbCrLf & VbCrLf'
	Response.Write "<REGISTROS>"  '& query'
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  'Response.Write "<COLOR>" & ORs.Fields.Item(1).Value & "</COLOR>"'
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(2).Value & "</DESC_EQUIPO>"
		  
		  Set oRsDesc = getDescripciones(TERMINO, FAENA, ORs.Fields.Item(0).Value) 
		   ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION '
		  
		  sRECOMENDACION=""
		  sREPORT =""
		  While Not oRsDesc.EOF
		  		Response.Write "<DESCRIP>" 
		  		Response.Write "<ID>" &  oRsDesc.Fields.Item(0).Value & "</ID> "
				Response.Write "<FECHA>" & oRsDesc.Fields.Item(1).Value & "</FECHA>" 
				Response.Write "<DESCRIPCION>" & oRsDesc.Fields.Item(2).Value & "</DESCRIPCION>" 
				Response.Write "<EQUIPO>" & oRsDesc.Fields.Item(3).Value & "</EQUIPO>" 
				Response.Write "<COLOR>" & oRsDesc.Fields.Item(4).Value & "</COLOR>" 
				Response.Write "<RECOMENDACION>" & oRsDesc.Fields.Item(5).Value & "</RECOMENDACION>"
				Response.Write "<REPORT>" & oRsDesc.Fields.Item(6).Value & "</REPORT>"
				sREPORT = oRsDesc.Fields.Item(6).Value + " "
				sRECOMENDACION = sRECOMENDACION + oRsDesc.Fields.Item(5).Value + " "
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

function getFiles(Bitacora)

    query = "SELECT (RTRIM(CAST(A.ID AS CHAR)) + '.' + CAST(A.EXT AS CHAR)) AS FILENAME FROM ARCHIVOS AS A "
	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
	query = query & " AND A.FAMILIA='BITACORAS' "
	
	Set getFiles =oDB.EjecutaSql(query)

end Function


function getDescripciones(Fecha, Faena, Equipo) ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION'

	query = "SET DATEFORMAT DMY SELECT B.ID, RTRIM(CONVERT(CHAR,B.FECHA,103)) AS FECHA, B.DESCRIPCION, B.EQUIPO, "
	query = query & "  B.COLOR, B.RECOMENDACION, B.REPORT, B.CAUSA "
	query = query & "  FROM BITACORAS AS B, EQUIPOS AS E "
	query = query & "  WHERE "
	query = query & "   B.UBICACION=" & strNvl(Faena)
	query = query & "  AND B.EQUIPO=E.CODIGO "
	query = query & "  AND B.IND_SOLUCION <> 'true' AND B.EQUIPO=" & strNvl(Equipo) 
	query = query & "  GROUP BY B.ID,B.FECHA, B.DESCRIPCION, B.EQUIPO, "
	query = query & "  B.COLOR, B.RECOMENDACION, B.REPORT "
	query = query & "  ORDER BY DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO"
	 
	Set getDescripciones =oDB.EjecutaSql(query)
	
end Function


function InfOT()

	 query = "SELECT V.FOLIO_OT, V.FECHA_EJECUCION, V.TIPO, V.COD_EQUIPO, V.DESC_EQUIPO, "
 	 query = query & " V.TURNO, V.RESPONSABLE, V.FECHA_PROGRAMADA, "
  	 query = query & " V.ESTADO, V.OBSERVACION, I.ID, I.DESCRIPCION "
	 query = query & " FROM VI_OT_EQUIPO AS V "
	 query = query & " LEFT OUTER JOIN VI_INCIDENTES_OT AS I ON V.FOLIO_OT = I.FOLIO_OT"
	 
 	 If TIPO="COR" Then
	  	 query = query & " WHERE  V.TIPO='COR'"
	 End If
	 
	 If TIPO="PRE" Then
	  	 query = query & " WHERE  V.TIPO='PRE'"
	 End If

	  	 query = query & " AND V.ESTADO =" & strNvl(ESTADO)
	 
 	Set ORs =oDB.EjecutaSql(query)
	
	 Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?'
	strName = strName & ".xls"
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Folio OT</TD>"
   				   Response.Write "<TD>Fecha</TD>"
   				   Response.Write "<TD>Tipo</TD>"
   				   Response.Write "<TD>Equipo</TD>"
   				   Response.Write "<TD>Turno</TD>"
   				   Response.Write "<TD>Supervisor</TD>"
   				   Response.Write "<TD>Programada</TD>"
   				   Response.Write "<TD>Estado</TD>"
  				   Response.Write "<TD>Observaci�n</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & " " & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<TIPO>" & ORs.Fields.Item(2).Value & "</TIPO>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(3).Value & " " & _
		  				 ORs.Fields.Item(4).Value & "</EQUIPO>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(5).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
  		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(7).Value & "</FECHA_PROGRAMADA>"
		  
		  Select Case ORs.Fields.Item(8).Value 
	  			Case "PRO"
			   		  Response.Write "<ESTADO>PROGRAMADA</ESTADO>"
  	  			Case "EJE"
			   		  Response.Write "<ESTADO>EJECUTADA</ESTADO>"
   	  			Case "PEN"
			   		  Response.Write "<ESTADO>PENDIENTE</ESTADO>"
  	  			Case "NUL"
			   		  Response.Write "<ESTADO>ANULADA</ESTADO>"
		  End Select

  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
   		  Response.Write "<ID_INCIDENTE>" & ORs.Fields.Item(10).Value & "</ID_INCIDENTE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(11).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	End If
	Set ORs = Nothing
	Set ODB = Nothing
end function

function HistorialMan()

	 query = "SELECT V.FOLIO_OT, V.FECHA_EJECUCION, V.TIPO, V.COD_EQUIPO, V.DESC_EQUIPO, "
 	 query = query & " V.TURNO, V.RESPONSABLE, V.FECHA_PROGRAMADA, "
  	 query = query & " V.OBSERVACION, I.ID, I.DESCRIPCION "
	 query = query & " FROM VI_OT_EQUIPO AS V "
	 query = query & " LEFT OUTER JOIN VI_INCIDENTES_OT AS I ON V.FOLIO_OT = I.FOLIO_OT"
	 
  	 query = query & " WHERE  V.COD_EQUIPO=" & strNvl(EQUIPO)

	 
 	Set ORs =oDB.EjecutaSql(query)
	
	 Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?'
	strName = strName & ".xls"
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Folio OT</TD>"
   				   Response.Write "<TD>Fecha</TD>"
   				   Response.Write "<TD>Tipo</TD>"
   				   Response.Write "<TD>Equipo</TD>"
   				   Response.Write "<TD>Turno</TD>"
   				   Response.Write "<TD>Supervisor</TD>"
   				   Response.Write "<TD>Programada</TD>"
  				   Response.Write "<TD>Observaci�n</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & " " & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<TIPO>" & ORs.Fields.Item(2).Value & "</TIPO>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(3).Value & " " & _
		  				 ORs.Fields.Item(4).Value & "</EQUIPO>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(5).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
  		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(7).Value & "</FECHA_PROGRAMADA>"  
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(8).Value & "</OBSERVACION>"
   		  Response.Write "<ID_INCIDENTE>" & ORs.Fields.Item(9).Value & "</ID_INCIDENTE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(10).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	End If
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListEquiposMan()

	 query = "SELECT CODIGO, DESCRIPCION, FECHA_ULT_MAN, HOROMETRO, "
	 query = query & " HOROMETRO_VEN, DIFERENCIA, FOLIO_OT, PRIORIDAD "
  	 query = query & " FROM VI_EQUIPOS_MAN AS V LEFT OUTER JOIN "
   	 query = query & " (SELECT FOLIO_OT, EQUIPO, ESTADO FROM OT WHERE ESTADO IN ('PEN') AND TIPO='PRE') AS OT "
   	 query = query & " ON V.CODIGO = OT.EQUIPO"
	 query = query & " ORDER BY CODIGO "
	Set ORs =oDB.EjecutaSql(query)
	
if EXCEL="YES" then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=EquiposEnRiesgo" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Codigo</TD>"
   				   Response.Write "<TD>Descripci�n</TD>"
   				   Response.Write "<TD>Ultima Mantenci�n</TD>"
   				   Response.Write "<TD>Horometro Actual</TD>"
   				   Response.Write "<TD>Vencimiento</TD>"
   				   Response.Write "<TD>Horas de Atraso</TD>"	
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value &"</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
		  If ORs.Fields.Item(6).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
  		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(7).Value & "</PRIORIDAD>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	wend
	Response.Write "</REGISTROS>"
End If
	Set ORs = Nothing
	Set ODB = Nothing
End function

function listBitDia()

query = " SELECT ID, RTRIM(CONVERT(CHAR,FECHA, 103)), EQUIPO, COLOR, SUBSTRING(B.DESCRIPCION,0,40)+ '...', B.UBICACION "
query = query & " FROM BITACORAS AS B"
query = query & " WHERE (CONVERT(CHAR,ULT_INSPECCION, 103) =CONVERT(CHAR," & strNvl(FECHA) & ", 103)"
query = query & " OR CONVERT(CHAR,FECHA, 103) =CONVERT(CHAR," & strNvl(FECHA) & ", 103) )"
query = query & " AND B.UBICACION=" & strNvl(FAENA) 
query = query & " AND B.IND_SOLUCION IN ('FALSE',NULL,'false')  " 
query = query & " ORDER BY dbo.EquipoPrincipal(EQUIPO) " 

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	While Not ORs.EOF 
	   Response.Write "<ROWS>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<EQUIPO>" & ORs.Fields.Item(2).Value & "</EQUIPO>"
  		  Response.Write "<COLOR>" & ORs.Fields.Item(3).Value & "</COLOR>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(4).Value & "</DESCRIPCION>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(5).Value & "</UBICACION>"
	   Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing

End Function

function listInformesDia()

query = " SELECT FOLIO, FECHA, RESPONSABLE, IDS "
query = query & " FROM INFORMES AS I"
query = query & " WHERE FAENA=" & strNvl(FAENA) 
query = query & " ORDER BY FOLIO DESC " 

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query'
	While Not ORs.EOF 
	   Response.Write "<ROWS>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
  		  Response.Write "<IDS>" & ORs.Fields.Item(3).Value & "</IDS>"

	   Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing

End Function

function listEquipos()

	 query = "SELECT CODIGO, DESCRIPCION, E.FECHA_INSTALACION, E.FECHA_ULT_MAN,  "
	 query = query & " isNull((SUM(P.MINUTOS)/60)/24,0),isNull((SUM(P.MINUTOS)/60)/24,0),"
	 query = query & " DATEDIFF(dd,'" & FECHA_INI & "','" & FECHA_FIN & "')+1 "
	 query = query & " FROM EQUIPOS AS E"
	 query = query & " LEFT OUTER JOIN PARADAS AS P ON E.CODIGO=P.COMPONENTE "
	 query = query & " AND FECHA_INI BETWEEN '" & FECHA_INI & "' AND '" & FECHA_FIN & "'"
	 query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	 ' query = query & " AND DBO.SecEquipoPrincipal(CODIGO) IN (" & strNvl(SECCION) & ")"'
	 
	 If LEN(TIPO)>0 Then
	    query = query & " AND TIPO_EQUIPO=" & TIPO
	 End If
	 query = query & " GROUP BY CODIGO, DESCRIPCION, FECHA_INSTALACION, FECHA_ULT_MAN "
	 query = query & " ORDER BY CODIGO "
	 
	Set ORs =oDB.EjecutaSql(query)
	
If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Equipo</TD>"
   				   Response.Write "<TD>Fecha Instalaci�n</TD>"
   				   Response.Write "<TD>Fecha Ult. Mantenci�n</TD>"
   				   Response.Write "<TD>Total Fallas</TD>"
   				   Response.Write "<TD>Fallas OP.</TD>"	
				   Response.Write "<TD>Tiempo Calendario</TD>"	
				   Response.Write "<TD>Disponibiliad</TD>"
				   Response.Write "<TD>Utilizaci�n</TD>"
				   
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				 Response.Write "<TD>" & ORs.Fields.Item(0).Value & " " & ORs.Fields.Item(1).Value & "</TD>"
   		 		 Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   		 		 Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
				 Response.Write "<TD>" & ROUND(ORs.Fields.Item(4).Value,2) & "</TD>"
		 		 Response.Write "<TD>" & ROUND(ORs.Fields.Item(5).Value,2) & "</TD>"
		 		 Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
		 		 DISP = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100
 		 		 Response.Write "<TD>" & ROUND(DISP,2)& "</TD>"
		 		 UTIL = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100 
	  	 		 Response.Write "<TD>" & ROUND(UTIL,2) & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & " " & ORs.Fields.Item(1).Value & "</CODIGO>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
   		  Response.Write "<ULT_MAN>" & ORs.Fields.Item(3).Value & "</ULT_MAN>"
  		  Response.Write "<TIEMPO_MAN>" & ROUND(ORs.Fields.Item(4).Value,2) & "</TIEMPO_MAN>"
		  Response.Write "<TIEMPO_OP>" & ROUND(ORs.Fields.Item(5).Value,2) & "</TIEMPO_OP>"
		  Response.Write "<TIEMPO_TT>" & ORs.Fields.Item(6).Value & "</TIEMPO_TT>"
		  DISP = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100
 		  Response.Write "<DISPONIBILIDAD>" & ROUND(DISP,2)& "</DISPONIBILIDAD>"
		  UTIL = ((ORs.Fields.Item(6).Value-ORs.Fields.Item(5).Value)/ORs.Fields.Item(6).Value)*100 
	  	  Response.Write "<UTILIZACION>" & ROUND(UTIL,2) & "</UTILIZACION>"
	   Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
End If
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grListEquipos()

	 query = "SELECT dbo.EquipoPrincipal(CODIGO), E.FECHA_INSTALACION, E.FECHA_ULT_MAN,  "
	 query = query & " isNull((SUM(P.MINUTOS)/60)/24,0),isNull((SUM(P.MINUTOS)/60)/24,0),"
	 query = query & " DATEDIFF(dd,'" & FECHA_INI & "','" & FECHA_FIN & "')+1 "
	 query = query & " FROM EQUIPOS AS E"
	 query = query & " LEFT OUTER JOIN PARADAS AS P ON E.CODIGO=P.COMPONENTE "
	 query = query & " AND FECHA_INI BETWEEN '" & FECHA_INI & "' AND '" & FECHA_FIN & "'"
	 query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	 
	 If LEN(TIPO)>0 Then
	    query = query & " AND TIPO_EQUIPO=" & TIPO
	 End If
	 query = query & " GROUP BY dbo.EquipoPrincipal(CODIGO), FECHA_INSTALACION, FECHA_ULT_MAN "
	 query = query & " ORDER BY dbo.EquipoPrincipal(CODIGO) "
	 
	Set ORs =oDB.EjecutaSql(query)
	
Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Disponibilidad' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php' rotateLabels='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & ORs.Fields.Item(0).Value &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst
	
	Response.Write "<dataset seriesName='Disponibilidad'  showValues='1' color='99CC33'>" 
	While Not ORs.EOF 
		  DISP = ((ORs.Fields.Item(5).Value - ORs.Fields.Item(4).Value)/ORs.Fields.Item(5).Value)*100
  	 	  Response.Write "<set value='" & ROUND(DISP,2) & "' />"
		  ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function


function EquiposxManCorr()

query = "SELECT	B.ID AS BITACORA, E.CODIGO, E.DESCRIPCION, "  
query = query & " CONVERT(CHAR,B.FECHA,103), B.TURNO, OT.ELEMENTO, "
query = query &	"	B.RESPONSABLE, B.DESCRIPCION, "
query = query &	"		OT.FOLIO_OT, OT.ESTADO, OT.FECHA_EJECUCION "
query = query &	" FROM BITACORAS AS B, INCIDENTES_OT AS I_OT, "
query = query &	"	 OT AS OT, EQUIPOS AS E "
query = query &	" WHERE OT.FOLIO_OT = I_OT.FOLIO_OT "
query = query &	"	AND ID_INCIDENTE = B.ID "
query = query &	"	AND E.CODIGO = OT.EQUIPO "
query = query &	"	AND SUBSTRING(RTRIM(CONVERT(CHAR,B.FECHA,103)),7,4)='" & 2008 & "' "
query = query &	"	AND dbo.EquipoPrincipal(E.CODIGO)='" & CODIGO & "' "
query = query &	" ORDER BY B.FECHA DESC"

Set ORs =oDB.EjecutaSql(query)
	
If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=IncManCorrec.xls"
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Bitacora</TD>"
   				   Response.Write "<TD>Codigo Equipo</TD>"
   				   Response.Write "<TD>Descripci�n Equipo</TD>"
   				   Response.Write "<TD>Fecha Incidente</TD>"
   				   Response.Write "<TD>Turno</TD>"
   				   Response.Write "<TD>Elemento</TD>"
				   Response.Write "<TD>Responsable</TD>"
				   Response.Write "<TD>Descripci�n Incidente</TD>"
				   Response.Write "<TD>Folio OT</TD>"
				   Response.Write "<TD>Estado</TD>"	
				   Response.Write "<TD>Fecha Ejecuci�n</TD>"	
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value &"</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<COD_EQUIPO>" & ORs.Fields.Item(1).Value & "</COD_EQUIPO>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(2).Value & "</DESC_EQUIPO>"
   		  Response.Write "<FECHA_INC>" & ORs.Fields.Item(3).Value & "</FECHA_INC>"
   		  Response.Write "<TURNO>" & ORs.Fields.Item(4).Value & "</TURNO>"
   		  Response.Write "<ELEMENTO>" & ORs.Fields.Item(5).Value & "</ELEMENTO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(7).Value & "</DESCRIPCION>"
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(8).Value & "</FOLIO_OT>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(9).Value & "</ESTADO>"
		  Response.Write "<FECHA_EJECUCION>" & ORs.Fields.Item(10).Value & "</FECHA_EJECUCION>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
End If

	Set ORs = Nothing
	Set ODB = Nothing
end function	

function ListEquiposManCro()

	 query = "SELECT CODIGO, DESCRIPCION, FECHA_ULT_MAN, HOROMETRO, "
	 query = query & " HOROMETRO_VEN, DIFERENCIA, FOLIO_OT, PRIORIDAD "
  	 query = query & " FROM VI_EQUIPOS_MAN_CRO AS V LEFT OUTER JOIN "
   	 query = query & " (SELECT FOLIO_OT, EQUIPO, ESTADO FROM OT WHERE ESTADO IN ('PRO','PEN') AND TIPO='PRE') AS OT "
   	 query = query & " ON V.CODIGO = OT.EQUIPO"
	 query = query & " WHERE dbo.EquipoPrincipal(CODIGO)=" & strNvl(CODIGO) & " "
	 query = query & " ORDER BY DIFERENCIA DESC "

'	 query = query & " WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"'
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
		  If ORs.Fields.Item(6).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
  		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(7).Value & "</PRIORIDAD>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function infPlanificacion()

Dim COND
DIM ESTATUS

	query = " SELECT dbo.EquipoPrincipal(EQUIPO), CONDICION, ACCION, FECHA_PROGRAMADA,"
	query = query & "  REPORT, DESCRIPCION, STATUS, RECOMENDACION, CAUSA, COLOR,  CRITICIDAD  "
	query = query & "  FROM BITACORAS "
	query = query & "  WHERE CONDICION IS NOT NULL AND IND_SOLUCION <> 'TRUE' "
	query = query & "  AND UBICACION=" & strNvl(FAENA)
	query = query & "  AND CONDICION=" & strNvl(CONDICION)
 
 	Set ORs =oDB.EjecutaSql(query)
	
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=IncManCorrec.xls"
		 Response.Write "<TABLE BORDER=0><TR><TD><IMG SRC='..\images\pie.jpg'/></TD></TR></TABLE>"
		 Response.Write "<BR/><BR/><BR/><BR/><BR/><BR/><BR/>"
		 Response.Write "<TABLE BORDER=0><TR><TD><strong>PLANIFICACION DE TRABAJOS TTM CHILE</strong></TD></TR></TABLE>"
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD><strong>Equipo</strong></TD>"
   				   Response.Write "<TD><strong>Condici�n</strong></TD>"
   				   Response.Write "<TD><strong>Accion Requerida</strong></TD>"
   				   Response.Write "<TD><strong>Fecha Programada</strong></TD>"
   				   Response.Write "<TD><strong>Nro Aviso</strong></TD>"
   				   Response.Write "<TD><strong>Descripci�n del Problema</strong></TD>"
				   Response.Write "<TD><strong>Status</strong></TD>"
				   Response.Write "<TD><strong>Recomendaci�n</strong></TD>"
				   Response.Write "<TD><strong>Causa Raiz</strong></TD>"
				   Response.Write "<TD><strong>Criticidad</strong></TD>"	
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
				    SELECT CASE ORs.Fields.Item(1).Value
			  		Case "A"
					Response.Write "<TD style='background-color:#33CC00'>(A) NADA QUE HACER</TD>"
			  		Case "B"
					Response.Write "<TD style='background-color:#0033FF'>(B) MONITOREAR</TD> "
			  		Case "C"
					Response.Write "<TD style='background-color:#FFFF00'>(C) MANT. PROGRAMADA 2 SEMANAS</TD>"
					Case "D"
					Response.Write "<TD style='background-color:#FF9900'>(D) MANT. PROGRAMADA 1 SEMANA</TD>"
					Case "E"
					Response.Write "<TD style='background-color:#FF0000'>(E) ACCION INMEDIATA</TD>"
					Case "P"
					Response.Write "<TD style='background-color:#990000'>(P) PROGRAMADA PARADA PLANTA</TD>"
	  	   			END SELECT
		   
   				 
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value &"</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
				   
				   SELECT CASE ORs.Fields.Item(6).Value
			  	Case "1"
					ESTATUS = "INFORMADO A MANTENIMIENTO"
			  	Case "2"
					ESTATUS = "MONITOREO"
	  	  			 END SELECT
		   
				   Response.Write "<TD>" & ESTATUS & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
				   
				   SELECT CASE ORs.Fields.Item(9).Value
			  		Case "ALTA"
						Response.Write "<TD style='background-color:#FF0000'>" & ORs.Fields.Item(9).Value & " " & ORs.Fields.Item(10).Value & "%</TD>"
			  		Case "MEDIA"
						Response.Write "<TD style='background-color:#FFFF00'>" & ORs.Fields.Item(9).Value & " " & ORs.Fields.Item(10).Value & "%</TD> "
			  		Case "BAJA"
						Response.Write "<TD style='background-color:#00FF33'>" & ORs.Fields.Item(9).Value & " " & ORs.Fields.Item(10).Value & "%</TD>"
	
	  	   			END SELECT
									   
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  
		  SELECT CASE ORs.Fields.Item(1).Value
			  	Case "A"
					COND = "(A) NADA QUE HACER"
			  	Case "B"
					COND = "(B) MONITOREAR "
			  	Case "C"
					COND = "(C) MANT. PROGRAMADA 2 SEMANAS"
				Case "D"
					COND = "(D) MANT. PROGRAMADA 1 SEMANA"
				Case "E"
					COND = "(E) ACCION INMEDIATA"
				Case "P"
					COND = "(P) PROGRAMADA PARADA PLANTA"
					
	  	   END SELECT
	  
		  Response.Write "<CONDICION>" & COND & "</CONDICION>"
   		  Response.Write "<ACCION>" & ORs.Fields.Item(2).Value & "</ACCION>"
   		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(3).Value & "</FECHA_PROGRAMADA>"
   		  Response.Write "<AVISO>" & ORs.Fields.Item(4).Value & "</AVISO>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(5).Value & "</DESCRIPCION>"
		  
		   SELECT CASE ORs.Fields.Item(6).Value
			  	Case "1"
					ESTATUS = "INFORMADO A MANTENIMIENTO"
			  	Case "2"
					ESTATUS = "MONITOREO"
	  	   END SELECT
		   		   
		  Response.Write "<ESTATUS>" & ESTATUS & "</ESTATUS>"
  		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(7).Value & "</RECOMENDACION>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(8).Value & "</CAUSA>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(9).Value & " " & ORs.Fields.Item(10).Value & "%</CRITICIDAD>"
		  
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	End If
	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

function infComponentes()

Dim CONDICION
DIM ESTATUS
Dim FECHA

	query = " SELECT DBO.EQUIPOPRINCIPAL(E.CODIGO), COUNT(DBO.EQUIPOPRINCIPAL(E.CODIGO)), E.CODIGO, ISNULL(B.COLOR,'BAJA') "
	query = query & " ,CONVERT(CHAR, E.FECHA_ULT_MAN, 103), ISNULL(B.DESCRIPCION, 'Componente en buen estado'), B.CAUSA "
	query = query & " FROM EQUIPOS AS E"
	query = query & " LEFT OUTER JOIN "
	query = query & " (SELECT B.EQUIPO, B.COLOR, B.DESCRIPCION, B.CAUSA"
	query = query & " 				FROM BITACORAS AS B"
	query = query & " 				WHERE B.IND_SOLUCION='FALSE') AS B ON B.EQUIPO=E.CODIGO  "
	query = query & "  WHERE  E.TIPO_EQUIPO = " & strNvl(TIPO) & "AND E.UBICACION=" & strNvl(FAENA)
	query = query & " AND E.ESTADO='ACT' "
	query = query & " GROUP BY E.CODIGO, B.COLOR, E.SECUENCIA, E.FECHA_ULT_MAN , B.DESCRIPCION, B.CAUSA "
	query = query & " ORDER BY E.SECUENCIA"
	
 	Set ORs =oDB.EjecutaSql(query)
	
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=IncManCorrec.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no'?>" 
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf'
	END IF
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"  
		  Response.Write "<COUNT>" & ORs.Fields.Item(1).Value  & "</COUNT>"
   		  Response.Write "<COMPONENTE>" & ORs.Fields.Item(2).Value & "</COMPONENTE>"
   		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(3).Value & "</CRITICIDAD>"
   		  Response.Write "<ULT_MAN>" & ORs.Fields.Item(4).Value & "</ULT_MAN>"
		  
		 'FECHA = CDATE(ISNULL(ORs.Fields.Item(4).Value,"01/01/2007"))'
		  IF ISNULL(ORs.Fields.Item(4).Value) THEN
		  	FECHA = ""
		  ELSE
		  	FECHA = ROUND ((NOW() - CDATE(ORs.Fields.Item(4).Value))/30,1)  
		  END IF
		  
		  Response.Write "<DURACION>" &  FECHA & "</DURACION>"
		  
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(5).Value & "</DESCRIPCION>"
		  Response.Write "<CAUSA>" & ORs.Fields.Item(6).Value & "</CAUSA>"
		  
		  
		  
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

function listEqCriticidad()
		
	Set Cn =  oDB.Conexion
	Dim ORs
	
	STR = "exec DBO.Criticidad @FECHA = " & strNvl(FECHA) 
	STR = STR & ", @FAENA=" & strNvl(FAENA)
   	' Set ORs = Cn.Execute (STR)'
	'response.write STR
	'response.end
   	Set ORs = Server.CreateObject("ADODB.Recordset")
   	ORs.CursorLocation = 3 
	ORs.Open STR, Cn, 1,1
	'Set ORs =oDB.EjecutaSql(STR)'
	
	ORs.Sort="VALOR DESC "
		'Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
   		  Response.Write "<COLOR>" & ORs.Fields.Item(2).Value & "</COLOR>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function fechasCriticidad()

query = " select convert(varchar, fecha, 103) "
query = query & " from historial_criticidad group by fecha order by fecha desc"

Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<FECHA>" & ORs.Fields.Item(0).Value & "</FECHA>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function empalmes()

	query = " SELECT T.EQUIPO, T.COMPONENTE, B.FECHA, B.DESCRIPCION FROM ( "
 	query = query & " SELECT   DBO.EQUIPOPRINCIPAL(E1.CODIGO) AS EQUIPO,  E1.CODIGO AS COMPONENTE, E.SECUENCIA"
	query = query & "  FROM  EQUIPOS AS E1, EQUIPOS AS E "
	query = query & "  WHERE E1.TIPO_EQUIPO=23  AND DBO.EQUIPOPRINCIPAL(E1.CODIGO)=E.CODIGO"
 	query = query & " AND E1.UBICACION='SPENCE' AND LEN(E1.CODIGO)>9) AS T"
 	query = query & " LEFT OUTER JOIN BITACORAS AS B ON T.COMPONENTE = B.EQUIPO"
	query = query & " AND B.IND_SOLUCION='false'"
 	query = query & "  ORDER BY T.SECUENCIA"


	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listEqCriticidadHist()
		
	query = " select equipo, criticidad, color "
	query = query & " from historial_criticidad " 
	query = query & " where convert(varchar, fecha, 103) = "  & strNvl(FECHA)
	query = query & " and faena = " & strNvl(FAENA)
	query = query & " order by criticidad desc"
	
   	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
   		  Response.Write "<COLOR>" & ORs.Fields.Item(2).Value & "</COLOR>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function backupCriticidad()
		
	Set Cn =  oDB.Conexion
	Dim ORs
	
	STR = "exec DBO.backupCriticidad " 
	
   	' Set ORs = Cn.Execute (STR)'
   	Set ORs = Server.CreateObject("ADODB.Recordset")
   	ORs.CursorLocation = 3 
	ORs.Open STR, Cn, 1,1
	'Set ORs =oDB.EjecutaSql(STR)'
	
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
 
	Response.Write "<ROWS>" 
		  Response.Write "<EQUIPO>ok</EQUIPO>"
	Response.Write "</ROWS>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function CriticidadPie()

Set Cn =  oDB.Conexion
	Dim ORs
	
	STR = "exec DBO.Criticidad @FECHA = " & strNvl(FECHA) 
	STR = STR & ", @FAENA=" & strNvl(FAENA)
   	' Set ORs = Cn.Execute (STR)
   	Set ORs = Server.CreateObject("ADODB.Recordset")
   	ORs.CursorLocation = 3 
	ORs.Open STR, Cn, 1,1
	'Set ORs =oDB.EjecutaSql(STR)
	
	ORs.Sort="VALOR DESC "
	
	ALTA=0
	MEDIA=0
	BAJA=0
	C=0

	While Not ORs.EOF 
	  If ORs.Fields.Item(2).Value = "ALTA" Then
	  				ALTA=ALTA +1 
	  End If
	  If ORs.Fields.Item(2).Value = "MEDIA" Then
	  				MEDIA=MEDIA +1 
	  End If
	  If ORs.Fields.Item(2).Value = "BAJA" Then
	  				BAJA=BAJA +1 
	  End If
	  C=C+1
	  ORs.MoveNext
	Wend

	Set ORs = Nothing
	Set ODB = Nothing
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' showPercentageValues='1' caption='Criticidad de Equipos' shownames='1' showvalues='1' showSum='1' decimals='1' overlapBars='1' showShadow='1' bgColor='99CCFF,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' showBorder='1' startingAngle='70'>"

		 
		 	Response.Write "<set color='FF0000' label='ALTA' value='" & ALTA / C & "' isSliced='1'/>" 
		 	Response.Write "<set color='FFFF00' label='MEDIA' value='" & MEDIA / C & "' isSliced='1'/>"  
			Response.Write "<set color='3366FF' label='BAJA' value='" & BAJA / C & "' isSliced='1'/>"  

	Response.Write "</chart>" 
	Set ORs = Nothing
	Set oDB = Nothing
end function

function InfInspecciones()

	query = "SELECT B.ID, B.EQUIPO,  DBO.EquipoPrincipal(B.EQUIPO), "
	query = query & " E.DESCRIPCION, EP.DESCRIPCION, EP.CRITICIDAD, B.COLOR " 
	query = query & " FROM BITACORAS AS B, EQUIPOS AS E, SECCIONES AS S, EQUIPOS AS EP "
	'query = query & "  WHERE CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) <= " & strNvl(TERMINO)'
	query = query & " WHERE   B.UBICACION=" & strNvl(FAENA) 
	query = query & "  AND DBO.SecEquipoPrincipal(B.EQUIPO)=S.CODIGO"
	query = query & "  AND DBO.EquipoPrincipal(B.EQUIPO)=EP.CODIGO"	
	query = query & "  AND B.EQUIPO=E.CODIGO AND E.UBICACION=B.UBICACION AND B.IND_SOLUCION <> 'true' "
	
	If Len(TIPO)>0 THEN
		If TIPO=17 THEN
			query = query & "  AND EP.TIPO_EQUIPO=" & strNvl(TIPO)
		Else
			query = query & " AND E.TIPO_EQUIPO=" & strNvl(TIPO)
		End If
	END IF
	
	If Len(SECCION)>0 THEN
			query = query & " AND EP.SECCION=" & strNvl(SECCION)
	END IF
	
	If EQUIPO<>"TOD" THEN
			query = query & " AND EP.CODIGO=" & strNvl(EQUIPO)
	END IF
	
	IF CRITICIDAD<>"TOD" THEN
		IF CRITICIDAD = "MEDALTA" THEN
			query = query & " AND B.COLOR IN ('MEDIA','ALTA')"
		ELSE
			query = query & " AND B.COLOR IN (" & strNvl(CRITICIDAD) & ")"
		END IF
	END IF
	
	query = query & "  GROUP BY B.ID, B.EQUIPO, DBO.EquipoPrincipal(B.EQUIPO), "
	query = query & "  E.DESCRIPCION, EP.DESCRIPCION, EP.CRITICIDAD, B.COLOR "
	query = query & "  ORDER BY DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO"	
	
	Set ORs =oDB.EjecutaSql(query)
	response.write query
	response.end 
		
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator? '
	strName = strName & ".xls"
	
	IF EXCEL="YES" THEN	
		
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no'?>" 
		
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
		
	END IF
	
'	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/Inspecciones2.xsl?x=44'?>"  & VbCrLf & VbCrLf
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/infInspecciones.xsl'?>" & VbCrLf & VbCrLf '
	Response.Write "<REGISTROS>" ' & query '
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(1).Value & "</EQUIPO>"
		  Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(2).Value & "</EQUIPO_PRIN>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(3).Value & "</DESC_EQUIPO>"
		  Response.Write "<DESC_EQUIPO_PRIN>" & ORs.Fields.Item(4).Value & "</DESC_EQUIPO_PRIN>"

				
		  Set oRsDesc = getDescripciones(ORs.Fields.Item(0).Value, FAENA, ORs.Fields.Item(1).Value) 
		   ' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION '
		  
		  sRECOMENDACION=" "
		  sCAUSA=" "
		  sREPORT =""
		  While Not oRsDesc.EOF
		  		Response.Write "<DESCRIP>" 
		  		Response.Write "<ID>" &  oRsDesc.Fields.Item(0).Value & "</ID> "
				Response.Write "<FECHA>" & oRsDesc.Fields.Item(1).Value & "</FECHA>" 
				Response.Write "<DESCRIPCION>" & oRsDesc.Fields.Item(2).Value & "</DESCRIPCION>" 
				Response.Write "<EQUIPO>" & oRsDesc.Fields.Item(3).Value & "</EQUIPO>" 
				'Response.Write "<RECOMENDACION>" & oRsDesc.Fields.Item(5).Value & "</RECOMENDACION>"'
				Response.Write "<REPORT>" & oRsDesc.Fields.Item(6).Value & "</REPORT>"
							
				Response.Write "<CRITICIDAD_EQUIPO>" & oRs.Fields.Item(5).Value & "</CRITICIDAD_EQUIPO>"
		  		Response.Write "<COLOR>" & oRs.Fields.Item(6).Value & "</COLOR>" 
		  
				sREPORT = sREPORT & oRsDesc.Fields.Item(6).Value & " "
				sRECOMENDACION = sRECOMENDACION & oRsDesc.Fields.Item(5).Value & " "
				sCAUSA = sCAUSA & oRsDesc.Fields.Item(7).Value & " "
				
				if EXCEL<>"YES" then	
					Set oRsFiles = getFiles(oRsDesc.Fields.Item(0).Value)
					if Not oRsFiles.EOF then
						Response.Write "<FILES>" 
						While Not oRsFiles.EOF
							'Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"'
							IF Not oRsFiles.EOF THEN
								Response.Write "<FILE>/sgm/Informes/imagen.aspx?image=/sgm/Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
							ELSE
								Response.Write "<FILE>/sgm/Informes/imagen.aspx?image=/sgm/images/noDisponible.png</FILE>"
							END IF
'							Response.Write "<FILE> /sgm/Informes/imagen.aspx?image=/sgm/Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"	
							oRsFiles.MoveNext
						Wend
						Response.Write "</FILES>" 
					end if
		  		end if 
				oRsDesc.MoveNext
				Response.Write "</DESCRIP>" 
		  Wend
		  
		  
		   Response.Write "<RECOMENDACION>" & sRECOMENDACION & "</RECOMENDACION>"
		   Response.Write "<REPORT>" & sREPORT & "</REPORT>"
		   Response.Write "<CAUSA>" & sCAUSA & "</CAUSA>"
		   Response.Write "<INICIO>" & INICIO & "</INICIO>"
		   Response.Write "<TERMINO>" & TERMINO & "</TERMINO>"
		   Response.Write "<NUM>" & NUM & "</NUM>"
		   Response.Write "<FOLIO_OT>" & FOLIO_OT & "</FOLIO_OT>"
		   Response.Write "<PLANTA>" & PLANTA & "</PLANTA>"
		   	If Len(SECCION)>0 THEN
				Response.Write "<SECCION_DES>" & SECCION_DES & "</SECCION_DES>"
			ELSE
				Response.Write "<SECCION_DES>TODAS</SECCION_DES>"
			END IF
			Response.Write "<FECHA_IMP>" & MID(NOW(),1,10) & "</FECHA_IMP>"
		  Response.Write "</ROW>"
	  
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function infDiario()

	query = "SELECT ID,"
	query = query & "rtrim(convert(char,B.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,B.fecha,108),1,5) as FECHA"
	query = query & ", TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, E.TIPO_EQUIPO,"
	query = query & " RECOMENDACION, B.UBICACION,  DBO.EquipoPrincipalFaena(B.EQUIPO, " & strNvl(FAENA) & "),"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), CRITICIDAD2, B.REPORT, EP.DESCRIPCION, E.DESCRIPCION "
	query = query & " FROM BITACORAS AS B, EQUIPOS AS E, EQUIPOS AS EP "
	query = query & " WHERE  B.IND_SOLUCION <> 'true'"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA) & " "
	query = query & " AND  EP.UBICACION=" & strNvl(FAENA) & " "
	query = query & " AND  B.EQUIPO=E.CODIGO AND DBO.EquipoPrincipalFaena(B.EQUIPO, " & strNvl(FAENA) & ") = EP.CODIGO "
	query = query & " AND E.UBICACION=EP.UBICACION 	" 
	query = query & " AND B.ID IN (" & BITACORAS & ")"

	
	If LEN(TIPO)>0 Then
		query = query & " AND E.TIPO_EQUIPO =" & strNvl(TIPO)
	End if
	
			
	query = query & " GROUP BY ID,"
	query = query & " B.FECHA, TURNO, B.RESPONSABLE,"
	query = query & " B.DESCRIPCION, B.ESTADO, IND_INCIDENTE, TIPO_TURNO, B.EQUIPO,"
	query = query & " B.IND_DANO, B.COLOR, B.CAUSA, "
	query = query & " E.TIPO_EQUIPO, B.RECOMENDACION, B.UBICACION, EP.SECUENCIA, B.CRITICIDAD2, B.REPORT, "
	query = query & " EP.DESCRIPCION, E.DESCRIPCION "
	query = query & " ORDER BY DBO.EquipoPrincipalFaena(B.EQUIPO, " & strNvl(FAENA) & "), B.CRITICIDAD2"
	
	Set ORs =oDB.EjecutaSql(query)
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=diario.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no'?>" & VbCrLf
		'Response.Write "<?xml-stylesheet type='text/xsl' href='http://www.ttminsight.cl/sgm/Informes/InspDiarias.xsl'?>" & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf
		'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf'
	END IF
	
	Response.Write "<REGISTROS>"' & query '
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
		  Response.Write "<DESC_EQ_PRINCIPAL>" & ORs.Fields.Item(19).Value & "</DESC_EQ_PRINCIPAL>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(5).Value & "</ESTADO>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(6).Value & "</IND_INCIDENTE>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(8).Value & "</EQUIPO>"
		  Response.Write "<COMPONENTE>" & ORs.Fields.Item(20).Value & "</COMPONENTE>"
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
		  
		  Set oRsChk = getChecklist(ORs.Fields.Item(0).Value, ORs.Fields.Item(12).Value)
		  sFALLA=""
		  if EXCEL<>"YES" then
		  		Response.Write "<FALLAS>" 
				  if  Not oRsChk.EOF then
					  While Not oRsChk.EOF
						Response.Write "<DESC_FALLA>" &  oRsChk.Fields.Item(1).Value & "</DESC_FALLA> "
						Response.Write "<VALOR_FALLA>" & oRsChk.Fields.Item(3).Value & "</VALOR_FALLA>" 'vbCR'
						oRsChk.MoveNext
					  Wend
				  end if
				Response.Write "</FALLAS>" 
			end if
		  
	   Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
	   Set oRsHistorial = getHistorial(ORs.Fields.Item(0).Value)
	   aHistorial=""
	   While Not oRsHistorial.EOF
	   
	   		SELECT CASE oRsHistorial.Fields.Item(2).Value
				   CASE 1 
				   		Status_ = "DISMINUYE"
				   CASE 2
				   		Status_ = "MANTIENE "
				   CASE 3
				   		Status_ = "AUMENTA"
			END SELECT
			
	 	aHistorial = aHistorial & oRsHistorial.Fields.Item(1).Value & " " &  Status_ & "&#13;"
		oRsHistorial.MoveNext
	   
	   Wend
		
	   
	   Response.Write "<HISTORIAL>" & aHistorial & "</HISTORIAL>"
	   
	   Response.Write "<CRITICIDAD_2>" & ORs.Fields.Item(17).Value & "</CRITICIDAD_2>"
	   Response.Write "<REPORT>" & ORs.Fields.Item(18).Value & "</REPORT>"
		if EXCEL<>"YES" then	
			IF Not oRsFiles.EOF THEN
				Response.Write "<FILE>/sgm/Informes/imagen.aspx?image=/sgm/Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
			ELSE
				Response.Write "<FILE>/sgm/Informes/imagen.aspx?image=/sgm/images/noDisponible.png</FILE>"
			END IF
		end if 
		  Response.Write "</ROW>"
	  
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getFiles(Bitacora)

    query = "SELECT (RTRIM(CAST(A.ID AS CHAR)) + '.' + CAST(A.EXT AS CHAR)) AS FILENAME FROM ARCHIVOS AS A "
	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
	query = query & " AND A.FAMILIA='BITACORAS' "
	
	Set getFiles =oDB.EjecutaSql(query)

End Function

function getHistorial(ID)

    query = "SELECT RTRIM(INSPECTOR), RTRIM(CONVERT(CHAR,FECHA,103)), STATUS FROM HISTORIAL_BITACORA "
	query = query & " WHERE ID = " & ID  
	query = query & " ORDER BY FECHA DESC "
	
	Set getHistorial =oDB.EjecutaSql(query)

End Function

function getInfDiario()
	
	query = "SELECT FOLIO, IDS, FECHA, RESPONSABLE FROM INFORMES "
	query = query & " WHERE INFORME='INFDIARIO' AND FOLIO = " & strNvl(FOLIO)
	query = query & " AND FAENA=" & strNvl(FAENA)
	 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query '
	
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<BITACORAS>" & ORs.Fields.Item(1).Value & "</BITACORAS>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing

End Function

function updateCriticidad2()
	
	query = "UPDATE BITACORAS SET "
	query = query & " CRITICIDAD2 = " & strNvl(CRITICIDAD) & " "
	query = query & " ,REPORT = " & strNvl(REPORT) & " "
	query = query & " WHERE ID = " & strNvl(ID)
	'query = query & " AND FAENA=" & strNvl(FAENA)'
	 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query '
	  	Response.Write "<ROWS>" 
		  Response.Write "<FOLIO>OK</FOLIO>"
		Response.Write "</ROWS>"

	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing

End Function

function updateInfDiario()
	
	query = "UPDATE INFORMES SET "
	query = query & " IDS = " & strNvl(BITACORAS) & ","
	query = query & " USERNAME = " & strNvl(USUARIO) & ", USERDATE = GETDATE()"  
	query = query & " WHERE INFORME='INFDIARIO' AND FOLIO = " & strNvl(FOLIO)
	query = query & " AND FAENA=" & strNvl(FAENA)
	 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query '
	
	  	Response.Write "<ROWS>" 
		  Response.Write "<FOLIO>OK</FOLIO>"
		Response.Write "</ROWS>"

	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing

End Function

function getChecklist(Id, TipoEquipo)

	query = "SELECT CHK.ID, CHK.DESCRIPCION, CHK_E.BITACORA , CHK_E.VALOR "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " LEFT OUTER JOIN CHECK_EQUIPOS AS CHK_E ON CHK_E.BITACORA=" & strNvl(Id)
	query = query & " 		AND CHK.ID = CHK_E.CHECKLIST "
	query = query & " WHERE TIPO_EQUIPO=" & TipoEquipo
	query = query & " AND CHK_E.VALOR<>0 "
	query = query & " ORDER BY ID"
	 
	Set getChecklist =oDB.EjecutaSql(query)
	

End Function

function getDescripciones(ID, Faena, Equipo) 
' ID, FECHA, B.DESCRIPCION, B.EQUIPO, B.COLOR, B.RECOMENDACION'

	query = "SET DATEFORMAT DMY SELECT B.ID, RTRIM(CONVERT(CHAR,B.FECHA,103)) AS FECHA, B.DESCRIPCION, B.EQUIPO, "
	query = query & "  B.COLOR, B.RECOMENDACION, B.REPORT, B.CAUSA "
	query = query & "  FROM BITACORAS AS B, EQUIPOS AS E "
	'query = query & "  WHERE CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) <= " & strNvl(TERMINO)'
	query = query & "  WHERE B.UBICACION=" & strNvl(Faena)
	query = query & "  AND B.ID = " & ID
	query = query & "  AND B.EQUIPO=E.CODIGO "
	query = query & "  AND B.IND_SOLUCION <> 'true' AND B.EQUIPO=" & strNvl(Equipo) 
	query = query & "  GROUP BY B.ID,B.FECHA, B.DESCRIPCION, B.EQUIPO, "
	query = query & "  B.COLOR, B.RECOMENDACION, B.REPORT, B.CAUSA "
	query = query & "  ORDER BY DBO.EquipoPrincipal(B.EQUIPO), B.EQUIPO"
	 
	Set getDescripciones =oDB.EjecutaSql(query)
	
End Function

function ListReportCorreas()

	query = " SELECT E.SECCION AREA, DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA)  & ") TAG_EQUIP , EC.LARGO AS LARGO_TOTAL, "
	query = query & "'T'+left(SUBSTRING(E.DESCRIPCION,CHARINDEX(' ',E.DESCRIPCION)+1,10),CHARINDEX(' ',SUBSTRING(E.DESCRIPCION,CHARINDEX(' ',E.DESCRIPCION)+1,10))) as TRA, "
	query = query & "B.CRITICIDAD2 AS STATUS_TRA, B.DESCRIPCION AS OBS_TRA ,  E.MARCA, E.MODELO, E.LARGO AS LARGO_TRA, MD1.VALOR as ESP_MAS_BAJO, MD1.FECHA FECHA_ULT_MEDICION, "
	query = query & "SUBSTRING(E2.CODIGO,CHARINDEX('EMP',E2.CODIGO)+3,3) EMP, B2.CRITICIDAD2 AS STATUS_EMP, B2.DESCRIPCION AS OBS_EMP, E2.FECHA_ULT_MAN AS FECH_CREAC_EMP, "
	query = query & "E2.LARGO AS LARGO_EMP FROM EQUIPOS AS E  LEFT JOIN ( "
	query = query & "SELECT UBICACION, EQUIPO, FECHA, CRITICIDAD2, DESCRIPCION, RANK() OVER (PARTITION BY UBICACION, EQUIPO ORDER BY FECHA DESC) AS LUGAR "
	query = query & "FROM BITACORAS WHERE UBICACION = " & strNvl(FAENA)  & " AND IND_SOLUCION = 'false') AS B on "
	query = query & "E.CODIGO = B.EQUIPO AND E.UBICACION = B.UBICACION AND B.LUGAR = 1 LEFT JOIN EQUIPOS AS E2 ON  "
	query = query & "DBO.EquipoPrincipalFaena(E.CODIGO, E.UBICACION) = DBO.EquipoPrincipalFaena(E2.CODIGO, E2.UBICACION) "
	query = query & "AND E.UBICACION = E2.UBICACION "
	query = query & "AND REPLACE(SUBSTRING(E.CODIGO,CHARINDEX('TRA',E.CODIGO)+3,2),'-','') = REPLACE(SUBSTRING(E2.CODIGO,CHARINDEX('EMP',E2.CODIGO)+3,2),'-','') "
	query = query & "AND E2.TIPO_EQUIPO = 23 AND E2.COD_EQUIPO_PADRE LIKE '%EMP%' LEFT JOIN EQUIPOS AS EC ON  "
	query = query & "DBO.EquipoPrincipalFaena(E.CODIGO, E.UBICACION) = DBO.EquipoPrincipalFaena(EC.CODIGO, EC.UBICACION) "
	query = query & "AND E.UBICACION = EC.UBICACION AND EC.CODIGO LIKE '%CIN'  LEFT OUTER JOIN ( "
	query = query & "SELECT UBICACION, EQUIPO, FECHA, CRITICIDAD2, DESCRIPCION, RANK() OVER (PARTITION BY UBICACION, EQUIPO ORDER BY FECHA DESC) AS LUGAR "
	query = query & "FROM BITACORAS WHERE UBICACION = " & strNvl(FAENA)  & " AND IND_SOLUCION = 'false'  "
    query = query & ") AS B2 on 	E.CODIGO = B2.EQUIPO AND E.UBICACION = B2.UBICACION AND B2.LUGAR = 1 "
    query = query & "LEFT JOIN (SELECT M.EQUIPO, M.FAENA, M.FECHA, MIN(MV.VALOR) AS VALOR, RANK() OVER (PARTITION BY M.FAENA, M.EQUIPO ORDER BY M.FECHA DESC) AS LUGAR "
	query = query & " FROM MEDICIONES M INNER JOIN MEDICIONES_VALOR MV ON M.FOLIO = MV.FOLIO "
	query = query & "WHERE M.FAENA = " & strNvl(FAENA)  & " AND MV.TIPO = 'CAR' AND MV.VALOR > 0 GROUP BY M.EQUIPO, M.FAENA,  M.FECHA "
    query = query & ") AS MD1 ON E.CODIGO = MD1.EQUIPO AND E.UBICACION = MD1.FAENA AND MD1.LUGAR = 1 "
	query = query & "WHERE 	E.ESTADO = 'ACT' 	AND E.COD_EQUIPO_PADRE LIKE '%TRA%'	AND E.UBICACION = " & strNvl(FAENA)  
	query = query & "AND E.TIPO_EQUIPO = 22 ORDER BY E.SECCION, DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA)  & ")"

	Set ORs =oDB.EjecutaSql(query)
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=informe_correas.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no'?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='http://www.ttminsight.cl/sgm/Informes/InspDiarias.xsl'?>" & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	END IF
	
	Response.Write "<REGISTROS>" '& query'
	While Not ORs.EOF
	   Response.Write "<ROW>" 
		  Response.Write "<AREA>" & ORs.Fields.Item(0).Value & "</AREA>"
   		  Response.Write "<TAG_EQUIP>" & ORs.Fields.Item(1).Value & "</TAG_EQUIP>"
   		  Response.Write "<LARGO_TOTAL>" & ORs.Fields.Item(2).Value & "</LARGO_TOTAL>"
  		  Response.Write "<TRA>" & ORs.Fields.Item(3).Value & "</TRA>"
		  Response.Write "<STATUS_TRA>" & ORs.Fields.Item(4).Value & "</STATUS_TRA>"
		  Response.Write "<OBS_TRA>" & ORs.Fields.Item(5).Value & "</OBS_TRA>"
		  Response.Write "<MARCA>" & ORs.Fields.Item(6).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(7).Value & "</MODELO>"
		  Response.Write "<LARGO_TRA>" & ORs.Fields.Item(8).Value & "</LARGO_TRA>"
		  Response.Write "<ESP_MAS_BAJO>" & ORs.Fields.Item(9).Value & "</ESP_MAS_BAJO>"
		  Response.Write "<FECHA_ULT_MEDICION>" & ORs.Fields.Item(10).Value & "</FECHA_ULT_MEDICION>"
'		  Response.Write "<FECHA_PROX_MEDICION_ESP>" & ORs.Fields.Item(11).Value & "</FECHA_PROX_MEDICION_ESP>"
		  Response.Write "<EMP>" & ORs.Fields.Item(11).Value & "</EMP>"
		  Response.Write "<STATUS_EMP>" & ORs.Fields.Item(12).Value & "</STATUS_EMP>"
		  Response.Write "<OBS_EMP>" & ORs.Fields.Item(13).Value & "</OBS_EMP>"
		  Response.Write "<FECH_CREAC_EMP>" & ORs.Fields.Item(14).Value & "</FECH_CREAC_EMP>"
		  Response.Write "<LARGO_EMP>" & ORs.Fields.Item(15).Value & "</LARGO_EMP>"
	   Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing

End Function

function ListReportDiario()

	fech = cdate("01/"& month(cdate(FECHA)) & "/" & year(cdate(FECHA))-2)
	fech2 = day(cdate(FECHA)) & "/"& month(cdate(FECHA)) & "/" & year(cdate(FECHA))	
	query = " SELECT   dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") AS EQUIPO, E.DESCRIPCION AS COMPONENTE,B.ID AS BITACORA, "
	query = query & "  B.REPORT AS AVISO, B.OT AS ORDEN, B.DESCRIPCION,  RECOMENDACION, B.COLOR as CRITICIDAD"
	query = query & "  FROM  EQUIPOS AS E LEFT JOIN BITACORAS AS B ON E.CODIGO = B.EQUIPO AND E.UBICACION = B.UBICACION"
	query = query & "  AND B.IND_SOLUCION = 'false' AND B.FECHA BETWEEN '" & fech & "' AND '" & fech2 & "'"
	query = query & "  WHERE E.ESTADO = 'ACT' AND E.UBICACION = " & strNvl(FAENA) & " AND dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") <> E.CODIGO"
	query = query & "  AND E.TIPO_EQUIPO IN (8,9,24,35,36,38,44,45) "
	if strNvl(SECCION) <> "NULL" then
		query = query & "  AND E.seccion in (" & SECCION & ")"
	end if
	if strNvl(EQUIPO) <> "NULL" then
		query = query & "  AND DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") in ("& EQUIPO &")"
	end if
	query = query & "  AND E.CODIGO NOT LIKE '%POL' AND E.CODIGO NOT LIKE '%PLI' "
	query = query & "  union "
	query = query & "  SELECT  dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") AS EQUIPO, CASE E.TIPO_EQUIPO WHEN 5 THEN 'CINTA'"
	query = query & "  WHEN 6 THEN 'GUALDERAS' WHEN 7 THEN 'CHUTE CARGA' WHEN 10 THEN 'RASPADORES' WHEN 22 THEN 'CINTA' WHEN 23 THEN 'CINTA' END AS COMPONENTE,"
	query = query & "  B.ID AS BITACORA, B.REPORT AS AVISO, B.OT AS ORDEN, B.DESCRIPCION,  RECOMENDACION, B.COLOR as CRITICIDAD"
	query = query & "  FROM  EQUIPOS AS E LEFT JOIN BITACORAS AS B ON E.CODIGO = B.EQUIPO AND E.UBICACION = B.UBICACION"
	query = query & "  AND B.IND_SOLUCION = 'false' AND B.FECHA BETWEEN '" & fech & "' AND '" & fech2 & "'"
	query = query & "  WHERE E.ESTADO = 'ACT' AND E.UBICACION = " & strNvl(FAENA) & " AND dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") <> E.CODIGO"
	query = query & "  AND E.TIPO_EQUIPO IN (5,6,7,10,22,23) "
	if strNvl(SECCION) <> "NULL" then
		query = query & "  AND E.seccion in (" & SECCION & ")"
	end if
	if strNvl(EQUIPO) <> "NULL" then
		query = query & "  AND DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") in ("& EQUIPO &")"
	end if
	query = query & "  GROUP BY dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & "), B.ID, CASE E.TIPO_EQUIPO WHEN 5 THEN 'CINTA'"
	query = query & "  WHEN 6 THEN 'GUALDERAS' WHEN 7 THEN 'CHUTE CARGA' WHEN 10 THEN 'RASPADORES' WHEN 22 THEN 'CINTA' WHEN 23 THEN 'CINTA' END,"
	query = query & "  B.REPORT, B.OT, B.DESCRIPCION,  RECOMENDACION, B.COLOR ORDER BY dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & "), COMPONENTE"
'response.write query 
'response.end
	Set ORs =oDB.EjecutaSql(query)
	IF EXCEL="YES" THEN	
		Response.Buffer = True
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=informe_diario.xls"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15' standalone='no'?>" 
		'Response.Write "<?xml-stylesheet type='text/xsl' href='http://www.ttminsight.cl/sgm/Informes/InspDiarias.xsl'?>" & VbCrLf
	ELSE
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	END IF

	eq = ""
	mvar = ""
	Response.Write "<REGISTROS>" '& query'
	While Not ORs.EOF
	   mvar = mvar & "<ROW>" 
		  mvar = mvar &  "<EQUIPO>" & trim(ORs.Fields.Item(0).Value) & "</EQUIPO>"
   		  mvar = mvar &  "<COMPONENTE>" & ORs.Fields.Item(1).Value & "</COMPONENTE>"
   		  mvar = mvar &  "<BITACORA>" & ORs.Fields.Item(2).Value & "</BITACORA>"
  		  mvar = mvar &  "<AVISO>" & ORs.Fields.Item(3).Value & "</AVISO>"
		  mvar = mvar &  "<ORDEN>" & ORs.Fields.Item(4).Value & "</ORDEN>"
		  mvar = mvar &  "<DESCRIPCION>" & ORs.Fields.Item(5).Value & "</DESCRIPCION>"
		  mvar = mvar &  "<RECOMENDACION>" & ORs.Fields.Item(6).Value & "</RECOMENDACION>"
		  mvar = mvar &  "<CRITICIDAD>" & ORs.Fields.Item(7).Value & "</CRITICIDAD>"
	   mvar = mvar &  "</ROW>"
	   'if eq = "" then
	   		eq = trim(ORs.Fields.Item(0).Value)
			comp = ORs.Fields.Item(1).Value
			bit =  ORs.Fields.Item(2).Value
	   	'end if
	  ORs.MoveNext
	  if not ORs.eof then
	  	if eq = trim(ORs.Fields.Item(0).Value) and comp = ORs.Fields.Item(1).Value and bit <> ORs.Fields.Item(2).Value and not isnull(bit) then
			response.write mvar
		elseif eq = trim(ORs.Fields.Item(0).Value) and comp <> ORs.Fields.Item(1).Value then
			response.write mvar
		elseif eq <> trim(ORs.Fields.Item(0).Value) and comp <> ORs.Fields.Item(1).Value then
			response.write mvar
		end if
	  elseif ORs.eof then
	  		response.write mvar
	  end if
	  mvar = ""
	Wend
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing

End Function

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

%>

