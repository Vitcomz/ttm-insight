<!--#include file="..\standard\DBConnExist.asp" -->
<%
Dim query, ID
Dim oDB
Set oDB = New DBConn

ID= UCASE(REQUEST("ID"))
CODIGO= UCASE(REQUEST("CODIGO"))
CANTIDAD= UCASE(REQUEST("CANTIDAD"))
COD_BODEGA= UCASE(REQUEST("COD_BODEGA"))
NOMBRE=UCASE(REQUEST("NOMBRE"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))
IND_ARTICULOS=UCASE(REQUEST("IND_ARTICULOS"))
TXT=UCASE(REQUEST("TXT"))
MARCA=REQUEST("MARCA")
MES=REQUEST("MES")
ANHO=REQUEST("ANHO")
APROBADO=UCASE(REQUEST("APROBADO"))
EMPRESA=UCASE(REQUEST("EMPRESA"))
EXCEL=UCASE(REQUEST("EXCEL"))
MODELO=REQUEST("MODELO")
FOLIO_OT=REQUEST("FOLIO_OT")
FOLIO_MOV=REQUEST("FOLIO_MOV")
INICIO=REQUEST("INICIO")
FIN=REQUEST("FIN")
BODEGA=REQUEST("BODEGA")
IND_EXISTENCIA=REQUEST("IND_EXISTENCIA")
IND_STOCK=REQUEST("IND_STOCK")
STOCK_MIN=REQUEST("STOCK_MIN")
FOLIO=REQUEST("FOLIO")
FECHA=REQUEST("FECHA")
FECHA_INI=REQUEST("FECHA_INI")
FECHA_FIN=REQUEST("FECHA_FIN")
FAMILIA=REQUEST("FAMILIA")
SUB_FAMILIA=REQUEST("SUB_FAMILIA")
IND_FAMILIA=REQUEST("IND_FAMILIA")
C=UCASE(REQUEST("c"))
TIPO_MONEDA=REQUEST("TIPO_MONEDA")
PLAZO_ENTREGA=REQUEST("PLAZO_ENTREGA")
COND_PAGO=REQUEST("COND_PAGO")
IND_EXENTA=UCASE(REQUEST("IND_EXENTA"))
UBICACION=UCASE(REQUEST("UBICACION"))
UNIDAD_MEDIDA=UCASE(REQUEST("UNIDAD_MEDIDA"))
SECCION=UCASE(REQUEST("SECCION"))
VALOR=REQUEST("VALOR")
PROVEEDOR=REQUEST("PROVEEDOR") 
RUT_PROVEEDOR=REQUEST("RUT_PROVEEDOR")
RECURSO=REQUEST("RECURSO")

Select Case RECURSO
	Case "GetArticulo"
		GetArticulo()
		
	Case "existeArticulo"
		existeArticulo()
		
	Case "NewArticulo"
		 NewArticulo()
		 
	Case "BuscarArticulos"
		 BuscarArticulos()
		 
	Case "ListInicioInventario"
		 ListInicioInventario()
	
	
	Case "delArticulosCT"
		  delArticulosCT()
			
	Case "newArticulosCT"
		  newArticulosCT()

	Case "updateArticulosCT"
		  updateArticulosCT()
			
	Case "UpdateArticulosOC"
			UpdateArticulosOC()
			
	Case "UpdateArticulo"
		 UpdateArticulos()
		 
	Case "UpdateValorizacion"
		 UpdateValorizacion()
		 
	Case "UpdateUbicacion"
		 UpdateUbicacion()
		 
	Case "GetUbicacion"
		 GetUbicacion()
		 
	Case "Ficha"
		 Ficha()
	
	Case "Saldos"
		 Saldos()
	
	Case "CierreMes"
		  CierreMes()
		 
	Case "existeCierre"
		  existeCierre()
		 
	Case "loadCierre"
		  loadCierre()
		 	 
	Case "InicioProceso"
		 InicioProceso()
		 
	Case "DeleteArticuloInicio"
		 DeleteArticuloInicio()	 
	
	Case "InsertArticulosInicio"
		 InsertArticulosInicio()
		 
	Case "ExisteInicio"
		 ExisteInicio()
		 
	Case "Valorizacion"
		 Valorizacion()

	Case "CalcularSaldos"
		CalcularSaldos()
		
	Case "ListProv"
		ListProv()
		
	Case "ListArticulos"
		ListArticulos()
		
	Case "ListArticulosExistencias"
		ListArticulosExistencias()
		
	Case "ListArticulosOT"
		ListArticulosOT()
		
	Case "ListArticulosUbicacion"
		 ListArticulosUbicacion()
		
	Case "ListArticulosCT"
		  ListArticulosCT()
	
	Case "ListArticulosOC"
		  ListArticulosOC()
	
	Case "ListArticulosOCEx"
		  ListArticulosOCEx()
		
	Case "DelArticulo"
		DelArticulo()
		
End Select

function CalcularSaldos()

ANHO = CINT(ANHO)

   Set cmd = Server.CreateObject("ADODB.Command")
   Set cmd.ActiveConnection = oDB.Conexion

   cmd.CommandText = "EXISTENCIAS.CalculoSaldo"
   cmd.CommandType = 4
   
  cmd.Parameters.Append = cmd.CreateParameter("CODIGO",3,1,,ID)
  cmd.Parameters.Append = cmd.CreateParameter("MES",200,1,2,MES)
  cmd.Parameters.Append = cmd.CreateParameter("ANHO",200,1,4,ANHO)
 
   cmd.Execute
   Set cn = Nothing
   
   Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
		  Response.Write "<RETURN>TRUE</RETURN>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"

end function

function NewArticulo()

	'query = "SELECT MAX(ID) AS NUM FROM ARTICULOS "
	'Set ORs =oDB.EjecutaSql(query)		
	'If Len(oRS("NUM"))>0 Then
	'	N = oRS("NUM") + 1
	'Else
	'	N = 1
	'End If

	query = "INSERT INTO ARTICULOS (ID, CODIGO, DESCRIPCION, MARCA, MODELO, FAMILIA,"
	query = query & "  FECHA, PROVEEDOR, VALOR, UNIDAD_MEDIDA, ESTADO) VALUES ("
	query = query & strNvl(ID) & "," 
	query = query & strNvl(CODIGO) & "," 
	query = query & strNvl(NOMBRE) & ","
	query = query & strNvl(MARCA) & ","
	query = query & strNvl(MODELO) & ","
	query = query & strNvl(FAMILIA)  & ","
	query = query & strNvl(FECHA)  & ", "
	query = query & strNvl(RUT_PROVEEDOR) & " ," 
	query = query & strNvl(VALOR) & "," 
	query = query & strNvl(UNIDAD_MEDIDA) & "," 
	query = query & "'ACT');" 
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	  Response.Write "<ROW>" 
		  Response.Write "<RETURN>" & N & "</RETURN>"
	  Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set oDB = Nothing
end function


function newExistencia()

	 query = "INSERT INTO EXISTENCIA (COD_ARTICULO, COD_BODEGA, STOCK) VALUES ("
	 query = query & strNvl(CODIGO) & ",'PA01',0)"
	 Set ORs =oDB.EjecutaSql(query)
	
