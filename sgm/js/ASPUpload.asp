<%
'####################################
'## Application:   Free ASP Upload
'## File Name:     freeaspupload.asp
'## File Version:  None
'## NOTICE:        This code has limited warranties. For examples, documentation, and your own free copy, go to: http://www.freeaspupload.net.
'## PLEASE NOTE:   This code has been modified from its original version found at: http://www.freeaspupload.net.
'####################################
%>

<%
Class FreeASPUpload
Public UploadedFiles
Public FormElements
Public fileName_
Public ext_
	
Private VarArrayBinRequest
Private StreamRequest
Private uploadedYet

Private Sub Class_Initialize()
Set UploadedFiles 	= Server.CreateObject("Scripting.Dictionary")
Set FormElements 	= Server.CreateObject("Scripting.Dictionary")
Set StreamRequest 	= Server.CreateObject("ADODB.Stream")
StreamRequest.Type 	= 1
StreamRequest.Open
uploadedYet = false
End Sub

Private Sub Class_Terminate()
If IsObject(UploadedFiles) Then
UploadedFiles.RemoveAll()
Set UploadedFiles = Nothing
End If
If IsObject(FormElements) Then
FormElements.RemoveAll()
Set FormElements = Nothing
End If
StreamRequest.Close
Set StreamRequest = Nothing
End Sub

Public Property Get Form(sIndex)
Form = ""
If FormElements.Exists(LCase(sIndex)) Then Form = FormElements.Item(LCase(sIndex))
End Property

Public Property Get Files()
Files = UploadedFiles.Items
End Property

Private Function UploadExists(FileName)
Dim objFS
UploadExists = False
Set objFS = CreateObject("Scripting.FileSystemObject")
UploadExists = objFS.FileExists(FileName)
End Function

Private Function FormatImageSize(intFileSize)
const DecimalPlaces = 1
const FileSizeBytes = 1
const FileSizeKiloByte = 1024
const FileSizeMegaByte = 1048576
const FileSizeGigaByte = 1073741824
const FileSizeTeraByte = 1099511627776
Dim strFileSize, newFilesize
If (Int(intFileSize / FileSizeTeraByte) <> 0) Then
newFilesize = Round(intFileSize / FileSizeTeraByte, DecimalPlaces)
strFileSize = newFilesize & " TB"
ElseIf (Int(intFileSize / FileSizeGigaByte) <> 0) Then
newFilesize = Round(intFileSize / FileSizeGigaByte, DecimalPlaces)
strFileSize = newFilesize & " GB"
ElseIf (Int(intFileSize / FileSizeMegaByte) <> 0) Then
newFilesize = Round(intFileSize / FileSizeMegaByte, DecimalPlaces)
strFileSize = newFilesize & " MB"
ElseIf (Int(intFileSize / FileSizeKiloByte) <> 0) Then
newFilesize = Round(intFileSize / FileSizeKiloByte, DecimalPlaces)
strFileSize = newFilesize & " KB"
ElseIf (Int(intFileSize / FileSizeBytes) <> 0) Then
newFilesize = intFilesize
strFileSize = newFilesize & " Bytes"
ElseIf Int(intFileSize) = 0 Then
strFilesize = 0 & " Bytes"
End If
FormatImageSize = strFileSize
End Function

