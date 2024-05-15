<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sgm_n_form_bitacoras.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_n_form_bitacoras"  StylesheetTheme="ttm" Theme="ttm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" type="text/css" />






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script> 
    <style type="text/css">
    body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
    </style>
<style type="text/css">

.rsbHeader ul,
.rsbListItem ul {
     margin: 0;
     padding: 0;
     width: 100%;
     display: inline-block;
     list-style-type: none;
}
 
.rsbHeader ul {
     padding-left:5px;
}
 
.RadTreeView {
    text-align: left !important;
}
 
.col1,
.col3 {
     margin: 0;
     padding: 0 5px 0 0;
     width: 160px;
     line-height: 14px;
     float: left;
}
.col2 
{
     margin: 0;
     padding: 0 5px 0 0;
     width: 250px;
     line-height: 14px;
     float: left;
}
.rcbTemplate {
    padding: 5px 5px 5px 5px !important;
}

.Overlay { 
  position:fixed; 
  top:0px; 
  bottom:0px; 
  left:0px; 
  right:0px; 
  overflow:hidden; 
  padding:0; 
  margin:0; 
  background-color:#000;  
  filter:alpha(opacity=90); 
  opacity:0.5; 
  z-index:1000;
}
 
.PopUpPanel {  
  position:absolute;
  background-color: #ffffff;   
  top:30%;
  left:30%;
  z-index:2001; 
  padding:10px;
  min-width:400px;
  max-width:600px;
    
  -moz-box-shadow:3.5px 4px 5px #000000;
  -webkit-box-shadow:3.5px 4px 5px #000000;
  box-shadow:3.5px 4px 5px #000000;

  border-radius:5px;
  -moz-border-radiux:5px;
  -webkit-border-radiux:5px;

 border: 1px solid #CCCCCC;
}

#DropZone {
    width: 550px;
    height: 100px;
    background-color: #357A2B;
    border-color: #CCCCCC;
    color: #767676;
    float: left;
    text-align: center;
    font-size: 16px;
    color: white;
}


