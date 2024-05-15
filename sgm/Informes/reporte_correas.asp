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
	pdf.Text x1+70, y1+32+salto, "Informe Correas TTM -  Fecha: "&FormatDateTime(now,2)
	
	pdf.SetFont "arial","B",5
	'PDF.rect x1+7, y1+35+salto, 188, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
'	PDF.rect x1+7, y1+35+salto, 16+15+11, 4 'dibujo rectangulo
	PDF.rect x1+7, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+12, 6 'dibujo rectangulo
	
	
	PDF.Text x1+len("Area")+8, y1+37+salto, "Area"
	PDF.Text x1+len("TAG Equipo")+15, y1+37+salto, "TAG Equipo"
	
	PDF.Text x1+len("Largo")+35, y1+37+salto, "Largo"
	PDF.Text x1+len("Total [m]")+30, y1+37+salto+2, "Total [m]"
	
	PDF.Text x1+len("Tramos")+42, y1+37+salto, "Tramos"
	
	PDF.Text x1+len("Status")+52, y1+37+salto, "Status"
	PDF.Text x1+len("Tramo")+53, y1+37+salto+2, "Tramo"
	
	PDF.Text x1+len("Observacion Tramo")+60, y1+37+salto, "Observacion Tramo"
	
	PDF.Text x1+len("Marca")+108, y1+37+salto, "Marca"
	PDF.Text x1+len("Modelo")+122, y1+37+salto, "Modelo"
	
	PDF.Text x1+len("Largo")+135, y1+37+salto, "Largo"
	PDF.Text x1+len("Tramo [m]")+130, y1+37+salto+2, "Tramo [m]"
	
	PDF.Text x1+len("Espesor")+142, y1+37+salto, "Espesor"
	PDF.Text x1+len("Min [mm]")+141, y1+37+salto+2, "Min [mm]"
	
	PDF.Text x1+len("Fecha Ultima")+147, y1+37+salto, "Fecha Ultima"
	PDF.Text x1+len("Medicion espesor")+142, y1+37+salto+2, "Medicion espesor"	
	
	PDF.Text x1+len("Emp")+172, y1+37+salto, "Emp"
	
	PDF.Text x1+len("Status")+178, y1+37+salto, "Status"
	PDF.Text x1+len("Emp")+182, y1+37+salto+2, "Emp"	
	
	PDF.Text x1+len("Observaciones Empalme")+179, y1+37+salto, "Observaciones Empalme"
	
	PDF.Text x1+len("Fecha Creacion")+220, y1+37+salto, "Fecha Creacion"
	PDF.Text x1+len("Empalme")+229, y1+37+salto+2, "Empalme"	
	
	PDF.Text x1+len("Largo")+246, y1+37+salto, "Largo"
	PDF.Text x1+len("Emp [mm]")+241, y1+37+salto+2, "Emp [mm]"
	

	
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
pdf.CreatePDF "L","mm","Letter"
pdf.SetPath("fpdf/")
pdf.Open()

