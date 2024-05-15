<!--#include file="../standard/DBConn.asp" -->
<!-- #include file="../upload/freeaspupload.asp" -->
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
IDENTIFICADOR=REQUEST("IDENTIFICADOR")
PATH=REQUEST("PATH")
SQL=UCASE(REQUEST("SQL"))
RESPONSABLE=UCASE(REQUEST("RESPONSABLE"))
FAENA = REQUEST("FAENA")
TIPO=UCASE(REQUEST("TIPO"))
FECHA=UCASE(REQUEST("FECHA"))
SIZE=UCASE(REQUEST("SIZE"))
FILEIMAGE=UCASE(REQUEST("FILEIMAGE"))

select case RECURSO

	case "GetArchivo" 
	 	GetArea() 
		
	case "SaveFile" 
	 	SaveFile() 
	
	case "uploadFile" 
	 	  uploadFile()
					
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

	case "NewArchivo" 
	 	NewArchivo() 
			
				
end select

function ListArchivos()

	query = "SELECT     dbo.ARCHIVOS.ID, dbo.ARCHIVOS.NOMBRE, dbo.ARCHIVOS.EXT, RTRIM(CONVERT(CHAR, dbo.ARCHIVOS.FECHA, 103)) AS FECH, dbo.ARCHIVOS.RUTA, dbo.ARCHIVOS.FAMILIA, dbo.ARCHIVOS.IDENTIFICADOR, dbo.ARCHIVOS.SIZE, dbo.ARCHIVOS.EXT AS Expr1 "
	query = query & " FROM dbo.ARCHIVOS INNER JOIN dbo.BITACORAS ON dbo.ARCHIVOS.IDENTIFICADOR = dbo.BITACORAS.ID "
	query = query & " WHERE FAMILIA = 'BITACORAS' and  dbo.BITACORAS.UBICACION = " & strNvl(FAENA)
	query = query & " ORDER BY dbo.ARCHIVOS.ID DESC"

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
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
	  	CASE "XLSX" 
			 Response.Write "<FILEIMAGE>images\excel.jpg</FILEIMAGE>"
		CASE  "PDF" 
	 		 Response.Write "<FILEIMAGE>images\pdf.jpg</FILEIMAGE>"
		CASE  "DOC" 
	 		 Response.Write "<FILEIMAGE>images\word.jpg</FILEIMAGE>"
		CASE  "DOCX" 
	 		 Response.Write "<FILEIMAGE>images\word.jpg</FILEIMAGE>"
	  	CASE  "PPT" 
	 		 Response.Write "<FILEIMAGE>images\ppt.jpg</FILEIMAGE>"
	  	CASE  "PPTX" 
	 		 Response.Write "<FILEIMAGE>images\ppt.jpg</FILEIMAGE>"
	  	CASE  "TXT" 
	 		 Response.Write "<FILEIMAGE>images\txt.png</FILEIMAGE>"
	    CASE ELSE
	  		 Response.Write "<FILEIMAGE>Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE>"
	  END SELECT
	  
	  Response.Write "<FILEID>Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEID>"
	  
	  Response.Write "<FILEIMAGE_LY>Files\" & ORs.Fields.Item(0).Value & "." & ORs.Fields.Item(8).Value & "</FILEIMAGE_LY>"
	  Response.Write "<OP></OP>"
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
	
	query = query & " ORDER BY ID DESC"
	
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

	query1 = "SELECT EXT FROM ARCHIVOS WHERE ID='" & ID & "'"
	Set ORs =oDB.EjecutaSql(query1)
	fileName = ID & "." & oRs.Fields.Item(0).Value
	
	query2 = "DELETE FROM ARCHIVOS WHERE ID='" & ID & "'"
	
	Set ORs =oDB.EjecutaSql(query2)
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

			If Upload.UploadedFiles(fileKey).Length<2300000 then
				Set fileClass = Upload.UploadedFiles(fileKey)
			Else
				Response.Write  "El archivo es demasiado grande " & Upload.UploadedFiles(fileKey).Length & ", el maximo permitido es 1MB."
				Response.Write  "</CENTER>"
				Exit Function
			End If
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
'	Response.Write  "<input type='button' value='Aceptar'  class='input' onclick='ocultar('"& strNvl(uploadsDirVar)&"','"&now()&"');' />"	



	Response.Write  "<script>window.parent.location.reload(true);</script>"	
	Response.Write  "<script>alert('Archivo Ingresado');</script>"
	Response.Write  "</CENTER>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function uploadFile

  Dim uploadsDirVar
  uploadsDirVar = Server.MapPath(PATH) 
  Dim fileClass, Upload, fileName, fileSize, ks, i, fileKey, resumen
	
	
    Set Upload = New FreeASPUpload
	 
    Upload.Save(uploadsDirVar)
	
	If Err.Number <> 0 then Exit function
    uploadFile = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        for each fileKey in Upload.UploadedFiles.keys
			RESUMEN =  Upload.UploadedFiles(fileKey).FileName & " " & Upload.UploadedFiles(fileKey).Length & " Bytes "
			Set fileClass = Upload.UploadedFiles(fileKey)
        next
    else
		RESUMEN = "El nombre del archivo especificado no es valido."
    end if
	
			
	
	
	Response.Write  RESUMEN
	Response.Write  "<BR><BR><BR>"
	Response.Write  "<script>"
	Response.Write  "function volver(){document.location.href='../upload.html'}"
	Response.Write  "</script>"
	Response.Write  "<input type='button' value='Volver' onclick='volver();' />"
	Response.Write  ""
	
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

function NewArchivo

	query = "SELECT MAX(ID) AS NUM FROM ARCHIVOS "
	
	Set ORs =oDB.EjecutaSql(query)	
		
	If Not ORs.Eof Then
		
		 N =oRS("NUM") + 1
	Else
		 N = 1
	End If
	
	query = "INSERT INTO ARCHIVOS (ID, NOMBRE, TIPO, SIZE, FECHA, RUTA, FAMILIA, EXT, IDENTIFICADOR) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & strNvl(NOMBRE) & ","
	query = query & "image/jpeg,"
	query = query & strNvl(SIZE) & ","
	query = query & strNvl(FECHA) & ","
	query = query & strNvl(PATH) & ","
	query = query & strNvl(FAMILIA) & ","
	query = query & strNvl(TIPO) & ","
	query = query & strNvl(IDENTIFICADOR) & ")"
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ID>" & N  & "</ID>"
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