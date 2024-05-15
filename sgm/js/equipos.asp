﻿<!--#include file="DBConn.asp" -->
<!--#include file="aspJSON1.18.asp" -->

<%
Dim query, ID
Dim oDB
Set oDB = New DBConn


	RECURSO=REQUEST("RECURSO")
	ANCHO=REQUEST("ANCHO")
	CODIGO=UCASE(REQUEST("CODIGO"))
	CARGA=UCASE(REQUEST("CARGA"))
	COD_EQUIPO=UCASE(REQUEST("COD_EQUIPO"))
	COD_EQUIPO_PADRE=UCASE(REQUEST("COD_EQUIPO_PADRE"))
	COLOR=UCASE(REQUEST("COLOR"))
	CIUDAD=REQUEST("CIUDAD")
	CRITICIDAD=REQUEST("CRITICIDAD")
	CAPACIDAD=REQUEST("CAPACIDAD")
	DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
	DIMENSIONES=UCASE(REQUEST("DIMENSIONES"))
	ESCALA=REQUEST("ESCALA")
	ESCALA_ALARM=REQUEST("ESCALA_ALARM")
	ESTADO=REQUEST("ESTADO")
   	EMPRESA	=REQUEST("EMPRESA")
	EQUIPO=REQUEST("EQUIPO")
	ESPESOR=REQUEST("ESPESOR")
	ESPESOR_R=REQUEST("ESPESOR_R")
	
	EXCEL=REQUEST("EXCEL")
	FOLIO_OT=REQUEST("FOLIO_OT")
	FECHA=REQUEST("FECHA")
	FECHA_INST=REQUEST("FECHA_INST")
	FACTURA = REQUEST("FACTURA")
	FAENA = REQUEST("FAENA")
	FECHA_ULT_MAN=REQUEST("FECHA_ULT_MAN")
	GRUPO=UCASE(REQUEST("GRUPO"))
	GSAP=UCASE(REQUEST("GSAP"))
	STRC=UCASE(REQUEST("c"))
	SERIE=REQUEST("SERIE")
	SECCION=REQUEST("SECCION")
	SECTOR=REQUEST("SECTOR")
	MARCA=UCASE(REQUEST("MARCA"))
	RETORNO=UCASE(REQUEST("RETORNO"))
	PLANTA=UCASE(REQUEST("PLANTA"))
	MODELO=UCASE(REQUEST("MODELO"))
	PROVEEDOR=REQUEST("PROVEEDOR") 
	RESPONSABLE=REQUEST("RESPONSABLE") 
	OBSERVACION=UCASE(REQUEST("OBSERVACION"))
	ORDEN=UCASE(REQUEST("ORDEN"))
	RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
   
	UBICACION=REQUEST("UBICACION")
	USUARIO=REQUEST("USUARIO")
	USERNAME=REQUEST("USERNAME")	
	TIPO_ASG=REQUEST("TIPO_ASG")
	LARGO=REQUEST("LARGO")
	TIPO_EQUIPO=REQUEST("TIPO_EQUIPO")
	TIPO_HOROMETRO=UCASE(REQUEST("TIPO_HOR"))
	TIPO_COMBUSTIBLE=UCASE(REQUEST("TIPO_COMBUSTIBLE"))
	TEXT=UCASE(REQUEST("TEXT"))
   
	PROPIETARIO=REQUEST("PROPIETARIO")
	PRIORIDAD=REQUEST("PRIORIDAD")
	PATENTE=UCASE(REQUEST("PATENTE"))
	HOROMETRO=REQUEST("HOROMETRO")
	HOROMETRO_MAN=REQUEST("HOROMETRO_MAN")
	HOROMETRO_VEN=REQUEST("HOROMETRO_VEN")
	HOROMETRO_ALARM=REQUEST("HOROMETRO_ALARM")
	HOROMETRO_PADRE=REQUEST("HOROMETRO_PADRE")
	LAYOUT	=REQUEST("LAYOUT")
	LAYOUT2	=REQUEST("LAYOUT2")
	X=REQUEST("X")
	Y=REQUEST("Y")
	GCODE=REQUEST("GCODE")
	VIDA_UTIL=REQUEST("VIDA_UTIL")
	VALOR=UCASE(REQUEST("VALOR"))
	VALOR_NETO=UCASE(REQUEST("VALOR_NETO"))

Session.LCID = 2057

select case RECURSO

	case "getEquipo"
		  getEquipo()

  	case "updateEquipo"
		updateEquipo()
		
	
	case "explorer"
		explorer()
		
	case "explorer2"
		explorer2()
	
   	case "explorer3"
		explorer3()
   
	case "listTipos"
		 listTipos()
	
	case "listEmpalmes"
		 listEmpalmes()
	
		case "listComp"
		 listComp()
		  	 
	case "listTipoFallas"
		 listTipoFallas()
	
	case "getHijosTipo"
		getHijosTipo()
	
	case "getHijosSector"
		getHijosSector()
   
	case "getHijosSectorJson"
		getHijosSectorJson()
   
   case "getHijosEquipoJson"
		getHijosEquipoJson()
   
	case "listEquiposHijos"
		listEquiposHijos()
			
	case "updateLayoutData"
		updateLayoutData()
		
	case "listEquipos"
		listEquipos()
		
	case "ListSubEquipos"
		ListSubEquipos()
		
	case "ListSubEquiposDS"
		  ListSubEquiposDS()
		
	case "ListPlanMan"
		 ListPlanMan()


	case "ListValorHorometro"
		 ListValorHorometro()
		
	case "ListEquiposPadres"
		 ListEquiposPadres()
		
	case "ListEquiposxUsuario"
		  ListEquiposxUsuario()
	
	case "ListEquiposMoviles"
		  ListEquiposMoviles()	
		    	
	case "ListEquiposAsignados"
		  ListEquiposAsignados()

	case "ListHorometros"
		  ListHorometros()
			

	case "ListEquiposMan"
		  ListEquiposMan()

	case "ListEquiposManCro"
		  ListEquiposManCro()
		
	case "newEquipo"
		  newEquipo()

	case "newTipo"
		  NewTipo()


	case "getPrioridad"
		getPrioridad()
		

	case "AsignarEquipo"
		AsignarEquipo()
		

		
	case "delEquipo"
		delEquipo()

	case "DelTipo"
		DelTipoEquipo()
				
	case "DelHorometro"
		DelHorometro()
		
	case "DelEquipoUsuario"
		DelEquipoUsuario()
		
	case "existeEquipo"
		  existeEquipo()

	case "InsertValorHorometro"
		 InsertValorHorometro()
		
	case "NewEquipoUsuario"
		 NewEquipoUsuario()

	case "UpdateValorHorometro"
		  UpdateValorHorometro()


		
		 
