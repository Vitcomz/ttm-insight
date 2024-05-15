<%
imagename = request("fileName")
url = request("url") 
'Creating variables 
imageUrl = url
 strImageName = imagename 
 'Function and subroutine calls 
 
 saveImage getImage(imageUrl), "preVw.jpg" 'strImageName 'Here is code library: 
 
 Function getImage(strImageUrl) 
  ' Set objHttp = CreateObject("Microsoft.XMLHTTP") 
   ' Set objHttp = CreateObject("MSXML2.ServerXMLHTTP") 
    Set objHttp = CreateObject("WinHttp.WinHttpRequest.5.1")  
	' Set Http = CreateObject("WinHttp.WinHttpRequest") 
	 objHttp.Open "GET", strImageUrl, False 
	  objHttp.Send             
	   getImage = objHttp.ResponseBody
 End Function
 
  Sub saveImage(ByteArray, strImageName) 
   Const adTypeBinary = 1 
    Const adSaveCreateOverWrite = 2
	  Const adSaveCreateNotExist = 1   
	      Set objBinaryStream = CreateObject("ADODB.Stream")  
		  objBinaryStream.Type = adTypeBinary          
		      objBinaryStream.Open  
			  objBinaryStream.Write ByteArray  
			  objBinaryStream.SaveToFile server.mappath("images\" & strImageName) , 
      			adSaveCreateOverWrite  response.Write("Image has been downloaded and saved!")
	end sub
	
 %>