<%
Function BinaryToString(Binary)
  Dim I, S
  For I = 1 To 60
    S = S & Chr(AscB(MidB(Binary, I, 1)))
  Next
  BinaryToString = S
End Function

Function BinaryToDec(BinaryValue)
	Dim valor
	Do 
		valor = valor + (Left(BinaryValue, 1) * 2 ^ (Len(BinaryValue) - 1)) 
		BinaryValue = Mid(BinaryValue, 2) 
	Loop Until BinaryValue = "" 
	BinaryToDec = valor
End Function 

Function IntToBinary(num)    
	Dim result    
	IntToBinary="00000000"    
	If num<1 Then Exit Function    
	result=""    
	Do Until num<1        
		result=result&CStr(num Mod 2)        
		num = Fix(num/2)    
	Loop
	Do Until len(result)>=8        
		result = result&"0"
	Loop
	IntToBinary=StrReverse(result)
End Function

function MBFtoREAL(BinaryData)
	Dim Valor(4), expo, m1, m2, m3, sign, mantisa
	'pasar a binario
	For I = 1 To 4
		valor(I)=cStr(IntToBinary(AscB(MidB(BinaryData, I, 1))))
	next
	'ordenar
	expo=valor(4)
	m1=mid(valor(3),2,len(valor(3)))
	m2=valor(2)
	m3=valor(1)
	'Exponente = ExponenteDecimal - 128
	expo=BinaryToDec(expo)-128
	'Mantisa  = byte3 sin signo + byte2 + byte1 
	mantisa=m1+m2+m3
	'signo = octavo bit byte3
	sign=mid(valor(3),1,1)
	'determino el entero si exponente negativo es 1, si positivo calculo
	if expo>0 then
		'Entero = 1 concatenado a bits de mantiza posicion 1 a exponente -1 evaluado a decimal 
		resultado = BinaryToDec("1"+mid(mantisa,1,expo-1))
		'fraccion = el resto de mantisa
		mantisa=mid(mantisa,expo)
	end if
	'calculo la fraccion
	i=0
	Do Until mantisa = ""
		i=i-1
		if not(isnumeric(Left(mantisa, 1))) then
			response.Write("aqui murioooo:-->"&Left(mantisa, 1)&"<-- tantan")
			response.End()
		end if
		resultado = resultado + (cInt(Left(mantisa, 1)) * 2 ^ i) 
		mantisa = Mid(mantisa, 2) 
	Loop 
	'si exponente <=0 calculo el resultsado final
	if expo <=0 and resultado <> 0 then
		resultado = (1+resultado) * 2 ^ (expo-1)
	end if
	MBFtoREAL = resultado
end function

Function ParseFitoval(Binary)
  Dim I, S
  Response.Write "<REGISTROS>"  
  For I = 1 To LenB(Binary)
	 D  = AscB(MidB(Binary, I, 2)) 
	 if D = 246 then 
		exit for
	 end if
	 Response.Write "<ROW>"
	 I = I+2
	 M = AscB(MidB(Binary, I, 2))
	 I = I+2
	 Y = AscB(MidB(Binary, I, 4))
	 I = I+4
	 N = BinaryToString(MidB(Binary, I, 60))
	 I = I+60
	 D0 = MBFtoREAL(MidB(Binary, I, 8))
	 I = I+8
	 D5 = MBFtoREAL(MidB(Binary, I, 8))
	 I = I+8
	 D10 = MBFtoREAL(MidB(Binary, I, 8))
	 I = I+8
	 D20 = MBFtoREAL(MidB(Binary, I, 8))
	 I = I+8
	 D30 = MBFtoREAL(MidB(Binary, I, 8))
	 I = I+8
	 B0 = MBFtoREAL(MidB(Binary, I, 6))
	 I = I+6
	 B5 = MBFtoREAL(MidB(Binary, I, 6))
	 I = I+6
	 B10 = MBFtoREAL(MidB(Binary, I, 6))
	 I = I+6
	 B20 = MBFtoREAL(MidB(Binary, I, 6))
	 I = I+6
	 B30 = MBFtoREAL(MidB(Binary, I, 6))
	 I = I+7
	 Response.Write "<D>" &   D & "</D>"
	 Response.Write "<M>" &   M & "</M>"
	 Response.Write "<Y>" &   Y & "</Y>"
	 Response.Write "<N>" &   N & "</N>"
	 Response.Write "<D0>" &  D0 & "</D0>"
	 Response.Write "<D5>" &  D5 & "</D5>"
	 Response.Write "<D10>" & D10 & "</D10>"
	 Response.Write "<D20>" & D20 & "</D20>"
	 Response.Write "<D30>" & D30 & "</D30>"
	 Response.Write "<B0>" &  B0 & "</B0>"
	 Response.Write "<B5>" &  B5 & "</B5>"
	 Response.Write "<B10>" & B10 & "</B10>"
	 Response.Write "<B20>" & B20 & "</B20>"
	 Response.Write "<B30>" & B30 & "</B30>"
	 Response.Write "</ROW>"&chr(13)&chr(10)
  Next
  Response.Write "</REGISTROS>"
End Function

	'rescato nombrearchivo
	archivo=request.QueryString("arch")
	'rescato tipo de archivo
	tipo = request.QueryString("tipo")
	
	'cargo el archivo binario
	set stream = Server.CreateObject("ADODB.Stream") 
	stream.Open 
	stream.Type = 1 ' binary 
	ServerPath = Server.MapPath(archivo)
	stream.LoadFromFile(ServerPath)
	ReadBinaryFile = stream.Read
	stream.Close
	Set stream = Nothing

	'encabezados excel
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition", "attachment;filename=" & strName 
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	
	'genero el excel
'	Select Case tipo
'		Case "fitoval"



'			response.Write("<script type='text/javascript' language='javascript'>"
'			response.Write("alert('en progreso');")
'			response.Write("window.close();")
'			response.Write("</script>")
'		Case Else
			ParseFitoval(ReadBinaryFile)
'	End Select

'LARGO DEL REGISTRO 140 BYTES
'
'FIELD #1,
'2 AS D$,
'2 AS M$,
'4 AS A$,
'60 AS N$,
'8 AS D0$,
'8 AS D5$,
'8 AS D10$,
'8 AS D20$,
'8 AS D30$,
'6 AS B0$,
'6 AS B5$,
'6 AS B10$,
'6 AS B20$,
'6 AS B30$ 	
%>