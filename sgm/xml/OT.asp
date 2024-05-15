<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ACTIVIDAD=REQUEST("ACTIVIDAD")
CODIGO=UCASE(REQUEST("CODIGO"))
COD_ACTIVIDAD=REQUEST("COD_ACTIVIDAD")
COD_ARTICULO = REQUEST("COD_ARTICULO")
CANTIDAD=REQUEST("CANTIDAD")
COMPONENTE=UCASE(REQUEST("COMPONENTE"))
COD_COMPONENTE=UCASE(REQUEST("COD_COMPONENTE"))
COD_SUB_ACTIVIDAD=REQUEST("COD_SUB_ACTIVIDAD")
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FOLIO=UCASE(REQUEST("FOLIO"))
DOCUMENTO=UCASE(REQUEST("DOCUMENTO"))
DURACION=UCASE(REQUEST("DURACION"))

ID=UCASE(REQUEST("ID"))
ID_INCIDENTE=UCASE(REQUEST("ID_INCIDENTE"))
RESPONSABLE=REQUEST("RESPONSABLE") 

HOROMETRO_CRO=REQUEST("HOROMETRO_CRO")
ROL=REQUEST("ROL") 
OBSERVACION=UCASE(REQUEST("OBSERVACION"))
FAENA=REQUEST("FAENA")
FECHA=REQUEST("FECHA")
FECHA_EJECUCION=REQUEST("FECHA_EJECUCION")
FECHA_INICIO=REQUEST("FECHA_INICIO")
FECHA_SOLICITUD=REQUEST("FECHA_SOLICITUD")
FECHA_DESPACHO=REQUEST("FECHA_DESPACHO")
FECHA_PROGRAMADA=REQUEST("FECHA_PROGRAMADA")
CLIENTE=REQUEST("CLIENTE")
ESTADO=REQUEST("ESTADO")
ELEMENTO=UCASE(REQUEST("ELEMENTO"))
ESPESOR=UCASE(REQUEST("ESPESOR"))
EQUIPO=REQUEST("EQUIPO")
EQUIPO_PRIN=REQUEST("EQUIPO_PRIN")
TURNO=REQUEST("TURNO")
TIPO=REQUEST("TIPO")
TIPO_REV=REQUEST("TIPO_REV")
PROVEEDOR=UCASE(REQUEST("PROVEEDOR"))
RUT_PROVEEDOR=UCASE(REQUEST("RUT_PROVEEDOR"))

USUARIO=REQUEST("USUARIO") 
U_MEDIDA=UCASE(REQUEST("U_MEDIDA")) 
VALOR=REQUEST("VALOR")



select case RECURSO
	
	case "GetOT"
		GetOT()
		
	case "getLayout"
			getLayout()
		
	case "NewOT"
		NewOT()
		
	case "UpdateOT"
		UpdateOT()
		
	case "FinalizarOT"
		  FinalizarOT()

	case "InsertIncidenteOT"
		  InsertIncidenteOT()

  	case "InsertArticulosOT"
		  InsertArticulosOT()
		  		  
  	case "DeleteIncidentesOT"
		  DeleteIncidentesOT()

   	case "DeleteArticulosOT"
		  DeleteArticulosOT()
		
	case "InsertActividadesOT"
		InsertActividadesOT()
		
	case "InsertActividadesUSR"
		InsertActividadesUSR()

  	case "DeleteActividadesOT"
		  DeleteActividadesOT()
		  
	case "ListOT"
		ListOT()

	case "ListOTPen"
		ListOTPen()
		
	case "ListSubEquipos"
		ListSubEquipos()
		
	case "ListEquiposMan"
		ListEquiposMan()

	case "AsignarOT"
			AsignarOT()
		
	case "ListIncidentesOT"
		ListIncidentesOT()

	case "ListArticulosOT"
		ListArticulosOT()

	case "ListActividadesUsr"
		 ListActividadesUsr()
		
	case "ListEquiposAsignados"
		ListEquiposAsignados()
		
	case "ListEquiposOTPre"
		  ListEquiposOTPre()
			
	case "ListSubActividadesOT"
		ListSubActividadesOT()

