<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
Session.LCID = 2057

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
EXCEL=UCASE(REQUEST("EXCEL"))
FOLIO=UCASE(REQUEST("FOLIO"))
FECHA=UCASE(REQUEST("FECHA"))
FAENA=UCASE(REQUEST("FAENA"))
EQUIPOS=UCASE(REQUEST("EQUIPOS"))
FAENA=UCASE(REQUEST("FAENA"))
USUARIO=UCASE(REQUEST("USUARIO"))
FECHA_ULT_MAN=UCASE(REQUEST("FECHA_ULT_MAN"))
DIAS_PROY=UCASE(REQUEST("DIAS_PROY"))



Select Case RECURSO

	case "getTren"
		  getTren()
	
	case "saveTren"
		  saveTren()
		  
	case "listTren"
		  listTren() 	  
	
	case "infTren"
		  infTren() 
		  
	case "delTren"
		  delTren()	 
		  
End Select

function getTren()

	query = "SELECT T.EQUIPO, E.DESCRIPCION, T.SECUENCIA "
	query = query & " FROM TREN AS T, EQUIPOS AS E "
	query = query & " WHERE "
	query = query & "  T.FOLIO=" & strNvl(FOLIO) 
	query = query & "  AND T.EQUIPO = E.CODIGO AND T.FAENA=E.UBICACION "
	query = query & "  AND T.FAENA = " & strNvl(FAENA) 
	query = query & " ORDER BY T.SECUENCIA  "  
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	
	Response.Write "<REGISTRO>"
		
	While Not Rs.EOF 
		Response.Write "<ROW>"
		 Response.Write "<EQUIPO>" & Rs.Fields.Item(0).Value & "</EQUIPO>"
		 Response.Write "<DESCRIPCION>" & Rs.Fields.Item(1).Value & "</DESCRIPCION>"
		 Response.Write "<SECUENCIA>" & Rs.Fields.Item(2).Value & "</SECUENCIA>"
		 Response.Write "</ROW>"
		 Rs.MoveNext
	Wend
	
	Response.Write "</REGISTRO>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function saveTren()


	If LEN(FOLIO)>0 THEN
		N=FOLIO
	ELSE
		query = "SELECT MAX(FOLIO) AS NUM FROM TREN "
		Set ORs =oDB.EjecutaSql(query)
		If Len(oRs("NUM"))>0 Then
			N = oRs("NUM") + 1
		Else
			N = 1
		End If
	End If
	
	   Dim aEquipos
	
		aEquipos = Split(EQUIPOS, ";")
	
		i=0
	
		While i<=ubound(aEquipos) - 1
		 
			query = "INSERT INTO TREN (" 
			query = query & " FOLIO, "
			query = query & " EQUIPO, "
			query = query & " SECUENCIA, "
			query = query & " FECHA, "
			query = query & " FAENA, "
			query = query & " USERNAME, "
			query = query & " USERDATE) "
			query = query & " VALUES ("
			query = query & strNvl(N) & ","
			query = query & strNvl(aEquipos(i)) & ","
			query = query & strNvl(i+1) & ","
			query = query & strNvl(FECHA) & ","	
			query = query & strNvl(FAENA) & ","
			query = query & strNvl(USUARIO) & ","
			query = query & " GETDATE())"
			
			Set ORs =oDB.EjecutaSql(query)
			'Response.Write(aMuestreo(i))
			i=i+1
		Wend
	
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><FOLIO>" & N & "</FOLIO></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function infTren()

