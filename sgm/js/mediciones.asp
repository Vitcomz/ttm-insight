<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 11274

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
EXCEL=UCASE(REQUEST("EXCEL"))
FOLIO=UCASE(REQUEST("FOLIO"))
FECHA=UCASE(REQUEST("FECHA"))
FAENA=UCASE(REQUEST("FAENA"))
FECHAS=UCASE(REQUEST("FECHAS"))
FAENA=UCASE(REQUEST("FAENA"))
DIST=UCASE(REQUEST("DIST"))
FECHA_CAMBIO=UCASE(REQUEST("FECHA_CAMBIO"))
FECHA_ULT_MAN=UCASE(REQUEST("FECHA_ULT_MAN"))
DIAS_PROY=UCASE(REQUEST("DIAS_PROY"))

EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
EQUIPOS=UCASE(REQUEST("EQUIPOS"))
DESGASTES=UCASE(REQUEST("DESGASTES"))
DUREZA=UCASE(REQUEST("DUREZA"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
USUARIO=UCASE(REQUEST("USUARIO"))
AREA=UCASE(REQUEST("AREA"))
RUT=UCASE(REQUEST("RUT"))
DISCIPLINA=UCASE(REQUEST("DISCIPLINA"))
DIST =UCASE(REQUEST("DIST"))
DIAS_OPERACION=UCASE(REQUEST("DIAS_OPERACION"))

EDAD=UCASE(REQUEST("EDAD"))
INSPECTOR=UCASE(REQUEST("INSPECTOR"))

SECCION=UCASE(REQUEST("SECCION"))
OBSERVACION=UCASE(REQUEST("OBSERVACION"))
SUCURSAL=UCASE(REQUEST("SUCURSAL"))
STR=UCASE(REQUEST("STR"))
SECCION=UCASE(REQUEST("SECCION"))
REPORT=UCASE(REQUEST("REPORT"))
TURNO=UCASE(REQUEST("TURNO"))
TIPO=UCASE(REQUEST("TIPO"))
MES=UCASE(REQUEST("MES"))
MUESTREO=UCASE(REQUEST("MUESTREO"))
RETORNO=UCASE(REQUEST("RETORNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
VALOR=UCASE(REQUEST("VALOR"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))



Select Case RECURSO

	case "getMedicion"
		  getMedicion()
	
	case "updateMedicion"
		  updateMedicion()
	
	case "newMedicion"
		  newMedicion()
		  
	case "newMedValor"
		  newMedValor()
	
	case "newTonValor"
		  newTonValor()
		  
	case "listMediciones"
		  listMediciones()
	
	case "listLecturasTon"
		  listLecturasTon()
		  
	case "listMedValor"
		  listMedValor()
		  
	case "excelMediciones"
		  excelMediciones()

	case "grProyec"
		  grProyec()
	
	case "listProyeccion"
		  listProyeccion()	  
	
	case "setProyeccion"
		  setProyeccion()	
		  	  	  
	case "delMedValor"
		  delMedValor()	 	  	  
	
	case "delMedicion"
		  delMedicion()	
	
	case "delTonValor"
		 delTonValor()	 
		  
end select

function getMedicion()

	query = "SELECT M.FOLIO, M.FECHA , M.EQUIPO, E.DESCRIPCION, M.INSPECTOR, M.FECHA_CAMBIO, "
	query = query & " M.DURACION, M.FECHA_ULTM_MANTENCION, E.ANCHO, E.ESPESOR, E.ESPESOR_R,"
	query = query & " T.DESCRIPCION, M.OBSERVACION, M.DUREZA, M.DISTANCIA " 
	query = query & " FROM MEDICIONES AS M, EQUIPOS AS E, TIPO_EQUIPOS AS T "
	query = query & " WHERE E.CODIGO = M.EQUIPO AND E.TIPO_EQUIPO=T.CODIGO"
	query = query & " AND FOLIO=" & strNvl(FOLIO) 
	query = query & " AND E.UBICACION=" & strNvl(FAENA)
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	
	Response.Write "<REGISTRO>"
		
	While Not Rs.EOF 
		Response.Write "<ROW>"
		 Response.Write "<FOLIO>" & Rs.Fields.Item(0).Value & "</FOLIO>"
		 Response.Write "<FECHA_MED>" & Rs.Fields.Item(1).Value & "</FECHA_MED>"
		 Response.Write "<CODIGO>" & Rs.Fields.Item(2).Value & "</CODIGO>"
		 Response.Write "<DESCRIPCION>" & Rs.Fields.Item(3).Value & "</DESCRIPCION>"
		 Response.Write "<INSPECTOR>" & Rs.Fields.Item(4).Value & "</INSPECTOR>"
		 Response.Write "<FECHA_CAMBIO>" & Rs.Fields.Item(5).Value & "</FECHA_CAMBIO>"
		 Response.Write "<DIAS_PROY>" & Rs.Fields.Item(6).Value & "</DIAS_PROY>"
		 Response.Write "<FECHA_ULT_MAN>" & Rs.Fields.Item(7).Value & "</FECHA_ULT_MAN>"
		 Response.Write "<ANCHO>" & Rs.Fields.Item(8).Value & "</ANCHO>"
		 Response.Write "<ESPESOR>" & Rs.Fields.Item(9).Value & "</ESPESOR>"
		 Response.Write "<ESPESOR_R>" & Rs.Fields.Item(10).Value & "</ESPESOR_R>"
		 Response.Write "<DESC_TIPO_EQUIPO>" & Rs.Fields.Item(11).Value & "</DESC_TIPO_EQUIPO>"
		 Response.Write "<OBSERVACION>" & Rs.Fields.Item(12).Value & "</OBSERVACION>"
		 Response.Write "<DUREZA>" & Rs.Fields.Item(13).Value & "</DUREZA>"
		 Response.Write "<DISTANCIA>" & Rs.Fields.Item(14).Value & "</DISTANCIA>"
		 Response.Write "</ROW>"
		 Rs.MoveNext
	Wend
	
	Response.Write "</REGISTRO>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function newMedicion()

	query = "SELECT MAX(FOLIO) AS NUM FROM MEDICIONES "

	Set ORs =oDB.EjecutaSql(query)

	If Len(oRs("NUM"))>0 Then
		N = oRs("NUM") + 1
	Else
		N = 1
	End If
	 
	query = "set dateformat dmy INSERT INTO MEDICIONES (FOLIO, FECHA, EQUIPO, INSPECTOR, DIAS_OP, "
	query = query & "FECHA_ULTM_MANTENCION, OBSERVACION, DUREZA, FECHA_CAMBIO, DIAS_PROY, DISTANCIA, FAENA) VALUES" 
	query = query & " (" & N
	query = query & " ," & strNvl(FECHA)
	query = query & " ," & strNvl(EQUIPO)
	query = query & " ," & strNvl(INSPECTOR)
	query = query & " ," & strNvl(DIAS_OPERACION)
	query = query & " ," & strNvl(FECHA_ULT_MAN)
	query = query & " ," & strNvl(OBSERVACION)
	query = query & " ," & strNvl(DUREZA)
	query = query & " ," & strNvl(FECHA_CAMBIO)
	query = query & " ," & strNvl(DIAS_PROY)
	query = query & " ," & strNvl(DIST)
	query = query & " ," & strNvl(FAENA) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW><FOLIO>" & N & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateMedicion()

	query = "UPDATE MEDICIONES SET " 
	query = query & " FECHA=" & strNvl(FECHA)
	query = query & " ,EQUIPO=" & strNvl(EQUIPO)
	'query = query & " ,INSPECTOR=" & strNvl(INSPECTOR)
	query = query & " ,DIAS_OPERACION=" & strNvl(DIAS_OPERACION)
	query = query & " ,OBSERVACION=" & strNvl(OBSERVACION)
	query = query & " ,DUREZA=" & strNvl(DUREZA)
	query = query & " ,FECHA_ULTM_MANTENCION=" & strNvl(FECHA_ULT_MAN)
	query = query & " ,FECHA_CAMBIO=" & strNvl(FECHA_CAMBIO)
	query = query & " ,DIAS_PROY=" & strNvl(DIAS_PROY)
	query = query & " ,DISTANCIA=" & strNvl(DISTANCIA)
	query = query & " WHERE FOLIO=" & strNvl(FOLIO)
	'query = query & " WHERE FOLIO=" & strNvl(FOLIO)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><FOLIO>" & FOLIO & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function newMedValor()

	Dim aMuestreo
	Dim aRetorno
	
	aMuestreo = Split(MUESTREO, ";")
	aRetorno = Split(RETORNO, ";")
	
	query = "DELETE MEDICIONES_VALOR WHERE FOLIO = " & strNvl(FOLIO) 
	query = query & " AND TIPO = " & strNvl(TIPO) 
	
	Set ORs = oDB.EjecutaSql(query)
	
	
	i=1
	
	While i<=ubound(aMuestreo) 
		 
			query = "INSERT INTO MEDICIONES_VALOR (" 
			query = query & " FOLIO, "
			query = query & " ID, VALOR, TIPO) "
			query = query & " VALUES ("
			query = query & strNvl(FOLIO) & ","
			query = query & strNvl(i) & ","
			query = query & strNvl(aMuestreo(i)) & "," & strNvl(TIPO) & ")"	
			Set ORs =oDB.EjecutaSql(query)
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend

'	i=1
'	
'	While i<=ubound(aRetorno) 
'		 
'			query = "UPDATE MEDICIONES_VALOR " 
'			query = query & " SET RETORNO =" & strNvl(aRetorno(i))
'			query = query & " WHERE FOLIO = " & strNvl(FOLIO)
'			query = query & " AND  ID="& strNvl(i)
'			Set ORs =oDB.EjecutaSql(query)
'			'Response.Write(aMuestreo(i))
'		i=i+1
'	Wend
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function newTonValor()

	
			query = "INSERT INTO TONELAJE (" 
			query = query & " EQUIPO, VALOR, "
			query = query & " FECHA, FAENA, USERNAME, USERDATE ) "
			query = query & " VALUES ("
			query = query & strNvl(EQUIPO) & ","
			query = query & strNvl(VALOR) & ","
			query = query & strNvl(FECHA) & ","
			query = query & strNvl(FAENA) & ","
			query = query & strNvl(USUARIO) & ","
			query = query &  "GETDATE())"	
			Set ORs =oDB.EjecutaSql(query)
			
	 
			query = "UPDATE EQUIPOS " 
			query = query & " SET TON_SEMANAL =" & strNvl(VALOR)
			query = query & " , HOROMETRO = HOROMETRO + " & strNvl(VALOR)
			query = query & " WHERE CODIGO = " & strNvl(EQUIPO)
			query = query & " AND  UBICACION="& strNvl(FAENA)
			
			Set ORs =oDB.EjecutaSql(query)
			
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function listMediciones()

	query = "  set dateformat dmy SELECT isnull(FECHA, FECHA_ULT_MAN)   FROM EQUIPOS WHERE CODIGO=" & strNvl(EQUIPO)
	query = query & " AND UBICACION=" & strNvl(FAENA)
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	While Not ORs1.EOF
		FECHA_INS = ORs1.Fields.Item(0).Value
		ORs1.MoveNext
	Wend 
	
	
	query =	" set dateformat dmy SELECT M.FOLIO, M.FECHA, M.EQUIPO, M.INSPECTOR, MV.TIPO, isnull(M.DISTANCIA,100) "
	query = query & " FROM MEDICIONES AS M "
	query = query & " LEFT OUTER JOIN MEDICIONES_VALOR AS MV  ON M.FOLIO=MV.FOLIO "
	query = query & " WHERE FAENA = " & strNvl(FAENA)
	'query = query & " AND ESTADO is null "

	If len(FECHA)>0 THEN
			query = query & " AND FECHA= " & strNvl(FECHA) 
	End If
	
	IF EQUIPO<>"TOD" THEN
		query = query & " AND  EQUIPO = " & strNvl(EQUIPO) & "" 
	END IF
	query = query & " GROUP BY M.FOLIO, M.FECHA, M.EQUIPO, M.INSPECTOR,  MV.TIPO, M.DISTANCIA"
	query = query & " ORDER BY M.FECHA DESC, M.EQUIPO, MV.TIPO "
	
	Set ORs =oDB.EjecutaSql(query)
	' response.write query 
	' exit function 
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>"  
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<FECHA_INS>" & FECHA_INS & "</FECHA_INS>"
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(2).Value & "</EQUIPO>"
		  Response.Write "<INSPECTOR>" & ORs.Fields.Item(3).Value & "</INSPECTOR>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(4).Value & "</TIPO>"
		  Response.Write "<DISTANCIA>" & ORs.Fields.Item(5).Value & "</DISTANCIA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listProyeccion()

query =	" select  e.descripcion,  round((sum(e.espesor-mv.valor) / sum(e.espesor))*100,2),"
query = query & " m.fecha, m.fecha_ultm_mantencion, dias_operacion, m.fecha_cambio"
query = query & " from mediciones_valor as mv, equipos as e, mediciones as m, "
query = query & " (select equipo, max(fecha) as fecha from mediciones group by equipo) as f "
query = query & "  where m.equipo=e.codigo  and m.folio = mv.folio and m.fecha = f.fecha and e.codigo=f.equipo"
query = query & "  and m.faena = " & strNvl(FAENA)
IF SECCION <> "TODOS" THEN
	query = query & "  and e.seccion = " & strNvl(SECCION)
END IF
query = query & " group by e.descripcion, m.fecha,  m.fecha_ultm_mantencion, DIAS_OPERACION, m.fecha_cambio"
query = query & " order by e.descripcion "


	Set ORs =oDB.EjecutaSql(query)
	
	strName = "espesores.xls"
	
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>Equipo</TD>"
   				   Response.Write "<TD>Desgaste</TD>"
   				   Response.Write "<TD>Fecha Muestreo</TD>"
   				   Response.Write "<TD>Fecha Ultimo Cambio</TD>"
   				   Response.Write "<TD>Dias de Operaci�n</TD>"
   				   Response.Write "<TD>Fecha Proyecci�n Cambio</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"
	Else
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>"  
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  Response.Write "<DESGASTE>" & ORs.Fields.Item(1).Value & "</DESGASTE>"
		  Response.Write "<FECHA_M>" & ORs.Fields.Item(2).Value & "</FECHA_M>"
		  Response.Write "<FECHA_UTM>" & ORs.Fields.Item(3).Value & "</FECHA_UTM>"
		  Response.Write "<DIAS>" & ORs.Fields.Item(4).Value & "</DIAS>"
		  Response.Write "<FECHA_CAMBIO>" & ORs.Fields.Item(5).Value & "</FECHA_CAMBIO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	End If
	Set ORs = Nothing
	Set ODB = Nothing
	
end function 
 

function listMedValor()

	query = "SELECT ID, VALOR "
	query = query & " FROM MEDICIONES_VALOR "
	query = query & " WHERE FOLIO= " & strNvl(FOLIO)
	query = query & " AND TIPO= " & strNvl(TIPO)
	

	query = query & " ORDER BY ID "
	 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"	
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID> "  & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End function

function excelMediciones()

	query = "SELECT M.FOLIO, M.FECHA , M.EQUIPO, E.DESCRIPCION, M.INSPECTOR, M.FECHA_CAMBIO, "
	query = query & " M.DURACION, M.FECHA_ULTM_MANTENCION, E.ANCHO, E.ESP_CAR, E.ESP_RET,"
	query = query & " T.DESCRIPCION, M.OBSERVACION, M.DUREZA, M.DISTANCIA " 
	query = query & " FROM MEDICIONES AS M, EQUIPOS AS E, TIPO_EQUIPOS AS T "
	query = query & " WHERE E.CODIGO = dbo.EquipoPrincipalFaena(M.EQUIPO, " & strNvl(FAENA) & ") AND E.TIPO_EQUIPO=T.CODIGO"
	query = query & " AND FOLIO=" & strNvl(FOLIO) 
	query = query & " AND T.UBICACION='15'"  
	
	Set Rs =oDB.EjecutaSql(query)
	
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition", "attachment;filename=medicionEsp.xls"  
	'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<br><br><br>"
	 	Response.Write "<TABLE BORDER=0>"
			Response.Write "<TR>"
			Response.Write "<TD COLSPAN=20>&nbsp;</TD>"
			Response.Write "</TR>"
		 	Response.Write "<TR>"
		 	Response.Write "<TD COLSPAN=20><center><strong>MEDICION DE ESPESORES</strong></center></TD>"
			Response.Write "</TR>"
			
			Response.Write "<TR>"
			Response.Write "<TD COLSPAN=20><center><strong>" & _
						Rs.Fields.Item(3).Value & " " & Rs.Fields.Item(2).Value & "</strong></center></TD>"
			Response.Write "</TR>"
			
			Response.Write "<TR>"
			Response.Write "<TD COLSPAN=14>&nbsp;</TD>"
			Response.Write "</TR>"
			
			Response.Write "<TR>"
			Response.Write "<TD COLSPAN=12><strong>FOLIO " & FOLIO & "</strong></TD>" 
			Response.Write "<TD COLSPAN=12>TIPO DE EQUIPO " & Rs.Fields.Item(11).Value  & "</TD>"
			Response.Write "</TR>"
			Response.Write "<TR>"	   
   			Response.Write "<TD COLSPAN=14><strong>FECHA MEDICION " & Rs.Fields.Item(1).Value  & "</strong></TD>"
			Response.Write "</TR>"
			
			Response.Write "<TR>"	   
   			Response.Write "<TD COLSPAN=12>INSPECTOR " & Rs.Fields.Item(4).Value  & "</TD>"
			Response.Write "<TD COLSPAN=12>FECHA CAMBIO " & Rs.Fields.Item(5).Value  & _
   				    				" DIAS PROYECTADOS " & Rs.Fields.Item(6).Value  & _
   				   					" FECHA ULTIMO CAMBIO " & Rs.Fields.Item(7).Value  & "</TD>"
			Response.Write "</TR>"
			Response.Write "<TR>"
  			Response.Write "<TD COLSPAN=14>ANCHO " & Rs.Fields.Item(8).Value  & " ESPESOR " & Rs.Fields.Item(9).Value 
			Response.Write " ESPESOR RETORNO " & Rs.Fields.Item(9).Value & " DUREZA " & Rs.Fields.Item(13).Value & "</TD>"
			Response.Write "</TR>"
		  	Response.Write "<TR>"
   			Response.Write "<TD COLSPAN=15>OBSERVACION " & Rs.Fields.Item(12).Value  & "</TD>"
			Response.Write "</TR>"
			
		Response.Write "</TABLE>"	
		



		Response.Write "<br/><br/><br/>"
	
	DIST = Rs.Fields.Item(14).Value
	
	query = "SELECT ID, VALOR , TIPO "
	query = query & " FROM MEDICIONES_VALOR "
	query = query & " WHERE FOLIO= " & strNvl(FOLIO)
	query = query & " ORDER BY ID "
	 
	Set ORs =oDB.EjecutaSql(query)
	
		 
	Response.Write "<TABLE boder=1 bordercolor='000000' BGCOLOR='#CCCCCC'>"
	Response.Write "<TR><TD><strong>N� DE MEDICIONES</strong></TD>"	
	
	While Not ORs.EOF 
	  	  Response.Write "<TD ALIGN='CENTER'><strong>"  & ORs.Fields.Item(0).Value & "</strong></TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
	ORs.MoveFirst
	Response.Write "<TR><TD>DISTANCIA (mm)</TD>"	
	MM=CDBL(DIST)
	While Not ORs.EOF 
	  	  Response.Write "<TD ALIGN='CENTER'>"  & MM & "</TD>"
		  MM=MM+DIST
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
	ORs.MoveFirst
	Response.Write "<TR><TD>CUBIERTA ORIGINAL</TD>"	
	While Not ORs.EOF 
 		Response.Write "<TD ALIGN='CENTER'>" & replace(Rs.Fields.Item(9).Value,".",",") & "</TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
		
	
	ORs.MoveFirst
	Response.Write "<TR><TD>MUESTREO CUBIERTA</TD>"
	While Not ORs.EOF 	
		 
		   Response.Write "<TD ALIGN='CENTER'>" & _
		  	"<font color='#000066' style='font-family:Verdana, Arial, Helvetica, sans-serif;size:10;'>"  & _
			 replace(ORs.Fields.Item(1).Value,".",",") & "</font></TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
	ORs.MoveFirst
	Response.Write "<TR><TD>DESGASTE REAL</TD>"	
	While Not ORs.EOF 
	  	  Response.Write "<TD ALIGN='CENTER'>"  & replace(ROUND(Rs.Fields.Item(9).Value - ORs.Fields.Item(1).Value ,2),".",",") & "</TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
 
	
	Set ORs = Nothing
	Set ODB = Nothing
	
End function


function listLecturasTon()

query =	" SELECT VALOR, FECHA "
query = query & " FROM TONELAJE "
query = query & " WHERE EQUIPO = " & strNvl(EQUIPO)
query = query & " AND FAENA = " & strNvl(FAENA)

query = query & " ORDER BY FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	While Not ORs.EOF 
	  Response.Write "<ROW>"  
		  Response.Write "<VALOR>" & ORs.Fields.Item(0).Value & "</VALOR>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function
	
function setProyeccion()

	query = "UPDATE EQUIPOS SET HOROMETRO = 0 WHERE CODIGO = " & strNvl(EQUIPO) 
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function delMedicion()

	query = "DELETE MEDICIONES_VALOR WHERE FOLIO = " & strNvl(FOLIO) 
	query = query & " AND TIPO = " & strNvl(TIPO) 
	Set ORs = oDB.EjecutaSql(query)
	
	
	query = "DELETE MEDICIONES WHERE FOLIO = " & strNvl(FOLIO) 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function


function delMedValor()

	query = "DELETE MEDICIONES_VALOR WHERE FOLIO = " & strNvl(FOLIO) 
	query = query & " AND TIPO = " & strNvl(TIPO) 
	Set ORs = oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function delTonValor()

			query = "DELETE TONELAJE WHERE EQUIPO = " & strNvl(EQUIPO) & " "
			query = query & " AND VALOR = " & strNvl(VALOR) & " "
			query = query & " AND FECHA = " & strNvl(FECHA) & " " 
			query = query & " AND FAENA = " & strNvl(FAENA) & " "
			
			
			Set ORs =oDB.EjecutaSql(query)
			
	 
			query = "UPDATE EQUIPOS " 
			query = query & " SET HOROMETRO = HOROMETRO - " & strNvl(VALOR)
			query = query & " WHERE CODIGO = " & strNvl(EQUIPO)
			query = query & " AND  UBICACION="& strNvl(FAENA)
			
			Set ORs =oDB.EjecutaSql(query)
			
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function grComp()

query =	" SELECT C.CATEGORIA,"
query = query & "		   S = SUM(CASE CF.VALOR WHEN 'S' THEN 1 END),"
query = query & "		   R = SUM(CASE CF.VALOR WHEN 'R' THEN 1 END),"
query = query & "		   COUNT(*) "
query = query & "	 FROM COMPORTAMIENTOS AS C, "
query = query & "		COMP_FOLIO AS CF"
query = query & "	WHERE C.ID=CF.ID"
query = query & "	GROUP BY C.CATEGORIA "
	Set ORs = oDB.EjecutaSql(query)
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Comportamientos' shownames='1'  numDivLines='10'  bgColor='FFFFFF' showBorder='0' anchorRadius='5' anchorBorderThickness='2'>"
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
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grProyec()

    Dim aEquipos
	Dim aDesgaste
	
	aEquipos = Split(EQUIPOS, ";")
	aDesgaste = Split(DESGASTES, ";")
	
	'response.Write(ubound(aMuestreo))
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='% DE DESGASTE' shownames='1'  showvalues='1' formatNumberScale='0' showShadow='1' formatNumber='0'  rotateLabels='1' showYAxisValues='1' showDivLineValues='1' divLineThickness='3'  imageSave='1' imageSaveURL='../FCExporter.php'>"
	i=1
	Response.Write "<categories>"
	While i<=ubound(aEquipos) 
		 	Response.Write "<category label='" & aEquipos(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</categories>"

	
	i=1
	Response.Write "<dataset seriesName='% Desgaste' showValues='1' color='FF0000'>" 
	While i<=ubound(aDesgaste) 
		 	Response.Write "<set label='" & aEquipos(i) & "' value='" & aDesgaste(i) & "' />"
			'Response.Write(aProyec(i)))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	Response.Write "</chart>"
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