end select


function ListSubActividadesOT()

	query = "SELECT   VI_SUBACTIVIDADES.COD_ACTIVIDAD, VI_SUBACTIVIDADES.ACTIVIDAD AS ACTIVIDAD,"
	query = query & " VI_SUBACTIVIDADES.CODIGO, VI_SUBACTIVIDADES.NOMBRE, VI_SUBACTIVIDADES.COD_EQUIPO, "
	query = query & " AO.IND_EJECUTADO, AO.FECHA, VI_SUBACTIVIDADES.DESCRIPCION "
	query = query & " FROM         VI_SUBACTIVIDADES LEFT OUTER JOIN"
	query = query & " (SELECT     COD_SUB_ACTIVIDAD, FOLIO_OT, CODIGO_ACTIVIDAD, IND_EJECUTADO, FECHA"
	query = query & "  FROM          ACTIVIDADES_OT"
	query = query & "  WHERE      (FOLIO_OT = " & FOLIO_OT & ")) AS AO ON "
	query = query & " VI_SUBACTIVIDADES.CODIGO = AO.COD_SUB_ACTIVIDAD"
	query = query & " AND VI_SUBACTIVIDADES.COD_ACTIVIDAD = AO.CODIGO_ACTIVIDAD"
	query = query & " WHERE     (VI_SUBACTIVIDADES.COD_EQUIPO = '" & EQUIPO & "')"
	query = query & " ORDER BY VI_SUBACTIVIDADES.COD_ACTIVIDAD, VI_SUBACTIVIDADES.CODIGO "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
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
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function NewOT()
	
	query = "SELECT MAX(FOLIO_OT) AS NUM FROM OT "
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO OT (" 
	query = query & " FOLIO_OT, "
	query = query & " FECHA_PROGRAMADA, "
	query = query & " FECHA_EJECUCION, "
	query = query & " FECHA_INICIO, "
	query = query & " FECHA_SOLICITUD, "
	query = query & " FECHA_DESPACHO, "
	query = query & " DOCUMENTO, "
	query = query & " DURACION, "
	query = query & " CLIENTE, "
	query = query & " EQUIPO,"
	query = query & " TURNO, "
	query = query & " ESTADO, "
	query = query & " TIPO_REV, "
	query = query & " COMPONENTE, "
	query = query & " ESPESOR, "
	query = query & " RESPONSABLE, "
	query = query & " OBSERVACION,"
	query = query & " UBICACION,"
	query = query & " USERDATE) "
	query = query & " VALUES ("
	query = query &  N & ","
	query = query &  strNvl(FECHA_PROGRAMADA) & "," 
	query = query &  strNvl(FECHA_EJECUCION) & "," 
	query = query &  strNvl(FECHA_INICIO) & ","
	query = query &  strNvl(FECHA_SOLICITUD) & ","
	query = query &  strNvl(FECHA_DESPACHO) & "," 
	query = query &  strNvl(DOCUMENTO) & "," 
	query = query &  strNvl(DURACION) & "," 
	query = query &  strNvl(CLIENTE) & "," 
	query = query &  strNvl(EQUIPO) & "," 
	query = query &  strNvl(TURNO) & "," 
	query = query &  strNvl(ESTADO) & "," 
	query = query &  strNvl(TIPO_REV) & "," 
	query = query &  strNvl(COMPONENTE) & "," 
	query = query &  strNvl(ESPESOR) & "," 
	query = query &  strNvl(RESPONSABLE) & "," 
	query = query & strNvl(OBSERVACION) & ","
	query = query & strNvl(FAENA) & ","
 	query = query & "getdate() )"  
		
	Set ORs =oDB.EjecutaSql(query)
	
	'query = "UPDATE EQUIPOS SET FECHA_ASIGNADO = GETDATE() WHERE CODIGO =" & strNvl(EQUIPO)
	'Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & N  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function AsignarOT()
	query = "UPDATE OT SET "
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) 
	query = query & " WHERE FOLIO_OT=" & FOLIO_OT

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function ListOT()

	 query = "SELECT V.FOLIO_OT, V.FECHA_EJECUCION, V.COD_EQUIPO, V.DESC_EQUIPO, "
 	 query = query & " V.TURNO, V.RESPONSABLE, V.FECHA_PROGRAMADA, "
  	 query = query & " V.ESTADO, V.OBSERVACION, I.ID, I.DESCRIPCION "
	 query = query & " FROM VI_OT_EQUIPO AS V "
	 query = query & " LEFT OUTER JOIN VI_INCIDENTES_OT AS I ON V.FOLIO_OT = I.FOLIO_OT"
	  
	 if LEN(ESTADO)>0 AND ESTADO<>"TOD" THEN
	  	 	query = query & " WHERE V.ESTADO=" & strNvl(ESTADO)
	 Else
	  	 	query = query & " WHERE V.ESTADO IN ('PRO','PEN')"
	 End If
	 
 	 If LEN(TURNO)>0 AND TURNO<>"TOD" THEN
	  	 	query = query & " AND V.TURNO=" & strNvl(TURNO)
	 End If
	 
  	 If LEN(RESPONSABLE)>0 AND RESPONSABLE<>"TOD" THEN
	  	 	query = query & " AND V.RESPONSABLE=" & strNvl(RESPONSABLE)
	 End If

 	 If TIPO="COR" Then
	  	 query = query & " AND  V.TIPO='COR'"
	 End If
	 
	  If TIPO="PRE" Then
	  	 query = query & " AND  V.TIPO='PRE'"
	 End If
	 
	 If LEN(ROL)>0 AND ROL="SUPERVISOR" Then
	  	 query = query & " AND V.RESPONSABLE=" & strNvl(USUARIO)
	 End If
	 
	 If Len(EQUIPO)>0  AND EQUIPO<>"TOD" Then
	 	 query = query & " AND DBO.EquipoPrincipal(V.COD_EQUIPO) = " & strNvl(EQUIPO)
	 End if
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<COD_EQUIPO>" & ORs.Fields.Item(2).Value & "</COD_EQUIPO>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(3).Value & "</DESC_EQUIPO>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(4).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(5).Value & "</RESPONSABLE>"
  		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(6).Value & "</FECHA_PROGRAMADA>"
		  
		  Select Case ORs.Fields.Item(7).Value 
	  			Case "PRO"
			   		  Response.Write "<ESTADO>PROGRAMADA</ESTADO>"
  	  			Case "EJE"
			   		  Response.Write "<ESTADO>EJECUTADA</ESTADO>"
   	  			Case "PEN"
			   		  Response.Write "<ESTADO>PENDIENTE</ESTADO>"
  	  			Case "NUL"
			   		  Response.Write "<ESTADO>ANULADA</ESTADO>"
		  End Select

  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(8).Value & "</OBSERVACION>"
   		  Response.Write "<ID_INCIDENTE>" & ORs.Fields.Item(9).Value & "</ID_INCIDENTE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(10).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListOTPen()

	query = "SELECT V.FOLIO_OT, RTRIM(CONVERT(CHAR,V.FECHA_PROGRAMADA,103)) AS FECHA,"
	query = query & " V.COD_EQUIPO + ' ' + V.DESC_EQUIPO AS EQUIPO, V.DESC_EQUIPO,"
  	query = query & " V.TURNO, V.RESPONSABLE, V.FECHA_EJECUCION, V.ESTADO, V.OBSERVACION "
	query = query & "	  FROM VI_OT_EQUIPO AS V "
	'query = query & "	  WHERE (--V.FECHA_PROGRAMADA<=GETDATE()--  OR V.FECHA_PROGRAMADA IS NULL) "
	query = query & "	  WHERE  "
	query = query & "		 ESTADO IN ('PRO','PEN')"
	 
	 If ROL="SUPERVISOR" Then
	  	 query = query & " AND V.RESPONSABLE=" & strNvl(USUARIO)
	 End If
	 
 	 
	 query = query & " AND V.UBICACION=" & strNvl(FAENA)
	
	 	 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<EQUIPO>" & ORs.Fields.Item(2).Value & "</EQUIPO>"
		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(3).Value & "</DESC_EQUIPO>"
  		  Response.Write "<TURNO>" & ORs.Fields.Item(4).Value & "</TURNO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(5).Value & "</RESPONSABLE>"
  		  Response.Write "<FECHA_EJECUCION>" & ORs.Fields.Item(6).Value & "</FECHA_EJECUCION>"
		  
		  Select Case ORs.Fields.Item(7).Value 
	  			Case "PRO"
			   		  Response.Write "<ESTADO>PROGRAMADA</ESTADO>"
  	  			Case "EJE"
			   		  Response.Write "<ESTADO>EJECUTADA</ESTADO>"
   	  			Case "PEN"
			   		  Response.Write "<ESTADO>PENDIENTE</ESTADO>"
  	  			Case "NUL"
			   		  Response.Write "<ESTADO>ANULADA</ESTADO>"
		  End Select

  		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(8).Value & "</OBSERVACION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListActividadesUsr()
	 query = "SELECT A.FOLIO_OT, A.DESCRIPCION "
	 query = query & " FROM ACTIVIDADES_USUARIO AS A"
 	 query = query & " WHERE FOLIO_OT = " & FOLIO_OT
 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
		  Response.Write "<ACTIVIDAD>" & ORs.Fields.Item(1).Value & "</ACTIVIDAD>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListIncidentesOT()


	 query = "SELECT I_OT.ID, I_OT.FECHA AS FECHA_INCIDENTE, I_OT.DIAS, I_OT.TURNO AS TUR_INCIDENTE,"
	 query = query & "I_OT.DESCRIPCION AS DESC_INCIDENTE, I_OT.EQUIPO AS COD_EQUIPO, I_OT.DESC_EQUIPO,"
	 query = query & "OT.FOLIO_OT, OT.RESPONSABLE AS RESPONSABLE_OT, OT.FECHA_PROGRAMADA, OT.TURNO, OT.ESTADO "
	 query = query & "FROM VI_INCIDENTES_OT AS I_OT "
	 query = query & "LEFT OUTER JOIN (SELECT * FROM OT  WHERE TIPO='COR') AS OT ON I_OT.FOLIO_OT = OT.FOLIO_OT"
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  		  Response.Write "<FECHA_INCIDENTE>" & ORs.Fields.Item(1).Value & "</FECHA_INCIDENTE>"
   		  Response.Write "<DIAS>" & ORs.Fields.Item(2).Value & "</DIAS>"
   		  Response.Write "<TUR_INCIDENTE>" & ORs.Fields.Item(3).Value & "</TUR_INCIDENTE>"
		  Response.Write "<DESC_INCIDENTE>" & ORs.Fields.Item(4).Value & "</DESC_INCIDENTE>"
  		  Response.Write "<COD_EQUIPO>" & ORs.Fields.Item(5).Value & "</COD_EQUIPO>"
   		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(6).Value & "</DESC_EQUIPO>"
  		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(7).Value & "</FOLIO_OT>"
  		  Response.Write "<RESPONSABLE_OT>" & ORs.Fields.Item(8).Value & "</RESPONSABLE_OT>"
   		  Response.Write "<FECHA_OT>" & ORs.Fields.Item(9).Value & "</FECHA_OT>"
   		  Response.Write "<TURNO_OT>" & ORs.Fields.Item(10).Value & "</TURNO_OT>"
   		  Response.Write "<ESTADO>" & ORs.Fields.Item(11).Value & "</ESTADO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArticulosOT()


	 query =  " SELECT AO.ID, AO.DESCRIPCION, AO.VALOR, AO.CANTIDAD, AO.U_MEDIDA, AO.PROVEEDOR, P.NOMBRE "
	 query = query & " FROM ARTICULOS_OT AS AO "
 	 query = query & " LEFT OUTER JOIN  TTMDATA.EXISTENCIAS.ARTICULOS AS A ON  A.ID = AO.ID "
 	 query = query & " LEFT OUTER JOIN TTMDATA.EXISTENCIAS.PROVEEDORES AS P ON AO.PROVEEDOR =P.RUT "
 	 query = query & " WHERE FOLIO_OT= " & strNvl(FOLIO)
	 
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
		  Response.Write "<U_MEDIDA>" & ORs.Fields.Item(4).Value & "</U_MEDIDA>"
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(5).Value & "</RUT_PROVEEDOR>"
		  Response.Write "<DESC_PROVEEDOR>" & ORs.Fields.Item(6).Value & "</DESC_PROVEEDOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListEquiposOTPre()


	query = " SELECT E.CODIGO, E.DESCRIPCION, OT.FOLIO_OT, OT.RESPONSABLE AS RESPONSABLE,"
	query = query & " OT.FECHA_PROGRAMADA, OT.TURNO, OT.ESTADO, OT.EQUIPO"
	query = query & " FROM VI_EQUIPOS_MAN AS E"
	query = query & "  LEFT OUTER JOIN (SELECT OT.FOLIO_OT, OT.RESPONSABLE AS RESPONSABLE, "
	query = query & " 	  OT.FECHA_PROGRAMADA, OT.TURNO, OT.ESTADO, OT.EQUIPO "
	query = query & " 	FROM OT WHERE OT.TIPO='PRE') AS OT ON OT.EQUIPO = E.CODIGO"
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(2).Value & "</FOLIO_OT>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(3).Value & "</RESPONSABLE>"
  		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(4).Value & "</FECHA_PROGRAMADA>"
		  Response.Write "<TURNO>" & ORs.Fields.Item(5).Value & "</TURNO>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(6).Value & "</ESTADO>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListSubEquipos()
	 query = "SELECT CODIGO, DESCRIPCION, ESTADO,  FECHA, HOROMETRO, "
 	 query = query & "HOROMETRO_VEN, "
 	 query = query & "(HOROMETRO-HOROMETRO_VEN) AS DIFERENCIA, "
	 query = query & " SISTEMA, CIUDAD, MARCA, MODELO, PROVEEDOR, VIDA_UTIL, UBICACION, COD_EQUIPO_PADRE FROM EQUIPOS WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(4).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(6).Value & "</DIFERENCIA>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListEquiposMan()
	 query = "SELECT CODIGO, DESCRIPCION, FECHA, HOROMETRO, "
	 query = query & " HOROMETRO_VEN, "
	 query = query & "(HOROMETRO-HOROMETRO_VEN) AS DIFERENCIA, "
  	 query = query & " RESPONSABLE_MAN FROM EQUIPOS "
   	 query = query & " WHERE  (HOROMETRO_VEN-HOROMETRO-HOROMETRO_ALARM) <=0 "

