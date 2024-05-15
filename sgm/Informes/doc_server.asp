<%@ Language=VBScript %>
<!--#include file="..\standard\DBConn.asp" -->
<%
DIM pdf,a
DIM x1, y1, x2, y2, salto
DIM f1, f2, faena
'response.Write("<html><body>")
'
'  response.write( Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")& " <br>")
'



'response.Write("</body></html>")
'response.End()

f1 = request("FECHA_INI")
f2 = request("FECHA_FIN")
faena = request("FAENA")
Function FechaPDF(vblefecha)
	if vblefecha <> "" THEN
	numerodia=day(vblefecha)
	if numerodia<10 then
	numerodia="0" & numerodia
	end if
	
	numeromes=month(vblefecha)
	if numeromes<10 then
	numeromes="0" & numeromes
	end if
	
	FechaPDF= numerodia & "/" & numeromes & "/" & year(vblefecha)
	else 
	FechaPDF=  ""
	end if
End Function

Function encabezados_fpdf()
	pdf.rect x1+7, y1+27+salto, 255, 4 'dibujo rectangulo
	pdf.SetFont "times","B",7
	pdf.Text x1+len("Num.")+4, y1+30+salto, "N."
	pdf.Text x1+len("Num.")+9+len("Id"), y1+30+salto, "Id"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+3, y1+30+salto, "Fecha"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+4, y1+30+salto, "Responsable"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15, y1+30+salto, "Descripcion"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18, y1+30+salto, "Ind_inc."
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6, y1+30+salto, "Componente"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8, y1+30+salto, "Color_crit."
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+8, y1+30+salto, "Crit."
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14, y1+30+salto, "Causa"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14+len("Dias")+19, y1+30+salto, "Dias"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14+len("Dias")+19+len("Equipo")+3, y1+30+salto, "Equipo"
	pdf.Text x+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14+len("Dias")+19+len("Equipo")+1+len("Recomendacion")+11, y1+30+salto, "Recomendacion"
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14+len("Dias")+19+len("Equipo")+1+len("Recomendacion")+11+len("Sol.")+13, y1+30+salto, "Sol."
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14+len("Dias")+19+len("Equipo")+1+len("Recomendacion")+11+len("Sol.")+13+len("Arch.")+4, y1+30+salto, "Arch."
	pdf.Text x1+len("Num.")+9+len("Id")+len("Fecha")+1+len("Responsable")+8+len("Descripcion")+15+len("Ind_inc.")+18+len("Componente")+6+len("Color_crit.")+8+len("Crit.")+9+len("Causa")+14+len("Dias")+19+len("Equipo")+1+len("Recomendacion")+11+len("Sol.")+13+len("Arch.")+4+len("Ult. Act.")+2, y1+30+salto, "Ult. Act"

End Function

Function WordWrap(strTextToBeWrapped, intMaxLineLength)
'	response.write strTextToBeWrapped & "<br>" 
     Dim strWrappedText           ' Result storage

     Dim intLengthOfInput         ' Length of original

     Dim intCurrentPosition       ' Where we're at now
     Dim intCurrentLineStart      ' Where the current line starts
     Dim intPositionOfLastSpace   ' Last space we saw

     ' Get this once so we don't have to keep checking
     intLengthOfInput = Len(strTextToBeWrapped)
	
     ' Start both of these at the beginning
     intCurrentPosition = 1
     intCurrentLineStart = 1

     ' Loop through until we get to the end
     Do While intCurrentPosition <= intLengthOfInput
          If Mid(strTextToBeWrapped, intCurrentPosition, 1) = " " Then
               intPositionOfLastSpace = intCurrentPosition
          End If
          If intCurrentPosition = intCurrentLineStart + intMaxLineLength Then
               'Response.Write intCurrentLineStart & "<br />"
'               Response.Write intPositionOfLastSpace &" "& intLengthOfInput & "<br />"
'               Response.Write Trim(Mid(strTextToBeWrapped, intcurrentLineStart, _
'                    intPositionOfLastSpace - intCurrentLineStart + 1)) & "<br />"

               strWrappedText = strWrappedText _
                    & Trim(Mid(strTextToBeWrapped, intcurrentLineStart, _
                    intPositionOfLastSpace - intCurrentLineStart + 1)) _
                    & vbCrLf
               intCurrentLineStart = intPositionOfLastSpace + 1
               Do While Mid(strTextToBeWrapped, intCurrentLineStart, 1) = " "
                    intCurrentLineStart = intCurrentLineStart + 1
               Loop
          End If
          intCurrentPosition = intCurrentPosition + 1
     Loop

     ' Since the loop ends before we add the remaining text,
     ' add remaining text as the last line.