</style>
<script language="JavaScript" src="../../ttm_js/swissarmy.js" type="text/javascript"></script>
    <title>Formulario Bitacora</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>

   <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <asp:HiddenField ID="hddsessionemp" runat="server" />
    <div>
      <table width="70%" align="center" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="30%" rowspan="2" valign="top">
                                                                              
              <table id="TblFiltoCompleto" runat="Server" bgcolor="#666" border="0" 
                  cellpadding="0" cellspacing="0" width="100%">
                  <tr>
                      <td style="width:100%">
                          <table border="0" cellpadding="0" cellspacing="0" class="filtroTitulo2" 
                              width="100%">
                              <tr>
                                  <th align="left" valign="middle">
                                      FILTRO DE EQUIPOS</th>
                                  <th align="right" style="height: 21px; width:200px" valign="top">
                                  </th>
                              </tr>
                          </table>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <table id="tblFiltro" runat="server" border="0" cellpadding="0" cellspacing="0" 
                              class="filtroContenido2" width="100%">
                              <tr>
                                  <td style="height:20px">
                                      <telerik:RadComboBox ID="cblequiposfiltros" runat="server" AutoPostBack="True" 
                                          CssClass="field3" EnableLoadOnDemand="true" EnableVirtualScrolling="true" 
                                          Filter="Contains" Height="300" LoadingMessage="Cargando..." 
                                          MarkFirstMatch="True" onclientdropdownopened="_DropDownOpening1" 
                                          ondatabound="cblequiposfiltros_DataBound" 
                                          onitemdatabound="cblequiposfiltros_ItemDataBound" 
                                          onitemsrequested="cblequiposfiltros_ItemsRequested" 
                                          onselectedindexchanged="cblequiposfiltros_SelectedIndexChanged" 
                                          ontextchanged="cblequiposfiltros_TextChanged" ShowMoreResultsBox="true" 
                                          Width="220">
                                          <HeaderTemplate>
                                              <h2>
                                                  Equipos</h2>
                                          </HeaderTemplate>
                                          <ItemTemplate>
                                              <div class="imageWrap">
                                                                                                  <img src="<%# BuscarFotoEquipo(Eval("IMAGEURL").ToString()) %>" alt=" <%# DataBinder.Eval(Container, "value")%> " />
                                                                                             </div>
                                              <div>
                                                  <ul class="personDetails">
                                                      <li class="name"><span> <%# DataBinder.Eval(Container, "value")%> </span></li>
                                                      <li class="title"><span> <%# DataBinder.Eval(Container, "text")%> </span></li>
                                                  </ul>
                                              </div>
                                          </ItemTemplate>
                                          <FooterTemplate>
                                              Total Equipos:
                                              <asp:Literal ID="RadComboItemsCount" runat="server" />
                                          </FooterTemplate>
                                      </telerik:RadComboBox>
                                  </td>
                              </tr>
                              <tr>
                                  <td style="height:20px"></td>
                              </tr>
                              <tr>
                                  <td>
                                                                            	<!--va el tree panel-->
                                                                                <telerik:RadTreeView ID="TreeEq2" 
                                          runat="server" BackColor="#666666" Font-Bold="True" Font-Names="Arial" 
                                          Font-Size="10px" ForeColor="White" Height="710px" 
                                          onnodeclick="TreeEq2_NodeClick" onnodedatabound="TreeEq2_NodeDataBound" >
                                                                                    <DataBindings>
                                                                                        <telerik:RadTreeNodeBinding Expanded="True" />
                                                                                    </DataBindings>
                                      </telerik:RadTreeView>
                                  </td>
                              </tr>
                          </table>
                      </td>
                  </tr>
              </table>
            </td>
          <td valign="top">
          <asp:Panel ID="PnlNuevoBitacora" runat="server" Visible="true" Enabled="False">
          <TABLE width="100%" BORDER="0" cellpadding="1" cellspacing="0" CLASS="texto">
                <!--DWLayoutTable-->
           
                <TR>
                  <TD width="195"  ALIGN="left" VALIGN="top"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                    <tr>
                      <td align="center" valign="middle"><strong>BITACORA&nbsp;Nº
                      <input id="txtID" class="inputBold" name="txtID" readonly size="5" 
                          type="TEXT" runat="server"  /></strong>
                          <asp:HiddenField ID="hddstatus" runat="server" />
                        </td>
                      <td align="center" valign="middle">
                          <asp:Panel ID="pnlultmod" runat="server">
                          
                      <span style="width: 383px"><strong>ULT. MOD. 
                          OBSERVACION</strong>&nbsp;:
                          <telerik:RadDatePicker ID="txtULT_INSP" Runat="server" Visible="False"></telerik:RadDatePicker>
                          <telerik:RadDatePicker ID="txtFechaObs" Runat="server" Culture="es-CL" 
                              Width="100px"><calendar ID="Calendar2" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar><dateinput dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
                                  labelwidth="40%"><EmptyMessageStyle Resize="None" /><ReadOnlyStyle Resize="None" /><FocusedStyle Resize="None" /><DisabledStyle Resize="None" /><InvalidStyle Resize="None" /><HoveredStyle Resize="None" /><EnabledStyle Resize="None" /></dateinput><DatePopupButton HoverImageUrl="" ImageUrl="" /></telerik:RadDatePicker>
                          &nbsp;</span>
                          </asp:Panel>
                      </td>
                      <td align="center" valign="middle"><span style="width: 196px"><strong>RESPONSABLE</strong> 
                          :
                          <asp:Label ID="idResponsable" class="Campo" runat="server" Text="Label"></asp:Label>
                      </span></td>
                    </tr>
                  </table></TD>
                </TR>
                <TR>
                  <TD  HEIGHT="29"><table width="100%" border="0" cellpadding="1" cellspacing="2">
                    <tr>
                      <td align="center" valign="middle"><strong>COMPONENTE</strong></td>
                      <td align="center" valign="middle">
                          <input   runat="server" class="input" id="idCodEquipo" size="16"  name="txtCodEquipo" type="text"  readonly="readonly" />
                        <input class="input"  runat="server" id="idEquipo" type="text" size="40"
            			             name="txtEquipo" readonly="readonly"   />
                          <asp:HiddenField ID="txtTipoEquipo" runat="server" />
                          <asp:HiddenField ID="txtEquipoPrincipal" runat="server" />
                          <asp:HiddenField ID="txtCodTipoEquipo" runat="server" />
                          &nbsp;&nbsp;&nbsp</td>
                      <td align="center" valign="middle"><strong>FECHA</strong>&nbsp;
                          
                          <telerik:RadDatePicker ID="TxtFecha" Runat="server" Culture="es-CL" 
                              Width="100px"><calendar ID="Calendar3" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar><DateInput DateFormat="dd-MM-yyyy" DisplayDateFormat="dd-MM-yyyy" 
                                                                                LabelWidth="40%"><EmptyMessageStyle Resize="None" /><ReadOnlyStyle Resize="None" /><FocusedStyle Resize="None" /><DisabledStyle Resize="None" /><InvalidStyle Resize="None" /><HoveredStyle Resize="None" /><EnabledStyle Resize="None" /></DateInput><DatePopupButton HoverImageUrl="" ImageUrl="" /></telerik:RadDatePicker>
                          
                      </td>
                      <td align="center" valign="middle"><strong>HORA</strong> :&nbsp;
                          <telerik:RadTimePicker ID="TxtHora" Runat="server" Culture="es-CL" Width="80px"><calendar ID="Calendar4" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar><datepopupbutton cssclass="" hoverimageurl="" imageurl="" visible="False" /><timeview cellspacing="-1" columns="6" culture="es-CL" interval="00:15:00"></timeview><timepopupbutton cssclass="" hoverimageurl="" imageurl="" /><dateinput dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
                                  labelwidth="64px" width=""><emptymessagestyle resize="None" /><readonlystyle resize="None" /><focusedstyle resize="None" /><disabledstyle resize="None" /><invalidstyle resize="None" /><hoveredstyle resize="None" /><enabledstyle resize="None" /></dateinput></telerik:RadTimePicker>
                        </td>
                    </tr>
                  </table></TD>
                </TR>
                <TR>
                  <TD  HEIGHT="29"><table width="100%" border="0" cellpadding="1" cellspacing="2">
                    <tr>
                        <asp:Panel ID="pnlfechprog" runat="server">
                        
                      <td align="center" valign="middle"><strong>FECHA PROG.:</strong><br>
                          &nbsp;<telerik:RadDatePicker ID="txtFechProg" Runat="server" Culture="es-CL" 
                              Width="100px">
                              <calendar usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar><dateinput dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
                                  labelwidth="40%"><EmptyMessageStyle Resize="None" /><ReadOnlyStyle Resize="None" /><FocusedStyle Resize="None" /><DisabledStyle Resize="None" /><InvalidStyle Resize="None" /><HoveredStyle Resize="None" /><EnabledStyle Resize="None" /></dateinput><DatePopupButton HoverImageUrl="" ImageUrl="" /></telerik:RadDatePicker>
                          &nbsp;<input name="txtUltInspeccion" id="txtUltInspeccion" type="hidden" 
                              class="input" size="12" readonly />
                        </td>
                        </asp:Panel>
                      <td align="center" valign="middle"><strong>CRITICIDAD</strong><br />
                      <input  type="text"  class="bordes" size="6"   runat="server" align="MIDDLE" name="txtColor" id="txtColor"  value=""  readonly="readonly"/>
                      <input  type="text"  class="bordes" size="3"  align="MIDDLE" name="txtCriticidad"  id="txtCriticidad" runat="server"  readonly="readonly"/>