'	 query = query & " WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"
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
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function ListEquiposAsignados()
	 query = "SELECT CODIGO, DESCRIPCION, FECHA, HOROMETRO, "
	 query = query & " HOROMETRO_VEN, "
	 query = query & " FECHA_ASIGNADO, "
  	 query = query & " RESPONSABLE_MAN FROM EQUIPOS "
   	 query = query & " WHERE  ASIGNADO_MAN='S' "

'	 query = query & " WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"
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
   		  Response.Write "<FECHA_ASIGNADO>" & ORs.Fields.Item(5).Value & "</FECHA_ASIGNADO>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function GetOT()

	query = "SELECT OT.FOLIO_OT, convert(char,OT.FECHA_PROGRAMADA,103),"
	query = query & "rtrim(convert(char,fecha_inicio,103)) + ' ' + "
	query = query & " substring(convert(char,fecha_inicio,108),1,5) as FECHA_INICIO,"
	query = query & "rtrim(convert(char,fecha_ejecucion,103)) + ' ' + "
	query = query & " substring(convert(char,fecha_ejecucion,108),1,5) as FECHA_EJECUCION,"
	query = query & "convert(char,OT.FECHA_DESPACHO,103), convert(char,OT.FECHA_SOLICITUD,103), "
	query = query & "OT.ESTADO, OT.RESPONSABLE, OT.TURNO, OT.EQUIPO, "
	query = query & "E.DESCRIPCION AS DESC_EQUIPO, OT.TIPO_REV, OT.OBSERVACION, OT.COMPONENTE,  "
	query = query & "OT.DOCUMENTO, OT.ESPESOR, OT.CLIENTE, C.NOMBRE, E2.DESCRIPCION, OT.DURACION "
	query = query & "FROM OT "
	query = query & "LEFT OUTER JOIN EQUIPOS E ON  OT.EQUIPO = E.CODIGO "
	query = query & "LEFT OUTER JOIN TTMDATA.EXISTENCIAS.CLIENTES AS C ON OT.CLIENTE = C.RUT"
	query = query & " LEFT OUTER JOIN EQUIPOS AS E2 ON OT.COMPONENTE = E2.CODIGO"
	query = query & " WHERE FOLIO_OT = " &  FOLIO_OT
	
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"' & query
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO_OT>" & ORs.Fields.Item(0).Value & "</FOLIO_OT>"
		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(1).Value & "</FECHA_PROGRAMADA>"
  		  Response.Write "<FECHA_INICIO>" & Mid(ORs.Fields.Item(2).Value,1,16) & "</FECHA_INICIO>"
   		  Response.Write "<FECHA_EJECUCION>" & Mid(ORs.Fields.Item(3).Value,1,16) & "</FECHA_EJECUCION>"
		  Response.Write "<FECHA_DESPACHO>" & ORs.Fields.Item(4).Value & "</FECHA_DESPACHO>"
		  Response.Write "<FECHA_SOLICITUD>" & ORs.Fields.Item(5).Value & "</FECHA_SOLICITUD>"
   		  Response.Write "<ESTADO>" & ORs.Fields.Item(6).Value & "</ESTADO>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(7).Value & "</RESPONSABLE>"
		  Response.Write "<TURNO>" & ORs.Fields.Item(8).Value & "</TURNO>"
  		  Response.Write "<COD_EQUIPO>" & ORs.Fields.Item(9).Value & "</COD_EQUIPO>"
   		  Response.Write "<DESC_EQUIPO>" & ORs.Fields.Item(10).Value & "</DESC_EQUIPO>"
   		  Response.Write "<TIPO_REV>" & ORs.Fields.Item(11).Value & "</TIPO_REV>"
   		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(12).Value & "</OBSERVACION>"
   		  Response.Write "<COD_COMPONENTE>" & ORs.Fields.Item(13).Value & "</COD_COMPONENTE>"
   		  Response.Write "<DOCUMENTO>" & ORs.Fields.Item(14).Value & "</DOCUMENTO>"
		  Response.Write "<ESPESOR>" & ORs.Fields.Item(15).Value & "</ESPESOR>"
		  Response.Write "<RUT_CLIENTE>" & ORs.Fields.Item(16).Value & "</RUT_CLIENTE>"
		  Response.Write "<CLIENTE>" & ORs.Fields.Item(17).Value & "</CLIENTE>"
		  Response.Write "<DESC_COMPONENTE>" & ORs.Fields.Item(18).Value & "</DESC_COMPONENTE>"
		  Response.Write "<DURACION>" & ORs.Fields.Item(19).Value & "</DURACION>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function getLayout()

	query = "set dateformat dmy "
	query = query & "SELECT OT.EQUIPO, DBO.EquipoPrincipal(OT.EQUIPO) AS PRINCIPAL, E.LAYOUT, E.X, E.Y, OT.FOLIO_OT, "
	query = query & " DATEDIFF(m, OT.FECHA_DESPACHO, getdate()) AS MESES, OT.FECHA_DESPACHO,OT.DURACION, "
	query = query & " CASE WHEN DATEDIFF(m, OT.FECHA_DESPACHO, getdate())>OT.DURACION THEN 'ALTA' "
	query = query & "	 WHEN DATEDIFF(m, OT.FECHA_DESPACHO, getdate())>OT.DURACION-3 THEN 'MEDIA' "
	query = query & "	 ELSE 'BAJA' END  "
	query = query & " FROM OT INNER JOIN EQUIPOS_USUARIOS AS EU ON DBO.EquipoPrincipal(OT.EQUIPO) = EU.EQUIPO "
	query = query & "				AND EU.USUARIO= 'HSANDOVAL'"
	query = query & " LEFT OUTER JOIN EQUIPOS AS E ON OT.EQUIPO = E.CODIGO AND E.UBICACION = OT.UBICACION  "
	query = query & " WHERE OT.UBICACION="  & strNvl(FAENA) & " AND DBO.EquipoPrincipal(OT.EQUIPO)=" & strNvl(EQUIPO_PRIN)
	query = query & " GROUP BY OT.EQUIPO,OT.FOLIO_OT, E.GCODE, E.LAYOUT, X, Y, OT.FECHA_DESPACHO, OT.DURACION "
	query = query & " ORDER BY OT.EQUIPO DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15' ?>" & VbCrLf & VbCrLf

	Response.Write "<REGISTROS>" '& query'
	N=0
	While Not ORs.EOF 
			N=N+1
			Response.Write "<ROW>" 
			Response.Write "<N>" & N & "</N>"
			Response.Write "<EQUIPO>" & ORs.Fields.Item(0).Value & "</EQUIPO>"
			Response.Write "<EQUIPO_PRIN>" & ORs.Fields.Item(1).Value & "</EQUIPO_PRIN>"
			Response.Write "<LAYOUT>" & ORs.Fields.Item(2).Value & "</LAYOUT>" 
			Response.Write "<X>" & ORs.Fields.Item(3).Value & "</X>" 
			Response.Write "<Y>" & ORs.Fields.Item(4).Value & "</Y>" 
			Response.Write "<FOLIO>" & ORs.Fields.Item(5).Value & "</FOLIO>"
			Response.Write "<COLOR>" & ORs.Fields.Item(9).Value & "</COLOR>"
			Response.Write "</ROW>"

	  ORs.MoveNext 
	Wend
	'Response.Write "<sql>" & query & "</sql>"'
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ORsFiles = Nothing
	Set ODB = Nothing