'	                Response.Write Trim(Mid(strTextToBeWrapped, _
'          intcurrentLineStart)) & "<br />"

     strWrappedText = strWrappedText & Trim(Mid(strTextToBeWrapped, _
          intcurrentLineStart)) & vbCrLf

     ' Return our result to the calling line.
     WordWrap = strWrappedText
End Function
Function countWordWrap(strTextToBeWrapped, intMaxLineLength)
     Dim strWrappedText           ' Result storage

     Dim intLengthOfInput         ' Length of original

     Dim intCurrentPosition       ' Where we're at now
     Dim intCurrentLineStart      ' Where the current line starts
     Dim intPositionOfLastSpace   ' Last space we saw

     ' Get this once so we don't have to keep checking
     intLengthOfInput = Len(strTextToBeWrapped)

     ' Start both of these at the beginning
     intCurrentPosition = 1
     intCurrentLineStart = 1
	  line = 0
     ' Loop through until we get to the end
     Do While intCurrentPosition < intLengthOfInput
          ' If the current position is a space, make a note of
          ' it's location for later use.
          If Mid(strTextToBeWrapped, intCurrentPosition, 1) = " " Then
               intPositionOfLastSpace = intCurrentPosition
          End If

          ' If we're at what should be the end of a line, we go back
          ' to the last space we saw and cut the line there.
          If intCurrentPosition = intCurrentLineStart + intMaxLineLength Then
               ' Some debugging lines if something's not lining up.
'               Response.Write intCurrentLineStart & "<br />"
'               Response.Write intPositionOfLastSpace & "<br />"
'               Response.Write Trim(Mid(strTextToBeWrapped, intcurrentLineStart, _
'                    intPositionOfLastSpace - intCurrentLineStart + 1)) & "<br />"

               ' Append this latest line to our result
               strWrappedText = strWrappedText _
                    & Trim(Mid(strTextToBeWrapped, intcurrentLineStart, _
                    intPositionOfLastSpace - intCurrentLineStart + 1)) _
                    & vbCrLf
				line = line + 1
               ' Reset the next line's starting point to the point we
               ' used for the last one's end + 1.
               intCurrentLineStart = intPositionOfLastSpace + 1

               ' Remove any leading spaces that might mess up our
               ' character count.  If you want to just pull of one,
               ' switch this to a simple If conditional instead of
               ' looping.
               Do While Mid(strTextToBeWrapped, intCurrentLineStart, 1) = " "
                    intCurrentLineStart = intCurrentLineStart + 1
               Loop
          End If

          ' Increment our location indicator.
          intCurrentPosition = intCurrentPosition + 1
		  
     Loop

     ' Since the loop ends before we add the remaining text,
     ' add remaining text as the last line.
     strWrappedText = strWrappedText & Trim(Mid(strTextToBeWrapped, _
          intcurrentLineStart)) & vbCrLf

     ' Return our result to the calling line.
	 'response.write line & "<br>"
     countWordWrap = line
End Function

%>
<!--#include file="fpdf.asp"-->
<%
salto = 0
Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF "L","mm","Letter"
pdf.SetPath("fpdf/")
pdf.Open()

' COORDENADAS INICIALES
pdf.SetAutoPageBreak true, default 
'pdf.SetDisplayMode "real", "default"' "two"
x1 = 6
y1 = 7
x2 = 193
y2 = 260
yy = 0

pdf.AddPage()


'pdf.rect x1, y1+salto, x2, y2 'dibujo rectangulo principal

' ENCABEZADO
'pdf.image "./images/encabezado.jpg",10,10,300
'pdf.Image Server.MapPath("images/encabezado.jpg"), 40, 20, 20, 20, "JPG","http://www.lambdasi.com.ar"
'pdf.Image Server.MapPath("encabezado.jpg"),5,5,201,0



' CONTEXTO
'pdf.Image "encabezado.jpg", 15, 15, 185, 15, "",""
	strLogo = "encabezado.jpg"
'pdf.Image strLogo,10,10,40,30

pdf.SetFont "times","B",20
pdf.Text x1+110, y1+14+salto, "Listado Bitacoras  "&a

