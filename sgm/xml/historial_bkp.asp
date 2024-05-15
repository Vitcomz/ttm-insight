<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
FECHA=UCASE(REQUEST("FECHA"))
ESTATUS=UCASE(REQUEST("ESTATUS"))
INSPECTOR=UCASE(REQUEST("INSPECTOR"))
FECHAX=UCASE(REQUEST("FECHAX"))
FAENA=UCASE(REQUEST("FAENA"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
WIN=UCASE(REQUEST("WIN"))


select case RECURSO
	case "listHisBit"
		listHisBit()
		
	case "newHisBit"
		  newHisBit()
		
	

		
end select

function listHisBit()

	query = "SELECT B.ID, B.INSPECTOR, convert(char(10),B.FECHA,105), B.STATUS"
	query = query & " FROM HISTORIAL_BITACORA as B INNER JOIN BITACORAS  ON B.ID = dbo.BITACORAS.ID where ubicacion = 'LOS PELAMBRES' "
	'query = query & " WHERE B.ID = " & ID
	query = query & " ORDER BY B.USERDATE DESC "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	N=1
	WHILE Not ORs.EOF 
	  Response.Write "<ROWS>" 
	  	  Response.Write "<NRO>" & N & "</NRO>"
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<INSPECTOR>" & ORs.Fields.Item(1).Value & "</INSPECTOR>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
		  SELECT CASE ORs.Fields.Item(3).Value
		  	CASE 1 
				ESTATUS = "DISMINUYE CRITICIDAD"
			CASE 2
				ESTATUS ="SE MANTIENE CONDICION"
			CASE 3
				ESTATUS ="AUMENTA CRITICIDAD"
			CASE 4
				ESTATUS ="NO SE REALIZA INSPECCION"
		 END SELECT
		  Response.Write "<STATUS>" & ESTATUS & "</STATUS>"
		  Response.Write "<OP></OP>"
	  Response.Write "</ROWS>"
	  N=N+1
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function newHisBit()



	query = "SELECT ID FROM BITACORAS "
	query = query & "WHERE UBICACION ='" & FAENA & "' AND EQUIPO ='" & EQUIPO & "' AND FECHA ='" & FECHAX & "'"
	Set ORs =oDB.EjecutaSql(query)
	If not ORs.eof Then
		FOLIO = ORs.Fields.Item(0).Value
	End If
	

	query = "SELECT ID AS NUM FROM HISTORIAL_BITACORA "
	query = query & "WHERE ID='" & FOLIO & "' and INSPECTOR='" & INSPECTOR & "' and FECHA='" & FECHA & "' and STATUS='" & ESTATUS & "'"
	Set ORs =oDB.EjecutaSql(query)
	If not ORs.eof Then
		N = 1
	Else
		N = 0
	End If

	if N = 0 then
		query = "INSERT INTO HISTORIAL_BITACORA  (" 
		query = query & " ID, "
		query = query & " INSPECTOR, "
		query = query & " FECHA, STATUS, USERDATE, USERNAME) "
		query = query & " VALUES ("
		query = query & FOLIO & ","
		query = query & strNvl(INSPECTOR) & ","
		query = query & strNvl(FECHA) & ","
		query = query & strNvl(ESTATUS) & ", GETDATE(), " & strNvl(INSPECTOR) & ")"

		Set ORs =oDB.EjecutaSql(query)
		query = "UPDATE BITACORAS SET ULT_INSPECCION =" & strNvl(FECHA)
		query = query & " WHERE ID = " & strNvl(ID)
		
		Set ORs =oDB.EjecutaSql(query)
		
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		Response.Write "<ROW>ok</ROW>"
		'Response.Write query
		Response.Write "</REGISTROS>"

		
'	else
'		query = "UPDATE HISTORIAL_BITACORA SET INSPECTOR =" & strNvl(INSPECTOR)
'		query = query & " , FECHA="  & strNvl(FECHA)
'		query = query & " , STATUS="  & strNvl(ESTATUS)
'		query = query & " , USERDATE= GETDATE()"
'		query = query & " WHERE ID = " & strNvl(FOLIO)
'		Set ORs =oDB.EjecutaSql(query)
'
'		query = "UPDATE BITACORAS SET ULT_INSPECCION =" & strNvl(FECHA)
'		query = query & " WHERE ID = " & strNvl(ID)
'		Set ORs =oDB.EjecutaSql(query)
'		
'		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
'		Response.Write "<REGISTROS>"
'		Response.Write "<ROW>ok</ROW>"
'		'Response.Write query
'		Response.Write "</REGISTROS>"
		
	end if


	Set ORs = Nothing
	Set oDB = Nothing
	
End function

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

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function

if(WIN = "OK") then



	 Response.Write ("<html><body><script>setTimeout(function(){ window.close(); }, 700);</script></body></html>")
	 
end if

%>