end function

function UpdateOT()

	query = "UPDATE OT SET ESTADO = " & strNvl(ESTADO) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ","
	query = query & "FECHA_INICIO=" & strNvl(FECHA_INICIO) & ","
	query = query & "FECHA_EJECUCION=" & strNvl(FECHA_EJECUCION) & ","
	query = query & "FECHA_SOLICITUD=" & strNvl(FECHA_SOLICITUD) & ","
	query = query & "FECHA_DESPACHO=" & strNvl(FECHA_DESPACHO) & ","
	query = query & "FECHA_PROGRAMADA=" & strNvl(FECHA_PROGRAMADA) & ","
	query = query & "CLIENTE=" & strNvl(CLIENTE) & ","	
	query = query & "DOCUMENTO=" & strNvl(DOCUMENTO) & ","	
	query = query & "TURNO=" & strNvl(TURNO) & ","
	query = query & "EQUIPO=" & strNvl(EQUIPO) & ","
	query = query & "DURACION=" & strNvl(DURACION) & ","
	query = query & "COMPONENTE=" & strNvl(COMPONENTE) & ","
	query = query & "ESPESOR=" & strNvl(ESPESOR) & ","
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ","
	query = query & "PROVEEDOR=" & strNvl(PROVEEDOR) & ","
	query = query & "TIPO_REV=" & strNvl(TIPO_REV) & ","
	query = query & "UBICACION=" & strNvl(FAENA) & ","
	query = query & "TIPO=" & strNvl(TIPO) & ""
	query = query & " WHERE FOLIO_OT=" & FOLIO_OT 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function FinalizarOT()

	query = "UPDATE OT SET ESTADO = 'EJE' " 
	query = query & " WHERE FOLIO_OT=" & FOLIO_OT 

	Set ORs =oDB.EjecutaSql(query)

	If TIPO="CRO" Then
		query = "UPDATE EQUIPOS SET HOROMETRO_VEN = " & HOROMETRO_CRO & " + HOROMETRO_MAN, " 
		query = query & "FECHA_ULT_MAN = " & strNvl(FECHA)
		query = query & " WHERE CODIGO=" & strNvl(EQUIPO)
	Else
		query = "UPDATE EQUIPOS SET HOROMETRO_VEN = HOROMETRO + HOROMETRO_MAN, " 
		query = query & "FECHA_ULT_MAN = " & strNvl(FECHA)
		query = query & " WHERE CODIGO=" & strNvl(EQUIPO)
	End If
	
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DeleteIncidentesOT()
	query = "DELETE FROM INCIDENTES_OT WHERE FOLIO_OT = " & FOLIO
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
end function