Private Function UploadSuccess()
Response.Write("<table cellspacing=""0"" cellpadding=""0"" border=""0"">")
Response.Write("<tr>")
Response.Write("<td><img src=""images/sm-checkmark.gif"" width=16 height=20 border=0></td>")
Response.Write("<td><font style=""color:green; font-weight:bold;"" class=""textmed"">&nbsp;Image Uploaded Successfully!</font></td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("<p>")
End Function

Private Function UploadFailure()
Response.Write("<table cellspacing=""0"" cellpadding=""0"" border=""0"">")
Response.Write("<tr>")
Response.Write("<td><img src=""images/sm-close.gif"" width=20 height=20 border=0></td>")
Response.Write("<td><font style=""color:#CC0000; font-weight:bold;"" class=""textmed"">&nbsp;Image Failed To Upload!</font></td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("<p>")
End Function

Private Function MakeThumb(imagepath, imagename)
Dim Jpeg, jPath, intWidth, intHeight
'On Error Resume Next

response.write NailerApp & " " & imagepath & "CARNET.jpg" 'imagename
NailerApp=1
Select Case NailerApp
Case 1 'ASPJpeg
Set Jpeg = Server.CreateObject("Persits.Jpeg")
jPath = imagepath & "CARNET.jpg"
Jpeg.Open jPath
Jpeg.Width = 120
Jpeg.Height = 120 * Jpeg.OriginalHeight / Jpeg.OriginalWidth
Jpeg.Save imagepath & "\tn-" & imagename
Case 2  'ASPImage
Set Jpeg = server.createobject("aspimage.image")
jPath = imagepath & imagename
Jpeg.loadimage jPath
intWidth    = Jpeg.MaxX
intHeight   = Jpeg.MaxY
Jpeg.resize 120, 120*intHeight/intWidth
Jpeg.ImageFormat = 1
Jpeg.JPEGQuality = 80
Jpeg.Filename=imagepath & "\tn-" & imagename
Jpeg.SaveImage
Case 3  'No Thumbnail
	response.write "No Thumb"
End Select
Set Jpeg = Nothing
 
End Function

'###### Calls Upload & Saves File ######
Public Sub Save(Path)
Dim MaxSize, streamFile, fileItem, Jpeg, jPath, objFS, f, FileSize, FileExt, xx
Dim NailerApp, ThumbPath, ThumbName
MaxSize = 2*1048576 'MaxUploadSize
if Right(Path, 1) <> "\" then Path = Path & "\"
if not uploadedYet then Upload

For Each fileItem In UploadedFiles.Items

DotPosition = InStrRev(fileItem.FileName, ".")
FileExt = Mid(fileItem.FileName,DotPosition + 1)
If lCase(FileExt) = "jpg" OR lCase(FileExt) = "jpeg" OR lCase(FileExt) = "gif" OR lCase(FileExt) = "bmp" OR lCase(FileExt) = "png" Then

If Not UploadExists(Path & fileItem.FileName) Then

'###### Upload Image To Server ######
Set streamFile = Server.CreateObject("ADODB.Stream")
streamFile.Type = 1
streamFile.Open
StreamRequest.Position=fileItem.Start
StreamRequest.CopyTo streamFile, fileItem.Length
'streamFile.SaveToFile Path & fileItem.FileName, 2
If len(fileName_)>0 Then
				array_ = split(fileItem.FileName,".")
				ext_ = array_(ubound(array_))
				'streamFile.SaveToFile Path  & fileName_ & "." & ext_ , 2
				streamFile.SaveToFile Path  & fileItem.FileName , 2
			Else
				streamFile.SaveToFile Path  & fileItem.FileName , 2
End If
			
streamFile.close
Set streamFile = Nothing
fileItem.Path = Path & fileItem.FileName

'###### Get Image Size & Check For Max Upload ######
Set objFS = CreateObject("Scripting.FileSystemObject")
Set f = objFS.GetFile(Path & fileItem.FileName) 
FileSize = f.size

If FileSize <= MaxSize Then

'###### Create Thumbnail ######
ThumbPath = Path
ThumbName = fileItem.FileName

'UploadSuccess()
call MakeThumb(ThumbPath,ThumbName)

response.write "The file <i>"""&fileItem.FileName&"""</i>&nbsp;<font class=""textxsm"">("&FormatImageSize(fileItem.length)&")</font> archivo subido."

Else
'###### Image Is Too Big Delete It ######
objFS.DeleteFile(Path & fileItem.FileName)

UploadFailure()
response.write "The file <i>"""&fileItem.FileName&"""</i>&nbsp;<font class=""textxsm"">("&FormatImageSize(fileItem.length)&")</font> exceeded the maximum allowed upload size of "&FormatImageSize(MaxSize)&". The upload process has been terminated."

End If

Else

'###### Rename & Upload Image ######
Dim OldFileName, NewFileName, ChangedName, DotPosition, FileRun
OldFileName = fileItem.FileName
NewFileName = fileItem.FileName
FileRun = 1
ChangedName = False
DotPosition = InStrRev(fileItem.FileName, ".")
FileExt = Mid(fileItem.FileName,DotPosition + 1)
Do While Not UploadExists(Path & NewFileName) = False
If Not ChangedName = True Then
NewFileName = Replace(NewFileName, "." & FileExt, "")
Else
NewFileName = Replace(NewFileName, FileRun - 1 & "." & FileExt, "")
End If
NewFileName = NewFileName & FileRun & "." & FileExt
FileRun = FileRun + 1
ChangedName = True
Loop
fileItem.FileName = NewFileName
Set streamFile = Server.CreateObject("ADODB.Stream")
streamFile.Type = 1
streamFile.Open
StreamRequest.Position=fileItem.Start
StreamRequest.CopyTo streamFile, fileItem.Length
streamFile.SaveToFile Path & fileItem.FileName, 2
streamFile.close
Set streamFile = Nothing
fileItem.Path = Path & fileItem.FileName

'###### Get Image Size & Check For Max Upload ######
Set objFS = CreateObject("Scripting.FileSystemObject")
Set f = objFS.GetFile(Path & fileItem.FileName) 
FileSize = f.size

If FileSize <= MaxSize Then

'###### Create Thumbnail ######
ThumbPath = Path
ThumbName = fileItem.FileName

call MakeThumb(ThumbPath,ThumbName)

'UploadSuccess()
response.write "The file <i>"""&OldFileName&"""</i>&nbsp;<font class=""textxsm"">("&FormatImageSize(fileItem.length)&")</font> was already present in the directory.&nbsp;&nbsp;To avoid erasing the existing image it was renamed <i>"""&NewFileName&"""</i>&nbsp;<font class=""textxsm"">("&FormatImageSize(fileItem.length)&")</font>."

Else
'###### Image Is Too Big Delete It ######
objFS.DeleteFile(Path & fileItem.FileName)

UploadFailure()
response.write "The file <i>"""&fileItem.FileName&"""</i>&nbsp;<font class=""textxsm"">("&FormatImageSize(fileItem.length)&")</font> exceeded the maximum allowed upload size.&nbsp;&nbsp;The upload process has been terminated."

End If

End If

Else

UploadFailure()
response.write "The file <i>"""&fileItem.FileName&"&nbsp;("&FormatImageSize(fileItem.length)&")""</i> is not an accepted upload format."

End If

Next
End Sub

Public Function SaveBinRequest(Path) ' For debugging purposes
StreamRequest.SaveToFile Path & "\debugStream.bin", 2
End Function

Public Sub DumpData() 'only works if files are plain text
Dim i, aKeys, f
response.write "Form Items:<br>"
aKeys = FormElements.Keys
For i = 0 To FormElements.Count -1 ' Iterate the array
response.write aKeys(i) & " = " & FormElements.Item(aKeys(i)) & "<BR>"
Next
response.write "Uploaded Files:<br>"
For Each f In UploadedFiles.Items
response.write "Name: " & f.FileName & "<br>"
response.write "Type: " & f.ContentType & "<br>"
response.write "Start: " & f.Start & "<br>"
response.write "Size: " & f.Length & "<br>"
Next
End Sub

Private Sub Upload()
Dim nCurPos, nDataBoundPos, nLastSepPos
Dim nPosFile, nPosBound
Dim sFieldName, osPathSep, auxStr

Dim vDataSep
Dim tNewLine, tDoubleQuotes, tTerm, tFilename, tName, tContentDisp, tContentType
tNewLine = Byte2String(Chr(13))
tDoubleQuotes = Byte2String(Chr(34))
tTerm = Byte2String("--")
tFilename = Byte2String("filename=""")
tName = Byte2String("name=""")
tContentDisp = Byte2String("Content-Disposition")
tContentType = Byte2String("Content-Type:")

uploadedYet = true

on error resume next
VarArrayBinRequest = Request.BinaryRead(Request.TotalBytes)
if Err.Number <> 0 then 
response.write "<br><br><B>System reported this error:</B><p>"
response.write Err.Description & "<p>"
response.write "The most likely cause for this error is the incorrect setup of AspMaxRequestEntityAllowed in IIS MetaBase. Please see instructions in the <A HREF='http://www.freeaspupload.net/freeaspupload/requirements.asp'>requirements page of freeaspupload.net</A>.<p>"
Exit Sub
end if
on error goto 0

nCurPos = FindToken(tNewLine,1)

If nCurPos <= 1  Then Exit Sub

vDataSep = MidB(VarArrayBinRequest, 1, nCurPos-1)

nDataBoundPos = 1

nLastSepPos = FindToken(vDataSep & tTerm, 1)

Do Until nDataBoundPos = nLastSepPos

nCurPos = SkipToken(tContentDisp, nDataBoundPos)
nCurPos = SkipToken(tName, nCurPos)
sFieldName = ExtractField(tDoubleQuotes, nCurPos)

nPosFile = FindToken(tFilename, nCurPos)
nPosBound = FindToken(vDataSep, nCurPos)

If nPosFile <> 0 And  nPosFile < nPosBound Then
Dim oUploadFile
Set oUploadFile = New UploadedFile

nCurPos = SkipToken(tFilename, nCurPos)
auxStr = ExtractField(tDoubleQuotes, nCurPos)

osPathSep = "\"
if InStr(auxStr, osPathSep) = 0 then osPathSep = "/"
oUploadFile.FileName = Right(auxStr, Len(auxStr)-InStrRev(auxStr, osPathSep))

if (Len(oUploadFile.FileName) > 0) then
nCurPos = SkipToken(tContentType, nCurPos)

auxStr = ExtractField(tNewLine, nCurPos)

oUploadFile.ContentType = Right(auxStr, Len(auxStr)-InStrRev(auxStr, " "))
nCurPos = FindToken(tNewLine, nCurPos) + 4

oUploadFile.Start = nCurPos-1
oUploadFile.Length = FindToken(vDataSep, nCurPos) - 2 - nCurPos

If oUploadFile.Length > 0 Then UploadedFiles.Add LCase(sFieldName), oUploadFile
End If
Else
Dim nEndOfData
nCurPos = FindToken(tNewLine, nCurPos) + 4
nEndOfData = FindToken(vDataSep, nCurPos) - 2
If Not FormElements.Exists(LCase(sFieldName)) Then FormElements.Add LCase(sFieldName), String2Byte(MidB(VarArrayBinRequest, nCurPos, nEndOfData-nCurPos))
End If

nDataBoundPos = FindToken(vDataSep, nCurPos)
Loop
StreamRequest.Write(VarArrayBinRequest)
End Sub

Private Function SkipToken(sToken, nStart)
SkipToken = InstrB(nStart, VarArrayBinRequest, sToken)
If SkipToken = 0 then
Response.write "Error in parsing uploaded binary request."
Response.End
end if
SkipToken = SkipToken + LenB(sToken)
End Function

Private Function FindToken(sToken, nStart)
FindToken = InstrB(nStart, VarArrayBinRequest, sToken)
End Function

Private Function ExtractField(sToken, nStart)
Dim nEnd
nEnd = InstrB(nStart, VarArrayBinRequest, sToken)
If nEnd = 0 then
Response.write "Error in parsing uploaded binary request."
Response.End
end if
ExtractField = String2Byte(MidB(VarArrayBinRequest, nStart, nEnd-nStart))
End Function

Private Function Byte2String(sString)
Dim i
For i = 1 to Len(sString)
Byte2String = Byte2String & ChrB(AscB(Mid(sString,i,1)))
Next
End Function

Private Function String2Byte(bsString)
Dim i
String2Byte =""
For i = 1 to LenB(bsString)
String2Byte = String2Byte & Chr(AscB(MidB(bsString,i,1))) 
Next
End Function
End Class

Class UploadedFile
Public ContentType
Public Start
Public Length
Public Path
Private nameOfFile

Public Property Let FileName(fN)
nameOfFile = fN
nameOfFile = SubstNoReg(nameOfFile, "\", "_")
nameOfFile = SubstNoReg(nameOfFile, "/", "_")
nameOfFile = SubstNoReg(nameOfFile, ":", "_")
nameOfFile = SubstNoReg(nameOfFile, "*", "_")
nameOfFile = SubstNoReg(nameOfFile, "?", "_")
nameOfFile = SubstNoReg(nameOfFile, """", "_")
nameOfFile = SubstNoReg(nameOfFile, "<", "_")
nameOfFile = SubstNoReg(nameOfFile, ">", "_")
nameOfFile = SubstNoReg(nameOfFile, "|", "_")
End Property

Public Property Get FileName()
FileName = nameOfFile
End Property

End Class

Function SubstNoReg(initialStr, oldStr, newStr)
Dim currentPos, oldStrPos, skip
If IsNull(initialStr) Or Len(initialStr) = 0 Then
SubstNoReg = ""
ElseIf IsNull(oldStr) Or Len(oldStr) = 0 Then
SubstNoReg = initialStr
Else
If IsNull(newStr) Then newStr = ""
currentPos = 1
oldStrPos = 0
SubstNoReg = ""
skip = Len(oldStr)
Do While currentPos <= Len(initialStr)
oldStrPos = InStr(currentPos, initialStr, oldStr)
If oldStrPos = 0 Then
SubstNoReg = SubstNoReg & Mid(initialStr, currentPos, Len(initialStr) - currentPos + 1)
currentPos = Len(initialStr) + 1
Else
SubstNoReg = SubstNoReg & Mid(initialStr, currentPos, oldStrPos - currentPos) & newStr
currentPos = oldStrPos + skip
End If
Loop
End If
End Function
%>