<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
SUB_CODIGO=UCASE(REQUEST("SUB_CODIGO"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
COD_EQUIPO=UCASE(REQUEST("COD_EQUIPO"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))

RECURSO=REQUEST("RECURSO")

select case RECURSO
	case "GetActividad"
		GetActividad()
		
	case "NewActividad"
		NewActividad()

	case "NewSubActividad"
		NewSubActividad()
		
	case "DelActividad"
		DelActividad()
		
	case "DelSubActividad"
		DelSubActividad()
		
	case "UpdateActividad"
		UpdateActividad()

	case "UpdateSubActividad"
		UpdateSubActividad()
		
	case "ListActividades"
		ListActividades()
		
	case "ListSubActividadesEquipo"
		ListSubActividadesEquipo()
				
	case "ListActividadesEquipos"
		ListActividadesEquipos()
		
	case "ListSubActividades"
		ListSubActividades()
		
	case "ListActividadEquipo"
		ListActividadEquipo()
end select

function NewActividad()

	query = "SELECT MAX(CODIGO) AS NUM FROM ACTIVIDADES"
	query = query & " WHERE COD_EQUIPO =" & strNvl(COD_EQUIPO) 
	
	Set ORs =oDB.EjecutaSql(query)

	If Len(oRS("NUM"))>0 Then
		CODIGO = oRS("NUM") + 1
	Else
		CODIGO = 1
	End If
	
	
	query = "INSERT INTO ACTIVIDADES (CODIGO, COD_EQUIPO, NOMBRE )"
	query = query & " VALUES ("
	query = query & CODIGO & ", " 
	query = query & strNvl(COD_EQUIPO) & "," 
	query = query & strNvl(NOMBRE) 
	query = query & ");" 
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function NewSubActividad()

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
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function


function ListActividades()

	query = "SELECT CODIGO, NOMBRE, DESCRIPCION"
	query = query & " FROM ACTIVIDADES"
	
	Set ORs =oDB.EjecutaSql(query)
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


function ListActividadesEquipos()

	query = "SELECT CODIGO, NOMBRE, DESCRIPCION"
	query = query & " FROM ACTIVIDADES"
	query = query & " WHERE COD_EQUIPO='" & COD_EQUIPO & "'"
	
	Set ORs =oDB.EjecutaSql(query)
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

function ListSubActividades()

	query = "SELECT   VI_SUBACTIVIDADES.COD_ACTIVIDAD, VI_SUBACTIVIDADES.ACTIVIDAD AS ACTIVIDAD,"
	query = query & " VI_SUBACTIVIDADES.CODIGO, VI_SUBACTIVIDADES.NOMBRE, VI_SUBACTIVIDADES.COD_EQUIPO, "
	query = query & "  AO.IND_EJECUTADO, AO.FECHA"
	query = query & " FROM         VI_SUBACTIVIDADES LEFT OUTER JOIN"
	query = query & " (SELECT     COD_SUB_ACTIVIDAD, FOLIO_OT, CODIGO_ACTIVIDAD, IND_EJECUTADO, FECHA"
	query = query & "   FROM          ACTIVIDADES_OT) AS AO ON "
	query = query & "  VI_SUBACTIVIDADES.CODIGO = AO.COD_SUB_ACTIVIDAD"
	query = query & " 	 AND VI_SUBACTIVIDADES.COD_ACTIVIDAD = AO.CODIGO_ACTIVIDAD"
	query = query & " 	 WHERE     (VI_SUBACTIVIDADES.COD_EQUIPO = 'G1.1.1')"
	query = query & " 	 ORDER BY VI_SUBACTIVIDADES.COD_ACTIVIDAD, VI_SUBACTIVIDADES.CODIGO "
end function

function ListSubActividades()

	query = "SELECT CODIGO, NOMBRE"
	query = query & " FROM SUB_ACTIVIDADES"
	query = query & " WHERE COD_ACTIVIDAD =" & CODIGO
	query = query & " AND COD_EQUIPO='" & COD_EQUIPO & "'" 
	
	Set ORs =oDB.EjecutaSql(query)
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

function ListSubActividadesEquipo()

	query = "SELECT A.NOMBRE AS ACTIVIDAD, SA.CODIGO, SA.NOMBRE"
	query = query & " FROM SUB_ACTIVIDADES AS SA, ACTIVIDADES AS A"
	query = query & " WHERE SA.COD_ACTIVIDAD = A.CODIGO"
	query = query & " AND A.COD_EQUIPO = SA.COD_EQUIPO "
	query = query & " AND SA.COD_EQUIPO=" & strNvl(EQUIPO) & "" 
	query = query & " ORDER BY A.NOMBRE, SA.CODIGO"
	
	Set ORs =oDB.EjecutaSql(query)
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


function GetActividad()

	query = "SELECT CODIGO, NOMBRE, DESCRIPCION "
	query = query & " FROM ACTIVIDADES"
	query = query & " WHERE CODIGO=" & CODIGO 
	query = query & " AND COD_EQUIPO=" & strNvl(COD_EQUIPO)

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateActividad()

	query = "UPDATE ACTIVIDADES SET "
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & " "
	query = query & "WHERE CODIGO=" & CODIGO
	query = query & " AND COD_EQUIPO=" & strNvl(COD_EQUIPO)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
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

function DelActividad()
	query = "DELETE FROM ACTIVIDADES WHERE CODIGO=" & CODIGO 
	query = query & " AND COD_EQUIPO='" & COD_EQUIPO & "'"
	
	ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function 

function DelSubActividad()
	query = "DELETE FROM SUB_ACTIVIDADES WHERE CODIGO=" & SUB_CODIGO 
	query = query & " AND COD_ACTIVIDAD=" & CODIGO
	query = query & " AND COD_EQUIPO='" & COD_EQUIPO & "'"
	
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