encabezados_fpdf()
'-------------------------------------------------
if f1 <> "" and f2 <> "" and faena <> "" then

	query = "SELECT row_number() OVER (ORDER BY B.ID) AS NUMERO, B.ID, B.FECHA, B.RESPONSABLE, B.DESCRIPCION, B.IND_INCIDENTE, B.EQUIPO AS COMPONENTE, B.COLOR AS COLOR_CRITICIDAD, ISNULL(B.CRITICIDAD,''), B.CAUSA, B.UBICACION AS FAENA, DATEDIFF ( dd , B.FECHA , SYSDATETIME() ) AS DIAS, dbo.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION) AS EQUIPO_PRI, E.DESCRIPCION AS DESC_EQUIPO, B.RECOMENDACION, B.REPORT AS OT, B.IND_SOLUCION, isnull(F.ARCHIVOS,' ') as ARCHIVOS, H.ULT_ACT AS ULT_ACT FROM BITACORAS B  INNER JOIN EQUIPOS E ON  B.UBICACION = E.UBICACION AND dbo.EquipoPrincipalFaena(B.EQUIPO, B.UBICACION)=E.CODIGO  LEFT JOIN (SELECT IDENTIFICADOR, COUNT(0) AS ARCHIVOS from ARCHIVOS WHERE FAMILIA = 'BITACORAS' GROUP BY IDENTIFICADOR) AS F ON B.ID = F.IDENTIFICADOR  LEFT JOIN (SELECT ID, MAX(FECHA) AS ULT_ACT FROM HISTORIAL_BITACORA GROUP BY ID) AS H ON B.ID = H.ID WHERE B.UBICACION = '"&faena&"' AND B.FECHA BETWEEN '"&f1&"' AND '"&f2&"' ORDER BY B.ID" 
	Dim oDB
	Set oDB = New DBConn
	Set ORs =oDB.EjecutaSql(query)
	yy = 30
	rayas = 1
	altura = 12
	While Not ORs.EOF 
			pdf.SetFont "times","",6
			pdf.SetXY 13,yy+4
			if rayas >= 1 then
				post1 = 3 * cint(countWordWrap(ORs.Fields.Item(4).Value, 36))
				'response.write cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
				post2 = 3 * cint(countWordWrap(ORs.Fields.Item(9).Value, 36))
				post3 = 3 * cint(countWordWrap(ORs.Fields.Item(14).Value, 36))
			end if
			'response.write  rayas & " " &altura & " " & cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
			pdf.Cell 5,altura, ORs.Fields.Item(0).Value,"LR",0,"L", false
			pdf.Cell 9,altura, ORs.Fields.Item(1).Value,"LR",0,"L", false
			pdf.Cell 14,altura, FechaPDF(ORs.Fields.Item(2).Value),"LR",0,"L", false
			pdf.Cell 16,altura, ORs.Fields.Item(3).Value,"LR",0,"L", false
			'pdf.Cell  30,altura, WordWrap(ORs.Fields.Item(4).Value, 30),"LR",0,"L", false
			pdf.SetXY 13+5+9+14+16,yy+4+4
			pdf.multiCell 40,altura-9, ORs.Fields.Item(4).Value, 0, "J", false
			pdf.SetXY 13+5+9+14+16+40,yy+4
			pdf.Cell 10,altura, ORs.Fields.Item(5).Value,"LR",0,"L", false
			pdf.Cell 26,altura, ORs.Fields.Item(6).Value,"LR",0,"L", false
			pdf.Cell 12,altura, ORs.Fields.Item(7).Value,"LR",0,"L", false
			pdf.Cell 8,altura, ORs.Fields.Item(8).Value,"LR",0,"L", false
			'pdf.Cell 30,altura, left(ORs.Fields.Item(9).Value,22),"LR",0,"L", false
			pdf.SetXY 13+5+9+14+16+40+10+26+12+8,yy+4+4
			pdf.multiCell 36,altura-9, ORs.Fields.Item(9).Value, 0, "J", false
			pdf.SetXY 13+5+9+14+16+40+10+26+12+8+36,yy+4
			pdf.Cell 6,altura, ORs.Fields.Item(11).Value,"LR",0,"L", false
			pdf.Cell 15,altura, ORs.Fields.Item(12).Value,"LR",0,"L", false
			'pdf.Cell 36,altura, left(ORs.Fields.Item(14).Value,24),"LR",0,"L", false
			pdf.SetXY 13+5+9+14+16+40+10+26+12+8+36+6+15,yy+4+4
			pdf.multiCell 25,altura-9, ORs.Fields.Item(14).Value, 0, "J", false
			pdf.SetXY 13+5+9+14+16+40+10+26+12+8+36+6+15+25,yy+4			
			pdf.Cell 9,altura, ORs.Fields.Item(16).Value,"LR",0,"L", false
			pdf.Cell 10,altura, ORs.Fields.Item(17).Value,"LR",0,"L", false
			pdf.Cell 14,altura, FechaPDF(ORs.Fields.Item(18).Value),"RR",0,"L", false
			
			pdf.line 13, y1+yy+1+salto, 268, y1+yy+1+salto
			'response.write "tope " &  y1+yy+1+salto & "<br>" 
			rayas = rayas + 1
			
			If (post1 >= post2 And post1 > post3) Then
				post = post1
			ElseIf (post2 > post1 And post2 > post3) Then
				post = post2
			Else
				post = post3
			End If
			
			yy = yy + 10 + post
			sum = sum + yy
			'response.write y1+yy+1+salto & "<br>"
			  if y1+yy+1+salto >= 160 then
				pdf.line 13, y1+27+salto , 13, y1+yy+1+salto
				pdf.line 13+5, y1+27+salto , 13+5, y1+yy+1+salto
				pdf.line 13+14, y1+27+salto , 13+14, y1+yy+1+salto
				pdf.line 13+28, y1+27+salto , 13+28, y1+yy+1+salto
				pdf.line 13+44, y1+27+salto , 13+44, y1+yy+1+salto
				pdf.line 13+84, y1+27+salto , 13+84, y1+yy+1+salto
				pdf.line 13+94, y1+27+salto , 13+94, y1+yy+1+salto
				pdf.line 13+120, y1+27+salto , 13+120, y1+yy+1+salto
				pdf.line 13+132, y1+27+salto , 13+132, y1+yy+1+salto
				pdf.line 13+140, y1+27+salto , 13+140, y1+yy+1+salto
				pdf.line 13+176, y1+27+salto , 13+176, y1+yy+1+salto
				
				pdf.line 13+182, y1+27+salto , 13+182, y1+yy+1+salto
				pdf.line 13+197, y1+27+salto , 13+197, y1+yy+1+salto
				
				pdf.line 13+222, y1+27+salto , 13+222, y1+yy+1+salto
				pdf.line 13+231, y1+27+salto , 13+231, y1+yy+1+salto
				pdf.line 13+241, y1+27+salto , 13+241, y1+yy+1+salto
				pdf.line 13+255, y1+27+salto , 13+255, y1+yy+1+salto
				
			  	pdf.line 13, y1+yy+1+salto, 268, y1+yy+1+salto	
				pdf.AddPage()
				encabezados_fpdf()
				rayas = 1
				yy = 30
				sum = 0
			  end if
