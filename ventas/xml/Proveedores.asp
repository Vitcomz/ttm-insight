<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
DV=UCASE(REQUEST("DV"))
TXTSRC=REQUEST("TXTSRC")
RUT=REQUEST("RUT")
NOMBRE=UCASE(REQUEST("NOMBRE"))
DIRECCION=UCASE(REQUEST("DIRECCION"))
OBSERVACION=UCASE(REQUEST("OBSERVACION"))
FONO=UCASE(REQUEST("FONO"))
FAX=UCASE(REQUEST("FAX"))
EMAIL=REQUEST("EMAIL")
WEB=REQUEST("WEB")
CELULAR=UCASE(REQUEST("CELULAR"))
CONTACTO=UCASE(REQUEST("CONTACTO"))
RUBRO=UCASE(REQUEST("RUBRO"))
INDICE=UCASE(REQUEST("INDICE"))
CIUDAD=UCASE(REQUEST("CIUDAD"))


Select Case RECURSO
	Case "ListCiudades"
		ListCiudades()
		
	Case "ListOCxProv"
		  ListOCxProv()
		
	Case "GetProv"
		GetProv()
		
	Case "ExisteProveedor"
		  ExisteProveedor()
			
	Case "DelProv"
		  DelProv()
		
	Case "NewProv"
		  NewProv()
		
	Case "UpdateProv"
		  UpdateProv()
		
	Case "ListProv"
		  ListProv()
End Select


function ListCiudades()
	query = "SELECT ID, NOMBRE FROM CIUDADES" 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<NOMBRE_CIUDAD>" & ORs.Fields.Item(1).Value & "</NOMBRE_CIUDAD>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewProv()

	query = "INSERT INTO PROVEEDORES (RUT, DV, NOMBRE, "
	query = query & "DIRECCION, FONO, FAX, CELULAR, EMAIL, WEB, CONTACTO, RUBRO, CIUDAD, OBSERVACION,"
	query = query & "IND_ACTIVACION, USERDATE) VALUES ("
	query = query & RUT & "," & strNvl(DV) & "," & strNvl(NOMBRE) & "," & strNvl(DIRECCION) & "," 
	query = query & strNvl(FONO) & "," & strNvl(FAX) & "," & strNvl(CELULAR) & "," & strNvl(EMAIL) & "," & strNvl(WEB)
	query = query & "," & strNvl(CONTACTO) & "," & strNvl(RUBRO)  & "," & strNvl(CIUDAD)  &  "," & strNvl(OBSERVACION) 
	query = query & "," & strNvl(INDICE) & ",getdate());"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

Function ExisteProveedor()
	
	query = "SELECT * FROM PROVEEDORES WHERE RUT=" & RUT & ""
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
		
	If ORs.Eof Then
		Response.Write "<EXISTE>FALSE</EXISTE>"
	Else
		Response.Write "<EXISTE>TRUE</EXISTE>"
	End If
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
	
End Function

function DelProv()
	query = "DELETE FROM PROVEEDORES WHERE RUT_PROVEEDOR="& RUT &""
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write"OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function

function GetProv()
	query = "SELECT RUT, DV, NOMBRE, DIRECCION, FONO, FAX, "
	query = query & " CELULAR,EMAIL,WEB, CONTACTO, RUBRO, CIUDAD, OBSERVACION, IND_ACTIVACION "
	query = query & " FROM PROVEEDORES WHERE RUT=" & RUT & "" 
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "-" &  ORs.Fields.Item(1).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(3).Value & "</DIRECCION>"
		  Response.Write "<FONO>" & ORs.Fields.Item(4).Value & "</FONO>"
		  Response.Write "<FAX>" & ORs.Fields.Item(5).Value & "</FAX>"
  		  Response.Write "<CELULAR>" & ORs.Fields.Item(6).Value & "</CELULAR>"
   		  Response.Write "<EMAIL>" & ORs.Fields.Item(7).Value & "</EMAIL>"
     	  Response.Write "<WEB>" & ORs.Fields.Item(8).Value & "</WEB>"
       	  Response.Write "<CONTACTO>" & ORs.Fields.Item(9).Value & "</CONTACTO>"
       	  Response.Write "<RUBRO>" & ORs.Fields.Item(10).Value & "</RUBRO>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(11).Value & "</CIUDAD>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(12).Value & "</OBSERVACION>"
		  Response.Write "<INDICE>" & ORs.Fields.Item(13).Value & "</INDICE>"
		  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateProv()
	query = "UPDATE PROVEEDORES SET DIRECCION=" & strNvl(DIRECCION) & ","
	query = query & "CIUDAD=" & strNvl(CIUDAD) & ", "
	query = query & "NOMBRE=" & strNvl(NOMBRE) & ","
	query = query & "FONO=" & strNvl(FONO) & ", "
	query = query & "FAX=" & strNvl(FAX) & ","
	query = query & "WEB=" & strNvl(WEB) & ","
	query = query & "EMAIL=" & strNvl(EMAIL) & ", "
	query = query & "CELULAR=" & strNvl(CELULAR) & ", "
	query = query & "CONTACTO=" & strNvl(CONTACTO) & ", "
	query = query & "RUBRO=" & strNvl(RUBRO) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ", "
	query = query & "IND_ACTIVACION=" & strNvl(INDICE) & ", "
	query = query & "USERDATE= getdate() "
	query = query & "WHERE RUT="& RUT & "" 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListProv()
	query = "SELECT RUT, DV, NOMBRE, DIRECCION, FONO, FAX, CIUDAD,"
	query = query & " OBSERVACION, IND_ACTIVACION FROM PROVEEDORES "
	query = query & " WHERE NOMBRE LIKE '%" & TXTSRC & "%'"
	query = query & " ORDER BY NOMBRE "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<DIRECCION>" & ORs.Fields.Item(3).Value & "</DIRECCION>"
		  Response.Write "<FONO>" & ORs.Fields.Item(4).Value & "</FONO>"
		  Response.Write "<FAX>" & ORs.Fields.Item(5).Value & "</FAX>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(6).Value & "</CIUDAD>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(7).Value & "</OBSERVACION>"
		  Response.Write "<INDICE>" & ORs.Fields.Item(8).Value & "</INDICE>"
		  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListOCxProv()
	
	query = "SELECT RUT, NOMBRE,"
	query = query & "  OC.FOLIO, RTRIM(CONVERT(CHAR,OC.FECHA,103)), "
	query = query & "  OC.PROJECTO, OC.TIPO_MONEDA, "
	query = query & "  RESPONSABLE, AREA "
	query = query & "  FROM PROVEEDORES AS P, ORDEN_COMPRA AS OC "
	query = query & "  WHERE P.NOMBRE LIKE '%" & TXTSRC & "%' "
	query = query & "    AND OC.PROVEEDOR = P.RUT "
	query = query & "    ORDER BY NOMBRE " 
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
		  Response.Write "<FOLIO>" & ORs.Fields.Item(2).Value & "</FOLIO>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
		  Response.Write "<PROJECTO>" & ORs.Fields.Item(4).Value & "</PROJECTO>"
		  Response.Write "<MONEDA>" & ORs.Fields.Item(5).Value & "</MONEDA>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
		  Response.Write "<AREA>" & ORs.Fields.Item(7).Value & "</AREA>"
		  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>