Dim CONDICION
DIM ESTATUS

	query = "SELECT T.EQUIPO, E.DESCRIPCION, T.SECUENCIA "
	query = query & " FROM TREN AS T, EQUIPOS AS E "
	query = query & " WHERE "
	query = query & "  T.FOLIO=" & strNvl(FOLIO) 
	query = query & "  AND T.EQUIPO = E.CODIGO AND T.FAENA=E.UBICACION "
	query = query & "  AND T.FAENA = " & strNvl(FAENA) 
	query = query & " ORDER BY T.SECUENCIA  " 
 
 	Set ORs =oDB.EjecutaSql(query)
	
	'	Response.ContentType = "application/vnd.ms-excel"
		'Response.AddHeader "Content-Disposition", "attachment;filename=infTrenApilamiento.xls" 
		 Response.Write("<style>body{font-family:Verdana, Tahoma, Arial;margin-top:0; }</style>")
		  Response.Write("<style>.td1{font-family:Verdana, Tahoma, Arial; font-size:10px;}</style>")
		 Response.Write "<TABLE BORDER=0><TR><TD><IMG SRC='..\images\pie.jpg'/></TD></TR></TABLE>"
		 Response.Write "<BR/><BR/>"
		 Response.Write "<TABLE BORDER=0 width='800'><TR><TD><strong>"
		 Response.Write "TREN DE APILAMIENTO PROPUESTO PTA1, PTA2 (CRITERIO TTM)</strong></TD></TR></TABLE><BR/>"
	    Response.Write "<TABLE BORDER=1 cellpadding='5' cellspacing='0' class='td1'>"
			 Response.Write "<TR>"
			       Response.Write "<TD><strong>&nbsp;</strong></TD>"
				   Response.Write "<TD><strong>POSICION</strong></TD>"
   				   Response.Write "<TD><strong>TAG</strong></TD>"
   				   Response.Write "<TD width='200'><strong>DESCRIPCI�N</strong></TD>"
   				   Response.Write "<TD width='200'><strong>RECOMENDACI�N</strong></TD>"	
			 Response.Write "</TR>"
		DIM X
		X=1
		While Not ORs.EOF 
				 Response.Write "<TR>"
				  If X=1 THEN
				   Response.Write "<TD rowspan='100'><IMG SRC='..\images\flechaTren.png'/></TD>"
				   X=2
				  END IF
				  
				   Response.Write "<TD align='center'>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value &"</TD>"	
				   Response.Write "<TD>&nbsp;</TD>"						   
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
	    Response.Write "</TABLE>"

	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

function listTren()

query =	" SELECT DISTINCT FOLIO, FECHA, USERNAME "
query = query & " FROM TREN "
query = query & " WHERE FAENA = " & strNvl(FAENA)
query = query & " ORDER BY FOLIO DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>"  
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<USUARIO>" & ORs.Fields.Item(2).Value & "</USUARIO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function



function excelMediciones()

	query = "SELECT M.FOLIO, M.FECHA , M.EQUIPO, E.DESCRIPCION, M.INSPECTOR, M.FECHA_CAMBIO, "
	query = query & " M.DURACION, M.FECHA_ULTM_MANTENCION, E.ANCHO, E.ESPESOR, E.ESPESOR_R,"
	query = query & " T.DESCRIPCION, M.OBSERVACION, M.DUREZA " 
	query = query & " FROM MEDICIONES AS M, EQUIPOS AS E, TIPO_EQUIPOS AS T "
	query = query & " WHERE E.CODIGO = M.EQUIPO AND E.TIPO_EQUIPO=T.CODIGO"
	query = query & " AND FOLIO=" & strNvl(FOLIO) 
	
	Set Rs =oDB.EjecutaSql(query)
	
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	
	 
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
		
	query = "SELECT ID, VALOR, RETORNO "
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
	MM=0
	While Not ORs.EOF 
	  	  Response.Write "<TD ALIGN='CENTER'>"  & MM & "</TD>"
		  MM=MM+50
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
	ORs.MoveFirst
	Response.Write "<TR><TD>CUBIERTA ORIGINAL</TD>"	
	While Not ORs.EOF 
 		Response.Write "<TD ALIGN='CENTER'>" & Rs.Fields.Item(9).Value & "</TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
		
	
	ORs.MoveFirst
	Response.Write "<TR><TD>MUESTREO CUBIERTA</TD>"
	While Not ORs.EOF 	
		 
		   Response.Write "<TD ALIGN='CENTER'>" & _
		  	"<font color='#000066' style='font-family:Verdana, Arial, Helvetica, sans-serif'>"  & _
			 ORs.Fields.Item(1).Value & "</font></TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
	ORs.MoveFirst
	Response.Write "<TR><TD>DESGASTE REAL</TD>"	
	While Not ORs.EOF 
	  	  Response.Write "<TD ALIGN='CENTER'>"  & Rs.Fields.Item(9).Value - ORs.Fields.Item(1).Value & "</TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	
	
	ORs.MoveFirst
	Response.Write "<TR><TD>MUESTREO RETORNO</TD>"
	While Not ORs.EOF 	
		  Response.Write "<TD ALIGN='CENTER'>" & ORs.Fields.Item(2).Value & "</TD>"
	  ORs.MoveNext
	Wend
	Response.Write "</TR>"
	Response.Write "</TABLE>"
	
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

 
function delTren()

	query = "DELETE TREN WHERE FOLIO = " & strNvl(FOLIO) 
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
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