<%@ Language=VBScript %>
<!--#include file="..\standard\DBConn.asp" -->
<%
DIM pdf,a
DIM x1, y1, x2, y2, salto
DIM f1, f2, faena

RECURSO=REQUEST("RECURSO")
EXCEL=REQUEST("EXCEL")
BITACORAS=UCASE(REQUEST("BITACORAS"))
CODIGO=UCASE(REQUEST("CODIGO"))
CONDICION=UCASE(REQUEST("CONDICION"))
CRITICIDAD=UCASE(REQUEST("CRITICIDAD"))
COLOR=UCASE(REQUEST("COLOR"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
EQUIPOS=UCASE(REQUEST("EQUIPOS"))
TIPO=UCASE(REQUEST("TIPO"))
FOLIO_OT=UCASE(REQUEST("FOLIO_OT"))
FECHA=UCASE(REQUEST("FECHA"))
IND_SOLUCION=UCASE(REQUEST("IND_SOLUCION"))
INICIO=UCASE(REQUEST("INICIO"))
ID=UCASE(REQUEST("ID"))
TERMINO=UCASE(REQUEST("TERMINO"))
REPORT=UCASE(REQUEST("REPORT"))
FECHA_INI=UCASE(REQUEST("FECHA_INI"))
FECHA_FIN=UCASE(REQUEST("FECHA_FIN"))
NUM=UCASE(REQUEST("NUM"))
USUARIO=UCASE(REQUEST("USUARIO"))
ESTADO=UCASE(REQUEST("ESTADO"))
DESCRIPCION=REQUEST("DESCRIPCION")
FAENA=REQUEST("FAENA")
FOLIO=REQUEST("FOLIO")
SECCION=REQUEST("SECCION")
SECCION_DES=REQUEST("SECCION_DES")
txtSupConfiabilidad=REQUEST("txtSupConfiabilidad")
txtInspLider=REQUEST("txtInspLider")
txtInsp1=REQUEST("txtInsp1")
txtInsp2=REQUEST("txtInsp2")
txtInsp3=REQUEST("txtInsp3")
txtEqRel=REQUEST("txtEqRel")
txtObsEq=REQUEST("txtObsEq")

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
	xx = "encabezado.jpg"
	'pdf.Image xx, 15, 15, 185, 15
	pdf.SetFont "arial","B",11
	pdf.Text x1+70, y1+32+salto, "Informe Diario TTM -  Fecha: "&FormatDateTime(now,2)
	
	PDF.rect x1+7, y1+35+salto, 23, 19 'dibujo rectangulo
	pdf.SetFont "arial","B",8
	PDF.Text x1+len("Equipo de")+3, y1+43+salto, "Equipo de"
	PDF.Text x1+len("Equipo de")+3, y1+47+salto, "Inpectores:"

	PDF.rect x1+30, y1+35+salto, 42, 5 'dibujo rectangulo
	PDF.rect x1+30, y1+40+salto, 42, 5 'dibujo rectangulo
	PDF.rect x1+30, y1+45+salto, 42, 9 'dibujo rectangulo
	PDF.Text x1+len("Supervisor de Confiabilidad:")+4, y1+39+salto, "Supervisor de Confiabilidad:"
	PDF.Text x1+len("Inspector Lider:")+24, y1+44+salto, "Inspector Lider:"
	PDF.Text x1+len("Inspectores:")+29, y1+51+salto, "Inspectores:"
	PDF.rect x1+72, y1+35+salto, 42, 5 'dibujo rectangulo
	PDF.rect x1+72, y1+40+salto, 42, 5 'dibujo rectangulo
	
	PDF.rect x1+72, y1+45+salto, 42, 3 'dibujo rectangulo
	PDF.rect x1+72, y1+48+salto, 42, 3 'dibujo rectangulo
	PDF.rect x1+72, y1+51+salto, 42, 3 'dibujo rectangulo
' aca van los datos de personas
	PDF.Text x1+74, y1+39+salto, txtSupConfiabilidad
	PDF.Text x1+74, y1+44+salto, txtInspLider
	PDF.Text x1+74, y1+48+salto, txtInsp1
	PDF.Text x1+74, y1+51+salto, txtInsp2
	PDF.Text x1+74, y1+54+salto, txtInsp3			

	PDF.rect x1+7, y1+57+salto, 23, 6 'dibujo rectangulo
	PDF.rect x1+30, y1+57+salto, 165, 6 'dibujo rectangulo
	PDF.rect x1+7, y1+63+salto, 23, 6 'dibujo rectangulo
	PDF.rect x1+30, y1+63+salto, 165, 6 'dibujo rectangulo
	pdf.SetFont "arial","B",6
	PDF.Text x1+len("Equipos")+8, y1+59+salto, "Equipos"
	PDF.Text x1+len("Inspeccionados:")-4, y1+62+salto, "Inspeccionados:"
	PDF.Text x1+len("Observaciones:")-4, y1+68+salto, "Observaciones:"	
	PDF.Text x1+32, y1+61+salto, txtEqRel
	PDF.Text x1+32, y1+67+salto, txtObsEq


	PDF.rect x1+7, y1+71+salto, 188, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 19, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 47, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 58, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 73, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 86, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 130, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+71+salto, 172, 4 'dibujo rectangulo
	
	pdf.SetFont "arial","B",5
	PDF.Text x1+len("Nombre Equipo")-4, y1+74+salto, "Nombre Equipo"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1, y1+74+salto, "Componente"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1+len("Bitacora")+14, y1+74+salto, "Bitacora"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1+len("Bitacora")+14+len("Aviso")+10, y1+74+salto, "Aviso"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1+len("Bitacora")+14+len("Aviso")+10+len("Orden")+8, y1+74+salto, "Orden"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1+len("Bitacora")+14+len("Aviso")+10+len("Orden")+8+len("Descripcion Condicion"), y1+74+salto, "Descripcion Condicion"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1+len("Bitacora")+14+len("Aviso")+10+len("Orden")+8+len("Descripcion Condicion")+len("Recomendacion")+32, y1+74+salto, "Recomendacion"
	PDF.Text x1+len("Nombre Equipo")+9+len("Componente")+1+len("Bitacora")+14+len("Aviso")+10+len("Orden")+8+len("Descripcion Condicion")+len("Recomendacion")+32+len("Criticidad")+24, y1+74+salto, "Criticidad"
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

function strNvl(Valor)

if Len(Valor) <1 then
	strNvl = "NULL"
else
	strNvl = "'" & Valor & "'"	
end if

end function


%>
<!--#include file="fpdf.asp"-->
<%
Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF "P","mm","Letter"
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

salto = 0
'PDF.rect x1, y1+salto, x2, y2 'dibujo rectangulo principal

' ENCABEZADO
'pdf.image "./images/encabezado.jpg",10,10,300
'pdf.Image Server.MapPath("images/encabezado.jpg"), 40, 20, 20, 20, "JPG","http://www.lambdasi.com.ar"
'pdf.Image Server.MapPath("encabezado.jpg"),5,5,201,0



' CONTEXTO
encabezados_fpdf()
'-------------------------------------------------

	fech = cdate("01/"& month(cdate(FECHA)) & "/" & year(cdate(FECHA))-2)
	fech2 = day(cdate(FECHA)) & "/"& month(cdate(FECHA)) & "/" & year(cdate(FECHA))
	query = " SELECT   dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") AS EQUIPO, isnull(E.DESCRIPCION,'Sin Novedad') AS COMPONENTE,isnull(B.ID,'') AS BITACORA, "
	query = query & "  isnull(B.REPORT,'') AS AVISO, isnull(B.OT,'') AS ORDEN, isnull(B.DESCRIPCION,'') as DESCRIPCION,  isnull(RECOMENDACION,'') as RECOMENDACION, isnull(B.COLOR,'') as CRITICIDAD"
	query = query & "  FROM  EQUIPOS AS E LEFT JOIN BITACORAS AS B ON E.CODIGO = B.EQUIPO AND E.UBICACION = B.UBICACION"
	query = query & "  AND B.IND_SOLUCION = 'false' AND B.FECHA BETWEEN '" & fech & "' AND '" & fech2 & "'"
	query = query & "  WHERE E.ESTADO = 'ACT' AND E.UBICACION = " & strNvl(FAENA) & " AND dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") <> E.CODIGO"
	query = query & "  AND E.TIPO_EQUIPO IN (8,9,24,35,36,38,44,45) "
	if strNvl(SECCION) <> "NULL" then
		query = query & "  AND E.seccion in (" & SECCION & ")"
	end if
	if strNvl(EQUIPO) <> "NULL" then
		query = query & "  AND DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") in ("& EQUIPO &")"
	end if
	query = query & "  AND E.CODIGO NOT LIKE '%POL' AND E.CODIGO NOT LIKE '%PLI' "
	query = query & "  union "
	query = query & "  SELECT  dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") AS EQUIPO, CASE E.TIPO_EQUIPO WHEN 5 THEN 'CINTA'"
	query = query & "  WHEN 6 THEN 'GUALDERAS' WHEN 7 THEN 'CHUTE CARGA' WHEN 10 THEN 'RASPADORES' WHEN 22 THEN 'CINTA' WHEN 23 THEN 'CINTA' END AS COMPONENTE,"
	query = query & "  isnull(B.ID,'') AS BITACORA, isnull(B.REPORT,'') AS AVISO,isnull(B.OT,'') AS ORDEN, isnull(B.DESCRIPCION,'') as DESCRIPCION, isnull(RECOMENDACION,'') as RECOMENDACION, isnull(B.COLOR,'') as CRITICIDAD"
	query = query & "  FROM  EQUIPOS AS E LEFT JOIN BITACORAS AS B ON E.CODIGO = B.EQUIPO AND E.UBICACION = B.UBICACION"
	query = query & "  AND B.IND_SOLUCION = 'false' AND B.FECHA BETWEEN '" & fech & "' AND '" & fech2 & "'"
	query = query & "  WHERE E.ESTADO = 'ACT' AND E.UBICACION = " & strNvl(FAENA) & " AND dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") <> E.CODIGO"
	query = query & "  AND E.TIPO_EQUIPO IN (5,6,7,10,22,23) "
	if strNvl(SECCION) <> "NULL" then
		query = query & "  AND E.seccion in (" & SECCION & ")"
	end if
	if strNvl(EQUIPO) <> "NULL" then
		query = query & "  AND DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & ") in ("& EQUIPO &")"
	end if
	query = query & "  GROUP BY dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & "), B.ID, CASE E.TIPO_EQUIPO WHEN 5 THEN 'CINTA'"
	query = query & "  WHEN 6 THEN 'GUALDERAS' WHEN 7 THEN 'CHUTE CARGA' WHEN 10 THEN 'RASPADORES' WHEN 22 THEN 'CINTA' WHEN 23 THEN 'CINTA' END,"
	query = query & "  B.REPORT, B.OT, B.DESCRIPCION,  RECOMENDACION, B.COLOR ORDER BY dbo.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA) & "), COMPONENTE"

	Dim oDB
	Set oDB = New DBConn
	Set ORs =oDB.EjecutaSql(query)
	yy = y1+70+salto
	rayas = 1
	altura = 10
	While Not ORs.EOF 
	   		eq = trim(ORs.Fields.Item(0).Value)
			comp = ORs.Fields.Item(1).Value
			bit =  ORs.Fields.Item(2).Value
			var3 =  ORs.Fields.Item(3).Value
			var4 =  ORs.Fields.Item(4).Value
			var5 =  ORs.Fields.Item(5).Value
			var6 =  ORs.Fields.Item(6).Value
			var7 =  ORs.Fields.Item(7).Value
	  ORs.MoveNext
	  if not ORs.eof then
	  	if eq = trim(ORs.Fields.Item(0).Value) and comp = ORs.Fields.Item(1).Value and bit <> ORs.Fields.Item(2).Value and bit <> 0 then
			pdf.SetFont "arial","",5
			pdf.SetXY 13,yy+4
			if rayas >= 1 then
				post1 = 2.2 * cint(countWordWrap(var5, 46))
				'response.write cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
				post2 = 2.2 * cint(countWordWrap(var6, 46))
			end if
			'response.write  rayas & " " &altura & " " & cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
			pdf.Cell 19,altura, eq,"LR",0,"L", false
			pdf.SetXY 13+19,yy+8
			pdf.multiCell 28,altura-8, comp, 0, "J", false
			pdf.SetXY 13+19+28,yy+4
