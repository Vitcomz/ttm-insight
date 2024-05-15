
<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
COMP=UCASE(REQUEST("COMP"))
JK=REQUEST("JK")
AREA=UCASE(REQUEST("AREA"))
CUBIERTA=UCASE(REQUEST("CUBIERTA"))
COLOR=UCASE(REQUEST("COLOR"))
CHK_MEDIA=UCASE(REQUEST("CHK_MEDIA"))
CHK_MAX=UCASE(REQUEST("CHK_MAX"))

HIST=REQUEST("HIST")
MES=UCASE(REQUEST("MES"))
ANHO=UCASE(REQUEST("ANHO"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FOLIO=UCASE(REQUEST("FOLIO"))
FOLIO_R=UCASE(REQUEST("FOLIO_R"))
TIPO_EQUIPO=UCASE(REQUEST("TIPO_EQUIPO"))
TIPO=UCASE(REQUEST("TIPO"))
FOLIOS=UCASE(REQUEST("FOLIOS"))
FAENA=UCASE(REQUEST("FAENA"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INST=UCASE(REQUEST("FECHA_INST"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
FONDO=UCASE(REQUEST("FONDO"))
INICIO=UCASE(REQUEST("INICIO"))
TERMINO=UCASE(REQUEST("TERMINO"))
SECCION=UCASE(REQUEST("SECCION"))
STR=UCASE(REQUEST("STR"))
REPORT=UCASE(REQUEST("REPORT"))
MUESTREO=UCASE(REQUEST("MUESTREO"))
PROYEC=UCASE(REQUEST("PROYEC"))
RETORNO=UCASE(REQUEST("RETORNO"))
TURNO=UCASE(REQUEST("TURNO"))
SUPERVISOR=UCASE(REQUEST("SUPERVISOR"))
OPERADOR_NAVE=UCASE(REQUEST("OPERADOR_NAVE"))
OPERADOR_GRUA=UCASE(REQUEST("OPERADOR_GRUA"))
EQUIPO_PRIN=UCASE(REQUEST("EQUIPO_PRIN"))
ESPESOR_SEG=UCASE(REQUEST("ESPESOR_SEG"))

EQUIPOS=REQUEST("EQUIPOS")
SEGS=REQUEST("SEGS")
REMA=REQUEST("REMA")
DESGASTES=REQUEST("DESGASTES")


Session.LCID = 2057

Select Case RECURSO

	case "nroAvisos"
			nroAvisos()
	
   	case "nroFallas"
			nroFallas()
   
	case "nroCausas"
		 nroCausas()

	case "grLecturas"
		 grLecturas()
	
	case "criticidadArea"
		  criticidadArea()
	
	case "critEquipos2"
		  critEquipos2()
	
   	case "criticidadComp"
		  criticidadComp()
   
   	case "critComp"
		  critComp()
   
	case "criSolucion"
		  criSolucion()
		  	  
	case "grPie"
		  grPie()
		  
	case "critComDet"
		 critComDet()
	
	case "listAnalisis"
		  listAnalisis()
		  
	case "grInd"
		  grInd()
		  
	case "grPolines"
		  grPolines()
		  
	case "grPolinesCri"
		  grPolinesCri()

	case "graphDispUtil"
		  graphDispUtil()
		  
	case "graphPareto"
		  graphPareto()
		  
	case "grDisp"
		  grDisp()	 
		  
	case "graphJack"
		  graphJack()	 	  	  
	
	case "tblInd"
		 tblInd()
		 
	case "tblIndAn"
		 tblIndAn()
		 
		case "grDistCri"
		 	grDistCri()
			  	
	case "grEspesor"
		  grEspesor()
		  
		  	  	
	case "grEspesor2"
		  grEspesor2()
	
		case "grEspesor3"
		  grEspesor3()
		  	    
	case "grProyec"
		  grProyec()
	
		case "grProyecciones"
		  grProyecciones()
		  	  
	case "toExcel"
		toExcel()
	
	case "critEquipos"
			critEquipos()
	
			
	case "grPareto"
			grPareto()
	

			
						  		  
end select

function criticidadArea()

	query = "SELECT DESCRIPCION"
	query = query & " FROM SECCIONES AS S"
	query = query & " WHERE FAENA= " & strNvl(FAENA) 
	
	If Len(AREA)>0 Then
		query = query & "  AND S.CODIGO=" & strNvl(AREA)  
	End If

	Set Rs =oDB.EjecutaSql(query)
	
 
	query =  " SELECT T.COD_SEC,  T.DESCRIPCION, ISNULL(T2.NRO_AVISOS,0), T.COD_CRI"
	query = query & " FROM ("
 	query = query & " SELECT C.CODIGO AS COD_CRI, C.NOMBRE, S.CODIGO AS COD_SEC,"
	query = query & " S.DESCRIPCION AS DESCRIPCION  "
 	query = query & " FROM TBL_CRITICIDAD AS C , SECCIONES AS S"
 	query = query & " WHERE S.FAENA=" & strNvl(FAENA)
	
	If Len(AREA)>0 Then
		query = query & "  AND S.CODIGO=" & strNvl(AREA)  
	End If
	
	query = query & " ) AS T"
	query = query & " LEFT OUTER JOIN ("
  	query = query & " SELECT E.SECCION, S.DESCRIPCION AS DES, "
	query = query & " COUNT(*) AS NRO_AVISOS, dbo.getCriticidadInt(B.COLOR) as COD_CRI"
    query = query & "   FROM BITACORAS AS B"
    query = query & "   INNER JOIN EQUIPOS AS E ON E.CODIGO=DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & ")"
    query = query & "   INNER JOIN SECCIONES AS S ON S.FAENA = E.UBICACION AND S.CODIGO = E.SECCION "
			query = query & "    AND S.FAENA = B.UBICACION "
	query = query & "    WHERE  B.UBICACION=   " & strNvl(FAENA)
	
	If HIST = "false" Then
		query = query & "  AND (B.IND_SOLUCION IS NULL OR B.IND_SOLUCION = 'FALSE') "  
	End If
	
   If Len(EQUIPO)>0 Then
		query = query & " AND  DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & ") =" & strNvl(EQUIPO)  
	End If
	
    query = query & "  GROUP BY E.SECCION, S.DESCRIPCION, B.COLOR"
 	query = query & "  ) AS T2 ON T2.SECCION= T.COD_SEC AND T2.COD_CRI = T.COD_CRI "
  	query = query & " ORDER BY 4, 1"
 
	
	Set Rs1 =oDB.EjecutaSql(query)

	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>"  & VbCrLf' & query 
	
	Response.Write "<categories>"  & VbCrLf
	While Not Rs.EOF 
		Response.Write "<item>" & Rs.Fields.Item(0).Value &  "</item>" & VbCrLf
		Rs.MoveNext
	Wend
	Response.Write "</categories>" & VbCrLf
	
	Response.Write "<series>" & VbCrLf
	
	estado = Rs1.Fields.Item(3).Value
	sector = Rs1.Fields.Item(1).Value
	
	SELECT CASE estado
	
				CASE 1
					Response.Write "<color>#FF3300</color>" & VbCrLf
					Response.Write "<name>Criticidad Alta</name>" & VbCrLf
				CASE 2
					Response.Write "<color>#FF9900</color>" & VbCrLf
					Response.Write "<name>Criticidad Media</name>" & VbCrLf
				CASE 3
					Response.Write "<color>#FFFF00</color>" & VbCrLf
					Response.Write "<name>Criticidad Baja</name>" & VbCrLf
				CASE 4
					Response.Write "<color>#5DC146</color>" & VbCrLf
					Response.Write "<name>Buen Estado</name>" & VbCrLf
				
	END SELECT 
		
	Response.Write "<data>" & VbCrLf
	
	Rs1.MoveFirst
		While Not Rs1.EOF 'valores de la serie
		
		Response.Write "<point>" & Rs1.Fields.Item(2).Value & "</point>" & VbCrLf
		Rs1.MoveNext
		
		If Not Rs1.EOF  Then
		
			If estado <> Rs1.Fields.Item(3).Value Then
				
				estado = Rs1.Fields.Item(3).Value
				sector = Rs1.Fields.Item(1).Value
					
				Response.Write "</data>" & VbCrLf
				Response.Write "</series>" & VbCrLf
			
				Response.Write "<series>" & VbCrLf
				
				SELECT CASE estado
					CASE 1
						Response.Write "<color>#FF3300</color>" & VbCrLf
						Response.Write "<name>Criticidad Alta</name>" & VbCrLf
					CASE 2
						Response.Write "<color>#FF9900</color>" & VbCrLf
						Response.Write "<name>Criticidad Media</name>" & VbCrLf
					CASE 3
						Response.Write "<color>#FFFF00</color>" & VbCrLf
						Response.Write "<name>Criticidad Baja</name>" & VbCrLf
					CASE 4
						Response.Write "<color>#5DC146</color>" & VbCrLf
						Response.Write "<name>Buen Estado</name>" & VbCrLf
				END SELECT
				 
				Response.Write "<data>" & VbCrLf

			End If ' if Cambio de serie
		End if
	Wend 'wend series
	
	Response.Write "</data>" & VbCrLf
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>" & VbCrLf
end function

function criSolucion()

	 
	Set Cn = oDB.Conexion
   	
	Dim Rs
	Dim STR
    IF LEN(AREA)=0 THEN
		'AREA = 1
	END IF
   
	STR =	"EXECUTE SP_CR_SOL @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	'STR = STR & ", @HIST=" & strNvl(HIST)   
	
 	Set ORs = Cn.Execute (STR)
	
	'Response.Write STR
	'EXIT FUNCTION
	 

	i=0

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf '& STR
	Response.Write "<categories>"& VbCrLf
	If not ORs.eof Then
	catAnt =  ORs.Fields.Item(1).Value 
	While catAnt = ORs.Fields.Item(1).Value
		i = i + 1
	
		Response.Write "<item>" & ORs.Fields.Item(2).Value &  "</item>" & VbCrLf
		 
		catAnt=ORs.Fields.Item(1).Value
		ORs.MoveNext
	Wend
	End If
	Response.Write "</categories>" & VbCrLf
	
	 ORs.MoveFirst
	 
	If not ORs.eof Then
	
	
	
		If ORs.Fields.Item(1).Value = "TRUE" THEN
				STR = "Solucionados"
		Else
				STR = "Por Solucionar"
		End If
		
	serAnt = ORs.Fields.Item(1).Value

	Response.Write "<series>" & VbCrLf
	Response.Write "<name>" &  STR & "</name>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	'Response.Write "<color>" & ORs.Fields.Item(3).Value & "</color>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	Response.Write "<yAx>0</yAx>" & VbCrLf
	
	End If 
	  
	While Not ORs.EOF 'valores de la serie
		
		If serAnt<>ORs.Fields.Item(1).Value Then
		
			Response.Write "</data>" & VbCrLf
	  		Response.Write "</series>" & VbCrLf
			
			If ORs.Fields.Item(1).Value = "TRUE" THEN
				STR = "Solucionados"
		Else
				STR = "Por Solucionar"
		End If
			
			Response.Write "<series>" & VbCrLf
			Response.Write "<name>" & STR & "</name>" & VbCrLf
			Response.Write "<type>column</type>" & VbCrLf
			Response.Write "<yAx>0</yAx>" & VbCrLf
	'		Response.Write "<color>" & ORs.Fields.Item(3).Value & "</color>" & VbCrLf
			Response.Write "<data>"	& VbCrLf
			
			
		End If	
		
		serAnt = ORs.Fields.Item(1).Value
		Response.Write "<point>" & ORs.Fields.Item(0).Value & "</point>" & VbCrLf
		ORs.MoveNext

	Wend 'wend series
 	
	 
	
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>" &  VbCrLf
	
end function

function nroAvisos()
	
Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	
	 
	STR =	"EXECUTE SP_NRO_AVISOS @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	STR = STR & ", @EQUIPO=" & strNvl(EQUIPO) 
	STR = STR & ", @COMP=" & strNvl(COMP) 
	STR = STR & ", @HIST=" & strNvl(HIST)  
		
 	Set Rs1 = Cn.Execute (STR)
	 

	Total=0
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf
	
	Response.Write "<categories>" & VbCrLf
	While Not Rs1.EOF 
		l=Len(Rs1.Fields.Item(1).Value)
		Total = Total + Cdbl(Rs1.Fields.Item(0).Value)
		Response.Write "<item>" & Rs1.Fields.Item(1).Value &  "</item>" & VbCrLf
		Rs1.MoveNext
	Wend
	Response.Write "</categories>" & VbCrLf
	
	Rs1.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Nro Fallas</name>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	Response.Write "<yAx>0</yAx>" & VbCrLf
			
	While Not Rs1.EOF
		Response.Write "<data>" & VbCrLf
			Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>" & VbCrLf
			Response.Write "<dataLabels>" & Rs1.Fields.Item(1).Value & "</dataLabels>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		Rs1.MoveNext
	Wend
	Response.Write "</series>" & VbCrLf
		
	Rs1.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Acumulado</name>" & VbCrLf
	Response.Write "<type>spline</type>" & VbCrLf
	Response.Write "<yAx>1</yAx>" & VbCrLf
		
 
	While Not Rs1.EOF
		Response.Write "<data>" & VbCrLf
		pTotal =  pTotal + (Cdbl(Rs1.Fields.Item(0).Value)  / Total) * 100 
		Response.Write "<point>" & ROUND(pTotal,2) & "</point>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		Rs1.MoveNext
	Wend
	
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>" & VbCrLf
 
	
end function



function nroFallas()
	
Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	
	 
	query =	"	 select top 15 count(*), c.descripcion"
  	query = query & " from bitacoras as b"
  	query = query & " inner join equipos as e on e.codigo = b.equipo"
	
	If Len(TIPO_EQUIPO)>0 then
	  query = query & " and e.tipo_equipo in (" & TIPO_EQUIPO & ") " 
  	End if

  	query = query & " inner join check_equipos as ce on b.id = ce.bitacora"
  	query = query & " inner join checklist as c on c.id=ce.checklist and c.tipo_equipo = e.tipo_equipo "
  	query = query & " where b.ubicacion= " & strNvl(FAENA)
  	query = query & " group by c.descripcion"
	query = query & " order by 1 desc"
	
 	Set Rs1 =oDB.EjecutaSql(query)
	 

	Total=0
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & query
	
	Response.Write "<categories>" & VbCrLf
	While Not Rs1.EOF 
		l=Len(Rs1.Fields.Item(1).Value)
		Total = Total + Cdbl(Rs1.Fields.Item(0).Value)
		Response.Write "<item>" & Rs1.Fields.Item(1).Value &  "</item>" & VbCrLf
		Rs1.MoveNext
	Wend
	Response.Write "</categories>" & VbCrLf
	
	Rs1.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Nro Fallas</name>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	Response.Write "<yAx>0</yAx>" & VbCrLf
			
	While Not Rs1.EOF
		Response.Write "<data>" & VbCrLf
			Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>" & VbCrLf
			Response.Write "<dataLabels>" & Rs1.Fields.Item(1).Value & "</dataLabels>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		Rs1.MoveNext
	Wend
	Response.Write "</series>" & VbCrLf
		
	Rs1.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Acumulado</name>" & VbCrLf
	Response.Write "<type>spline</type>" & VbCrLf
	Response.Write "<yAx>1</yAx>" & VbCrLf
		
 
	While Not Rs1.EOF
		Response.Write "<data>" & VbCrLf
		pTotal =  pTotal + (Cdbl(Rs1.Fields.Item(0).Value)  / Total) * 100 
		Response.Write "<point>" & ROUND(pTotal,2) & "</point>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		Rs1.MoveNext
	Wend
	
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>" & VbCrLf
 
	
end function
	

	

function nroCausas()
	
Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
	
	 
	query =	"	 select top 15 count(*), b.causa"
  	query = query & " from bitacoras as b"
  	query = query & " inner join equipos as e on e.codigo = b.equipo"
		
	  If Len(TIPO_EQUIPO)>0 then
	  query = query & " and e.tipo_equipo in (" & TIPO_EQUIPO & ") " 
  	End if
  	query = query & " where b.ubicacion= " & strNvl(FAENA)
  	query = query & " group by b.causa"
	query = query & " order by 1 desc"
	
 	Set Rs1 =oDB.EjecutaSql(query)
	 

	Total=0
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf
	
	Response.Write "<categories>" & VbCrLf
	While Not Rs1.EOF 
		l=Len(Rs1.Fields.Item(1).Value)
		Total = Total + Cdbl(Rs1.Fields.Item(0).Value)
		Response.Write "<item>" & Rs1.Fields.Item(1).Value &  "</item>" & VbCrLf
		Rs1.MoveNext
	Wend
	Response.Write "</categories>" & VbCrLf
	
	Rs1.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Nro Fallas</name>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	Response.Write "<yAx>0</yAx>" & VbCrLf
			
	While Not Rs1.EOF
		Response.Write "<data>" & VbCrLf
			Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>" & VbCrLf
			Response.Write "<dataLabels>" & Rs1.Fields.Item(1).Value & "</dataLabels>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		Rs1.MoveNext
	Wend
	Response.Write "</series>" & VbCrLf
		
	Rs1.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Acumulado</name>" & VbCrLf
	Response.Write "<type>spline</type>" & VbCrLf
	Response.Write "<yAx>1</yAx>" & VbCrLf
		
 
	While Not Rs1.EOF
		Response.Write "<data>" & VbCrLf
		pTotal =  pTotal + (Cdbl(Rs1.Fields.Item(0).Value)  / Total) * 100 
		Response.Write "<point>" & ROUND(pTotal,2) & "</point>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		Rs1.MoveNext
	Wend
	
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>" & VbCrLf
 
	
end function
	
	
function criticidadComp()

	
Set Cn = oDB.Conexion
   	Dim Rs
	Dim STR
   
	STR =	"EXECUTE SP_CR_COMP @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	STR = STR & ", @EQUIPO=" & strNvl(EQUIPO)  
	STR = STR & ", @HIST=" & strNvl(HIST)  
	
 	Set Rs1 = Cn.Execute (STR)

	Total=0
	Response.Write STR
	'EXIT FUNCTION
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>"
	Response.Write "<categories>"
	 
		Response.Write "<item>Chutes</item>"
		Response.Write "<item>Cinta</item>"
		Response.Write "<item>Empalme</item>"
		Response.Write "<item>Guarderas</item>"
		Response.Write "<item>Poleas</item>"
		Response.Write "<item>Polines</item>"
		Response.Write "<item>Raspadores</item>"
		Response.Write "<item>Tramos</item>"
	 
	Response.Write "</categories>"
	
	Response.Write "<series>"
	estado = Rs1.Fields.Item(3).Value
	
		SELECT CASE estado
					CASE 1
						Response.Write "<color>#FF3300</color>"
						Response.Write "<name>Criticidad Alta</name>"
					CASE 2
						Response.Write "<color>#FF9900</color>"
						Response.Write "<name>Criticidad Media</name>"
					CASE 3
						Response.Write "<color>#FFFF00</color>"
						Response.Write "<name>Criticidad Baja</name>"
					'CASE 4
					'	Response.Write "<color>#5DC146</color>"
					'	Response.Write "<name>Buen Estado</name>"
		END SELECT 
		
	Response.Write "<data>"
	
	
		While Not Rs1.EOF 'valores de la serie
		Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>"
		Rs1.MoveNext
		
		If Not Rs1.EOF  Then
			If estado <> Rs1.Fields.Item(3).Value Then
				
				estado = Rs1.Fields.Item(3).Value	
				Response.Write "</data>"
				Response.Write "</series>"
			
				Response.Write "<series>"
				
				SELECT CASE estado
					CASE 1
						Response.Write "<color>#FF3300</color>"
						Response.Write "<name>Criticidad Alta</name>"
					CASE 2
						Response.Write "<color>#FF9900</color>"
						Response.Write "<name>Criticidad Media</name>"
					CASE 3
						Response.Write "<color>#FFFF00</color>"
						Response.Write "<name>Criticidad Baja</name>"
					CASE 4
						Response.Write "<color>#5DC146</color>"
						Response.Write "<name>Buen Estado</name>"
				END SELECT 
				Response.Write "<data>"

			End If ' if Cambio de serie
		End if
	Wend 'wend series
	
	Response.Write "</data>"
	Response.Write "</series>"
	Response.Write "</chart>"
	
end function


function grPareto()

	query = "SELECT DESCRIPCION"
	query = query & " FROM SECCIONES"
	query = query & " WHERE FAENA=" & strNvl(FAENA) 

	Set Rs =oDB.EjecutaSql(query)
	
	query = "SELECT count(E.CODIGO) AS NRO_EQUIPOS, B.ESTADO, CONVERT(FLOAT,E.SECTOR), S.DESCRIPCION "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E ON E.CODIGO=DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & ")"
	query = query & " INNER JOIN SECCIONES AS S ON S.FAENA = E.UBICACION AND S.CODIGO = E.SECTOR"
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA) &  "  AND B.ESTADO=1"
	query = query & " 	 AND E.UBICACION=B.UBICACION " ' AND (IND_SOLUCION IS NULL OR IND_SOLUCION = 'FALSE')"
	query = query & " GROUP BY E.SECTOR, S.DESCRIPCION, B.ESTADO "
	query = query & " ORDER BY 1 DESC "
	
	Set Rs1 =oDB.EjecutaSql(query)

	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>"
	
	Response.Write "<categories>"
	While Not Rs1.EOF 
		l=Len(Rs1.Fields.Item(3).Value)
		Response.Write "<item>" &  Rs1.Fields.Item(3).Value  &  "</item>"
		Rs1.MoveNext
	Wend
	Response.Write "</categories>"
	
	Rs1.MoveFirst
	
	Response.Write "<series>"
		Response.Write "<name>Criticidad Alta</name>"
		Response.Write "<color>#FF3300</color>"
	While Not Rs1.EOF 

		Response.Write "<data>"
			Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>"
			Response.Write "<dataLabels>" & Rs1.Fields.Item(3).Value & "</dataLabels>"
		Response.Write "</data>"

			Rs1.MoveNext
	Wend
	
	Response.Write "</series>"
		
	Response.Write "</chart>"
end function


function grPie()

	Dim Total
	
	query = "SELECT DESCRIPCION"
	query = query & " FROM SECCIONES"
	query = query & " WHERE FAENA=" & strNvl(FAENA) 

	Set Rs =oDB.EjecutaSql(query)
	
	query = " SELECT C.CODIGO, isnull(T.NRO_AVISOS,0) "
	query = query & " FROM TBL_CRITICIDAD AS C"
	query = query & " LEFT OUTER JOIN ("
	query = query & " SELECT count(B.ID) AS NRO_AVISOS, dbo.getCriticidadInt(B.COLOR) AS COD_CRI"
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E ON E.CODIGO= B.EQUIPO AND E.UBICACION = " & strNvl(FAENA) & " "
	query = query & " AND E.TIPO_EQUIPO!=8 "
	query = query & " INNER JOIN SECCIONES AS S ON S.FAENA = E.UBICACION AND S.CODIGO = E.SECCION"
	query = query & "  WHERE B.UBICACION=" & strNvl(FAENA)  
	
	If Len(AREA)>0 Then
		query = query & "  AND E.SECCION=" & strNvl(AREA)  
	End If
	
	If Len(EQUIPO)>0 Then
		query = query & " AND  DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & ") =" & strNvl(EQUIPO)  
	End If
	
	
	If HIST = "false" Then
		query = query & "  AND (B.IND_SOLUCION IS NULL OR B.IND_SOLUCION = 'FALSE') "  
	End If
	
	query = query & "	 AND E.UBICACION=B.UBICACION "
	query = query & " GROUP BY  B.COLOR ) AS T ON T.COD_CRI = C.CODIGO "
	query = query & " ORDER BY 1  "
	
	
	Set Rs1 =oDB.EjecutaSql(query)

	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf 
	
	Response.Write " <cat>" & VbCrLf
	
    Response.Write "<tag>Criticidad Alta</tag>" & VbCrLf
	Response.Write "<name>Criticidad Alta</name>" & VbCrLf
	Response.Write "  <color>#FF3300</color>" & VbCrLf
	
    Response.Write "  <tag>Criticidad Media</tag>" & VbCrLf
	Response.Write "<name>Criticidad Media</name>" & VbCrLf
	Response.Write "  <color>#FF9900</color>" & VbCrLf
	
    Response.Write "  <tag>Criticidad Baja</tag>" & VbCrLf
	Response.Write "<name>Criticidad Baja</name>" & VbCrLf
	Response.Write "  <color>#FFFF00</color>" & VbCrLf
	
    Response.Write "  <tag>Buen Estado</tag>" & VbCrLf
	Response.Write "<name>Buen Estado</name>" & VbCrLf
	Response.Write "  <color>#00FF00</color>" & VbCrLf
	
  	Response.Write " </cat>" & VbCrLf
	
	Response.Write " <tags>" & VbCrLf
	
	
  	Response.Write "<tgv>" & VbCrLf
  
  	Total = 0
	
	While Not Rs1.EOF 
		Total = Total + Rs1.Fields.Item(1).Value
	  Rs1.MoveNext
	Wend
	
	
	
	If Total = 0 Then
		Total=1
	End If
	
	
	Rs1.Movefirst
	
	While Not Rs1.EOF 
	
		valor = (Rs1.Fields.Item(1).Value/Total)*100
  		Response.Write "<point>" & valor & "</point>" & VbCrLf

		select case Rs1.Fields.Item(1).Value
			
					case 1
						color = "#FF3300"
						nam = "Criticidad Alta"
						
					case 2 
						 color = "#FF9900"
						 nam = "Criticidad Media"
					case 3
						 color = "#FFFF00"
						 nam = "Criticidad Baja"
					case 4
					 color = "#00FF00"
					 nam = "Buen Estado"
					
		end select 
	 	
	 
	  Rs1.MoveNext
	Wend
	
	Response.Write " </tgv>"
  	Response.Write "</tags>"
	
	'Response.Write "<series>"
	'Response.Write "<color>#FF3300</color>"
	'	Response.Write "<data>"
		
	
			
'		Response.Write "<label>" & nam & "</label>"
'		Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>"
			 
'		Response.Write "</data>"	
'		Response.Write "</series>"

	Response.Write "</chart>"
	
end function


function paretoComponentes()

	query = "SELECT DESCRIPCION"
	query = query & " FROM SECCIONES"
	query = query & " WHERE FAENA=" & strNvl(FAENA) 

	Set Rs =oDB.EjecutaSql(query)
	
	query = "SELECT TOP 6 T.DESCRIPCION,  COUNT(ID) "
	query = query & " FROM BITACORAS AS B"
	query = query & " INNER JOIN EQUIPOS AS E ON E.CODIGO=B.EQUIPO"
	query = query & " INNER JOIN SECCIONES AS S ON S.FAENA = E.UBICACION AND S.CODIGO = E.SECTOR"
	query = query & " INNER JOIN TIPO_EQUIPOS AS T ON T.CODIGO = E.TIPO_EQUIPO AND T.UBICACION=15"
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)  & "  AND B.ESTADO=1"
	query = query & " 	 AND E.UBICACION=B.UBICACION AND (IND_SOLUCION IS NULL OR IND_SOLUCION = 'FALSE')"
	query = query & " GROUP BY T.DESCRIPCION"
	query = query & "  ORDER BY 2 DESC, 1"
	
	Set Rs1 =oDB.EjecutaSql(query)

	Total=0
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>"
	
	Response.Write "<categories>"
	While Not Rs1.EOF 
		l=Len(Rs1.Fields.Item(0).Value)
		Total = Total + Cdbl(Rs1.Fields.Item(1).Value)
		Response.Write "<item>" & Rs1.Fields.Item(0).Value &  "</item>"
		Rs1.MoveNext
	Wend
	Response.Write "</categories>"
	
	Rs1.MoveFirst
	Response.Write "<series>"
	Response.Write "<name>Nro Componentes</name>"
	Response.Write "<type>column</type>"
		
	While Not Rs1.EOF
		Response.Write "<data>"
			Response.Write "<point>" & Rs1.Fields.Item(1).Value & "</point>"
			Response.Write "<dataLabels>" & Rs1.Fields.Item(0).Value & "</dataLabels>"
		Response.Write "</data>"
		Rs1.MoveNext
	Wend
	Response.Write "</series>"
		
	Rs1.MoveFirst
	Response.Write "<series>"
	Response.Write "<name>% Acumulado</name>"
	Response.Write "<type>line</type>"
		
	AcTotal = 0
	While Not Rs1.EOF
		Response.Write "<data>"
		
		AcTotal = AcTotal + Cdbl(Rs1.Fields.Item(1).Value)/Total 
		
			Response.Write "<point>" & ROUND(AcTotal*100,2) & "</point>"
		
		Response.Write "</data>"
		Rs1.MoveNext
	Wend
	Response.Write "</series>"
	
	
	Response.Write "</chart>"
end function

function Criticidad_BAR()

	query = "SELECT  MONTH(FECHA) " 
	query = query & " FROM BITACORAS"
	query = query & " WHERE UBICACION=" & strNvl(FAENA) 
	query = query & " AND FECHA BETWEEN " & strNvl(INICIO) & " AND " &  strNvl(TERMINO) 
	query = query & " GROUP BY  MONTH(FECHA) "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Criticidad' shownames='1' showvalues='1' showSum='1' decimals='0' overlapBars='1' showShadow='1' showLabels='1' yAxisMaxValue='25'>"
	Response.Write "<categories>"
	While Not Rs.EOF 
		Response.Write "<category label='" & trim(Rs.Fields.Item(0).Value) & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</categories>"
	
	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='ALTA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	 
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='ALTA'  showValues='1' color='FF0000'>" 
	While Not Rs.EOF 
	     If Not Rs.Fields.Item(1).Value Then
		 	Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Else
		 	Response.Write "<set value='0' />"
		 End If
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"

	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='MEDIA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='MEDIA'  showValues='1' color='FFFF00'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	query = "SELECT  MONTH(FECHA), B1.COLOR " 
	query = query & " FROM BITACORAS AS B"
	query = query & " LEFT OUTER JOIN (SELECT COUNT(*) AS COLOR, MONTH(FECHA) AS MES"
	query = query & " 		FROM BITACORAS WHERE COLOR='BAJA' AND UBICACION=" & strNvl(FAENA)
	query = query & " 						AND COLOR IS NOT NULL AND YEAR(FECHA)=YEAR(" & strNvl(INICIO) & ")"
	query = query & " 		GROUP BY MONTH(FECHA), COLOR) AS B1 ON MES = MONTH(B.FECHA) " 
	query = query & " WHERE B.UBICACION=" & strNvl(FAENA)
	query = query & " AND B.FECHA BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
	query = query & " GROUP BY   MONTH(FECHA), B1.COLOR "
	query = query & " ORDER BY   MONTH(FECHA) DESC"
	
	Set Rs =oDB.EjecutaSql(query)
	Response.Write "<dataset seriesName='BAJA'  showValues='1' color='3366FF'>"
	While Not Rs.EOF 
		 Response.Write "<set value='" & Rs.Fields.Item(1).Value & "' />"
		 Rs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function


function critComDet()

	Set Cn = oDB.Conexion
   	
	Dim Rs
	Dim STR
    IF LEN(AREA)=0 THEN
		'AREA = 1
	END IF
   
	STR =	"EXECUTE SP_CR_COMP_DET @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	STR = STR & ", @EQUIPO=" & strNvl(EQUIPO) 
	STR = STR & ", @COMP=" & strNvl(COMP) 
	STR = STR & ", @HIST=" & strNvl(HIST)   
	
 	Set ORs = Cn.Execute (STR)
	
	'Response.Write STR
	'EXIT FUNCTION
	
	i=0

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & STR
	Response.Write "<categories>"& VbCrLf
	If not ORs.eof Then
	catAnt =  ORs.Fields.Item(2).Value 
	While catAnt = ORs.Fields.Item(2).Value
		i = i + 1
		Response.Write "<item>" & ORs.Fields.Item(3).Value &  "</item>" & VbCrLf
		catAnt=ORs.Fields.Item(2).Value
		ORs.MoveNext
	Wend
	End If
	Response.Write "</categories>" & VbCrLf
	
	 
	SELECT CASE COMP
		CASE "3"
			name1 =  "Tramos"
		'	Response.Write "<color>#0011FF</color>"
		CASE "4,13"
			name1 =  "Empalmes"
		'	Response.Write "<color>#0011FF</color>"
			
		CASE "7"
			name1 =  "Poleas"
		'	Response.Write "<color>#FF1123</color>"
		
		CASE "8,14"
			name1 =  "Polines"
		'	Response.Write "<color>#FF1123</color>"
	END SELECT
	
	If not ORs.eof Then
	
	ORs.MoveFirst
	serAnt = ORs.Fields.Item(2).Value

	Response.Write "<series>" & VbCrLf
	Response.Write "<name>" &  serAnt & "</name>" & VbCrLf
	Response.Write "<color>" & ORs.Fields.Item(4).Value & "</color>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	
	End If 
	  
	While Not ORs.EOF 'valores de la serie
		
		If serAnt<>ORs.Fields.Item(2).Value Then
		
			Response.Write "</data>" & VbCrLf
	  		Response.Write "</series>" & VbCrLf
			
			Response.Write "<series>" & VbCrLf
			Response.Write "<name>" &  ORs.Fields.Item(2).Value & "</name>" & VbCrLf
			Response.Write "<color>" & ORs.Fields.Item(4).Value & "</color>" & VbCrLf
			Response.Write "<data>"	& VbCrLf
			
		End If	
		
		serAnt = ORs.Fields.Item(2).Value
		Response.Write "<point>" & ORs.Fields.Item(0).Value & "</point>" & VbCrLf
		ORs.MoveNext

	Wend 'wend series
 	
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	
	Response.Write "</chart>" &  VbCrLf
	
end function


function critEquipos2()

	Set Cn = oDB.Conexion
   	
	Dim Rs
	Dim STR
    IF LEN(AREA)=0 THEN
		'AREA = 1
	END IF
   
	STR =	"EXECUTE SP_CR_EQUIPOS @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	STR = STR & ", @HIST=" & strNvl(HIST)   
	
 	Set ORs = Cn.Execute (STR)
	
	'Response.Write STR
	'EXIT FUNCTION
	AcTotal = 0

	i=0

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf '& STR
	Response.Write "<categories>"& VbCrLf
	If not ORs.eof Then
	catAnt =  ORs.Fields.Item(2).Value 
	While catAnt = ORs.Fields.Item(2).Value
		i = i + 1
		Response.Write "<item>" & ORs.Fields.Item(3).Value &  "</item>" & VbCrLf
		AcTotal = AcTotal + Cdbl(ORs.Fields.Item(0).Value)  
		catAnt=ORs.Fields.Item(2).Value
		ORs.MoveNext
	Wend
	End If
	Response.Write "</categories>" & VbCrLf
	
	 
	If not ORs.eof Then
	
	ORs.MoveFirst
	serAnt = ORs.Fields.Item(2).Value

	Response.Write "<series>" & VbCrLf
	Response.Write "<name>" &  serAnt & "</name>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	Response.Write "<color>" & ORs.Fields.Item(4).Value & "</color>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	Response.Write "<yAx>0</yAx>" & VbCrLf
	
	End If 
	  
	While Not ORs.EOF 'valores de la serie
		
		If serAnt<>ORs.Fields.Item(2).Value Then
		
			Response.Write "</data>" & VbCrLf
	  		Response.Write "</series>" & VbCrLf
			
			Response.Write "<series>" & VbCrLf
			Response.Write "<name>" &  ORs.Fields.Item(2).Value & "</name>" & VbCrLf
			Response.Write "<type>column</type>" & VbCrLf
			Response.Write "<yAx>0</yAx>" & VbCrLf
			Response.Write "<color>" & ORs.Fields.Item(4).Value & "</color>" & VbCrLf
			Response.Write "<data>"	& VbCrLf
			
			
		End If	
		
		serAnt = ORs.Fields.Item(2).Value
		Response.Write "<point>" & ORs.Fields.Item(0).Value & "</point>" & VbCrLf
		ORs.MoveNext

	Wend 'wend series
 	
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	
	ORs.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Acumulado</name>" & VbCrLf
	Response.Write "<type>spline</type>" & VbCrLf
	Response.Write "<yAx>1</yAx>" & VbCrLf
		
	 
	
	ORs.MoveFirst
	pTotal =0
	
	catAnt =  ORs.Fields.Item(2).Value 
	While catAnt = ORs.Fields.Item(2).Value
		i = i + 1
		Response.Write "<data>" & VbCrLf
		If AcTotal>0 Then
			pTotal =  pTotal + (Cdbl(ORs.Fields.Item(0).Value)  / AcTotal) * 100 
		End If
		
		Response.Write "<point>" & ROUND(pTotal,2) & "</point>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		
		catAnt=ORs.Fields.Item(2).Value
		ORs.MoveNext
	Wend
	

	
	Response.Write "</series>" & VbCrLf
	
	Response.Write "</chart>" &  VbCrLf
	
end function


function critComp()

	Set Cn = oDB.Conexion
   	
	Dim Rs
	Dim STR
    IF LEN(AREA)=0 THEN
		'AREA = 1
	END IF
   
	STR =	"EXECUTE SP_CR_COMP2 @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	STR = STR & ", @EQUIPO=" & strNvl(EQUIPO)
	STR = STR & ", @HIST=" & strNvl(HIST)   
	
 	Set ORs = Cn.Execute (STR)
	
	'Response.Write STR
	'EXIT FUNCTION
	 

	i=0

	Total=0
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf
	
	Response.Write "<categories>" & VbCrLf
	While Not ORs.EOF 
		l=Len(ORs.Fields.Item(1).Value)
		Total = Total + Cdbl(ORs.Fields.Item(0).Value)
		Response.Write "<item>" & ORs.Fields.Item(2).Value &  "</item>" & VbCrLf
		ORs.MoveNext
	Wend
	Response.Write "</categories>" & VbCrLf
	
	ORs.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>NRO DE AVISOS " & CRI & "</name>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	Response.Write "<color>" & COLOR & "</color>" & VbCrLf
	 
	Response.Write "<yAx>0</yAx>" & VbCrLf
			
	While Not ORs.EOF
		Response.Write "<data>" & VbCrLf
			Response.Write "<point>" & ORs.Fields.Item(0).Value & "</point>" & VbCrLf
			Response.Write "<dataLabels>" & ORs.Fields.Item(2).Value & "</dataLabels>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		ORs.MoveNext
	Wend
	Response.Write "</series>" & VbCrLf
		
	ORs.MoveFirst
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Acumulado</name>" & VbCrLf
	Response.Write "<type>spline</type>" & VbCrLf
	Response.Write "<yAx>1</yAx>" & VbCrLf
		
	 
	 
	pTotal =0
	
	While Not ORs.EOF
		Response.Write "<data>" & VbCrLf
		pTotal =  pTotal + (Cdbl(ORs.Fields.Item(0).Value)  / Total) * 100 
		Response.Write "<point>" & ROUND(pTotal,2) & "</point>" & VbCrLf
		Response.Write "</data>" & VbCrLf
		ORs.MoveNext
	Wend
	
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>" & VbCrLf
	
end function
	
function critEquipos()

	Set Cn = oDB.Conexion
   	
	   Dim aMuestreo(200)
	Dim Rs
	Dim STR
    IF LEN(AREA)=0 THEN
		'AREA = 1
	END IF
   
	STR =	"SP_TBR_CR_EQ @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @AREA=" & strNvl(AREA)
	STR = STR & ", @EQUIPO=" & strNvl(EQUIPO) 
	STR = STR & ", @HIST=" & strNvl(HIST)   
	
 	Set ORs = Cn.Execute (STR)

	i=0
	nEq=0
	acum=0
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & STR
	Response.Write "<categories>"& VbCrLf
	If not ORs.eof Then
	catAnt =  ORs.Fields.Item(2).Value 
	While catAnt = ORs.Fields.Item(2).Value
	
		acum = acum + ORs.Fields.Item(5).Value
		aMuestreo(i) = ORs.Fields.Item(5).Value
		i 	= 	i + 1
		nEq	=	nEq +1
		Response.Write "<item>" & ORs.Fields.Item(3).Value &  "</item>" & VbCrLf
		catAnt=ORs.Fields.Item(2).Value
		ORs.MoveNext
	Wend
	End If
	Response.Write "</categories>" & VbCrLf
	
 	

	If not ORs.eof Then
	
	ORs.MoveFirst
	serAnt = ORs.Fields.Item(2).Value

	Response.Write "<series>" & VbCrLf
	Response.Write "<name>" &  serAnt & "</name>" & VbCrLf
	Response.Write "<color>" & ORs.Fields.Item(4).Value & "</color>" & VbCrLf
	Response.Write "<type>column</type>" & VbCrLf
	Response.Write "<yA>0</yA>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	
	End If 
	  
	While Not ORs.EOF 'valores de la serie
		
		If serAnt<>ORs.Fields.Item(2).Value Then
		
			Response.Write "</data>" & VbCrLf
	  		Response.Write "</series>" & VbCrLf
			
			Response.Write "<series>" & VbCrLf
			Response.Write "<name>" &  ORs.Fields.Item(2).Value & "</name>" & VbCrLf
			Response.Write "<color>" & ORs.Fields.Item(4).Value & "</color>" & VbCrLf
			Response.Write "<data>"	& VbCrLf
			
		End If	
		
		serAnt = ORs.Fields.Item(2).Value
		Response.Write "<point>" & ORs.Fields.Item(0).Value & "</point>" & VbCrLf
		ORs.MoveNext

	Wend 'wend series
 	
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Acumulado</name>" & VbCrLf
	Response.Write "<color>#006699</color>" & VbCrLf
	Response.Write "<type>line</type>"
		Response.Write "<yA>1</yA>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	i=0
	x=0
	While i<nEq
			x = x + 100*(aMuestreo(i)/acum) 
			Response.Write "<point>" & x & "</point>" & VbCrLf
	  i=i+1
	Wend
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	Response.Write "</chart>" &  VbCrLf
	
end function

function grDistCri()

	query = "SELECT DESCRIPCION"
	query = query & " FROM SECCIONES"
	query = query & " WHERE FAENA=" & strNvl(FAENA) 

	Set Rs =oDB.EjecutaSql(query)
	
	query = " SELECT  TOP 10 count(B.ID) AS NRO_AVISOS, "
	query = query & " rtrim(ltrim(DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & "))) "
	query = query & " FROM BITACORAS AS B "
	query = query & " INNER JOIN EQUIPOS AS E ON E.CODIGO= B.EQUIPO AND E.UBICACION = " & strNvl(FAENA) & " "
	query = query & " AND E.TIPO_EQUIPO!=8 "
	query = query & " INNER JOIN SECCIONES AS S ON S.FAENA = E.UBICACION AND S.CODIGO = E.SECCION"
	query = query & "  WHERE B.UBICACION=" & strNvl(FAENA)  
	
	If Len(AREA)>0 Then
		query = query & "  AND E.SECCION=" & strNvl(AREA)  
	End If
	
	If Len(EQUIPO)>0 Then
		query = query & " AND  DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & ") =" & strNvl(EQUIPO)  
	End If
	
	
	If HIST = "false" Then
		query = query & "  AND (B.IND_SOLUCION IS NULL OR B.IND_SOLUCION = 'FALSE') "  
	End If
	
	query = query & "	 AND E.UBICACION=B.UBICACION "
	query = query & " GROUP BY  DBO.EQUIPOPRINCIPALFAENA(B.EQUIPO, " & strNvl(FAENA) & ") "
	query = query & " ORDER BY 1  desc "
	
	
	Set Rs1 =oDB.EjecutaSql(query)

	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>" & query
	
	Total = 0
	
	While Not Rs1.EOF
		Response.Write " <cat>"
    	Response.Write "<tag>" & Rs1.Fields.Item(1).Value & "</tag>"
		Response.Write "<name>" & Rs1.Fields.Item(1).Value & "</name>"
		' Response.Write "  <color>#FF3300</color>"
		Total = Total + Rs1.Fields.Item(0).Value
  		Response.Write " </cat>"
		 Rs1.MoveNext
	 
	Wend
	
	Response.Write " <tags>"
	
	
  	Response.Write "<tgv>"
	 
	Rs1.movefirst 
	While Not Rs1.EOF 
  		Response.Write "<point>" & Rs1.Fields.Item(0).Value & "</point>"
 
	  Rs1.MoveNext
	Wend
	
	Response.Write " </tgv>"
  	Response.Write "</tags>"
	
 
	Response.Write "</chart>"
	
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
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
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

