<!--#include file="DBConn.asp" -->
<!--#include file="freeaspupload.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

Response.Expires = -1
Server.ScriptTimeout = 1600

CODIGO=UCASE(REQUEST("CODIGO"))
ID=UCASE(REQUEST("ID"))
RECURSO=REQUEST("RECURSO")
USUARIO=REQUEST("USUARIO")
EMPRESA=REQUEST("EMPRESA")
FAMILIA=REQUEST("FAMILIA")
NOMBRE=REQUEST("NOMBRE")
PRIN=REQUEST("PRIN")
IDENTIFICADOR=REQUEST("IDENTIFICADOR")
PATH=REQUEST("PATH")
SQL=UCASE(REQUEST("SQL"))
RESPONSABLE=UCASE(REQUEST("RESPONSABLE"))

select case RECURSO
	
	case "saveFile" 
	 	  saveFile() 
	
	case "uploadFile" 
	 	  uploadFile()
					
	case "delFile"
		  delFile()
	
	case "setPrin"
		  setPrin()
		  
	case "listArchivos"
	 	  listArchivos()
	
	case "listUbicaciones"
	 	  listUbicaciones()
		  
	case "listArchivosDS"
	 	  ListArchivosDS()
				
	case "NewArea"
		NewArea()
	
	case "runSql"
			runSql()
				
end select

function listUbicaciones()
	query = "SELECT CODIGO, DESCRIPCION FROM UBICACION "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listArchivos()

	query = "SELECT ID,  NOMBRE , EXT, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECH, RUTA,"
	query = query & " FAMILIA, IDENTIFICADOR, SIZE, EXT "
	query = query & " FROM ARCHIVOS "
	query = query & " WHERE FAMILIA = " & strNvl(FAMILIA)
	

	query = query & " AND IDENTIFICADOR = " & strNvl(IDENTIFICADOR)

	
	query = query & " ORDER BY FECHA DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value  & "</NOMBRE>"
	  Response.Write "<TIPO>" & ORs.Fields.Item(2).Value & "</TIPO>"
	  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
	  Response.Write "<RUTA>" & ORs.Fields.Item(4).Value & "</RUTA>"
	  Response.Write "<FAMILIA>" & ORs.Fields.Item(5).Value & "</FAMILIA>"
	  Response.Write "<IDENTIFICADOR>" & ORs.Fields.Item(6).Value & "</IDENTIFICADOR>"
	  Response.Write "<SIZE>" & ORs.Fields.Item(7).Value & " Bytes </SIZE>"
	'  Response.Write "<PRIN>" & ORs.Fields.Item(9).Value & "</PRIN>"
		
	  SELECT CASE  UCASE(ORs.Fields.Item(8).Value)
	  	CASE "XLS" 
			 Response.Write "<FILEIMAGE>images\excel.jpg</FILEIMAGE>"
		CASE  "PDF" 
	 		 Response.Write "<FILEIMAGE>images\pdf.jpg</FILEIMAGE>"
		CASE  "DOC" 
	 		 Response.Write "<FILEIMAGE>images\word.jpg</FILEIMAGE>"
	  	CASE  "PPT" 
	 		 Response.Write "<FILEIMAGE>images\ppt.jpg</FILEIMAGE>"
	    CASE ELSE
	  		 Response.Write "<FILEIMAGE>../files/" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE>"
	  END SELECT
	  
	  Response.Write "<FILEID>files/" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEID>"
	  Response.Write "<FILEPR>files/" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEPR>"
	  
	  Response.Write "<FILEIMAGE_LY>files/" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE_LY>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArchivosDS()

	query = "SELECT ID, NOMBRE, EXT, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECH, RUTA, FAMILIA, IDENTIFICADOR, SIZE, EXT "
	query = query & "FROM ARCHIVOS "
	query = query & " WHERE FAMILIA = " & strNvl(FAMILIA)
	
	If (LEN(IDENTIFICADOR)>0) Then
		query = query & " AND IDENTIFICADOR = " & strNvl(IDENTIFICADOR)
	Else
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS><ROW></ROW></REGISTROS>"
		exit function
	End If
	
	query = query & " ORDER BY FECHA DESC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
	  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "<TIPO>" & ORs.Fields.Item(2).Value & "</TIPO>"
	  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
	  Response.Write "<RUTA>" & ORs.Fields.Item(4).Value & "</RUTA>"
	  Response.Write "<FAMILIA>" & ORs.Fields.Item(5).Value & "</FAMILIA>"
	  Response.Write "<IDENTIFICADOR>" & ORs.Fields.Item(6).Value & "</IDENTIFICADOR>"
	  Response.Write "<SIZE>" & ORs.Fields.Item(7).Value & " Bytes </SIZE>"
	  
	  SELECT CASE  UCASE(ORs.Fields.Item(8).Value)
	  	CASE "XLS" 
			 Response.Write "<FILEIMAGE>images\excel.jpg</FILEIMAGE>"
		CASE  "PDF" 
	 		 Response.Write "<FILEIMAGE>images\pdf.jpg</FILEIMAGE>"
		CASE  "DOC" 
	 		 Response.Write "<FILEIMAGE>images\word.jpg</FILEIMAGE>"
	  	CASE  "PPT" 
	 		 Response.Write "<FILEIMAGE>images\ppt.jpg</FILEIMAGE>"
	    CASE ELSE
	  		 Response.Write "<FILEIMAGE>..\files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE>"
	  END SELECT
	  
	  Response.Write "<FILEID>files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEID>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function GetArchivo()
	query = "SELECT A.ID, A.NOMBRE, A.FECHA, A.SIZE, A.EXT "
	query = query & " FROM ARCHIVOS AS A "
	query = query & " WHERE A.FAMILIA=" & strNvl(FAMILIA)
	query = query & "       AND A.IDENTIFICADOR=" & strNvl(IDENTIFICADOR)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>" 
  		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</RESPONSABLE>" 
   		  Response.Write "<SIZE>" & ORs.Fields.Item(3).Value & "</SIZE>"
   		  Response.Write "<EXT>" & ORs.Fields.Item(4).Value & "</EXT>"
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
	query = query & " WHERE U.AREA = A.CODIGO AND U.ID=" & strNvl(USUARIO)
	
	Set ORs =oDB.EjecutaSql(query)

	If Not ORs.EOF Then
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & strNvl(USUARIO)
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



