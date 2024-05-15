<!--#include file="../standard/DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

CODIGO=UCASE(REQUEST("CODIGO"))
RECURSO=REQUEST("RECURSO")
USUARIO=REQUEST("USUARIO")
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
RESPONSABLE=UCASE(REQUEST("RESPONSABLE"))

select case RECURSO

	case "GetArea" 
	 	GetArea() 
		
	case "GetAreaUsuario" 
	 	GetAreaUsuario() 
		
	case "UpdateResponsable" 
	 	UpdateResponsable()
		
	case "DelArea"
		DelArea()
		
	case "ListAreas"
	 	ListAreas()

	case "ListFuncionarios"
	 	ListFuncionarios()
				
	case "NewArea"
		NewArea()
end select


function ListAreas()
	query = "SELECT CODIGO, DESCRIPCION, RESPONSABLE FROM AREAS "
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  	  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function ListFuncionarios()

	query = "SELECT ID, NOMBRES, APELLIDOS FROM USUARIOS "
	query = query & " WHERE AREA="	& CODIGO
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & " " & _
	  					ORs.Fields.Item(2).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function GetArea()
	query = "SELECT A.CODIGO, A.DESCRIPCION, A.RESPONSABLE, U.NOMBRES, U.APELLIDOS, U.E_MAIL "
	query = query & " FROM AREAS AS A "
	query = query & " LEFT OUTER JOIN USUARIOS AS U ON A.RESPONSABLE = U.ID "
	query = query & " WHERE A.CODIGO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>" 
  		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>" 
   		  Response.Write "<NOMBRE>" & ORs.Fields.Item(3).Value & " " &_
									 ORs.Fields.Item(4).Value &   "</NOMBRE>" 
   		  Response.Write "<E_MAIL>" & ORs.Fields.Item(5).Value & "</E_MAIL>" 
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetAreaUsuario()
	query = "SELECT A.CODIGO, A.DESCRIPCION, A.RESPONSABLE, U.NOMBRES, U.APELLIDOS, U.E_MAIL, U.ID "
	query = query & " FROM AREAS AS A "
	query = query & " ,USUARIOS AS U  "
	query = query & " WHERE U.AREA = A.CODIGO AND LTRIM(RTRIM(U.ID))=" & strNvl(USUARIO)
	
	Set ORs =oDB.EjecutaSql(query)

	If Not ORs.EOF Then
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<AREA>" & ORs.Fields.Item(1).Value & "</AREA>" 
  		  Response.Write "<AUTORIZA>" & ORs.Fields.Item(2).Value & "</AUTORIZA>" 
   		  Response.Write "<NOMBRE>" & ORs.Fields.Item(3).Value & " " &_
									 ORs.Fields.Item(4).Value &   "</NOMBRE>" 
   		  Response.Write "<E_MAIL>" & ORs.Fields.Item(5).Value & "</E_MAIL>" 
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>" 
	  Response.Write "</ROW>"
	 Response.Write "</REGISTROS>"
	ELSE
	Response.Write query
	End If
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateResponsable()
	query = "UPDATE AREAS SET RESPONSABLE = " & strNvl(RESPONSABLE)
	query = query  & " WHERE CODIGO = " & CODIGO & ""
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InsertRol()

	query = "INSERT INTO ROLES (ID, NOMBRE) VALUES ('" & ID & "','" & NOMBRE & "')"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewArea()

	query = "SELECT MAX(CODIGO) AS NUM FROM AREAS "
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO AREAS (CODIGO, DESCRIPCION) VALUES (" & N & "," & strNvl(DESCRIPCION) & ")"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelRol()

	query = "DELETE FROM ROLES WHERE ID='" & ID & " ' "
	Set ORs =oDB.EjecutaSql(query)
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