function tblInd()

Set Cn =  oDB.Conexion
	Dim ORs
	
	STR = "exec DBO.SCI_TBR_Ind @equipo='',"
	STR = STR & " @area=" & strNvl(AREA) & ", @anho=" & ANHO & ", @faena=" & strNvl(FAENA)
   	' Set ORs = Cn.Execute (STR)
	
   	Set ORs = Server.CreateObject("ADODB.Recordset")
   	ORs.CursorLocation = 3 
	ORs.Open STR, Cn, 1,1
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & STR
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<ANHO>" & ORs.Fields.Item(0).Value & "</ANHO>"
		  Response.Write "<MES>" & ORs.Fields.Item(1).Value & "</MES>"
   		  Response.Write "<TC>" & ORs.Fields.Item(2).Value & "</TC>"
		  
		  TC = ROUND(ORs.Fields.Item(2).Value)
		  MP = ROUND(ORs.Fields.Item(3).Value/60,2)
		  MC = ROUND(ORs.Fields.Item(4).Value/60,2)
		  P_DO = ROUND(ORs.Fields.Item(5).Value/60,2)
		  
		  NDO = ROUND(ORs.Fields.Item(6).Value)
		  NMC = ROUND(ORs.Fields.Item(7).Value)
		  
		  Response.Write "<MP>" & MP & "</MP>"
		  Response.Write "<MC>" & MC & "</MC>"
		  Response.Write "<DO>" & P_DO & "</DO>"
		  Response.Write "<NDO>" & NDO & "</NDO>"
		  Response.Write "<NMC>" & NMC & "</NMC>"
		  
		  P_TO = TC - MP - MC - P_DO
		  
		  Response.Write "<TO>" & P_TO & "</TO>"
		  Response.Write "<MTBF>" & ROUND(P_TO/ ( NMC + 1),2) & "</MTBF>"
		
		  If NMC>0 Then
			 Response.Write "<MTTR>" & ROUND( MC / NMC,2)  & "</MTTR>"
		  End If
		 
		  If NMC>0 Then
			 Response.Write "<MTBS>" & ROUND( P_TO / ( NDO + NMC + 1), 2 )  & "</MTBS>"
		  End If
		 
		  If NMC>0 Then
			 Response.Write "<TPM>" & ROUND( MP + MC , 2 )  & "</TPM>"
		  End If
		  
		
			 Response.Write "<DISP>" & ROUND( ((TC - MP - MC)/TC)*100 ,2)  & "%</DISP>"
			 Response.Write "<UTIL>" & ROUND((P_TO/TC)*100  , 2 )  & "%</UTIL>"
		  
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	

