<!--#include file="DBConn.asp" -->
<%
Dim query
Dim oDB
Set oDB = New DBConn

RECURSO=REQUEST("RECURSO")
ID=UCASE(REQUEST("ID"))
CRITICIDAD=UCASE(REQUEST("CRITICIDAD"))
FOLIO=UCASE(REQUEST("FOLIO"))
COD_FALLA=UCASE(REQUEST("COD_FALLA"))
FAENA=UCASE(REQUEST("FAENA"))
MESA=UCASE(REQUEST("MESA"))
EST=UCASE(REQUEST("EST"))
HIST= REQUEST("HIST") 
SECTOR=UCASE(REQUEST("SECTOR"))
MATERIAL=UCASE(REQUEST("MATERIAL"))
FALLA=UCASE(REQUEST("FALLA"))
USERNAME=UCASE(REQUEST("USERNAME"))
UBICACION=UCASE(REQUEST("UBICACION"))
EQUIPO=UCASE(REQUEST("EQUIPO"))
FAENA=UCASE(REQUEST("FAENA"))
VALOR=UCASE(REQUEST("VALOR"))
TIPO=UCASE(REQUEST("TIPO"))
TIPO2=UCASE(REQUEST("TIPO2"))
OBS=REQUEST("OBS")
CHK=REQUEST("CHK")

TIPO_EQUIPO=UCASE(REQUEST("TIPO_EQUIPO"))
DESCRIPCION=UCASE(REQUEST("DESCRIPCION"))

Select case RECURSO

	case "listCheck"
		  listCheck()
	
	case "getPolin"
		  getPolin()
		
	case "updatePolin"
		  updatePolin()
	
	 case "updateObs"
		  updateObs()

	case "listPolines"
		  listPolines()
		  
	case "delPolines"
		  delPolines()
		  
		  	  
	case "newChkAviso"
		  newChkAviso()
	
	case "newChkPolin"
		  newChkPolin()
		
	case "delChkAviso"
		  delChkAviso()
		 
	case "newFalla"
		newFalla()
		
	case "newCausa"
		newCausa()
		
	case "setPolR"
		setPolR()

	case "chkMatAcu"
		chkMatAcu()	
		
	case "DelCheck"
		DelCheck()
		
	case "DelCheckBitacora"
		DelCheckBitacora()
		
	case "ListCheckDesc"
		ListCheckDesc()

	case "UpdCheckBitacora"
		UpdCheckBitacora()
		
	case "Listafallas"
		Listafallas()

	case "listCausas"
		listCausas()
			
end select