'			pdf.Cell 28,altura, ORs.Fields.Item(1).Value,"LR",0,"L", false
			pdf.Cell 11,altura, bit,"LR",0,"L", false
			pdf.Cell 15,altura, var3,"LR",0,"L", false
			pdf.Cell 13,altura, var4,"LR",0,"L", false
			'pdf.Cell 44,altura, WordWrap(ORs.Fields.Item(5).Value, 20),"LR",0,"L", false
			pdf.SetXY 13+19+28+11+15+13,yy+8
			pdf.multiCell 44,altura-8, var5, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44,yy+8			
			pdf.multiCell 42,altura-8, var6, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44+42,yy+7			
'			pdf.Cell 42,altura, ORs.Fields.Item(6).Value,"LR",0,"L", false
			if var7 = "ALTA" then
				pdf.setfillcolor 255,0,0
			elseif var7 = "MEDIA" then
				pdf.setfillcolor 255,255,0
			elseif var7 = "BAJA" then
				pdf.setfillcolor 0,102,255
			else
				pdf.setfillcolor 255,255,255
			end if
			pdf.Cell 16,altura-7, var7,"LR",0,"L", true
			rayas = rayas + 1
			
			If (post1 >= post2) Then
				post = post1
			Else
				post = post2
			End If
			
			yy = yy + 10 + post
			sum = sum + yy
			'response.write y1+yy+1+salto & "<br>"
			  if y1+yy+1+salto >= 220 then
				pdf.line 13, y1+71+salto , 13, y1+yy+1+salto
				pdf.line 13+19, y1+71+salto , 13+19, y1+yy+1+salto
				pdf.line 13+19+28, y1+71+salto , 13+19+28, y1+yy+1+salto
				pdf.line 13+19+28+11, y1+71+salto , 13+19+28+11, y1+yy+1+salto
				pdf.line 13+19+28+11+15, y1+71+salto , 13+19+28+11+15, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13, y1+71+salto , 13+19+28+11+15+13, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44, y1+71+salto , 13+19+28+11+15+13+44, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44+42, y1+71+salto , 13+19+28+11+15+13+44+42, y1+yy+1+salto
			  	pdf.line 13+19+28+11+15+13+44+42+16, y1+71+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.line 13+19+28+11+15+13+44+42+16+16, y1+71+salto, 13+19+28+11+15+13+44+42+16+16, y1+yy+1+salto	
				pdf.line 13, y1+yy+1+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.AddPage()
				encabezados_fpdf()
				rayas = 1
				'yy = 30
				sum = 0
				yy = y1+70+salto
			  else
			  	pdf.line 13, y1+yy-2+salto, 13+19+28+11+15+13+44+42+16, y1+yy-2+salto	
			  end if
		elseif eq = trim(ORs.Fields.Item(0).Value) and comp <> ORs.Fields.Item(1).Value then
			pdf.SetFont "arial","",5
			pdf.SetXY 13,yy+4
			if rayas >= 1 then
				post1 = 2.2 * cint(countWordWrap(var5, 46))
				'response.write cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
				post2 = 2.2 * cint(countWordWrap(var6, 46))
			end if
			'response.write  rayas & " " &altura & " " & cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
			pdf.Cell 19,altura, eq,"LR",0,"L", false
			pdf.SetXY 13+19,yy+8
			pdf.multiCell 28,altura-8, comp, 0, "J", false
			pdf.SetXY 13+19+28,yy+4
