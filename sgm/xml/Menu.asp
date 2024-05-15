<!--#include file="../standard/DBConn.asp" -->
<%

Dim oDB, ORs
Set oDB = New DBConn
Dim query, CODIGO 

RECURSO=REQUEST("RECURSO")
CODIGO=UCASE(REQUEST("CODIGO"))
SISTEMA=UCASE(REQUEST("SISTEMA"))
ROL=UCASE(REQUEST("ROL"))
COD_MENU_PADRE=UCASE(REQUEST("COD_MENU_PADRE"))
NOMBRE=REQUEST("NOMBRE")
LINK=REQUEST("LINK")
TARGET=REQUEST("TARGET")
ORDEN=REQUEST("ORDEN")
USERNAME=REQUEST("USERNAME")
USERDATE=REQUEST("USERDATE")
	
select case RECURSO
	case "DelMenu"
		DelMenu()

	case "DelMenuRol"
		DelMenuRol()
		
	case "UpdateMenu"
		UpdateMenu()
		
	case "NewMenu"
		NewMenu()

	case "NewMenuRol"
		NewMenuRol()
		
	case "GetMenu"
		GetMenu()
		
	case "ListMenu"
		ListMenu()
		
	case "ListMenuxRol"
		ListMenuxRol()
		
	case "ListSubMenu"
		ListSubMenu()

	case "ListMenuPrincipal"
		ListMenuPrincipal()
		
end select

function ListMenu()
	query = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE, ORDEN "
	query = query & " FROM MENU WHERE SISTEMA='" & SISTEMA & "'"
	query = query & "  ORDER BY ORDEN"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<COD_MENU_PADRE>" & ORs.Fields.Item(1).Value & "</COD_MENU_PADRE>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<LINK>" & ORs.Fields.Item(3).Value & "</LINK>"
		  Response.Write "<TARGET>" & ORs.Fields.Item(4).Value & "</TARGET>"
		  Response.Write "<SISTEMA>" & ORs.Fields.Item(5).Value & "</SISTEMA>"
		  Response.Write "<USERNAME>" & ORs.Fields.Item(6).Value & "</USERNAME>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>" 
  		  Response.Write "<ORDEN>" & ORs.Fields.Item(8).Value & "</ORDEN>" 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListMenuxRol()


	query = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE,"
	query = query & "LINK, TARGET, M.SISTEMA, MR.COD_ROL, M.ORDEN "
	query = query & "FROM MENU AS M INNER JOIN MENUROL AS MR "
	query = query & "	ON M.CODIGO = COD_MENU "
	query = query & "WHERE M.SISTEMA=" & strNvl(SISTEMA)
	query = query & "	 AND COD_ROL=" & strNvl(ROL)
	query = query & "    AND MR.SISTEMA=" & strNvl(SISTEMA)
	query = query & " ORDER BY M.ORDEN"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<COD_MENU_PADRE>" & ORs.Fields.Item(1).Value & "</COD_MENU_PADRE>"
  		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<LINK>" & ORs.Fields.Item(3).Value & "</LINK>"
		  Response.Write "<TARGET>" & ORs.Fields.Item(4).Value & "</TARGET>"
  		  Response.Write "<SISTEMA>" & ORs.Fields.Item(5).Value & "</SISTEMA>"
		  Response.Write "<COD_ROL>" & ORs.Fields.Item(6).Value & "</COD_ROL>"
  		  Response.Write "<ORDEN>" & ORs.Fields.Item(7).Value & "</ORDEN>" 

	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListSubMenu()

	 query = "SELECT M.CODIGO, COD_MENU_PADRE, NOMBRE, LINK,"
	 query = query & "TARGET, M.SISTEMA, MR.COD_ROL, ORDEN "
	 query = query & "FROM MENU AS M  LEFT OUTER JOIN MENUROL AS MR "
	 query = query & "ON M.CODIGO = MR.COD_MENU AND COD_ROL=" & strNvl(ROL) 
 	 query = query & " AND MR.SISTEMA=" & strNvl(SISTEMA) 
 	 query = query & "	WHERE M.SISTEMA=" & strNvl(SISTEMA)
	 
	If strNvl(COD_MENU_PADRE)<>"NULL" Then
		query = query & "  AND RTRIM(COD_MENU_PADRE)=" & strNvl(COD_MENU_PADRE)
	Else 
		query = query & "  AND RTRIM(COD_MENU_PADRE)=''"
	End If
	
	query = query & "  ORDER BY ORDEN"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<COD_MENU_PADRE>" & ORs.Fields.Item(1).Value & "</COD_MENU_PADRE>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<LINK>" & ORs.Fields.Item(3).Value & "</LINK>"
		  Response.Write "<TARGET>" & ORs.Fields.Item(4).Value & "</TARGET>"
		  Response.Write "<SISTEMA>" & ORs.Fields.Item(5).Value & "</SISTEMA>"
			IF LEN(ORs.Fields.Item(6).Value)>0 THEN
			  	Response.Write "<ROL>TRUE</ROL>"
			ELSE
			 	Response.Write "<ROL>FALSE</ROL>"
			END IF
  		  Response.Write "<ORDEN>" & ORs.Fields.Item(7).Value & "</ORDEN>" 
	  Response.Write "</ROW>"
	  ORs.MoveNext 
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListMenuPrincipal()
	query = "SELECT CODIGO, NOMBRE"
	query = query & " FROM MENU AS M, (SELECT DISTINCT COD_MENU_PADRE"
	query = query & " FROM MENU WHERE SISTEMA =" & strNvl(SISTEMA) & ") AS M2"
	query = query & " WHERE M.CODIGO	= M2.COD_MENU_PADRE "
	query = query & " AND M.SISTEMA=" & strNvl(SISTEMA) 
	
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

