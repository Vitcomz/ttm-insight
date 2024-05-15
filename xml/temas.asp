<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
FECHA=UCASE(REQUEST("FECHA"))
NOMBRE=REQUEST("NOMBRE")
DESCRIPCION=REQUEST("DESCRIPCION")
AUTOR=REQUEST("AUTOR")
ESTADO=UCASE(REQUEST("ESTADO"))
SUCURSAL=UCASE(REQUEST("SUCURSAL"))
CATEGORIA=UCASE(REQUEST("CATEGORIA"))


select case RECURSO
	case "getTema"
		  getTema()
		
	case "newTema"
		  newTema()
		
	case "updateTema"
		  updateTema()
		
	case "ListTemas"
		  ListTemas()
	
	
	
end select

function newTema()

	query = "SELECT MAX(ID) AS N FROM TEMAS "
	Set oRs =oDB.EjecutaSql(query)
	
	If Len(oRS("N"))>0 Then
		N = cint(oRS("N")) + 1
	Else
		N = 1
	End If
	
	
	query = "INSERT INTO TEMAS (ID, FECHA, NOMBRE, DESCRIPCION,  "
	query = query & " AUTOR, SUCURSAL, CATEGORIA, ESTADO) VALUES ("
	query = query & N & "," 
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(NOMBRE) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(AUTOR) & ","
	query = query & strNvl(SUCURSAL) & ","
	query = query & strNvl(CATEGORIA) & ","
	query = query & strNvl(ESTADO) & ");"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & N  & "</ID>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
end function

function ListTemas()

	query = "SELECT T.ID,CONVERT(VARCHAR,T.FECHA,103), T.NOMBRE, T.DESCRIPCION, T.AUTOR, T.SUCURSAL, A.ID, A.EXT  "
	query = query & " FROM TEMAS AS T "
	query = query & " LEFT OUTER JOIN ARCHIVOS AS A  ON FAMILIA='TEMAS' AND RTRIM(LTRIM(STR(T.ID)))=A.IDENTIFICADOR"
	query = query & " WHERE CATEGORIA = " & strNvl(CATEGORIA)
	

	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(3).Value & "</DESCRIPCION>"
   		  Response.Write "<AUTOR>" & ORs.Fields.Item(4).Value & "</AUTOR>"
		  Response.Write "<SUCURSAL>" & ORs.Fields.Item(5).Value & "</SUCURSAL>"
	 	  SELECT CASE  UCASE(ORs.Fields.Item(7).Value)
			CASE "XLS" 
			 Response.Write "<FILEIMAGE>sgm\images\excel.jpg</FILEIMAGE>"
			CASE  "PDF" 
	 		 Response.Write "<FILEIMAGE>sgm\images\pdf.jpg</FILEIMAGE>"
			CASE  "DOC" 
	 		 Response.Write "<FILEIMAGE>sgm\images\word.jpg</FILEIMAGE>"
	  		CASE  "PPT" 
	 		 Response.Write "<FILEIMAGE>sgm\images\ppt.jpg</FILEIMAGE>"
	    	CASE ELSE
	  		 Response.Write "<FILEIMAGE>sgm\Files\" & ORs.Fields.Item(6).Value & "." & ORs.Fields.Item(7).Value & "</FILEIMAGE>"
	 	  END SELECT
		  Response.Write "<FILEID>sgm\Files\" & ORs.Fields.Item(6).Value & "." & ORs.Fields.Item(7).Value & "</FILEID>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	'Response.Write "<sql>" & query & "</sql>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function




function getTema()

	query = "SELECT ID,"
	query = query & "RTRIM(CONVERT(CHAR,FECHA,103)) ,"
	query = query & " NOMBRE,"
	query = query & " DESCRIPCION,"
	query = query & " AUTOR,"
	query = query & " SUCURSAL,"
	query = query & " ESTADO, CATEGORIA  "
	query = query & " FROM TEMAS "
	query = query & " WHERE ID=" & ID 

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
  		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(3).Value & "</DESCRIPCION>"
   		  Response.Write "<AUTOR>" & ORs.Fields.Item(4).Value & "</AUTOR>"
  		  Response.Write "<SUCURSAL>" & ORs.Fields.Item(5).Value & "</SUCURSAL>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(6).Value & "</ESTADO>"
		  Response.Write "<CATEGORIA>" & ORs.Fields.Item(7).Value & "</CATEGORIA>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updateTema()

	query = "UPDATE TEMAS SET FECHA = " & strNvl(FECHA) & ","
	query = query & "AUTOR=" & strNvl(AUTOR) & ","
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "NOMBRE=" & strNvl(NOMBRE) & ","
	query = query & "SUCURSAL=" & strNvl(SUCURSAL) & ","
	query = query & "CATEGORIA=" & strNvl(CATEGORIA) & ","
	query = query & "ESTADO=" & strNvl(ESTADO) & ""
	query = query & " WHERE ID=" & ID 
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
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

function ListNaves()

	query = "SELECT FLD_COD_NAVE, replace(FLD_DES_NAVE,'&',' ') FROM T_Nave "
	query = query & "WHERE Upper(FLD_DES_NAVE) LIKE '%" & UCASE(STR) & "%'"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(0).Value & "</NOMBRE>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelInsumo()
	query = "DELETE FROM INSUMOS WHERE CODIGO='" & CODIGO & "' "
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