' COORDENADAS INICIALES
pdf.SetAutoPageBreak true, default 
'pdf.SetDisplayMode "real", "default"' "two"
x1 = 6
y1 = 0
x2 = 193
y2 = 260
yy = -15

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
	query = " SELECT ISNULL(E.SECCION,'') AREA, DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA)  & ") TAG_EQUIP , ISNULL(EC.LARGO,'') AS LARGO_TOTAL, "
	query = query & "'T'+left(SUBSTRING(E.DESCRIPCION,CHARINDEX(' ',E.DESCRIPCION)+1,10),CHARINDEX(' ',SUBSTRING(E.DESCRIPCION,CHARINDEX(' ',E.DESCRIPCION)+1,10))) as TRA, "
	query = query & "ISNULL(B.CRITICIDAD2,'') AS STATUS_TRA, ISNULL(B.DESCRIPCION,'') AS OBS_TRA ,  ISNULL(E.MARCA,''), ISNULL(E.MODELO,''), ISNULL(E.LARGO,'') AS LARGO_TRA, ISNULL(MD1.VALOR,'') as ESP_MAS_BAJO, MD1.FECHA FECHA_ULT_MEDICION, "
	query = query & "ISNULL(SUBSTRING(E2.CODIGO,CHARINDEX('EMP',E2.CODIGO)+3,3),'') EMP, ISNULL(B2.CRITICIDAD2,'') AS STATUS_EMP, ISNULL(B2.DESCRIPCION,'') AS OBS_EMP, E2.FECHA_ULT_MAN AS FECH_CREAC_EMP, "
	query = query & "ISNULL(E2.LARGO,'') AS LARGO_EMP FROM EQUIPOS AS E  LEFT JOIN ( "
	query = query & "SELECT UBICACION, EQUIPO, FECHA, CRITICIDAD2, DESCRIPCION, RANK() OVER (PARTITION BY UBICACION, EQUIPO ORDER BY FECHA DESC) AS LUGAR "
	query = query & "FROM BITACORAS WHERE UBICACION = " & strNvl(FAENA)  & " AND IND_SOLUCION = 'false') AS B on "
	query = query & "E.CODIGO = B.EQUIPO AND E.UBICACION = B.UBICACION AND B.LUGAR = 1 LEFT JOIN EQUIPOS AS E2 ON  "
	query = query & "DBO.EquipoPrincipalFaena(E.CODIGO, E.UBICACION) = DBO.EquipoPrincipalFaena(E2.CODIGO, E2.UBICACION) "
	query = query & "AND E.UBICACION = E2.UBICACION "
	query = query & "AND REPLACE(SUBSTRING(E.CODIGO,CHARINDEX('TRA',E.CODIGO)+3,2),'-','') = REPLACE(SUBSTRING(E2.CODIGO,CHARINDEX('EMP',E2.CODIGO)+3,2),'-','') "
	query = query & "AND E2.TIPO_EQUIPO = 23 AND E2.COD_EQUIPO_PADRE LIKE '%EMP%' LEFT JOIN EQUIPOS AS EC ON  "
	query = query & "DBO.EquipoPrincipalFaena(E.CODIGO, E.UBICACION) = DBO.EquipoPrincipalFaena(EC.CODIGO, EC.UBICACION) "
	query = query & "AND E.UBICACION = EC.UBICACION AND EC.CODIGO LIKE '%CIN'  LEFT OUTER JOIN ( "
	query = query & "SELECT UBICACION, EQUIPO, FECHA, CRITICIDAD2, DESCRIPCION, RANK() OVER (PARTITION BY UBICACION, EQUIPO ORDER BY FECHA DESC) AS LUGAR "
	query = query & "FROM BITACORAS WHERE UBICACION = " & strNvl(FAENA)  & " AND IND_SOLUCION = 'false'  "
    query = query & ") AS B2 on 	E.CODIGO = B2.EQUIPO AND E.UBICACION = B2.UBICACION AND B2.LUGAR = 1 "
    query = query & "LEFT JOIN (SELECT M.EQUIPO, M.FAENA, M.FECHA, MIN(MV.VALOR) AS VALOR, RANK() OVER (PARTITION BY M.FAENA, M.EQUIPO ORDER BY M.FECHA DESC) AS LUGAR "
	query = query & " FROM MEDICIONES M INNER JOIN MEDICIONES_VALOR MV ON M.FOLIO = MV.FOLIO "
	query = query & "WHERE M.FAENA = " & strNvl(FAENA)  & " AND MV.TIPO = 'CAR' AND MV.VALOR > 0 GROUP BY M.EQUIPO, M.FAENA,  M.FECHA "
    query = query & ") AS MD1 ON E.CODIGO = MD1.EQUIPO AND E.UBICACION = MD1.FAENA AND MD1.LUGAR = 1 "
	query = query & "WHERE 	E.ESTADO = 'ACT' 	AND E.COD_EQUIPO_PADRE LIKE '%TRA%'	AND E.UBICACION = " & strNvl(FAENA)  
	query = query & "AND E.TIPO_EQUIPO = 22 ORDER BY E.SECCION, DBO.EquipoPrincipalFaena(E.CODIGO, " & strNvl(FAENA)  & ")"

	Dim oDB
	Set oDB = New DBConn
	Set ORs =oDB.EjecutaSql(query)
	yy = y1+39+salto
	rayas = 1
	altura = 8
	While Not ORs.EOF 
			pdf.SetFont "arial","",5
			pdf.SetXY 13,yy
			if rayas >= 1 then
				post1 = 2.1 * cint(countWordWrap(ORs.Fields.Item(5).Value, 42))
				'response.write cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
				post2 = 2.1 * cint(countWordWrap(ORs.Fields.Item(13).Value, 42))
			end if
			'response.write  rayas & " " &altura & " " & cint(countWordWrap(ORs.Fields.Item(4).Value, 29)) & "<br>"
			pdf.Cell 16,altura, ORs.Fields.Item(0).Value,"LR",0,"L", false
			pdf.SetXY 13+16,yy+4
			pdf.Cell 15,altura-8, ORs.Fields.Item(1).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15,yy
			pdf.Cell 9,altura, ORs.Fields.Item(2).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9,yy
			pdf.Cell 9,altura, ORs.Fields.Item(3).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9,yy
			pdf.Cell 9,altura, ORs.Fields.Item(4).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9,yy+2
			pdf.multiCell 42,altura-5, ORs.Fields.Item(5).Value, 0, "J", false
			
			pdf.SetXY 13+16+15+9+9+9+42,yy+2
			pdf.multiCell 16,altura-4, ORs.Fields.Item(6).Value, 0, "J", false 
			'pdf.Cell  9,altura, WordWrap(ORs.Fields.Item(8).Value, 30),"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16,yy+2	
			pdf.multiCell 16,altura-4, ORs.Fields.Item(7).Value, 0, "J", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16,yy		
			pdf.Cell  9,altura, ORs.Fields.Item(8).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9,yy
			pdf.Cell 9,altura, ORs.Fields.Item(9).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9+9,yy
			if not isnull(ORs.Fields.Item(10).Value) then
				dat = FormatDateTime(ORs.Fields.Item(10).Value,2)
			else
				dat = ""
			end if
			pdf.Cell 16,altura, dat,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9+9+16,yy
			pdf.Cell 9,altura, ORs.Fields.Item(11).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9+9+16+9,yy
			pdf.Cell 9,altura, ORs.Fields.Item(12).Value,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9+9+16+9+9,yy+2
			pdf.multiCell 42,altura-5, ORs.Fields.Item(13).Value, 0, "J", false
			
			'pdf.Cell 30,altura, left(ORs.Fields.Item(9).Value,22),"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42,yy
			if not isnull(ORs.Fields.Item(14).Value) then
				dat = FormatDateTime(ORs.Fields.Item(14).Value,2)
			else
				dat = ""
			end if
			
			pdf.Cell 16,altura, dat,"LR",0,"L", false
			pdf.SetXY 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16,yy
			pdf.Cell 9,altura, ORs.Fields.Item(15).Value,"LR",0,"L", false
			
			'pdf.line 13, y1+yy+1+salto, 268, y1+yy+1+salto
			'response.write "tope " &  y1+yy+1+salto & "<br>" 
			rayas = rayas + 1
			
			If (post1 >= post2) Then
				post = post1
			Else
				post = post2
			End If
			
			yy = yy + 10 + post
			sum = sum + yy
			'response.write y1+yy+1+salto & "<br>"
			  if y1+yy+1+salto >= 180 then
				pdf.line 13, y1+35+salto , 13, y1+yy+1+salto
				pdf.line 13+16, y1+35+salto , 13+16, y1+yy+1+salto
				pdf.line 13+16+15, y1+35+salto , 13+16+15, y1+yy+1+salto
				pdf.line 13+16+15+9, y1+35+salto , 13+16+15+9, y1+yy+1+salto
				pdf.line 13+16+15+9+9, y1+35+salto , 13+16+15+9+9, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9, y1+35+salto , 13+16+15+9+9+9, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42, y1+35+salto , 13+16+15+9+9+9+42, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42+16, y1+35+salto , 13+16+15+9+9+9+42+16, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42+16+16, y1+35+salto , 13+16+15+9+9+9+42+16+16, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42+16+16+9, y1+35+salto , 13+16+15+9+9+9+42+16+16+9, y1+yy+1+salto
			  	pdf.line 13+16+15+9+9+9+42+16+16+9+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+yy+1+salto	
				
				pdf.line 13, y1+yy+1+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+yy+1+salto	
				pdf.AddPage()
				encabezados_fpdf()
				rayas = 1
				'yy = 30
				sum = 0
				yy = y1+41+salto
			  else
			  	pdf.line 13, y1+yy+1+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+yy+1+salto	
			  end if
