<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sgm_form_bitacoras.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_form_bitacoras"  StylesheetTheme="ttm" Theme="ttm" %>

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
      <table WIDTH="750px" align="center" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top">
          <asp:Panel ID="PnlNuevoBitacora" runat="server" Visible="true">
          <TABLE WIDTH="100%" BORDER="0" cellpadding="1" cellspacing="0" CLASS="texto">
                <!--DWLayoutTable-->
           
                <TR>
                  <TD width="195"  ALIGN="left" VALIGN="top"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                    <tr>
                      <td align="center" valign="middle"><strong>BITACORA&nbsp;Nº
                      <input id="txtID" class="inputBold" name="txtID" readonly size="5" 
                          type="TEXT" runat="server"  /></strong>
                          <asp:HiddenField ID="hddstatus" runat="server" Value="1" />
                        </td>
                      <td align="center" valign="middle">
                      <asp:Panel ID="pnlultmod" runat="server">
                      <span style="width: 383px"><strong>ULT. MOD. 
                          OBSERVACION</strong>&nbsp;:
                          <telerik:RadDatePicker ID="txtULT_INSP" Runat="server" Visible="False"></telerik:RadDatePicker>
                          <telerik:RadDatePicker ID="txtFechaObs" Runat="server" Culture="es-CL" 
                              Width="100px"><calendar ID="Calendar1" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays><telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"><ItemStyle BackColor="#6699FF" ForeColor="White" /></telerik:RadCalendarDay></SpecialDays></calendar><dateinput dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
                                  labelwidth="40%"><EmptyMessageStyle Resize="None" /><ReadOnlyStyle Resize="None" /><FocusedStyle Resize="None" /><DisabledStyle Resize="None" /><InvalidStyle Resize="None" /><HoveredStyle Resize="None" /><EnabledStyle Resize="None" /></dateinput><DatePopupButton HoverImageUrl="" 
                                  ImageUrl="" /></telerik:RadDatePicker>
                          &nbsp;</span></asp:Panel></td>
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
                          
                          <input   runat="server" class="input" id="idCodEquipo" size="16"  
                              name="txtCodEquipo" type="text"  readonly="readonly" />
                          <input class="input"  runat="server" id="idEquipo" type="text" size="40"
            			             name="txtEquipo" readonly="readonly"   />
                          &nbsp;
                          <asp:HiddenField ID="txtTipoEquipo" runat="server" />
                          <asp:HiddenField ID="txtEquipoPrincipal" runat="server" />
                          <asp:HiddenField ID="txtCodTipoEquipo" runat="server" />
                        </td>
                      <td align="center" valign="middle"><strong>FECHA</strong>&nbsp;
                          
                          <telerik:RadDatePicker ID="TxtFecha" Runat="server" Culture="es-CL" 
                              Width="100px"><calendar ID="Calendar2" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays><telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"><ItemStyle BackColor="#6699FF" ForeColor="White" /></telerik:RadCalendarDay></SpecialDays></calendar><DateInput DateFormat="dd-MM-yyyy" DisplayDateFormat="dd-MM-yyyy" 
                                                                                LabelWidth="40%"><EmptyMessageStyle Resize="None" /><ReadOnlyStyle Resize="None" /><FocusedStyle Resize="None" /><DisabledStyle Resize="None" /><InvalidStyle Resize="None" /><HoveredStyle Resize="None" /><EnabledStyle Resize="None" /></DateInput><DatePopupButton HoverImageUrl="" ImageUrl="" /></telerik:RadDatePicker>
                          
                      </td>
                      <td align="center" valign="middle"><strong>HORA</strong> :&nbsp;
                          <telerik:RadTimePicker ID="TxtHora" Runat="server" Culture="es-CL" Width="80px"><calendar ID="Calendar3" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays><telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"><ItemStyle BackColor="#6699FF" ForeColor="White" /></telerik:RadCalendarDay></SpecialDays></calendar><datepopupbutton cssclass="" hoverimageurl="" imageurl="" visible="False" /><timeview cellspacing="-1" columns="6" culture="es-CL" interval="00:15:00"></timeview><timepopupbutton cssclass="" hoverimageurl="" imageurl="" /><dateinput dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
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
                              Width="100px"><calendar ID="Calendar4" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays><telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"><ItemStyle BackColor="#6699FF" ForeColor="White" /></telerik:RadCalendarDay></SpecialDays></calendar><dateinput dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
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
                          <asp:HiddenField ID="cmbFallas_hidden" runat="server" /></td>
                        </asp:Panel>
                      <td align="center" valign="middle"><strong>CRITICIDAD</strong><br />
                        &nbsp;
                          <telerik:RadComboBox ID="cmbCriticidad" runat="server" CausesValidation="False" 
                              Culture="es-CL" Filter="Contains" Width="100px" AutoPostBack="True" 
                              onselectedindexchanged="cmbCriticidad_SelectedIndexChanged"><Items><telerik:RadComboBoxItem runat="server" Text="[-Seleccione-]" Value="0" /><telerik:RadComboBoxItem runat="server" BackColor="RoyalBlue" Text="BAJA" 
                                      Value="1" /><telerik:RadComboBoxItem runat="server" BackColor="#FFFF80" ForeColor="Black" 
                                      Text="MEDIA" Value="2" /><telerik:RadComboBoxItem runat="server" BackColor="#FF8080" Text="ALTA" 
                                      Value="3" /></Items></telerik:RadComboBox>
                          <asp:HiddenField ID="cmbCriticidad_hidden" runat="server" />
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
                              CausesValidation="False" Culture="es-CL" Filter="Contains" Width="100px"><Items><telerik:RadComboBoxItem runat="server" Owner="listStatus3" 
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
                            <textarea name="TxtObservacion" id="TxtObservacion" rows="5" cols="60" 
                                  class="textArea" runat="server"  
                                  onkeypress="validaKeys(this,1500, event);"></textarea>
                          <textarea name="TxtObservacion_hidden" id="TxtObservacion_hidden" rows="1" cols="1" class="textArea" style="visibility:hidden" runat="server" ></textarea></td>
                        </tr>
                        <asp:Panel ID="pnlcausa" runat="server">
                        <tr>
                          <td><strong>CAUSA RAIZ</strong><br />
                            <textarea name="TxtCausa" id="TxtCausa"  rows="4" cols="60" class="textArea"  
                                  runat="server" onkeypress="validaKeys(this,749, event);"></textarea>
                          <textarea name="TxtCausa_hidden" id="TxtCausa_hidden"  rows="1" cols="1" class="textArea" style="visibility:hidden" runat="server" ></textarea></td>
                        </tr>
                        <tr>
                          <td><strong>RECOMENDACIONES</strong><br />