function delFile()

	query = "SELECT EXT FROM ARCHIVOS WHERE ID='" & ID & "'"
	Set ORs =oDB.EjecutaSql(query)
	fileName = ID & "." & oRs.Fields.Item(0).Value
	
	query = "DELETE FROM ARCHIVOS WHERE ID='" & ID & "'"
	
	Set ORs1 =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & query & "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
	Set fs = CreateObject("Scripting.FileSystemObject")
	ServerPath1 = Server.MapPath("..\files\" & fileName)
	
     fs.DeleteFile(ServerPath1) 

end function


function setPrin()

	IF PRIN ="true" then
			query = "UPDATE ARCHIVOS SET PRINCIPAL=1  WHERE ID='" & ID & "'"
	Else
			query = "UPDATE ARCHIVOS SET PRINCIPAL=NULL  WHERE ID='" & ID & "'"
	End If
	Set ORs1 =oDB.EjecutaSql(query)
		
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>" & query & "</ROW>"
	Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	

end function

function saveFile

  Dim uploadsDirVar
  Dim fileN
  
  uploadsDirVar = Server.MapPath("../files/") 
  Dim fileClass, Upload1, fileName, fileSize, ks, i, fileKey, resumen
	
	
    Set Upload1 = New FreeASPUpload
		Upload1.Save(uploadsDirVar)
		
	If Err.Number <> 0 Then Exit function
    SaveFile = ""
    ks = Upload1.UploadedFiles.keys
	
    If (UBound(ks) <> -1) then
	
       For each fileKey in Upload1.UploadedFiles.keys
		
		RESUMEN =  RESUMEN & _
		Upload1.UploadedFiles(fileKey).FileName & " " & Upload1.UploadedFiles(fileKey).Length & " Bytes </BR>"
	
		Set fileClass = Upload1.UploadedFiles(fileKey)
	
	   Next
    Else
		RESUMEN = "El nombre del archivo especificado no es valido."  & UBound(ks)
		
    End if
	
			
	
	
	Response.Write  RESUMEN
	Response.Write  "<style>body{background-color:#f4fafe;}</style>"
	Response.Write  "<BR><BR><BR><CENTER>"



	Response.Write  "<script>function ocultar(){"
	Response.Write  "parent.document.getElementById('boxDetAvisos').close();}</script>"
	Response.Write  "<input type='button' value='Aceptar' onclick='ocultar();' />"
	Response.Write  "</CENTER>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


function runSql()

	Set ORs =oDB.EjecutaSql(SQL & " ")
	If Not ORs.Eof Then
		str=ORs.GetString(,,"</td><td>","</td></tr><tr><td>","&nbsp;")
		Response.Write("<style>.normal9px{font-family:Verdana, Tahoma, Arial;font-size:9px;font-weight:normal;}</style>")
		Response.Write("<table border=1 width='100%' class=normal9px cellpadding='0' cellspacing='0'>")
		for each x in ORs.Fields
  			response.write("<th>" & ucase(x.name) & "</th>")
		next
		Response.write ("<tr><td>")
		Response.Write(str)
		Response.Write("</td></tr></table>")
	Else
		Response.Write("<style>.normal9px{font-family:Verdana, Tahoma, Arial;font-size:9px;font-weight:normal;}</style>")
		Response.Write("<table border=1 width='100%' class=normal9px cellpadding='0' cellspacing='0'>")
		Response.Write(ORs.status)
		Response.Write("</table>")
	End If

	Set ORs =oDB.EjecutaSql("SELECT @@rowcount AS 'Rows Returned'")
	If Not ORs.Eof Then
		str=ORs.GetString(,,"</td><td>","</td></tr><tr><td>","&nbsp;")
		Response.Write("<table border=1 width='100%' class=normal9px cellpadding='0' cellspacing='0'>")
		Response.write ("<tr><td>Rows Returned ")
		Response.Write(str)
		Response.Write("</td></tr></table>")
	Else
		Response.write ("Rows Returned 0")
	End If
	
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