'			pdf.Cell 28,altura, ORs.Fields.Item(1).Value,"LR",0,"L", false
			pdf.Cell 11,altura, bit,"LR",0,"L", false
			pdf.Cell 15,altura, var3,"LR",0,"L", false
			pdf.Cell 13,altura, var4,"LR",0,"L", false
			'pdf.Cell 44,altura, WordWrap(ORs.Fields.Item(5).Value, 20),"LR",0,"L", false
			pdf.SetXY 13+19+28+11+15+13,yy+8
			pdf.multiCell 44,altura-8, var5, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44,yy+8			
			pdf.multiCell 42,altura-8, var6, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44+42,yy+7			
'			pdf.Cell 42,altura, ORs.Fields.Item(6).Value,"LR",0,"L", false
			if var7 = "ALTA" then
				pdf.setfillcolor 255,0,0
			elseif var7 = "MEDIA" then
				pdf.setfillcolor 255,255,0
			elseif var7 = "BAJA" then
				pdf.setfillcolor 0,102,255
			else
				pdf.setfillcolor 255,255,255
			end if
			pdf.Cell 16,altura-7, var7,"LR",0,"L", true
			rayas = rayas + 1
			
			If (post1 >= post2) Then
				post = post1
			Else
				post = post2
			End If
			
			yy = yy + 10 + post
			sum = sum + yy
			'response.write y1+yy+1+salto & "<br>"
			  if y1+yy+1+salto >= 220 then
				pdf.line 13, y1+71+salto , 13, y1+yy+1+salto
				pdf.line 13+19, y1+71+salto , 13+19, y1+yy+1+salto
				pdf.line 13+19+28, y1+71+salto , 13+19+28, y1+yy+1+salto
				pdf.line 13+19+28+11, y1+71+salto , 13+19+28+11, y1+yy+1+salto
				pdf.line 13+19+28+11+15, y1+71+salto , 13+19+28+11+15, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13, y1+71+salto , 13+19+28+11+15+13, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44, y1+71+salto , 13+19+28+11+15+13+44, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44+42, y1+71+salto , 13+19+28+11+15+13+44+42, y1+yy+1+salto
			  	pdf.line 13+19+28+11+15+13+44+42+16, y1+71+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.line 13+19+28+11+15+13+44+42+16+16, y1+71+salto, 13+19+28+11+15+13+44+42+16+16, y1+yy+1+salto	
				pdf.line 13, y1+yy+1+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.AddPage()
				encabezados_fpdf()
				rayas = 1
				'yy = 30
				sum = 0
				yy = y1+70+salto
			  else
			  	pdf.line 13, y1+yy-2+salto, 13+19+28+11+15+13+44+42+16, y1+yy-2+salto	
			  end if
		elseif eq <> trim(ORs.Fields.Item(0).Value) and comp <> ORs.Fields.Item(1).Value then
			pdf.SetFont "arial","",5
			pdf.SetXY 13,yy+4
			if rayas >= 1 then
				post1 = 2.2 * cint(countWordWrap(var5, 46))
				'response.write cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
				post2 = 2.2 * cint(countWordWrap(var6, 46))
			end if
			'response.write  rayas & " " &altura & " " & cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
			pdf.Cell 19,altura, eq,"LR",0,"L", false
			pdf.SetXY 13+19,yy+8
			pdf.multiCell 28,altura-8, comp, 0, "J", false
			pdf.SetXY 13+19+28,yy+4