function ListCheck()


	query = "SELECT CHK.ID, CHK.DESCRIPCION, CHK_E.BITACORA , CHK_E.VALOR "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " INNER JOIN CHECK_EQUIPOS AS CHK_E ON CHK_E.BITACORA=" & strNvl(FOLIO)  
	query = query & " 		AND CHK.ID = CHK_E.CHECKLIST "
	query = query & " WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	query = query & " ORDER BY ID"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<BITACORA>" & ORs.Fields.Item(2).Value & "</BITACORA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function newFalla()

	query = "SELECT MAX(ID) AS NUM FROM CHECKLIST "
	query = query & "WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	Set ORs =oDB.EjecutaSql(query)
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO CHECKLIST (" 
	query = query & " ID, "
	query = query & " TIPO_EQUIPO, "
	query = query & " DESCRIPCION) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & TIPO_EQUIPO & ","
	query = query & strNvl(DESCRIPCION) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function newCausa()

	query = "SELECT MAX(ID) AS NUM FROM CAUSAS "
	query = query & " WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	query = query & " AND ID_FALLA =" & COD_FALLA
	Set ORs =oDB.EjecutaSql(query)
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO CAUSAS (" 
	query = query & " ID, "
	query = query & " TIPO_EQUIPO, "
	query = query & " ID_FALLA, "
	query = query & " DESCRIPCION) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & TIPO_EQUIPO & ","
	query = query & COD_FALLA & ","
	query = query & strNvl(DESCRIPCION) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	 
	Response.Write "<ROW><ID>" & N & "</ID></ROW>"
 

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function NewCheckBitacora()

	query = "INSERT INTO CHECK_EQUIPOS (" 
	query = query & " BITACORA, "
	query = query & " CHECKLIST, VALOR) "
	query = query & " VALUES ("
	query = query & strNvl(FOLIO) & ","
	query = query & strNvl(ID) & ","
	query = query & strNvl(VALOR) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function DelCheck()
	query = "DELETE CHECKLIST WHERE ID = " & ID & " AND TIPO_EQUIPO= " & TIPO_EQUIPO
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"


	Set ORs = Nothing
	Set ODB = Nothing
end function

function DelCheckBitacora()

	query = "DELETE CHECK_EQUIPOS WHERE BITACORA = " & ID & " "
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function
'---adding----------

function ListCheckDesc()
	query = "SELECT ID, CHK.DESCRIPCION "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " LEFT OUTER JOIN CHECK_EQUIPOS AS CHK_E ON CHK_E.BITACORA=" & strNvl(FOLIO)
	query = query & " AND CHK.ID = CHK_E.CHECKLIST "
	query = query & " LEFT OUTER JOIN TIPO_EQUIPOS AS CHK_T "
	query = query & " ON CHK.TIPO_EQUIPO = CHK_T.CODIGO "
	query = query & " WHERE CHK_T.DESCRIPCION='" & TIPO_EQUIPO &"'"
	query = query & " ORDER BY ID" 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function setPolR()

query = "UPDATE EQUIPOS SET "

If CHK = "true" then
	query = query & " POLINR = 1 " 
Else
	query = query & " POLINR = 0 " 
End If
 
query = query & " WHERE CODIGO=" & strNvl(EQUIPO)
query = query & " AND UBICACION=" & strNvl(UBICACION)

Set ORs =oDB.EjecutaSql(query)
		
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW>OK</ROW>"
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

function UpdCheckBitacora()

	query = "SELECT BITACORA AS NUM FROM CHECK_EQUIPOS "
	query = query & "WHERE BITACORA='" & FOLIO & "'"
	Set ORs =oDB.EjecutaSql(query)
	If not ORs.eof Then
		N = 1
	Else
		N = 0
	End If

	if N = 0 then
		query = "INSERT INTO CHECK_EQUIPOS (" 
		query = query & " BITACORA, "
		query = query & " CHECKLIST, VALOR) "
		query = query & " VALUES ("
		query = query & strNvl(FOLIO) & ","
		query = query & strNvl(ID) & ","
		query = query & strNvl(VALOR) & ")"	
		Set ORs =oDB.EjecutaSql(query)
	else
		query = "UPDATE CHECK_EQUIPOS SET CHECKLIST =" & strNvl(ID)
		query = query & " , VALOR="  & strNvl(VALOR)
		query = query & " WHERE BITACORA = " & strNvl(FOLIO)
		Set ORs =oDB.EjecutaSql(query)
	end if
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function Listafallas()
	query = "SELECT CHK.ID, CHK.DESCRIPCION "
	query = query & " FROM CHECKLIST AS CHK "
	query = query & " WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	query = query & " ORDER BY ID"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listCausas()

	query = "SELECT CHK.ID, CHK.DESCRIPCION "
	query = query & " FROM CAUSAS AS CHK "
	query = query & " WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	query = query & " AND TIPO_FALLA = " & COD_FALLA
	query = query & " ORDER BY ID"
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function listCheck()


	query = " SELECT TIPO_EQUIPO FROM BITACORAS AS B, EQUIPOS AS E "
	query = query & " WHERE B.EQUIPO = E.CODIGO "
	query = query & " AND B.ID = " & strNvl(FOLIO)
	query = query & " AND E.UBICACION = " & strNvl(FAENA)
	
	Set ORs1 =oDB.EjecutaSql(query)
	
	TIPO_EQUIPO = ORs1.Fields.Item(0).Value
	
	query = "SELECT DISTINCT CHK.CODIGO, CHK.DESCRIPCION, CHK_E.ID_AVISO , CHK_E.VALOR "
	query = query & " FROM TIPO_FALLAS AS CHK "
	query = query & " LEFT OUTER JOIN CHECK_EQUIPOS AS CHK_E ON CHK_E.ID_AVISO=" & strNvl(FOLIO)
	query = query & " 		AND CHK.CODIGO = CHK_E.COD_FALLA "
	query = query & " WHERE CHK.TIPO_EQUIPO=" & TIPO_EQUIPO
	query = query & " ORDER BY DESCRIPCION "
	 
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	    Response.Write "<ROW>"
	  	  Response.Write "<ID>" & ORs.Fields.Item(0).Value & "</ID>"
		  Response.Write "<DESCRIPCION>" & ORs.Fields.Item(1).Value & "</DESCRIPCION>"
		  Response.Write "<BITACORA>" & ORs.Fields.Item(2).Value & "</BITACORA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(3).Value & "</VALOR>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function NewCheck()

	query = "SELECT MAX(ID) AS NUM FROM CHECKLIST "
	query = query & "WHERE TIPO_EQUIPO=" & TIPO_EQUIPO
	Set ORs =oDB.EjecutaSql(query)
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If

	query = "INSERT INTO CHECKLIST (" 
	query = query & " ID, "
	query = query & " TIPO_EQUIPO, "

	query = query & " DESCRIPCION) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & TIPO_EQUIPO & ","
	query = query & strNvl(DESCRIPCION) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function newChkPolin()



	query = "SELECT MAX(ID) AS NUM FROM CHECK_POLINES  "
	query = query & "WHERE FAENA=" & strNvl(FAENA)
	Set ORs =oDB.EjecutaSql(query)
	
	If Len(oRS("NUM"))>0 Then
		N = oRS("NUM") + 1
	Else
		N = 1
	End If
	
	query = "INSERT INTO CHECK_POLINES (" 
	query = query & " ID, EQUIPO, MESA, EST, SECTOR, TIPO, FALLA,"
	query = query & " VALOR, MATERIAL,  FAENA, CRITICIDAD, USERNAME, USERDATE) "
	query = query & " VALUES ("
	query = query & N & ","
	query = query & " RTRIM(dbo.EquipoPrincipalFaena(" & strNvl(EQUIPO) & "," & strNvl(FAENA) & ")) ,"
	query = query & strNvl(MESA) & ","
	query = query & strNvl(EST) & ","
	query = query & strNvl(SECTOR) & ","
	query = query & strNvl(TIPO) & ","
	query = query & strNvl(FALLA) & ","
	query = query & strNvl(VALOR) & ","
	query = query & strNvl(MATERIAL) & ","
	query = query & strNvl(FAENA) & ","
	query = query & strNvl(CRITICIDAD) & ","
	query = query & strNvl(USERNAME) & ","
	query = query & " getdate())"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function updatePolin()

	query = "UPDATE CHECK_POLINES SET " 
	query = query & " MESA = " & strNvl(MESA) & ","
	query = query & " EST = " & strNvl(EST) & ","
	query = query & " SECTOR = " & strNvl(SECTOR) & ","
	query = query & " TIPO = " & strNvl(TIPO) & ","
	query = query & " FALLA = " & strNvl(FALLA) & ","
	query = query & " VALOR= " &  strNvl(VALOR) & ","
	query = query & " CRITICIDAD = " & strNvl(CRITICIDAD) & ","
	query = query & " USERNAME = " & strNvl(USERNAME) & ","
	query = query & " USERDATE = getdate()"
	query = query & " WHERE ID=" & strNvl(ID)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function updateObs()

	query = "UPDATE CHECK_POLINES SET " 
	query = query & " OBS = " & strNvl(OBS) & " "

	query = query & " WHERE ID=" & strNvl(ID)
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function


function getPolin()

	query = query & "  ORDER BY MESA, CHK.EST  "
	query = "SELECT DISTINCT CHK.MESA, CHK.EST, CHK.SECTOR , CHK.TIPO, CHK.FALLA, CHK.VALOR , "
	query = query & "CHK.CRITICIDAD, convert(varchar,CHK.USERDATE,103), convert(varchar,CHK.FECHA_COR,103), ID"
	query = query & " FROM CHECK_POLINES AS CHK "
	query = query & " WHERE ID = " & strNvl(ID)
 
 	If HIST<>"true" Then
		query = query & " and corregido is null "
	End If
	 
	Set ORs =oDB.EjecutaSql(query) 
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<MESA>" & ORs.Fields.Item(0).Value & "</MESA>"
		  Response.Write "<EST>" & ORs.Fields.Item(1).Value & "</EST>"
		  Response.Write "<SECTOR>" & ORs.Fields.Item(2).Value & "</SECTOR>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(3).Value & "</TIPO>"
 		  Response.Write "<ESTADO>" & ORs.Fields.Item(6).Value & "</ESTADO>"
 
		SELECT CASE ORs.Fields.Item(6).Value
		  	CASE "1" 
			 Response.Write "<IMG_EST>mg/importancia_alta.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Alta</IMG_TEXT>"
			CASE "2" 
			 Response.Write "<IMG_EST>mg/importancia_media.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Media</IMG_TEXT>"
			CASE "3" 
			 Response.Write "<IMG_EST>mg/importancia_baja.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Criticiada Baja</IMG_TEXT>"
			CASE "4" 
			 Response.Write "<IMG_EST>mg/importancia_nula.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Buen Estado</IMG_TEXT>"
			 
		 END SELECT 
		  
		  
		  Response.Write "<FALLA>" & ORs.Fields.Item(4).Value  & "</FALLA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(5).Value & "</VALOR>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>"
		  Response.Write "<FECHA_COR>" & ORs.Fields.Item(8).Value & "</FECHA_COR>"
		  Response.Write "<ID>" & ORs.Fields.Item(9).Value & "</ID>"
	    
		Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function

function listPolines()

	query = "SELECT convert(float, CHK.MESA), convert(float, CHK.EST), CHK.SECTOR , CHK.TIPO, CHK.FALLA, CHK.VALOR , "
	query = query & "CHK.CRITICIDAD, convert(varchar,CHK.USERDATE,103), convert(varchar,CHK.FECHA_COR,103), "
	query = query & " ID, MATERIAL, OBS, MATERIAL_ACU "
	query = query & " FROM CHECK_POLINES AS CHK "
	query = query & " WHERE RTRIM(EQUIPO) = "
	query = query & "  dbo.EquipoPrincipalFaena(" & strNvl(EQUIPO) & "," & strNvl(FAENA) & ") "

	If TIPO="CEN" Then
		query = query & "  AND SECTOR IN (" & strNvl(TIPO) & ",'EST','MES','REC') "
	Else
		query = query & "  AND SECTOR IN (" & strNvl(TIPO) & ",'EST','MES','REV','REC','PVELA') "
	End If 

	query = query & "  AND TIPO  = " & strNvl(TIPO2)  
	
 	If HIST<>"true" Then
		query = query & " and corregido is null "
	End If
	query = query & " ORDER BY convert(float, CHK.MESA), convert(float, CHK.EST)"
	
		 
	Set ORs =oDB.EjecutaSql(query) 
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" '& query
	While Not ORs.EOF 
	   Response.Write "<ROW>"
	  	  Response.Write "<MESA>" & ORs.Fields.Item(0).Value & "</MESA>"
		  Response.Write "<EST>" & ORs.Fields.Item(1).Value & "</EST>"
		  Response.Write "<SECTOR>" & ORs.Fields.Item(2).Value & "</SECTOR>"
		  Response.Write "<TIPO>" & ORs.Fields.Item(3).Value & "</TIPO>"
 
				
		  SELECT CASE ORs.Fields.Item(4).Value
			
		   	CASE 1 FALLA = "Ruido"
          	CASE 2 FALLA = "Trabado"
            CASE 3 FALLA = "Faltante"
			CASE 4 FALLA = "Sin Contacto"
            CASE 5 FALLA = "Desgastado"
            CASE 6 FALLA = "Suelta"
			CASE 7 FALLA = "Sucio"
			CASE 8 FALLA = "Rodamiento"
			CASE 9 FALLA = "Deformada"
			CASE 10 FALLA = "Cuyunturas"
			CASE 11 FALLA = "Daño Estructural"
			CASE 12 FALLA = "Desalineada"
			CASE 13 FALLA = "Temperatura"
			  	
		  END SELECT
		  
		SELECT CASE ORs.Fields.Item(6).Value
		  	CASE "3" 
			 Response.Write "<IMG_EST>mg/alta.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Alta</IMG_TEXT>"
			CASE "2" 
			 Response.Write "<IMG_EST>mg/media.gif</IMG_EST>"
			 Response.Write "<IMG_TEXT>Criticidad Media</IMG_TEXT>"
			CASE "1" 
			 Response.Write "<IMG_EST>mg/baja_pol.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Criticiada Baja</IMG_TEXT>"
			CASE "" 
			 Response.Write "<IMG_EST>mg/importancia_nula.gif</IMG_EST>"
			  Response.Write "<IMG_TEXT>Buen Estado</IMG_TEXT>"
			 
		 END SELECT 
		  
		  
		  Response.Write "<FALLA>" & FALLA & "</FALLA>"
		  Response.Write "<VALOR>" & ORs.Fields.Item(5).Value & "</VALOR>"
		  Response.Write "<USERDATE>" & ORs.Fields.Item(7).Value & "</USERDATE>"
		  Response.Write "<FECHA_COR>" & ORs.Fields.Item(8).Value & "</FECHA_COR>"
			Response.Write "<ID>" & ORs.Fields.Item(9).Value & "</ID>"
			Response.Write "<MAT>" & ORs.Fields.Item(10).Value & "</MAT>"
			Response.Write "<OBS>" & ORs.Fields.Item(11).Value & "</OBS>"
			Response.Write "<MAT_ACU>" & ORs.Fields.Item(12).Value & "</MAT_ACU>"
	    Response.Write "</ROW>"
	  ORs.MoveNext
	Wend
	Response.Write "</REGISTROS>"
	Set ORs = Nothing
	Set ODB = Nothing
end function


function newChkAviso()

	query = "INSERT INTO CHECK_EQUIPOS (" 
	query = query & " ID_AVISO, "
	query = query & " COD_FALLA, VALOR) "
	query = query & " VALUES ("
	query = query & strNvl(FOLIO) & ","
	query = query & strNvl(ID) & ","
	query = query & strNvl(VALOR) & ")"
	
	Set ORs =oDB.EjecutaSql(query)
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>ok</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set oDB = Nothing
	
End function

function DelCheck()
	query = "DELETE CHECKLIST WHERE ID = " & ID & " AND TIPO_EQUIPO= " & TIPO_EQUIPO
	Set ORs = oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "OK"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function delPolines()

	query = "UPDATE CHECK_POLINES SET CORREGIDO='TRUE', FECHA_COR=GETDATE() "
	query = query  & " WHERE ID=" & ID
	query = query & " AND FAENA =" & strNvl(FAENA) & " "
	'query = query & " AND EST=" & strNvl(EST)
	'IF LEN(MESA)>0 THEN
'		query = query & " AND MESA=" & strNvl(MESA)'
'	END IF
'	query = query & " AND TIPO=" & strNvl(TIPO) 
	
	Set ORs = oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function delChkAviso()

	query = "DELETE CHECK_EQUIPOS WHERE ID_AVISO = " & ID & " "
	Set ORs = oDB.EjecutaSql(query)
	
	Response.ContentType = "text/xml"
	Response.Write "<?xml version='1.0' encoding='ISO-8859-15'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>"
	Response.Write "<ROW>OK</ROW>"
	Response.Write "</REGISTROS>"

	Set ORs = Nothing
	Set ODB = Nothing
end function

function chkMatAcu()

query = "UPDATE CHECK_POLINES SET "

If CHK = "true" then
	query = query & " MATERIAL_ACU = 1 " 
Else
	query = query & " MATERIAL_ACU = 0 " 
End If
 
	query = query  & " WHERE ID=" & ID
	query = query & " AND FAENA =" & strNvl(FAENA) & " "

Set ORs =oDB.EjecutaSql(query)
		
	Set ORs =oDB.EjecutaSql(query)
	Response.Write "<?xml version='1.0' encoding='utf-8'?>" & VbCrLf & VbCrLf
	Response.Write "<REGISTROS>" & query
	Response.Write "<ROW>OK</ROW>"
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