<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../standard/DBConn.asp" -->

<%
Dim query, ID
Dim oDB
Set oDB = New DBConn
'response.Charset="UTF-8"
Session.LCID = 2057
	RECURSO=REQUEST("RECURSO")
	FECHA_INI=REQUEST("FECHA_INI")
	FECHA_FIN=REQUEST("FECHA_FIN")
	FAENA = REQUEST("FAENA")

'Session.LCID = 2057

select case RECURSO
		
	case "ListInspeccion"
		 ListInspeccion()
		 
end select

function ListInspeccion()

	Dim EquipoAnterior
	Dim STR
	
	STR=""
	
	
	
	'response.write query
	'response.end

	Set Cn = oDB.Conexion

	'Set ORs =oDB.EjecutaSql(query)
	STR =	"EXECUTE SP_BITACORA_EXCEL @FAENA=" & strNvl(FAENA)  
	STR = STR & ", @INI=" & strNvl(FECHA_INI)
	STR = STR & ", @FIN=" & strNvl(FECHA_FIN)   
	
	on error resume next 
	
 	Set ORs = Cn.Execute (STR)
	
	'response.Write( Server.ScriptTimeout)
	
'	response.Write( err.description)
	
'	Server.ScriptTimeout=500
	
'	response.Write( Server.ScriptTimeout)
	
'	exit function
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = FAENA & "_" & strName & ".xls"
		Response.ContentType = "application/vnd.ms-excel"
        'Response.Charset = "UTF-8";
		'Response.CodePage = 65001
		'Response.CharSet = "utf-8"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
		'Response.Write "<?xml version='1.0' encoding='UTF-8' ?>" 
		Response.Charset = "UTF-8"
		'Response.AddHeader "Content-Type", "text/html; charset=utf-8"
		'Response.AddHeader "Pragma", "no-cache"

		
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"

				   Response.Write "<TD>NUMERO</TD>"
   				   Response.Write "<TD>ID</TD>"
   				   Response.Write "<TD>FECHA</TD>"
				   Response.Write "<TD>RESPONSABLE</TD>"
				   Response.Write "<TD>MODO FALLA</TD>"
				   Response.Write "<TD>DESCRIPCION</TD>"
				   Response.Write "<TD>IND_INCIDENTE</TD>"
				   Response.Write "<TD>COLOR_CRITICIDAD</TD>"
				   Response.Write "<TD>CRITICIDAD</TD>"
				   Response.Write "<TD>CAUSA</TD>"
				   Response.Write "<TD>DIAS</TD>"
				   Response.Write "<TD>FAENA</TD>"
				   Response.Write "<TD>EQUIPO_PRI</TD>"
				   Response.Write "<TD>DESC_EQUIPO</TD>"
				   Response.Write "<TD>EQUIPO_SEC</TD>"
				   Response.Write "<TD>DESC_EQ_SEC</TD>"
				   Response.Write "<TD>COMPONENTE</TD>"
				   Response.Write "<TD>DESC_COMP</TD>"
				   Response.Write "<TD>RECOMENDACION</TD>"
				   Response.Write "<TD>AVISO</TD>"
				   Response.Write "<TD>OT</TD>"
				   Response.Write "<TD>STATUS</TD>"
				   Response.Write "<TD>CONDICION</TD>"
				   Response.Write "<TD>IND_SOLUCION</TD>"
				   Response.Write "<TD>ARCHIVOS</TD>"
				   Response.Write "<TD>ULT_ACT</TD>"
				   Response.Write "<TD>STATUS</TD>"
				   
				   
			 Response.Write "</TR>"
		While Not ORs.EOF

			  Response.Write "<TR>"
			  Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
  			  Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(11).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(12).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(13).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(14).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(28).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(16).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(17).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(18).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(19).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(20).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(21).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(22).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(23).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(24).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(25).Value & "</TD>"			  			  
			  Response.Write "<TD>" & ORs.Fields.Item(26).Value & "</TD>"
			  Response.Write "</TR>"
			  		
	  		ORs.MoveNext

		Wend
	    Response.Write "</TABLE>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

%>