'			  if rayas = 2 then 
'			  	response.end 
'			end if
	  ORs.MoveNext
	Wend
	Set ORs = Nothing
	Set ODB = Nothing
				pdf.line 13, y1+27+salto , 13, y1+yy+1+salto
				pdf.line 13+5, y1+27+salto , 13+5, y1+yy+1+salto
				pdf.line 13+14, y1+27+salto , 13+14, y1+yy+1+salto
				pdf.line 13+28, y1+27+salto , 13+28, y1+yy+1+salto
				pdf.line 13+44, y1+27+salto , 13+44, y1+yy+1+salto
				pdf.line 13+84, y1+27+salto , 13+84, y1+yy+1+salto
				pdf.line 13+94, y1+27+salto , 13+94, y1+yy+1+salto
				pdf.line 13+120, y1+27+salto , 13+120, y1+yy+1+salto
				pdf.line 13+132, y1+27+salto , 13+132, y1+yy+1+salto
				pdf.line 13+140, y1+27+salto , 13+140, y1+yy+1+salto
				pdf.line 13+176, y1+27+salto , 13+176, y1+yy+1+salto
				
				pdf.line 13+182, y1+27+salto , 13+182, y1+yy+1+salto
				pdf.line 13+197, y1+27+salto , 13+197, y1+yy+1+salto
				
				pdf.line 13+222, y1+27+salto , 13+222, y1+yy+1+salto
				pdf.line 13+231, y1+27+salto , 13+231, y1+yy+1+salto
				pdf.line 13+241, y1+27+salto , 13+241, y1+yy+1+salto
				pdf.line 13+255, y1+27+salto , 13+255, y1+yy+1+salto

	
	pdf.line 13, y1+yy+1+salto, 268, y1+yy+1+salto
end if
pdf.Close()
pdf.Output("Listado.pdf")
%>
