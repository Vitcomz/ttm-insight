<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn
'Session.LCID = 11274

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
FECHA=UCASE(REQUEST("FECHA"))
ESTATUS=UCASE(REQUEST("ESTATUS"))
INSPECTOR=UCASE(REQUEST("INSPECTOR"))


select case RECURSO
	case "listHisBit"
		listHisBit()
		
	case "newHisBit"
		  newHisBit()
		
	

		
end select

function listHisBit()

	query = "SELECT B.ID, B.INSPECTOR, B.FECHA, B.STATUS"
	query = query & " FROM HISTORIAL_BITACORA AS B "
	query = query & " WHERE B.ID = " & ID
	query = query & " ORDER BY B.FECHA DESC"
	
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
			CASE 0
				ESTATUS = "INSPECCION INICIAL"
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
	  Response.Write "</ROWS>"
	  N=N+1
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function newHisBit()

	query = "SELECT MAX(ORDEN) AS N FROM HISTORIAL_BITACORA WHERE ID = " & ID
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		O = oRS("N") + 1
	Else
		O = 1
	End If

	query = " SET DATEFORMAT DMY INSERT INTO HISTORIAL_BITACORA  (" 
	query = query & " ID, "
	query = query & " INSPECTOR, "
	query = query & " FECHA, STATUS, USERDATE, ORDEN) "
	query = query & " VALUES ("
	query = query & ID & ","
	query = query & strNvl(INSPECTOR) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(ESTATUS) & ", GETDATE(), " & O & ")"
	response.write query
	'response.end
	

	Set ORs =oDB.EjecutaSql(query)
	
	query = "UPDATE BITACORAS SET ULT_INSPECCION =" & strNvl(FECHA)
	query = query & " WHERE ID = " & strNvl(ID)
	
	Set ORs =oDB.EjecutaSql(query)


	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	'Response.Write query
	Response.Write "</REGISTROS>"

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

%>

