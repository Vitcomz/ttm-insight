<%
Option Explicit
Dim OReg, query, OCon, ID
Set OCon = Server.CreateObject("ADODB.Connection")
ID=REQUEST("ID")
'OCon.Open "Provider=MSDAORA.1;Password=pass;User ID=usuario; Data Source=dtsource; Persist Security Info=True"'

OCon.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\SistemasWeb\Vitcomz\AppWeb\SCI\SCI.MDB;User Id=admin;Password=;"
OCon.BeginTrans
query = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK FROM MENU "

Set OReg = OCon.Execute(query)
Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
Response.Write "<XML>"
While Not OReg.EOF 
  Response.Write "<ROW>"
  Response.Write "<CODIGO>" & OReg.Fields.Item(0).Value & "</CODIGO>"
  Response.Write "<COD_MENU_PADRE>" & OReg.Fields.Item(1).Value & "</COD_MENU_PADRE>"
  Response.Write "<NOMBRE>" & OReg.Fields.Item(2).Value & "</NOMBRE>"
  Response.Write "<LINK>" & OReg.Fields.Item(3).Value & "</LINK>"
  Response.Write "</ROW>"
  OReg.MoveNext
Wend
Response.Write "</XML>"
OCon.CommitTrans()
OCon.Close()
Set OReg = Nothing
Set OCon = Nothing
%>