end function 

function BuscarArticulos()

	IF IND_ARTICULOS="YES" THEN
		query = "SELECT OC.FOLIO, convert(varchar(30),convert(money,SUM(A_ST.CANTIDAD*A_ST.VALOR)),1), OC.TIPO_MONEDA AS MONEDA,"
		query = query & " P.NOMBRE AS PROVEEDOR, rtrim(CONVERT(CHAR,OC.FECHA,103)) AS FECHA, RESPONSABLE, AREA,"
		query = query & " A.DESCRIPCION, A_ST.CANTIDAD, convert(varchar(30),convert(money,A_ST.VALOR),1) "
		query = query & " FROM ORDEN_COMPRA as OC, "
		query = query & " ARTICULOS_ST AS A_ST, "
		query = query & " ARTICULOS AS A, "
		query = query & " PROVEEDORES AS P "
		query = query & " WHERE OC.FOLIO = a_st.folio_oc "
		query = query & " AND a_st.codigo = a.id "
		query = query & " AND OC.PROVEEDOR = P.RUT "
		query = query & " AND OC.EMPRESA = " & strNvl(EMPRESA)
		If Len(TXT)>0 THEN
				query = query & " AND A.DESCRIPCION LIKE '%" & TXT & "%'"
		End If
		query = query & " GROUP BY  OC.FOLIO,  OC.TIPO_MONEDA,  P.NOMBRE, "
		query = query & " OC.FECHA, RESPONSABLE, AREA, A.DESCRIPCION, A_ST.CANTIDAD, A_ST.VALOR "
		query = query & " ORDER BY OC.FOLIO "
	ELSE
	
		query = "SELECT OC.FOLIO, SUM(A_ST.CANTIDAD*A_ST.VALOR), OC.TIPO_MONEDA AS MONEDA,  P.NOMBRE AS PROVEEDOR, "
		query = query & " RTRIM(CONVERT(CHAR,OC.FECHA,103)) AS FECHA, RESPONSABLE, AREA, "
		query = query & " A.DESCRIPCION, A_ST.CANTIDAD, A_ST.VALOR "
		query = query & " FROM ORDEN_COMPRA as OC, "
		query = query & " SERVICIOS_ST AS A_ST, "
		query = query & " SERVICIOS AS A, "
		query = query & " PROVEEDORES AS P "
		query = query & " WHERE oc.folio = a_st.folio_oc "
		query = query & " AND a_st.codigo = a.codigo "
		If Len(TXT)>0 THEN
				query = query & " AND A.DESCRIPCION LIKE '%" & TXT & "%'"
		End If
		query = query & " AND OC.PROVEEDOR = P.RUT "
		query = query & " AND OC.EMPRESA = " & strNvl(EMPRESA)
		query = query & " GROUP BY  OC.FOLIO,  OC.TIPO_MONEDA,  P.NOMBRE, "
		query = query & " OC.FECHA, RESPONSABLE, AREA, A.DESCRIPCION, A_ST.CANTIDAD, A_ST.VALOR "
		query = query & " ORDER BY OC.FOLIO "
		
	End If

		Set ORs =oDB.EjecutaSql(query)
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
			Response.Write "<REGISTROS>"
			While Not ORs.EOF 
			  Response.Write "<ROW>" 
  				  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
				  Response.Write "<SUMA>" & ORs.Fields.Item(1).Value & "</SUMA>"
				  Response.Write "<MONEDA>" & ORs.Fields.Item(2).Value & "</MONEDA>"
  				  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(3).Value & "</PROVEEDOR>"
				  Response.Write "<FECHA>" & ORs.Fields.Item(4).Value & "</FECHA>"
				  Response.Write "<RESPONSABLE>" & ORs.Fields.Item(5).Value & "</RESPONSABLE>"
				  Response.Write "<AREA>" & ORs.Fields.Item(6).Value & "</AREA>"
				  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(7).Value & "</DESCRIPCION>"
				  Response.Write "<CANTIDAD>" & ORs.Fields.Item(8).Value & "</CANTIDAD>"
				  Response.Write "<VALOR>" & ORs.Fields.Item(9).Value & "</VALOR>"
			  Response.Write "</ROW>"
		 	 ORs.MoveNext
			Wend
			Response.Write "</REGISTROS>"
			

end function 

function ListArticulos()


	IF IND_EXISTENCIA="YES" THEN
			query = "SELECT A.ID, A.CODIGO,  A.DESCRIPCION, isnull(EXISTENCIAS.GetSaldo(A.ID),0) AS SALDO, A.VALOR " 
	 		query = query & " FROM Articulos AS A  "
	 		query = query & " WHERE UPPER(A.DESCRIPCION) LIKE '%" & C & "%'"
	        query = query & "  AND A.ESTADO<>'NUL'  "
			query = query & "  GROUP BY A.ID, A.CODIGO, A.DESCRIPCION,  A.VALOR "
			query = query & " ORDER BY A.DESCRIPCION"
			Set ORs =oDB.EjecutaSql(query)
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
			Response.Write "<REGISTROS>" 
			While Not ORs.EOF 
			  Response.Write "<ROW>" 
  				  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
				  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
				  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
				  Response.Write "<SALDO>" & ORs.Fields.Item(3).Value & "</SALDO>"
				  Response.Write "<VALOR>" & ORs.Fields.Item(4).Value & "</VALOR>"
			  Response.Write "</ROW>"
		 	 ORs.MoveNext
			Wend
			Response.Write "</REGISTROS>"
			
	ELSE
			query = "SELECT A.ID, A.CODIGO, A.DESCRIPCION, A.MARCA, A.MODELO,"
			query = query & "  A.VALOR "
			query = query & " FROM Articulos AS A"
			query = query & " WHERE UPPER(A.DESCRIPCION) LIKE '%" & C & "%' AND A.ESTADO<>'NUL'"
			
			Set ORs =oDB.EjecutaSql(query)
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
			Response.Write "<REGISTROS>"
			While Not ORs.EOF 
			  Response.Write "<ROW>" 
  				  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
				  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
				  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
  				  Response.Write "<MARCA>" & ORs.Fields.Item(3).Value & "</MARCA>"
				  Response.Write "<MODELO>" & ORs.Fields.Item(4).Value & "</MODELO>"
				  Response.Write "<VALOR>" & ORs.Fields.Item(5).Value & "</VALOR>"
			  Response.Write "</ROW>"
		 	 ORs.MoveNext
			Wend
			Response.Write "</REGISTROS>"
	END IF

	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArticulosUbicacion()

			query = "SELECT A.ID, M.COD_ARTICULO,  A.DESCRIPCION, EXISTENCIAS.GetSaldo(M.COD_ARTICULO) AS SALDO, M.UBICACION, M.SECCION " 
	 		query = query & " FROM Articulos AS A, MOVIMIENTOS AS M "
	 		query = query & " WHERE UPPER(A.DESCRIPCION) LIKE '%" & C & "%'"
	        query = query & " AND A.ID = M.COD_ARTICULO AND A.ESTADO<>'NUL' AND SALDO>0 "
			query = query & " GROUP BY A.ID, M.COD_ARTICULO, A.DESCRIPCION, M.UBICACION, M.SECCION"
			query = query & " ORDER BY A.DESCRIPCION"
			Set ORs =oDB.EjecutaSql(query)
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
			Response.Write "<REGISTROS>"
			While Not ORs.EOF 
			  Response.Write "<ROW>" 
  				  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
				  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
				  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
  				  Response.Write "<STOCK>" & ORs.Fields.Item(3).Value & "</STOCK>"
				  Response.Write "<UBICACION>" & ORs.Fields.Item(4).Value & "</UBICACION>"
				  Response.Write "<SECCION>" & ORs.Fields.Item(5).Value &  "</SECCION>"
			  Response.Write "</ROW>"
		 	 ORs.MoveNext
			Wend
			Response.Write "</REGISTROS>"
			
	
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArticulosExistencias()

			query = "SELECT A.ID, A.CODIGO, A.DESCRIPCION, A.MARCA, A.MODELO,"
			query = query & "  A.VALOR "
			query = query & " FROM Articulos AS A, FAMILIAS AS F"
			query = query & " WHERE UPPER(A.DESCRIPCION) LIKE '%" & C & "%'"
			query = query & " AND A.FAMILIA = F.CODIGO AND F.IND_EXISTENCIA='TRUE' AND A.ESTADO<>'NUL'"
			
			Set ORs =oDB.EjecutaSql(query)
			Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
			Response.Write "<REGISTROS>"
			While Not ORs.EOF 
			  Response.Write "<ROW>" 
  				  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
				  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
				  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
  				  Response.Write "<MARCA>" & ORs.Fields.Item(3).Value & "</MARCA>"
				  Response.Write "<MODELO>" & ORs.Fields.Item(4).Value & "</MODELO>"
				  Response.Write "<VALOR>" & ORs.Fields.Item(5).Value & "</VALOR>"
			  Response.Write "</ROW>"
		 	 ORs.MoveNext
			Wend
			Response.Write "</REGISTROS>"
	
	
	Set ORs = Nothing
	Set ODB = Nothing