end select


function getEquipo()
  
	query = "SELECT E.CODIGO, E.ESTADO, E.DESCRIPCION, E.COD_EQUIPO_PADRE,  "
	query = query & " CONVERT(VARCHAR,E.FECHA,103), E.TIPO_EQUIPO, "
	query = query & " E.UBICACION, E.MARCA, E.MODELO, E.OBSERVACION, "
	query = query & " E.SECCION, E.GSAP, E.SECUENCIA , E.GCODE, E.ANCHO, "
	query = query & " E.ESP_CAR, E.ESP_RET, E.LARGO, E.MESAS, "
	query = query & " dbo.EquipoPrincipalFaena(CODIGO,E.UBICACION), "
	query = query & " E.X, E.Y, E.POLINR, E.LAYOUT, E.LAYOUT2 "
	query = query & " FROM EQUIPOS AS E"
	query = query & " WHERE E.CODIGO=" & strNvl(CODIGO) & " AND E.UBICACION=" & strNvl(UBICACION) & " "
	
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" 
	Response.Write "<REGISTROS>" 
	'Response.Write "</REGISTROS>" 
	'exit function
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(1).Value & "</ESTADO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<EQUIPO_PADRE>" & ORs.Fields.Item(3).Value & "</EQUIPO_PADRE>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(4).Value & "</FECHA>"
  		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(5).Value & "</TIPO_EQUIPO>"
   		  Response.Write "<UBICACION>" & ORs.Fields.Item(6).Value & "</UBICACION>"
   		  Response.Write "<MARCA>" & ORs.Fields.Item(7).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(8).Value & "</MODELO>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
		  Response.Write "<SECTOR>" & ORs.Fields.Item(10).Value & "</SECTOR>"
		  Response.Write "<GSAP>" & ORs.Fields.Item(11).Value & "</GSAP>"
		  Response.Write "<ORDEN>" & ORs.Fields.Item(12).Value & "</ORDEN>"
		  Response.Write "<GCODE>" & ORs.Fields.Item(13).Value & "</GCODE>"
		  Response.Write "<ANCHO>" & ORs.Fields.Item(14).Value & "</ANCHO>"
		  Response.Write "<CARGA>" & ORs.Fields.Item(15).Value & "</CARGA>"
		  Response.Write "<RETORNO>" & ORs.Fields.Item(16).Value & "</RETORNO>"
		  Response.Write "<LARGO>" & ORs.Fields.Item(17).Value & "</LARGO>"
		  Response.Write "<MESAS>" & ORs.Fields.Item(18).Value & "</MESAS>"
		  Response.Write "<EQUIPO_PRI>" & ORs.Fields.Item(19).Value & "</EQUIPO_PRI>"
		  Response.Write "<X>" & ORs.Fields.Item(20).Value & "</X>"
		  Response.Write "<Y>" & ORs.Fields.Item(21).Value & "</Y>"
		  Response.Write "<POLINR>" & ORs.Fields.Item(22).Value & "</POLINR>"
		  Response.Write "<LAYOUT>" & ORs.Fields.Item(23).Value & "</LAYOUT>"
		  Response.Write "<LAYOUT2>" & ORs.Fields.Item(24).Value & "</LAYOUT2>"
		  
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updateEquipo()

	query = "UPDATE EQUIPOS SET ESTADO = " & strNvl(ESTADO) & ", "
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "COD_EQUIPO_PADRE=" & strNvl(COD_EQUIPO_PADRE) & ", "
	query = query & "GSAP=" & strNvl(GSAP) & ", "
	query = query & "GCODE=" & strNvl(GCODE) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ", "
	query = query & "TIPO_EQUIPO=" & strNvl(TIPO_EQUIPO) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	'query = query & "MODELO=" & strNvl(MODELO) & ","
	'query = query & "MARCA=" & strNvl(MARCA) & ","
	'query = query & "ESP_CAR=" & strNvl(CARGA) & ","
	'query = query & "ESP_RET=" & strNvl(RETORNO) & "," 
	query = query & "ANCHO =" & strNvl(ANCHO) & ","
	query = query & "SECCION=" & strNvl(SECTOR) & ", "
	query = query & "MESAS=" & strNvl(LARGO) & ", "
	query = query & "X=" & strNvl(X) & ", "
	query = query & "Y=" & strNvl(Y) & ", "
	query = query & "LAYOUT=" & strNvl(LAYOUT) & ", "
	query = query & "LAYOUT2=" & strNvl(LAYOUT2) & ", "
	query = query & "USERNAME=" & strNvl(USERNAME) & ", "
	query = query & "USERDATE = GETDATE() , "
	query = query & "SECUENCIA=" & strNvl(ORDEN) & " "
	query = query & "WHERE CODIGO=" & strNvl(CODIGO) 
	query = query & " AND UBICACION =" & strNvl(UBICACION) 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function newTipo()

	query = "SELECT MAX(CODIGO) AS NUM FROM TIPO_EQUIPOS "
	Set ORs =oDB.EjecutaSql(query)
   
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO TIPO_EQUIPOS (" 
	query = query & " CODIGO, "
	query = query & " DESCRIPCION, UBICACION, EMPRESA) "
	query = query & " VALUES ("
	query = query & strNvl(N) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(UBICACION) & ","
	query = query & strNvl(EMPRESA) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function newEquipo()
	
	query = "INSERT INTO EQUIPOS (" 
	query = query & " CODIGO, "
	query = query & " ESTADO, "
	query = query & " DESCRIPCION,"
	query = query & " UBICACION, "
	query = query & " SECUENCIA, "
	query = query & " COD_EQUIPO_PADRE, "
	query = query & " OBSERVACION,"
	query = query & " GSAP, "
	query = query & " GCODE, "
	query = query & " TIPO_EQUIPO, "
	query = query & " MARCA, "
	query = query & " MODELO, "
	query = query & " FECHA, "
	query = query & " SECTOR, "
	query = query & " USERNAME, "
	query = query & " USERDATE ) "
	query = query & " VALUES ("
	query = query &  strNvl(CODIGO) & ","
	query = query &  strNvl(ESTADO) & "," 
	query = query &  strNvl(DESCRIPCION) & ","
	query = query &  strNvl(UBICACION) & ","
	query = query &  strNvl(ORDEN) & ","
	query = query &  strNvl(COD_EQUIPO_PADRE) & ","
	query = query &  strNvl(OBSERVACION) & ","
	query = query &  strNvl(GSAP) & ","
	query = query &  strNvl(GCODE) & ","
	query = query &  strNvl(TIPO_EQUIPO) & ","
	query = query &  strNvl(MARCA) & "," 
	query = query &  strNvl(MODELO) & "," 
	query = query &  strNvl(FECHA) & "," 
	query = query &  strNvl(SECTOR) & "," 
 	query = query &  strNvl(USERNAME) & "," 
 	query = query & "getdate())"  
		
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function listEquipos()
	
	 query = "SELECT E.CODIGO, E.ESTADO, E.DESCRIPCION, E.HOROMETRO, E.HOROMETRO_MAN, "
	 query = query & " E.HOROMETRO_VEN,  E.HOROMETRO_ALARM, E.COD_EQUIPO_PADRE,"
	 query = query & " E.CIUDAD, E.MARCA, E.MODELO,"
	 query = query & " S.DESCRIPCION, E.UBICACION "
	 query = query & " FROM EQUIPOS AS E"
 	 query = query & " LEFT OUTER JOIN SECCIONES AS S ON S.CODIGO = E.SECTOR "
	 query = query & " AND S.FAENA=E.UBICACION "
	
	query = query & " WHERE UPPER(E.DESCRIPCION) LIKE '%" & TEXT & "%'"
	
	 query = query & " AND E.COD_EQUIPO_PADRE IS NULL "
	 'query = query & " AND E.EMPRESA=" & strNvl(EMPRESA)
	 query = query & " AND E.UBICACION=" & strNvl(EMPRESA)
	
	 query = query & " ORDER BY S.CODIGO, E.SECUENCIA "
	 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(1).Value & "</ESTADO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
  		  Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_MAN>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<HOROMETRO_ALARM>" & ORs.Fields.Item(6).Value & "</HOROMETRO_ALARM>"
  		  Response.Write "<COD_EQUIPO_PADRE>" & ORs.Fields.Item(7).Value & "</COD_EQUIPO_PADRE>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(8).Value & "</CIUDAD>"
		  Response.Write "<MARCA>" & ORs.Fields.Item(9).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(10).Value & "</MODELO>"   
		  Response.Write "<SECTOR>" & ORs.Fields.Item(11).Value & "</SECTOR>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(12).Value & "</UBICACION>"

	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listTipoFallas()

	query = "SELECT CODIGO, DESCRIPCION FROM TIPO_FALLAS "
	
	IF LEN(TIPO_EQUIPO)>0 THEN
		query = query & " WHERE TIPO_EQUIPO = " & TIPO_EQUIPO
	ELSE
		query = query & " WHERE TIPO_EQUIPO IS NULL"
	END IF
	
	Set ORs =oDB.EjecutaSql(query)
	
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listEquiposHijos()

	query = "SELECT E.CODIGO, E.DESCRIPCION, E.TIPO_EQUIPO "
	query = query & " FROM DBO.EQUIPOS AS E"
	query = query & " WHERE UBICACION=" & strNvl(UBICACION)
	
	
	If CODIGO="NULL" Then
		query = query & " AND E.COD_EQUIPO_PADRE IS NULL "
	Else
		query = query & " AND E.COD_EQUIPO_PADRE=" & strNvl(CODIGO) 
	End If

	If len(TIPO_HOROMETRO)>0 Then
		query = query & " AND E.TIPO_HOROMETRO=" & strNvl(TIPO_HOROMETRO)
	End If
	
	If len(TIPO)>0 Then
		query = query & " AND E.TIPO_EQUIPO=" & strNvl(TIPO)
	End If
	
	query = query & " GROUP BY E.CODIGO, E.DESCRIPCION, E.TIPO_EQUIPO "

	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(2).Value & "</TIPO_EQUIPO>"
  	   Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function	

function ListSubEquipos()
	 query = "SELECT CODIGO, DESCRIPCION, ESTADO,  FECHA_ULT_MAN, HOROMETRO, HOROMETRO_VEN,"
 	 query = query & "(HOROMETRO-HOROMETRO_VEN) AS DIFERENCIA, HOROMETRO_PADRE, "
	 query = query & " SISTEMA, CIUDAD, MARCA, MODELO, PROVEEDOR, VIDA_UTIL, UBICACION,"
	 query = query & " COD_EQUIPO_PADRE FROM EQUIPOS WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"
  	 query = query & " ORDER BY dbo.NumbersOnly(CODIGO)"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(4).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(6).Value & "</DIFERENCIA>"
   		  Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(7).Value & "</HOROMETRO_PADRE>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function



function ListPlanMan()
	Dim EquipoAnterior
	
		query = "SELECT E1.CODIGO+' '+E1.DESCRIPCION AS EQUIPO0, E1.HOROMETRO_MAN, E1.HOROMETRO_PADRE,"
		query = query & " E2.CODIGO, E2.DESCRIPCION, E2.HOROMETRO_MAN, E2.HOROMETRO_PADRE, "
		query = query & " E3.CODIGO, E3.DESCRIPCION, E3.HOROMETRO_MAN, E3.HOROMETRO_PADRE "
		query = query & " FROM EQUIPOS AS E1"
		query = query & " LEFT OUTER JOIN EQUIPOS AS E2 "
		query = query & " 	ON E1.CODIGO=E2.COD_EQUIPO_PADRE "
		query = query & " LEFT OUTER JOIN EQUIPOS AS E3 "
		query = query & " 	ON E2.CODIGO = E3.COD_EQUIPO_PADRE "
		query = query & " WHERE E1.COD_EQUIPO_PADRE=" & strNvl(CODIGO)
		query = query & " order by E1.CODIGO, E2.CODIGO, E3.CODIGO "

	Set ORs =oDB.EjecutaSql(query)
	
	
	Dim strName

	strName = Date()
	strName = Replace(strName, "/", "") ' "/" Your local dateseparator?
	strName = strName & ".xls"
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>EQUIPO</TD>"
   				   Response.Write "<TD>MANTENCION</TD>"
   				   Response.Write "<TD>HOROMETRO</TD>"
			 Response.Write "</TR>"
 		EquipoAnterior = ""
		While Not ORs.EOF

	  		If ORs.Fields.Item(0).Value = EquipoAnterior Then
			  Response.Write "<TR>" 
	  		  Response.Write "<TD>���-�" & ORs.Fields.Item(3).Value & _
		  					 "�" & ORs.Fields.Item(4).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
  			  Response.Write "</TR>"
			Else
			  Response.Write "<TR>"
			  Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
  			  Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   			  Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
			  Response.Write "</TR>"
			  
 		 	 If Len(ORs.Fields.Item(3).Value)>0 Then
 		 	  Response.Write "<TR>" 
  				 Response.Write "<TD>���-�" & ORs.Fields.Item(3).Value & "�" & ORs.Fields.Item(4).Value & "</TD>"
				  Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
   				  Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
		      Response.Write "</TR>"
			 End If
			  EquipoAnterior = ORs.Fields.Item(0).Value 
			End If
	 
	  		If Len(ORs.Fields.Item(7).Value)>0 Then
			 Response.Write "<TR>"
				  Response.Write "<TD>�����-�" & ORs.Fields.Item(7).Value & _
		  									"�" &ORs.Fields.Item(8).Value & "</TD>"
   				  Response.Write "<TD>" & ORs.Fields.Item(9).Value & "</TD>"
	   			  Response.Write "<TD>" & ORs.Fields.Item(10).Value & "</TD>"
	  		 Response.Write "</TR>"
			End if
		
	  		ORs.MoveNext

		Wend
	    Response.Write "</TABLE>"
	Else
		Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		EquipoAnterior = ""
		EquipoAnterior1 = ""
		While Not ORs.EOF 

	  		If ORs.Fields.Item(0).Value = EquipoAnterior Then
				If ORs.Fields.Item(3).Value=EquipoAnterior1 Then
			  		Response.Write "<ROWS>"
				  	Response.Write "<EQUIPO0>������������-�" & ORs.Fields.Item(7).Value & _
		  									" " &ORs.Fields.Item(8).Value & "</EQUIPO0>"
   				 	Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(9).Value & "</HOROMETRO_MAN>"
	   			 	Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(10).Value & "</HOROMETRO_PADRE>"
	  		 		Response.Write "</ROWS>"
			  	Else
 		  		 	Response.Write "<ROWS>" 
					Response.Write "<EQUIPO0>�����-�" & ORs.Fields.Item(3).Value & _
			  											 " " &ORs.Fields.Item(4).Value & "</EQUIPO0>"
		   			Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_MAN>"
		   			Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(6).Value & "</HOROMETRO_PADRE>"
	  			  	Response.Write "</ROWS>"
					If Len(ORs.Fields.Item(7).Value)>0 Then
			 						Response.Write "<ROWS>"
				  					Response.Write "<EQUIPO0>������������-�" & ORs.Fields.Item(7).Value & _
		  									" " &ORs.Fields.Item(8).Value & "</EQUIPO0>"
   				  					Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(9).Value & "</HOROMETRO_MAN>"
	   			  					Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(10).Value & "</HOROMETRO_PADRE>"
	  		 						Response.Write "</ROWS>"
					End if
			  End If
			Else
			  Response.Write "<ROWS><EQUIPO0>" & ORs.Fields.Item(0).Value & "</EQUIPO0>"
   			  Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(1).Value & "</HOROMETRO_MAN>"
   			  Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(2).Value & "</HOROMETRO_PADRE>"
   			  Response.Write "</ROWS>"
			  
			 End If
			
			EquipoAnterior = ORs.Fields.Item(0).Value 
			EquipoAnterior1 = ORs.Fields.Item(3).Value
			  
	  		ORs.MoveNext
			Wend
		Response.Write "</REGISTROS>"
	End If
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listTipos()

	 query = "SELECT CODIGO, DESCRIPCION  "
	 query = query & " FROM TIPO_EQUIPOS "
	 query = query & " WHERE ACTIVO='ACT' " 

	' query = query & "WHERE UBICACION="  & strNvl(UBICACION)
	 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	 	 Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listEmpalmes()

	 query = "SELECT E.CODIGO, E.DESCRIPCION , convert(varchar, M.FECHA, 103) "
	 query = query & " FROM EQUIPOS AS E "
	 query = query & " LEFT OUTER JOIN  MEDICIONES AS M ON M.EQUIPO=E.CODIGO "
	 query = query & "  where dbo.equipoprincipalfaena(codigo," & strNvl(FAENA) & ")=" & strNvl(EQUIPO)
	 query = query & "  AND TIPO_EQUIPO IN (13,3) "
	  
	 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	 	 Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
	 
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & " " & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listComp()

	 query = "select CODIGO, DESCRIPCION"
	 query = query & " from equipos"
	 query = query & "  where dbo.equipoprincipalfaena(codigo," & strNvl(FAENA) & ")=" & strNvl(EQUIPO)
	 'query = query & "  AND TIPO_EQUIPO IN (13,3) "
	  
	 
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	While Not ORs.EOF 
	 	 Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		 
		 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function



function ListEquiposMan()

	 query = "SELECT CODIGO, DESCRIPCION, FECHA_ULT_MAN, HOROMETRO, "
	 query = query & " HOROMETRO_VEN, DIFERENCIA, FOLIO_OT, PRIORIDAD "
  	 query = query & " FROM VI_EQUIPOS_MAN AS V LEFT OUTER JOIN "
   	 query = query & " (SELECT FOLIO_OT, EQUIPO, ESTADO FROM OT WHERE ESTADO IN ('PRO','PEN') AND TIPO='PRE') AS OT "
   	 query = query & " ON V.CODIGO = OT.EQUIPO"
	 query = query & " WHERE dbo.EquipoPrincipal(CODIGO)=" & strNvl(CODIGO) & " "
	 query = query & " ORDER BY DIFERENCIA DESC "

'	 query = query & " WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
		  If ORs.Fields.Item(6).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
  		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(7).Value & "</PRIORIDAD>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListEquiposManCro()

	 query = "SELECT CODIGO, DESCRIPCION, FECHA_ULT_MAN, HOROMETRO, "
	 query = query & " HOROMETRO_VEN, DIFERENCIA, FOLIO_OT, PRIORIDAD "
  	 query = query & " FROM VI_EQUIPOS_MAN_CRO AS V LEFT OUTER JOIN "
   	 query = query & " (SELECT FOLIO_OT, EQUIPO, ESTADO FROM OT WHERE ESTADO IN ('PRO','PEN') AND TIPO='PRE') AS OT "
   	 query = query & " ON V.CODIGO = OT.EQUIPO"
	 query = query & " WHERE dbo.EquipoPrincipal(CODIGO)=" & strNvl(CODIGO) & " "
	 query = query & " ORDER BY DIFERENCIA DESC "

'	 query = query & " WHERE COD_EQUIPO_PADRE='" &  CODIGO & "'"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(2).Value & "</FECHA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<DIFERENCIA>" & ORs.Fields.Item(5).Value & "</DIFERENCIA>"
		  If ORs.Fields.Item(6).Value<>"NULL" Then
   		  		IMAGEN = "images\generado.gif"
		  Else
		  		IMAGEN = "images\generar.gif"
		  End If
		  Response.Write "<IMAGE>" & IMAGEN & "</IMAGE>"
  		  Response.Write "<PRIORIDAD>" & ORs.Fields.Item(7).Value & "</PRIORIDAD>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function ListEquiposPadres()

	query = "SELECT E.CODIGO, E.DESCRIPCION, E.LAYOUT "
	query = query & " FROM EQUIPOS AS E "
	query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL "
	query = query & " AND E.UBICACION=" & strNvl(UBICACION)
	query = query & " GROUP BY E.CODIGO, E.DESCRIPCION, E.LAYOUT, E.SECUENCIA "
	query = query & " ORDER BY E.SECUENCIA "

	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<LAYOUT>" & ORs.Fields.Item(2).Value & "</LAYOUT>"
  	   Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function	  

function ListEquiposxUsuario()

	query = "SELECT DISTINCT E.CODIGO, E.DESCRIPCION, EU.IND "
	query = query & "FROM EQUIPOS AS E "
	query = query & " LEFT OUTER JOIN (SELECT 'TRUE' AS IND, EQUIPO FROM EQUIPOS_USUARIOS "
	query = query & "  WHERE USUARIO=" & strNvl(USUARIO) & " ) AS EU "
	query = query & "  ON E.CODIGO = EU.EQUIPO "
	
	query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL " 
	query = query & "	AND E.SECCION=" & strNvl(SECCION) 
	query = query & "	AND E.UBICACION=" & strNvl(FAENA) 
	query = query & " ORDER BY E.CODIGO"

	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  		  Response.Write "<IND>" & ORs.Fields.Item(2).Value & "</IND>"
  	   Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function	  

function listEquiposProyeccion()

	query = "SELECT DISTINCT E.CODIGO, E.DESCRIPCION, E.VIDA_UTIL, E.TON_SEMANAL, E.HOROMETRO "
	query = query & "FROM EQUIPOS AS E, SECCIONES AS S "
	query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL " 
	query = query & "	AND E.UBICACION=" & strNvl(FAENA) 
	query = query & "	AND E.SECCION=S.CODIGO AND S.PLANTA="  & strNvl(PLANTA)
	query = query & "	AND TIPO_EQUIPO IN (1,2)"  
	query = query & " ORDER BY E.CODIGO"

	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	n=0
	
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<N>" & n & "</N>"
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  		  Response.Write "<VIDA_UTIL>" & ORs.Fields.Item(2).Value & "</VIDA_UTIL>"
		  Response.Write "<TON_SEMANAL>" & ORs.Fields.Item(3).Value & "</TON_SEMANAL>"
		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(4).Value & "</HOROMETRO>"
		  
		  VidaUtil = ORs.Fields.Item(2).Value 
		  
		  If isNull(ORs.Fields.Item(3).Value) or  ORs.Fields.Item(3).Value=0 Then
		  		TonSemanal = 1
				Dias = 0
		  Else
		  		TonSemanal = ORs.Fields.Item(3).Value
				If isNull(ORs.Fields.Item(4).Value) Then
					Horometro = 0
				Else
					Horometro = ORs.Fields.Item(4).Value 
				End If
				
		 		Dias = Round((VidaUtil - Horometro)/ (TonSemanal/7),0)
		  End If
		  
		  
		  Response.Write "<DIAS>" & Dias & "</DIAS>"
		  Response.Write "<FECHA_CORTE>" & mid(DATEADD("D",Dias, NOW),1,10) & "</FECHA_CORTE>"
		  
  	   Response.Write "</ROW>"
	  ORs.MoveNext
	  n=n+1
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function	

function ListEquiposMoviles()

	query = "SELECT DISTINCT E.CODIGO, E.DESCRIPCION "
	query = query & "FROM EQUIPOS AS E "
	query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL " 
	query = query & "	AND E.TIPO_EQUIPO = 17" 
	query = query & "	AND E.UBICACION=" & strNvl(FAENA) 

	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  	   Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function	 

function ListEquiposAsignados()

	 query = "SELECT E.CODIGO, E.DESCRIPCION, E.FECHA_ASIGNADO, OT.FECHA_PROGRAMADA, E.HOROMETRO, "
	 query = query & " E.HOROMETRO_VEN, E.RESPONSABLE_MAN, OT.FOLIO_OT, OT.TURNO"
  	 query = query & " FROM EQUIPOS AS E LEFT JOIN OT ON E.CODIGO=OT.EQUIPO "
   	 query = query & " WHERE E.ESTADO='ASG'"

'	query = query "SELECT E.*, Equipos.DESCRIPCION AS DESC_PADRE "
'	query = query & "FROM EQUIPOS AS E LEFT JOIN Equipos ON E.COD_EQUIPO_PADRE = Equipos.CODIGO "
'	query = query & "WHERE ((E.CODIGO='" & CODIGO & "'))
'	

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<FECHA_ASIGNADA>" & ORs.Fields.Item(2).Value & "</FECHA_ASIGNADA>"
   		  Response.Write "<FECHA_PROGRAMADA>" & ORs.Fields.Item(3).Value & "</FECHA_PROGRAMADA>"
   		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(4).Value & "</HOROMETRO>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(6).Value & "</RESPONSABLE>"
   		  Response.Write "<OT>" & ORs.Fields.Item(7).Value & "</OT>"
   		  Response.Write "<TURNO>" & ORs.Fields.Item(8).Value & "</TURNO>"
		  
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function



function GetTipo()

	query = "SELECT E.TIPO_EQUIPO, TE.DESCRIPCION, E.COD_EQUIPO_PADRE "
	query = query & " FROM EQUIPOS AS E, TIPO_EQUIPOS AS TE"
	query = query & " WHERE E.TIPO_EQUIPO = TE.CODIGO "
	query = query & " AND  E.CODIGO = " & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<EQUIPO_PADRE>" & ORs.Fields.Item(2).Value & "</EQUIPO_PADRE>"
	  Response.Write "</ROWS>"
	End IF
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


function getLayoutData()

	query = "SELECT E.LAYOUT, E.GCODE, E.X, E.Y "
	query = query & " FROM EQUIPOS AS E "
	query = query & " WHERE E.CODIGO = " & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROWS>" 
		  Response.Write "<LAYOUT>" & ORs.Fields.Item(0).Value & "</LAYOUT>"
		  Response.Write "<GCODE>" & ORs.Fields.Item(1).Value & "</GCODE>"
		  Response.Write "<X>" & ORs.Fields.Item(2).Value & "</X>"
		  Response.Write "<Y>" & ORs.Fields.Item(3).Value & "</Y>"
	  Response.Write "</ROWS>"
	End IF
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function


function updateLayoutData()

	query = "UPDATE EQUIPOS SET LAYOUT =" & strNvl(LAYOUT)
	query = query & " , GCODE =" & strNvl(GCODE)
	query = query & " , X="  & strNvl(X)
	query = query & " , Y="  & strNvl(Y)
	query = query & " WHERE CODIGO = " & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROWS>" 
		  Response.Write "<LAYOUT>OK</LAYOUT>"
	  Response.Write "</ROWS>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function



function existeEquipo()

	query = "SELECT E.CODIGO "
	query = query & "FROM EQUIPOS AS E "
	query = query & " WHERE E.CODIGO='" & CODIGO & "'"
	query = query & " AND UBICACION=" & strNvl(UBICACION)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>"  '& query
		  Response.Write "<RETURN>YES</RETURN>"
	  Response.Write "</ROW>"
	Else
		  Response.Write "<ROW>" 
		  Response.Write "<RETURN>NOT</RETURN>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function explorer()

	query = " SELECT T.CODIGO, T.DESCRIPCION "
	query = query & "FROM SECCIONES AS T "
	query = query & " WHERE FAENA = " & strNvl(UBICACION)
 	query = query & " ORDER BY SECUENCIA "
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1' ?>" & VbCrLf & VbCrLf 'encoding='UTF-8'
	Response.Write "<REGISTROS>"
	DIM I
	DIM J
	I=1
	J=1
	While Not ORs.EOF 
		  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"		 
		  Response.Write "</ROWS>"
		ORs.MoveNext
	 Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
												
end function

function explorer3()

	query = " SELECT T.CODIGO, T.DESCRIPCION "
	query = query & "FROM SECCIONES AS T "
	query = query & " WHERE FAENA = " & strNvl(UBICACION)
 	query = query & " ORDER BY SECUENCIA "
	  
 	Set ORs =oDB.EjecutaSql(query)
	Set oJSON = New aspJSON
																				
	i=0
	With oJSON.data
	 	While Not ORs.EOF 
			   
			title = ORs.Fields.Item(1).Value   
			 id =  ORs.Fields.Item(0).Value
	
		.Add i, oJSON.Collection()
		
    		With .item(i)
                .Add "id", id		
				.Add "text",title
                .Add "parent","#"
				.Add "state", oJSON.Collection()
	
				With .item("state")
					.Add "opened","false"
					' .Add "selected","true"
				End With
	
            End With
	 		ORs.MoveNext
		i=i+1
		Wend
	
 
End With '**** END oJson

Response.Write oJSON.JSONoutput()                   'Return json string

end function

	
	
function explorer2()

	query = " SELECT T.CODIGO, T.DESCRIPCION "
	query = query & "FROM TIPO_EQUIPOS AS T "
	query = query & " ORDER BY T.DESCRIPCION "
	

	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1' ?>" & VbCrLf & VbCrLf 'encoding='UTF-8'
	Response.Write "<REGISTROS>"
	DIM I
	DIM J
	I=1
	J=1
	While Not ORs.EOF 
		  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & I & "</CODIGO>"
		  Response.Write "<COD_PADRE>" & 0 & "</COD_PADRE>"
		  Set oRsHijos = getHijosTipoRs(ORs.Fields.Item(0).Value)
		  
		  IF Not oRsHijos.EOF THEN
		  	  oRsHijos.movefirst
			  vCount =  oRsHijos.RecordCount 
		   ELSE
		   	  vCount =  oRsHijos.RecordCount 
		  END IF
		  
		  Response.Write "<DESCRIPCION>&lt;li class='closed'  onclick='hijos2(this,0);' &gt;" '& _
		  Response.Write "&lt;span class='folder' &gt; " & ORs.Fields.Item(1).Value & "(" & vCount & ") &lt;/span&gt;" 
		  Response.Write "&lt;ul&gt;"
		  While Not oRsHijos.EOF
		   'Response.Write "&lt;li id='" & I & "' title='" & oRsHijos.Fields.Item(0).Value _
'		   				  & "'&gt; &lt;span class='machine' onclick='hijos(this,0);' &gt;" _
'		   	              & " " & oRsHijos.Fields.Item(0).Value  & " " & oRsHijos.Fields.Item(1).Value & "&lt;/span&gt;" _
'		   				  & "&lt;/li&gt;"
		   
		   Response.Write "&lt;li&gt; &lt;span class='machine' onclick='hijos(this,0);' &gt;" _
		                & " " & oRsHijos.Fields.Item(0).Value  & " " & oRsHijos.Fields.Item(1).Value & "&lt;/span&gt;" _
		  				& "&lt;ul id='" & I & "' title='" & oRsHijos.Fields.Item(0).Value & "' &gt; &lt;/ul&gt;" _
		  				& "&lt;/li&gt;"
		  				  
						  
				I=I+1
			oRsHijos.MoveNext
		 Wend
		 	 
		 Response.Write "&lt;/ul&gt;&lt;/li&gt;</DESCRIPCION>"
		 
		 Response.Write "</ROWS>"
		ORs.MoveNext
	 Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
												
end function

function getHijosTipoRs(codPadre)

	query = "SELECT E.CODIGO, E.DESCRIPCION  "
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  WHERE E.TIPO_EQUIPO=" & strNvl(codPadre)
	query = query & "  AND COD_EQUIPO_PADRE IS NULL"
	query = query & "  ORDER BY E.DESCRIPCION "
	 
	Set getHijosTipo =oDB.EjecutaSql(query)
	
End Function

function getHijosSectorJson()

	query = "SELECT E.CODIGO, E.DESCRIPCION  "
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  WHERE E.SECCION=" & strNvl(CODIGO)
	query = query & "  AND E.UBICACION=" & strNvl(UBICACION)
	query = query & "  AND COD_EQUIPO_PADRE IS NULL"
	query = query & " ORDER BY E.SECUENCIA "
	' response.write(query)
 	
	Set ORs =oDB.EjecutaSql(query)
	Set oJSON = New aspJSON
																				
	i=0
	With oJSON.data
	 	While Not ORs.EOF 
			
			id =  ORs.Fields.Item(0).Value  
			title = ORs.Fields.Item(1).Value   
			 
		.Add i, oJSON.Collection()
		
    		With .item(i)
                .Add "id", id 		
				.Add "text", id & " " & title 
                .Add "parent",CODIGO
				.Add "icon","/mg/machine.png"
				.Add "state", oJSON.Collection()
	
				With .item("state")
					.Add "opened","false"
					' .Add "selected","true"
				End With
	
            End With
	 		ORs.MoveNext
		i=i+1
		Wend
	
 
End With '**** END oJson

Response.Write oJSON.JSONoutput()                   'Return json string

end function

function getHijosEquipoJson()

	query = "SELECT E.CODIGO, E.DESCRIPCION , ISNULL(DBO.GETCRITICIDAD(E.CODIGO,E.UBICACION),33.3) , e.secuencia"
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  WHERE E.COD_EQUIPO_PADRE=" & strNvl(CODIGO)
		query = query & "  AND E.UBICACION=" & strNvl(UBICACION)
	query = query & " ORDER BY E.secuencia "
	  
 	Set ORs =oDB.EjecutaSql(query)
	Set oJSON = New aspJSON
																				
	i=0
	With oJSON.data
	 	While Not ORs.EOF 
			
			id =  ORs.Fields.Item(0).Value  
			title = ORs.Fields.Item(1).Value 
			criticidad  = ORs.Fields.Item(2).Value 
		
		select case criticidad
	
			case "100"
			  icon = "/sgm/mg/alta.gif"
			
			case "66.7"
			  icon = "/sgm/mg/media.gif"
	
			case "33.3"
			  icon = "/sgm/mg/baja.gif"
		
		end select 
	
			
			 
		.Add i, oJSON.Collection()
		
    		With .item(i)
                .Add "id", id 		
				.Add "text",title
                .Add "parent",CODIGO
				.Add "icon", icon 'criticidad
				.Add "state", oJSON.Collection()
	
				With .item("state")
					.Add "opened","true"
					' .Add "selected","true"
				End With
	
            End With
	 		ORs.MoveNext
		i=i+1
		Wend
	
 
End With '**** END oJson

Response.Write oJSON.JSONoutput()                   'Return json string

end function
	
function getHijosSector()

	query = "SELECT E.CODIGO, E.DESCRIPCION  "
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  WHERE E.SECTOR=" & strNvl(CODIGO)
	query = query & "  AND E.UBICACION=" & strNvl(UBICACION)
	query = query & "  AND COD_EQUIPO_PADRE IS NULL"
	query = query & " ORDER BY E.SECUENCIA "
	
	Set oRs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1' ?>" & VbCrLf & VbCrLf 'encoding='UTF-8'
	Response.Write "<REGISTROS>"
	While Not oRs.EOF
		Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & oRs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & oRs.Fields.Item(1).Value & "</DESCRIPCION>"
		  I=I+1
		  oRs.MoveNext
		Response.Write "</ROWS>" 
	Wend
	Response.Write "</REGISTROS>" 
	
End Function

function getHijosTipo()

	query = "SELECT E.CODIGO, E.DESCRIPCION  "
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  WHERE E.TIPO_EQUIPO=" & strNvl(CODIGO)
	query = query & "  AND COD_EQUIPO_PADRE IS NULL"
	query = query & "  ORDER BY E.DESCRIPCION "
	Set oRs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1' ?>" & VbCrLf & VbCrLf 'encoding='UTF-8'
	Response.Write "<REGISTROS>"
	While Not oRs.EOF
		Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & oRs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & oRs.Fields.Item(1).Value & "</DESCRIPCION>"
		  I=I+1
		  oRs.MoveNext
		Response.Write "</ROWS>" 
	Wend
	Response.Write "</REGISTROS>" 
	
End Function

function getSons()

	query = "SELECT E.CODIGO, E.DESCRIPCION  "
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  WHERE E.COD_EQUIPO_PADRE=" & strNvl(EQUIPO)
	query = query & " ORDER BY E.CODIGO "
	 
	Set oRs =oDB.EjecutaSql(query)
	Dim I
	I = 2
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1' ?>" & VbCrLf & VbCrLf 'encoding='UTF-8'
	Response.Write "<REGISTROS>"
	Response.Write "<ROWS>" 
	
		 While Not oRs.EOF

		  Response.Write "<DESCRIPCION>" 
		  Response.Write "&lt;li id=" & P_ID & I & " title='" & oRs.Fields.Item(0).Value & "'&gt;" _
		  			  	  & "&lt;span class='part' onclick='hijos(this," & P_ID & I & ");' ondblclick='set(" & oRs.Fields.Item(0).Value & ");' &gt;" _
		   	              & " " & oRs.Fields.Item(0).Value  & " " & oRs.Fields.Item(1).Value & "&lt;/span&gt;" _
						  & "&lt;/li&gt;</DESCRIPCION>"'  & "&lt;ul&gt;&lt;/ul&gt;" _
				I=I+1
			oRs.MoveNext
		 Wend
		 	 
	Response.Write "</ROWS>" 
	Response.Write "</REGISTROS>" 
		 
	
End Function

function getHijos(codPadre)

	query = "SELECT E.CODIGO, E.DESCRIPCION  "
	query = query & "  FROM  EQUIPOS AS E "
	query = query & "  AND COD_EQUIPO_PADRE IS NULL"
	query = query & "  WHERE E.TIPO_EQUIPO=" & strNvl(codPadre)
	query = query & " AND UBICACION=" & strNvl(UBICACION)
	query = query & " ORDER BY E.DESCRIPCION "
	 
	Set getHijos =oDB.EjecutaSql(query)
	
End Function


function updateProyeccion()

	query = "UPDATE EQUIPOS SET HOROMETRO = " &  replace(strNvl(HOROMETRO),",",".") & ", "
	query = query & " VIDA_UTIL = " & strNvl(VIDA_UTIL) & ", "
	query = query & " TON_SEMANAL = " & strNvl(TON_SEMANAL)
	query = query & " WHERE CODIGO = " & strNvl(CODIGO) 
	query = query & " AND UBICACION = " & strNvl(FAENA) 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function AsignarEquipo()
	query = "UPDATE EQUIPOS SET ESTADO = 'ASG', "
	query = query & "RESPONSABLE_MAN=" & strNvl(RESPONSABLE) & ","
	query = query & "TIPO_ASG = " & strNvl(TIPO_ASG) & ","
	query = query & "FECHA_ASIGNADO= getdate()"
	query = query & " WHERE CODIGO=" & strNvl(CODIGO) 

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function updatePrioridad()

	query = "UPDATE EQUIPOS SET PRIORIDAD = " & strNvl(PRIORIDAD)
	query = query & " WHERE CODIGO=" & strNvl(CODIGO) 

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write strNvl(CODIGO) 
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function getPrioridad()

	query = "SELECT PRIORIDAD FROM EQUIPOS "
	query = query & " WHERE CODIGO=" & strNvl(CODIGO) 

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	 Response.Write "<PRIORIDAD>" & ORs.Fields.Item(0).Value & "</PRIORIDAD>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function AsignarEquipoHorometro()
	query = "UPDATE EQUIPOS SET "
	query = query & "HOROMETRO_PADRE=" & strNvl(HOROMETRO) 
	query = query & " WHERE CODIGO=" & strNvl(CODIGO) 

	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function InsertHorometroGestion()

	query = "SELECT HOROMETRO, HOROMETRO_VEN FROM EQUIPOS "
	query = query & " WHERE CODIGO=" & strNvl(CODIGO) 
	
	Set ORs =oDB.EjecutaSql(query)
	
	HorometroAsig = ORs.Fields.Item(0).Value
	HorometroTeo = ORs.Fields.Item(1).Value
	
	
	query = "INSERT INTO HOROMETRO_GESTION (FOLIO_OT, HOROMETRO_ASIG, HOROMETRO_TEO) VALUES ("
	query = query &  FOLIO_OT 
	query = query & "," & REPLACE(HorometroAsig,",",".")
	query = query & "," & REPLACE(HorometroTeo,",",".")  & ")"
	
	Set ORs =oDB.EjecutaSql(query)

	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function ListProv()
	query = "SELECT RUT_PROVEEDOR, NOMBRE FROM EXISTENCIAS.DBO.PROVEEDORES"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>"
		  Response.Write "<RUT>" & ORs.Fields.Item(0).Value & "</RUT>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(1).Value & "</NOMBRE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function delEquipo()
	
	query = "DELETE EQUIPOS WHERE CODIGO = '" & CODIGO & "' "
	query = query & "AND ubicacion = " & strNvl(EMPRESA) 
	
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<XML><ROW>" & query
	Response.Write "<RESP>" & CODIGO & " Eliminado</RESP>"
	Response.Write "</ROW></XML>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelHorometro()
	query = "DELETE HOROMETROS WHERE CODIGO='" & CODIGO & "' "
	query = query & "AND COD_EQUIPO_PRINCIPAL='" & COD_EQUIPO & "' "
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelEquipoUsuario()

	query = "DELETE EQUIPOS_USUARIOS WHERE USUARIO=" & strNvl(USUARIO) & " "
	query = query & "AND EQUIPO=" & strNvl(CODIGO) & " "
	
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelTipoEquipo()

	query = "DELETE TIPO_EQUIPOS WHERE CODIGO=" & strNvl(CODIGO) & " "
		
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
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