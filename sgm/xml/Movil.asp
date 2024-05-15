<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

RECURSO=REQUEST("RECURSO")
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


select case RECURSO
	case "GetBitacora"
		GetBitacora()
		
	case "NewBitacora"
		NewBitacora()
		
	
	case "ListBitacora"
		ListBitacora()
	
	case "ListBitacoraID"
		  ListBitacoraID()
		
	case "InfSemInspec"
	      InfSemInspec()
	
	
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
	query = query & " IND_SOLUCION, PRIORIDAD) VALUES ("
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

	query = "SELECT B.ID,"
	query = query & "rtrim(convert(char,b.fecha,103)) + ' ' + "
	query = query & " substring(convert(char,b.fecha,108),1,5) as FECHA, "
	query = query & " TURNO, B.RESPONSABLE,"
	query = query & " SUBSTRING(B.DESCRIPCION,0,40)+ '...', B.ESTADO, B.IND_INCIDENTE, B.TIPO_TURNO, "
	query = query & " B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION,"
	query = query & " DATEDIFF(d,B.FECHA,GETDATE()), DBO.EquipoPrincipal(B.EQUIPO),"
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, E.X, E.Y, B.EJECUTOR "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS_USUARIOS AS EU ON "
	query = query & " DBO.EquipoPrincipal(B.EQUIPO) = EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO)
	query = query & " INNER JOIN EQUIPOS AS E ON B.EQUIPO = E.CODIGO AND E.UBICACION = B.UBICACION "
	query = query & " WHERE (CONVERT(DATETIME,CONVERT(CHAR,B.FECHA,103)) BETWEEN " & strNvl(FECHA_INI)
	query = query & " AND " & strNvl(FECHA_FIN) & ")"
	query = query & " AND  B.UBICACION=" & strNvl(FAENA)
	
	
	If RESPONSABLE<>"TOD" AND LEN(RESPONSABLE)>0 Then
		query = query & " AND RESPONSABLE =" & strNvl(RESPONSABLE)
	End if
	
	If TIPO<>"TOD" Then
		query = query & " AND E.TIPO_EQUIPO=" & strNvl(TIPO)
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
		
	ELSE
			If SECCION<>"'TOD'" AND LEN(SECCION)>0 Then
				query = query & " AND DBO.SecEquipoPrincipal(B.EQUIPO) IN (" & SECCION & ")"
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
	
	
	query = query & " GROUP BY B.ID,B.FECHA, TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE,"
	query = query & " B.TIPO_TURNO,B.EQUIPO, B.IND_DANO, B.COLOR, B.CAUSA, B.IND_SOLUCION, "
	query = query & " RECOMENDACION, B.CRITICIDAD, E.GCODE, X, Y, EJECUTOR"
	query = query & " ORDER BY DBO.EQUIPOPRINCIPAL(B.EQUIPO), B.fecha DESC  "
	
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
	query = query & " E.TIPO_EQUIPO, B.RECOMENDACION, B.UBICACION, E.SECUENCIA "
	query = query & " ORDER BY E.SECUENCIA "
	
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
		  
	   Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
	   
	    While Not oRsFiles.EOF
			Response.Write "<FILES>"
		  		Response.Write "<FILE>../Files/" & ORsFiles.Fields.Item(0).Value & "</FILE>"
			Response.Write "</FILES>"
			oRsFiles.MoveNext
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
	
	Response.Write "<?xml version='1.0' encoding='iso-8859-1'?>"
	'Response.Write "<?xml-stylesheet type='text/xsl' href='../Informes/InspDiarias.xsl'?>" & VbCrLf & VbCrLf
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

    query = "SELECT (RTRIM(CAST(A.ID AS CHAR)) + '.' + CAST(A.EXT AS CHAR)) AS FILENAME FROM ARCHIVOS AS A "
	query = query & " WHERE A.IDENTIFICADOR = '" & Bitacora & "'" 
	query = query & " AND A.FAMILIA='BITACORAS' and A.EXT<>'pdf'"
	
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
	query = query & " B.CAUSA, B.RECOMENDACION, B.COLOR, B.IND_SOLUCION, B.EJECUTOR, B.ULT_INSPECCION "
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

	query = "UPDATE BITACORAS SET FECHA = " & strNvl(FECHA) & ","
	query = query & "TURNO=" & strNvl(TURNO) & ","
	query = query & "EJECUTOR=" & strNvl(EJECUTOR) & ","
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
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
	query = query & "CAUSA=" & strNvl(CAUSA) & ","
	query = query & "RECOMENDACION=" & strNvl(RECOMENDACION) & ","
	query = query & "IND_SOLUCION=" & strNvl(IND_SOLUCION) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ","
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

