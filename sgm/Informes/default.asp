<%@language=vbscript%>
<!--#include file="fpdf.asp"-->
<%
 
Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.SetPath("fpdf/")
pdf.SetFont "Arial","",16
pdf.Open()
pdf.AddPage()
pdf.Cell 40,10,"Esto es un PDF creado desde ASP."
 

pdf.Close()
pdf.Output()
%> 