end function

function grInd()
	
	Set Cn =  oDB.Conexion
	Dim ORs
	Dim MP
	Dim MC
	
	STR = "exec DBO.SCI_TBR_IND @equipo='',"
	STR = STR & " @area=" & strNvl(AREA) & ", @anho=" & ANHO & ", @faena=" & strNvl(FAENA)
  	
   	Set ORs = Server.CreateObject("ADODB.Recordset")
   	ORs.CursorLocation = 3 
	ORs.Open STR, Cn, 1,1
	
	Total=0
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>" & STR
	
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<item>" & ORs.Fields.Item(1).Value &  "</item>"
		ORs.MoveNext
	Wend
	
	
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<series>"
	Response.Write "<name>MTBF</name>"
	Response.Write "<type>column</type>"
	Response.Write "<naxi>1</naxi>"
		
	While Not ORs.EOF
	
	 	TC = ROUND(ORs.Fields.Item(2).Value)
		 MP = ROUND(ORs.Fields.Item(3).Value/60,2)
		 MC = ROUND(ORs.Fields.Item(4).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(5).Value/60,2) 
		 NDO = ROUND(ORs.Fields.Item(6).Value)
		 NMC = ROUND(ORs.Fields.Item(7).Value)	
		    
		  P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		  
		 ' response.write ORs.Fields.Item(0).Value & " ** " & MONTH(NOW)
		  
		  IF NMC = 0 THEN
		  	 MTBF = 0
		  ELSE  
		  	 MTBF = ROUND(P_TO/ ( NMC + 1),2)
	 	  END IF
		  
		  
		   
		  If NMC>0 Then
		   MTTR =  ROUND( MC / NMC,2)
		  Else
		 	 MTTR =  0
		  End If
		 
		  If NMC>0 Then MTBS =  ROUND( P_TO / ( NDO + NMC + 1), 2 ) End If
		 
		  DISP = ROUND( ((TC - MP - MC)/TC)*100 ,2)
		  UTIL = ROUND((P_TO/TC)*100  , 2 )
		  
		Response.Write "<data>"
			Response.Write "<point>" & MTBF & "</point>"
			Response.Write "<dataLabels>" & ORs.Fields.Item(1).Value & "</dataLabels>"
		Response.Write "</data>"
		ORs.MoveNext
	Wend
	Response.Write "</series>"
		
	ORs.MoveFirst
	Response.Write "<series>"
	Response.Write "<name>MTTR</name>"
	Response.Write "<type>column</type>"
	Response.Write "<naxi>2</naxi>"
		
	While Not ORs.EOF
	
	 	TC = ROUND(ORs.Fields.Item(2).Value)
		 MP = ROUND(ORs.Fields.Item(3).Value/60,2)
		 MC = ROUND(ORs.Fields.Item(4).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(5).Value/60,2) 
		 NDO = ROUND(ORs.Fields.Item(6).Value)
		 NMC = ROUND(ORs.Fields.Item(7).Value)	
		    
		  P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		  
		 ' response.write ORs.Fields.Item(0).Value & " ** " & MONTH(NOW)
		  If NMC>0 Then
		    MTBF = 0
		  Else
		 	 MTBF = ROUND(P_TO/ ( NMC + 1),2)
		  End If
		  		  
		  If NMC>0 Then
		   MTTR =  ROUND( MC / NMC,2)
		   
		  Else 
		    MTTR = 0
		  End If
		 
		  If NMC>0 Then MTBS =  ROUND( P_TO / ( NDO + NMC + 1), 2 ) End If
		 
		  DISP = ROUND( ((TC - MP - MC)/TC)*100 ,2)
		  UTIL = ROUND((P_TO/TC)*100  , 2 )
		  
		Response.Write "<data>"
			Response.Write "<point>" & MTTR & "</point>"
			Response.Write "<dataLabels>" & MTTR & "</dataLabels>"
		Response.Write "</data>"
		ORs.MoveNext
	Wend
	
	Response.Write "</series>"
	
	Response.Write "<series>"
	Response.Write "<name>Disponibilidad </name>"
	Response.Write "<type>line</type>" 
	Response.Write "<naxi>2</naxi>"

	ORs.MoveFirst
	While Not ORs.EOF

 		 TC = ROUND(ORs.Fields.Item(2).Value)
		 MP =  ROUND(ORs.Fields.Item(3).Value/60,2)
		 MC = ROUND(ORs.Fields.Item(4).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(5).Value/60,2) 
		 NDO = ROUND(ORs.Fields.Item(6).Value)
		 NMC = ROUND(ORs.Fields.Item(7).Value)
		 TPM =  MP + MC  
		 P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		 
		 DISP = ROUND( ((TC - MP - MC)/TC)*100 ,2)
		 UTIL = ROUND((P_TO/TC)*100  , 2 )
	
		  'If NMC>0 Then
		  '  DISP = 0
		  'Else
		  '	  DISP = ROUND( ((TC - MP - MC)/TC)*100 ,2)
		  'End If
	
	
		  
		Response.Write "<data>"
		Response.Write "<point>" & DISP & "</point>"
		Response.Write "<dataLabels>" & DISP &  " %</dataLabels>"
		
		Response.Write "</data>"
		ORs.MoveNext
	Wend
	
	Response.Write "</series>"
	
	
	Response.Write "<series>"
	Response.Write "<name>Utilizaci�n</name>"
	Response.Write "<type>line</type>" 
	Response.Write "<naxi>3</naxi>"

	ORs.MoveFirst
	While Not ORs.EOF

 		 TC = ROUND(ORs.Fields.Item(2).Value)
		 MP =  ROUND(ORs.Fields.Item(3).Value/60,2)
		 MC =  ROUND(ORs.Fields.Item(4).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(5).Value/60,2) 
		 NDO = ROUND(ORs.Fields.Item(6).Value)
		 NMC = ROUND(ORs.Fields.Item(7).Value)
		 TPM =  MP + MC  
		 
		 P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		 
		 DISP = ROUND( ((TC - MP - MC)/TC)*100 ,2)
		 UTIL = ROUND( (P_TO/TC)*100  , 2 )
	
		' IF ORs.Fields.Item(0).Value > MONTH(NOW) THEN
		 ' 	 UTIL = 0
		 ' ELSE  
		  	  UTIL = ROUND( (P_TO/TC)*100  , 2 )
	 	  'END IF
		  
		Response.Write "<data>"
		Response.Write "<point>" & UTIL & "</point>"
		Response.Write "<dataLabels>" & UTIL &  " %</dataLabels>"
		
		Response.Write "</data>"
		ORs.MoveNext
	Wend
	
	Response.Write "</series>"
	
	
	Response.Write "</chart>"
	
	
