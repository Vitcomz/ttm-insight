<!--#include file="DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ALARMA=UCASE(REQUEST("ALARMA"))
ACTIVIDAD=UCASE(REQUEST("ACTIVIDAD"))
ESCALA_ALARMA=UCASE(REQUEST("ESCALA_ALARMA"))

CANTIDAD=UCASE(REQUEST("CANTIDAD"))
CANTIDAD_H=UCASE(REQUEST("CANTIDAD_H"))
   
CODIGO=UCASE(REQUEST("CODIGO"))
COD_ACTIVIDAD=UCASE(REQUEST("COD_ACTIVIDAD"))
COD_SUB_ACTIVIDAD=UCASE(REQUEST("COD_SUB_ACTIVIDAD"))
COD_ARTICULO=UCASE(REQUEST("COD_ARTICULO"))
COD_EQUIPO=UCASE(REQUEST("COD_EQUIPO"))
COD_SUB=UCASE(REQUEST("COD_SUB"))

COMPETENCIA=UCASE(REQUEST("COMPETENCIA"))
TIPO=UCASE(REQUEST("TIPO"))
   TOTAL_HH=UCASE(REQUEST("TOTAL_HH"))
TIPO_CONTROL=UCASE(REQUEST("TIPO_CONTROL"))
TIPO_HOROMETRO=UCASE(REQUEST("TIPO_HOROMETRO"))
TIEMPO_EJECUCION=UCASE(REQUEST("TIEMPO_EJECUCION"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
ESTADO_EQUIPO=UCASE(REQUEST("ESTADO_EQUIPO"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
EMPRESA=UCASE(REQUEST("EMPRESA"))
ESCALA=UCASE(REQUEST("ESCALA"))
ID=UCASE(REQUEST("ID"))
UNIDAD=UCASE(REQUEST("UNIDAD"))
UBICACION=UCASE(REQUEST("UBICACION"))
FOLIO=UCASE(REQUEST("FOLIO"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FAMILIA=UCASE(REQUEST("FAMILIA"))
FECHA=UCASE(REQUEST("FECHA"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
OPORTU=REQUEST("OPORTU")
HOROMETRO=UCASE(REQUEST("HOROMETRO"))
HOROMETRO_ASG=UCASE(REQUEST("HOROMETRO_ASG"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
PERIODO=UCASE(REQUEST("PERIODO"))
SECTOR=UCASE(REQUEST("SECTOR"))
USERNAME=UCASE(REQUEST("USERNAME"))
SUB_CODIGO=UCASE(REQUEST("SUB_CODIGO"))
VENCIMIENTO=UCASE(REQUEST("VENCIMIENTO"))

RECURSO=REQUEST("RECURSO")

select case RECURSO


	case "getActividad"
	  	  getActividad()
		  
	case "getUsrActividad"
	  	  getUsrActividad()
		
	case "newActividad"
		  newActividad()
   
	case "newSubActividad"
   		  newSubActividad()
   
   case "setSubAct"
   		 setSubAct()
   
	case "mantencion"
		  mantencion()	
		
	case "asignaOT"
		  asignaOT()
		  
	case "newActividadCor"
		  newActividadCor()
   
	case "newUsrActividad"
		  newUsrActividad()
	
   case "setUsrActividad"
		  setUsrActividad()
   
	case "updateActividadCor"
		  updateActividadCor()
	
	case "newActOT"
		  newActOT()
		  
	case "newArticulosAct" 
		  newArticulosAct()
		  	
	case "delActividad"
		  delActividad()
		
	case "delSubActividad"
		  delSubActividad()
	
	case "delActividadUsr"
		  delActividadesUsr()
		  
	case "delArticulosAct"
		  delArticulosAct()
	
	case "delActividadesOT"
		  delActividadesOT()  
		  	
	case "updateActividad"
		  updateActividad()
		
	case "listActividades"
		  listActividades()

	case "listArticulosOT"
		  listArticulosOT()
		  	
	case "listArticulosAct"
		  listArticulosAct()
		  		
	case "listEquiposMan"
		  listEquiposMan()
	
	case "listEquiposManVen"
		  listEquiposManVen()
		  
	case "listOTEquipos"
		  listOTEquipos()
		  	  	
	case "listActividadesEquipo"
		  listActividadesEquipo()
	
	case "listUsrActividad"
		  listUsrActividad()
		  	
	case "listSubActividadesEquipo"
		  listSubActividadesEquipo()
						
	case "listSubActividades"
		  listSubActividades()
	
	case "listSubActividadesOT"
		  listSubActividadesOT()
				
	case "ListActividadEquipo"
		  ListActividadEquipo()
		  
end select

function newActividad()

	query = "SELECT MAX(CODIGO) AS NUM FROM ACTIVIDADES"
	query = query & " WHERE COD_EQUIPO =" & strNvl(COD_EQUIPO) 
	
	Set ORs =oDB.EjecutaSql(query)

	If Len(oRS("NUM"))>0 Then
		CODIGO = oRS("NUM") + 1
	Else
		CODIGO = 1
	End If
	
	
	query = "INSERT INTO ACTIVIDADES (CODIGO, COD_EQUIPO, NOMBRE, "
	query = query & " DESCRIPCION, TIPO_HOROMETRO, TIPO, EJECUCION, PERIODO, ALARMA, "
	query = query & " ESCALA, ESCALA_ALARMA, SECTOR, COMPETENCIA, ESTADO_EQUIPO, "
	query = query & " HOROMETRO, HOROMETRO_ASG, VENCIMIENTO, PEDIDO, UBICACION)"
	query = query & " VALUES ("
	query = query & CODIGO & ", " 
	query = query & strNvl(COD_EQUIPO) & "," 
	query = query & strNvl(NOMBRE) & "," 
	query = query & strNvl(DESCRIPCION) & "," 
	query = query & strNvl(TIPO_HOROMETRO) & ", " 
	query = query & strNvl(TIPO_CONTROL) & ", "
	query = query & strNvl(TIEMPO_EJECUCION) & ", "
	query = query & strNvl(PERIODO) & ", "
	query = query & strNvl(ALARMA) & ", "
	query = query & strNvl(ESCALA) & ", "
	query = query & strNvl(ESCALA_ALARMA) & ", "
	query = query & strNvl(SECTOR) & ", "
	query = query & strNvl(COMPETENCIA) & ", "
	query = query & strNvl(ESTADO_EQUIPO) & ", "
	query = query & strNvl(HOROMETRO) & ", "
	query = query & strNvl(HOROMETRO_ASG) & ", "
	query = query & strNvl(VENCIMIENTO) & ", "
	query = query & strNvl(PEDIDO) & ", "
	query = query & strNvl(UBICACION) & " "
	query = query & ");" 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function newUsrActividad()

	 
	query = "INSERT INTO USR_ACTIVIDAD (FOLIO_OT, COD_ACTIVIDAD, USUARIO, "
	query = query & " FECHA_INI,  FECHA_FIN,  USERNAME, USERDATE, EMPRESA )"
	query = query & " VALUES ("
	query = query & strNvl(FOLIO_OT) & ","
	query = query & strNvl(COD_ACTIVIDAD) & ", "
	query = query & strNvl(ID) & ", " 
	query = query & strNvl(FECHA_INI) & "," 
	query = query & strNvl(FECHA_FIN) & ","
	query = query & strNvl(USERNAME) & ", GETDATE(), " 
	query = query & strNvl(EMPRESA) & ")"  
	
		
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><CODE>" & strNvl(COD_ACTIVIDAD) & "</CODE></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
	
end function

	
function newActividadCor()

	query = "SELECT MAX(CODIGO) AS NUM FROM ACTIVIDADES_USUARIO"
	
	Set ORs =oDB.EjecutaSql(query)

	If Len(oRS("NUM"))>0 Then
		CODIGO = oRS("NUM") + 1
	Else
		CODIGO = 1
	End If
	
	
	query = "INSERT INTO ACTIVIDADES_USUARIO (CODIGO, FOLIO_OT, DESCRIPCION, EMPRESA, FECHA )"
	query = query & " VALUES ("
	query = query & CODIGO & ", " 
	query = query & strNvl(FOLIO_OT) & "," 
	query = query & strNvl(DESCRIPCION) & "," 
	query = query & strNvl(EMPRESA) & "," 
	query = query & "GETDATE());" 
	
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><CODE>" & CODIGO & "</CODE></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function setUsrActividad()
	 
	query = "set dateformat dmy UPDATE USR_ACTIVIDAD SET "
	query = query & "  FECHA_INI= " & strNvl(FECHA_INI)
	query = query & " ,FECHA_FIN= " & strNvl(FECHA_FIN)
	query = query & " ,USERNAME = " & strNvl(USERNAME) 
	query = query & " ,USERDATE = GETDATE() " 
 
	query = query & " WHERE 1=1 "
	query = query & " AND FOLIO_OT = " & strNvl(FOLIO_OT) 
	query = query & " AND COD_ACTIVIDAD = " & strNvl(COD_ACTIVIDAD)  
	query = query & " AND USUARIO = " & strNvl(ID) 
	query = query & " AND EMPRESA = " & strNvl(EMPRESA) 
 
	 Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><CODE>" & query & "</CODE></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
	
end function
	
function updateActividadCor()

	query = "SELECT MAX(CODIGO) AS NUM FROM ACTIVIDADES_USUARIO"
	
	Set ORs =oDB.EjecutaSql(query)

	If Len(oRS("NUM"))>0 Then
		CODIGO = oRS("NUM") + 1
	Else
		CODIGO = 1
	End If
	
	
	query = "UPDATE ACTIVIDADES_USUARIO SET  DESCRIPCION=" & strNvl(DESCRIPCION)
	query = query & ", FECHA=getDate()"
	query = query & " WHERE FOLIO_OT=" & strNvl(FOLIO_OT)
	query = query & " AND CODIGO = " & strNvl(COD_ACTIVIDAD)
	query = query & " AND EMPRESA = " & strNvl(EMPRESA)
		
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><CODE>" & CODIGO & "</CODE></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function newSubActividad()

	query = "SELECT MAX(CODIGO) AS NUM FROM SUB_ACTIVIDADES"
	query = query & " WHERE COD_ACTIVIDAD=" & CODIGO
	query = query & " AND  COD_EQUIPO='" & COD_EQUIPO & "'"

	Set ORs =oDB.EjecutaSql(query)
	
	'Response.Write("Largo=" & Len(oRS("NUM")))
	
	If Len(oRS("NUM"))>0 Then
		SUB_CODIGO = oRS("NUM") + 1
	Else
		SUB_CODIGO = 1
	End If
	
	query = "INSERT INTO SUB_ACTIVIDADES (COD_ACTIVIDAD, COD_EQUIPO, CODIGO, NOMBRE )"
	query = query & " VALUES ("
	query = query & CODIGO & ", " 
	query = query & strNvl(COD_EQUIPO) & ", " 
	query = query & SUB_CODIGO & ", " 
	query = query & strNvl(NOMBRE) 
	query = query & ");" 
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

	
function setSubAct()
	 
	query = "UPDATE ACTIVIDADES_OT set IND_EJECUTADO = 'TRUE' "
 
	query = query & " WHERE 1=1 "
	query = query & " AND FOLIO_OT = " & strNvl(FOLIO_OT) 
	query = query & " AND CODIGO_ACTIVIDAD = " & strNvl(COD_ACTIVIDAD)  
	query = query & " AND COD_SUB_ACTIVIDAD = " & strNvl(COD_SUB_ACTIVIDAD) 
	query = query & " AND EMPRESA = " & strNvl(EMPRESA) 
 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW><CODE>" & strNvl(query) & "</CODE></ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
	
end function
	
function delActividadesUsr()

	query = "DELETE FROM USR_ACTIVIDAD WHERE FOLIO_OT = " & FOLIO_OT
	query = query & " AND COD_ACTIVIDAD=" & COD_ACTIVIDAD
	
	Set ORs =oDB.EjecutaSql(query)
		
	query = "DELETE FROM ACTIVIDADES_USUARIO WHERE FOLIO_OT = " & FOLIO_OT
	query = query & " AND CODIGO=" & COD_ACTIVIDAD
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & FOLIO_OT  & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function delActividadesOT()

	query = "DELETE FROM ACTIVIDADES_OT WHERE FOLIO_OT = " & FOLIO_OT
	query = query & " AND CODIGO_ACTIVIDAD=" & COD_ACTIVIDAD
	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & FOLIO_OT  & "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


function newActOT()

	
	
	query = "INSERT INTO ACTIVIDADES_OT (FOLIO_OT, CODIGO_ACTIVIDAD, COD_SUB_ACTIVIDAD, "
	query = query & " FECHA, EMPRESA, UBICACION,  USERDATE, USERNAME)"
	
	query = query & "SELECT " & strNvl(FOLIO_OT) & ", SA.COD_ACTIVIDAD,  SA.CODIGO, " & strNvl(FECHA) & ", "
	query = query & strNvl(EMPRESA) & "," & strNvl(EMPRESA)  & ", GETDATE()," & strNvl(USERNAME) 
	query = query & " FROM ACTIVIDADES AS A " 
	query = query & " INNER JOIN SUB_ACTIVIDADES AS SA ON A.CODIGO = SA.COD_ACTIVIDAD "
	query = query & " AND A.COD_EQUIPO = SA.COD_EQUIPO "
	query = query & " AND SA.COD_ACTIVIDAD = A.CODIGO " 
	
	query = query & " WHERE A.CODIGO = " & strNvl(COD_ACTIVIDAD)
	query = query & " AND A.COD_EQUIPO = " & strNvl(EQUIPO)
	query = query & " AND A.UBICACION = " & strNvl(EMPRESA)


	
	 Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function newArticulosAct()

	query = "INSERT INTO ARTICULOS_ACT (COD_ACTIVIDAD, EQUIPO, COD_ARTICULO, FAMILIA,"
	query = query & " UNIDAD, CANTIDAD, USERNAME, USERDATE ) VALUES ("
	query = query & COD_ACTIVIDAD & ","
	query = query & strNvl(EQUIPO) & ","
	query = query & COD_ARTICULO & ","
	query = query & strNvl(FAMILIA) & ","
	query = query & strNvl(UNIDAD) & ","
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(USER) & ","
	query = query & " GETDATE())"

	Set ORs =oDB.EjecutaSql(query)
	
	query = " UPDATE EXISTENCIAS.DBO.ARTICULOS SET UNIDAD_MEDIDA=" & strNvl(UNIDAD)
	query = query & "WHERE ID=" & strNvl(COD_ARTICULO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listArticulosOT()

	 query = "SELECT A.ID, A.DESCRIPCION, A.VALOR, AO.CANTIDAD, A.VALOR*AO.CANTIDAD, "
	 query = query & " AO.ORIGEN, A.UNIDAD_MEDIDA, A.FAMILIA "
	 query = query & "FROM EXISTENCIAS.DBO.ARTICULOS AS A, ARTICULOS_OT AS AO "
	 query = query & "WHERE A.ID = AO.COD_ARTICULO "
 	 query = query & " AND AO.FOLIO_OT= " & FOLIO
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
		  Response.Write "<TOTAL>" & ORs.Fields.Item(4).Value & "</TOTAL>"
		  Response.Write "<ORIGEN>" & ORs.Fields.Item(5).Value & "</ORIGEN>"
		  Response.Write "<UNIDAD>" & ORs.Fields.Item(6).Value & "</UNIDAD>"
		  Response.Write "<FAMILIA>" & ORs.Fields.Item(7).Value & "</FAMILIA>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listActividades_elim()

	query = "SELECT CODIGO, NOMBRE, DESCRIPCION"
	query = query & " FROM ACTIVIDADES"
	
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"	
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listActividadesEquipo()

	Set Cn =  oDB.Conexion
	Dim ORs
	

	Dim str 
	
	IF Len(COD_EQUIPO)>0 THEN
	
	str = "SP_ACT_MANTENCION "  & strNvl(COD_EQUIPO) & ", " & strNvl(UBICACION)
	
    Set ORs = Cn.Execute (str)
	ELSE
		EXIT FUNCTION
	
	END IF
	
	'response.Write(str)
	
	Set ORs = Server.CreateObject("ADODB.Recordset")
   	ORs.CursorLocation = 3 
	ORs.Open STR, Cn, 1,1
	
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & str
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(3).Value & "</DESCRIPCION>"
		  Response.Write "<TIPO_HOROMETRO>" & ORs.Fields.Item(6).Value & "</TIPO_HOROMETRO>"
		  Response.Write "<EJECUCION>" & ORs.Fields.Item(11).Value & "</EJECUCION>"
		  Response.Write "<PERIODO>" & ORs.Fields.Item(9).Value & " " & ORs.Fields.Item(16).Value & "</PERIODO>"
		  Response.Write "<ALARMA>" & ORs.Fields.Item(17).Value  & "</ALARMA>"
		
				  	  
		  VEN = 0	
		  d = DateSerial(1970,1,1)
		   	  
		  If ORs.Fields.Item(6).Value = "CRO" THEN
			If Not isNull(ORs.Fields.Item(4).Value) Then
				VEN = mid(dateadd("s", ORs.Fields.Item(4).Value/1000, d),1,10)
				DIF = Round(ORs.Fields.Item(5).Value/(1000*60*60*24),0) & " Días."
			 
		  	End If
			HOR= MID(NOW(),1,10)
		  Else
		  	HOR = ORs.Fields.Item(3).Value
			VEN = ORs.Fields.Item(4).Value
			DIF = ORs.Fields.Item(5).Value
		  End If
		  
		  IF ORs.Fields.Item(5).Value>0 THEN
		  		VENCIDO=1
		  ELSE
		  		VENCIDO=0
		  END IF
		  
		  Response.Write "<HOROMETRO>" & HOR & "</HOROMETRO>"
		  Response.Write "<VENCIMIENTO>" & VEN & "</VENCIMIENTO>"
	 	  Response.Write "<DIF>" & DIF & "</DIF>"
		  Response.Write "<VENCIDO>" & VENCIDO & "</VENCIDO>"
	 
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listArticulosAct()

	 query = "SELECT A.ID, A.DESCRIPCION, A.VALOR, AA.CANTIDAD, AA.FAMILIA, AA.UNIDAD, EXISTENCIAS.DBO.GetSaldo(A.ID) "
	 query = query & " FROM EXISTENCIAS.DBO.ARTICULOS AS A, ARTICULOS_ACT AS AA "
	 query = query & " WHERE A.ID = AA.COD_ARTICULO "
 	 query = query & " AND AA.COD_ACTIVIDAD= " & COD_ACTIVIDAD
	 query = query & " AND AA.EQUIPO= " & strNvl(EQUIPO)
		 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
		  Response.Write "<FAMILIA>" & ORs.Fields.Item(4).Value & "</FAMILIA>"
		  Response.Write "<UNIDAD>" & ORs.Fields.Item(5).Value & "</UNIDAD>"
		  Response.Write "<SALDO>" & ORs.Fields.Item(6).Value & "</SALDO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listEquiposMan()

		
 	Set Cn = oDB.Conexion
  	Dim Rs
    Set ORs = Cn.Execute ("SP_ACT_MANTENCION "  & strNvl(EQUIPO))
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	'EXIT FUNCTION
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(6).Value & "</TIPO>"
		  Response.Write "<SECTOR>" & ORs.Fields.Item(7).Value & "</SECTOR>"
		  Response.Write "<ESTADO_E>" & ORs.Fields.Item(8).Value & "</ESTADO_E>"
		  
		  If ORs.Fields.Item(13).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  
		   IF ORs.Fields.Item(15).Value="CRO"   THEN
		   	
		    SELECT CASE ORs.Fields.Item(16).Value
				CASE "H" 
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60)
		  		CASE "D" 
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60*24)
				CASE "M"
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60*24*30.41666)
				CASE "A"
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60*24*30.41666*12)
			 END SELECT 
			 
			 Response.Write "<PERIODO>" & ROUND(ORs.Fields.Item(9).Value,1) & " " & ORs.Fields.Item(16).Value & "</PERIODO>"	
			 		  
			 Dim d
			 d = DateSerial(1970,1,1)  
			
			 
			 Response.Write "<HOROMETRO>" & mid(NOW,1,10) & "</HOROMETRO>"	 
		  	 Response.Write "<HOROMETRO_VEN>" & mid(dateadd("s", round(ORs.Fields.Item(4).Value/1000,2), d),1,10) _
			 				& "</HOROMETRO_VEN>"
			
		 	 DIFERENCIA = Round(ORs.Fields.Item(5).Value/(1000*60*60*24),0) & " Días."
			 Response.Write "<DIFERENCIA>" & DIFERENCIA & "</DIFERENCIA>"
		  
		  ELSE ' EQUIPO SECUENCIAL
		   		Response.Write "<PERIODO>" & ROUND(ORs.Fields.Item(9).Value,1) & "</PERIODO>"
				Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
   		 		Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
   		  		Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
		  
		  END IF
		  
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
		  Response.Write "<COD_ACTIVIDAD>" & ORs.Fields.Item(10).Value & "</COD_ACTIVIDAD>"
		  Response.Write "<EJECUCION>" & ORs.Fields.Item(11).Value & "</EJECUCION>"
		  Response.Write "<ESPECIALIDAD>" & ORs.Fields.Item(12).Value & "</ESPECIALIDAD>"
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(13).Value & "</FOLIO_OT>"
		  Response.Write "<REPRO>" & ORs.Fields.Item(14).Value & "</REPRO>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function mantencion()

Session.LCID = 2057
	Set Cn = oDB.Conexion
  	
	Dim ORs
    Set ORs = Cn.Execute ("SP_MANTENCION "  & strNvl(EQUIPO) & "," & strNvl(TIPO) & "," & strNvl(UBICACION))
	
	
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
	'response.Write(ORs.EOF)
	
	Response.Write "<REGISTROS>" & query
	N=0
	While Not ORs.EOF 
		N=N+1
	  Response.Write "<ROW>" 
	  	Response.Write "<N>" & N & "</N>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<EQUIPO>" & ORs.Fields.Item(1).Value & "</EQUIPO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"	  
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
		  
		  Response.Write "<TIPO_MAN>" & ORs.Fields.Item(8).Value & "</TIPO_MAN>"
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(9).Value & "</FOLIO_OT>"
				  
  		  Response.Write "<COMP>" & ORs.Fields.Item(11).Value & "</COMP>"
		  Response.Write "<IND_INCIDENTE>" & ORs.Fields.Item(12).Value & "</IND_INCIDENTE>"
		  Response.Write "<TOTAL_HH>" & ORs.Fields.Item(12).Value & "</TOTAL_HH>"
	
		  IF ORs.Fields.Item(7).Value="CRO"   THEN
		   	
		  '  SELECT CASE ORs.Fields.Item(9).Value ' escala
			'		CASE "H" 
			'			PERIODO = ORs.Fields.Item(10).Value/(1000*60*60)
		 	' 		CASE "D" 
			'			PERIODO = ORs.Fields.Item(10).Value/(1000*60*60*24)
			'		CASE "M"
			'			PERIODO = ORs.Fields.Item(10).Value/(1000*60*60*24*30.41666)
			'		CASE "A"
			'			PERIODO = ORs.Fields.Item(10).Value/(1000*60*60*24*30.41666*12)
		'	 END SELECT 
			 
		 		  
			 Dim d
			 d = DateSerial(1970,1,1)  
			
			 
			 Response.Write "<HOROMETRO>" & mid(NOW,1,10) & "</HOROMETRO>"	 
			 
		  	 Response.Write "<HOROMETRO_VEN>" & mid(dateadd("s", round(ORs.Fields.Item(5).Value/1000,2), d),1,10) _
			 				& "</HOROMETRO_VEN>"
							
			 IF ORs.Fields.Item(8).Value="CORRECTIVA" THEN
				  DIFERENCIA = ORs.Fields.Item(6).Value & " Días."
			 ELSE
			 	 DIFERENCIA = Round(ORs.Fields.Item(6).Value/(1000*60*60*24),0) & " Días."
			 END IF
			 
	
			 Response.Write "<DIFERENCIA>" & DIFERENCIA & "</DIFERENCIA>"
		  
		  ELSE ' EQUIPO SECUENCIAL
		   	'	Response.Write "<PERIODO>" & ROUND(ORs.Fields.Item(9).Value,1) & "</PERIODO>"
				Response.Write "<HOROMETRO>" & ORs.Fields.Item(4).Value & "</HOROMETRO>"
   		 		Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  		Response.Write "<DIFERENCIA>" & ORs.Fields.Item(6).Value & " Horas" & "</DIFERENCIA>"
		  
		  END IF
	  		
		  Response.Write "<IND_DANO>" & ORs.Fields.Item(10).Value & "</IND_DANO>"
		 
		  
		  If ORs.Fields.Item(12).Value ="TRUE" Then
		 	 Response.Write "<TIPO>INCIDENTE</TIPO>"

		  End If
		  
			
		 Set oRsFiles = getFiles(ORs.Fields.Item(0).Value)
		 
		  If Not oRsFiles.EOF Then
				 Response.Write "<FILE>files/pr_" & ORsFiles.Fields.Item(0).Value & "</FILE>"
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

function listEquiposManVen()

		
 	Set Cn = oDB.Conexion
  	Dim Rs
    Set ORs = Cn.Execute ("SP_ACT_MAN_VENCIDAS "  & strNvl(EQUIPO))
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	'EXIT FUNCTION
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(6).Value & "</TIPO>"
		  Response.Write "<SECTOR>" & ORs.Fields.Item(7).Value & "</SECTOR>"
		  Response.Write "<ESTADO_E>" & ORs.Fields.Item(8).Value & "</ESTADO_E>"
		  
		  If ORs.Fields.Item(13).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  
		   IF ORs.Fields.Item(15).Value="CRO"   THEN
		   	
		    SELECT CASE ORs.Fields.Item(16).Value
				CASE "H" 
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60)
		  		CASE "D" 
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60*24)
				CASE "M"
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60*24*30.41666)
				CASE "A"
					PERIODO = ORs.Fields.Item(9).Value/(1000*60*60*24*30.41666*12)
			 END SELECT 
			 
			 Response.Write "<PERIODO>" & ROUND(ORs.Fields.Item(9).Value,1) & " " & ORs.Fields.Item(16).Value & "</PERIODO>"	
			 		  
			 Dim d
			 d = DateSerial(1970,1,1)  
			
			 
			 Response.Write "<HOROMETRO>" & mid(NOW,1,10) & "</HOROMETRO>"	 
		  	 Response.Write "<HOROMETRO_VEN>" & mid(dateadd("s", round(ORs.Fields.Item(4).Value/1000,2), d),1,10) _
			 				& "</HOROMETRO_VEN>"
			
		 	 DIFERENCIA = Round(ORs.Fields.Item(5).Value/(1000*60*60*24),0) & " Días."
			 Response.Write "<DIFERENCIA>" & DIFERENCIA & "</DIFERENCIA>"
		  
		  ELSE ' EQUIPO SECUENCIAL
		   		Response.Write "<PERIODO>" & ROUND(ORs.Fields.Item(9).Value,1) & "</PERIODO>"
				Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
   		 		Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
   		  		Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
		  
		  END IF
		  
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
		  Response.Write "<COD_ACTIVIDAD>" & ORs.Fields.Item(10).Value & "</COD_ACTIVIDAD>"
		  Response.Write "<EJECUCION>" & ORs.Fields.Item(11).Value & "</EJECUCION>"
		  Response.Write "<ESPECIALIDAD>" & ORs.Fields.Item(12).Value & "</ESPECIALIDAD>"
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(13).Value & "</FOLIO_OT>"
		  Response.Write "<REPRO>" & ORs.Fields.Item(14).Value & "</REPRO>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listUsrActividad()

	query = "SELECT U.CODIGO, U.NOMBRE, U.CARGO, COD_ACTIVIDAD, "
	query = query & " CONVERT(VARCHAR, UA.FECHA_INI ,103) + ' ' + substring(convert(VARCHAR,UA.FECHA_INI,108),1,5),"
	query = query & " CONVERT(VARCHAR, UA.FECHA_FIN ,103) + ' ' + substring(convert(VARCHAR,UA.FECHA_FIN,108),1,5),"
	query = query & " DATEDIFF(mi,UA.FECHA_INI,UA.FECHA_FIN) "
	query = query & " FROM USR_ACTIVIDAD AS UA, TRABAJADORES AS U "
	query = query & " WHERE UA.USUARIO = U.CODIGO "
	query = query & " 	AND UA.FOLIO_OT = " & FOLIO_OT
	
	IF LEN(COD_ACTIVIDAD)>0 THEN
			query = query & " 	AND UA.COD_ACTIVIDAD = " & strNvl(COD_ACTIVIDAD)
	END IF
	
	query = query & " ORDER BY U.NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  	Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  	Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
			SELECT CASE ORs.Fields.Item(2).Value
				CASE "ELE"
					ESPECIAL = "(ELECTRICO)"
				CASE "MEC"
					ESPECIAL = "(MECANICO)"
				CASE "TOD"
					ESPECIAL = "(TODOS)"
				CASE null
					ESPECIAL = "  "
				CASE "INS"
					ESPECIAL = "(INSTRUMENTAL)"
	  		END SELECT

			Response.Write "<ESPECIALIDAD>" & ESPECIAL & "</ESPECIALIDAD>"
			Response.Write "<COD_ACTIVIDAD>" & ORs.Fields.Item(3).Value & "</COD_ACTIVIDAD>"
			Response.Write "<FECHA_INI>" & ORs.Fields.Item(4).Value & "</FECHA_INI>"
			Response.Write "<FECHA_FIN>" & ORs.Fields.Item(5).Value & "</FECHA_FIN>"
			Response.Write "<MIN>" & ORs.Fields.Item(6).Value & " Min.</MIN>"
			Response.Write "</ROW>"
		 ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function
	
	
function listSubActividades()
	
		query = "SELECT CODIGO, NOMBRE"
		query = query & " FROM SUB_ACTIVIDADES"
		query = query & " WHERE COD_ACTIVIDAD = " & CODIGO
		query = query & " AND COD_EQUIPO='" & COD_EQUIPO & "'" 
		
		Set ORs =oDB.EjecutaSql(query)
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		While Not ORs.EOF 
		  Response.Write "<ROW>" 
			  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
			  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "</ROW>"
		  ORs.MoveNext
		Wend
		Response.Write "</REGISTROS>"
		Set ORs = Nothing
		Set ODB = Nothing
	end function
	
function listSubActividadesEquipo()
	
		query = "SELECT A.NOMBRE AS ACTIVIDAD, SA.CODIGO, SA.NOMBRE"
		query = query & " FROM SUB_ACTIVIDADES AS SA, ACTIVIDADES AS A"
		query = query & " WHERE SA.COD_ACTIVIDAD = A.CODIGO"
		query = query & " AND A.COD_EQUIPO = SA.COD_EQUIPO "
		query = query & " AND SA.COD_EQUIPO=" & strNvl(EQUIPO)  
		query = query & " AND SA.COD_ACTIVIDAD=" & strNvl(CODIGO)
		query = query & " ORDER BY A.NOMBRE, SA.CODIGO"
		
		Set ORs =oDB.EjecutaSql(query)
		Response.ContentType = "text/xml"
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		While Not ORs.EOF 
		  Response.Write "<ROW>" 
			  Response.Write "<ACTIVIDAD>" & ORs.Fields.Item(0).Value & "</ACTIVIDAD>"
			  Response.Write "<SUB_CODIGO>" & ORs.Fields.Item(1).Value & "</SUB_CODIGO>"
			  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listSubActividadesOT()

	query = "SELECT A_OT.CODIGO_ACTIVIDAD, A.NOMBRE, A_OT.COD_SUB_ACTIVIDAD, SA.NOMBRE, "
	query = query & "  OT.EQUIPO, A_OT.IND_EJECUTADO, A_OT.FECHA, A.DESCRIPCION, A.EJECUCION, A.COMPETENCIA "
	query = query & "  FROM ACTIVIDADES_OT AS A_OT"
	query = query & "  INNER JOIN OT ON OT.FOLIO_OT = A_OT.FOLIO_OT"
	query = query & "  INNER JOIN ACTIVIDADES AS A ON A_OT.CODIGO_ACTIVIDAD = A.CODIGO AND A.COD_EQUIPO = OT.EQUIPO"
	query = query & "  LEFT OUTER JOIN SUB_ACTIVIDADES AS SA ON SA.COD_ACTIVIDAD = A_OT.CODIGO_ACTIVIDAD "
	query = query & "  		AND SA.COD_EQUIPO = OT.EQUIPO AND A_OT.COD_SUB_ACTIVIDAD = SA.CODIGO "
	query = query & "  WHERE A_OT.FOLIO_OT=" & strNvl(FOLIO_OT)
	query = query & "   AND A_OT.EMPRESA=" & strNvl(EMPRESA) & ""
	
	
	
	IF LEN(COD_ACTIVIDAD)>0 THEN
			query = query & "  AND A_OT.CODIGO_ACTIVIDAD=" & strNvl(COD_ACTIVIDAD)
	END IF

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
   		  Response.Write "<COD_ACTIVIDAD>" & ORs.Fields.Item(0).Value & "</COD_ACTIVIDAD>"
		  Response.Write "<ACTIVIDAD>" & ORs.Fields.Item(1).Value & "</ACTIVIDAD>"
  		  Response.Write "<COD_SUB_ACTIVIDAD>" & ORs.Fields.Item(2).Value & "</COD_SUB_ACTIVIDAD>"
  		  Response.Write "<NOMBRE>" & ORs.Fields.Item(3).Value & "</NOMBRE>"
   		  Response.Write "<EQUIPO>" & ORs.Fields.Item(4).Value & "</EQUIPO>"
		  Response.Write "<IND>" & ORs.Fields.Item(5).Value & "</IND>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(6).Value & "</FECHA>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(7).Value & "</DESCRIPCION>"
		  Response.Write "<EJECUCION>" & ORs.Fields.Item(8).Value & "</EJECUCION>"
	  Response.Write "<COMPETENCIA>" & ORs.Fields.Item(9).Value & "</COMPETENCIA>"
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
	query = query & " AND A.FAMILIA='AVISOS' "
	
	Set getFiles =oDB.EjecutaSql(query)

End Function

function asignaOT()

	query = "INSERT INTO ACTIVIDADES_OT (FOLIO_OT, CODIGO_ACTIVIDAD, COD_SUB_ACTIVIDAD) "
	query = query & " SELECT " & FOLIO_OT & ", COD_ACTIVIDAD, CODIGO FROM SUB_ACTIVIDADES "
	query = query & " WHERE COD_ACTIVIDAD =" & strNvl(COD_ACTIVIDAD) 
	query = query & "  AND COD_EQUIPO =" & strNvl(EQUIPO)
	
		Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
   		  Response.Write "<COD_ACTIVIDAD>OK</COD_ACTIVIDAD>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function listOTEquipos()

	query = "SELECT DISTINCT OT.FOLIO_OT, OT.FECHA_PROGRAMADA, A.NOMBRE, "
	query = query & "  OT.EQUIPO, A_OT.IND_EJECUTADO, A_OT.FECHA, A.DESCRIPCION "
	query = query & "  FROM ACTIVIDADES_OT AS A_OT"
	query = query & "  INNER JOIN OT ON OT.FOLIO_OT = A_OT.FOLIO_OT"
	query = query & "  INNER JOIN ACTIVIDADES AS A ON A_OT.CODIGO_ACTIVIDAD = A.CODIGO AND A.COD_EQUIPO = OT.EQUIPO"
	query = query & "  WHERE OT.EQUIPO=" & strNvl(EQUIPO)
	query = query & "   AND OT.ESTADO IN ('PRO','PEN')"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" ' & query
   		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function getActividad()

	 Dim d
	 d = DateSerial(1970,1,1)  
	
  
	 	 
	query = "SELECT A.CODIGO, A.NOMBRE, A.DESCRIPCION, A.TIPO_HOROMETRO, A.TIPO, A.EJECUCION, "
	query = query & " A.PERIODO, A.ALARMA, A.ESCALA, A.ESCALA_ALARMA, A.SECTOR, A.COMPETENCIA, "
	query = query & " A.ESTADO_EQUIPO , A.HOROMETRO, A.HOROMETRO_ASG, A.VENCIMIENTO, "
	query = query & " CAST(DATEDIFF(s,CAST('1970-01-01T00:00:00.000' AS datetime), GETDATE()) AS FLOAT)*1000 - A.VENCIMIENTO,"
	query = query & " A_OT.FOLIO_OT, A.CANTIDAD_H, A.TOTAL_HH "
	query = query & " FROM ACTIVIDADES AS A"
	query = query & " LEFT OUTER JOIN "
	query = query & "    (SELECT A.FOLIO_OT, A.CODIGO_ACTIVIDAD, OT.EQUIPO FROM ACTIVIDADES_OT AS A, OT "
	query = query & "   WHERE A.FOLIO_OT=OT.FOLIO_OT "
	query = query & " 		AND OT.ESTADO IN ('GEN','PEN') AND OT.TIPO='PRE'  ) AS A_OT  "
	query = query & " ON A_OT.CODIGO_ACTIVIDAD = A.CODIGO AND A_OT.EQUIPO = A.COD_EQUIPO "
	query = query & " WHERE A.CODIGO=" & CODIGO 
	query = query & " AND A.COD_EQUIPO=" & strNvl(COD_EQUIPO)

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<TIPO_HOROMETRO>" & ORs.Fields.Item(3).Value & "</TIPO_HOROMETRO>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(4).Value & "</TIPO>"
		  Response.Write "<EJECUCION>" & ORs.Fields.Item(5).Value & "</EJECUCION>"
		  Response.Write "<PERIODO>" & ORs.Fields.Item(6).Value & "</PERIODO>"
		  Response.Write "<ALARMA>" & ORs.Fields.Item(7).Value & "</ALARMA>"
		  Response.Write "<ESCALA>" & ORs.Fields.Item(8).Value & "</ESCALA>"
		  Response.Write "<ESCALA_ALARMA>" & ORs.Fields.Item(9).Value & "</ESCALA_ALARMA>"
		  Response.Write "<SECTOR>" & ORs.Fields.Item(10).Value & "</SECTOR>"
		  Response.Write "<COMPETENCIA>" & ORs.Fields.Item(11).Value & "</COMPETENCIA>"
		  Response.Write "<ESTADO_EQUIPO>" & ORs.Fields.Item(12).Value & "</ESTADO_EQUIPO>"
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(17).Value & "</FOLIO_OT>"
			Response.Write "<CANTIDAD_H>" & ORs.Fields.Item(18).Value & "</CANTIDAD_H>"
			Response.Write "<TOTAL_HH>" & ORs.Fields.Item(19).Value & "</TOTAL_HH>"
		  
		  If ORs.Fields.Item(3).Value = "CRO" THEN
		  	HOR= MID(NOW(),1,10)
			Response.Write "<VENCIMIENTO>" & _
						 mid(dateadd("s", round(ORs.Fields.Item(15).Value/1000,0), d),1,10) & "</VENCIMIENTO>"
			DIFERENCIA =   Round(ORs.Fields.Item(16).Value/(1000*60*60*24),0) & " Días."  
	
		  Else
		  
		  	HOR = ORs.Fields.Item(13).Value
			Response.Write "<VENCIMIENTO>" & ORs.Fields.Item(15).Value & "</VENCIMIENTO>"
			DIFERENCIA =  ( HOR - ORs.Fields.Item(15).Value)  & " Km."
			
		  End If
		  

		  Response.Write "<DIFERENCIA>" & DIFERENCIA & "</DIFERENCIA>" 
		  Response.Write "<HOROMETRO>" & HOR & "</HOROMETRO>"
		  Response.Write "<HOROMETRO_ASG>" & ORs.Fields.Item(14).Value & "</HOROMETRO_ASG>"
		  
		 
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getUsrActividad()

	query = "SELECT CODIGO, DESCRIPCION "
	query = query & " FROM ACTIVIDADES_USUARIO "
	query = query & " WHERE CODIGO=" & CODIGO 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"		 
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function updateActividad()

	query = "UPDATE ACTIVIDADES SET "
	query = query & "NOMBRE=" & strNvl(NOMBRE) & ", "
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ", "
	query = query & "TIPO_HOROMETRO=" & strNvl(TIPO_HOROMETRO) & ", " 
	query = query & "TIPO=" & strNvl(TIPO_CONTROL) & ", "
	query = query & "CANTIDAD_H=" & strNvl(CANTIDAD_H) & ", "
	query = query & "TOTAL_HH=" & strNvl(TOTAL_HH) & ", "
	
	query = query & "EJECUCION=" & strNvl(TIEMPO_EJECUCION) & ", "
	query = query & "PERIODO=" & strNvl(PERIODO) & ", "
	query = query & "ALARMA=" & strNvl(ALARMA) & ", "
	query = query & "ESCALA=" & strNvl(ESCALA) & ", "
	query = query & "ESCALA_ALARMA=" & strNvl(ESCALA_ALARMA) & ", "
	query = query & "SECTOR=" & strNvl(SECTOR) & ", "
	query = query & "COMPETENCIA=" & strNvl(COMPETENCIA) & ", "
	query = query & "ESTADO_EQUIPO=" & strNvl(ESTADO_EQUIPO) & ", "
	query = query & "HOROMETRO=" & strNvl(HOROMETRO) & ", "
	query = query & "HOROMETRO_ASG=" & strNvl(HOROMETRO_ASG) & ", "
	query = query & "VENCIMIENTO=" & strNvl(VENCIMIENTO) & ", "
	query = query & "PEDIDO=" & strNvl(OPORTU) & " "
	query = query & "WHERE CODIGO=" & CODIGO
	query = query & " AND COD_EQUIPO=" & strNvl(COD_EQUIPO)
	query = query & " AND UBICACION=" & strNvl(EMPRESA)
	
	Set ORs =oDB.EjecutaSql(query)
	
	'response.write query	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" '& VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<Q>" & query & " </Q>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function UpdateSubActividad()

	query = "UPDATE SUB_ACTIVIDADES SET NOMBRE = '" & NOMBRE & "' "
	query = query & "WHERE CODIGO=" & SUB_CODIGO 
	query = query & " AND COD_EQUIPO='" & COD_EQUIPO & "'"
	query = query & " AND COD_ACTIVIDAD=" & CODIGO
		
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function delArticulosOT()


	query = "DELETE FROM ARTICULOS_OT WHERE FOLIO_OT = " & FOLIO_OT 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	
end function

function delArticulosAct()

	query = "DELETE FROM ARTICULOS_ACT WHERE COD_ACTIVIDAD = " & COD_ACTIVIDAD
	query = query & " AND EQUIPO=" & strNvl(EQUIPO)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
end function

function delActividad()

	 		query = "DELETE FROM SUB_ACTIVIDADES WHERE "
	query = query & "  COD_ACTIVIDAD=" & CODIGO
	query = query & " AND COD_EQUIPO=" & strNvl(COD_EQUIPO) 
	
	'response.write(query)
	
	ORs = oDB.EjecutaSql(query)
	query = "DELETE FROM ACTIVIDADES WHERE CODIGO=" & CODIGO 
	query = query & " AND COD_EQUIPO='" & COD_EQUIPO & "'"
	query = query & " AND UBICACION='" & UBICACION & "'"
	
	ORs = oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function delSubActividad()

	query = "DELETE FROM SUB_ACTIVIDADES WHERE CODIGO=" & COD_SUB 
	query = query & " AND COD_ACTIVIDAD=" & CODIGO
	query = query & " AND COD_EQUIPO=" & strNvl(COD_EQUIPO) 
	
	'response.write(query)
	
	ORs = oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
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