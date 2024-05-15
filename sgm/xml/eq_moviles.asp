<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../standard/DBConn.asp" -->
<%
response.ContentType="text/HTML"
response.Charset="ISO-8859-1"
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

CODIGO=UCASE(REQUEST("CODIGO"))
RECURSO=REQUEST("RECURSO")
ID=REQUEST("ID")
FOLIO=REQUEST("FOLIO")
MES=REQUEST("MES")
ANO=REQUEST("ANO")
TIPO_EQUIPO=REQUEST("TIPO_EQUIPO")
SECCION=REQUEST("SECCION")
FAENA=REQUEST("FAENA")
PLANTA=REQUEST("PLANTA")
LINEA=REQUEST("LINEA")
PILA1=REQUEST("PILA1")
PILA2=REQUEST("PILA2")
SEC=REQUEST("SEC")
IND_OP=REQUEST("IND_OP")
USER=REQUEST("USER")
FECHA=REQUEST("FECHA")
ESTADO=REQUEST("ESTADO")
CRITICIDAD=REQUEST("CRITICIDAD")
MARCA=REQUEST("MARCA")
COMBUSTIBLE=UCASE(REQUEST("COMBUSTIBLE"))
CAUSA=UCASE(REQUEST("CAUSA"))
ACCION=UCASE(REQUEST("ACCION"))
ESTATUS=UCASE(REQUEST("ESTATUS"))
EJECUTOR=UCASE(REQUEST("EJECUTOR"))
CONDICION=UCASE(REQUEST("CONDICION"))
COLOR=UCASE(REQUEST("COLOR"))
VALOR_COMBUSTIBLE=UCASE(REQUEST("VALOR_COMBUSTIBLE"))
DOC_COMBUSTIBLE=UCASE(REQUEST("DOC_COMBUSTIBLE"))
DESC_SECCION=UCASE(REQUEST("DESC_SECCION"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
ULT_INSPECCION=UCASE(REQUEST("ULT_INSPECCION"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
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
FECHA_EJECUCCION=UCASE(REQUEST("FECHA_EJECUCCION"))
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
IMG=UCASE(REQUEST("IMG"))
ULT_MOD_OBS=UCASE(REQUEST("ULT_MOD_OBS"))
SW=UCASE(REQUEST("SW"))
SISTEMA=UCASE(REQUEST("SISTEMA"))
ACCION=UCASE(REQUEST("ACCION"))
FOLIO1=REQUEST("FOLIO1")
FOLIO2=REQUEST("FOLIO2")
JERARQUIA=REQUEST("JERARQUIA")
IDHISTORIAL=REQUEST("IDHISTORIAL")


if PLANTA <> "" then PLANTA = replace(PLANTA, "-", " ") end if
Select case RECURSO
	case "listMoviles"
	 	  listMoviles()
	case "listFijos"
	 	  listFijos()
	case "listTren"
	 	  listTren()
	case "DelTren"
	 	  DelTren()
	case "SaveTren"
	 	  SaveTren()		  
	case "UpdTrenSTBtoACT"
	 	  UpdTrenSTBtoACT()		  
	case "listTrenScreen"
	 	  listTrenScreen()	
	case "FolioTren"
	 	  FolioTren()	
	case "LoadTren"
	 	  LoadTren()	
	case "listMoviles_UM"
	 	  listMoviles_UM()	
	case "listMoviles_UM_MOD"
	 	  listMoviles_UM_MOD()	
	case "LoadFolio"
	 	  LoadFolio()	
	case "UpdListMoviles"
	 	  UpdListMoviles()	
	case "UpdlistFijos"
	 	  UpdlistFijos()	
	case "SaveBitacoraMovil"
	 	  SaveBitacoraMovil()	
	case "UpdateBitacoraMovil"
	 	  UpdateBitacoraMovil()	
	case "listCriterios"
	 	  listCriterios()			  
	case "GetBitacora"
	 	  GetBitacora()			  
	case "listComponentesMoviles"
	 	  listComponentesMoviles()		
	case "GetBitacoraUlt"
	 	  GetBitacoraUlt()		
	case "GetBitacoraUltFull"
	 	  GetBitacoraUltFull()		
	case "listTrenGroupScreen"
	 	  listTrenGroupScreen()				  
	case "listExistentes"
	 	  listExistentes()		
	case "listHistorial"
	 	  listHistorial()		
	case "IdHistTren"
	 	  IdHistTren()		
	case "LoadHistorialTren"
	 	  LoadHistorialTren()		
		  		  
		  	  
		  
End Select


function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function


function listMoviles()

	'query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, E.MARCA  FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO LEFT JOIN BITACORAS AS B ON E.CODIGO = DBO.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION)  AND B.STATUS IS NOT NULL AND B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE'  WHERE  (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 17) AND B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE' GROUP BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, E.MARCA ORDER BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA"
	query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, (select TOP 1 CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END FROM BITACORAS AS B WHERE B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC') AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = E.CODIGO) AS STATUS , E.MARCA  FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO WHERE  (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 17) GROUP BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, E.MARCA, E.CODIGO ORDER BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA"
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1	
		context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><input type='checkbox' id='chk' /><input type='hidden' id='hd' value='M' /><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' /><img src='Scripts/" & trim(ORs.Fields.Item(4).Value) & "' alt='' style='vertical-align:middle'/><label style='border-style:solid; border-width:1px; padding:2px;'> " & N & " </label>&nbsp;&nbsp;"& trim(ORs.Fields.Item(0).Value) 
		if trim(ORs.Fields.Item(5).Value) = "STM" then 
			context = context &  "<img id='mark' src='images/ICON_STM.png'/>"
		end if
		context = context &  "</li>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listFijos()

	query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, replace(E.DESCRIPCION,'CORREA ','') as DESCRIPCION ,S.PLANTA, E.TIPO_EQUIPO, S.CODIGO FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO WHERE     (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 1) and (E.DESCRIPCION like '%ORUGA%' OR E.DESCRIPCION like '%STACKER%' OR E.DESCRIPCION like '%TRIPPER%' OR E.DESCRIPCION like '%DERIVADOR%' OR E.DESCRIPCION like '%TRASPASO%') "
	if PLANTA <> "" then
		query = query & " AND S.PLANTA = '" & PLANTA  & "' "
	end if
	query = query & " GROUP BY dbo.EquipoPrincipal(E.CODIGO), E.DESCRIPCION ,S.PLANTA, E.TIPO_EQUIPO, S.CODIGO ORDER BY EQUIPO, S.PLANTA"
	
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><input type='checkbox' id='chk' /><input type='hidden' id='hd' value='F' /><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' /><input type='hidden' id='pt' value='"& trim(ORs.Fields.Item(2).Value) &"' />&nbsp;"& trim(ORs.Fields.Item(1).Value) &"</li>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listTren()

	query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, replace(E.DESCRIPCION,'CORREA ','') as DESCRIPCION ,S.PLANTA, E.TIPO_EQUIPO, S.CODIGO FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO WHERE     (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 1) and (E.DESCRIPCION like '%ORUGA%' OR E.DESCRIPCION like '%STACKER%' OR E.DESCRIPCION like '%TRIPPER%' OR E.DESCRIPCION like '%DERIVADOR%' OR E.DESCRIPCION like '%TRASPASO%') GROUP BY dbo.EquipoPrincipal(E.CODIGO), E.DESCRIPCION ,S.PLANTA, E.TIPO_EQUIPO, S.CODIGO ORDER BY EQUIPO, S.PLANTA"
	
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1



		context = context &  "<li><div id='machine"& N &"' class='machine'><div id='codemachine"& N &"' class='codemachine'>"& trim(ORs.Fields.Item(0).Value) &"</div><div id='status' class='status'><img src='../Scripts/down.png'/></div><div id='serie"& N &"' class='serie'>"& N &"</div></div></li>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelTren()

'LINEA=" + $('#txt_linea01').attr('value') + "&PILA1=" + $('#txt_pila01').attr('value')+ "&PILA2=''&PLANTA=" + $('select#cbl_planta01').val() + "&IND_OP=OP&FAENA=" + faena + "&ESTADO=" + estado
	
	query = "DELETE FROM TREN WHERE LINEA='" & LINEA & "'  AND PLANTA ='"&PLANTA&"'"
	if PILA1 <> "" or PILA2 <> "" then
		query = query & " AND (PILA = '"&PILA1&"' OR PILA = '"&PILA2&"')"
	end if
	if IND_OP <> "" then 
		query = query & " AND IND_OPERATIVO = " & strNvl(IND_OP)
	end if
	if FAENA <> "" then 
		query = query & " AND FAENA = " & strNvl(FAENA)
	end if
	if ESTADO <> "" then 
		query = query & " AND ACTIVO = " & strNvl(ESTADO)
	end if
	if JERARQUIA <> "" then 
		query = query & " AND JERARQUIA = " & strNvl(JERARQUIA)
	end if
	
	ORs = oDB.EjecutaSql(query)
	if ACCION <> "" then
		query = "SELECT MAX(ID_HISTORIAL) AS N FROM TREN_HISTORIAL"
		Set ORs =oDB.EjecutaSql(query)
		if not ORs.EOF then
			If Len(oRS("N"))>0 Then
				IDHIST = cint(oRS("N")) + 1
			Else
				IDHIST = 1
			End If
		end if
		query = "INSERT INTO TREN_HISTORIAL SELECT FOLIO, EQUIPO, SECUENCIA, IND_OPERATIVO, FECHA, RECOMENDACION, FAENA, USERNAME, USERDATE, LINEA, PILA, PLANTA, TIPO_EQUIPO, PILA_REL, ACTIVO, JERARQUIA, 'CAMBIOS POR ELIMINACION' AS STATUS_OP, '" & IDHIST & "' FROM TREN WHERE LINEA='" & LINEA & "'  AND PLANTA ='"&PLANTA&"'"
		if PILA1 <> "" or PILA2 <> "" then
			query = query & " AND (PILA = '"&PILA1&"' OR PILA = '"&PILA2&"')"
		end if
'		if IND_OP <> "" then 
'			query = query & " AND IND_OPERATIVO = " & strNvl(IND_OP)
'		end if
		if FAENA <> "" then 
			query = query & " AND FAENA = " & strNvl(FAENA)
		end if
		if ESTADO <> "" then 
			query = query & " AND ACTIVO = " & strNvl(ESTADO)
		end if
'		if JERARQUIA <> "" then 
'			query = query & " AND JERARQUIA = " & strNvl(JERARQUIA)
'		end if
		
		ORs = oDB.EjecutaSql(query)
	end if
	Set ORs = Nothing
	Set ODB = Nothing
	if err.number = 0 then
		response.write "OK"
	else
		response.write "ERR"
	end if
end function

function SaveTren()

'	query = "SELECT MAX(ID) AS N FROM TREN"
'	Set ORs =oDB.EjecutaSql(query)
'	
'	If Len(oRS("N"))>0 Then
'		N = oRS("N") + 1
'	Else
'		N = 1
'	End If
'	FOLIO = N
	query = "SELECT * FROM TREN"
	query = query & "WHERE  LINEA = '"&LINEA&"' AND  PILA = '"&PILA1&"' AND PLANTA = '"&PLANTA&"' AND IND_OPERATIVO = '"&IND_OP&"'"	
	'Set ORs =oDB.EjecutaSql(query)

	query = "INSERT INTO TREN_HISTORIAL(FOLIO, EQUIPO, SECUENCIA, IND_OPERATIVO, FECHA, RECOMENDACION, FAENA, USERNAME, USERDATE, LINEA, PILA, PLANTA, TIPO_EQUIPO, PILA_REL, ACTIVO, JERARQUIA, STATUS_OP, ID_HISTORIAL)"
	query = query & " VALUES ("
	query = query & FOLIO & "," 
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(SEC) & ","
	query = query & strNvl(IND_OP) & ","
	query = query & "getdate()," 
	query = query & strNvl(RECOMENDACION) & ","
	query = query & strNvl(FAENA) & ","
	query = query & strNvl(USER) & ","
	query = query & "getdate()," 
	query = query & strNvl(LINEA) & ","
	query = query & strNvl(PILA1) & ","
	query = query & strNvl(PLANTA) & ","
	query = query & strNvl(TIPO_EQUIPO) & ","
	query = query & strNvl(PILA2) & ","
	query = query & strNvl(ESTADO) & ","	
	query = query & strNvl(JERARQUIA) & ","	
	query = query & strNvl(ACCION) & ","	
	query = query & strNvl(IDHISTORIAL) & ")"	
	Set ORs =oDB.EjecutaSql(query)


	query = "INSERT INTO TREN(FOLIO, EQUIPO, SECUENCIA, IND_OPERATIVO, FECHA, RECOMENDACION, FAENA, USERNAME, USERDATE, LINEA, PILA, PLANTA, TIPO_EQUIPO, PILA_REL, ACTIVO, JERARQUIA)"
	query = query & " VALUES ("
	query = query & FOLIO & "," 
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(SEC) & ","
	query = query & strNvl(IND_OP) & ","
	query = query & "getdate()," 
	query = query & strNvl(RECOMENDACION) & ","
	query = query & strNvl(FAENA) & ","
	query = query & strNvl(USER) & ","
	query = query & "getdate()," 
	query = query & strNvl(LINEA) & ","
	query = query & strNvl(PILA1) & ","
	query = query & strNvl(PLANTA) & ","
	query = query & strNvl(TIPO_EQUIPO) & ","
	query = query & strNvl(PILA2) & ","
	query = query & strNvl(ESTADO) & ","	
	query = query & strNvl(JERARQUIA) & ")"	
	' FALTA STATUS DE CADA EQUIPO
		
'	response.write query
	Set ORs =oDB.EjecutaSql(query)
	if err.number = 0 then
		response.write "OK"
	else
		response.write "ERR"
	end if
	Set ORs = Nothing
	Set oDB = Nothing

end function

function UpdTrenSTBtoACT()

'LINEA=" + $('#txt_linea01').attr('value') + "&PILA1=" + $('#txt_pila01').attr('value')+ "&PILA2=''&PLANTA=" + $('select#cbl_planta01').val() + "&IND_OP=OP&FAENA=" + faena + "&ESTADO=" + estado

	query = "UPDATE TREN SET ACTIVO = 'ACT'  WHERE LINEA='" & LINEA & "'  AND PLANTA ='"&PLANTA&"'"
	if PILA1 <> "" or PILA2 <> "" then
		query = query & " AND (PILA = '"&PILA1&"' OR PILA = '"&PILA2&"')"
	end if
	if IND_OP <> "" then 
		query = query & " AND IND_OPERATIVO = " & strNvl(IND_OP)
	end if
	if FAENA <> "" then 
		query = query & " AND FAENA = " & strNvl(FAENA)
	end if
	if ESTADO <> "" then 
		query = query & " AND ACTIVO = " & strNvl(ESTADO)
	end if
	if JERARQUIA <> "" then 
		query = query & " AND JERARQUIA = " & strNvl(JERARQUIA)
	end if
	
	ORs = oDB.EjecutaSql(query)
	if ACCION <> "" then
		query = "SELECT MAX(ID_HISTORIAL) AS N FROM TREN_HISTORIAL"
		Set ORs =oDB.EjecutaSql(query)
		if not ORs.EOF then
			If Len(oRS("N"))>0 Then
				IDHIST = cint(oRS("N")) + 1
			Else
				IDHIST = 1
			End If
		end if
		ESTADO = "ACT" 
		query = "INSERT INTO TREN_HISTORIAL SELECT FOLIO, EQUIPO, SECUENCIA, IND_OPERATIVO, FECHA, RECOMENDACION, FAENA, USERNAME, USERDATE, LINEA, PILA, PLANTA, TIPO_EQUIPO, PILA_REL, ACTIVO, JERARQUIA, '" & ACCION & "' AS STATUS_OP, '" & IDHIST & "' FROM TREN WHERE LINEA='" & LINEA & "'  AND PLANTA ='"&PLANTA&"'"
		if PILA1 <> "" or PILA2 <> "" then
			query = query & " AND (PILA = '"&PILA1&"' OR PILA = '"&PILA2&"')"
		end if
'		if IND_OP <> "" then 
'			query = query & " AND IND_OPERATIVO = " & strNvl(IND_OP)
'		end if
		if FAENA <> "" then 
			query = query & " AND FAENA = " & strNvl(FAENA)
		end if
		if ESTADO <> "" then 
			query = query & " AND ACTIVO = " & strNvl(ESTADO)
		end if
'		if JERARQUIA <> "" then 
'			query = query & " AND JERARQUIA = " & strNvl(JERARQUIA)
'		end if
		response.write query
		ORs = oDB.EjecutaSql(query)
	end if
	Set ORs = Nothing
	Set ODB = Nothing
	if err.number = 0 then
		response.write "OK"
	else
		response.write "ERR"
	end if
	
end function


function listTrenScreen()

	query = "SELECT T.FOLIO, dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, T.PLANTA, T.SECUENCIA, CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png'  WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO LEFT OUTER JOIN TREN AS T ON E.CODIGO = T.EQUIPO LEFT OUTER JOIN BITACORAS B  ON T.EQUIPO = dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION)  AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC') WHERE (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT')  AND (E.TIPO_EQUIPO = 1 OR E.TIPO_EQUIPO = 17) and (E.DESCRIPCION like '%movil%' OR E.DESCRIPCION like '%STACKER%' OR E.DESCRIPCION like '%TRIPPER%' OR E.DESCRIPCION like '%DERIVADOR%' OR E.DESCRIPCION like '%TRASPASO%') AND T.ACTIVO = 'ACT' and T.TIPO_EQUIPO = 'M' AND T.IND_OPERATIVO = 'OP' " 
	if FAENA <> "" then
		query = query & " AND T.FAENA = '"& FAENA & "'"
	end if
	PLANTA = replace(planta, "-", " ")
	if PLANTA <> "" then
		query = query & " AND T.PLANTA = '"& PLANTA & "'"
	end if
	if LINEA <> "" then
		query = query & " AND T.LINEA = '"& LINEA & "'"
	end if
	if PILA1 <> "" then
		query = query & " AND T.PILA = '"& PILA1 & "'"
	end if
	
	query = query & " GROUP BY  T.FOLIO, dbo.EquipoPrincipal(E.CODIGO), E.DESCRIPCION ,T.PLANTA, T.SECUENCIA  ORDER BY T.FOLIO, T.SECUENCIA, T.PLANTA"	
	
	'response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		context = context &  "<li><div id='machine"& N &"' class='machine'><div id='codemachine"& N &"' class='codemachine'>"& trim(ORs.Fields.Item(1).Value) &"</div><div id='status' class='status'><img src='../Scripts/"& trim(ORs.Fields.Item(4).Value) &"'/></div><div id='serie"& N &"' class='serie'>"& N &"</div></div></li>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listTrenGroupScreen()

'	query = " SELECT   FOLIO, LINEA, PILA, PLANTA, CASE MAX(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png'  WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, @@rowcount as TL FROM TREN T LEFT OUTER JOIN BITACORAS B  ON T.EQUIPO = dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION)  AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC')  WHERE T.ACTIVO = 'ACT' and T.TIPO_EQUIPO = 'M' AND T.IND_OPERATIVO = 'OP' AND B.STATUS IS NOT NULL  AND T.FAENA = 'CERRO COLORADO' AND T.FAENA = B.UBICACION " 

	query = " SELECT   FOLIO, LINEA, PILA, PLANTA, CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, @@rowcount as TL FROM TREN T LEFT OUTER JOIN BITACORAS B ON T.EQUIPO = dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) AND B.IND_SOLUCION = 'FALSE' AND T.FAENA = B.UBICACION AND B.CONDICION IN ('REPROG','EJEC')   WHERE T.ACTIVO = 'ACT' and T.TIPO_EQUIPO = 'M' AND T.IND_OPERATIVO = 'OP'"
	if FAENA <> "" then
		query = query & " AND T.FAENA = '"& FAENA & "'"
	end if
	if PLANTA <> "" then
		query = query & " AND PLANTA = '"& PLANTA & "'"
	end if
	if LINEA <> "" then
		query = query & " AND LINEA = '"& LINEA & "'"
	end if
	if PILA <> "" then
		query = query & " AND PILA = '"& PILA & "'"
	end if
	query = query & " GROUP BY FOLIO, LINEA, PILA, PLANTA"	
	
	'response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	PLANTA = replace(planta, " ", "-")
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		context = context &  "<li onclick=loadrisk('" & PLANTA & "','" & trim(ORs.Fields.Item(1).Value) & "','" & trim(ORs.Fields.Item(2).Value) & "');><div id='group"& N &"' class='group'><div id='codegroup"& N &"' class='codegroup'>LINEA "& trim(ORs.Fields.Item(1).Value) &" PILA "& trim(ORs.Fields.Item(2).Value) &"</div><div id='status' class='status'><img src='../Scripts/"& trim(ORs.Fields.Item(4).Value) &"'/></div><div id='serie"& N &"' class='serie'>"& N &"</div></div></li>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function


function FolioTren()

	query = "SELECT MAX(FOLIO) AS N FROM TREN"
	Set ORs =oDB.EjecutaSql(query)
	if not ORs.EOF then
		If Len(oRS("N"))>0 Then
			N = oRS("N") + 1
		Else
			N = 1
		End If
	end if
	response.write N
end function

function IdHistTren()

	query = "SELECT MAX(ID_HISTORIAL) AS N FROM TREN_HISTORIAL"
	Set ORs =oDB.EjecutaSql(query)
	if not ORs.EOF then
		If Len(oRS("N"))>0 Then
			Nx = cint(oRS("N")) + 1
		Else
			Nx = 1
		End If
	end if
	response.write Nx
end function

function LoadTren()
	FAENA = "CERRO COLORADO"
	query = " SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, replace(E.DESCRIPCION,'CORREA ','') as DESCRIPCION, S.PLANTA, T.SECUENCIA, T.TIPO_EQUIPO, T.PILA_REL, (select TOP 1 CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END FROM BITACORAS AS B WHERE B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC') AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = E.CODIGO) AS STATUS, E.MARCA FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO LEFT OUTER JOIN TREN AS T ON E.CODIGO = T.EQUIPO   WHERE  (E.UBICACION = '"&FAENA&"') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT')  AND (E.TIPO_EQUIPO = 1 OR E.TIPO_EQUIPO = 17) and (E.DESCRIPCION like '%movil%' OR E.DESCRIPCION like '%STACKER%' OR E.DESCRIPCION like '%TRIPPER%' OR E.DESCRIPCION like '%DERIVADOR%' OR E.DESCRIPCION like '%TRASPASO%' OR E.DESCRIPCION like '%ORUGA%') AND "
	if LINEA <> "" THEN
		query = query & " T.LINEA = '"&LINEA&"' AND "
	END IF
	query = query & " T.PILA = '"&PILA1&"' AND T.PLANTA = '"&PLANTA&"' AND T.IND_OPERATIVO = '"&IND_OP&"'"
	if ESTADO <> "" THEN
		query = query & "AND T.ACTIVO = '"&ESTADO&"' "
	END IF	
	if JERARQUIA <> "" THEN
		query = query & "AND T.JERARQUIA = '"&JERARQUIA&"' "
	END IF	
	query = query & " GROUP BY  dbo.EquipoPrincipal(E.CODIGO), E.DESCRIPCION ,S.PLANTA, T.SECUENCIA, T.TIPO_EQUIPO, T.PILA_REL, E.MARCA, E.CODIGO ORDER BY T.SECUENCIA"
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		if  trim(ORs.Fields.Item(4).Value) = "M" then
			context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><input type='checkbox' id='chk' /><input type='hidden' id='hd' value='"& trim(ORs.Fields.Item(4).Value) &"' /><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' /><input type='hidden' id='pila_aux' value='"& trim(ORs.Fields.Item(5).Value) &"' /><input type='hidden' id='pt' value='"& trim(ORs.Fields.Item(2).Value) &"' /><img src='Scripts/"& trim(ORs.Fields.Item(6).Value) &"' alt='' style='vertical-align:middle'/><label style='border-style:solid; border-width:1px; padding:2px;'> " & N & " </label>&nbsp;&nbsp;"& trim(ORs.Fields.Item(0).Value) 
			if trim(ORs.Fields.Item(7).Value) = "STM" then 
				context = context &  "<img id='mark' src='images/ICON_STM.png'/>"
			end if
			context = context &  "</li>"
		elseif trim(ORs.Fields.Item(4).Value) = "F" then
			context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><input type='checkbox' id='chk' /><input type='hidden' id='hd' value='"& trim(ORs.Fields.Item(4).Value) &"' /><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' /><input type='hidden' id='pila_aux' value='"& trim(ORs.Fields.Item(5).Value) &"' /><input type='hidden' id='pt' value='"& trim(ORs.Fields.Item(2).Value) &"' />&nbsp;"& trim(ORs.Fields.Item(1).Value) &"</li>"
		end if
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	if err.number <> 0 then
		response.write "ERR"
	elseif N = 0 then
		response.write "EMPTY"
	else
		response.write context
	end if
end function	

function listMoviles_UM()
	if LINEA <> "" and PILA1 <> "" then
		query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, ROW_NUMBER() OVER(ORDER BY dbo.EquipoPrincipal(E.CODIGO) DESC) as n, (select TOP 1 CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END FROM BITACORAS AS B WHERE B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC') AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = E.CODIGO) AS STATUS FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO INNER JOIN TREN AS T ON T.EQUIPO = dbo.EquipoPrincipal(E.CODIGO) AND T.FAENA = E.UBICACION AND T.ACTIVO = E.ESTADO WHERE (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 17) AND T.LINEA = '"&LINEA&"' AND T.PILA = '"&PILA1&"' GROUP BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, E.CODIGO ORDER BY EQUIPO, S.PLANTA"	
	else
		query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, ROW_NUMBER() OVER(ORDER BY dbo.EquipoPrincipal(E.CODIGO) DESC) as n, (select TOP 1 CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END FROM BITACORAS AS B WHERE B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC') AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = E.CODIGO) AS STATUS FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO WHERE     (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 17) GROUP BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, E.CODIGO ORDER BY EQUIPO, S.PLANTA"
	end if
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		if N = 1 then 
			context = context &  "<li class='st_li_first'><a href='#tab-"& N &"' rel='tab-"& N &"' class='st_tab st_tab_"& N &" st_tab_first st_tab_active'><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' />"& trim(ORs.Fields.Item(0).Value) &"  &nbsp;&nbsp;&nbsp;<img src='Scripts/"& trim(ORs.Fields.Item(5).Value) &"' alt='' style='vertical-align:middle' border='0'/></a></li>"
		elseif N > 1 and cdbl(ORs.Fields.Item(4).Value) > 1 then
			context = context &  "<li><a href='#tab-"& N &"' rel='tab-"& N &"' class='st_tab st_tab_"& N &"'><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' />"& trim(ORs.Fields.Item(0).Value) &" &nbsp;&nbsp;&nbsp;<img src='Scripts/"& trim(ORs.Fields.Item(5).Value) &"' alt='' style='vertical-align:middle' border='0'/></a></li>"
		elseif cdbl(ORs.Fields.Item(4).Value) = 1 then
				context = context &  "<li class='st_li_last'><a href='#tab-"& N &"' rel='tab-"& N &"' class='st_tab st_tab_"& N &" st_tab_last'><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' />"& trim(ORs.Fields.Item(0).Value) &" &nbsp;&nbsp;&nbsp;<img src='Scripts/"& trim(ORs.Fields.Item(5).Value) &"' alt='' style='vertical-align:middle' border='0'/></a></li>"
		end if
		ORs.MoveNext 
'		if ORs.EOF then
'				context = context &  "<li class='st_li_last'><a href='#tab-"& N &"' rel='tab-"& N &"' class='st_tab st_tab_"& N &" st_tab_last'><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' />"& trim(ORs.Fields.Item(0).Value) &" </a></li>"
'		end if
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
	
end function
function listMoviles_UM_MOD()

	query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, ROW_NUMBER() OVER(ORDER BY dbo.EquipoPrincipal(E.CODIGO) DESC) as n FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO WHERE     (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 17) GROUP BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA, E.TIPO_EQUIPO, S.CODIGO ORDER BY EQUIPO, S.PLANTA"
	
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	While Not ORs.EOF
		N=N+1
		if N = 1 then
			context = context &  "<div class='tab-"&N&" st_view st_view_first' id='tab-"&N&"'><input id='hddlist' type='hidden' value=''/><div class='st_view_inner'><div id='hero-slider'><div id='pnl-"&N&"'><ul><li><a href='#' rel='#panel-1' class='activate post'>Item 1</a></li><li><a href='#' rel='#panel-2' class='post'>Item 2</a></li><li><a href='#' rel='#panel-3' class='post'>Item 3</a></li><li><a href='#' rel='#panel-4' class='post'>Item 4</a></li></ul></div><div id='tab-"&N&"-mask' class='mask'><div class='slider-body'  id='tab-"&N&"-body'><div class='panel' id='panel-1'></div><div class='panel' id='panel-2'></div><div class='panel' id='panel-3'></div><div class='panel' id='panel-4'></div></div></div></div></div></div>"
		elseif N > 1 then
			context = context &  "<div class='tab-"&N&" st_view' id='tab-"&N&"'><input id='hddlist' type='hidden' value=''/><div class='st_view_inner'><div id='hero-slider'><div id='pnl-"&N&"'><ul><li><a href='#' rel='#panel-1' class='activate post'>Item 1</a></li><li><a href='#' rel='#panel-2' class='post'>Item 2</a></li><li><a href='#' rel='#panel-3' class='post'>Item 3</a></li><li><a href='#' rel='#panel-4' class='post'>Item 4</a></li></ul></div><div id='tab-"&N&"-mask' class='mask'><div class='slider-body' id='tab-"&N&"-body'><div class='panel' id='panel-1'></div><div class='panel' id='panel-2'></div><div class='panel' id='panel-3'></div><div class='panel' id='panel-4'></div></div></div></div></div></div>"
		end if
		ORs.MoveNext 
	Wend
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function LoadFolio()
	FAENA = "CERRO COLORADO"
	query = " SELECT DISTINCT T.FOLIO, T.LINEA, T.PILA, T.PILA_REL, T.IND_OPERATIVO, T.PLANTA FROM TREN T WHERE  T.ACTIVO = 'ACT' AND T.IND_OPERATIVO = 'OP' AND "
	query = query & "  T.PLANTA = '"&PLANTA&"' AND T.FOLIO = '"&FOLIO&"'"
	'response.write query
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	While Not ORs.EOF 
		N=N+1
		context = context &  "<li><input type='hidden' id='FOLIO' value='"& trim(ORs.Fields.Item(0).Value) &"' /><input type='hidden' id='LINEA' value='"& trim(ORs.Fields.Item(1).Value) &"' /><input type='hidden' id='PILA' value='"& trim(ORs.Fields.Item(2).Value) &"' /><input type='hidden' id='PILA_REL' value='"& trim(ORs.Fields.Item(3).Value) &"' /><input type='hidden' id='IND_OP' value='"& trim(ORs.Fields.Item(4).Value) &"' /><input type='hidden' id='PLANTA' value='"& trim(ORs.Fields.Item(5).Value) &"' /></li>"
		ORs.MoveNext 
	Wend
	if err.number <> 0 then
		response.write "ERR"
	elseif N = 0 then
		response.write "EMPTY"
	else
		response.write context
	end if
end function	

function UpdListMoviles()

	query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, (select TOP 1 CASE MIN(B.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END FROM BITACORAS AS B WHERE B.UBICACION = 'CERRO COLORADO' AND  B.IND_SOLUCION = 'FALSE' AND B.CONDICION IN ('REPROG','EJEC') AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = E.CODIGO) AS STATUS , E.MARCA FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO   WHERE     (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 17) and dbo.EquipoPrincipal(E.CODIGO) not in (select EQUIPO from TREN where FOLIO = '" & FOLIO1 & "' and TIPO_EQUIPO = 'M') GROUP BY dbo.EquipoPrincipal(E.CODIGO), S.PLANTA, E.TIPO_EQUIPO, S.CODIGO, E.MARCA, E.CODIGO ORDER BY EQUIPO, S.PLANTA"
	
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><input type='checkbox' id='chk' /><input type='hidden' id='hd' value='M' /><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' /><img src='Scripts/"& trim(ORs.Fields.Item(4).Value) &"' alt='' style='vertical-align:middle'/><label style='border-style:solid; border-width:1px; padding:2px;'> " & N & " </label>&nbsp;&nbsp;"& trim(ORs.Fields.Item(0).Value) 
			if trim(ORs.Fields.Item(5).Value) = "STM" then 
				context = context &  "<img id='mark' src='images/ICON_STM.png'/>"
			end if
			context = context &  "</li>"

		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdlistFijos()

	query = "SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, replace(E.DESCRIPCION,'CORREA ','') as DESCRIPCION ,S.PLANTA, E.TIPO_EQUIPO, S.CODIGO  FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO WHERE     (E.UBICACION = 'CERRO COLORADO') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT') AND (E.TIPO_EQUIPO = 1) and dbo.EquipoPrincipal(E.CODIGO) not in (select EQUIPO from TREN where FOLIO = '" & FOLIO1 & "' and TIPO_EQUIPO = 'F' and planta = '" & PLANTA & "') and (E.DESCRIPCION like '%ORUGA%' OR E.DESCRIPCION like '%STACKER%' OR E.DESCRIPCION like '%TRIPPER%'  OR E.DESCRIPCION like '%DERIVADOR%' OR E.DESCRIPCION like '%TRASPASO%') and (S.PLANTA = '" & PLANTA & "') GROUP BY dbo.EquipoPrincipal(E.CODIGO), E.DESCRIPCION ,S.PLANTA, E.TIPO_EQUIPO, S.CODIGO ORDER BY EQUIPO, S.PLANTA"
	
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><input type='checkbox' id='chk' /><input type='hidden' id='hd' value='F' /><input type='hidden' id='hd_cod' value='"& trim(ORs.Fields.Item(0).Value) &"' /><input type='hidden' id='pt' value='"& trim(ORs.Fields.Item(2).Value) &"' />&nbsp;"& trim(ORs.Fields.Item(1).Value) &"</li>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function
function SaveBitacoraMovil()

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
	query = query & " IND_SOLUCION, PRIORIDAD, COLOR, CRITICIDAD, ACCION, FECHA_PROGRAMADA, OT, CONDICION, USERDATE, USERNAME, STATUS) VALUES ("
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
	query = query & strNvl(ACCION) & ","	
	query = query & strNvl(FECHA_PROGRAMADA) & ","
	query = query & strNvl(OT) & ","
	query = query & strNvl(CONDICION) & ","
	query = query & "getdate(),"
	query = query & strNvl(USERNAME) & ","	
	query = query & strNvl(ESTATUS) & ");"	
		
'	response.write query	
	Set ORs =oDB.EjecutaSql(query)
	if err.number = 0 then
		response.write N
	else
		response.write "ERR"
	end if
end function

function UpdateBitacoraMovil()

	query = "UPDATE BITACORAS SET "'FECHA = " & strNvl(FECHA) & ","
	query = query & "TURNO=" & strNvl(TURNO) & ","
	query = query & "EJECUTOR=" & strNvl(EJECUTOR) & ","
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "IND_INCIDENTE=" & strNvl(IND_INCIDENTE) & ","
	query = query & "IND_DANO=" & strNvl(IND_DANO) & ","
	'query = query & "EQUIPO=" & strNvl(EQUIPO) & ","
	query = query & "REPORT=" & strNvl(REPORT) & ","
	query = query & "NAVE=" & strNvl(NAVE) & ","
	query = query & "TIPO_TURNO=" & strNvl(TIPO_TURNO) & ","
	query = query & "PRIORIDAD=" & strNvl(PRIORIDAD) & ","
	query = query & "COLOR=" & strNvl(COLOR) & ","
	query = query & "CRITICIDAD=" & strNvl(CRITICIDAD) & ","
	query = query & "COMBUSTIBLE=" & strNvl(COMBUSTIBLE) & ","
	query = query & "VALOR_COMBUSTIBLE=" & strNvl(VALOR_COMBUSTIBLE) & ","
	query = query & "CAUSA=" & strNvl(CAUSA) & ","
	query = query & "RECOMENDACION=" & strNvl(RECOMENDACION) & ","
	query = query & "IND_SOLUCION=" & strNvl(IND_SOLUCION) & ","
	query = query & "USERDATE = getdate(),"
	query = query & "USERNAME =" & strNvl(USERNAME) & ","
	query = query & "DANO=" & strNvl(DANO) & ","
	if IND_SOLUCION = "TRUE" then
		query = query & "ULT_MOD_OBS= getdate() ,"
		query = query & "ULT_INSPECCION= getdate() ,"
	else		
		query = query & "ULT_INSPECCION=" & strNvl(ULT_INSPECCION) & ","
	end if
	query = query & "ACCION=" & strNvl(ACCION) & ","
	query = query & "CONDICION=" & strNvl(CONDICION) & ","
	query = query & "STATUS=" & strNvl(ESTATUS) & ","
	query = query & "FECHA_PROGRAMADA=" & strNvl(FECHA_PROGRAMADA) & ""
		
	query = query & " WHERE ID=" & ID 

	Set ORs =oDB.EjecutaSql(query)
	
'		query = "UPDATE BITACORAS SET ULT_INSPECCION = " & strNvl(ULT_INSPECCION) 
'		query = query & " WHERE DBO.EQUIPOPRINCIPAL(EQUIPO)= DBO.EQUIPOPRINCIPAL(" & strNvl(EQUIPO) & ")" 
'		query = query & " AND UBICACION=" & strNvl(FAENA) 
'		query = query & " AND IND_SOLUCION<>'TRUE'"
'		Set ORs =oDB.EjecutaSql(query)
		
		
'		response.write query & "<br>"
'		response.end
		
'	IF SW = 2 or SW = 3 or IND_SOLUCION = "TRUE" THEN
'		query = "SELECT FECHA, STATUS FROM HISTORIAL_BITACORA "
'		query = query & " WHERE ID=" & strNvl(ID) 
'		query = query & " AND CONVERT(CHAR,FECHA,103)=CONVERT(CHAR," & strNvl(ULT_INSPECCION) & ",103)" 
'		query = query & " AND STATUS = " & strNvl(STS)
'	
'		Set ORs =oDB.EjecutaSql(query)
'		'response.write query & "<br>"
'		if IND_SOLUCION = "TRUE" then
'			STS = 1
'		end if
'		If ORs.EOF Then
'			query = " INSERT INTO HISTORIAL_BITACORA (ID, INSPECTOR, FECHA, STATUS, USERNAME, USERDATE) VALUES ("
'			query = query & ID & "," & strNvl(USERNAME) & "," 
'			if ULT_INSPECCION <> "" THEN
'				query = query & strNvl(ULT_INSPECCION &" "& Time()) 
'			ELSE
'				query = query & "GETDATE()"
'			END IF
'			query = query & "," & STS & "," & strNvl(USERNAME) & ", GETDATE())"
'			'response.write query & "<br>"
'
'			Set ORs =oDB.EjecutaSql(query) 
'		End If
'	END IF
	'response.write query & "<br>"
	'response.end
	if err.number = 0 then
		response.write "OK"
	else
		response.write "ERR"
	end if
	
	
	
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listCriterios()

	query = "select Linea, pila, planta from tren where IND_OPERATIVO = 'OP' group by Linea, pila, planta"
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	context = context &  "<option value='-1'>[--Seleccionar--]</option><option value='all'>[-- Todos --]</option>"
	While Not ORs.EOF 
		N=N+1
		context = context &  "<option value='"& trim(ORs.Fields.Item(0).Value)&"|"&trim(ORs.Fields.Item(1).Value)&"|"&trim(ORs.Fields.Item(2).Value) &"'> Linea "& trim(ORs.Fields.Item(0).Value) &"&nbsp;Pila&nbsp;" & trim(ORs.Fields.Item(1).Value) & "&nbsp;" & trim(ORs.Fields.Item(2).Value) &"</option>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetBitacora()
	if 	SISTEMA = "UCC" then
		sist = "CINTA"
	elseif SISTEMA = "UME" then
		sist = "COMPONENTES ELECTRICOS"
	elseif SISTEMA = "UMM" then
		sist = "COMPONENTES MECANICOS"
	elseif SISTEMA = "UMI" then
		sist = "INSTRUMENTACION"
	end if
	query = "select top 20 B.ID, rtrim(convert(char,b.fecha,103)) + ' ' +  substring(convert(char,b.fecha,108),1,5) as FECHA, B.TURNO, B.RESPONSABLE, B.DESCRIPCION, B.ESTADO, B.IND_INCIDENTE, B.EQUIPO, B.REPORT, B.CRITICIDAD, B.TIPO_TURNO,   B.DANO, B.PRIORIDAD, B.IND_DANO,  B.COMBUSTIBLE, B.VALOR_COMBUSTIBLE, B.DOC_COMBUSTIBLE, B.CAUSA, B.RECOMENDACION, B.COLOR, B.IND_SOLUCION, B.EJECUTOR, B.ULT_INSPECCION, B.OT, B.ULT_MOD_OBS, B.ACCION, B.CONDICION, CASE B.STATUS WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, B.FECHA_PROGRAMADA, B.USERDATE, B.USERNAME, B.STATUS as IDSTATUS  from bitacoras B INNER JOIN EQUIPOS AS G ON dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION)=G.CODIGO AND B.UBICACION = G.UBICACION INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = 'CERRO COLORADO' AND M.DESCRIPCION = '" & sist &"' AND B.CONDICION IN ('REPROG','EJEC') "
	if ID <> "" then
		query = query & " AND ID = '"& ID &"' AND B.EQUIPO = '" &EQUIPO& "'"
	else
		query = query & " AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = '" &EQUIPO& "'"
	end if
	query = query & " ORDER BY FECHA DESC, ID DESC"

	'response.write query
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
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
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(7).Value & "</EQUIPO>"
   		  Response.Write "<REPORT>" & ORs.Fields.Item(8).Value & "</REPORT>"
  		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(9).Value & "</CRITICIDAD>"
  		  Response.Write "<TIPO_TURNO>" & ORs.Fields.Item(10).Value & "</TIPO_TURNO>"
   		  Response.Write "<DANO>" & ORs.Fields.Item(11).Value & "</DANO>"
   		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(12).Value & "</PRIORIDAD>"
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(13).Value & "</IND_DANO>"
		  Response.Write "<COMBUSTIBLE>" & ORs.Fields.Item(14).Value & "</COMBUSTIBLE>"
		  Response.Write "<VALOR_COMBUSTIBLE>" & ORs.Fields.Item(15).Value & "</VALOR_COMBUSTIBLE>"
		  Response.Write "<DOC_COMBUSTIBLE>" & ORs.Fields.Item(16).Value & "</DOC_COMBUSTIBLE>"
 		  Response.Write "<CAUSA>" & ORs.Fields.Item(17).Value & "</CAUSA>"
		  Response.Write "<RECOMENDACION>" & ORs.Fields.Item(18).Value & "</RECOMENDACION>"
		  Response.Write "<COLOR>" & ORs.Fields.Item(19).Value & "</COLOR>"
		  Response.Write "<IND_SOLUCION>" & ORs.Fields.Item(20).Value & "</IND_SOLUCION>"
		  Response.Write "<EJECUTOR>" & ORs.Fields.Item(21).Value & "</EJECUTOR>"
		  Response.Write "<ULT_INSPECCION>" & ORs.Fields.Item(22).Value & "</ULT_INSPECCION>"
		  Response.Write "<OT>" & ORs.Fields.Item(23).Value & "</OT>"
		  Response.Write "<ULT_MOD_OBS>" & ORs.Fields.Item(24).Value & "</ULT_MOD_OBS>"
		  Response.Write "<ACCION>" & ORs.Fields.Item(25).Value & "</ACCION>"
		  Response.Write "<CONDICION>" & ORs.Fields.Item(26).Value & "</CONDICION>"
		  Response.Write "<STATUS>" & ORs.Fields.Item(27).Value & "</STATUS>"
		  Response.Write "<IDSTATUS>" & ORs.Fields.Item(31).Value & "</IDSTATUS>"
		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(28).Value & "</FECHA_PROGRAMADA>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(29).Value & "</USERDATE>"
		  Response.Write "<USERNAME>" & ORs.Fields.Item(30).Value & "</USERNAME>"
	  Response.Write "</ROW>"
		ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listComponentesMoviles()

	query = "SELECT M.DESCRIPCION AS EQUIPO, G.CODIGO, G.DESCRIPCION AS GRUPO, C.DESCRIPCION AS COMPONENTE, C.CODIGO FROM EQUIPOS AS C INNER JOIN EQUIPOS AS G ON dbo.EquipoPrincipalFaena(C.CODIGO,C.UBICACION)=G.CODIGO AND C.UBICACION = G.UBICACION INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(C.CODIGO,C.UBICACION)=M.CODIGO AND C.UBICACION = M.UBICACION WHERE C.UBICACION = 'CERRO COLORADO' AND G.CODIGO = '" & EQUIPO &"' AND M.DESCRIPCION = '" & SISTEMA & "'"
	
	
'	response.write query
	
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	context = context &  "<option value='-1'>[-- Seleccione --]</option>"
	While Not ORs.EOF 
		context = context &  "<option value='"& trim(ORs.Fields.Item(4).Value) &"' selected>"& trim(ORs.Fields.Item(3).Value) &"</option>"
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetBitacoraUlt()

	query = "SELECT TOP 1 dbo.EquipoPrincipalFaena(B1.EQUIPO,B1.UBICACION) AS EQUIPO, CASE MIN(B1.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, B1.STATUS AS IDSTATUS,(select MAX(B.ULT_INSPECCION) from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'CAMBIO' AND M.DESCRIPCION = 'CINTA'  AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " & strNvl(EQUIPO) & " AND B.ULT_INSPECCION IS NOT NULL) UCC, (select MAX(B.ULT_INSPECCION) from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES ELECTRICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " & strNvl(EQUIPO) & " AND B.ULT_INSPECCION IS NOT NULL) UME, (select MAX(B.ULT_INSPECCION) from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION  where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES MECANICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " & strNvl(EQUIPO) & " AND B.ULT_INSPECCION IS NOT NULL) UMM, (select MAX(B.ULT_INSPECCION) from bitacoras B  INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION  where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'INSTRUMENTACION' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " & strNvl(EQUIPO) & " AND B.ULT_INSPECCION IS NOT NULL) UMI FROM BITACORAS AS B1 WHERE B1.UBICACION = "&strNvl(FAENA)&" AND  B1.IND_SOLUCION = 'FALSE' AND B1.CONDICION IN ('REPROG','EJEC') " 
	if EQUIPO <> "" then
		query = query & "  AND dbo.EquipoPrincipalFaena(B1.EQUIPO,B1.UBICACION) = " &strNvl(EQUIPO)
	end if
	query = query & "  GROUP BY B1.EQUIPO, B1.UBICACION, B1.STATUS ORDER BY B1.STATUS ASC "

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  Response.Write "<STATUS>" & ORs.Fields.Item(1).Value & "</STATUS>"
		  Response.Write "<IDSTATUS>" & ORs.Fields.Item(2).Value & "</IDSTATUS>"
		  Response.Write "<UCC>" & ORs.Fields.Item(3).Value & "</UCC>"
		  Response.Write "<UME>" & ORs.Fields.Item(4).Value & "</UME>"
		  Response.Write "<UMM>" & ORs.Fields.Item(5).Value & "</UMM>"
		  Response.Write "<UMI>" & ORs.Fields.Item(6).Value & "</UMI>"
	  Response.Write "</ROW>"
		ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetBitacoraUltFull()

	query = "SELECT TOP 1 dbo.EquipoPrincipalFaena(B1.EQUIPO,B1.UBICACION) AS EQUIPO, CASE MIN(B1.STATUS) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, B1.STATUS AS IDSTATUS, (select MAX(B.ULT_INSPECCION) from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'CAMBIO' AND M.DESCRIPCION = 'CINTA' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND B.ULT_INSPECCION IS NOT NULL) UCC, (select MAX(B.ULT_INSPECCION) from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES ELECTRICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND B.ULT_INSPECCION IS NOT NULL) UME, (select MAX(B.ULT_INSPECCION) from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES MECANICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND B.ULT_INSPECCION IS NOT NULL) UMM, (select MAX(B.ULT_INSPECCION) from bitacoras B  INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION  where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'TRUE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'INSTRUMENTACION' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND B.ULT_INSPECCION IS NOT NULL) UMI, (select TOP 1 B.DESCRIPCION from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'CAMBIO' AND M.DESCRIPCION = 'CINTA' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " ORDER BY B.ID DESC) UCC_BIT, (select TOP 1 B.DESCRIPCION from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES ELECTRICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " ORDER BY B.ID DESC) UME_BIT, (select TOP 1 B.DESCRIPCION from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES MECANICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " ORDER BY B.ID DESC) UMM_BIT, (select TOP 1 B.DESCRIPCION from bitacoras B  INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'INSTRUMENTACION' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " ORDER BY B.ID DESC) UMI_BIT, (select TOP 1 B.FECHA_PROGRAMADA from bitacoras B INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'CAMBIO' AND M.DESCRIPCION = 'CINTA' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND FECHA_PROGRAMADA IS NOT NULL ORDER BY B.ID DESC) UCCFPROG, (select TOP 1 B.FECHA_PROGRAMADA from bitacoras B  INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION  where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES ELECTRICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND FECHA_PROGRAMADA IS NOT NULL ORDER BY B.ID DESC) UMEFPROG, (select TOP 1 B.FECHA_PROGRAMADA from bitacoras B  INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION  where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'COMPONENTES MECANICOS' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND FECHA_PROGRAMADA IS NOT NULL ORDER BY B.ID DESC) UMMFPROG, (select TOP 1 B.FECHA_PROGRAMADA from bitacoras B  INNER JOIN EQUIPOS AS M ON dbo.GrupoMovil(B.EQUIPO,B.UBICACION)=M.CODIGO AND B.UBICACION = M.UBICACION  where B.UBICACION = "&strNvl(FAENA)&" AND B.CONDICION IN ('REPROG','EJEC') AND IND_SOLUCION = 'FALSE' AND B.ACCION = 'MTTO' AND M.DESCRIPCION = 'INSTRUMENTACION' AND dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) = " &strNvl(EQUIPO)& " AND FECHA_PROGRAMADA IS NOT NULL ORDER BY B.ID DESC) UMIFPROG FROM BITACORAS AS B1 WHERE B1.UBICACION = "&strNvl(FAENA)&" AND  B1.IND_SOLUCION = 'FALSE' AND B1.CONDICION IN ('REPROG','EJEC') " 
	if EQUIPO <> "" then
		query = query & "  AND dbo.EquipoPrincipalFaena(B1.EQUIPO,B1.UBICACION) = " &strNvl(EQUIPO)
	end if
	query = query & "  GROUP BY B1.EQUIPO, B1.UBICACION, B1.STATUS ORDER BY B1.STATUS ASC "

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  Response.Write "<STATUS>" & ORs.Fields.Item(1).Value & "</STATUS>"
		  Response.Write "<IDSTATUS>" & ORs.Fields.Item(2).Value & "</IDSTATUS>"
		  Response.Write "<UCC>" & ORs.Fields.Item(3).Value & "</UCC>"
		  Response.Write "<UME>" & ORs.Fields.Item(4).Value & "</UME>"
		  Response.Write "<UMM>" & ORs.Fields.Item(5).Value & "</UMM>"
		  Response.Write "<UMI>" & ORs.Fields.Item(6).Value & "</UMI>"
		  Response.Write "<UCC_BIT>" & ORs.Fields.Item(7).Value & "</UCC_BIT>"
		  Response.Write "<UME_BIT>" & ORs.Fields.Item(8).Value & "</UME_BIT>"
		  Response.Write "<UMM_BIT>" & ORs.Fields.Item(9).Value & "</UMM_BIT>"
		  Response.Write "<UMI_BIT>" & ORs.Fields.Item(10).Value & "</UMI_BIT>"
		  Response.Write "<UCC_FECHP>" & ORs.Fields.Item(11).Value & "</UCC_FECHP>"
		  Response.Write "<UME_FECHP>" & ORs.Fields.Item(12).Value & "</UME_FECHP>"
		  Response.Write "<UMM_FECHP>" & ORs.Fields.Item(13).Value & "</UMM_FECHP>"
		  Response.Write "<UMI_FECHP>" & ORs.Fields.Item(14).Value & "</UMI_FECHP>"
		  
	  Response.Write "</ROW>"
		ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listExistentes()

	query = "SELECT  TOP 20 TX1.FOLIO, TX1.LINEA, TX1.PILA, TX1.PILA_REL, TX1.PLANTA, convert(varchar, TX1.FECHA, 103) AS FECHA, TX1.USERNAME, TX1.ACTIVO from TREN TX1  WHERE  TX1.PILA_REL IS NOT NULL AND TX1.FAENA = 'CERRO COLORADO' AND ACTIVO = 'ACT' AND JERARQUIA IS NOT NULL  GROUP BY TX1.FOLIO, TX1.LINEA, TX1.PILA, TX1.PILA_REL, TX1.PLANTA, convert(varchar, TX1.FECHA, 103), TX1.USERNAME, TX1.ACTIVO  ORDER BY FECHA DESC, TX1.PLANTA, TX1.FOLIO DESC"
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	PLANTA = replace(planta, " ", "-")
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
'		context = context &  "<li onclick=""loadrisk('" & trim(ORs.Fields.Item(0).Value) & "','" & trim(ORs.Fields.Item(1).Value) & "','" & trim(ORs.Fields.Item(2).Value) & "','" & trim(ORs.Fields.Item(4).Value) & "','" & trim(ORs.Fields.Item(7).Value) & "','" & trim(ORs.Fields.Item(8).Value) & "','" & trim(ORs.Fields.Item(9).Value) & "','" & trim(ORs.Fields.Item(11).Value) & "');""><a href='#'><table width='100%' border='0' cellspacing='1' cellpadding='1'><tr><td width='60'>FOLIO "& trim(ORs.Fields.Item(0).Value) &"</td><td width='60'> LINEA "& trim(ORs.Fields.Item(1).Value) &"</td><td width='60'> PILA "& trim(ORs.Fields.Item(2).Value) &"</td><td width='30'><img src='images/2_ARROWS.png' width='20' height='20' /></td><td width='60'> PILA "& trim(ORs.Fields.Item(3).Value) &"</td><td width='60'> "& trim(ORs.Fields.Item(4).Value) &"</td><td width='120'  align='center'> FECHA "& trim(ORs.Fields.Item(5).Value) & "</td>"

		context = context &  "<li onclick=""loadrisk('" & trim(ORs.Fields.Item(0).Value) & "','" & trim(ORs.Fields.Item(1).Value) & "','" & trim(ORs.Fields.Item(2).Value) & "','" & trim(ORs.Fields.Item(3).Value) & "','" & trim(ORs.Fields.Item(4).Value) & "','" & trim(ORs.Fields.Item(7).Value) & "','" & trim(ORs.Fields.Item(5).Value) & "','" & trim(ORs.Fields.Item(0).Value) & "','" & trim(ORs.Fields.Item(1).Value) & "','" & trim(ORs.Fields.Item(2).Value) & "','" & trim(ORs.Fields.Item(3).Value) & "','" & trim(ORs.Fields.Item(4).Value) & "','" & trim(ORs.Fields.Item(7).Value) & "','" & trim(ORs.Fields.Item(5).Value) & "');""><a href='#'><table width='100%' border='0' cellspacing='1' cellpadding='1'><tr><td width='60'>FOLIO "& trim(ORs.Fields.Item(0).Value) &"</td><td width='60'> LINEA "& trim(ORs.Fields.Item(1).Value) &"</td><td width='70'> PILA "& trim(ORs.Fields.Item(2).Value) &"</td><td width='60'> "& trim(ORs.Fields.Item(4).Value) &"</td><td width='120'  align='center'> FECHA "& trim(ORs.Fields.Item(5).Value) & "</td><td width='70'  align='center'> "
		if trim(ORs.Fields.Item(7).Value) = "ACT" then 
			context = context &  "OPERATIVO</td>"
		elseif  trim(ORs.Fields.Item(7).Value) = "STB" then 
			context = context &  "PROPUESTA</td>"
		end if

'		if (trim(ORs.Fields.Item(7).Value) <> "") then
'			if (trim(ORs.Fields.Item(0).Value) <> trim(ORs.Fields.Item(7).Value)) then
'				context = context &  "<td width='60'>  FOLIO "& trim(ORs.Fields.Item(7).Value) &"</td>"
'			end if
'			context = context &  "<td width='60'>  LINEA "& trim(ORs.Fields.Item(8).Value) &"</td><td width='60'>  PILA "& trim(ORs.Fields.Item(9).Value) &"</td><td width='30'><img src='images/2_ARROWS.png' width='20' height='20' /></td><td width='60'> PILA "& trim(ORs.Fields.Item(10).Value) &"</td><td width='60'>  "& trim(ORs.Fields.Item(11).Value) &" </td></tr></table>"	
'		else
			context = context &  "<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>"
'		end if
		ORs.MoveNext 
	Wend
	context = context &  " </a></li>"
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listHistorial()

	query = "SELECT  TOP 20 TX1.FOLIO, TX1.LINEA, TX1.PILA, TX1.PILA_REL, TX1.PLANTA, convert(varchar, TX1.FECHA, 103) + ' ' + convert(nvarchar(5), TX1.FECHA, 108)  AS FECHA, TX1.USERNAME, TX1.ACTIVO, TX1.STATUS_OP, TX1.ID_HISTORIAL  from TREN_HISTORIAL TX1  WHERE  TX1.PILA_REL IS NOT NULL  AND JERARQUIA IS NOT NULL AND TX1.FAENA = 'CERRO COLORADO' "
	if FOLIO <> "" THEN
		query = query & "AND TX1.FOLIO = '"&FOLIO&"' "
	END IF		
	if LINEA <> "" THEN
		query = query & "AND TX1.LINEA = '"&LINEA&"' "
	END IF	
	if PILA1 <> "" THEN
		query = query & "AND TX1.PILA = '"&PILA1&"' "
	END IF	
	if ESTADO <> "" THEN
		query = query & "AND TX1.ACTIVO = '"&ESTADO&"' "
	END IF	
	if PLANTA <> "" THEN
		query = query & "AND TX1.PLANTA = '"&PLANTA&"' "
	END IF	
	if FECHA_INI <> "" THEN
		query = query & "AND convert(varchar, TX1.FECHA, 103) = '"&FECHA_INI&"' "
	END IF	
	query = query & " GROUP BY TX1.FOLIO, TX1.LINEA, TX1.PILA, TX1.PILA_REL, TX1.PLANTA, convert(varchar, TX1.FECHA, 103) + ' ' + convert(nvarchar(5), TX1.FECHA, 108), TX1.USERNAME, TX1.ACTIVO, TX1.STATUS_OP, TX1.ID_HISTORIAL ORDER BY ID_HISTORIAL DESC"
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	PLANTA = replace(planta, " ", "-")
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
'		context = context &  "<li onclick=""loadrisk('" & trim(ORs.Fields.Item(0).Value) & "','" & trim(ORs.Fields.Item(1).Value) & "','" & trim(ORs.Fields.Item(2).Value) & "','" & trim(ORs.Fields.Item(4).Value) & "','" & trim(ORs.Fields.Item(7).Value) & "','" & trim(ORs.Fields.Item(8).Value) & "','" & trim(ORs.Fields.Item(9).Value) & "','" & trim(ORs.Fields.Item(11).Value) & "');""><a href='#'><table width='100%' border='0' cellspacing='1' cellpadding='1'><tr><td width='60'>FOLIO "& trim(ORs.Fields.Item(0).Value) &"</td><td width='60'> LINEA "& trim(ORs.Fields.Item(1).Value) &"</td><td width='60'> PILA "& trim(ORs.Fields.Item(2).Value) &"</td><td width='30'><img src='images/2_ARROWS.png' width='20' height='20' /></td><td width='60'> PILA "& trim(ORs.Fields.Item(3).Value) &"</td><td width='60'> "& trim(ORs.Fields.Item(4).Value) &"</td><td width='120'  align='center'> FECHA "& trim(ORs.Fields.Item(5).Value) & "</td>"

		context = context &  "<li onclick=""loadHistorico('" & trim(ORs.Fields.Item(9).Value) & "','" & trim(ORs.Fields.Item(0).Value) & "','" & trim(ORs.Fields.Item(1).Value) & "','" & trim(ORs.Fields.Item(2).Value) & "','" & trim(ORs.Fields.Item(4).Value) & "','" & trim(ORs.Fields.Item(7).Value) & "','" & trim(ORs.Fields.Item(5).Value) & "','" & trim(ORs.Fields.Item(8).Value) & "','" & trim(ORs.Fields.Item(6).Value) & "');""><a href='#'><table width='100%' border='0' cellspacing='1' cellpadding='1'><tr><td width='8%'  align='center'>FOLIO "& trim(ORs.Fields.Item(0).Value) &"</td><td width='8%'  align='center'> LINEA "& trim(ORs.Fields.Item(1).Value) &"</td><td width='10%'  align='center'> "
		if trim(ORs.Fields.Item(7).Value) = "ACT" then 
			context = context &  "OPERATIVO</td>"
		elseif  trim(ORs.Fields.Item(7).Value) = "STB" then 
			context = context &  "PROPUESTA</td>"
		end if		
		context = context &  "<td width='10%'  align='center'> PILA "& trim(ORs.Fields.Item(2).Value) &"</td><td width='30'> "& trim(ORs.Fields.Item(4).Value) &"</td><td width='25%'   align='center'> FECHA "& trim(ORs.Fields.Item(5).Value) & "</td>"

'		if (trim(ORs.Fields.Item(7).Value) <> "") then
'			if (trim(ORs.Fields.Item(0).Value) <> trim(ORs.Fields.Item(7).Value)) then
'				context = context &  "<td width='60'>  FOLIO "& trim(ORs.Fields.Item(7).Value) &"</td>"
'			end if
			context = context &  "<td width='30%'> "& trim(ORs.Fields.Item(8).Value) &"</td>"	
'		else
			context = context &  "</tr></table>"
'		end if
		ORs.MoveNext 
	Wend
	context = context &  " </a></li>"
	'context = context &  "</ul>"
	response.write context
	Set ORs = Nothing
	Set ODB = Nothing
end function

function LoadHistorialTren()
	FAENA = "CERRO COLORADO"
	query = " SELECT dbo.EquipoPrincipal(E.CODIGO) AS EQUIPO, replace(E.DESCRIPCION,'CORREA ','') as DESCRIPCION, S.PLANTA, T.SECUENCIA, T.TIPO_EQUIPO, T.PILA, CASE MIN(ISNULL(B.STATUS,7)) WHEN 1 THEN 'down.png' WHEN 3 THEN 'right_down.png' WHEN 4 THEN 'right.png' WHEN 5 THEN 'right_up.png' WHEN 7 THEN 'up.png' ELSE 'up.png' END AS STATUS, E.MARCA FROM dbo.EQUIPOS AS E INNER JOIN dbo.SECCIONES AS S ON E.SECCION = S.CODIGO LEFT OUTER JOIN TREN_HISTORIAL AS T ON E.CODIGO = T.EQUIPO  LEFT JOIN BITACORAS AS B ON E.CODIGO = dbo.EquipoPrincipalFaena(B.EQUIPO,B.UBICACION) AND E.UBICACION = B.UBICACION AND B.STATUS IS NOT NULL AND B.IND_SOLUCION = 'FALSE' WHERE  (E.UBICACION = '"&FAENA&"') AND (E.COD_EQUIPO_PADRE IS NULL) AND (E.ESTADO = 'ACT')  AND (E.TIPO_EQUIPO = 1 OR E.TIPO_EQUIPO = 17) and (E.DESCRIPCION like '%movil%' OR E.DESCRIPCION like '%STACKER%' OR E.DESCRIPCION like '%TRIPPER%' OR E.DESCRIPCION like '%DERIVADOR%' OR E.DESCRIPCION like '%TRASPASO%' OR E.DESCRIPCION like '%ORUGA%') AND "
	query = query & " T.ID_HISTORIAL = '"&IDHISTORIAL&"' AND T.LINEA = '"&LINEA&"' AND T.PILA = '"&PILA1&"' AND T.PLANTA = '"&PLANTA&"' AND T.IND_OPERATIVO = '"&IND_OP&"' "
	if FOLIO <> "" THEN
		query = query & "AND T.FOLIO = '"&FOLIO&"' "
	END IF		
	if ESTADO <> "" THEN
		query = query & "AND T.ACTIVO = '"&ESTADO&"' "
	END IF	
	if JERARQUIA <> "" THEN
		query = query & "AND T.JERARQUIA = '"&JERARQUIA&"' "
	END IF	
	if ACCION <> "" THEN
		query = query & "AND T.STATUS_OP = '"&ACCION&"' "
	END IF	
	
	query = query & " GROUP BY  dbo.EquipoPrincipal(E.CODIGO), E.DESCRIPCION ,S.PLANTA, T.SECUENCIA, T.TIPO_EQUIPO, T.PILA, E.MARCA ORDER BY T.SECUENCIA"
	'response.write query
	'response.end
	Set ORs =oDB.EjecutaSql(query)
'------------------------------------------------------------------------------------------------------------------------------------------------	
	Dim strName
	N=0
	context = ""
	'context = context &  "<ul class='listdragable ui-droppable'>"
	While Not ORs.EOF 
		N=N+1
		if  trim(ORs.Fields.Item(4).Value) = "M" then
			context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'><img src='Scripts/"& trim(ORs.Fields.Item(6).Value) &"' alt='' style='vertical-align:middle'/><label style='border-style:solid; border-width:1px; padding:2px;'> " & N & " </label>&nbsp;&nbsp;"& trim(ORs.Fields.Item(0).Value) 
			if trim(ORs.Fields.Item(7).Value) = "STM" then 
				context = context &  "<img id='mark' src='images/ICON_STM.png'/>"
			end if
			context = context &  "</li>"
		elseif trim(ORs.Fields.Item(4).Value) = "F" then
			context = context &  "<li class='itemSort1 ui-draggable' id='Li"& N &"'>&nbsp;"& trim(ORs.Fields.Item(1).Value) &"</li>"
		end if
		ORs.MoveNext 
	Wend
	'context = context &  "</ul>"
	if err.number <> 0 then
		response.write "ERR"
	elseif N = 0 then
		response.write "EMPTY"
	else
		response.write context
	end if
end function	

	Set ORs = Nothing
	Set oDB = Nothing
%>