end function


function listIndicadores()

Session.LCID = 1036
 

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION IN (" & SECCION & ")"
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FECHA>" & ORs.Fields.Item(0).Value & "/" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<TC>" & ORs.Fields.Item(2).Value & "</TC>"
		  Response.Write "<TT>" & ORs.Fields.Item(3).Value & "</TT>"
		  Response.Write "<ST>" & ORs.Fields.Item(4).Value & "</ST>"
		  Response.Write "<FM>" & ORs.Fields.Item(5).Value & "</FM>"
		  Response.Write "<MP>" & ORs.Fields.Item(6).Value & "</MP>"
		  Response.Write "<FO>" & ORs.Fields.Item(7).Value & "</FO>"
		  Response.Write "<OP>" & ORs.Fields.Item(8).Value & "</OP>"
		  Response.Write "<NF>" & ORs.Fields.Item(9).Value & "</NF>"
		  Response.Write "<TP>" & ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value & "</TP>"
		  Response.Write "<DISP>" & ROUND(((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value + ORs.Fields.Item(4).Value) / isCero(ORs.Fields.Item(2).Value))*100,2) & "</DISP>"
		  
		  Response.Write "<UTIL>" & ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value )/ isCero(ORs.Fields.Item(2).Value)*100,2) & "</UTIL>"
		  Response.Write "<MTBF>" & ROUND((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value)/ isCero(ORs.Fields.Item(9).Value),2) & "</MTBF>"
		  Response.Write "<MTTR>" & ROUND(ORs.Fields.Item(3).Value / isCero(ORs.Fields.Item(9).Value),2) & "</MTTR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function tblIndAn()

	IF LEN(AREA)=0 THEN
		query = query & " SELECT SUBSTRING(S.DESCRIPCION,0,15),"
	ELSE
		query = query & " SELECT E.CODIGO,"
	END IF
	
	

	query = query & "  MONTH(FECHA_INI) AS MES,"
	query = query & "  YEAR(FECHA_INI) AS ANO,"
	query = query & "  dbo.GetDaysInMonth2(FECHA_INI)*24 AS TC,"
	
	query = query & "  isnull(SUM(CASE WHEN P.TIPO IN ('MP') THEN P.MINUTOS END),0) AS MP, "
	
	query = query & "  isnull(ROUND(SUM(CASE WHEN P.TIPO IN ('CM','CT','CI','CE') "
	query = query & "  THEN P.MINUTOS END),2),0) AS MC, "
	
	query = query & "  isnull(ROUND(SUM(CASE WHEN P.TIPO IN ('DO') THEN P.MINUTOS END),2),0) AS DO,"
	query = query & "  COUNT(*) , "
	query = query & "  ROUND(SUM(MINUTOS),2) AS TT "
	query = query & " FROM PARADAS AS P  "
	query = query & " INNER JOIN EQUIPOS AS E ON  E.CODIGO  = DBO.EQUIPOPRINCIPALFAENA(P.EQUIPO," & strNvl(FAENA) & ")"
	query = query & " INNER JOIN SECCIONES AS S ON S.CODIGO = E.SECTOR AND S.FAENA=P.FAENA "
	query = query & " WHERE   "
	query = query & "	  	    P.FAENA = " & strNvl(FAENA) 
	query = query & "	  	    AND  MONTH(FECHA_INI)=" & strNvl(MES) & " AND YEAR(FECHA_INI)=" & strNvl(ANHO)
	
	IF LEN(AREA)=0 THEN
		  
		query = query & " GROUP BY SUBSTRING(S.DESCRIPCION,0,15),"
	ELSE
		query = query & " AND E.SECTOR =" & strNvl(AREA)
		query = query & " AND	P.EQUIPO NOT IN ('1','2','3','4','5')"
		
		query = query & " GROUP BY E.CODIGO,"
	END IF
	
		
	query = query & " MONTH(FECHA_INI), YEAR(FECHA_INI)  , "
	query = query & "		  dbo.GetDaysInMonth2(FECHA_INI)*24"
	query = query & " ORDER BY 8 DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
 
		
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
		Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
	      Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
		  Response.Write "<MES>" & ORs.Fields.Item(1).Value & "</MES>"
		  Response.Write "<ANHO>" & ORs.Fields.Item(2).Value & "</ANHO>"
   		  Response.Write "<TC>" & ORs.Fields.Item(3).Value & "</TC>"
		  Response.Write "<TT>" & ORs.Fields.Item(8).Value & "</TT>"
			  
		 TC = ROUND(ORs.Fields.Item(3).Value)
		 MP = ROUND(ORs.Fields.Item(4).Value/60,2)
		 MC = ROUND(ORs.Fields.Item(5).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(6).Value/60,2) 
		 
		 NDO = 0
		 NMC = ROUND(ORs.Fields.Item(7).Value)	
		  
		   
		 P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		 
		 MTBF = ROUND(P_TO/ ( NMC + 1),2)

		  If NMC>0 Then MTTR =  ROUND( MC / NMC,2) End If
		  If MTTR = 0 then MTTR=0.1 End If
		  If NMC>0 Then MTBS =  ROUND( P_TO / ( NDO + NMC + 1), 2 ) End If
		  
		  
		  Response.Write "<MP>" & MP & "</MP>"
		  Response.Write "<MC>" & MC & "</MC>"
		  Response.Write "<DO>" & P_DO & "</DO>"
		  Response.Write "<NDO>" & NDO & "</NDO>"
		  Response.Write "<NMC>" & NMC & "</NMC>"
		  
		  P_TO = TC - MP - MC - P_DO
		  
		  Response.Write "<TO>" & P_TO & "</TO>"
		  Response.Write "<MTBF>" &  MTBF  & "</MTBF>"
		
		  If NMC>0 Then
			 Response.Write "<MTTR>" & MTTR   & "</MTTR>"
		  End If
 
		 
		  If NMC>0 Then
			 Response.Write "<TPM>" & ROUND( MP + MC , 2 )  & "</TPM>"
		  End If
		  
		
		  
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	