'			pdf.Cell 28,altura, ORs.Fields.Item(1).Value,"LR",0,"L", false
			pdf.Cell 11,altura, bit,"LR",0,"L", false
			pdf.Cell 15,altura, var3,"LR",0,"L", false
			pdf.Cell 13,altura, var4,"LR",0,"L", false
			'pdf.Cell 44,altura, WordWrap(ORs.Fields.Item(5).Value, 20),"LR",0,"L", false
			pdf.SetXY 13+19+28+11+15+13,yy+8
			pdf.multiCell 44,altura-8, var5, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44,yy+8			
			pdf.multiCell 42,altura-8, var6, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44+42,yy+7			
'			pdf.Cell 42,altura, ORs.Fields.Item(6).Value,"LR",0,"L", false
			if var7 = "ALTA" then
				pdf.setfillcolor 255,0,0
			elseif var7 = "MEDIA" then
				pdf.setfillcolor 255,255,0
			elseif var7 = "BAJA" then
				pdf.setfillcolor 0,102,255
			else
				pdf.setfillcolor 255,255,255
			end if
			pdf.Cell 16,altura-7, var7,"LR",0,"L", true
			rayas = rayas + 1
			
			If (post1 >= post2) Then
				post = post1
			Else
				post = post2
			End If
			
			yy = yy + 10 + post
			sum = sum + yy
			'response.write y1+yy+1+salto & "<br>"
			  if y1+yy+1+salto >= 220 then
				pdf.line 13, y1+71+salto , 13, y1+yy+1+salto
				pdf.line 13+19, y1+71+salto , 13+19, y1+yy+1+salto
				pdf.line 13+19+28, y1+71+salto , 13+19+28, y1+yy+1+salto
				pdf.line 13+19+28+11, y1+71+salto , 13+19+28+11, y1+yy+1+salto
				pdf.line 13+19+28+11+15, y1+71+salto , 13+19+28+11+15, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13, y1+71+salto , 13+19+28+11+15+13, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44, y1+71+salto , 13+19+28+11+15+13+44, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44+42, y1+71+salto , 13+19+28+11+15+13+44+42, y1+yy+1+salto
			  	pdf.line 13+19+28+11+15+13+44+42+16, y1+71+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.line 13+19+28+11+15+13+44+42+16+16, y1+71+salto, 13+19+28+11+15+13+44+42+16+16, y1+yy+1+salto	
				pdf.line 13, y1+yy+1+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.AddPage()
				encabezados_fpdf()
				rayas = 1
				'yy = 30
				sum = 0
				yy = y1+70+salto
			  else
			  	pdf.line 13, y1+yy-2+salto, 13+19+28+11+15+13+44+42+16, y1+yy-2+salto	
			  end if
		end if
	  elseif ORs.eof then
			pdf.SetFont "arial","",5
			pdf.SetXY 13,yy+4
			if rayas >= 1 then
				post1 = 2.2 * cint(countWordWrap(var5, 46))
				'response.write cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
				post2 = 2.2 * cint(countWordWrap(var6, 46))
			end if
			'response.write  rayas & " " &altura & " " & cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
			pdf.Cell 19,altura, eq,"LR",0,"L", false
			pdf.SetXY 13+19,yy+8
			pdf.multiCell 28,altura-8, comp, 0, "J", false
			pdf.SetXY 13+19+28,yy+4
