<%@ LANGUAGE="VBSCRIPT" %>

<%
'####################################
'## Application:   Blue-Collar Productions
'## File Name:     igallery.asp (default.asp)
'## File Version:  i-Gallery
'## Notice:        This code has limited warranties. Please see http://www.b-cp.com for details.
'####################################
%>

<!--#INCLUDE FILE="include/globalsets.asp"-->
<!--#INCLUDE FILE="include/testenvironment.asp"-->
<!--#INCLUDE FILE="include/gfxSpex.inc"-->
<!--#INCLUDE FILE="include/filesize.inc"-->

<% 
Sub DisplayFileName(fn)
strFolderName 		= ""&fn.Name&""
strFolderLocation 	= UploadPath&"\"&strFolderName&"/"
Set F1  = FSO.GetFolder(strFolderLocation)
Set FC = F1.Files
On Error Resume Next
rpf 	= 1
rpr 	= 2
intPage = 0
i 		= 1
RecordsCount = 0
%>
<table width="120" cellspacing="1" cellpadding="2" border="0">
<tr>
<td align="center" nowrap>
<table style="cursor: hand;" onClick="location.href='folderview.asp?folder=<%= URLSpace(strfoldername) %>'" background="images/largefolder.gif" width="92" height="92" cellspacing="0" cellpadding="0" border="0">
<tr>
<td valign="middle" align="center">
<img src="images/spacer.gif" width="1" height="5" border="0"><br>
<table cellspacing="1" cellpadding="2" border="0">
<tr>
<%
For Each f1 in FC

If (RecordsCount >= (intPage * rpf)) And (RecordsCount < (intPage * rpf) + rpf) Then

If NOT InStr(f1, "tn-") > 0 Then ' Hide NON-Thumnails In View

ThumbPath 		= UploadPath&"\"&strFolderName&"\"&f1.Name

