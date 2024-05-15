<!--#include file="..\standard\DBConn.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

	RECURSO=REQUEST("RECURSO")
	ANCHO=REQUEST("ANCHO")
	CODIGO=UCASE(REQUEST("CODIGO"))
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
	SECUENCIA=REQUEST("SECUENCIA")
	POLIZA=UCASE(REQUEST("POLIZA"))
	PLANTA=UCASE(REQUEST("PLANTA"))
	PROPIETARIO=UCASE(REQUEST("PROPIETARIO"))
	PROVEEDOR=REQUEST("PROVEEDOR") 'NOMBRE DEL PROVEEDOR
	RESPONSABLE=REQUEST("RESPONSABLE") 
	OBSERVACION=UCASE(REQUEST("OBSERVACION"))
	RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
	UBICACION=REQUEST("UBICACION")
	TIPO_ASG=REQUEST("TIPO_ASG")
	LARGO=REQUEST("LARGO")
	TIPO_EQUIPO=REQUEST("TIPO_EQUIPO")
	TIPO_HOROMETRO=UCASE(REQUEST("TIPO_HOR"))
	TIPO_COMBUSTIBLE=UCASE(REQUEST("TIPO_COMBUSTIBLE"))
	TON_SEMANAL=UCASE(REQUEST("TON_SEMANAL"))
	PROPIETARIO=REQUEST("PROPIETARIO")
	PRIORIDAD=REQUEST("PRIORIDAD")
	PATENTE=UCASE(REQUEST("PATENTE"))
	HOROMETRO=REQUEST("HOROMETRO")
	HOROMETRO_MAN=REQUEST("HOROMETRO_MAN")
	HOROMETRO_VEN=REQUEST("HOROMETRO_VEN")
	HOROMETRO_ALARM=REQUEST("HOROMETRO_ALARM")
	HOROMETRO_PADRE=REQUEST("HOROMETRO_PADRE")
	MODELO=REQUEST("MODELO")
	MARCA=REQUEST("MARCA")
	USUARIO=REQUEST("USUARIO")
	LAYOUT=REQUEST("LAYOUT")
	X=REQUEST("X")
	Y=REQUEST("Y")
	SX=REQUEST("SX")
	SY=REQUEST("SY")
	GCODE=REQUEST("GCODE")
	VIDA_UTIL=REQUEST("VIDA_UTIL")
	VALOR=UCASE(REQUEST("VALOR"))
	VALOR_NETO=UCASE(REQUEST("VALOR_NETO"))
	LISTEQ=UCASE(REQUEST("LISTEQUIPOS"))
	LISTEST=UCASE(REQUEST("LISTESTOCADA"))
	LISTME=UCASE(REQUEST("LISTMESA"))
	
Session.LCID = 2057

select case RECURSO

	case "ListCiudades"
		ListCiudades()
		
	case "GetEquipo"
		GetEquipo()
		
	case "GetTipo"
		GetTipo()
	
	case "getLayoutData"
		 getLayoutData()
	
	case "updateLayoutData"
		updateLayoutData()
		
	case "ListEquipos"
		ListEquipos()
		
	case "ListEquiposMov"
		ListEquiposMov()
		
		
	case "ListSubEquipos"
		ListSubEquipos()
		
	case "ListSubEquiposDS"
		  ListSubEquiposDS()
		
	case "ListPlanMan"
		 ListPlanMan()

	case "ListTipos"
		ListTipos()

	case "ListTiposMov"
		ListTiposMov()
		
	case "listEquiposProyeccion"
		 listEquiposProyeccion()

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
			
	case "ListEquiposPrincipal"
		  ListEquiposPrincipal()

	case "ListEquiposMan"
		  ListEquiposMan()

	case "ListEquiposManCro"
		  ListEquiposManCro()
		
	case "NewEquipo"
		  NewEquipo()

	case "NewTipo"
		  NewTipo()

	case "NewHorometro"
		  NewHorometro()
		
	case "updatePrioridad"
		  updatePrioridad()
	
	case "updateProyeccion"
		 updateProyeccion()
		 		
	case "getPrioridad"
		getPrioridad()
		
	case "NewHorometroEquipo"
		NewHorometroEquipo()

	case "AsignarEquipo"
		AsignarEquipo()
		
	case "ListValorHorometroxGrupo"
		ListValorHorometroxGrupo()
		
	case "ListValorHorometroxEquipo"
		ListValorHorometroxEquipo()

	case "UltimoValorHorometro"
		UltimoValorHorometro()

	case "AsignarEquipoHorometro"
		AsignarEquipoHorometro()
		
	case "DelEquipo"
		DelEquipo()

	case "DelTipo"
		DelTipoEquipo()
				
	case "DelHorometro"
		DelHorometro()
		
	case "DelEquipoUsuario"
		DelEquipoUsuario()
		
	case "UpdateEquipo"
		UpdateEquipo()

	case "existeEquipo"
		  existeEquipo()

	case "InsertValorHorometro"
		 InsertValorHorometro()
		
	case "NewEquipoUsuario"
		 NewEquipoUsuario()

	case "UpdateValorHorometro"
		  UpdateValorHorometro()
		
	case "ListProv"
		  ListProv()
		  
	case "ListEquiposHijos"
		ListEquiposHijos()
		
	Case "InsertHorometroGestion"
		 InsertHorometroGestion()
		 
	Case "ListEquiposCorreas"
		 ListEquiposCorreas()
		 
	Case "ListEquiposPadresAndina"
		 ListEquiposPadresAndina()

	Case "ListEstocadaAndina"
		 ListEstocadaAndina()
		 
	Case "ListMesaAndina"
		 ListMesaAndina()
	 