function DeleteArticulosOT()
	query = "DELETE FROM ARTICULOS_OT WHERE FOLIO_OT = " & FOLIO
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
end function

function InsertIncidenteOT()

	
	query = "INSERT INTO INCIDENTES_OT (FOLIO_OT, ID_INCIDENTE) VALUES ("
	query = query & FOLIO_OT & ","
	query = query & ID_INCIDENTE & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InsertArticulosOT()

	query = "INSERT INTO ARTICULOS_OT (FOLIO_OT, ID, DESCRIPCION, CANTIDAD, U_MEDIDA, VALOR, PROVEEDOR) VALUES ("
	query = query & FOLIO & ","
	query = query & strNvl(ID) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(U_MEDIDA) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(RUT_PROVEEDOR) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DeleteActividadesOT()

	query = "DELETE FROM ACTIVIDADES_OT WHERE FOLIO_OT = " & FOLIO_OT
	Set ORs =oDB.EjecutaSql(query)
	
	query = "DELETE FROM ACTIVIDADES_USUARIO WHERE FOLIO_OT = " & FOLIO_OT
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function
	
function InsertActividadesOT()

	
	query = "INSERT INTO ACTIVIDADES_OT (FOLIO_OT, CODIGO_ACTIVIDAD,"
	query = query & "COD_SUB_ACTIVIDAD, IND_EJECUTADO, FECHA) VALUES ("
	query = query & FOLIO_OT & ","
	query = query & COD_ACTIVIDAD & ","
	query = query & COD_SUB_ACTIVIDAD & ","
	query = query & "'TRUE', getdate())"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function InsertActividadesUSR()

	
	query = "INSERT INTO ACTIVIDADES_USUARIO (FOLIO_OT, DESCRIPCION, FECHA) "
	query = query & "VALUES ("
	query = query & FOLIO_OT & ","
	query = query & strNvl(ACTIVIDAD) & ", getdate())"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO_OT>" & FOLIO_OT  & "</FOLIO_OT>"
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


function DelEquipo()
	query = "UPDATE EQUIPOS SET ESTADO='NUL'  WHERE CODIGO = '" & CODIGO & "' "
	Set ORs = oDB.EjecutaSql(query)
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