end function

function graphMTTR()

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION = " & strNvl(SECCION)
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='MTTR' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst

	Response.Write "<dataset seriesName='MTTR'  showValues='1' color='94B0BE'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(3).Value / isCero(ORs.Fields.Item(9).Value),2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grEspesor()

    Dim aMuestreo(200)
	Dim aProyec
	Dim aRetorno
	Dim aFolios
	
	query = "SET DATEFORMAT DMY SELECT M.FOLIO, M.FECHA "
	query = query & " FROM MEDICIONES AS M "
	query = query & " WHERE M.FOLIO IN (" & FOLIOS & ")"
	query = query & " ORDER BY M.FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	FLAT=0
	TIPO="CAR"
	
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>"
	i=1
	Response.Write "<categories>"
	Response.Write "<item>0</item>"
	While Not ORs.Eof
		
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value
		Response.Write "<item>" & i & "</item>"
		ORs.MoveNext
		 i=i+1
	Wend
	Response.Write "</categories>"
	
	
	query = "SELECT MV.ID+1, convert(float,isnull(MV.VALOR,0)) "
	query = query & " FROM MEDICIONES_VALOR AS MV "
	query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
	query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
	query = query & " ORDER BY MV.ID "
	 	
	Set ORsLecturas =oDB.EjecutaSql(query)
	
 	Response.Write "<series>"
	Response.Write "<name>Cubierta Original</name>"
	Response.Write "<color>#333333</color>"	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
 
		Response.Write "<data>"
			Response.Write "<point>" & CUBIERTA &  "</point>"
		Response.Write "</data>"
		
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & CUBIERTA &  "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"	
	
	ORsLecturas.MoveFirst
	Response.Write "<series>"' & query
	Response.Write "<name>" & FECHA & "</name>"
	Response.Write "<color>#00ee00</color>"	
	Response.Write "<type>line</type>" 'areaspline
	i=1
			desgMax = 0
			media=0
			min=100
			If Not ORsLecturas.Eof Then
				Response.Write "<data><point>" & ORsLecturas.Fields.Item(1).Value & "</point></data>"
			End If
			
			While Not ORsLecturas.Eof
		 	
				Response.Write "<data>"
				aMuestreo(i) = ORsLecturas.Fields.Item(1).Value
				Response.Write "<point>" &  ORsLecturas.Fields.Item(1).Value  & "</point>"
					
				If desgMax < CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value) Then
					desgMax = CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value)
				End If
				
				If min>ORsLecturas.Fields.Item(1).Value Then
					min = ORsLecturas.Fields.Item(1).Value
				End IF
				
				i=i+1
				media=media+ (  CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value))
				ORsLecturas.MoveNext
				
				Response.Write "</data>"
			Wend
			
			if(i>1) Then
			media = media/(i-1)
			else
			media=1
			End If
 
	
	Response.Write "</series>"
	
	diasOP = ROUND(DATEDIFF("d", FECHA_INST, FECHA),0)
	tasa   = desgMax / diasOP 
	diasP  = (CUBIERTA-ESPESOR_SEG) / tasa
 
	tasaM   = media / diasOP 
	diasPM  = (CUBIERTA-ESPESOR_SEG) / tasaM
	
	fechaT = dateAdd("d", diasPM, FECHA_INST)
		
	IF CHK_MEDIA="TRUE" THEN
		Response.Write "<series>"
		Response.Write "<name>Proyecci�n Media " & fechaT  & " " & round(media,1) & "</name>"
		Response.Write "<color>#F80000</color>"	
		Response.Write "<type>spline</type>"
		 i=1
	
		ORsLecturas.MoveFirst
		valor = aMuestreo(i)
		desgaste = (CUBIERTA) - valor
		desgastePr = (CUBIERTA)  - (desgaste / diasP) * diasPM  
			
		Response.Write "<data><point>" & round(desgastePr,2) & "</point></data>"
		
		While Not ORsLecturas.Eof
			Response.Write "<data>" 
			valor = aMuestreo(i)
			desgaste = (CUBIERTA) - valor
			desgastePr = (CUBIERTA)  - (desgaste / diasP) * diasPM  
		 	Response.Write "<point>" & round(desgastePr,2) & "</point>"
			i=i+1
			ORsLecturas.movenext
			Response.Write "</data>"
		Wend
		Response.Write "</series>"
	
	END IF
	
	i=1
	diasOP = ROUND(DATEDIFF("d", FECHA_INST, FECHA),0)
	tasa   = desgMax / diasOP 
	diasP  = (CUBIERTA-ESPESOR_SEG) / tasa
    fechaT1 = dateAdd("d",diasP,FECHA_INST)
	
	If CHK_MAX="TRUE" THEN
	
	Response.Write "<series>"
	Response.Write "<name>Proyecci�n " & fechaT1 &  " " & round(desgMax,1) & "</name>"
	Response.Write "<color>#E8C60D</color>"	
	Response.Write "<type>spline</type>"
	 
	ORsLecturas.MoveFirst
			valor = aMuestreo(i)
			desgaste = CUBIERTA - valor
			desgastePr = CUBIERTA - (desgaste / diasOP) * diasP  
			
	Response.Write "<data><point>" & round(desgastePr,2) & "</point></data>"
		
		While Not ORsLecturas.Eof
			Response.Write "<data>" 
			valor = aMuestreo(i)
			desgaste = CUBIERTA - valor
			desgastePr = CUBIERTA - (desgaste / diasOP) * diasP  
		 	Response.Write "<point>" & round(desgastePr,2) & "</point>"
			i=i+1
			ORsLecturas.movenext
			Response.Write "</data>"
		Wend
	Response.Write "</series>"
	
	END IF
	
	
	
	Response.Write "<series>"
	Response.Write "<name>Centro</name>"
	Response.Write "<color>#cccccc</color>"	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
	Response.Write "<data><point>0</point></data>"
 
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>0</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"
	
	Response.Write "<series>"
	Response.Write "<name>Esp. de Seguridad</name>"
	Response.Write "<color>#FF0000</color>"	
	 
	
	If CHK_MAX="TRUE" Then
		Response.Write "<dMax>" & round(desgMax, 3)  & "</dMax>"	 'round(desgMax,3) 
		Response.Write "<tasa>" & round(tasa, 3) & "</tasa>"	 'round(tasa*30 ,3)
		Response.Write "<fechaP>" & fechaT1 & "</fechaP>"	
	Else
		Response.Write "<dMax>" & round(media, 3)  & "</dMax>"	 'round(desgMax,3) 
		Response.Write "<tasa>" & round(tasaM, 3) & "</tasa>"	 'round(tasa*30 ,3)
		Response.Write "<fechaP>" & fechaT & "</fechaP>"	
	End If
	
	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
	Response.Write "<data><point>" & ESPESOR_SEG & "</point></data>"
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & ESPESOR_SEG & "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"	
	
	Response.Write "<series>"
	Response.Write "<name>Retorno</name>"
	Response.Write "<color>#333333</color>"	
	Response.Write "<type>line</type>"
 
	ORsLecturas.MoveFirst
	Response.Write "<data><point>" & RETORNO & "</point></data>"
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & RETORNO & "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"
	
	

			
	Response.Write "</chart>"
	
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grEspesor2()
    
	Dim aMuestreo(100)
	Dim aProyec
	Dim aRetorno
	Dim desgMax
	Dim media
	Dim min
		
	query = "SET DATEFORMAT DMY SELECT M.FOLIO, M.FECHA "
	query = query & " FROM MEDICIONES AS M "
	query = query & " WHERE M.FOLIO IN (" & FOLIOS & ")"
	query = query & " ORDER BY M.FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	FLAT=0
	TIPO="CAR"
	
	While Not ORs.Eof
			
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value

		query = "SELECT MV.ID, MV.VALOR "
		query = query & " FROM MEDICIONES_VALOR AS MV "
		query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
		query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
		query = query & " ORDER BY MV.ID "
	 
		Set ORsLecturas =oDB.EjecutaSql(query)
		
		IF FLAT=0 THEN
			FLAT = 1
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<chart palette='3' caption='MEDICION DE ESPESORES   " & EQUIPO & " - " & FAENA & "' shownames='1'  showvalues='1' overlapBars='2' showShadow='1' yAxisMaxValue='" & CUBIERTA & "' yAxisMinValue='" & FONDO & "'  imageSave='1' imageSaveURL='FCExporter.php' legendPosition='BOTTOM'>"
		 
			i=1
			desgMax = 0
			media=0
			min=100
			Response.Write "<categories>"
			While Not ORsLecturas.Eof
		 		Response.Write "<category label='" & i & "' />"
				aMuestreo(i) = ORsLecturas.Fields.Item(1).Value
				If desgMax < CUBIERTA - ORsLecturas.Fields.Item(1).Value Then
					desgMax = CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value)
				End If
				
				If min>ORsLecturas.Fields.Item(1).Value Then
					min = ORsLecturas.Fields.Item(1).Value
				End IF
				i=i+1
				media=media+ORsLecturas.Fields.Item(1).Value
				ORsLecturas.MoveNext
			Wend
			media = media/(i-1)
			
			Response.Write "</categories>"
		
			j=i
			
		  END IF
		

		i=1
		ORsLecturas.MoveFirst
		Response.Write "<dataset seriesName='MUESTREO " & ORs.Fields.Item(1).Value & "'  showValues='0' anchorRadius='2' lineThickness='2' color='FF0000'>" 
		While Not ORsLecturas.eof
		 		Response.Write "<set label='" & ORsLecturas.Fields.Item(0).Value _
					 & "' value='" & ORsLecturas.Fields.Item(1).Value & "' />"
				'Response.Write(aMuestreo(i))
			i=i+1
			ORsLecturas.movenext
		Wend
		
		Response.Write "</dataset>"
		ORs.MoveNext	
	Wend
	
	i=1
	
	diasOP = ROUND(DATEDIFF("d", FECHA_INST, FECHA),0)
	tasa   = desgMax / diasOP 
	
	diasP  = (CUBIERTA-ESPESOR_SEG) / tasa
	
    fechaT = dateAdd("d",diasP,FECHA_INST)
	
	Response.Write "<dataset seriesName='PROYECCION " &  fechaT & " Tasa " & round(tasa,3) & "mm/d�a   Media " & round(media,3) & " Min " & min & "'  showValues='0' anchorRadius='2' color='FFCC00'>" 


			
	While i<=j 'GRAFICAR
			valor = aMuestreo(i)
			desgaste = CUBIERTA - valor
			desgastePr = CUBIERTA - (desgaste / diasOP) * diasP
			
		 	Response.Write "<set label='" & i & "' value='" & desgastePr & "' />"
		    'Response.Write "<set label='" & i & "' value='" & desgaste & "' />"
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	IF LEN(FOLIO_R)>0 THEN
		query = "SELECT MV.ID, MV.VALOR "
		query = query & " FROM MEDICIONES_VALOR AS MV "
		query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO_R)
		query = query & " AND MV.TIPO='RET'" '& strNvl(TIPO)
		query = query & " ORDER BY MV.ID "
		Set ORsRetorno =oDB.EjecutaSql(query)
		
		i=1
		Response.Write "<dataset seriesName='RETORNO'  showValues='0' color='000000' anchorRadius='1'>" 
		While Not ORsRetorno.eof 
		 	Response.Write "<set label='" & i & "' value='-" & ORsRetorno.Fields.Item(1).Value & "' />"
			ORsRetorno.MoveNext
			i=i+1
		Wend
		Response.Write "</dataset>"
		
	END IF ' RETORNO
	
   	Response.Write "<trendLines >"
    Response.Write "<line startValue='0' endValue='-0.5' color='00000' displayvalue='CARCASA   ' isTrendZone='1'  /> "
	
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & ESPESOR_SEG & "' color='FFFF00' displayvalue='SEGURIDAD' valueOnRight='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & CUBIERTA & "' color='000099' displayvalue='CUBIERTA' thickness='1' valueOnRight='1' showOnTop='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='" & FONDO & "' color='000099' displayvalue='RETORNO' thickness='1' valueOnRight='1' showOnTop='1'/> "
	Response.Write "</trendLines>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function grEspesor3()
