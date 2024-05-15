<!--#include virtual="/standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

	FAENA = REQUEST("FAENA")
	COD_EQUIPO=UCASE(REQUEST("COD_EQUIPO"))
	RECURSO=REQUEST("RECURSO")
		
select case RECURSO
	case "ObtenerEquipos"
		ObtenerEquipos()
	case "ObtenerDetalleEquipo"
		ObtenerDetalleEquipo()
	case "informavariable"
		informavariable()
	case "informavideo"
		informavideo()
	case "informaimagen"
		informaimagen()	
	case Else
		response.write("HELLO MASTER")
		response.end()	
end select

function ObtenerEquipos()


	query = "SELECT CODIGO, DESCRIPCION "
	query = query & " FROM EQUIPOS "
	query = query & " WHERE UBICACION = UPPER( '" & FAENA & "') AND (COD_EQUIPO_PADRE IS NULL) "
	'query = query & " WHERE UBICACION = UPPER( '" & FAENA & "') AND (COD_EQUIPO_PADRE IS NULL OR COD_EQUIPO_PADRE IN "'
	'query = query & " (SELECT CODIGO FROM EQUIPOS WHERE UBICACION = UPPER( '" & FAENA & "') AND COD_EQUIPO_PADRE IS NULL))"'

	Set ORs =oDB.EjecutaSql(query)
	'Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf'
	Response.Write "<Equipo>" &chr(13)
	if Not ORs.EOF then
		While Not ORs.EOF 
			  Response.Write "<EquipoArbol Equipo='" & ORs.Fields.Item(0).Value &"'>" &chr(13)
			  Response.Write "   <Descripcion>" & ORs.Fields.Item(1).Value & "</Descripcion>" &chr(13)
			  Response.Write "</EquipoArbol>" &chr(13)
		  ORs.MoveNext
		Wend
	else
		Response.Write " No existe detalle de equipos" &chr(13)
	end if
	Response.Write "</Equipo>" &chr(13)
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ObtenerDetalleEquipo()
	 'query = "SELECT E2.CODIGO, E2.DESCRIPCION, E2.COD_EQUIPO_PADRE, E1.DESCRIPCION , E2.CODIGO+'-INSP' AS TIPOS, "'
	 'query = query & " 'INSPECCION VISUAL' AS TIPO FROM EQUIPOS E1 "'
	 'query = query & " INNER JOIN EQUIPOS E2 ON E1.CODIGO = E2.COD_EQUIPO_PADRE "'
	 'query = query & " 				  AND E1.UBICACION = E2.UBICACION "'
	 'query = query & " WHERE E2.COD_EQUIPO_PADRE = '" & COD_EQUIPO & "' "'
	 'query = query & " AND E2.UBICACION = '" & FAENA & "' "'
 	 'query = query & " ORDER BY dbo.NumbersOnly(E2.CODIGO)"'
 	 query = " 	SELECT CODIGO, DESCRIPCION, dbo.EquipoPrincipalFaena(CODIGO,UBICACION) AS COD_EQUIPO_PADRE, DESCRIPCION , CODIGO+'-INSP' AS TIPOS," 
 	 query = query & " 		'INSPECCION VISUAL' AS TIPO FROM EQUIPOS "
 	 query = query & " 		WHERE dbo.EquipoPrincipalFaena(CODIGO,UBICACION) = '" & COD_EQUIPO & "' "
 	 query = query & " 		AND UBICACION = '" & FAENA & "' "
 	 query = query & " 		AND CODIGO NOT IN (SELECT DISTINCT ISNULL(COD_EQUIPO_PADRE,0) FROM EQUIPOS WHERE UBICACION = '" & FAENA & "' "
 	 query = query & " 							AND dbo.equipoprincipal(CODIGO) = '" & COD_EQUIPO & "') "
 	 query = query & " ORDER BY dbo.NumbersOnly(CODIGO)"
	Set ORs =oDB.EjecutaSql(query)
	if Not ORs.EOF then
		'Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf'
		Response.Write "<Equipo>" &chr(13)
		Response.Write "<EquipoArbol Equipo='"& COD_EQUIPO &"'>"  &chr(13)
		Response.Write "<Descripcion>" & ORs.Fields.Item(3).Value & "</Descripcion>" &chr(13)
		While Not ORs.EOF 
			  Response.Write "<Componentes CO='" & ORs.Fields.Item(0).Value & "'>" &chr(13)
			  Response.Write "<Componente>" & ORs.Fields.Item(1).Value & "</Componente>" &chr(13)
			  Response.Write "<CodigoPapa>" & ORs.Fields.Item(2).Value & "</CodigoPapa>" &chr(13)
			  Response.Write "<TiposMedicion MS='" & ORs.Fields.Item(4).Value & "'>" &chr(13)
			  Response.Write "<TipoMedicion>" & ORs.Fields.Item(5).Value & "</TipoMedicion>" &chr(13)
			  Response.Write "<CodigoPapa>"& ORs.Fields.Item(0).Value &"</CodigoPapa>" &chr(13)
			  Response.Write "</TiposMedicion>" &chr(13)
			  Response.Write "</Componentes>" &chr(13)
		  ORs.MoveNext
		Wend
		Response.Write "</EquipoArbol>" &chr(13)
		Response.Write "</Equipo>" &chr(13)
	else
		Response.Write "<Equipo>" &chr(13)
		Response.Write " Equipo no encontrado" &chr(13)
		Response.Write "</Equipo>" &chr(13)
	end if
	Set ORs = Nothing
	Set ODB = Nothing