'			pdf.Cell 28,altura, ORs.Fields.Item(1).Value,"LR",0,"L", false
			pdf.Cell 11,altura, bit,"LR",0,"L", false
			pdf.Cell 15,altura, var3,"LR",0,"L", false
			pdf.Cell 13,altura, var4,"LR",0,"L", false
			'pdf.Cell 44,altura, WordWrap(ORs.Fields.Item(5).Value, 20),"LR",0,"L", false
			pdf.SetXY 13+19+28+11+15+13,yy+8
			pdf.multiCell 44,altura-8, var5, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44,yy+8			
			pdf.multiCell 42,altura-8, var6, 0, "J", false
			pdf.SetXY 13+19+28+11+15+13+44+42,yy+7			
'			pdf.Cell 42,altura, ORs.Fields.Item(6).Value,"LR",0,"L", false
			if var7 = "ALTA" then
				pdf.setfillcolor 255,0,0
			elseif var7 = "MEDIA" then
				pdf.setfillcolor 255,255,0
			elseif var7 = "BAJA" then
				pdf.setfillcolor 0,102,255
			else
				pdf.setfillcolor 255,255,255
			end if
			pdf.Cell 16,altura-7, var7,"LR",0,"L", true
			rayas = rayas + 1
			
			If (post1 >= post2) Then
				post = post1
			Else
				post = post2
			End If
			
			yy = yy + 10 + post
			sum = sum + yy
			'response.write y1+yy+1+salto & "<br>"
			  if y1+yy+1+salto >= 220 then
				pdf.line 13, y1+71+salto , 13, y1+yy+1+salto
				pdf.line 13+19, y1+71+salto , 13+19, y1+yy+1+salto
				pdf.line 13+19+28, y1+71+salto , 13+19+28, y1+yy+1+salto
				pdf.line 13+19+28+11, y1+71+salto , 13+19+28+11, y1+yy+1+salto
				pdf.line 13+19+28+11+15, y1+71+salto , 13+19+28+11+15, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13, y1+71+salto , 13+19+28+11+15+13, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44, y1+71+salto , 13+19+28+11+15+13+44, y1+yy+1+salto
				pdf.line 13+19+28+11+15+13+44+42, y1+71+salto , 13+19+28+11+15+13+44+42, y1+yy+1+salto
			  	pdf.line 13+19+28+11+15+13+44+42+16, y1+71+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.line 13+19+28+11+15+13+44+42+16+16, y1+71+salto, 13+19+28+11+15+13+44+42+16+16, y1+yy+1+salto	
				pdf.line 13, y1+yy+1+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
				pdf.AddPage()
				encabezados_fpdf()
				rayas = 1
				'yy = 30
				sum = 0
				yy = y1+70+salto
			  else
			  	pdf.line 13, y1+yy-2+salto, 13+19+28+11+15+13+44+42+16, y1+yy-2+salto	
			  end if
	  end if
	Wend
	Set ORs = Nothing
	Set ODB = Nothing
				pdf.line 13, y1+71+salto , 13, y1+yy-2+salto
				pdf.line 13+19, y1+71+salto , 13+19, y1+yy-2+salto
				pdf.line 13+19+28, y1+71+salto , 13+19+28, y1+yy-2+salto
				pdf.line 13+19+28+11, y1+71+salto , 13+19+28+11, y1+yy-2+salto
				pdf.line 13+19+28+11+15, y1+71+salto , 13+19+28+11+15, y1+yy-2+salto
				pdf.line 13+19+28+11+15+13, y1+71+salto , 13+19+28+11+15+13, y1+yy-2+salto
				pdf.line 13+19+28+11+15+13+44, y1+71+salto , 13+19+28+11+15+13+44, y1+yy-2+salto
				pdf.line 13+19+28+11+15+13+44+42, y1+71+salto , 13+19+28+11+15+13+44+42, y1+yy-2+salto
			  	pdf.line 13+19+28+11+15+13+44+42+16, y1+71+salto, 13+19+28+11+15+13+44+42+16, y1+yy-2+salto	
				pdf.line 13+19+28+11+15+13+44+42+16+16, y1+71+salto, 13+19+28+11+15+13+44+42+16+16, y1+yy-2+salto	