'on error resume next

	Set Cn = oDB.Conexion
   	
	Dim Rs
	Dim STR
    IF LEN(AREA)=0 THEN
		'AREA = 1
	END IF
   
	 Dim aEquipos
	Dim aDesgaste
	Dim aRema
	Dim aSeg
	Dim i
	
	aEquipos = Split(EQUIPOS, ";")
	aSeg = Split(SEGS, ";")  
	aRema = Split(REMA, ";")  
	aDesgaste = Split(DESGASTES, ";")  
	
 
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf 
	Response.Write "<categories>"& VbCrLf
  	
	i=1
	
	While i <= ubound(aEquipos) 
		Response.Write "<item>" & aEquipos(i) &  "</item>" & VbCrLf
		 i = i + 1
	Wend
	Response.Write "</categories>" & VbCrLf
	
 
	
	
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Desgaste [mm]</name>" & VbCrLf
	Response.Write "<color>#cccccc</color>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	i=1
	While i<=ubound(aDesgaste) 
		Response.Write "<point>" & replace(aDesgaste(i),",",".") & "</point>" & VbCrLf
		i = i + 1
	Wend 'wend series
 	
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	
 
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Espesor Remanente [mm]</name>" & VbCrLf
	Response.Write "<color>#ED7D31</color>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	
	i=1
	While i<=ubound(aRema) 
		Response.Write "<point>" & replace(aRema(i),",",".")  & "</point>" & VbCrLf
		i = i + 1
	Wend 'wend series
 	
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	
	
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>Espesor Seguridad [mm]</name>" & VbCrLf
	Response.Write "<color>#5B9BD5</color>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	
	i=1
	While i<=ubound(aSeg) 
		Response.Write "<point>" & aSeg(i) & "</point>" & VbCrLf
		i = i + 1
	Wend 'wend series
 	
	Response.Write "</data>" &  VbCrLf
	Response.Write "</series>" &  VbCrLf
	
	Response.Write "</chart>" &  VbCrLf
	
end function



function grProyec()

    Dim aMuestreo
	Dim aProyec
	
	aMuestreo = Split(MUESTREO, ";")
	aProyec = Split(PROYEC, ";")
	
	'response.Write(ubound(aMuestreo))
	
	Response.Write "<?xml version='1.0' encoding='utf-8'?>"
	Response.Write "<chart palette='2' caption='Proyecciones' shownames='1' formatNumberScale='0' formatNumber='0' showShadow='1'  rotateLabels='1' showDivLineValues='1' divLineThickness='3' yAxisMinValue='200000' numberSuffix=' YYYYMM' imageSave='1' imageSaveURL='FCExporter.php'>"
	i=1
	Response.Write "<categories>"
	While i<=ubound(aMuestreo) 
		 	Response.Write "<category label='" & aMuestreo(i) & "' />"
			'Response.Write(aMuestreo(i))
		i=i+1
	Wend
	Response.Write "</categories>"

	
	i=1
	Response.Write "<dataset seriesName='PROYECCION' showValues='0' rotateLabels='1' >" 
	While i<=ubound(aProyec) 
		 	Response.Write "<set label='" & aMuestreo(i) & "' value='" & aProyec(i) & "' />"
			'Response.Write(aProyec(i)))
		i=i+1
	Wend
	Response.Write "</dataset>"
	
	Response.Write "<trendLines>"
    Response.Write "<line startValue='200900' color='000000' displayvalue='Año Actual 2023' valueOnRight='1'/> "
	Response.Write "</trendLines>"
	
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function graphDispUtil()

query =	" SELECT NOMBRE, P.ANO, ISNULL(P.TC,0), ISNULL(P.TT,0), ISNULL(P.ST,0), ISNULL(P.FM,0), ISNULL(P.MP,0), "
query = query  & " ISNULL(P.FO,0), ISNULL(P.OP,0), ISNULL(P.NF,0) "
query = query  & " FROM MESES LEFT OUTER JOIN ("
query =	query  & " SELECT MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query  & "     dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query  & "     ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2) AS FM, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query  & "	   ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query  & "     ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query  & " FROM PARADAS AS P  "
query = query  & " WHERE P.SECCION = " & strNvl(SECCION)
query = query  & "	  	    AND  FAENA = " & strNvl(FAENA)
query = query  & "	  	    AND  FECHA_INI BETWEEN " & strNvl(INICIO) & " AND " & strNvl(TERMINO) 
query = query  & " GROUP BY MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 ) AS P ON P.MES=NUMERO "
query = query  & " ORDER BY NUMERO "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Indicadores' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & Mid(CStr(ORs.Fields.Item(0).Value),1,3) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	ORs.MoveFirst

	Response.Write "<dataset seriesName='Disponibilidad'  RenderAs='Line'  >" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(((ORs.Fields.Item(2).Value - ORs.Fields.Item(3).Value + ORs.Fields.Item(4).Value) / isCero(ORs.Fields.Item(2).Value))*100,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Mantenci�n Programada'  showValues='0' color='FF0000'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(6).Value,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Fallas x Mantenci�n'  showValues='0' color='94B0BE'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(5).Value,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Fallas x Operaci�n'  showValues='0' color='00FF33'>" 
	While Not ORs.EOF 
		 	Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(7).Value,2),",",".") & "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	Response.Write "</chart>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listAnalisis()

query =	" SELECT dbo.equipoprincipal(P.EQUIPO), MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION IN (" & SECCION & ")" 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY dbo.equipoprincipal(P.EQUIPO), MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY TT DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	While Not ORs.EOF
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value  & "</EQUIPO>"
		  Response.Write "<TC>" & ORs.Fields.Item(3).Value & "</TC>"
		  Response.Write "<TT>" & ORs.Fields.Item(4).Value & "</TT>"
		  Response.Write "<ST>" & ORs.Fields.Item(5).Value & "</ST>"
		  Response.Write "<FM>" & ORs.Fields.Item(6).Value & "</FM>"
		  Response.Write "<PORC>" & ROUND(ORs.Fields.Item(6).Value/isCero(TTotalFM)*100,2) & "%</PORC>"
		  ProcAcum = ProcAcum + (ORs.Fields.Item(6).Value/isCero(TTotalFM))
		  Response.Write "<PORC_ACUM>" & ROUND(ProcAcum*100,2) & "%</PORC_ACUM>"
		  Response.Write "<MP>" & ORs.Fields.Item(7).Value & "</MP>"
		  Response.Write "<FO>" & ORs.Fields.Item(8).Value & "</FO>"
		  Response.Write "<OP>" & ORs.Fields.Item(9).Value & "</OP>"
		  Response.Write "<NF>" & ORs.Fields.Item(10).Value & "</NF>"
		  Response.Write "<TP>" & ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value & "</TP>"
		  MTBF = ROUND((ORs.Fields.Item(3).Value - ORs.Fields.Item(4).Value)/ isCero(ORs.Fields.Item(10).Value),2)
		  T_MTBF = T_MTBF + MTBF
		  MTTR = ROUND(ORs.Fields.Item(4).Value / isCero(ORs.Fields.Item(10).Value),2)
		  T_MTTR = T_MTTR + MTTR
		  Response.Write "<MTBF>" & MTBF & "</MTBF>"
		  Response.Write "<MTTR>" & MTTR & "</MTTR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	 Response.Write "<ROW>"
	 		Response.Write "<EQUIPO>TOTALES </EQUIPO>"
	 		Response.Write "<FM>" & TTotalFM & "</FM>"
			Response.Write "<TT>" & TTotal & "</TT>"
			Response.Write "<NF>" & TTotalNF & "</NF>"
			Response.Write "<PORC>100%</PORC>"
			Response.Write "<MTBF>" & ROUND(T_MTBF/C,2) & "</MTBF>"
		  	Response.Write "<MTTR>" & ROUND(T_MTTR/C,2) & "</MTTR>"
			Response.Write "<PORC_ACUM>�</PORC_ACUM>"
	 Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function
		 
function graphPareto()