end function


function ListArticulosOT()

	 query = "SELECT A.ID, A.DESCRIPCION, A.VALOR, AO.CANTIDAD "
	 query = query & "FROM ARTICULOS AS A, SCI.DBO.ARTICULOS_OT AS AO "
	 query = query & "WHERE A.ID = AO.ID AND ESTADO<>'NUL'"
 	 query = query & " AND AO.FOLIO_OT= " & FOLIO_OT
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<CODIGO>" & ORs.Fields.Item(0).Value & "</CODIGO>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  If Len(ORs.Fields.Item(2).Value)>0 Then
		  		VALOR = ORs.Fields.Item(2).Value
		  Else
		  		VALOR = 0
		  End If
   		  Response.Write "<VALOR>" & VALOR & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListInicioInventario()

	
	query = "SELECT M.FOLIO, M.COD_ARTICULO, A.DESCRIPCION, "
	query = query & " M.CANTIDAD, convert(varchar(30),convert(money,M.VALOR),1),"
	query = query & " convert(varchar(30),convert(money,M.VALOR*M.CANTIDAD),1), "
	query = query & " M.UBICACION, M.SECCION  "
	query = query & " FROM MOVIMIENTOS AS M, ARTICULOS AS A "
	query = query & " WHERE M.FOLIO =" & strNvl(FOLIO) & " "
	query = query & " 	AND M.COD_ARTICULO = A.ID "
	query = query & " ORDER BY M.COD_ARTICULO , M.FECHA "
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<ID>" & ORs.Fields.Item(1).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(4).Value & "</VALOR>"
		  Response.Write "<TOTAL>" &  ORs.Fields.Item(5).Value & "</TOTAL>"
		  Response.Write "<UBICACION>" & ORs.Fields.Item(6).Value & "</UBICACION>"
		  Response.Write "<SECCION>" & ORs.Fields.Item(7).Value & "</SECCION>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArticulosCT()

	 query = "SELECT AC.FOLIO, A.ID, AC.CODIGO, AC.DESCRIPCION, AC.CANTIDAD, AC.VALOR , A.UNIDAD_MEDIDA "
	 query = query & " FROM ARTICULOS AS A, ARTICULOS_CT AS AC "
	 query = query & " WHERE A.ID = AC.CODIGO "
 	 query = query & " AND AC.FOLIO= " & FOLIO
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF
	 
	  Response.Write "<ROW>" 
	  	  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<ID>" & ORs.Fields.Item(1).Value & "</ID>"
  		  Response.Write "<CODIGO>" & ORs.Fields.Item(2).Value & "</CODIGO>"
   		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(3).Value & "</DESCRIPCION>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(4).Value & "</CANTIDAD>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(5).Value & "</VALOR>"
		  Response.Write "<UNIDAD>" & ORs.Fields.Item(6).Value & "</UNIDAD>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArticulosOC()

	 query = "SELECT A.ID, A.DESCRIPCION, OC.VALOR, OC.CANTIDAD, OC.APROBADO, OC.PROVEEDOR "
	 query = query & "FROM ARTICULOS AS A, ARTICULOS_ST AS OC "
	 query = query & "WHERE A.ID = OC.CODIGO "
 	 query = query & " AND OC.FOLIO_OC= " & FOLIO
	 query = query & " AND OC.EMPRESA= " & strNvl(EMPRESA)
	 
	IF LEN(APROBADO)>0 THEN
	  	 query = query & " AND OC.APROBADO='TRUE' " 
   	END IF
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
   		  Response.Write "<APROBADO>" & ORs.Fields.Item(4).Value & "</APROBADO>"
		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(5).Value & "</PROVEEDOR>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function ListArticulosOCEx()

	 query = "SELECT A.ID, A.DESCRIPCION, OC.VALOR, OC.CANTIDAD, OC.APROBADO, OC.PROVEEDOR, A.FAMILIA, "
	 query = query & " F.IND_EXISTENCIA, OC.CANTIDAD_PENDIENTE "
	 query = query & " FROM ARTICULOS AS A, ARTICULOS_ST AS OC, FAMILIAS AS F "
	 query = query & " WHERE A.ID = OC.CODIGO" 
	 query = query & " AND A.FAMILIA = F.CODIGO"
 	 query = query & " AND OC.FOLIO_OC= " & FOLIO
	 query = query & " AND F.IND_EXISTENCIA= 'TRUE' AND OC.APROBADO='TRUE' "
	 query = query & " AND CANTIDAD_PENDIENTE > 0"
	 query = query & " AND OC.EMPRESA=" & strNvl(EMPRESA)
	 
	IF LEN(APROBADO)>0 THEN
	  	 query = query & " AND OC.APROBADO='TRUE' " 
   	END IF
		 
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	  Response.Write "<ROW>" 
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
   		  Response.Write "<VALOR>" & ORs.Fields.Item(2).Value & "</VALOR>"
   		  Response.Write "<CANTIDAD>" & ORs.Fields.Item(3).Value & "</CANTIDAD>"
   		  Response.Write "<APROBADO>" & ORs.Fields.Item(4).Value & "</APROBADO>"
		  Response.Write "<PROVEEDOR>" & ORs.Fields.Item(5).Value & "</PROVEEDOR>"
		  Response.Write "<CANTIDAD_PENDIENTE>" & ORs.Fields.Item(8).Value & "</CANTIDAD_PENDIENTE>"
	  Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function
	 