'			  if rayas = 2 then 
'			  	response.end 
'			end if
	  ORs.MoveNext
	Wend
	Set ORs = Nothing
	Set ODB = Nothing
				pdf.line 13, y1+35+salto , 13, y1+yy+1+salto
				pdf.line 13+16, y1+35+salto , 13+16, y1+yy+1+salto
				pdf.line 13+16+15, y1+35+salto , 13+16+15, y1+yy+1+salto
				pdf.line 13+16+15+9, y1+35+salto , 13+16+15+9, y1+yy+1+salto
				pdf.line 13+16+15+9+9, y1+35+salto , 13+16+15+9+9, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9, y1+35+salto , 13+16+15+9+9+9, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42, y1+35+salto , 13+16+15+9+9+9+42, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42+16, y1+35+salto , 13+16+15+9+9+9+42+16, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42+16+16, y1+35+salto , 13+16+15+9+9+9+42+16+16, y1+yy+1+salto
				pdf.line 13+16+15+9+9+9+42+16+16+9, y1+35+salto , 13+16+15+9+9+9+42+16+16+9, y1+yy+1+salto
			  	pdf.line 13+16+15+9+9+9+42+16+16+9+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16, y1+yy+1+salto	
				pdf.line 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+35+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+yy+1+salto	
				
				'pdf.line 13, y1+yy+1+salto, 13+16+15+9+9+9+42+16+16+9+9+16+9+9+42+16+9, y1+yy+1+salto
				
				
				
				
				
				
				
				
'				pdf.line 13, y1+yy+1+salto, 13+16+15+11+15+13+44+42+16, y1+yy+1+salto	
	
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
'				pdf.line 13+167, y1+27+salto , 13+197, y1+yy+1+salto
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
