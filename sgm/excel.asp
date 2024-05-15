<%

set objExcelApp = CreateObject("Excel.Application") 
objExcelApp.DisplayAlerts = false 
objExcelApp.Application.Visible = false

objExcelApp.WorkBooks.add 
set objExcelBook = objExcelApp.ActiveWorkBook 
set objExcelSheets = objExcelBook.Worksheets 
set objExcelSheet = objExcelBook.Sheets(1)

strAddr = Server.MapPath(".") 
objExcelApp.WorkBooks.Open(strAddr & "\files\Table.xls") 
set objExcelBook = objExcelApp.ActiveWorkBook 
set objExcelSheets = objExcelBook.Worksheets 
set objExcelSheet = objExcelBook.Sheets(1)

objExcelBook.SaveAs strAddr & "\files\Table.xls"
objExcelBook.Save

objExcelSheet.Range("B3:k3").Value = Array("67", "87", "5", "9", "7", "45", "45", "54", "54", "10")
objExcelSheet.Cells(3,1).Value="Internet Explorer"


%>

