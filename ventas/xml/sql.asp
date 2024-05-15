<!--#include file="../standard/DBConnExist.asp" -->
<!-- #include file="../upload/freeaspupload.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

Response.Expires = -1
Server.ScriptTimeout = 600


CODIGO=UCASE(REQUEST("CODIGO"))
ID=UCASE(REQUEST("ID"))
RECURSO=REQUEST("RECURSO")
USUARIO=REQUEST("USUARIO")
EMPRESA=REQUEST("EMPRESA")
FAMILIA=REQUEST("FAMILIA")
SQL=REQUEST("SQL")
IDENTIFICADOR=REQUEST("IDENTIFICADOR")
PATH=REQUEST("PATH")
RESPONSABLE=UCASE(REQUEST("RESPONSABLE"))

select case RECURSO

	case "GetArchivo" 
	 		GetArea() 
		
	case "SaveFile" 
	 		SaveFile() 
				
	case "delFile"
			delFile()
		
	case "listArchivos"
	 		ListArchivos()
	
	case "listArchivosDS"
	 		ListArchivosDS()
				
	case "NewArea"
			NewArea()
	
	case "runSql"
			runSql()	
end select

function ListArchivos()

	query = "SELECT ID, NOMBRE, EXT, RTRIM(CONVERT(CHAR,FECHA,103)) AS FECH, RUTA, FAMILIA, IDENTIFICADOR, SIZE, EXT "
	query = query & "FROM ARCHIVOS "
	query = query & " WHERE FAMILIA = " & strNvl(FAMILIA)
	
	If (LEN(IDENTIFICADOR)>0) Then
		query = query & " AND IDENTIFICADOR = " & strNvl(IDENTIFICADOR)
	End If
	
	query = query & " ORDER BY FECHA DESC"
	
	Set ORs =oDB.EjecutaSql(query)
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
	  		 Response.Write "<FILEIMAGE>Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE>"
	  END SELECT
	  
	  Response.Write "<FILEID>Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEID>"
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
	End If
	
	query = query & " ORDER BY FECHA DESC"
	
	Set ORs =oDB.EjecutaSql(query)
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
	  		 Response.Write "<FILEIMAGE>..\Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE>"
	  END SELECT
	  
	  Response.Write "<FILEID>Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEID>"
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
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
	Set fs = CreateObject("Scripting.FileSystemObject")
	ServerPath1 = Server.MapPath("..\Files\" & fileName)
	
     fs.DeleteFile(ServerPath1) 

end function


function SaveFile

  Dim uploadsDirVar
  uploadsDirVar = Server.MapPath("../Files/") 
  Dim fileClass, Upload, fileName, fileSize, ks, i, fileKey, resumen
	
	query = "SELECT MAX(ID) AS NUM FROM ARCHIVOS "
	
	Set ORs =oDB.EjecutaSql(query)	
		
	If Not ORs.Eof Then
		
		 N =oRS("NUM") + 1
	Else
		 N = 1
	End If
	
    Set Upload = New FreeASPUpload
	
	Upload.fileName_ = N 
    Upload.Save(uploadsDirVar)
	
	If Err.Number <> 0 then Exit function
    SaveFile = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        for each fileKey in Upload.UploadedFiles.keys
			RESUMEN =  Upload.UploadedFiles(fileKey).FileName & " " & Upload.UploadedFiles(fileKey).Length & " Bytes "
			Set fileClass = Upload.UploadedFiles(fileKey)
        next
    else
		RESUMEN = "El nombre del archivo especificado no es valido."
    end if
	
			
	query = "INSERT INTO ARCHIVOS (ID, NOMBRE, TIPO, SIZE, FECHA, RUTA, FAMILIA, EXT, IDENTIFICADOR) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & strNvl(fileClass.FileName) & ","
	query = query & strNvl(fileClass.ContentType) & ","
	query = query & strNvl(fileClass.Length) & ","
	query = query & "getdate(),"
	query = query & strNvl(uploadsDirVar) & ","
	query = query & strNvl(FAMILIA) & ","
	query = query & strNvl(Upload.ext_) & ","
	query = query & strNvl(IDENTIFICADOR) & ")"
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write  RESUMEN
	Response.Write  "<BR><BR><BR><CENTER>"



	Response.Write  "<script>function ocultar(){parent.document.getElementById('divFiles').style.visibility = 'hidden';"
	Response.Write  "parent.document.getElementById('frameFiles').src='archivos.html';parent.listArchivos();}</script>"
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