function GetUbicacion()

	query = "SELECT EX.UBICACION, EX.SECCION "
	query = query & " FROM EXISTENCIA AS EX "
	query = query & " WHERE EX.COD_ARTICULO=" & ID & "  " 
	query = query & " AND EX.COD_BODEGA = " & strNvl(BODEGA)

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
 		  Response.Write "<UBICACION>" & ORs.Fields.Item(0).Value & "</UBICACION>"
		  Response.Write "<SECCION>" & ORs.Fields.Item(1).Value & "</SECCION>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function Ficha()

	query = "SELECT  M.FOLIO, RTRIM(CONVERT(CHAR, M.FECHA, 103)) + ' ' + "
	query = query & " substring(convert(char,M.FECHA,108),1,5) AS FECHA, ING.TIPO_DOC, ING.NRO_DOCUMENTO, "
	query = query & "	  ENTRADAS = CASE M.TIPO WHEN 'ING' THEN CANTIDAD END,"
	query = query & "	  SALIDAS = CASE M.TIPO WHEN 'SAL' THEN CANTIDAD END,"
	query = query & "	  M.SALDO, M.VALORIZACION, CAST(M.PPM AS DECIMAL(16,2)) "
	query = query & " FROM      MOVIMIENTOS AS M"
	query = query & " LEFT OUTER JOIN INGRESOS AS ING ON ING.FOLIO=M.FOLIO AND M.TIPO='ING' "
	query = query & " LEFT OUTER JOIN EGRESOS AS EGR ON EGR.FOLIO=M.FOLIO AND M.TIPO='SAL' "
	query = query & " WHERE M.COD_ARTICULO = " & ID
	query = query & "		  AND M.FECHA >= '" & FECHA_INI & "'"
	query = query & "		  AND M.FECHA <= '" & FECHA_FIN & "'"
	query = query & " GROUP BY M.FOLIO, M.FECHA, M.TIPO, ING.TIPO_DOC, ING.NRO_DOCUMENTO, "
	query = query & " CANTIDAD, M.SALDO, M.VALORIZACION	, M.PPM "
	query = query & " ORDER BY CAST(M.FECHA AS DATETIME) ASC"
	
	Set ORs =oDB.EjecutaSql(query)
	
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>FOLIO</TD>"
   				   Response.Write "<TD>FECHA</TD>"
   				   Response.Write "<TD>TIPO</TD>"
   				   Response.Write "<TD>NUMERO DOC</TD>"
   				   Response.Write "<TD>ENTRADAS</TD>"
   				   Response.Write "<TD>SALIDAS</TD>"
   				   Response.Write "<TD>SALDO</TD>"
   				   Response.Write "<TD>VALORIZACION</TD>"
				   Response.Write "<TD>VALOR ENTRADAS</TD>"
				   Response.Write "<TD>VALOR SALIDAS</TD>"
				   Response.Write "<TD>VALOR SALDO</TD>"
				   Response.Write "<TD>PPM USD</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   				    ENTRADAS = CInt(numNvl(ORs.Fields.Item(4).Value))
		  	 		SALIDAS = CInt(numNvl(ORs.Fields.Item(5).Value))
		 			 If Not isNull(ORs.Fields.Item(7).Value) Then
		  				VALOR1 = CDBL(numNvl(ORs.Fields.Item(7).Value))
						SALDO = SALDO + (ENTRADAS*VALOR1)
					  Else
			   		    SALDO = SALDO - (SALIDAS*VALOR1)
			  		End If
		  
			  Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
			  Response.Write "<TD>" & VALOR1 & "</TD>"	
			  Response.Write "<TD>" & ENTRADAS * VALOR1 & "</TD>"
			  Response.Write "<TD>" & SALIDAS * VALOR1 & "</TD>"
			  Response.Write "<TD>" & SALDO & "</TD>"
			  Response.Write "<TD>" & ORs.Fields.Item(8).Value & "</TD>"
   			  Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
		 Response.Write "<TR>"
				 Response.Write "<TD COLSPAN='8'>TOTAL GENERAL " & SUM_TOTAL & "</TD>"
				 Response.Write "</TR>"
	    Response.Write "</TABLE>"
	ELSE
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>" 
		SALDO = 0
		WHILE NOT ORs.EOF 
		 	 Response.Write "<ROW>" 
 		 	 Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  	 Response.Write "<FECHA>" & ORs.Fields.Item(1).Value & "</FECHA>"
		  	 Response.Write "<TIPO>" & ORs.Fields.Item(2).Value & "</TIPO>"
		 	 Response.Write "<NRO_DOC>" & ORs.Fields.Item(3).Value & "</NRO_DOC>"
		  	 ENTRADAS = CInt(numNvl(ORs.Fields.Item(4).Value))
		  	 SALIDAS = CInt(numNvl(ORs.Fields.Item(5).Value))
		 	 If isNull(ORs.Fields.Item(5).Value) Then
		  			VALOR1 = CDBL(numNvl(ORs.Fields.Item(7).Value))
					SALDO = formatNumber(SALDO + (ENTRADAS*VALOR1),2)
			  Else
			  		VALOR1 = CDBL(numNvl(ORs.Fields.Item(8).Value))
			  		SALDO = formatNumber(SALDO - (SALIDAS*VALOR1),2)
			  End If
		  
			  Response.Write "<ENTRADAS>" & ORs.Fields.Item(4).Value & "</ENTRADAS>"
			  Response.Write "<SALIDAS>" & ORs.Fields.Item(5).Value & "</SALIDAS>"
			  Response.Write "<SALDO>" & ORs.Fields.Item(6).Value & "</SALDO>"
			  Response.Write "<VALORIZACION>" & VALOR1 & "</VALORIZACION>"
 			  Response.Write "<PPM>" & ORs.Fields.Item(8).Value & "</PPM>"	
			  Response.Write "<ENTRADAS_V>" & ENTRADAS * VALOR1 & "</ENTRADAS_V>"
			  Response.Write "<SALIDAS_V>" & SALIDAS * VALOR1 & "</SALIDAS_V>"
			  Response.Write "<SALDO_V>" & SALDO & "</SALDO_V>"
		    
		  Response.Write "</ROW>"
		  ORs.MOVENEXT
		WEND 
		Response.Write "</REGISTROS>"
	END IF
	Set ORs = Nothing
	Set ODB = Nothing
end function

