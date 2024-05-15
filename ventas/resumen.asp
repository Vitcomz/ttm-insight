<% 
Response.Expires = -1
Server.ScriptTimeout = 600
%>
n
<!-- #include file="xml/archivos.asp" -->
<%


function SaveFiles

empresa = Request.QueryString("empresa")
  Dim uploadsDirVar
  uploadsDirVar = Server.MapPath("/Files/" & empresa) 
  
 
    Dim fileClass, Upload, fileName, fileSize, ks, i, fileKey, resumen
	
    Set Upload = New FreeASPUpload
    Upload.Save(uploadsDirVar)
	
	If Err.Number <> 0 then Exit function
    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
		resumen = "<BR> "
        for each fileKey in Upload.UploadedFiles.keys
			resumen = resumen & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & " Bytes) "
			Set fileClass = Upload.UploadedFiles(fileKey)
        next
    else
		resumen = "El nombre del archivo especificado no es valido."
    end if
	
	
	X = InsertFile (fileClass.FileName, fileClass.ContentType, fileClass.Length, uploadsDirVar,  empresa)
	SaveFiles = resumen
	
end function



%>

<HTML>
<HEAD>
<TITLE>Vitcomz Upload</TITLE>
		<link rel="stylesheet" href="standard/menu.css" type="text/css">



		<script language="JavaScript1.2" src="standard/coolmenus4.js"></script>
</HEAD>
<link rel="stylesheet" href="sci.css" type="text/css">
<BODY>	
	<script language="JavaScript1.2" src="standard/menudata.js"></script>
	<BR>
	<BR>
<div  class="titulo" style="border-bottom: #A91905 2px solid;font-size:16">Subir archivos</div>
<div style='margin-left:50'>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="resumen.asp">
 <font class="texto"> Resumen  Archivo : </font>
 <%
if Request.ServerVariables("REQUEST_METHOD") = "POST" then
	response.write SaveFiles()
end if
%>
<br>
<br> 
<input type=button class="botonBlanco" value="Cerrar" onClick="location.href='listArchivos.html'">
</form>

<BR></div>

</BODY>
</HTML>
