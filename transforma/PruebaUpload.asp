<% 
option explicit
Response.Expires = -1
Server.ScriptTimeout = 600
%>
<!-- #include file="freeaspupload.asp" -->
<%
' ****************************************************
' Cambiar el valor de la siguiente variable
' para indicar el directorio de destino.
' El directorio indicado debe tener permisos de escritura
' de caso contrario el script fallará mostrando un error.
  Dim uploadsDirVar
   uploadsDirVar = Server.MapPath("/transforma/") 
  'uploadsDirVar = "C:\inetpub\Insight\ttminsight.cl\wwwroot\transforma" 
' ****************************************************
 Dim arch
function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey, resumen
    Set Upload = New FreeASPUpload
    Upload.Save(uploadsDirVar)
	' If something fails inside the script, but the exception is handled
	If Err.Number <> 0 then Exit function
    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
		resumen = "<B>Archivos subidos:</B> "
        for each fileKey in Upload.UploadedFiles.keys
			resumen = resumen & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
			arch = Upload.UploadedFiles(fileKey).FileName
        next
    else
		resumen = "El nombre del archivo especificado en el formulario no es valido en el sistema."
    end if
	'comentar la siguiente linea si no se desea mostrar el resumen
	SaveFiles = resumen
end function
%>

<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>Test Free ASP Upload</TITLE>



</HEAD>
<script language="javascript" type="text/javascript">
function bajar(archivo){
		window.open("OpenFile.asp?arch="+archivo);
}

</script>
<BODY>
<br>
<div style="border-bottom: #A91905 2px solid;font-size:16">Subir archivos</div>
<div style='margin-left:150'>

<form name="frmSend" method="POST" enctype="multipart/form-data" action="pruebaupload.asp">
Archivo 1: <input name="attach1" type="file" size="35"><br>
<br> 
<input type=submit value="Upload">
</form>

<BR></div>
    <%
    response.write ("<H1> Archivos ya subidos </H1>")
	Dim FileSysObj, strFileAndPath, strPathOnly, strFullPath, fldr, FileList, FileIndex
    set FileSysObj=CreateObject("Scripting.FileSystemObject")
    strFileAndPath = request.servervariables("SCRIPT_NAME")
    strPathOnly = Mid(strFileAndPath,1 ,InStrRev(strFileAndPath, "/"))
    strFullPath = server.mappath(strPathOnly)
    set fldr=FileSysObj.GetFolder(strFullPath)
    set FileList = fldr.Files
    For Each FileIndex in FileList
        'This bit excludes this page (and other asp files) from the list of links
        if Lcase(right(FileIndex.Name, 4)) <> ".asp" then
            Response.Write("<A HREF=javascript:bajar('" & FileIndex.name & "')>" & FileIndex.name & "</A><BR>")
        end if
    Next
    %>



<%
'solo llamo al UPLOAD si hay envio de formulario
if Request.ServerVariables("REQUEST_METHOD") = "POST" then
	'Hace el upload de los archivos enviados y muestra el resumen	
	response.write SaveFiles()
	if Err.Number = 0 then
		response.Write("<script type='text/javascript' language='javascript'>")
		response.Write("window.open('OpenFile.asp?arch="&arch&"');")
		response.Write("</script>")
	end if
end if
%>
</BODY>
</HTML>