'				pdf.line 13, y1+yy+1+salto, 13+19+28+11+15+13+44+42+16, y1+yy+1+salto	
	
'				pdf.line 13, y1+27+salto , 13, y1+yy+1+salto
'				pdf.line 13+5, y1+27+salto , 13+5, y1+yy+1+salto
'				pdf.line 13+14, y1+27+salto , 13+14, y1+yy+1+salto
'				pdf.line 13+28, y1+27+salto , 13+28, y1+yy+1+salto
'				pdf.line 13+44, y1+27+salto , 13+44, y1+yy+1+salto
'				pdf.line 13+84, y1+27+salto , 13+84, y1+yy+1+salto
'				pdf.line 13+94, y1+27+salto , 13+94, y1+yy+1+salto
'				pdf.line 13+120, y1+27+salto , 13+120, y1+yy+1+salto
'				pdf.line 13+132, y1+27+salto , 13+132, y1+yy+1+salto
'				pdf.line 13+140, y1+27+salto , 13+140, y1+yy+1+salto
'				pdf.line 13+176, y1+27+salto , 13+176, y1+yy+1+salto
'				
'				pdf.line 13+182, y1+27+salto , 13+182, y1+yy+1+salto
'				pdf.line 13+197, y1+27+salto , 13+197, y1+yy+1+salto
'				
'				pdf.line 13+222, y1+27+salto , 13+222, y1+yy+1+salto
'				pdf.line 13+231, y1+27+salto , 13+231, y1+yy+1+salto
'				pdf.line 13+241, y1+27+salto , 13+241, y1+yy+1+salto
'				pdf.line 13+255, y1+27+salto , 13+255, y1+yy+1+salto
'
'	
'	pdf.line 13, y1+yy+1+salto, 268, y1+yy+1+salto
pdf.Output ()
pdf.Close()
%>