query =	" SELECT P.EQUIPO, MONTH(FECHA_INI) AS MES,YEAR(FECHA_INI) AS ANO,"
query = query & "		dbo.GetDaysInMonth(FECHA_INI)*24 AS TC, "
query = query & "		ROUND(SUM(MINUTOS)/60,2) AS TT, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('ST', 'RS') THEN MINUTOS END)/60,2) AS ST, "
query = query & "		ISNULL(ROUND(SUM(CASE WHEN TIPO IN ('FE','FM','FI','FG') THEN MINUTOS END)/60,2),0) AS FM, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('MP') THEN MINUTOS END)/60,2) AS MP, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('FO') THEN MINUTOS END)/60,2) AS FO, "
query = query & "		ROUND(SUM(CASE WHEN TIPO IN ('OP') THEN MINUTOS END)/60,2) AS OP, COUNT(*) AS NF "
query = query & " FROM PARADAS AS P  "
query = query & " WHERE  P.SECCION in (" & SECCION & ")" 
query = query & "	  	    AND  FAENA = " & strNvl(FAENA) 
query = query & "	  	    AND  MONTH(FECHA_INI)=" & MES & " AND YEAR(FECHA_INI)=" & ANHO 
query = query & " GROUP BY P.EQUIPO, MONTH(FECHA_INI), YEAR(FECHA_INI), dbo.GetDaysInMonth(FECHA_INI)*24 "
query = query & " ORDER BY TT DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TTotalC = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	
	If ORs.Eof Then
	  	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
			Response.Write "<REGISTROS>"
			Response.Write "</REGISTROS>"
		Exit Function
	End If
	
	While Not ORs.EOF
		TTotalC = TTotalC + CDbl(ORs.Fields.Item(3).Value)
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(10).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	
	ORs.MoveFirst
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart palette='2' caption='Pareto Tiempo Fuera de Servicios' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php' rotateLabels='1' showBorder='1'>"
	Response.Write "<categories>"
	While Not ORs.EOF 
		Response.Write "<category label='" & CStr(ORs.Fields.Item(0).Value) &  "' />"
		 ORs.MoveNext
	Wend
	Response.Write "</categories>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Horas Total Tiempo FS'  showValues='1' color='94B0BE'>" 
	While Not ORs.EOF 
		Response.Write "<set value='" & REPLACE(ROUND(ORs.Fields.Item(4).Value/TTotal*100,2),",",".") & "' />"
		ORs.MoveNext
	Wend
	Response.Write "</dataset>"
	
	ORs.MoveFirst
	Response.Write "<dataset seriesName='Acumulado'  showValues='1' color='FFF000' RenderAs='Line' >" 
	While Not ORs.EOF 
		ProcAcum = ProcAcum + (ORs.Fields.Item(4).Value/TTotal)
		Response.Write "<set value='" & REPLACE(ROUND(ProcAcum*100,2),",",".") & "' />"
		ORs.MoveNext
	Wend
	Response.Write "</dataset>"

	Response.Write "</chart>"
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grDisp()

 
	 
	
	IF LEN(AREA)=0 THEN
		query = query & " SELECT S.DESCRIPCION,"
	ELSE
		query = query & " SELECT E.DESCRIPCION,"
	END IF
	
	query = query & "  MONTH(FECHA_INI) AS MES,"
	query = query & "  YEAR(FECHA_INI) AS ANO,"
	
	query = query & "  dbo.GetDaysInMonth2(FECHA_INI)*24 AS TC,"
	
	query = query & "  isnull(SUM(CASE WHEN P.TIPO IN ('MP') THEN P.MINUTOS END),0) AS MP, "
	query = query & "  isnull(ROUND(SUM(CASE WHEN P.TIPO IN ('CM','CT','CI','CE') "
	query = query & "  THEN P.MINUTOS END),2),0) AS MC, "
	
	query = query & "  isnull(ROUND(SUM(CASE WHEN P.TIPO IN ('DO') THEN P.MINUTOS END),2),0) AS DO,"
	
	query = query & "  COUNT(*),  "
	query = query & "  ROUND(SUM(MINUTOS),2) AS TT "
	query = query & " FROM PARADAS AS P  "
	query = query & " INNER JOIN EQUIPOS AS E ON DBO.EQUIPOPRINCIPALFAENA(P.EQUIPO," & strNvl(FAENA) & ") = E.CODIGO "
	query = query & " INNER JOIN SECCIONES AS S ON S.CODIGO = E.SECTOR AND S.FAENA=P.FAENA "
	query = query & " WHERE   " 'P.SECCION in (1,2) AND
	query = query & "	  	      P.FAENA = " & strNvl(FAENA) 
	query = query & "	  	    AND  MONTH(FECHA_INI)=" & strNvl(MES) & " AND YEAR(FECHA_INI)=" & strNvl(ANHO)
	
	IF LEN(AREA)=0 THEN
		 
		query = query & " GROUP BY S.DESCRIPCION,"
	ELSE
		query = query & " AND E.SECTOR =" & strNvl(AREA)
		query = query & " AND	P.EQUIPO NOT IN ('1','2','3','4','5')"
		query = query & " GROUP BY E.DESCRIPCION,"
	END IF
	
	
	
	query = query & " MONTH(FECHA_INI), YEAR(FECHA_INI)  , "
	query = query & "		  dbo.GetDaysInMonth2(FECHA_INI)*24"
	query = query & " ORDER BY 8 DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	TTotalFM = 0
	TTotal = 0
	TotalNF = 0
	T_MTBF = 0
	T_MTTR = 0
	ProcAcum = 0
	C=0
	sx = 0
	sy = 0
	sxy = 0
	sx2 = 0
	yt=0
	
			
	If(Not ORs.eof) Then
	
	While Not ORs.EOF
		TTotal = TTotal +  CDbl(ORs.Fields.Item(4).Value)
		TTotalFM = TTotalFM +  CDbl(ORs.Fields.Item(6).Value)
		'TTotalNF = TTotalNF +  CDbl(ORs.Fields.Item(8).Value)
		C=C+1
		ORs.MoveNext
	Wend
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & query
	
	ORs.MoveFirst
	i=1
	T_MTBF =  0
	T_MTTR = 0
	
	While Not ORs.EOF
	
		 TC = ROUND(ORs.Fields.Item(3).Value)
		 MP = ROUND(ORs.Fields.Item(4).Value/60,2)
		 MC = ROUND(ORs.Fields.Item(5).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(6).Value/60,2) 
		 
		 NDO = 0
		 NMC = ROUND(ORs.Fields.Item(7).Value)	
		  
		   
		 P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		 
		 MTBF = ROUND(P_TO/ ( NMC + 1),2)

		  If NMC>0 Then MTTR =  ROUND( MC / NMC,2) End If
		  If MTTR = 0 then MTTR=0.001 End If
		  If NMC>0 Then MTBS =  ROUND( P_TO / ( NDO + NMC + 1), 2 ) End If
		  
		  T_MTBF = T_MTBF  + MTBF 
		  T_MTTR = T_MTTR + MTTR 
		  
		Response.Write "<series>" & VbCrLf
		Response.Write "<name>" & ORs.Fields.Item(0).Value  & "</name>" & VbCrLf
		Response.Write "<type>scatter</type>" & VbCrLf
		Response.Write "<mkr>true</mkr>" & VbCrLf
		Response.Write "<data>"	& VbCrLf
		Response.Write "<point>"	& VbCrLf	 
				 
		response.write "<x>" & formatNumber( MTBF,3) & "</x>" & VbCrLf
		response.write "<y>" &   formatNumber(MTTR,3)  & "</y>" & VbCrLf
		response.write "<y2>" & formatNumber(NMC,0) & "</y2>" & VbCrLf
		
		If i=1 Then
			
			x1=formatNumber( MTBF,3)
			y1=formatNumber(NMC,0)
			yt = y1
			sx = sx + x1
			sy = sy + y1
 
		Else
			x2=formatNumber( MTBF,3)
			y2=formatNumber(NMC,0)
			sx = sx + x2
			sy = sy + y2
		 
		End If
		
			'Response.Write "<dataLabels>" & ORs.Fields.Item(0).Value & "</dataLabels>"
		Response.Write "</point>"	& VbCrLf
		Response.Write "</data>" & VbCrLf
		Response.Write "</series>" & VbCrLf
			i=i+1
		ORs.MoveNext
	Wend
	
		n=i-1
		
   		mx = sx/n
		my = sy/n
		
   
   ORs.MoveFirst
   
   While Not ORs.EOF
	
		 TC = ROUND(ORs.Fields.Item(3).Value)
		 MP = ROUND(ORs.Fields.Item(4).Value/60,2)
		 MC = ROUND(ORs.Fields.Item(5).Value/60,2)
		 P_DO = ROUND(ORs.Fields.Item(6).Value/60,2) 
		 
		 NDO = 0
		 NMC = ROUND(ORs.Fields.Item(7).Value)	
		 P_TO = TC - MP - MC - P_DO ' TIEMPO OPERACIONAL
		 
		 MTBF = ROUND(P_TO/ ( NMC + 1),2)

		  If NMC>0 Then MTTR =  ROUND( MC / NMC,2) End If
		  If MTTR = 0 then MTTR=0.001 End If
		  If NMC>0 Then MTBS =  ROUND( P_TO / ( NDO + NMC + 1), 2 ) End If
	  
	 	dx=formatNumber(MTBF,3)-mx
		dy=formatNumber(NMC,0)-my
	 
		sxy = sxy + dx*dy
		
		sx2 = sx2 + dx*dx
	 
		ORs.MoveNext
	Wend
	
		
		
   		b2 =(sxy/sx2)  ' slope b
   		b1 = my-(b2*mx) ' intercep
 
   		If JK=1 Then
			'x1 = 1
			'x2 = 100
			'y1 = round(b1,3) + round(b2,3)*x1
			'y2 = round(b1,3) + round(b2,3)*x2
						
			If (round(b1,3) + round(b2,3)*x2) >0 Then
				y2 = round(b1,3) + round(b2,3)*x2
		 
			End If
			'x2 = 100
 			Response.Write "<series>" & VbCrLf
			Response.Write "<name>y =" & round(b1,3) & "" & round(b2,3) & "x" & "</name>" & VbCrLf
			Response.Write "<type>line</type>" & VbCrLf
			Response.Write "<color>#ff0000</color>" & VbCrLf
			Response.Write "<data2>"	& VbCrLf
			Response.Write "<point>"	& VbCrLf	  
			response.write "<x1>" & x1 & "</x1>" & VbCrLf
			response.write "<y1>" & y1 & "</y1>" & VbCrLf  
			response.write "<x2>" & x2 & "</x2>" & VbCrLf
			response.write "<y2>" & y2 & "</y2>" & VbCrLf
	
			Response.Write "</point>"	& VbCrLf
		
		
		Response.Write "</data2>" & VbCrLf
		Response.Write "</series>" & VbCrLf
		End If
		
	Response.Write "</chart>"
	Else
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & query
	 
		Response.Write "<series>" & VbCrLf
		Response.Write "<name>no data.</name>" & VbCrLf
		Response.Write "<type>scatter</type>" & VbCrLf
		Response.Write "<data>"	
		Response.Write "<point>"		 
		'	Response.Write "<name>" & MTBF & "," & MTTR & "</name>"
			response.write "<x>1</x>" & VbCrLf
			response.write "<y>0.001</y>" & VbCrLf
			response.write "<y2>0.001</y2>" & VbCrLf
			'Response.Write "<dataLabels>" & ORs.Fields.Item(0).Value & "</dataLabels>"
			Response.Write "</point>"	
		Response.Write "</data>" & VbCrLf
		Response.Write "</series>" & VbCrLf
	 
	Response.Write "</chart>"
	End If
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grPolines()

 
	query =  "select chk.sector, chk.tipo, chk.falla, isnull(chk.mesa, chk.est) , chk.est, e.largo"
	query = query & " from check_polines as chk, equipos as e "
	query = query & " WHERE EQUIPO=" & strNvl(EQUIPO) & "  and e.codigo=chk.equipo"
	query = query & " AND  chk.tipo="  & strNvl(TIPO)
	
	If HIST<>"true" Then
		query = query & " and corregido is null "
	
	End If
	
	query = query & " ORDER BY chk.falla, chk.mesa desc"
	
	Set ORs =oDB.EjecutaSql(query)
	
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & query
	
			  SELECT CASE ORs.Fields.Item(2).Value
			
		   	CASE 1 FALLA = "Ruido"
          	CASE 2 FALLA = "Trabado"
            CASE 3 FALLA = "Faltante"
			CASE 4 FALLA = "Sin Contacto"
            CASE 5 FALLA = "Desgastado"
            CASE 6 FALLA = "Suelta"
			CASE 7 FALLA = "Sucio"
			CASE 8 FALLA = "Rodamiento"
			CASE 9 FALLA = "Deformada"
			CASE 10 FALLA = "Cuyunturas"
			CASE 11 FALLA = "Daño Estructural"
			CASE 12 FALLA = "Desalineada"
			CASE 13 FALLA = "Temperatura"
			  	
		  END SELECT
	
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>" & FALLA  & "</name>" & VbCrLf
	Response.Write "<largo>" & ORs.Fields.Item(5).Value  & "</largo>" & VbCrLf
	Response.Write "<type>scatter</type>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
				  
	ORs.MoveFirst
	serAnt = ORs.Fields.Item(2).Value

		
	While Not ORs.EOF
	
		 SEC = ORs.Fields.Item(0).Value
		 FA = ROUND(ORs.Fields.Item(2).Value,0)
		 
		 SELECT CASE SEC
		 	CASE "IZQ"	
			 y=20 + (FA+3)

		CASE "CEN"
			 y=50 

		CASE "REC"
			 y=50 

		 CASE "EST"
			 y=50 + (FA+3)
			 			
		CASE "DER"
			 y= 75 + (FA+3)
		END SELECT 
		
		 SELECT CASE ORs.Fields.Item(2).Value
			
		   	CASE 1 FALLA = "Ruido"
          	CASE 2 FALLA = "Trabado"
            CASE 3 FALLA = "Faltante"
			CASE 4 FALLA = "Sin Contacto"
            CASE 5 FALLA = "Desgastado"
            CASE 6 FALLA = "Suelta"
			CASE 7 FALLA = "Sucio"
			CASE 8 FALLA = "Rodamiento"
			CASE 9 FALLA = "Deformada"
			CASE 10 FALLA = "Cuyunturas"
			CASE 11 FALLA = "Daño Estructural"
			CASE 12 FALLA = "Desalineada"
			CASE 13 FALLA = "Temperatura"
			CASE 14 FALLA = "Vibración"
			CASE 15 FALLA = "Falla Montaje"
            CASE 16 FALLA = "Material acumulado"
						  	
		  END SELECT
		  
		  If serAnt<>ORs.Fields.Item(2).Value Then
		
				Response.Write "</data>" & VbCrLf
				Response.Write "</series>" & VbCrLf
			
				Response.Write "<series>" & VbCrLf
				Response.Write "<name>" & FALLA  & "</name>" & VbCrLf
				Response.Write "<largo>" & ORs.Fields.Item(5).Value  & "</largo>" & VbCrLf
				Response.Write "<type>scatter</type>" & VbCrLf
				Response.Write "<data>"	& VbCrLf
				serAnt = ORs.Fields.Item(2).Value
			
			End If	

		IF SEC="EST" Then
		 
		  x = ROUND(ORs.Fields.Item(3).Value,2)
		  Response.Write "<point>"& VbCrLf
			  y=20 
		  response.write "<x>" &  X & "</x>" & VbCrLf
		  response.write "<y>" &  y & "</y>" & VbCrLf
		  Response.Write "</point>"	& VbCrLf
		  Response.Write "<point>"& VbCrLf

			If TIPO="CAR" THEN
				y=50 
				response.write "<x>" &  X & "</x>" & VbCrLf
				response.write "<y>" &  y & "</y>" & VbCrLf
				Response.Write "</point>"	& VbCrLf
				Response.Write "<point>"& VbCrLf
			End if

		  y=75 
		  response.write "<x>" &  X & "</x>" & VbCrLf
		  response.write "<y>" &  y & "</y>" & VbCrLf
		  Response.Write "</point>"	& VbCrLf
		  serAnt = ORs.Fields.Item(2).Value
	  ELSE
		
			IF SEC="REV" THEN
					x = ROUND(ORs.Fields.Item(3).Value,2)
					y=20 
					Response.Write "<point>" & VbCrLf
					response.write "<x>" &  X & "</x>" & VbCrLf
					response.write "<y>" &  y & "</y>" & VbCrLf
					Response.Write "</point>"	& VbCrLf
					y=75 
					Response.Write "<point>" & VbCrLf
					response.write "<x>" &  X & "</x>" & VbCrLf
					response.write "<y>" &  y & "</y>" & VbCrLf
					Response.Write "</point>"	& VbCrLf

				ELSE
					x = ROUND(ORs.Fields.Item(3).Value,2)
					Response.Write "<point>" & VbCrLf
					response.write "<x>" &  X & "</x>" & VbCrLf
					response.write "<y>" &  y & "</y>" & VbCrLf
					Response.Write "</point>"	& VbCrLf
				END IF
		END IF

			i=i+1
		ORs.MoveNext
	Wend
	Response.Write "</data>" & VbCrLf
	  	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>"& VbCrLf
	
	Set ORs = Nothing
	Set ODB = Nothing
end function