%</td>
                        <asp:Panel ID="pnlfallas" runat="server">
                        
                      <td align="center" valign="middle"><strong>MODO DE FALLA</strong><br />
                        &nbsp;
                          <telerik:RadComboBox ID="cmbFallas" runat="server" Width="140px"  
                              CausesValidation="False" DataTextField="description" DataValueField="value" 
                              Culture="es-CL" DropDownAutoWidth="Enabled" Filter="Contains"  ></telerik:RadComboBox>
                      <input type="hidden" name="listFallas_hidden" id="listFallas_hidden" /></td>
                      </asp:Panel>
                      <td align="center" valign="middle"><strong>CRITICIDAD</strong><br />
                        &nbsp;
                      <input type="hidden" name="ListCheck_hidden" id="ListCheck_hidden" />
                          <telerik:RadComboBox ID="cmbCriticidad" runat="server" CausesValidation="False" 
                              Culture="es-CL" Filter="Contains" Width="100px" AutoPostBack="True" 
                              onselectedindexchanged="cmbCriticidad_SelectedIndexChanged"><Items><telerik:RadComboBoxItem runat="server" Text="[-Seleccione-]" Value="0" /><telerik:RadComboBoxItem runat="server" BackColor="RoyalBlue" Text="BAJA" 
                                      Value="1" /><telerik:RadComboBoxItem runat="server" BackColor="#FFFF80" ForeColor="Black" 
                                      Text="MEDIA" Value="2" /><telerik:RadComboBoxItem runat="server" BackColor="#FF8080" Text="ALTA" 
                                      Value="3" /></Items></telerik:RadComboBox>
                        </td>
                      <td align="center" valign="middle"><span class="style3"><strong>DAÑO</strong> </span>
                        <input name="chkIncidente" id="chkIncidente"  type="checkbox" class="input"  runat="server" checked="checked" />
                      &nbsp;&nbsp;&nbsp;</td>
                      <td align="center" valign="middle"><strong>SOLUCIONADO</strong>
                      <input name="chkSolucion"  type="checkbox" class="input"  id="chkSolucion" runat="server" /></td>
                      <asp:Panel ID="pnlstatus" runat="server">
                        <td align="center" valign="middle"><strong>STATUS</strong>
                        <input name="chkSTATUS"  type="checkbox" class="input"  id="chkSTATUS" runat="server" /></td>
                      </asp:Panel>
                    </tr>
                  </table></TD>
                </TR>
                <asp:Panel ID="pnlot" runat="server">
                <TR>
                  <TD  HEIGHT="29"><table width="100%" border="0" cellpadding="1" cellspacing="2">
                    <tr>
                      <td align="center" valign="middle" class="texto" ><strong>AVISO</strong></td>
                      <td align="center" valign="middle" class="texto" >
                          <input  type="text" class="input" size="14" 
   			            name="txtReport" id="txtReport"  runat="server" readonly="readonly" /></td>
                      <td align="center" valign="middle" class="texto"><strong>OT</strong></td>
                      <td align="center" valign="middle" class="texto" >
                          <input  type="text" class="input" size="14" runat="server"
   			            name="txtOT" id="txtOT" readonly="readonly" /></td>
                      <td align="center" valign="middle"><strong>STATUS SAP</strong></td>
                      <td align="center" valign="middle">
                          <telerik:RadComboBox ID="listStatus3" runat="server" 
                              CausesValidation="False" Culture="es-CL" Filter="Contains" 
                              onselectedindexchanged="cmbCriticidad_SelectedIndexChanged" Width="100px"><Items><telerik:RadComboBoxItem runat="server" Owner="listStatus3" 
                                      Text="[-Seleccione-]" Value="0" /><telerik:RadComboBoxItem runat="server" BackColor="RoyalBlue" 
                                      Owner="listStatus3" Text="ABIERTA" Value="1" /><telerik:RadComboBoxItem runat="server" BackColor="#FFFF80" ForeColor="Black" 
                                      Owner="listStatus3" Text="CERRADA" Value="2" /><telerik:RadComboBoxItem runat="server" BackColor="#FF8080" Owner="listStatus3" 
                                      Text="NOTIFICADA" Value="3" /></Items></telerik:RadComboBox>
                        </td>
                      <td align="center" valign="middle"><strong>CONDICION</strong></td>
                      <td align="center" valign="middle">
                          <telerik:RadComboBox ID="listCondicion" runat="server" 
                              CausesValidation="False" Culture="es-CL" Filter="Contains" Width="240px"><Items><telerik:RadComboBoxItem runat="server" BackColor="#0033FF" 
                                      Text="(B) MONITOREAR " Value="B" Owner="listCondicion" /><telerik:RadComboBoxItem runat="server" BackColor="#FFFF00" 
                                      Text="(C) PROGRAMADA 2 SEMANAS" Value="C" Owner="listCondicion" /><telerik:RadComboBoxItem runat="server" BackColor="#FF9900" 
                                      Text="(D) PROGRAMADA 1 SEMANA" Value="D" Owner="listCondicion" /><telerik:RadComboBoxItem runat="server" BackColor="#FF0000" 
                                      Text="(E) ACCION INMEDIATA" Value="E" Owner="listCondicion" /><telerik:RadComboBoxItem runat="server" BackColor="#990000" 
                                      Text="(P) PROGRAMADA PARADA PLANTA" Value="P" Owner="listCondicion" /></Items></telerik:RadComboBox>
                        </td>
                    </tr>
                      
                      
                  </table></TD>
                </TR>
                </asp:Panel>
                <TR>
                  <TD><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="70%"><table width="100%" border="0" cellpadding="1" cellspacing="2">
                        <tr>
                          <td><strong>OBSERVACIONES</strong><br />
                            <textarea name="TxtObservacion" id="TxtObservacion" rows="3" cols="60" 
                                  class="textArea" runat="server"  onkeypress="validaKeys(this,1500, event);" 
                                  readonly="readonly"></textarea>
                          <textarea name="TxtObservacion_hidden" id="TxtObservacion_hidden" rows="1" cols="1" class="textArea" style="visibility:hidden"></textarea></td>
                        </tr>
                          <asp:Panel ID="pnlcausa" runat="server">
                        <tr>
                          <td><strong>CAUSA RAIZ</strong><br />
                            <textarea name="TxtCausa" id="TxtCausa"  rows="3" cols="60" class="textArea"  
                                  runat="server" onkeypress="validaKeys(this,749, event);" readonly="readonly"></textarea>
                          <textarea name="TxtCausa_hidden" id="TxtCausa_hidden"  rows="1" cols="1" class="textArea" style="visibility:hidden"></textarea></td>
                        </tr>
                        <tr>
                          <td><strong>RECOMENDACIONES</strong><br />