function Valorizacion()

	query = "SELECT   M.FOLIO, A.ID, A.DESCRIPCION,"
	query = query & " RTRIM(CONVERT(CHAR, M.FECHA, 103)) + ' ' + SUBSTRING(CONVERT(CHAR,M.FECHA,108),1,5) AS FECHA, "
	query = query & " ING.TIPO_DOC, ING.NRO_DOCUMENTO," 
	query = query & " ENTRADAS = CASE M.TIPO WHEN 'ING' THEN CANTIDAD END,"
	query = query & " convert(varchar(30),convert(money,M.VALOR),1),"
	query = query & " convert(varchar(30),convert(money,M.PPM),1),"
	query = query & " convert(varchar(30),convert(money,M.VALORIZACION),1), M.FOLIO_MOV "
	query = query & " FROM MOVIMIENTOS AS M"
	query = query & " LEFT OUTER JOIN INGRESOS AS ING ON ING.FOLIO=M.FOLIO AND M.TIPO='ING'"
	query = query & " LEFT OUTER JOIN ARTICULOS AS A ON A.ID=M.COD_ARTICULO "
	query = query & " WHERE "
	query = query & " 		  SUBSTRING(RTRIM(CONVERT(CHAR,M.FECHA,103)),4,2) =" & MES
	query = query & " 		  AND SUBSTRING(RTRIM(CONVERT(CHAR,M.FECHA,103)),7,4)='" & ANHO &"'"
	query = query & " 		  AND M.TIPO='ING'"
	query = query & " GROUP BY M.FOLIO, A.ID, A.DESCRIPCION, M.FECHA, M.TIPO, "
	query = query & " 	 ING.TIPO_DOC, ING.NRO_DOCUMENTO, CANTIDAD,"
	query = query & " 	 M.SALDO, M.VALOR, M.PPM, M.VALORIZACION, M.FOLIO_MOV"
	query = query & " ORDER BY A.DESCRIPCION, M.FECHA"

	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	WHILE NOT ORs.EOF 
	  Response.Write "<ROW>" 
 		  Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
		  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(2).Value & "</DESCRIPCION>"
		  Response.Write "<FECHA>" & ORs.Fields.Item(3).Value & "</FECHA>"
		  Response.Write "<TIPO_DOC>" & ORs.Fields.Item(4).Value & "</TIPO_DOC>"
		  Response.Write "<NRO_DOC>" & ORs.Fields.Item(5).Value & "</NRO_DOC>"
		  Response.Write "<ENTRADAS>" & ORs.Fields.Item(6).Value & "</ENTRADAS>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(7).Value & "</VALOR>"  
		  Response.Write "<PPM>" & ORs.Fields.Item(8).Value & "</PPM>" 
		  Response.Write "<VALORIZACION>" & ORs.Fields.Item(9).Value & "</VALORIZACION>" 
		  Response.Write "<FOLIO_MOV>" & ORs.Fields.Item(10).Value & "</FOLIO_MOV>" 
	  Response.Write "</ROW>"
	  ORs.MOVENEXT
	WEND 
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateValorizacion()
	query = "UPDATE MOVIMIENTOS SET VALORIZACION = " & VALOR 
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND TIPO='ING' AND COD_ARTICULO=" & ID
	query = query & " AND FOLIO_MOV =" & FOLIO_MOV
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	 Response.Write "<ROW>" 
 		  Response.Write "<ID>TRUE</ID>"
	 Response.Write "</ROW>"	
	Response.Write "</REGISTROS>"

end function

function UpdateUbicacion()

	query = "UPDATE MOVIMIENTOS SET UBICACION = " & strNvl(UBICACION) & ", "
	query = query & " SECCION =" & strNvl(SECCION) 
	query = query & " WHERE FOLIO=" & FOLIO 
	query = query & " AND  COD_ARTICULO=" & ID
	Set ORs =oDB.EjecutaSql(query)
	
	query = "SELECT STOCK FROM EXISTENCIA "
	query = query & "  WHERE COD_BODEGA = " & strNvl(COD_BODEGA)
	query = query & "  AND  COD_ARTICULO = " & strNvl(ID)
	Set ORs =oDB.EjecutaSql(query)
	
	If ORs.eof Then
			query = "INSERT INTO EXISTENCIA (COD_BODEGA, COD_ARTICULO, UBICACION, SECCION, STOCK) VALUES ("
			query = query &  strNvl(COD_BODEGA) & ","
			query = query &  strNvl(ID) & ", "
			query = query &  strNvl(UBICACION) & ", "
			query = query &  strNvl(SECCION) & ", "
			query = query &  strNvl(CANTIDAD) & ")"
	Else
			query = "UPDATE EXISTENCIA SET UBICACION = " & strNvl(UBICACION) & ", "
			query = query & "SECCION = " & strNvl(SECCION) & ", "
			query = query & "STOCK = " & strNvl(CANTIDAD) & " "
			query = query & "  WHERE COD_BODEGA = " & strNvl(COD_BODEGA)
			query = query & "  AND  COD_ARTICULO = " & strNvl(ID)
	End If
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	 Response.Write "<ROW>" 
 		  Response.Write "<ID>TRUE</ID>"
	 Response.Write "</ROW>"	
	Response.Write "</REGISTROS>"

end function


function GetArticulo()

	query = "SELECT A.ID, A.CODIGO, A.DESCRIPCION, A.MARCA AS COD_MARCA, M.DESCRIPCION,"
	query = query & " A.MODELO AS COD_MODELO, MO.DESCRIPCION, A.FAMILIA, A.SUB_FAMILIA, "
	query = query & " A.FECHA,  A.VALOR , A.STOCK_MIN, A.TIPO_MONEDA, A.UNIDAD_MEDIDA "
	query = query & " FROM ARTICULOS AS A "
	query = query & " LEFT OUTER JOIN MARCAS AS M ON A.MARCA = M.CODIGO"
	query = query & " LEFT OUTER JOIN MODELOS AS MO ON A.MODELO = MO.CODIGO"
	query = query & " WHERE A.ID=" & strNvl(ID) & "  " 

	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	If Not ORs.EOF Then
	  Response.Write "<ROW>" 
 		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<CODIGO>" & ORs.Fields.Item(1).Value & "</CODIGO>"
		  Response.Write "<NOMBRE>" & ORs.Fields.Item(2).Value & "</NOMBRE>"
		  Response.Write "<COD_MARCA>" & ORs.Fields.Item(3).Value & "</COD_MARCA>"
  		  Response.Write "<MARCA>" & ORs.Fields.Item(4).Value & "</MARCA>"
		  Response.Write "<COD_MODELO>" & ORs.Fields.Item(5).Value & "</COD_MODELO>"
  		  Response.Write "<MODELO>" & ORs.Fields.Item(6).Value & "</MODELO>"
   		  Response.Write "<FAMILIA>" & ORs.Fields.Item(7).Value & "</FAMILIA>"
   		  Response.Write "<SUB_FAMILIA>" & ORs.Fields.Item(8).Value & "</SUB_FAMILIA>"
   		  Response.Write "<FECHA>" & ORs.Fields.Item(9).Value & "</FECHA>" 
		  Response.Write "<VALOR>" & ORs.Fields.Item(10).Value & "</VALOR>"
		  Response.Write "<STOCK_MIN>" & ORs.Fields.Item(11).Value & "</STOCK_MIN>"
		  Response.Write "<TIPO_MONEDA>" & ORs.Fields.Item(12).Value & "</TIPO_MONEDA>"
		  Response.Write "<UNIDAD_MEDIDA>" & ORs.Fields.Item(13).Value & "</UNIDAD_MEDIDA>"
	  Response.Write "</ROW>"
	End If
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function existeArticulo()

	query = "SELECT A.ID "
	query = query & "FROM ARTICULOS AS A "
	
	If Len(ID)>0 THEN
		query = query & "WHERE A.ID=" & strNvl(ID)
	End If
	
	If Len(NOMBRE)>0 THEN
		query = query & "WHERE A.DESCRIPCION=" & strNvl(NOMBRE)
	End If
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	
	If ORs.EOF Then
	 	Response.Write "<ROW><RETURN>NOT</RETURN></ROW>"
	Else
		Response.Write "<ROW><RETURN>YES</RETURN></ROW>"
	End If
	
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