'##### Thumbnailer Call ######
If gfxSpex(ThumbPath, width, height, colors, strType) = true then
strwidth  = "92"
strheight = FormatNumber(strwidth*(height/width),0)
If strheight > 92 Then strheight = "92" Else strheight = strheight
If nailer Then
strURL = URLPath&"/"&strfoldername&"/tn-"&f1.Name
Else
strURL = URLPath&"/"&strfoldername&"/"&f1.Name
End If
strimagesrc = "<img src="""&strURL&""" width="""&strwidth&""" height="""&strheight&""" border=""0"">"
End If
'##### End Thumbnailer Call ######

If Not i Mod rpr = 0 Then
%>
<td align="center">
<%= strimagesrc %><br>
</td>
<% Else %>
<td align="center">
<%= strimagesrc %><br>
</td>
</tr>
<%
End if
End If	
RecordsCount = RecordsCount + 1	
i = i + 1
End If
Set Jpeg = Nothing
Next
%> 
</table>
</td>
</tr>
</table>
<img src="images/spacer.gif" width="1" height="3" border="0"><br>
<a class="linkxsm" href="folderview.asp?folder=<%= URLSpace(strfoldername) %>"><b><%= fn.name %></b></a><br>
</td>
</tr>
</table>
<% End Sub %>

<html>
<head>

<title>Lock Stock & Barrel - Production & Location Services</title>

<SCRIPT LANGUAGE="JAVASCRIPT" TYPE="text/javascript">
<!--
function confirmValidation(entered, alertbox) 
{
with (entered)
{
subjectlen = value.length;
if (subjectlen == "") {
if (alertbox) {alert(alertbox);} return false;}
else {return true;}
}
}
function formvalidation(thisform)
{
with (thisform)
{
if (confirmValidation(newfolder,"Please enter a value in the \"Create New Folder\" field!")==false) {newfolder.focus(); return false;};
}
}
//-->
</script>


<link rel="STYLESHEET" type="text/css" href="css/nn.css" disabled>
<script language="JavaScript1.2" type="text/javascript">
<!--
    if (document.all) document.createStyleSheet("css/ie.css");
//-->
</script>

<link rel="stylesheet" type="text/css" media="screen" href="../includes/nn4.css" />
<!--link before import prevents Flash Of Unstyled Content in ie6pc -->
<link href="../includes/css-styles.css" media="all" rel="stylesheet" type="text/css" />
</head>

<body>

<!--#include file="../includes/skiplinks.inc" -->

<div id="hidden">
<!--#include file="../includes/hidden.inc" -->
</div>

<div align="center">

<div id="header">
<!--#include file="../includes/header-gallery.inc" -->
</div>

<div id="page2">

<div id="galleries">

<table width="95%" cellspacing="0" cellpadding="0" border="0">
<tr>
<td height="24" bgcolor="#FFFFFF" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=<%= StartColor1 %>,endColorStr=<%= EndColor1 %>);" colspan="3">

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
<td>
</td>
<% If Session("userLevel") = "99" OR Session("userLevel") = "98" Then %>
<td style="padding-right: 6px;" align="right"><a href="../clients/"><img src="images/client.gif" width="14" height="14" border="0" alt="Client Area"></a>&nbsp;&nbsp;&nbsp;<a href="authorize.asp?l=O" onMouseOver="document.sbtnoff.src='images/sm-logoff2.gif'" onMouseOut="document.sbtnoff.src='images/sm-logoff1.gif'"><img name="sbtnoff" src="images/sm-logoff1.gif" width="14" height="14" border="0" alt="Log Off"></a></td>
<% Else %>
<td style="padding-right: 6px;" align="right"><a href="../clients/"><img src="images/client.gif" width="14" height="14" border="0" alt="Client Area"></a>&nbsp;&nbsp;&nbsp;<a href="login.asp?folder=<%= URLSpace(Request("folder")) %>&n=<%= Request.ServerVariables("SCRIPT_NAME") %>" onMouseOver="document.sbtnon.src='images/sm-logon2.gif'" onMouseOut="document.sbtnon.src='images/sm-logon1.gif'"><img name="sbtnon" src="images/sm-logon1.gif" width="14" height="14" border="0" alt="Log On"></a></td>
<% End If %>
</tr>
</table>

</td>
</tr>
</table>

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
<td style="padding-top:7px;" width="190" valign="top">

<!--#INCLUDE FILE="include/menu.asp"-->
<img src="images/spacer.gif" width=190 height=5 border=0 alt=""><br>

</td>

<td width="20" valign="top"><img src="images/spacer-bevel.gif" width=1 height=235 border=0 alt=""></td>
<td style="padding-left:10px;padding-top:15px;" width="560" valign="top">

<font class="text">

<table cellspacing="0" cellpadding="0" border="0">
<tr>
<td width="30"><img src="images/folder-closed.gif" width=27 height=27 border=0 alt=""></td>
<td><font class="largeheader">main folder</font></td>
</tr>
</table>

<img src="images/spacer.gif" width=10 height=5 border=0 alt=""><br>

<table cellspacing="0" cellpadding="0" border="0">
<tr>
<%
Set f = FSO.GetFolder(UploadPath)
Set FileList = f.subFolders
Set objFC  = f.Files

On Error Resume Next
fi 		= 1
count 	= 0
fpr = foldersperrow
For Each fn In FileList
emptyDir = False
If Not fi Mod fpr = 0 then
%>
<td align="center">
<% DisplayFileName(fn) %>
</td>
<td width="10">&nbsp;</td>
<% Else %>
<td align="center">
<% DisplayFileName(fn) %>
</td>
</tr>
<%
End If
fi = fi + 1
Next
%> 
</table>

<%
emptyDir = True
For Each fn In FileList
emptyDir = False
Next
If emptyDir Then
%>
<img src="images/spacer.gif" width=1 height=7 border=0 alt=""><br>
<%
If Session("userLevel") = "99" OR Session("userLevel") = "98" Then 
%>
<font class="text">Use the "Create New Folder" form to add your first sub-directory to your main i-Gallery folder.<br></font>
<% Else %>
<font class="text">There are currently no sub-folders within your main i-Gallery folder.&nbsp;&nbsp;To create a new folder you must first log-in.&nbsp;&nbsp;<a class="link" href="login.asp">Click Here</a> to log-in now.<br></font>
<% End If %>
<% End If %>

<%
set FSO 	= nothing
%>

<% If Session("userLevel") = "99" OR Session("userLevel") = "98" Then %>
<p>
<table style="filter:progid:DXImageTransform.Microsoft.Shadow(color='#a9a9a9', Direction=135, Strength=2);" align="center" bgcolor="gray" cellspacing="0" cellpadding="1" border="0">
<tr>
<td>
<table width="100%" cellspacing="0" cellpadding="3" border="0">
<tr>
<td bgcolor="#F7F7F7">
<table width="100%" cellspacing="0" cellpadding="1" border="0">
<form name="newdir" method="post" action="create.asp?mode=newfolder" onSubmit="return formvalidation(this)">
<input type="hidden" name="fsDir" value="<%= fsDir %>">
<tr>
<td colspan="2">
<table cellspacing="0" cellpadding="2" border="0">
<tr>
<td><img src="images/sm-folder.gif" width="16" height="14" border="0"></td>
<td class="textsm"><b>Create New Folder:</b></td>
</tr>
</table>
</tr>
<tr>
<td><font class="textsm"><input type="text" style="width: 150px;" size=12 name="newfolder" class="input"></td>
<td><font class="textsm"><input class="button" style="font-size: 8.5pt;" type="submit" value="Create"></td>
</tr></form>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<% End If %>

</font>

</td>
</tr>
</table>

<p>

</div>
</div>

<div id="footer">
<!--#include file="../includes/footer.inc" -->
</div>


</div>

</body>
</html>