<textarea name="TxtRecomendacion" id="TxtRecomendacion"  rows="3" cols="60" class="textArea"  runat="server" 
                                  onkeypress="validaKeys(this,749, event);" readonly="readonly"></textarea>
                          <textarea name="TxtRecomendacion_hidden" id="TxtRecomendacion_hidden"  rows="1" cols="1" class="textArea" style="visibility:hidden"></textarea></td>
                        </tr>
                        </asp:Panel>
                      </table></td>
                      <td valign="top">
                      <style type="text/css"></style>
                      <asp:Panel ID="Pnlimgform" runat="server" Visible="False">
                        <strong>ARCHIVOS ADJUNTOS</strong><br>&nbsp;
                        <TABLE width="100%"  border="0" align="center" CELLPADDING="0" cellspacing="0" DATAPAGESIZE="1" ID="tabImages">
		     	                <TR>
					                <TD align="center" VALIGN="top">
                                    
                                    <script type="text/javascript">
                                        <asp:Literal id="litScript" runat="server" />
                                    </script>
                                    
                                       <%--<script type="text/javascript">
								            if(getParametro("ID") != ""){
										            if (id_br == "IE")
										            {
											            var xmlImages = document.getElementById("xmlImages");
											            xmlImages.async = false;
										            }else if (id_br == "FF" || id_br == "OP" || id_br == "SF"  || id_br == "CR"){
											            var xmlImages = document.implementation.createDocument("", "", null);
										            }
									            <!---->
									            //If using image buttons as controls, Set image buttons' image preload here true
									            //(use false for no preloading and for when using no image buttons as controls):
									            var preload_ctrl_images=true;
									
									            //And configure the image buttons' images here:
									            var previmg='left.gif';
									            var stopimg='stop.gif';
									            var playimg='play.gif';
									            var nextimg='right.gif';
									
									            var xmlDso = xmlImages.XMLDocument;
									            var url = "xml/archivos.asp?RECURSO=listArchivos";
										            url += "&FAMILIA=BITACORAS"; 
										            url += "&IDENTIFICADOR="+getParametro("ID");
										            if (id_br == "FF" || id_br == "OP" || id_br == "SF"  || id_br == "CR")
										            {
													            if (window.XMLHttpRequest)
													              {// code for IE7+, Firefox, Chrome, Opera, Safari
													              xmlhttp=new XMLHttpRequest();
													              }
													            else
													              {// code for IE6, IE5
													              xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
													              }
													            xmlhttp.open("GET",url,false);
													            xmlhttp.send();
													            xmlDoc=xmlhttp.responseText;
													            parser = new DOMParser();
													            xmlDso = parser.parseFromString(xmlDoc, "text/xml"); 
													            xmlestado = parser.parseFromString(xmlDoc, "text/xml"); 
													            //alert(xmlDso);
													            //window.open(url);
										            }
										            else if (id_br == "IE")
										            {
											            xmlestado = xmlDso.load(url);
										            }
									
									            //window.open(url);
									            if(!xmlestado){
											            window.open(url);}
									            else{		
									               total_registros_lista = xmlDso.documentElement.childNodes.length;
									   
								            //		document.getElementById("ID_list_cant_reg").innerText = total_registros_lista;
								            //		bloque_listado = 1;
								            //		total_bloque_listado = Math.ceil(total_registros_lista/1);
								            //		var objLabelReg = document.getElementById("ID_list_fraccion_reg");
								            //		objLabelReg.innerHTML = "1/" + total_bloque_listado;
								            //		i = 0;
								            //		document.getElementById("n_file").value = i;
								            //		document.getElementById("t_file").value = total_registros_lista-1;
										
										            if (total_registros_lista > 0){
													            var slides2=[]; 
													            var x = xmlDso.getElementsByTagName("ROW"); // mostramos los registros
													            for (i=0; i<x.length; i++) {
														            //alert(checkImage(x[i].getElementsByTagName("FILEIMAGE")[0].childNodes[0].nodeValue));
            //														if (checkImage(x[i].getElementsByTagName("FILEIMAGE")[0].childNodes[0].nodeValue.toString())){
            //															alert('done');
															            slides2[i] = [x[i].getElementsByTagName("FILEIMAGE")[0].childNodes[0].nodeValue.toString(), x[i].getElementsByTagName("FECHA")[0].childNodes[0].nodeValue.toString(), x[i].getElementsByTagName("FILEID")[0].childNodes[0].nodeValue.toString(), "_new", "top=200, left=300, width=700, height=500",  x[i].getElementsByTagName("ID")[0].childNodes[0].nodeValue.toString()];
            //														}else{
            //															slides2[i] = ["images/noDisponible.png", ""];	
            //															alert('failed');
            //														}
													            }
											            //var slides2=[]; //SECOND SLIDESHOW
											            ////configure the below images and descriptions to your own. 
											            //slides2[0] = ["photo6.jpg", "Crucifix"];
											            //slides2[1] = ["photo7.jpg", "Alter Boys"];
											            //slides2[2] = ["photo8.jpg", "Young Pan"];
											            //slides2[3] = ["photo9_thumb.jpg", "Mona Lisa"];
											            //optional properties for these images:
											            slides2.desc_prefix='<b>Fecha:<\/b> '; //string prefix for image descriptions display
											            slides2.controls_top=0; //use for top controls
											            slides2.counter=1; //use to show image count
											            slides2.width=170; //use to set width of widest image if dimensions vary
											            slides2.height=170; //use to set height of tallest image if dimensions vary
											            slides2.no_auto=1; //use to make show completely user operated (no play button, starts in stopped mode)
											            slides2.use_alt=1; //use for descriptions as images alt attributes
											            slides2.use_title=0; //use for descriptions as images title attributes
											            slides2.nofade=0; //use for no fade-in, fade-out effect for this show
											            slides2.border=2; //set border width for images
											            slides2.border_color='lightblue'; //set border color for images
											            slides2.no_added_linebreaks=1;
											            //slides2.onclick="window.open(this.href,this.target,'top=0, left=0, width='+screen.availWidth+', height='+screen.availHeight);return false;";
											             new inter_slide(slides2);
											             document.getElementById("idpic").value = 1;
										            }
									            }
								            }
                                        </script>--%>
					               </TD>
			               </TR>
					
				               <TR>
                                   <TD height="40" align="center" VALIGN="middle">
                                        <telerik:RadButton ID="btnnew" AutoPostBack="true" Text="Nuevo" runat="server" OnClick="btnnew_Click1"></telerik:RadButton>                                     
                                       &nbsp;                                      
                                       <telerik:RadButton ID="btnDelete" AutoPostBack="false" Text="Eliminar" runat="server" OnClientClicked="ShowDialog" OnClick="btndel_Click"></telerik:RadButton>
                                       <asp:HiddenField ID="HddFiles" runat="server" />                              
                                   </TD>
			                   </TR>
	                  </TABLE></asp:Panel> 
                       <script type="text/javascript">

                            function OnClientFileUploading(sender, args) {
                                var fileName = args.get_fileName();

                                for (var i = 0; i < sender.getUploadedFiles().length; i++) {
                                    if (sender.getUploadedFiles()[i] === fileName) {
                                        console.log('duplicated' + fileName);
                                        args.set_cancel(true);
                                        sender.deleteFileInputAt(1);
                                        $(".ErrorHolder").append("Archivo duplicado, se renovo automaticamente.<br/>").fadeIn("slow");
                                    }

                                }
                            }
                            function OnClientFileAdd(sender, args) {
                                $(".ErrorHolder").html('').fadeOut("slow");
                            }

                            function ShowDialog(button, args) {
                                if (window.confirm("Estas seguro de desvincular el archivo?")) {
                                    button.set_autoPostBack(true);
                                }
                                else {
                                    button.set_autoPostBack(false);
                                }
                            }
                        </script> 
                        <asp:panel id="panelOverlay" runat="server" class="Overlay" visible="false"></asp:panel>
                        <asp:Panel ID="pnlEditCustomer" runat="server" class="PopUpPanel" visible="false">
                                    <div style="margin:10px">
                                        <table style="width:400px;">
                                          <tr>
                                              <td width="20%" valign="top">Archivos</td>
                                              <td>
                                                  <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" 
                                                      MultipleFileSelection="Automatic" DropZones="#DropZone" 
                                                      Localization-Cancel="Cancelar" Localization-DropZone="Adjuntar aca" 
                                                      Localization-Remove="Quitar" Localization-Select="Adjuntar" 
                                                      MaxFileInputsCount="20" UploadedFilesRendering="BelowFileInput" 
                                                      RenderMode="Classic" AutoAddFileInputs="True" DisableChunkUpload="False" 
                                                      HideFileInput="False" onfileuploaded="RadAsyncUpload1_FileUploaded" OnClientFileUploading="OnClientFileUploading" 
                                                      onclientadded="OnClientFileAdd" 
                                                      onclientfileuploadremoving="OnClientFileAdd" TargetFolder="~/sgm/files" 
                                                      TemporaryFolder="~/files/Temporal" 
                                                      AllowedFileExtensions="xls,xlsx,pdf,doc,docx,ppt,pptx,txt,jpg,jpeg,png,gif,xlt,zip,mp4,bmp" 
                                                      MaxFileSize="5242880">
                                                      <Localization Cancel="Cancelar" DropZone="Adjuntar aca" Remove="Quitar" 
                                                          Select="Adjuntar" />
                                                      <filefilters>
                                                          <telerik:FileFilter Description="files" 
                                                              Extensions="xls,xlsx,pdf,doc,docx,ppt,pptx,txt,jpg,jpeg,png,gif,xlt,zip,mp4,bmp" />
                                                      </filefilters>
                                                  </telerik:RadAsyncUpload>
                                                  <div class="ErrorHolder" style="background-color:red; color:White;"></div>

                                              </td>                     
                                          </tr>
                                           <tr>
                                              <td width="20%" valign="top">Tipo</td>
                                              <td align="left">
                                                  <telerik:RadComboBox ID="cmbListCateg" runat="server" 
                                                      AppendDataBoundItems="True">
                                                  </telerik:RadComboBox>
                                              </td>                     
                                          </tr>
                                          <tr><td colspan="2">
                                                <div id="DropZone">
                                                    <p>Zona Adjuntos Archivos</p>
                                                    <p>Dejar archivos aca</p>
                                                </div>
                                          </td></tr>
                                          <tr>
                                          <td colspan="2">
                                          <center>
                                              <asp:Button ID="btnViewAlbum" runat="server" Text="Grabar" 
                                                  onclick="btnViewAlbum_Click" />    &nbsp;&nbsp;
                                              <asp:Button ID="btnCancelAlbum" runat="server" Text="Cancelar" 
                                                  onclick="btnCancelAlbum_Click" />    </center>
                                          </td>
                                          </tr>
                                                    
                                        </table> 
                                
           
                                        <%--<hr />
                                        <asp:Button ID="editBox_OK" runat="server" Text="OK" width="50px"/>
                                        <asp:Button ID="editBox_Cancel" runat="server" Text="Cancel" width="50px" />--%>
                                    </div>
                            </asp:Panel>
                                      
                      </td>
                    </tr>
                  </table></TD>
                </TR>
                <TR>
                    <TD align="left">
                        <asp:Panel ID="PnlHist" runat="server" Visible="False">
                            <strong>HISTORIAL DE CAMBIOS DE CRITICIDAD</strong><br />
                            <telerik:radgrid id="RadGrid1Aux" runat="server" AllowPaging="True" 
                                                                                
                            AutoGenerateColumns="False" CellPadding="0" CellSpacing="0" 
                                                                                ShowStatusBar="True"                                     
                            Culture="es-CL" GroupingEnabled="False" Width="820px" PageSize="8" 
                                GridLines="Horizontal" onpageindexchanged="RadGrid1Aux_PageIndexChanged" 
                                onpagesizechanged="RadGrid1Aux_PageSizeChanged" 
                                onsortcommand="RadGrid1Aux_SortCommand">
                                <exportsettings>
                                    <pdf pagewidth="">
                                    </pdf>
                                </exportsettings>
                                <clientsettings>
                                    <Scrolling AllowScroll="True" ScrollHeight="200px" 
                                        UseStaticHeaders="True" />
                                </clientsettings>
                                <AlternatingItemStyle Font-Size="12px" /><MasterTableView CellPadding="0" 
                                    CellSpacing="0" GridLines="Both" 
                                                                                    DataKeyNames="ID" 
                                    commanditemdisplay="Top" nodetailrecordstext="No hay registro a mostrar" 
                                    nomasterrecordstext="No hay registro a mostrar">
                                    <commanditemtemplate>
                                        <table cellpadding="0" 
                                            style="height: 20px; background-color: #336699; font-family: Arial, Helvetica, sans-serif; font-size: x-small; font-weight: bold; color: #FFFFFF;" 
                                            width="100%">
                                            <tr>
                                                <td align="left" width="18">
                                                    &nbsp;</td>
                                                <td align="left" width="50">
                                                    Fecha</td>
                                                <td align="left" width="130">
                                                    <telerik:RadDatePicker ID="RadDatePckr" runat="server" Culture="es-ES" 
                                                        EnableTyping="False" Width="110px">
                                                        <calendar ID="Calendar1" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar>
                                                        <dateinput dateformat="dd/MM/yyyy" displaydateformat="dd/MM/yyyy" 
                                                            labelwidth="40%" readonly="True">
                                                            <emptymessagestyle resize="None" />
                                                            <readonlystyle resize="None" />
                                                            <focusedstyle resize="None" />
                                                            <disabledstyle resize="None" />
                                                            <invalidstyle resize="None" />
                                                            <hoveredstyle resize="None" />
                                                            <enabledstyle resize="None" />
                                                        </dateinput>
                                                        <datepopupbutton hoverimageurl="" imageurl="" />
                                                    </telerik:RadDatePicker>
                                                </td>
                                                <td align="left" width="57">
                                                    Estado</td>
                                                <td align="left" width="228">
                                                    <telerik:RadComboBox ID="cmbEst" runat="server" CausesValidation="False" 
                                                        Culture="es-CL" Filter="Contains" Width="200px">
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text="DISMINUYE CRITICIDAD" Value="1" />
                                                            <telerik:RadComboBoxItem runat="server" Selected="" 
                                                                Text="SE MANTIENE CONDICION" Value="2" />
                                                            <telerik:RadComboBoxItem runat="server" Text="AUMENTA CRITICIDAD" Value="3" />
                                                            <telerik:RadComboBoxItem runat="server" Text="NO SE REALIZA INSPECCION" 
                                                                Value="4" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td align="left" width="723">
                                                    <asp:Button ID="BtnSaveHist" runat="server" CssClass="tinyInput" 
                                                        onclick="BtnSaveHist_Click" Text="Guardar" />
                                                </td>
                                            </tr>
                                        </table>
                                    </commanditemtemplate>
                                    <CommandItemSettings AddNewRecordText="" 
                                        CancelChangesText="" RefreshText="" SaveChangesText="" 
                                        ShowAddNewRecordButton="False" ShowRefreshButton="False" />
                                    <rowindicatorcolumn visible="False"></rowindicatorcolumn><expandcollapsecolumn created="True"></expandcollapsecolumn><Columns><telerik:GridBoundColumn DataField="ID" HeaderText="ID" 
                                                                                            UniqueName="ID" Resizable="False" Visible="false"><HeaderStyle HorizontalAlign="Center" Width="80px" /><ItemStyle HorizontalAlign="Center"/></telerik:GridBoundColumn><telerik:GridBoundColumn DataField="ROW" HeaderText="N°" 
                                                                                            UniqueName="ROW" Resizable="False"  ><HeaderStyle HorizontalAlign="Center" Width="80px" /><ItemStyle HorizontalAlign="Center"/></telerik:GridBoundColumn><telerik:GridBoundColumn DataField="INSPECTOR" HeaderText="Inspector" 
                                                                                            UniqueName="INSPECTOR"   ><HeaderStyle HorizontalAlign="Center" Width="110px" /><ItemStyle HorizontalAlign="Center" /></telerik:GridBoundColumn><telerik:GridBoundColumn UniqueName="FECHA" DataField="FECHA" HeaderText="Fecha" 
                                                                                              DataFormatString="{0:dd/MM/yyyy}" ><HeaderStyle HorizontalAlign="Center" Width="40px" /><ItemStyle HorizontalAlign="Center" /><HeaderStyle Width="125px" /></telerik:GridBoundColumn><telerik:GridBoundColumn DataField="DETSTATUS" HeaderText="Condicion" 
                                                                                            UniqueName="DETSTATUS" ><HeaderStyle HorizontalAlign="Center" Width="200px" /><ItemStyle HorizontalAlign="Center" /></telerik:GridBoundColumn></Columns><ItemStyle Font-Size="11px" /><AlternatingItemStyle Font-Size="11px" /><PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" AlwaysVisible="True" /><HeaderStyle Font-Size="10px" /></MasterTableView><HeaderStyle Font-Size="13px" /><ItemStyle Font-Size="12px" /><PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" AlwaysVisible="True" />
                                <StatusBarSettings LoadingText="Cargando..." 
                                    ReadyText="Listo" />
                            </telerik:radgrid>
                        </asp:Panel>
                    </TD>
                </TR>
              
                <TR>
                  <TD>
                    
                  </TD>
                </TR>
              </TABLE>
         </asp:Panel>
          </td>
        </tr>
        <tr>
          <td align="left" valign="bottom"><div class="ContTitLiBxFoot">
                        <asp:ImageButton ID="IbtnGrabar" runat="server" CausesValidation="False" 
                            skinid="IBtnGrabar" onclick="IbtnGrabar_Click" Visible="False" />
                        <asp:ImageButton ID="IbtnSalir" runat="server" CausesValidation="False" 
                            SkinID="IBtnSalir" OnClientClick="window.parent.jQuery.colorbox.close(); return false;" />
                    </div></td>
        </tr>
      </table>
              
                <%# DataBinder.Eval(Container, "text")%>

    </div>

<script type="text/javascript">
//    jQuery.curCSS = jQuery.css;
    function _DropDownOpening1(sender, eventArgs) {
        sender.clearSelection();
        sender.set_emptyMessage("");
    }
</script>
<asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>                                    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" 
        UpdatePanelsRenderMode="Inline">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cblequiposfiltros">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TreeEq2" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="TreeEq2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cblequiposfiltros" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="IbtnGrabar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbCriticidad">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnnew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="panelOverlay" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="pnlEditCustomer" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnViewAlbum">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCancelAlbum">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