function newArticulosCT()

	query = "INSERT INTO ARTICULOS_CT (FOLIO, CODIGO, DESCRIPCION, CANTIDAD,  VALOR) VALUES ("
	query = query & FOLIO & ","
	query = query & strNvl(CODIGO) & ","
	query = query & strNvl(DESCRIPCION) & ","
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(VALOR) & ")"

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function updateArticulosCT()

	query = "UPDATE ARTICULOS_CT SET "
	query = query & "CANTIDAD =" & strNvl(CANTIDAD) & ","
	query = query & "VALOR =" & strNvl(VALOR) & " "
	query = query & " WHERE CODIGO = " & strNvl(CODIGO)
	query = query & " AND FOLIO = " & strNvl(FOLIO) 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateArticulosOC()

	query = "UPDATE ARTICULOS_ST SET "
	query = query & "CANTIDAD =" & strNvl(CANTIDAD) & ","
	query = query & "VALOR =" & strNvl(VALOR) & " "
	
	If Len(APROBADO) > 0 Then
		query = query & ", APROBADO =" & strNvl(APROBADO) & " "
	End If
	
	If Len(RUT_PROVEEDOR) > 0 Then
	query = query & ", PROVEEDOR =" & strNvl(RUT_PROVEEDOR) & " "
	End If

	query = query & " WHERE CODIGO = " & strNvl(CODIGO)
	query = query & " AND FOLIO_OC = " & strNvl(FOLIO) 

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function UpdateArticulos()
	query = "UPDATE Articulos SET DESCRIPCION = " & strNvl(NOMBRE) & ", "
	query = query & "CODIGO=" & strNvl(CODIGO) & ", "
	query = query & "MARCA=" & strNvl(MARCA) & ", "
	query = query & "MODELO=" & strNvl(MODELO) & ", "
	query = query & "FECHA=" & strNvl(FECHA) & ", "
	query = query & "FAMILIA=" & strNvl(FAMILIA) & ", "
	query = query & "STOCK_MIN=" & strNvl(STOCK_MIN) & ", "
	query = query & "SUB_FAMILIA=" & strNvl(SUB_FAMILIA) & ", "
	query = query & "TIPO_MONEDA=" & strNvl(TIPO_MONEDA) & ", "
	query = query & "UNIDAD_MEDIDA=" & strNvl(UNIDAD_MEDIDA) & ", "
	query = query & "VALOR=" & strNvl(VALOR) & " "
	query = query & "WHERE ID=" & strNvl(ID)
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

Function ExisteInicio()

	query = "SELECT FOLIO_INICIO_PROCESO, MES_PROCESO FROM PARAMETROS "
	Set ORs =oDB.EjecutaSql(query)		
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<FOLIO>" & ORs.Fields.Item(0).Value & "</FOLIO>"
	Response.Write "<MES_PROCESO>" & ORs.Fields.Item(1).Value & "</MES_PROCESO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	

End Function

Function InicioProceso()
Dim N 

	query = "SELECT MAX(FOLIO) AS NUM FROM INGRESOS "
	Set ORs =oDB.EjecutaSql(query)		
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO INGRESOS (FOLIO, FECHA, PROVEEDOR, ORDEN_COMPRA, RECEPTOR, OBSERVACION, NRO_DOCUMENTO, TIPO_DOC ) "
	query = query & " VALUES ("
	query = query & N & "," 
	query = query & "'01/" & MES & "/2008',"
	query = query & "99511240,"
	query = query & "0,"
	query = query & strNvl(RESPONSABLE)  & ","
	query = query & "'INICIO DE PROCESO MES=" & MES & "',"
	query = query & "0," 
	query = query & "'INI');" 
	
	Set ORs =oDB.EjecutaSql(query)
	
	query = "UPDATE PARAMETROS SET FOLIO_INICIO_PROCESO =" & N
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"
	Response.Write "<FOLIO>" & N & "</FOLIO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
End Function