<textarea name="TxtRecomendacion" id="TxtRecomendacion"  rows="4" cols="60" class="textArea"  runat="server" 
                                  onkeypress="validaKeys(this,749, event);"></textarea>
                          <textarea name="TxtRecomendacion_hidden" id="TxtRecomendacion_hidden"  rows="1" cols="1" class="textArea" style="visibility:hidden" runat="server" ></textarea></td>
                        </tr>
                        </asp:Panel>
                      </table></td>
                      <td valign="top">
                      <style type="text/css"></style>
                      <asp:Panel ID="Pnlimgform" runat="server">
                        <strong>ARCHIVOS ADJUNTOS</strong><br>&nbsp;
                        <TABLE width="100%"  border="0" align="center" CELLPADDING="0" cellspacing="0" DATAPAGESIZE="1" ID="tabImages">
		     	                <TR>
					                <TD align="center" VALIGN="top">
                                       <script type="text/javascript">
                                        <asp:Literal id="litScript" runat="server" />
                                        </script>
								         <%--   if(getParametro("ID") != ""){
									            var preload_ctrl_images=true;
    								            var previmg='left.gif';
									            var stopimg='stop.gif';
									            var playimg='play.gif';
									            var nextimg='right.gif';
									
									            var url = "xml/archivos.asp?RECURSO=listArchivos";
										            url += "&FAMILIA=BITACORAS"; 
										            url += "&IDENTIFICADOR="+getParametro("ID");
										            
									               total_registros_lista = xmlDso.documentElement.childNodes.length;
									   

										
										            if (total_registros_lista > 0){
													            var slides2=[]; 
													            var x = xmlDso.getElementsByTagName("ROW"); // mostramos los registros
													            for (i=0; i<x.length; i++) {
															            slides2[i] = [x[i].getElementsByTagName("FILEIMAGE")[0].childNodes[0].nodeValue.toString(), x[i].getElementsByTagName("FECHA")[0].childNodes[0].nodeValue.toString(), x[i].getElementsByTagName("FILEID")[0].childNodes[0].nodeValue.toString(), "_new", "top=200, left=300, width=700, height=500",  x[i].getElementsByTagName("ID")[0].childNodes[0].nodeValue.toString()];
													            }
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
								            }--%>
                                        
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

                       <%--<script type="text/javascript"> 
                           $("[id*=btnnew]").live("click", function () {
                               $("#pnlEditCustomer").dialog({
                                   title: "Adjuntos Imagenes y Archivos",
                                   buttons: {
                                       Close: function () {
                                           $(this).dialog('cerrar');
                                       }
                                   },
                                   autoOpen: false,
                                   width: 600,
                                   maxWidth: 700,
                                   height: 350,
                                   maxHeight: 500,
                                   show: {
                                       effect: "fade",
                                       duration: 300
                                   },
                                   modal: true
                               });
//                               $p = window.parent.$;
//                                setTimeout(
//                                function () {
//                                    alert($(window.parent.document).find(".cboxLoadedContent").html());
//                                    
//                                },
//                                5000);                            
                               return false;
                           });
                        </script>--%>
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
                                              <td width="20%" valign="top">
                                                  <asp:HiddenField ID="Hddtipo" runat="server" />
                                                  Archivos</td>
                                              <td>
                                                  <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" 
                                                      MultipleFileSelection="Automatic" DropZones="#DropZone" 
                                                      Localization-Cancel="Cancelar" Localization-DropZone="Adjuntar aca" 
                                                      Localization-Remove="Quitar" Localization-Select="Adjuntar" 
                                                      MaxFileInputsCount="20" UploadedFilesRendering="BelowFileInput" 
                                                      RenderMode="Classic" DisableChunkUpload="False" 
                                                      HideFileInput="False" onfileuploaded="RadAsyncUpload1_FileUploaded" 
                                                      TargetFolder="~/sgm/files" OnClientFileUploading="OnClientFileUploading" 
                                                      onclientadded="OnClientFileAdd" 
                                                      onclientfileuploadremoving="OnClientFileAdd" Culture="es" 
                                                      onclientfileuploadfailed="OnClientFileUploadFailed" 
                                                      TemporaryFolder="~/files/Temporal" 
                                                      AllowedFileExtensions="xls,xlsx,pdf,doc,docx,ppt,pptx,txt,jpg,jpeg,png,gif,xlt,zip,mp4,bmp" 
                                                      MaxFileSize="5242880" Width="230px">
                                                      <Localization Cancel="Cancelar" DropZone="Adjuntar aca" Remove="Quitar" 
                                                          Select="Adjuntar" />
                                                      <filefilters>
                                                          <telerik:FileFilter Description="files" 
                                                              Extensions="xls,xlsx,pdf,doc,docx,ppt,pptx,txt,jpg,jpeg,png,gif,xlt,zip,mp4,bmp" />
                                                      </filefilters>
                                                  </telerik:RadAsyncUpload>
                                                  <div class="ErrorHolder" style="background-color:red; color:White;"></div>

                                              </td>   
                                              <td width="20%" valign="top"><asp:Label ID="lbltip" runat="server" Text="Tipo" Visible="False"></asp:Label></td>
                                              <td width="20%" valign="top">
                                                  <telerik:RadComboBox ID="cmbListCateg" runat="server" Visible="False" 
                                                      onselectedindexchanged="cmbListCateg_SelectedIndexChanged" 
                                                      AutoPostBack="True">
                                                  </telerik:RadComboBox>
                                              </td>                  
                                          </tr>
                                          <tr><td colspan="4">
                                                <div id="DropZone">
                                                    <p>Zona Adjuntos Archivos</p>
                                                    <p>Dejar archivos aca</p>
                                                </div>
                                          </td></tr>
                                          <tr>
                                          <td colspan="4">
                                          <center>
                                              <asp:Button ID="btnViewAlbum" runat="server" Text="Grabar" 
                                                  onclick="btnViewAlbum_Click" />    &nbsp;&nbsp;
                                              <asp:Button ID="btnCancelAlbum" runat="server" Text="Cancelar" 
                                                  onclick="btnCancelAlbum_Click" />
                                              </center>
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
                                AutoGenerateColumns="False" CellPadding="0" CellSpacing="0" ShowStatusBar="True"
                                Culture="es-CL" GroupingEnabled="False" Width="820px" PageSize="8" 
                                GridLines="Horizontal" onpageindexchanged="RadGrid1Aux_PageIndexChanged" 
                                onpagesizechanged="RadGrid1Aux_PageSizeChanged" 
                                onsortcommand="RadGrid1Aux_SortCommand"><exportsettings><pdf pagewidth=""></pdf></exportsettings><clientsettings><Scrolling AllowScroll="True" 
                                        UseStaticHeaders="True" ScrollHeight="200px"/></clientsettings><AlternatingItemStyle Font-Size="12px" /><MasterTableView CellPadding="0" 
                                    CellSpacing="0" GridLines="Both" DataKeyNames="ID" 
                                nodetailrecordstext="No hay registro a mostrar" 
                                nomasterrecordstext="No hay registro a mostrar" CommandItemDisplay="Top"><CommandItemTemplate><table width="100%" 
                                            style="height: 20px; background-color: #336699; font-family: Arial, Helvetica, sans-serif; font-size: x-small; font-weight: bold; color: #FFFFFF;" 
                                             cellpadding="0"><TR><TD width=18 align=left>&nbsp;</TD><TD width=50 align=left>Fecha</TD><TD width=130 align=left><telerik:RadDatePicker
        ID="RadDatePckr" runat="server" Width="110px" Culture="es-ES" 
        EnableTyping="False"><calendar ID="Calendar5" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays><telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"><ItemStyle BackColor="#6699FF" ForeColor="White" /></telerik:RadCalendarDay></SpecialDays></calendar><dateinput dateformat="dd/MM/yyyy" displaydateformat="dd/MM/yyyy" 
        labelwidth="40%" readonly="True"><emptymessagestyle resize="None" /><readonlystyle resize="None" /><focusedstyle resize="None" /><disabledstyle resize="None" /><invalidstyle resize="None" /><hoveredstyle resize="None" /><enabledstyle resize="None" /></dateinput><datepopupbutton hoverimageurl="" imageurl="" /></telerik:RadDatePicker></TD><TD width=57 align=left>Estado</TD><TD width=228 align=left><telerik:RadComboBox ID="cmbEst" runat="server" CausesValidation="False" 
                              Culture="es-CL" Filter="Contains" Width="200px" ><Items><telerik:RadComboBoxItem runat="server" Text="DISMINUYE CRITICIDAD" Value="1" /><telerik:RadComboBoxItem runat="server" Text="SE MANTIENE CONDICION" Value="2" Selected /><telerik:RadComboBoxItem runat="server" Text="AUMENTA CRITICIDAD" Value="3" /><telerik:RadComboBoxItem runat="server" Text="NO SE REALIZA INSPECCION" Value="4" /></Items></telerik:RadComboBox></TD><TD width=723 align=left><asp:Button ID="BtnSaveHist" runat="server" Text="Guardar" 
        CssClass="tinyInput" onclick="BtnSaveHist_Click" /></TD></TR></table></CommandItemTemplate><CommandItemSettings AddNewRecordText="" CancelChangesText="" RefreshText="" SaveChangesText="" ShowRefreshButton="False" ShowAddNewRecordButton="False" /><rowindicatorcolumn visible="False"></rowindicatorcolumn><expandcollapsecolumn created="True"></expandcollapsecolumn><Columns><telerik:GridBoundColumn DataField="ID" HeaderText="ID" UniqueName="ID" Resizable="False" Visible="false"><HeaderStyle HorizontalAlign="Center" Width="80px" /><ItemStyle HorizontalAlign="Center"/></telerik:GridBoundColumn><telerik:GridBoundColumn DataField="ROW" HeaderText="N°" UniqueName="ROW" Resizable="False"  ><HeaderStyle HorizontalAlign="Center" Width="80px" /><ItemStyle HorizontalAlign="Center"/></telerik:GridBoundColumn><telerik:GridBoundColumn DataField="INSPECTOR" HeaderText="Inspector" UniqueName="INSPECTOR"   ><HeaderStyle HorizontalAlign="Center" Width="110px" /><ItemStyle HorizontalAlign="Center" /></telerik:GridBoundColumn><telerik:GridBoundColumn UniqueName="FECHA" DataField="FECHA" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" ><HeaderStyle HorizontalAlign="Center" Width="40px" /><ItemStyle HorizontalAlign="Center" /><HeaderStyle Width="125px" /></telerik:GridBoundColumn><telerik:GridBoundColumn DataField="DETSTATUS" HeaderText="Condicion" UniqueName="DETSTATUS" ><HeaderStyle HorizontalAlign="Center" Width="200px" /><ItemStyle HorizontalAlign="Center" /></telerik:GridBoundColumn></Columns><ItemStyle Font-Size="11px" /><AlternatingItemStyle Font-Size="11px" /><PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" AlwaysVisible="True" /><HeaderStyle Font-Size="10px" /></MasterTableView><HeaderStyle Font-Size="13px" /><ItemStyle Font-Size="12px" /><PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" AlwaysVisible="True" /><StatusBarSettings LoadingText="Cargando..." ReadyText="Listo" /></telerik:radgrid>
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
    function OnClientFileUploadFailed(sender, args) {
        args.get_message();
    }
</script>
<asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>                                    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" UpdatePanelsRenderMode="Inline">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbCriticidad">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnnew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="panelOverlay" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="pnlEditCustomer" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
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
                    <telerik:AjaxUpdatedControl ControlID="panelOverlay" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="pnlEditCustomer" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1Aux">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1Aux" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoBitacora" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbListCateg">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Hddtipo" 
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