function grPolinesCri()

 
	query =  "select chk.sector, chk.tipo, chk.criticidad, isnull(chk.mesa, chk.est) , chk.est, e.largo"
	query = query & " from check_polines as chk, equipos as e "
	query = query & " WHERE EQUIPO=" & strNvl(EQUIPO) & "  and e.codigo=chk.equipo"
	query = query & " AND  chk.tipo="  & strNvl(TIPO)

	If HIST<>"true" Then
		query = query & " and corregido is null "
	
	End If
	
	query = query & " ORDER BY chk.criticidad, chk.mesa desc"
	
	Set ORs =oDB.EjecutaSql(query)
	
	
	Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf
	Response.Write "<chart>" & VbCrLf & query
	
		SELECT CASE ORs.Fields.Item(2).Value
			
		   	CASE 1 FALLA = "Baja"
			   color ="#00FF00"
			CASE 2 FALLA = "Media"
				   color ="#FFFF00"
			CASE 3 FALLA = "Alta"
				   color ="#FF3300"
					  	
		  END SELECT
	
	Response.Write "<series>" & VbCrLf
	Response.Write "<name>" & FALLA  & "</name>" & VbCrLf
	Response.Write "<largo>" & ORs.Fields.Item(5).Value  & "</largo>" & VbCrLf
	Response.Write "<type>scatter</type>" & VbCrLf
	Response.Write "<data>"	& VbCrLf
	Response.Write "<color>" & color &"</color>"
				  
	ORs.MoveFirst
	serAnt = ORs.Fields.Item(2).Value

		
	While Not ORs.EOF
	
		 SEC = ORs.Fields.Item(0).Value
		 FA = ROUND(ORs.Fields.Item(2).Value,0)
		 
		 SELECT CASE SEC
			CASE "DER"	
				y=20  

			CASE "CEN"
				y=50 
			
			CASE "REC"
				y=50 
			CASE "EST"
				y=50   
						
			CASE "IZQ"
				y= 75  
		END SELECT 
		
		SELECT CASE ORs.Fields.Item(2).Value
					CASE 1 FALLA = "Baja"
						color ="#00FF00"
					CASE 2 FALLA = "Media"
						color ="#FFFF00"
					CASE 3 FALLA = "Alta"
						color ="#FF3300"
		END SELECT

		If serAnt<>ORs.Fields.Item(2).Value Then
			
			Response.Write "</data>" & VbCrLf
			Response.Write "</series>" & VbCrLf
		
			Response.Write "<series>" & VbCrLf
			Response.Write "<name>" & FALLA  & "</name>" & VbCrLf
			Response.Write "<largo>" & ORs.Fields.Item(5).Value  & "</largo>" & VbCrLf
			Response.Write "<type>scatter</type>" & VbCrLf
			Response.Write "<color>" & color &"</color>"
			Response.Write "<data>"	& VbCrLf
			serAnt = ORs.Fields.Item(2).Value
 
		End If	

		If SEC="EST" Then
		 
			x = ROUND(ORs.Fields.Item(3).Value,2)
			Response.Write "<point>"& VbCrLf
				y=20 
			response.write "<x>" &  X & "</x>" & VbCrLf
			response.write "<y>" &  y & "</y>" & VbCrLf
			Response.Write "</point>"	& VbCrLf
			Response.Write "<point>"& VbCrLf

			If TIPO="CAR" THEN
			y=50 
			response.write "<x>" &  X & "</x>" & VbCrLf
			response.write "<y>" &  y & "</y>" & VbCrLf
			Response.Write "</point>"	& VbCrLf
			Response.Write "<point>"& VbCrLf
			End if

				y=75 
			response.write "<x>" &  X & "</x>" & VbCrLf
			response.write "<y>" &  y & "</y>" & VbCrLf
			Response.Write "</point>"	& VbCrLf
			serAnt = ORs.Fields.Item(2).Value
		ELSE
 
			IF SEC="REV" THEN
				x = ROUND(ORs.Fields.Item(3).Value,2)
				y=20 
				Response.Write "<point>" & VbCrLf
				response.write "<x>" &  X & "</x>" & VbCrLf
				response.write "<y>" &  y & "</y>" & VbCrLf
				Response.Write "</point>"	& VbCrLf
				y=75 
				Response.Write "<point>" & VbCrLf
				response.write "<x>" &  X & "</x>" & VbCrLf
				response.write "<y>" &  y & "</y>" & VbCrLf
				Response.Write "</point>"	& VbCrLf

			ELSE
				x = ROUND(ORs.Fields.Item(3).Value,2)
				Response.Write "<point>" & VbCrLf
				response.write "<x>" &  X & "</x>" & VbCrLf
				response.write "<y>" &  y & "</y>" & VbCrLf
				Response.Write "</point>"	& VbCrLf
			END IF
			 

		END IF
			i=i+1
 

		ORs.MoveNext
	Wend


	Response.Write "</data>" & VbCrLf
	Response.Write "</series>" & VbCrLf
	Response.Write "</chart>"& VbCrLf
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grLecturas()

    Dim aMuestreo(200)
	Dim aProyec
	Dim aRetorno
	Dim aFolios
	
	query = "SET DATEFORMAT DMY SELECT M.FOLIO, M.FECHA "
	query = query & " FROM MEDICIONES AS M "
	query = query & " WHERE M.FOLIO IN (" & FOLIOS & ")"
	query = query & " ORDER BY M.FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	FLAT=0
	TIPO="CAR"
	
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>"
	Response.Write "<chart>"
	i=1
	Response.Write "<categories>"
	Response.Write "<item>0</item>"
	While Not ORs.Eof
		
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value
		Response.Write "<item>" & i & "</item>"
		ORs.MoveNext
		 i=i+1
	Wend
	Response.Write "</categories>"
	
	query = "SELECT MV.ID+1, convert(float,isnull(MV.VALOR,0)) "
	query = query & " FROM MEDICIONES_VALOR AS MV "
	query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
	query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
	query = query & " ORDER BY MV.ID "
	 	
	Set ORsLecturas =oDB.EjecutaSql(query)
	
	
 	Response.Write "<series>"
	Response.Write "<name>Cubierta Original</name>"
	Response.Write "<color>#333333</color>"	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
 
		Response.Write "<data>"
			Response.Write "<point>" & CUBIERTA &  "</point>"
		Response.Write "</data>"
		
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & CUBIERTA &  "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"	
	
	
	ORs.MoveFirst ' Mediciones
	
	While Not ORs.Eof
	
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value
	
		query = "SELECT MV.ID+1, convert(float,isnull(MV.VALOR,0)) "
		query = query & " FROM MEDICIONES_VALOR AS MV "
		query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
		query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
		query = query & " ORDER BY MV.ID "
		 	
		Set ORsLecturas =oDB.EjecutaSql(query)
			
		ORsLecturas.MoveFirst
	
		Response.Write "<series>" ' & query
		Response.Write "<name>" & FECHA & "</name>"
		'Response.Write "<color>#f00ee00</color>"	
		Response.Write "<type>line</type>" 'areaspline
		i=1
			desgMax = 0
			media=0
			min=100
			If Not ORsLecturas.Eof Then
				Response.Write "<data><point>" & ORsLecturas.Fields.Item(1).Value & "</point></data>"
			End If
			
			
			While Not ORsLecturas.Eof
		 	
				Response.Write "<data>"
				aMuestreo(i) = ORsLecturas.Fields.Item(1).Value
					Response.Write "<point>" &  ORsLecturas.Fields.Item(1).Value  & "</point>"
					
				If desgMax < CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value) Then
					desgMax = CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value)
				End If
				
				If min>ORsLecturas.Fields.Item(1).Value Then
					min = ORsLecturas.Fields.Item(1).Value
				End IF
				
				i=i+1
				media=media+ (  CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value))
				ORsLecturas.MoveNext
				
				Response.Write "</data>"
				
			Wend
			
			if(i>1) Then
			media = media/(i-1)
			else
			media=1
			End If
 
	
	Response.Write "</series>"
	
	ORs.MoveNext
		  
		 
	Wend
	 
		
	 i=1
	
	
	
	Response.Write "<series>"
	Response.Write "<name>Centro</name>"
	Response.Write "<color>#cccccc</color>"	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
	Response.Write "<data><point>0</point></data>"
 
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>0</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"
	
	Response.Write "<series>"
	Response.Write "<name>Esp. de Seguridad</name>"
	Response.Write "<color>#FF0000</color>"	
	 
	
 
	
	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
	Response.Write "<data><point>" & ESPESOR_SEG & "</point></data>"
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & ESPESOR_SEG & "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"	
	
	Response.Write "<series>"
	Response.Write "<name>Retorno</name>"
	Response.Write "<color>#333333</color>"	
	Response.Write "<type>line</type>"
 
	ORsLecturas.MoveFirst
	Response.Write "<data><point>" & RETORNO & "</point></data>"
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & RETORNO & "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"
	
	

			
	Response.Write "</chart>"
	
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function grProyecciones()

    Dim aMuestreo(200)
	Dim aMuestreoAnt(200)
	
	Dim aProyec
	Dim aRetorno
	Dim aFolios
	Dim nroMuestra
	Dim FECHA_ANT
	
	query = "SET DATEFORMAT DMY SELECT M.FOLIO, M.FECHA "
	query = query & " FROM MEDICIONES AS M "
	query = query & " WHERE M.FOLIO IN (" & FOLIOS & ")"
	'query = query & " ORDER BY M.FECHA DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	FLAT=0
	TIPO="CAR"
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='utf-8'?>"
	Response.Write "<chart>"
	i=1
	Response.Write "<categories>" '*********** CATEGORIAS ****************
	Response.Write "<item>0</item>"
	While Not ORs.Eof
		
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value
		Response.Write "<item>" & i & "</item>"
		ORs.MoveNext
		 i=i+1
	Wend
	Response.Write "</categories>"
	
	query = "SELECT MV.ID+1, convert(float,isnull(MV.VALOR,0)) "
	query = query & " FROM MEDICIONES_VALOR AS MV "
	query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
	query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
	query = query & " ORDER BY MV.ID "
	 	
	Set ORsLecturas =oDB.EjecutaSql(query)
		
 	Response.Write "<series>"
	Response.Write "<name>Cubierta Original</name>"
	Response.Write "<color>#333333</color>"	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
 
		Response.Write "<data>"
			Response.Write "<point>" & CUBIERTA &  "</point>"
		Response.Write "</data>"
		
	While Not ORsLecturas.Eof	
	
		Response.Write "<data>"
			Response.Write "<point>" & CUBIERTA &  "</point>"
		Response.Write "</data>"
	
		ORsLecturas.MoveNext				
	Wend
	
	Response.Write "</series>"	
	
	
	
	ORs.MoveFirst
	nroMuestra = 0
	
	While Not ORs.Eof
	
		FOLIO = ORs.Fields.Item(0).Value
		FECHA = ORs.Fields.Item(1).Value
	
		query = "SELECT MV.ID+1, convert(float,isnull(MV.VALOR,0)) "
		query = query & " FROM MEDICIONES_VALOR AS MV "
		query = query & " WHERE MV.FOLIO=" & strNvl(FOLIO)
		query = query & " AND MV.TIPO='CAR'" '& strNvl(TIPO)
		query = query & " ORDER BY MV.ID "
		 	
		Set ORsLecturas =oDB.EjecutaSql(query)
		
				 
		i=1
		desgMax =0
		min=100
	
		If CHK_MAX="TRUE" THEN
	
			 
				ORsLecturas.MoveFirst
				While Not ORsLecturas.Eof
					aMuestreo(i) = ORsLecturas.Fields.Item(1).Value
		
					if nroMuestra > 0 Then
					' RESPONSE.WRITE "AQUI"
						If desgMax <  aMuestreoAnt(i)- cdbl(ORsLecturas.Fields.Item(1).Value) Then
							desgMax =  aMuestreoAnt(i) - cdbl(ORsLecturas.Fields.Item(1).Value)
						End If	
					Else
					 	If desgMax < CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value) Then
							desgMax = CUBIERTA - cdbl(ORsLecturas.Fields.Item(1).Value)
						End If
						
						If min>ORsLecturas.Fields.Item(1).Value Then
							min = ORsLecturas.Fields.Item(1).Value
						End IF
				
					End If
					
				
					i=i+1
					ORsLecturas.movenext
				
				Wend

				i=1
				
				If nroMuestra > 0 Then
			
						diasOP = ROUND(DATEDIFF("d", FECHA_ANT, FECHA),0)			
						
						tasaD   = desgMax / diasOP 
						tasa = (diasOP/desgMax)
						
						diasP  = (aMuestreoAnt(i)-ESPESOR_SEG) * tasa
    					fechaT1 = dateAdd("d", diasP, FECHA)
						
						valor = aMuestreo(i)
						desgaste = aMuestreoAnt(i) - valor
						desgastePr = aMuestreoAnt(i) - (desgaste / diasOP) * diasP  
				Else
				
					diasOP = ROUND(DATEDIFF("d", FECHA_INST, FECHA),0)	
					
					if diasOP<1 Then
							diasOP=1
					End If  
								
					tasa   = desgMax / diasOP
					tasaD   = desgMax / diasOP 
					 
					diasP  = (CUBIERTA-ESPESOR_SEG) / tasa
    				fechaT1 = dateAdd("d",diasP,FECHA_INST)
					valor = aMuestreo(i)
					desgaste = CUBIERTA - valor
					desgastePr = CUBIERTA - (desgaste / diasOP) * diasP  
			
				End If
				
				 
				arrdet = split(fechaT1, "/")
				yex = arrdet(2)
				mex = arrdet(1)
				dex = arrdet(0) 
				
		
		 
		query ="SET DATEFORMAT DMY UPDATE MEDICIONES SET TASA=" & round(tasaD,3) & " ,"  
		query = query & " MEDIA= " & round(min,3) & " ," 
		query = query & " FECHA_CAMBIO = '" & dex & "/" & mex & "/" & yex & "', "
		query = query & " FECHA_ULTM_MANTENCION =ISNULL('" & FECHA_INST & "',FECHA_ULTM_MANTENCION) "  
		query = query & " WHERE FOLIO=" & FOLIO
	
		'response.Write(query)	
		Set ORsX =oDB.EjecutaSql(query)
	
		
		Response.Write "<series>"
		Response.Write "<name>Proyección "  & fechaT1    _
				 						& " Días de OP. " & round(diasOP,0) & " Desgaste " & desgMax & "</name>"
										
		'Response.Write "<color>#E8C60D</color>"	
		Response.Write "<type>spline</type>"
	 			
		Response.Write "<data><point>" & round(desgastePr,2) & "</point></data>"

		
		ORsLecturas.MoveFirst	
		While Not ORsLecturas.Eof
			
			Response.Write "<data>" 
			
			If nroMuestra > 0 Then
				valor = aMuestreo(i)
				desgaste = aMuestreoAnt(i) - valor
				desgastePr = aMuestreoAnt(i) - (desgaste / diasOP) * diasP  
			
			Else
				valor = aMuestreo(i)
				desgaste = CUBIERTA - valor
				desgastePr = CUBIERTA - (desgaste / diasOP) * diasP  
			End If
			
		 	Response.Write "<point>" & round(desgastePr,2) & "</point>"
			i=i+1
			ORsLecturas.movenext
			Response.Write "</data>"
		Wend
					
		Response.Write "</series>"

		i=1
		ORsLecturas.MoveFirst	
		While Not ORsLecturas.Eof
			aMuestreoAnt(i) = ORsLecturas.Fields.Item(1).Value
			i=i+1
			ORsLecturas.movenext
		wend
		
		FECHA_ANT = FECHA
		
	END IF ' CHK_MAX
		 
	 nroMuestra =  nroMuestra  +1
	ORs.MoveNext

	Wend ' ****** FIN DE TODAS LAS MUESTRAS
		
	Response.Write "<series>"
	Response.Write "<name>Centro</name>"
	Response.Write "<color>#cccccc</color>"	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
	Response.Write "<data><point>0</point></data>"
 
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>0</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"
	
	Response.Write "<series>"
	Response.Write "<name>Esp. de Seguridad</name>"
	Response.Write "<color>#FF0000</color>"	
	 
	
	If CHK_MAX="TRUE" Then
		Response.Write "<dMax>" & round(desgMax, 3)  & "</dMax>"	 'round(desgMax,3) 
		Response.Write "<tasa>" & round(tasa, 3) & "</tasa>"	 'round(tasa*30 ,3)
		Response.Write "<fechaP>" & fechaT1 & "</fechaP>"	
	Else
		Response.Write "<dMax>" & round(media, 3)  & "</dMax>"	 'round(desgMax,3) 
		Response.Write "<tasa>" & round(tasaM, 3) & "</tasa>"	 'round(tasa*30 ,3)
		Response.Write "<fechaP>" & fechaT & "</fechaP>"	
	End If
	
	
	Response.Write "<type>line</type>"
	ORsLecturas.MoveFirst
	Response.Write "<data><point>" & ESPESOR_SEG & "</point></data>"
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & ESPESOR_SEG & "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"	
	
	Response.Write "<series>"
	Response.Write "<name>Retorno</name>"
	Response.Write "<color>#333333</color>"	
	Response.Write "<type>line</type>"
 
	ORsLecturas.MoveFirst
	Response.Write "<data><point>" & RETORNO & "</point></data>"
	While Not ORsLecturas.Eof	
		Response.Write "<data>"
			Response.Write "<point>" & RETORNO & "</point>"
			ORsLecturas.MoveNext
		Response.Write "</data>"
	Wend
	Response.Write "</series>"
	
	

			
	Response.Write "</chart>"
	
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


Function numNvl(Valor)
	if Len(Valor) <1 then
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

Function toExcel()
Set oExcel = Server.CreateObject("Excel.Application")
oExcel.Workbooks.Open "C:\1.xls"
oExcel.CELLS(1, 1)="25772"


End Function

%>