Function InsertArticulosInicio()
Dim N 


	query = "SELECT MAX(FOLIO_MOV) AS NUM FROM MOVIMIENTOS "
	Set ORs =oDB.EjecutaSql(query)		
	
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO MOVIMIENTOS (FOLIO_MOV, FOLIO, COD_ARTICULO, COD_BODEGA, TIPO, FECHA,"
	query = query & " CANTIDAD, VALOR, VALORIZACION, UBICACION, SECCION ) VALUES ("
	query = query & N & ","
	query = query & strNvl(FOLIO) & ","
	query = query & strNvl(CODIGO) & ","
	query = query & "'MICH01','ING',"
	query = query & "'01/" & MES & "/2008 ' + Convert(Char(8), getdate(), 108),"
	query = query & strNvl(CANTIDAD) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(VALOR) & ","
	query = query & "NULL,"
	query = query & "NULL)"

	Set oDB = New DBConn	
	Set ORs =oDB.EjecutaSql(query)
		
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>"  
	Response.Write "	<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</ROW>"
	Response.Write "</REGISTROS>"
	
	COD_BODEGA = "MICH01"
	COD_ARTICULO = CODIGO
	query = "SELECT STOCK FROM EXISTENCIA WHERE "
	query = query & " COD_ARTICULO = " & strNvl(COD_ARTICULO) & " "
	query = query & " AND COD_BODEGA = " & strNvl(COD_BODEGA) & " "
	query = query & " AND UBICACION = " & strNvl(UBICACION) & " "
	query = query & " AND SECCION = " & strNvl(SECCION) & " "
	
	Set ORs =oDB.EjecutaSql(query)
	
	If (ORs.eof) Then
	
		query = "INSERT INTO EXISTENCIA (COD_BODEGA, COD_ARTICULO, UBICACION, SECCION, STOCK) VALUES ("
		query = query &  strNvl(COD_BODEGA) & ","
		query = query &  strNvl(COD_ARTICULO) & ", "
		query = query &  strNvl(UBICACION) & ", "
		query = query &  strNvl(SECCION) & ", "
		query = query &  strNvl(CANTIDAD) & ")"
	
		Set ORs =oDB.EjecutaSql(query)
	Else
		query = "UPDATE EXISTENCIA SET STOCK = STOCK + " &  CANTIDAD
		query = query & " WHERE COD_BODEGA = " & strNvl(COD_BODEGA) & " "
		query = query & " AND COD_ARTICULO = " &  strNvl(COD_ARTICULO) & " "
		IF strNvl(UBICACION)="NULL" THEN
				query = query & " AND UBICACION IS NULL " 
		ELSE
				query = query & " AND UBICACION = " & strNvl(UBICACION) 
		END IF
	
		IF strNvl(SECCION)="NULL" THEN
			query = query & " AND SECCION IS NULL " 
		ELSE
			query = query & " AND SECCION = " & strNvl(SECCION) & " " 
		END IF
	
		Set ORs =oDB.EjecutaSql(query)
	
	End If
	Set ORs = Nothing
	Set ODB = Nothing

End Function

FUNCTION Saldos()

INICIO = CDATE(INICIO)
FIN = CDATE(FIN)
MES = CINT(MONTH(FIN))
TOTAL = 0
SUM_TOTAL = 0

	query ="SELECT  A.ID, A.DESCRIPCION, "
	query = query & "	SALDO =	SUM(CASE WHEN (M.TIPO='ING' "
	query = query & "		AND M.FECHA<'" & INICIO & "') "
	query = query & "		THEN CANTIDAD ELSE 0 END) - "
	query = query & "				SUM(CASE WHEN (M.TIPO='SAL' "
	query = query & "							AND M.FECHA<'" & INICIO & "')"
	query = query & "							THEN CANTIDAD ELSE 0 END),"
	query = query & " 	ENTRADAS = SUM(CASE WHEN (M.TIPO='ING' "
	query = query & "							AND M.FECHA BETWEEN '" & INICIO & "' AND '" & FIN & "') "
	query = query & "							THEN CANTIDAD ELSE 0 END), "
	query = query & "	SALIDAS = SUM(CASE WHEN (M.TIPO='SAL' "
	query = query & "							AND M.FECHA BETWEEN '" & INICIO & "' AND '" & FIN & "') "
	query = query & "							 THEN CANTIDAD ELSE 0 END), "
	query = query & "	EXISTENCIAS.GetPPM(A.ID,'" & FIN & "'), M.UBICACION, M.SECCION "
	query = query & "  FROM     MOVIMIENTOS AS M, " 
	query = query & " 		    ARTICULOS AS A "
	query = query & "  WHERE  A.ID=M.COD_ARTICULO "
	query = query & "		  AND M.FECHA <= '" & FIN & "'"
	
	
	If Len(FAMILIA)>0 Then
		query = query & "		AND A.FAMILIA = " & strNvl(FAMILIA)
	End If
	query = query & "  GROUP BY  A.ID,  A.DESCRIPCION, "
	query = query & "			M.UBICACION, M.SECCION "
	query = query & " ORDER BY A.DESCRIPCION "
	 
	Set ORs =oDB.EjecutaSql(query)
	
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>CODIGO</TD>"
   				   Response.Write "<TD>DESCRIPCION</TD>"
   				   Response.Write "<TD>SALDO ANTERIOR</TD>"
   				   Response.Write "<TD>ENTRADAS</TD>"
   				   Response.Write "<TD>SALIDAS</TD>"
   				   Response.Write "<TD>SALDOS</TD>"
   				   Response.Write "<TD>VALOR UNITARIO</TD>"
   				   Response.Write "<TD>STOCK TOTAL VALORIZADO</TD>"
  				   Response.Write "<TD>UBICACI�N</TD>"
				   Response.Write "<TD>SECCION</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
				   SALDO = (CINT(ORs.Fields.Item(3).Value) - CINT(ORs.Fields.Item(4).Value)) + CINT(ORs.Fields.Item(2).Value)
   				   Response.Write "<TD>" & SALDO & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
				   TOTAL = (SALDO)*ORs.Fields.Item(5).Value
   				   Response.Write "<TD>" & TOTAL & "</TD>"
				   SUM_TOTAL = SUM_TOTAL + TOTAL
   				   Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
		 Response.Write "<TR>"
				 Response.Write "<TD COLSPAN='8'>TOTAL GENERAL " & SUM_TOTAL & "</TD>"
				 Response.Write "</TR>"
	    Response.Write "</TABLE>"
	ELSE
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		While Not ORs.EOF 
	 	 Response.Write "<ROW>" 
	  		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  			  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
			  Response.Write "<SALDO_ANT>" & ORs.Fields.Item(2).Value & "</SALDO_ANT>"
   			  Response.Write "<ENTRADAS>" & ORs.Fields.Item(3).Value & "</ENTRADAS>"  
   			  Response.Write "<SALIDAS>" & ORs.Fields.Item(4).Value & "</SALIDAS>"
			  SALDO = (CINT(ORs.Fields.Item(3).Value) - CINT(ORs.Fields.Item(4).Value)) + CINT(ORs.Fields.Item(2).Value)
			  Response.Write "<SALDO>" & SALDO  & "</SALDO>"
   			  Response.Write "<PPM>" & ORs.Fields.Item(5).Value & "</PPM>"
			  TOTAL = (SALDO)*ORs.Fields.Item(5).Value
			  Response.Write "<TOTAL>" & TOTAL & "</TOTAL>"
			  SUM_TOTAL = SUM_TOTAL + TOTAL
			  Response.Write "<UBICACION>" & ORs.Fields.Item(6).Value & "</UBICACION>"
			  Response.Write "<SECCION>" & ORs.Fields.Item(7).Value & "</SECCION>"
	  	Response.Write "</ROW>"
	 	 ORs.MoveNext
		Wend
		Response.Write "<ROW>" 
			  Response.Write "<SUM_TOTAL>TOTAL  " & SUM_TOTAL  &  "</SUM_TOTAL>"
		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	END IF
	Set ORs = Nothing
	Set ODB = Nothing
	 
END FUNCTION

FUNCTION CierreMes()


MES = Month(Fin)
ANHO = Year(Fin)
TOTAL = 0
SUM_TOTAL = 0

	query = query & "INSERT INTO CIERRE (MES, ANHO, ID, DESCRIPCION, SALDO, ENTRADAS, SALIDAS, VALOR_UNI, UBICACION, SECCION) "
	query = query & " SELECT " & MES & "," & ANHO & ", A.ID, A.DESCRIPCION, "
	query = query & "	SALDO =	SUM(CASE WHEN (M.TIPO='ING' "
	query = query & "		AND M.FECHA<'" & INICIO & "') "
	query = query & "		THEN CANTIDAD ELSE 0 END) - "
	query = query & "				SUM(CASE WHEN (M.TIPO='SAL' "
	query = query & "							AND M.FECHA<'" & INICIO & "')"
	query = query & "							THEN CANTIDAD ELSE 0 END),"
	query = query & " 	ENTRADAS = SUM(CASE WHEN (M.TIPO='ING' "
	query = query & "							AND M.FECHA BETWEEN '" & INICIO & "' AND '" & FIN & "') "
	query = query & "							THEN CANTIDAD ELSE 0 END), "
	query = query & "	SALIDAS = SUM(CASE WHEN (M.TIPO='SAL' "
	query = query & "							AND M.FECHA BETWEEN '" & INICIO & "' AND '" & FIN & "') "
	query = query & "							 THEN CANTIDAD ELSE 0 END), "
	query = query & "	EXISTENCIAS.GetPPM(A.ID,'" & FIN & "'), M.UBICACION, M.SECCION "
	query = query & "  FROM     MOVIMIENTOS AS M, " 
	query = query & " 		    ARTICULOS AS A "
	query = query & "  WHERE  A.ID=M.COD_ARTICULO "
	query = query & "		  AND M.FECHA <= '" & FIN & "'"
	query = query & "  GROUP BY  A.ID,  A.DESCRIPCION, "
	query = query & "			M.UBICACION, M.SECCION "
	query = query & " ORDER BY A.DESCRIPCION "
	 
	Set ORs =oDB.EjecutaSql(query)
	
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
	 		 Response.Write "<ROW>" 
	  		  Response.Write "<ID>True</ID>"
	  		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	 
END FUNCTION

FUNCTION existeCierre()

MES = Cint(MES)
TOTAL = 0
SUM_TOTAL = 0

	query = query & "SELECT * FROM CIERRE WHERE MES=" & MES & " AND ANHO=" & ANHO
	 
	Set ORs =oDB.EjecutaSql(query)
	
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		If Not ORs.EOF Then 
	 		 Response.Write "<ROW>" 
	  		  Response.Write "<ID>TRUE</ID>"
	  		 Response.Write "</ROW>"
	 	Else
			 Response.Write "<ROW>" 
	  		  Response.Write "<ID>FALSE</ID>"
	  		 Response.Write "</ROW>"
		End If

		Response.Write "</REGISTROS>"
	
	Set ORs = Nothing
	Set ODB = Nothing
	 
END FUNCTION

FUNCTION loadCierre()

MES = Cint(MES)
TOTAL = 0
SUM_TOTAL = 0

	query =  "SELECT C.ID, C.DESCRIPCION, C.SALDO, C.ENTRADAS, C.SALIDAS, C.VALOR_UNI, C.UBICACION, C.SECCION "
	query = query & " FROM CIERRE AS C, ARTICULOS AS A WHERE C.MES=" & MES & " AND C.ANHO=" & ANHO
	query = query & " AND C.ID = A.ID "
	
	If Len(FAMILIA)>0 Then
		query = query & "		AND A.FAMILIA = " & strNvl(FAMILIA)
	End If
	
	query = query & " ORDER BY C.DESCRIPCION "
	
	Set ORs =oDB.EjecutaSql(query)
	
	If EXCEL="YES" Then
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & strName
	    Response.Write "<TABLE BORDER=1>"
			 Response.Write "<TR>"
				   Response.Write "<TD>CODIGO</TD>"
   				   Response.Write "<TD>DESCRIPCION</TD>"
   				   Response.Write "<TD>SALDO ANTERIOR</TD>"
   				   Response.Write "<TD>ENTRADAS</TD>"
   				   Response.Write "<TD>SALIDAS</TD>"
   				   Response.Write "<TD>SALDOS</TD>"
   				   Response.Write "<TD>VALOR UNITARIO</TD>"
   				   Response.Write "<TD>STOCK TOTAL VALORIZADO</TD>"
  				   Response.Write "<TD>UBICACI�N</TD>"
				   Response.Write "<TD>SECCION</TD>"
			 Response.Write "</TR>"
		While Not ORs.EOF 
				 Response.Write "<TR>"
				   Response.Write "<TD>" & ORs.Fields.Item(0).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(1).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(2).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(3).Value & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(4).Value & "</TD>"
				   SALDO = (CINT(ORs.Fields.Item(3).Value) - CINT(ORs.Fields.Item(4).Value)) + CINT(ORs.Fields.Item(2).Value)
   				   Response.Write "<TD>" & SALDO & "</TD>"
   				   Response.Write "<TD>" & ORs.Fields.Item(5).Value & "</TD>"
				   TOTAL = (SALDO)*ORs.Fields.Item(5).Value
   				   Response.Write "<TD>" & TOTAL & "</TD>"
				   SUM_TOTAL = SUM_TOTAL + TOTAL
   				   Response.Write "<TD>" & ORs.Fields.Item(6).Value & "</TD>"
				   Response.Write "<TD>" & ORs.Fields.Item(7).Value & "</TD>"
   				 Response.Write "</TR>"
	 		  ORs.MoveNext
		Wend
		 Response.Write "<TR>"
				 Response.Write "<TD COLSPAN='8'>TOTAL GENERAL " & SUM_TOTAL & "</TD>"
				 Response.Write "</TR>"
	    Response.Write "</TABLE>"
	ELSE
		Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
		Response.Write "<REGISTROS>"
		While Not ORs.EOF 
	 	 Response.Write "<ROW>" 
	  		  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
  			  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
			  Response.Write "<SALDO_ANT>" & ORs.Fields.Item(2).Value & "</SALDO_ANT>"
   			  Response.Write "<ENTRADAS>" & ORs.Fields.Item(3).Value & "</ENTRADAS>"  
   			  Response.Write "<SALIDAS>" & ORs.Fields.Item(4).Value & "</SALIDAS>"
			  SALDO = (CINT(ORs.Fields.Item(3).Value) - CINT(ORs.Fields.Item(4).Value)) + CINT(ORs.Fields.Item(2).Value)
			  Response.Write "<SALDO>" & SALDO  & "</SALDO>"
   			  Response.Write "<PPM>" & ORs.Fields.Item(5).Value & "</PPM>"
			  TOTAL = (SALDO)*ORs.Fields.Item(5).Value
			  Response.Write "<TOTAL>" & TOTAL & "</TOTAL>"
			  SUM_TOTAL = SUM_TOTAL + TOTAL
			  Response.Write "<UBICACION>" & ORs.Fields.Item(6).Value & "</UBICACION>"
			  Response.Write "<SECCION>" & ORs.Fields.Item(7).Value & "</SECCION>"
	  	Response.Write "</ROW>"
	 	 ORs.MoveNext
		Wend
		Response.Write "<ROW>" 
			  Response.Write "<SUM_TOTAL>TOTAL  " & SUM_TOTAL  & "</SUM_TOTAL>"
		Response.Write "</ROW>"
		Response.Write "</REGISTROS>"
	END IF
	Set ORs = Nothing
	Set ODB = Nothing
	 
END FUNCTION


function DeleteArticuloInicio()

	query = "DELETE FROM MOVIMIENTOS WHERE FOLIO = " & FOLIO & " AND TIPO='ING'"
	query = query & " AND COD_ARTICULO=" & strNvl(CODIGO)
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

function delArticulosCT()

	query = "DELETE FROM ARTICULOS_CT WHERE FOLIO = " & FOLIO

	Set ORs =oDB.EjecutaSql(query)
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<FOLIO>" & FOLIO  & "</FOLIO>"
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
	
end function

	
function DelArticulo()
	query = "UPDATE ARTICULOS SET ESTADO='NUL' WHERE ID=" & ID & ""
	ORs = oDB.EjecutaSql(query)
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

function numNvl(Valor)
	if isNull(Valor) then
		numNvl = 0
	else
	 	numNvl = Valor
	end if 
end function

%>