end function

function informavariable()
	fecha 			= REQUEST("fecha")
	fecha			= Mid(fecha,4,3)&Mid(fecha,1,3)&Mid(fecha,7,4)
	hora 			= REQUEST("hora")
	ejecutor 		= UCASE(REQUEST("ejecutor"))
	valor 			= REQUEST("valor")
	observaciones 	= REQUEST("observaciones")
	recomendaciones	= REQUEST("recomendaciones")
	causaRaiz 		= REQUEST("causaRaiz")
	criticidad 		= REQUEST("criticidad")
	
	COD_EQUIPO= Mid(COD_EQUIPO, 1, InStr(COD_EQUIPO, "-INSP")-1)

	query = "SELECT MAX(ID) AS N FROM BITACORAS"
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = oRS("N") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO BITACORAS (ID, FECHA, EJECUTOR,  RESPONSABLE,  "
	query = query & " DESCRIPCION, ESTADO, EQUIPO, REPORT, "
	query = query & " IND_INCIDENTE, IND_DANO, UBICACION, CAUSA, RECOMENDACION,"
	query = query & " IND_SOLUCION) VALUES ('"
	query = query & N & "','" 
	query = query & fecha & "','"
	query = query & ejecutor & "','"
	query = query & ejecutor & "','" 'aqui hay algo raro'
	query = query & observaciones & "',"
	query = query & "'ING','"
	query = query & COD_EQUIPO & "',"
	query = query & "NULL,"
	query = query & "NULL,"
	query = query & "NULL,'"
	query = query & FAENA & "','"
	query = query & causaRaiz & "','"
	query = query & recomendaciones & "',"
	query = query & "'FALSE');"
	'err.clear'
	On Error Resume Next
		Set ORs =oDB.EjecutaSql(query)
	'if err.number < > 0 then'
		'N=err.number'
	'end if'

'	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf'
'	Response.Write "<REGISTROS>"'
'	Response.Write "<ID>" & N  & "</ID>"'
	Response.Write N
'	Response.Write "</REGISTROS>"'
	Set ORs = Nothing
	Set oDB = Nothing
end function

function informaFile()
	N 				= REQUEST("N")
	tipo 			= REQUEST("TIPO")
	peso 			= REQUEST("PESO")
	directorio		= REQUEST("DIRECTORIO")
	familia			= REQUEST("FAMILIA")
	ext_ 			= REQUEST("EXT")
	identificador	= REQUEST("ID")
				
	query = "INSERT INTO ARCHIVOS (ID, NOMBRE, TIPO, SIZE, FECHA, RUTA, FAMILIA, EXT, IDENTIFICADOR) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & N & ","
	query = query & strNvl(tipo) & ","
	query = query & strNvl(peso) & ","
	query = query & "getdate(),"
	query = query & strNvl(directorio) & ","
	query = query & strNvl(familia) & ","
	query = query & strNvl(ext_) & ","
	query = query & strNvl(identificador) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write  N	
	Set ORs = Nothing
	Set ODB = Nothing

end function


function nombraFile()
	codFaena 	= REQUEST("codFaena")
	codEquipo 	= REQUEST("codEquipo")
	codNodo 	= REQUEST("codNodo")
	fecha 		= REQUEST("fecha")

	query = "SELECT MAX(ID) AS NUM FROM ARCHIVOS "
	Set ORs =oDB.EjecutaSql(query)	
	If Not ORs.Eof Then
		 N =oRS("NUM") + 1
	Else
		 N = 1
	End If

	response.write N	
	Set ORs = Nothing
	Set ODB = Nothing
end function
%>