function DelMenu()

	query = "DELETE FROM MENU WHERE CODIGO='" & CODIGO & "'"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf 
	Response.Write "<REGISTROS>"
	Response.Write "		<R>OK</R>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetMenu()
	query = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE, ORDEN " 
	query = query & "FROM MENU WHERE CODIGO='" & CODIGO & "'"

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<COD_MENU_PADRE>" & ORs.Fields.Item(1).Value & "</COD_MENU_PADRE>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<LINK>" & ORs.Fields.Item(3).Value & "</LINK>"
		  Response.Write "<TARGET>" & ORs.Fields.Item(4).Value & "</TARGET>"
		  Response.Write "<SISTEMA>" & ORs.Fields.Item(5).Value & "</SISTEMA>"
		  Response.Write "<USERNAME>" & ORs.Fields.Item(6).Value & "</USERNAME>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>" 
  		  Response.Write "<ORDEN>" & ORs.Fields.Item(8).Value & "</ORDEN>" 
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewMenu()

	Dim MaxOrden 
	
	Sql = "SELECT MAX(ORDEN) AS MAXORDEN FROM MENU WHERE COD_MENU_PADRE='" & COD_MENU_PADRE & "'"
	
	Set ORs =oDB.EjecutaSql(Sql)
	
	If Len(oRS("MAXORDEN"))>0 Then
		MaxOrden = ORs("MAXORDEN") + 1
	Else
		MaxOrden = 1
	End if
	
	query = "INSERT INTO MENU (CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, ORDEN, USERNAME, USERDATE) VALUES ('"
	query = query & CODIGO & "','" & COD_MENU_PADRE & " ','" & NOMBRE & " ','" & LINK & " ','" 
	query = query & TARGET &" ','" & SISTEMA & "'," & MaxOrden & ",'" & USERNAME & "', getdate());"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewMenuRol()

	query = "INSERT INTO MENUROL (COD_MENU, COD_ROL, SISTEMA) VALUES ("
	query = query & strNvl(CODIGO) & "," & strNvl(ROL) & "," & strNvl(SISTEMA) & ");"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelMenuRol()

	query = "DELETE MENUROL WHERE "
	query = query & " COD_MENU=" & strNvl(CODIGO)
	query = query & " AND COD_ROL=" & strNvl(ROL)
	query = query & " AND SISTEMA =" & strNvl(SISTEMA) & ";"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateMenu()
	query = "UPDATE MENU SET "
	query = query & "COD_MENU_PADRE='" & COD_MENU_PADRE & " ',"
	query = query & "NOMBRE='" & NOMBRE & " ',"
	query = query & "LINK='" & LINK & " ',"
	query = query & "TARGET='" & TARGET & " ',"
	query = query & "USERNAME='DESARROLLO',"
	query = query & "USERDATE=getdate()"
	If Len(ORDEN) <> 0 Then  query = query & ",ORDEN = " & ORDEN & " " End If
	query = query & "WHERE CODIGO='" & CODIGO & "' AND SISTEMA='" & SISTEMA & "'"
	
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