end select

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


function ListHorometros()
	query = "SELECT CODIGO, DESCRIPCION"
	query = query & " FROM HOROMETROS "
	query = query & " WHERE COD_EQUIPO_PRINCIPAL = dbo.EquipoPrincipal(" & strNvl(COD_EQUIPO)  & ")"
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
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

function NewHorometroEquipo()
	
	query = "INSERT INTO HOROMETRO_EQUIPO (" 
	query = query & " EQUIPO, "
	query = query & " FECHA, "
	query = query & " HOROMETRO) "
	query = query & " VALUES ("
	query = query & "'" & CODIGO & "',"
	query = query &  strNvl(FECHA) & "," 
	query = query &  HOROMETRO & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function NewEquipoUsuario()
	
	query = "INSERT INTO EQUIPOS_USUARIOS (" 
	query = query & " EQUIPO, "
	query = query & " USUARIO, "
	query = query & " SECCION) "
	query = query & " VALUES ("
	query = query & "'" & CODIGO & "',"
	query = query &  strNvl(USUARIO) & "," 
	query = query &  strNvl(SECCION) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function NewTipo()

	query = "SELECT MAX(CODIGO) AS NUM FROM TIPO_EQUIPOS "
	Set ORs =oDB.EjecutaSql(query)
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO TIPO_EQUIPOS (" 
	query = query & " CODIGO, "
	query = query & " DESCRIPCION, ACTIVO) "
	query = query & " VALUES ("
	query = query & strNvl(N) & ","
	query = query & strNvl(DESCRIPCION) & ",'ACT')"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function NewHorometro()
	
	query = "INSERT INTO HOROMETROS (" 
	query = query & " CODIGO, "
	query = query & " COD_EQUIPO_PRINCIPAL, "
	query = query & " DESCRIPCION) VALUES ("
	query = query & "'" & CODIGO & "',"
	query = query & "'" & COD_EQUIPO & "',"
	query = query & "'" & DESCRIPCION & "')"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function NewEquipo()
	
	query = "INSERT INTO EQUIPOS (" 
	query = query & " CODIGO, "
	query = query & " ESTADO, "
	query = query & " DESCRIPCION,"
	query = query & " DIMENSIONES,"
	query = query & " CRITICIDAD,"
	query = query & " POLIZA,"
	query = query & " COLOR,"
	query = query & " RESPONSABLE,"
	query = query & " OBSERVACION,"
	query = query & " HOROMETRO, "
	query = query & " HOROMETRO_MAN, "
	query = query & " HOROMETRO_VEN, "
	query = query & " HOROMETRO_ALARM, "
	query = query & " HOROMETRO_PADRE, "
	query = query & " PROPIETARIO, "
	query = query & " SISTEMA, "
	query = query & " CIUDAD, "
	query = query & " TIPO_HOROMETRO, "
	query = query & " TIPO_EQUIPO, "
	query = query & " TIPO_COMBUSTIBLE, "
	query = query & " ANCHO, "
	query = query & " ESPESOR, "
	query = query & " ESCALA, "
	query = query & " ESCALA_ALARM, "
	query = query & " MARCA, "
	query = query & " MODELO, "
	query = query & " GRUPO, "
	query = query & " GSAP, "
	query = query & " FECHA, "
	query = query & " PROVEEDOR, "
	query = query & " SECUENCIA, "
	query = query & " SECCION, "
	query = query & " VALOR_NETO, "
	query = query & " UBICACION, "
	query = query & " COD_EQUIPO_PADRE, "
	query = query & " USERNAME, "
	query = query & " USERDATE) "
	query = query & " VALUES ("
	query = query & "'" & CODIGO & "',"
	query = query &  strNvl(ESTADO) & "," 
	query = query &  strNvl(DESCRIPCION) & ","
	query = query &  strNvl(DIMENSIONES) & ","
	query = query &  strNvl(CRITICIDAD) & ","
	query = query &  strNvl(POLIZA) & ","
	query = query &  strNvl(COLOR) & ","
	query = query &  strNvl(RESPONSABLE) & ","
	query = query &  strNvl(OBSERVACION) & ","
	query = query &  strNvl(HOROMETRO) & "," 
	query = query &  strNvl(HOROMETRO_MAN) & "," 
	query = query &  strNvl(HOROMETRO_VEN) & "," 
	query = query &  strNvl(HOROMETRO_ALARM) & "," 
	query = query &  strNvl(HOROMETRO_PADRE) & "," 
	query = query &  strNvl(PROPIETARIO) & "," 
	query = query &  strNvl(SISTEMA) & "," 
	query = query & strNvl(CIUDAD) & "," 
	query = query & "'SEC'," 
	query = query & strNvl(TIPO_EQUIPO) & ","
	query = query & strNvl(TIPO_COMBUSTIBLE) & ","
	query = query & strNvl(ANCHO) & ","
	query = query & strNvl(ESPESOR) & ","
	query = query & strNvl(ESCALA) & "," 
	query = query & strNvl(ESCALA_ALARM) & "," 
	query = query & strNvl(MARCA) & ","
 	query = query & strNvl(MODELO) & "," 
	query = query & strNvl(GRUPO) & "," 
	query = query & strNvl(GSAP) & ","
	query = query & strNvl(FECHA) & "," 
 	query = query & "1," 
	query = query & strNvl(SECUENCIA) & "," 
	query = query & strNvl(SECCION) & "," 
	query = query & strNvl(VALOR_NETO) & ","  
 	query = query & strNvl(UBICACION) & "," 
 	query = query & strNvl(COD_EQUIPO_PADRE) & "," 
 	query = query & strNvl(USUARIO) & "," 
 	query = query & "getdate() )"  
		
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function ListEquipos()
	 query = "SELECT CODIGO, ESTADO, DESCRIPCION, HOROMETRO, HOROMETRO_MAN,"
	 query = query & " HOROMETRO_VEN,  HOROMETRO_ALARM, COD_EQUIPO_PADRE,  CIUDAD, MARCA, MODELO,"
	 query = query & "  PROVEEDOR, VIDA_UTIL, UBICACION "
	 query = query & " FROM EQUIPOS "
 	 query = query & " WHERE UPPER(DESCRIPCION) LIKE '%" & STRC & "%'"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
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
		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(11).Value & "</PROVEEDOR>"  
		  Response.Write "<VIDA_UTIL>" & ORs.Fields.Item(12).Value & "</VIDA_UTIL>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(13).Value & "</UBICACION>"

	  Response.Write "</ROW>"
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

function ListSubEquiposDS()
	 query = "SELECT CODIGO, DESCRIPCION, ESTADO,  FECHA_ULT_MAN, MARCA, DIMENSIONES,"
 	 query = query & "GSAP, SERIE, MODELO, OBSERVACION "
	 query = query & " FROM EQUIPOS WHERE dbo.EquipoPrincipal(COD_EQUIPO_PADRE)=" &  strNvl(CODIGO) 
  	 query = query & " ORDER BY DESCRIPCION "
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION_DS>" & ORs.Fields.Item(1).Value & "</DESCRIPCION_DS>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
   		  Response.Write "<MARCA_DS>" & ORs.Fields.Item(4).Value & "</MARCA_DS>"
   		  Response.Write "<DIMENSIONES_DS>" & ORs.Fields.Item(5).Value & "</DIMENSIONES_DS>"
   		  Response.Write "<GSAP>" & ORs.Fields.Item(6).Value & "</GSAP>"
   		  Response.Write "<SERIE_DS>" & ORs.Fields.Item(7).Value & "</SERIE_DS>"
		  Response.Write "<MODELO_DS>" & ORs.Fields.Item(8).Value & "</MODELO_DS>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(9).Value & "</OBSERVACION>"
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


function ListEquiposxGrupos()
	 query = "SELECT E.CODIGO, E.DESCRIPCION, E.ESTADO, E.HOROMETRO_PADRE "
 	 query = query & "FROM EQUIPOS AS E "
	 query = query & "WHERE GRUPO='" &  GRUPO & "' "
	' query = query & " ORDER BY REPLACE(SUBSTRING(E.CODIGO,4,2),'.',''),"
	' query = query & " CAST(REPLACE(SUBSTRING(E.CODIGO,6,2),'.','') AS NUMERIC)"

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  		  Response.Write "<ESTADO>" & ORs.Fields.Item(2).Value & "</ESTADO>"
  	 	  Response.Write "<HOROMETRO_P>" & ORs.Fields.Item(3).Value & "</HOROMETRO_P>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListValorHorometroxEquipo()

	 query = "SELECT CODIGO, DESCRIPCION, HV.COD_EQUIPO_PRINCIPAL, CONVERT(CHAR,HV.FECHA,103), HV.VALOR "
 	 query = query & "FROM HOROMETROS AS H "
 	 query = query & "LEFT JOIN (SELECT COD_EQUIPO_PRINCIPAL, COD_HOROMETRO, FECHA, VALOR "
 	 query = query & "FROM HOROMETRO_VALOR WHERE COD_EQUIPO_PRINCIPAL = '" & COD_EQUIPO & "'"
	 query = query & " AND convert(char,fecha,103)='" & FECHA &"' AND COD_EQUIPO IS NULL) AS HV "
	 query = query & " ON H.CODIGO=HV.COD_HOROMETRO "
	 query = query & " WHERE H.COD_EQUIPO_PRINCIPAL='" & COD_EQUIPO  & "' "
 	 query = query & " GROUP BY CODIGO, DESCRIPCION, HV.COD_EQUIPO_PRINCIPAL, CONVERT(CHAR,FECHA,103), VALOR "
 	 query = query & " ORDER BY DESCRIPCION "
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
  		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<GRUPO>" & ORs.Fields.Item(2).Value & "</GRUPO>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(4).Value & "</VALOR>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListValorHorometroxGrupo()

	 query = "SELECT CODIGO, DESCRIPCION, HV.COD_GRUPO, CONVERT(CHAR,HV.FECHA,103), HV.VALOR "
 	 query = query & "FROM HOROMETROS AS H "
 	 query = query & "LEFT JOIN (SELECT COD_GRUPO, COD_HOROMETRO, FECHA, VALOR "
 	 query = query & "FROM HOROMETRO_VALOR WHERE COD_GRUPO = '" & GRUPO & "' AND convert(char,fecha,103)='" & FECHA &"' AND COD_EQUIPO IS NULL) AS HV "
	 query = query & " ON H.CODIGO=HV.COD_HOROMETRO "
	 query = query & " WHERE GRUPO='" & GRUPO  & "' "
 	 query = query & " GROUP BY CODIGO, DESCRIPCION, COD_GRUPO, CONVERT(CHAR,FECHA,103), VALOR "
 	 query = query & " ORDER BY DESCRIPCION "
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
  		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<GRUPO>" & ORs.Fields.Item(2).Value & "</GRUPO>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(4).Value & "</VALOR>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListValorHorometro()

	 query = "SELECT FECHA, VALOR "
 	 query = query & "FROM HOROMETRO_VALOR "
	 query = query & "WHERE COD_EQUIPO_PRINCIPAL=dbo.EquipoPrincipal('" &  COD_EQUIPO & "')"
	 query = query & " AND COD_HOROMETRO='" & HOROMETRO & "'"
 	 query = query & " ORDER BY FECHA DESC"
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<FECHA>" & ORs.Fields.Item(0).Value & "</FECHA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListTipos()
	 query = "SELECT CODIGO, DESCRIPCION, CRITICIDAD "
	 query = query & "FROM TIPO_EQUIPOS WHERE ACTIVO='ACT' ORDER BY DESCRIPCION"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>"
	 Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function ListTiposMov()

	 query = "SELECT CODIGO, DESCRIPCION, CRITICIDAD "
	 query = query & "FROM TIPO_EQUIPOS WHERE ACTIVO='ACT' AND IND_MOVIL='TRUE' ORDER BY DESCRIPCION"
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
'	 Response.Write "<ROW>" 
'		  Response.Write "<CODIGO>TOD</CODIGO>"
'		  Response.Write "<DESCRIPCION>TODOS</DESCRIPCION>"
'		  Response.Write "<CRITICIDAD></CRITICIDAD>"
'	  Response.Write "</ROW>"
	  
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(2).Value & "</CRITICIDAD>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UltimoValorHorometro()


 query = "SELECT TOP 1 CONVERT(CHAR,FECHA,103), VALOR "
 	 query = query & "FROM HOROMETRO_VALOR "
	 query = query & "WHERE COD_EQUIPO_PRINCIPAL=dbo.EquipoPrincipal('" &  COD_EQUIPO & "')"
	 query = query & " AND COD_HOROMETRO='" & HOROMETRO & "'"
 	 query = query & " AND COD_EQUIPO IS NULL"
 	 query = query & " ORDER BY FECHA DESC, VALOR ASC "
	
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROWS>" 
		  Response.Write "<FECHA>" & ORs.Fields.Item(0).Value & "</FECHA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(1).Value & "</VALOR>"
	 Response.Write "</ROWS>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end Function

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
	query = query & " FROM EQUIPOS AS E , EQUIPOS_USUARIOS AS EU"
	
	If CODIGO="NULL" Then
		query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL "
		query = query & " AND  E.CODIGO = EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO) 
	Else
		query = query & " WHERE E.COD_EQUIPO_PADRE=" & strNvl(CODIGO) 
	End If

	If len(TIPO_HOROMETRO)>0 Then
		query = query & " AND E.TIPO_HOROMETRO=" & strNvl(TIPO_HOROMETRO)
	End If
	
	If len(SECCION)>0 Then
		query = query & " AND E.SECCION=" & strNvl(SECCION)
	End If
	
	if FAENA = "CERRO COLORADO" then
		query = query & " AND E.DESCRIPCION NOT like '%MOVIL%' AND E.TIPO_EQUIPO <> 17 "
	end if

	query = query & " AND E.UBICACION=" & strNvl(FAENA)
	query = query & " AND E.ESTADO='ACT' "
	query = query & " GROUP BY E.CODIGO, E.DESCRIPCION, E.LAYOUT, E.SECUENCIA "
	query = query & " ORDER BY E.SECUENCIA "
	
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
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

	query = "SELECT DISTINCT E.CODIGO, E.DESCRIPCION, E.SECUENCIA "
	query = query & "FROM EQUIPOS AS E "
	query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL " 
	query = query & "	AND E.TIPO_EQUIPO = 17" 
	query = query & "	AND E.UBICACION=" & strNvl(FAENA)
	query = query & " ORDER BY SECUENCIA " 

	
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

function ListEquiposHijos()

	query = "SELECT E.CODIGO, E.DESCRIPCION, E.TIPO_EQUIPO "
	query = query & " FROM DBO.EQUIPOS AS E"
	
	
	If CODIGO="NULL" Then
		query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL "
	Else
		query = query & " WHERE E.COD_EQUIPO_PADRE=" & strNvl(CODIGO) 
	End If

	If len(TIPO_HOROMETRO)>0 Then
		query = query & " AND E.TIPO_HOROMETRO=" & strNvl(TIPO_HOROMETRO)
	End If
	
	If len(TIPO)>0 Then
		query = query & " AND E.TIPO_EQUIPO=" & strNvl(TIPO)
	End If
	
	query = query & " GROUP BY E.CODIGO, E.DESCRIPCION, E.TIPO_EQUIPO "

	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(2).Value & "</TIPO_EQUIPO>"
  	   Response.Write "</ROW>"
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

	query = "SELECT E.LAYOUT, E.GCODE, E.X, E.Y, SCALEX, SCALEY "
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
		  Response.Write "<SCALEX>" & ORs.Fields.Item(4).Value & "</SCALEX>"
		  Response.Write "<SCALEY>" & ORs.Fields.Item(5).Value & "</SCALEY>"
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
	query = query & " , SCALEX="  & strNvl(SX)
	query = query & " , SCALEY="  & strNvl(SY)
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

function GetEquipo()

	query = "SELECT E.CODIGO, E.ESTADO, E.DESCRIPCION, E.HOROMETRO, E.HOROMETRO_MAN, "
	query = query & " E.HOROMETRO_VEN, E.HOROMETRO_ALARM, E.DESC_PADRE, E.SISTEMA, E.CIUDAD, E.TIPO_HOROMETRO, "
	query = query & " E.HOROMETRO_PADRE, E.CAPACIDAD,  E.PROVEEDOR, E.VIDA_UTIL, E.UBICACION, CONVERT(CHAR,E.FECHA,103),"
	query = query & " E.ESCALA, E.ESCALA_ALARM, CONVERT(CHAR,E.FECHA_ULT_MAN,103), E.COD_EQUIPO_PADRE,"
	query = query & " E.PROVEEDOR AS DESC_PROVEEDOR, E.GSAP, E.OBSERVACION, "
	query = query & " E.CRITICIDAD, E.RESPONSABLE, E.TIPO_EQUIPO, "
	query = query & " E.SECUENCIA, E.SECCION, E.VALOR_NETO, E.PROPIETARIO, E.DIMENSIONES, "
	query = query & " E.MARCA, E.MODELO, TE.DESCRIPCION, E.FECHA_INSTALACION, E.ANCHO,"
	query = query & " E.ESPESOR, E.TON_SEMANAL, E.ESPESOR_R "
	query = query & "FROM "
	query = query & "  (SELECT E.*, Equipos.DESCRIPCION AS DESC_PADRE "
	query = query & "  FROM EQUIPOS AS E LEFT JOIN Equipos ON E.COD_EQUIPO_PADRE = Equipos.CODIGO "
	query = query & "  WHERE E.CODIGO=" & strNvl(CODIGO) & " AND E.UBICACION=" & strNvl(FAENA) & ") AS E "
	'query = query & " LEFT OUTER JOIN  EXISTENCIAS.DBO.PROVEEDORES AS P ON E.PROVEEDOR = P.RUT"
	query = query & " LEFT OUTER JOIN TIPO_EQUIPOS AS TE ON E.TIPO_EQUIPO = TE.CODIGO ;"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<ESTADO>" & ORs.Fields.Item(1).Value & "</ESTADO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<HOROMETRO>" & ORs.Fields.Item(3).Value & "</HOROMETRO>"
  		  Response.Write "<HOROMETRO_MAN>" & ORs.Fields.Item(4).Value & "</HOROMETRO_MAN>"
   		  Response.Write "<HOROMETRO_VEN>" & ORs.Fields.Item(5).Value & "</HOROMETRO_VEN>"
   		  Response.Write "<HOROMETRO_ALARM>" & ORs.Fields.Item(6).Value & "</HOROMETRO_ALARM>"
	      Response.Write "<EQUIPO_PADRE>" & ORs.Fields.Item(7).Value & "</EQUIPO_PADRE>"
		  Response.Write "<ID_SISTEMA>" & ORs.Fields.Item(8).Value & "</ID_SISTEMA>"
		  Response.Write "<CIUDAD>" & ORs.Fields.Item(9).Value & "</CIUDAD>"
		  Response.Write "<TIPO_HOROMETRO>" & ORs.Fields.Item(10).Value & "</TIPO_HOROMETRO>"
		  Response.Write "<HOROMETRO_PADRE>" & ORs.Fields.Item(11).Value & "</HOROMETRO_PADRE>" 
  		  Response.Write "<CAPACIDAD>" & ORs.Fields.Item(12).Value & "</CAPACIDAD>" 
		  Response.Write "<RUT_PROVEEDOR>" & ORs.Fields.Item(13).Value & "</RUT_PROVEEDOR>"
		  Response.Write "<VIDA_UTIL>" & ORs.Fields.Item(14).Value & "</VIDA_UTIL>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(15).Value & "</UBICACION>"
  		  Response.Write "<FECHA>" & ORs.Fields.Item(16).Value & "</FECHA>"
  		  Response.Write "<ESCALA>" & ORs.Fields.Item(17).Value & "</ESCALA>"
   		  Response.Write "<ESCALA_ALARM>" & ORs.Fields.Item(18).Value & "</ESCALA_ALARM>"
   		  Response.Write "<FECHA_ULT_MAN>" & ORs.Fields.Item(19).Value & "</FECHA_ULT_MAN>"
  		  Response.Write "<COD_EQUIPO_PADRE>" & ORs.Fields.Item(20).Value & "</COD_EQUIPO_PADRE>"
  		  Response.Write "<NOMBRE_PROVEEDOR>" & ORs.Fields.Item(21).Value & "</NOMBRE_PROVEEDOR>"
		  Response.Write "<GSAP>" & ORs.Fields.Item(22).Value & "</GSAP>"
		  Response.Write "<OBSERVACION>" & ORs.Fields.Item(23).Value & "</OBSERVACION>"
		  Response.Write "<CRITICIDAD>" & ORs.Fields.Item(24).Value & "</CRITICIDAD>"
		  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(25).Value & "</RESPONSABLE>"
		  Response.Write "<TIPO_EQUIPO>" & ORs.Fields.Item(26).Value & "</TIPO_EQUIPO>"
		  Response.Write "<SECUENCIA>" & ORs.Fields.Item(27).Value & "</SECUENCIA>"
		  Response.Write "<SECCION>" & ORs.Fields.Item(28).Value & "</SECCION>"
		  Response.Write "<VALOR_NETO>" & ORs.Fields.Item(29).Value & "</VALOR_NETO>"
		  Response.Write "<PROPIETARIO>" & ORs.Fields.Item(30).Value & "</PROPIETARIO>"
		  Response.Write "<DIMENSIONES>" & ORs.Fields.Item(31).Value & "</DIMENSIONES>"
		  Response.Write "<MARCA>" & ORs.Fields.Item(32).Value & "</MARCA>"
		  Response.Write "<MODELO>" & ORs.Fields.Item(33).Value & "</MODELO>"
		  Response.Write "<DESC_TIPO_EQUIPO>" & ORs.Fields.Item(34).Value & "</DESC_TIPO_EQUIPO>"
		  Response.Write "<FECHA_INST>" & ORs.Fields.Item(35).Value & "</FECHA_INST>"
		  Response.Write "<ANCHO>" & ORs.Fields.Item(36).Value & "</ANCHO>"
		  Response.Write "<ESPESOR>" & ORs.Fields.Item(37).Value & "</ESPESOR>"
		  Response.Write "<TON_SEMANAL>" & ORs.Fields.Item(38).Value & "</TON_SEMANAL>"
		  Response.Write "<ESPESOR_R>" & ORs.Fields.Item(39).Value & "</ESPESOR_R>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function existeEquipo()

	query = "SELECT E.CODIGO "
	query = query & "FROM EQUIPOS AS E "
	query = query & " WHERE E.CODIGO='" & CODIGO & "'"
	query = query & " AND UBICACION=" & strNvl(FAENA)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
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

function UpdateEquipo()

	query = "UPDATE EQUIPOS SET ESTADO = " & strNvl(ESTADO) & ", "
	query = query & "DESCRIPCION=" & strNvl(DESCRIPCION) & ","
	query = query & "DIMENSIONES=" & strNvl(DIMENSIONES) & ","
	query = query & "HOROMETRO=" & strNvl(REPLACE(HOROMETRO,",",".")) & ","
	query = query & "HOROMETRO_MAN=" & strNvl(REPLACE(HOROMETRO_MAN,",",".")) & ","
	query = query & "HOROMETRO_VEN=" & strNvl(REPLACE(HOROMETRO_VEN,",",".")) & ","
	query = query & "HOROMETRO_ALARM=" & strNvl(REPLACE(HOROMETRO_ALARM,",",".")) & ","
	query = query & "HOROMETRO_PADRE=" & strNvl(HOROMETRO_PADRE) & ","
	query = query & "ESCALA=" & strNvl(ESCALA) & ", "
	query = query & "ESCALA_ALARM=" & strNvl(ESCALA_ALARM) & ", "
	query = query & "COD_EQUIPO_PADRE=" & strNvl(COD_EQUIPO_PADRE) & ", "
	query = query & "COLOR=" & strNvl(COLOR) & ", "
	query = query & "CAPACIDAD=" & strNvl(CAPACIDAD) & ", "
	query = query & "GSAP=" & strNvl(GSAP) & ", "
	query = query & "CRITICIDAD=" & strNvl(CRITICIDAD) & ", "
	query = query & "POLIZA=" & strNvl(POLIZA) & ", "
	query = query & "PROPIETARIO=" & strNvl(PROPIETARIO) & ", "
	query = query & "SECUENCIA=" & strNvl(SECUENCIA) & ", "
	query = query & "OBSERVACION=" & strNvl(OBSERVACION) & ", "
	query = query & "RESPONSABLE=" & strNvl(RESPONSABLE) & ", "
	query = query & "SISTEMA=" & strNvl(ID_SISTEMA) & ","
	query = query & "CIUDAD=" & strNvl(CIUDAD) & ", "
	query = query & "ANCHO=" & strNvl(ANCHO) & ", "
	query = query & "ESPESOR=" & strNvl(ESPESOR) & ", "
	query = query & "ESPESOR_R=" & strNvl(ESPESOR_R) & ", "
	query = query & "TIPO_HOROMETRO=" & strNvl(TIPO_HOROMETRO) & ","
	query = query & "TIPO_COMBUSTIBLE=" & strNvl(TIPO_COMBUSTIBLE) & ","
	query = query & "TIPO_EQUIPO=" & strNvl(TIPO_EQUIPO) & ","
	query = query & "TON_SEMANAL=" & strNvl(TON_SEMANAL) & ","
	query = query & "MODELO=" & strNvl(MODELO) & ","
	query = query & "MARCA=" & strNvl(MARCA) & ","
	query = query & "FECHA=" & strNvl(FECHA) & ","
	query = query & "FECHA_INSTALACION=" & strNvl(FECHA_INST) & ","
	query = query & "FACTURA=" & strNvl(FACTURA) & ","
	query = query & "FECHA_ULT_MAN=" & strNvl(FECHA_ULT_MAN) & ","
	query = query & "PROVEEDOR=" & strNvl(RUT_PROVEEDOR) & ","
	query = query & "VIDA_UTIL=" & strNvl(VIDA_UTIL) & ", "
	query = query & "SECCION=" & strNvl(SECCION) & ", "
	query = query & "VALOR_NETO=" & strNvl(VALOR_NETO) & " "
	query = query & "WHERE CODIGO=" & strNvl(CODIGO) 
	query = query & " AND UBICACION=" & strNvl(UBICACION) & " "

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write query
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function InsertValorHorometro()

	query = "INSERT INTO HOROMETRO_VALOR ("
	query = query & "COD_HOROMETRO, COD_EQUIPO_PRINCIPAL, COD_EQUIPO, FECHA, VALOR, USERDATE, USERNAME) "
	query = query & " VALUES (" & strNvl(HOROMETRO) & ","
	query = query & "dbo.EquipoPrincipal(" & strNvl(COD_EQUIPO) & "),"
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(FECHA) & ","
	query = query & replace(strNvl(VALOR),",",".") & "," 
	query = query & "GETDATE(), "
	query = query & strNvl(USUARIO) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateValorHorometro()

	query = "UPDATE EQUIPOS SET HOROMETRO = " &  replace(strNvl(VALOR),",",".") 
	query = query & ", USERDATE = GETDATE()"
	query = query & ", USERNAME = " & strNvl(USUARIO)
	query = query & " WHERE GRUPO = " & strNvl(GRUPO) 
	query = query & " AND HOROMETRO_PADRE = " & strNvl(HOROMETRO) 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

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


function DelEquipo()
	query = "DELETE EQUIPOS WHERE CODIGO = '" & CODIGO & "' "
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

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

function ListEquiposCorreas()

	query = "SELECT E.CODIGO, E.DESCRIPCION "
	query = query & " FROM EQUIPOS AS E , EQUIPOS_USUARIOS AS EU"
	
	query = query & " WHERE E.COD_EQUIPO_PADRE IS NULL "
	query = query & " AND  E.CODIGO = EU.EQUIPO AND EU.USUARIO=" & strNvl(USUARIO) 

	If len(TIPO_HOROMETRO)>0 Then
		query = query & " AND E.TIPO_HOROMETRO=" & strNvl(TIPO_HOROMETRO)
	End If
	
	If len(SECCION)>0 Then
		query = query & " AND E.SECCION IN (" & SECCION & ")"
	End If
	
	query = query & " AND E.UBICACION=" & strNvl(FAENA)
	query = query & " AND E.ESTADO='ACT' "
	query = query & " AND E.TIPO_EQUIPO = 1 "
	query = query & " GROUP BY E.CODIGO, E.DESCRIPCION, E.SECUENCIA "
	query = query & " ORDER BY E.SECUENCIA "
	
	
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


function strNvl(Valor)
	if Len(Valor) <1 then
		strNvl = "NULL"
	else
		strNvl = "'" & Valor & "'"	
	end if
end function

function ListEquiposPadresAndina()

	query = "SELECT CODIGO, DESCRIPCION"
	query = query & " FROM EQUIPOS WHERE ESTADO = 'ACT' "
	query = query & " AND COD_EQUIPO_PADRE IS NULL AND UBICACION=" & strNvl(FAENA)
	query = query & " ORDER BY CODIGO, DESCRIPCION "
	
'	response.write query
'	response.End()
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
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

function ListEstocadaAndina()

	query = "SELECT CODIGO, DESCRIPCION FROM EQUIPOS WHERE ESTADO = 'ACT' AND TIPO_EQUIPO=8 AND CODIGO LIKE '%-EST%' "
	query = query & " AND UBICACION=" & strNvl(FAENA)
	
	if strNvl(LISTEQ)<> "NULL" and LISTEQ <> "TOD" then
		query=query&" AND dbo.EquipoPrincipalFaena(CODIGO,UBICACION) ="&strNvl(LISTEQ)
	end if

	query = query & " ORDER BY CODIGO "
	
'	response.write query
'	response.End()
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" 
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
		  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
  	   Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	if LISTEQ = "CV00A6" or LISTEQ = "TOD" then
	  Response.Write "<ROW>" 
		Response.Write "<CODIGO>UNICA</CODIGO>"
		Response.Write "<DESCRIPCION>UNICA A6</DESCRIPCION>"
  	   Response.Write "</ROW>"
	end if
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function
  
function ListMesaAndina()

	query = "SELECT CODIGO, DESCRIPCION FROM EQUIPOS WHERE ESTADO = 'ACT' AND TIPO_EQUIPO=8 AND CODIGO LIKE '%-M%' "
	query = query & " AND UBICACION=" & strNvl(FAENA)

	if strNvl(LISTEQ)<> "NULL" and LISTEQ <> "TOD" then
		query=query&" AND dbo.EquipoPrincipalFaena(CODIGO,UBICACION) ="&strNvl(LISTEQ)
	end if
	if strNvl(LISTEST)<> "NULL" and LISTEST <> "TOD" and LISTEST <> "UNICA" then
		query = query & " AND COD_EQUIPO_PADRE = " & strNvl(LISTEST) 
	end if
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
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

%>

