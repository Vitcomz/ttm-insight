<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
FOLIO=UCASE(REQUEST("FOLIO"))
VALOR=UCASE(REQUEST("VALOR"))
TIPO_EQUIPO=UCASE(REQUEST("TIPO_EQUIPO"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
FAENA = REQUEST("FAENA")
EQUIPO = REQUEST("EQUIPO")
FECHA = REQUEST("FECHA")
WIN=UCASE(REQUEST("WIN"))
COLOR = REQUEST("COLOR")

select case RECURSO
	case "ListCheck"
		ListCheck()
		
	case "NewCheck"
		NewCheck()
		
	
	CASE "NewCheckBitacora"
		NewCheckBitacora()
		
	case "DelCheck"
		DelCheck()
		
	case "DelCheckBitacora"
		DelCheckBitacora()
		
	case "ListCheckDesc"
		ListCheckDesc()

	case "UpdCheckBitacora"
		UpdCheckBitacora()
		
	case "Listafallas"
		Listafallas()
		
	case "ListCheckBitacora"
		ListCheckBitacora()
				
		
end select

function ListCheck()

	xFaena = replace(Faena, "~", "','")
	xfan = Split(Faena, "~") 

	query = "SELECT CHK.ID, CHK.DESCRIPCION, CHK_E.BITACORA , CHK_E.VALOR, TIPO_EQUIPO, B.UBICACION "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " INNER JOIN CHECK_EQUIPOS AS CHK_E ON "
	query = query & " 		 CHK.ID = CHK_E.CHECKLIST  INNER JOIN BITACORAS AS B ON CHK_E.BITACORA = B.ID "
	query = query & " WHERE B.UBICACION in (" & strNvl(xFaena) & ")"
	query = query & " ORDER BY B.UBICACION, ID"
	 
	'response.write query
	'response.end
	 
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.AddHeader "Content-Type", "text/xml; charset=utf-8"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<BITACORA>" & ORs.Fields.Item(2).Value & "</BITACORA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(4).Value & "</TIPO_EQUIPO>"
		  Response.Write "<FAENA>" & ORs.Fields.Item(5).Value & "</FAENA>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewCheck()

	query = "SELECT MAX(ID) AS NUM FROM CHECKLIST "
	query = query & "WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	Set ORs =oDB.EjecutaSql(query)
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO CHECKLIST (" 
	query = query & " ID, "
	query = query & " TIPO_EQUIPO, "
	query = query & " DESCRIPCION) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & TIPO_EQUIPO & ","
	query = query & strNvl(DESCRIPCION) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function NewCheckBitacora()

	query = "INSERT INTO CHECK_EQUIPOS (" 
	query = query & " BITACORA, "
	query = query & " CHECKLIST, VALOR) "
	query = query & " VALUES ("
	query = query & strNvl(FOLIO) & ","
	query = query & strNvl(ID) & ","
	query = query & strNvl(VALOR) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function DelCheck()
	query = "DELETE CHECKLIST WHERE ID = " & ID & " AND TIPO_EQUIPO= " & TIPO_EQUIPO
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelCheckBitacora()

	query = "DELETE CHECK_EQUIPOS WHERE BITACORA = " & ID & " "
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function
'---adding----------
function ListCheckDesc()
	query = "SELECT distinct CHK.ID, CHK.DESCRIPCION, CHK_T.DESCRIPCION, CHK_T.CODIGO"
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " LEFT OUTER JOIN CHECK_EQUIPOS AS CHK_E ON "
	query = query & " CHK.ID = CHK_E.CHECKLIST "
	query = query & " LEFT OUTER JOIN TIPO_EQUIPOS AS CHK_T "
	query = query & " ON CHK.TIPO_EQUIPO = CHK_T.CODIGO "
	query = query & " ORDER BY ID" 
	Set ORs =oDB.EjecutaSql(query)
	Response.AddHeader "Content-Type", "text/xml; charset=utf-8"
	'Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
'		  Response.Write "<BITACORA>" & ORs.Fields.Item(2).Value & "</BITACORA>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(2).Value & "</TIPO>"
		  Response.Write "<CODTIPO>" & ORs.Fields.Item(3).Value & "</CODTIPO>"
'		  Response.Write "<FAENA>" & ORs.Fields.Item(4).Value & "</FAENA>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
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

function UpdCheckBitacora()

	query = "SELECT ID FROM BITACORAS "
	query = query & "WHERE UBICACION ='" & FAENA & "' AND EQUIPO ='" & EQUIPO & "' AND FECHA ='" & FECHA & "' AND COLOR ='" & COLOR & "'"
	Set ORs =oDB.EjecutaSql(query)
	If not ORs.eof Then
		FOLIO = ORs.Fields.Item(0).Value
	End If
	
	query = "SELECT BITACORA AS NUM FROM CHECK_EQUIPOS "
	query = query & "WHERE BITACORA='" & FOLIO & "'"

	Set ORs =oDB.EjecutaSql(query)
	If not ORs.eof Then
		N = 1
	Else
		N = 0
	End If

	if N = 0 then
		query = "INSERT INTO CHECK_EQUIPOS (" 
		query = query & " BITACORA, "
		query = query & " CHECKLIST, VALOR) "
		query = query & " VALUES ("
		query = query & strNvl(FOLIO) & ","
		query = query & strNvl(ID) & ","
		query = query & strNvl(VALOR) & ")"	
		Set ORs =oDB.EjecutaSql(query)
	else
		query = "UPDATE CHECK_EQUIPOS SET CHECKLIST =" & strNvl(ID)
		query = query & " , VALOR="  & strNvl(VALOR)
		query = query & " WHERE BITACORA = " & strNvl(FOLIO)
		Set ORs =oDB.EjecutaSql(query)
	end if
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function Listafallas()
	query = "SELECT CHK.ID, CHK.DESCRIPCION "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	query = query & " ORDER BY ID"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListCheckBitacora()

	xFaena = replace(Faena, "~", "','")
	xfan = Split(Faena, "~") 

	query = "SELECT dbo.CHECK_EQUIPOS.BITACORA, dbo.CHECK_EQUIPOS.CHECKLIST, dbo.CHECK_EQUIPOS.VALOR "
	query = query & " FROM dbo.CHECK_EQUIPOS INNER JOIN " 
	query = query & " dbo.BITACORAS ON dbo.CHECK_EQUIPOS.BITACORA = dbo.BITACORAS.ID "
	query = query & " WHERE UBICACION in (" & strNvl(xFaena) & ")"
	
	'response.write query
	'response.end
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.AddHeader "Content-Type", "text/xml; charset=iso-8859-1"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<BITACORA>" & ORs.Fields.Item(0).Value & "</BITACORA>"
		  Response.Write "<CHECKLIST>" & ORs.Fields.Item(1).Value & "</CHECKLIST>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
		  Response.Write "<OP></OP>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


if(WIN = "OK") then



	 Response.Write ("<html><body><script>setTimeout(function(){ window.close(); }, 700);</script></body></html>")
	 
end if

%>