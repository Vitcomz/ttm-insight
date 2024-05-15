<%@ Page Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="List_InfPolines.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_InfPolines" StyleSheetTheme="ttm" Theme="ttm"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">






<script type="text/javascript" src="FusionCharts.js"></script>
<script type="text/javascript" src="../../ttm_js/libs/base64.js"></script>
<script type="text/javascript" src="../../ttm_js/libs/sprintf.js"></script>
<%--<script type="text/javascript" src="../../ttm_js/jspdf.js"></script>--%>

<script type="text/javascript" src="../../ttm_js/jspdf.debug.js"></script>
<script type="text/javascript" src="../../ttm_js/tableExport.js"></script>
<script type="text/javascript" src="../../ttm_js/jquery.base64.js"></script>
<script type="text/javascript">
    function FromHTMLtoPDF() {
        var eq = document.getElementById("ctl00_ContentPlaceHolder1_Hddequipo").value;
        var sec = document.getElementById("ctl00_ContentPlaceHolder1_Hddseccion").value;
//        var tip = document.getElementById("ctl00_ContentPlaceHolder1_Hddtipo").value;
        var crit = document.getElementById("ctl00_ContentPlaceHolder1_Hddcrit").value;
        var time = 5;
        var f1 = document.getElementById("ctl00_ContentPlaceHolder1_rddate1_dateInput").value;
        var f2 = document.getElementById("ctl00_ContentPlaceHolder1_rddate2_dateInput").value;
        var alltime = time * 1700;
        var oManager = window.radopen("ReporteInspPolGenPdf.aspx?sec=" + sec + "&eq=" + eq + "&crit=" + crit + "&fech1=" + f1 + "&fech2=" + f2, null);
        oManager.setSize(5, 5); //Width, Height
        oManager.center();
        oManager.SetActive();
        setTimeout(function () { oManager.close(); }, alltime);
    }

    function FromHTMLtoEXCEL() {
//        var $tableBody2 = $('#ctl00_ContentPlaceHolder1_tabMedidas2');
//        $tableBody2.html('<tbody></tbody>');
//        var $tablebodyin = $('#ctl00_ContentPlaceHolder1_tabMedidas2').find("tbody");
//        var $tableBody = $('#ctl00_ContentPlaceHolder1_CritDivCode').find("tbody");
//        $tablebodyin.append("<tr><td>ID</td><td>FECHA</td><td>EQUIPO</td><td>COMPONENTE</td><td>OBSERVACION</td><td>CAUSA RAIZ</td><td>ORIGENES FALLAS</td><td>GRADO CRITICIDAD</td><td>TRATAMIENTO TECNICO TTM</td></tr>");
//        $tableBody.find("[name='rowsdata']").each(function (i, tr) {
//            $trNew = "<tr><td>" + $(this).find("[id='1x']").html() + "</td><td>" + $(this).find("[id='2x']").html() + "</td><td>" + $(this).find("[id='3x']").html() + "</td><td>" + $(this).find("[id='4x']").html() + "</td><td>" + $(this).find("[id='5x']").html() + "</td><td>" + $(this).find("[id='6x']").html() + "</td><td>" + $(this).find("[id='7x']").val() + "</td><td>" + $(this).find("[id='8x']").html() + "</td><td>" + $(this).find("[id='9x']").html() + "</td></tr>";
//            $tablebodyin.append($trNew);
//        });
//        $('#ctl00_ContentPlaceHolder1_tabMedidas2').tableExport({ type: 'excel', escape: 'false' });
//        $tableBody2.html('<tbody></tbody>');

    }


//    function FC_Rendered(domId) {
//        //It is in this method that you can update chart's data using JS methods.
//        //Check if this is the chart that we want to update
//        if (domId == "chartdiv3") {
//            //Set chartLoaded flag to true
//            chartLoaded = true;

//            //Get reference to chart object using Dom ID
//            var chartObj = getChartFromId(domId);
//            //Update it's XML - set animate Flag to true
//            chartObj.setDataXML(document.getElementById('ctl00_ContentPlaceHolder1_hddxml').value);
//        }
//        return true;
//    }

//    function updateChart(domId) {
//        //Update only if chart has loaded
//        if (chartLoaded) {
//            //Get reference to chart object using Dom ID
//            var chartObj = getChartFromId(domId);
//            //Update it's XML - set animate Flag from AnimateChart checkbox in form
//            chartObj.setDataXML(document.getElementById('ctl00_ContentPlaceHolder1_hddxml').value); 
//        }
//    }

    function clientItemChecking(sender, args) {
        var checkedItems = sender.get_checkedItems().length;
        if (checkedItems >= 2 && (args.get_item().get_checked() == false)) {
            args.set_cancel(true);
            radalert("Seleccione 2 Secciones maximo")
        }
    }

</script>
<table cellpadding="0" cellspacing="0" border="0" width="939">
                                    	<tr>
                                        	<td style="width:15px"></td>
                                        	<td valign="top" style="width:744px">
                                            	<table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                	<tr>
                                                    	<td style="width:900; height: 10px;" valign="top">
                                                        	<div class="ContTopLiBx">
                                                                            <div class="ContTitLiBx">Informe Polines</div>
	                                                                        <div class="LogoTTMLiBx"></div>
	                                                                        <div class="limpiar"></div>
                                                                        </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    	<td style="height:10px">
                                                            <asp:Panel runat="server" ID="PnlFilto" meta:resourcekey="PnlFiltoResource1">
                                                            <table width="900" border="0" cellspacing="0" cellpadding="0" class="TblFiltoCompleto" id="Table2" runat="server" visible="true">
                                                              <tr id="Tr1" runat="server">
                                                                <td id="Td1" style="width:900px; height:20px" runat="server">
                                                                    <table width="900" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo">
                                                                  <tr>
                                                                    <th align="left" valign="middle" style="width:700px">FILTRO DE BUSQUEDA</th>
                                                                    <th style="height: 21px; width:200px" align="right" valign="top">
                                                                    <asp:ImageButton runat="server" ID="IbtnDesactivar"  OnClick="IbtnDesactivar_Click" 
                                                                            SkinID="IBtnDesactivarFiltro" CausesValidation="False"  
                                                                            ToolTip="Desactivar filtro"  />
                                                                    <asp:ImageButton runat="server" ID="IbtnActivar" Visible="False" 
                                                                            OnClick="IbtnActivar_Click" SkinID="IBtnActivarFilto" CausesValidation="False" 
                                                                            ToolTip="Activar filtro" />
                                                                        </th>
                                                                  </tr>
                                                                </table></td>
                                                              </tr>
                                                              <tr id="Tr2" runat="server">
                                                                <td id="Td2" valign="top" runat="server">
                                                                    <table width="900" border="0" cellspacing="0" cellpadding="0" 
                                                                        class="filtroContenido" id="tblFiltro" runat="server">
                                                                        <tr id="Tr3" runat="server">
                                                                            <td id="Td3" valign="top" runat="server">
                                                                                <table cellpadding="0" cellspacing="0" border="0" style="width:700px">
                                                                                    <tr>
                                                                                            <td style="width:10px"></td>
                                                                                            <td style="width:100px; height:10px"></td>
                                                                                            <td style="width:200px;"></td>
                                                                                            <td style="width:100px;"></td>
                                                                                            <td style="width:200px;"></td>
                                                                                            <td style="width: 89px"></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td></td>
                                                                                        <td style="height: 24px" align="center" valign="top">Seccion</td>
                                                                                        <td align="left" valign="top">

                                                                                                <telerik:RadComboBox ID="CmbseccionInfPolines" runat="server" 
                                                                                                    AutoPostBack="True" CausesValidation="False" DataTextField="description" 
                                                                                                    DataValueField="value" CheckBoxes="false"
                                                                                                    Skin="Default" Sort="Ascending" Width="180px" 
                                                                                                    Culture="es-CL" DropDownAutoWidth="Enabled" 
                                                                                                    onselectedindexchanged="CmbseccionInfPolines_SelectedIndexChanged" 
                                                                                                    EmptyMessage="[-- Seleccione --]">
                                                                                                    <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                                </telerik:RadComboBox>
                 

                                                                                        </td>
                                                                                        <td align="center" valign="top">Equipo
                                                                                            <br />
                                                                                            </td>
                                                                                        <td align="left" valign="top">
                                                                                        <telerik:RadComboBox ID="CmbEqInfPolines" runat="server" DataTextField="description" 
                                                                                                    DataValueField="value" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                                                                    Skin="Default" Sort="Ascending" Width="180px" 
                                                                                                    Height="350px" 
                                                                                                onselectedindexchanged="CmbEqInfPolines_SelectedIndexChanged" 
                                                                                                EmptyMessage="[-- Seleccione --]" CausesValidation="False">
                                                                                                    <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                                </telerik:RadComboBox>
                                                                                        </td>
                                                                                        <td align="center" valign="top">Criticidad
                                                                                            <br />
                                                                                            </td>
                                                                                        <td align="left" valign="top">
                                                                                        <telerik:RadComboBox ID="cblcolor" runat="server" CausesValidation="False" DataTextField="description" 
                                                                                                DataValueField="value"  CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                                                                Skin="Default" Sort="Ascending" Width="180px" 
                                                                                                EmptyMessage="[-- Seleccione --]" >
                                                                                                <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>&nbsp;</td>
                                                                                        <td style="height: 24px" align="center" valign="top">Desde</td>
                                                                                        <td align="left" valign="top">
                <telerik:RadDatePicker ID="rddate1" runat="server">
                </telerik:RadDatePicker>
                                                                                        </td>
                                                                                        <td align="center" valign="top">Hasta</td>
                                                                                        <td align="left" valign="top">
            <telerik:RadDatePicker ID="rddate2" runat="server">
            </telerik:RadDatePicker>
			                                                                            </td>
                                                                                        <td align="center" valign="top"></td>
                                                                                        <td align="left" valign="top">
                                                                                        
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="6" style="height:10px"></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                            <td id="Td4" style="width:180px" valign="top" runat="server">
                                                                                <table cellpadding="2" cellspacing="0" border="0">
                                                                                    <tr>
                                                                                        <td valign="top">
                                                                                            <asp:HiddenField ID="Hddseccion" runat="server" />
                                                                                            <asp:HiddenField ID="Hddequipo" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtipo" runat="server" />
                                                                                            <asp:HiddenField ID="Hddcrit" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtime" runat="server" />
                                                                                            <asp:HiddenField ID="hddxml" runat="server" />
                                                                                            <asp:ImageButton ID="IbtnBuscar" runat="server" OnClick="IbtnBuscar_Click" SkinID="IBtnBuscar" CausesValidation="False" />
                                                                                        </td>
                                                                                        <td valign="top">
                                                                                            <asp:ImageButton ID="IbtnBorrarBuscar" runat="server" OnClick="IbtnBorrarBuscar_Click" SkinID="IBtnBorrarBuacar" CausesValidation="False" />
                                                                                        </td>
                                                                                        <td valign="top">
                                                                                            <asp:ImageButton ID="IbtnPdf" runat="server" SkinID="IBtnPdf" CausesValidation="False"  onclientclick="FromHTMLtoPDF();"/>
                                                                                        </td>
                                                                                        <td valign="top">
                                                                                            <asp:ImageButton ID="IbtnExcel" runat="server" SkinID="IBtnExcel" onclientclick="FromHTMLtoEXCEL();return false;"  CausesValidation="False" Visible="False"  />
                                                                                        </td>
                                                                                     </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                </table>
                                                                
                                                                </td>
                                                              </tr>
                                                            </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height:10px"></td>
                                                    </tr>
                                                    <tr>
                                                    	<td valign="top" style="width:900px;">
                                                    	    <asp:Panel ID="PnlBuscar" runat="server" Width="900px" 
                                                                meta:resourcekey="PnlBuscarResource1">
                                                    	    	<table id="TblBuscar" runat="server" cellpadding="0" cellspacing="0" border="0" 
                                                                    style="width:900px">
                                                    	    	
                                                    	        	<tr id="Tr4" runat="server">
                                                    	        	    <td id="Td5" style="width:900px" runat="server">
                                                    	        	        <table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    	        	            <tr>    
                                                    	        	                <td style="width:300px; height: 20px;" valign="top" align="left">
                                                    	        	                    &nbsp;&nbsp;</td>
                                                                                    <td align="center" style="width: 181px; height: 20px">&nbsp;
                                                                                        
                                                                                    </td>
                                                    	        	                <td style="width:600; height: 20px;" align="right">
                                                    	        	                </td>
                                                    	        	            </tr>
                                                    	        	            
                                                    	        	        </table>
                                                    	        	        
                                                    	        	    </td>
                                                    	        	</tr>
                                                    	    	    <tr id="Tr5" runat="server">
                                                    	    	        <td id="Td6" valign="top" 
                                                                            style="font-size: 11px; vertical-align: text-top; font-style: normal; font-family: Arial; height: 5%; text-align: right; font-variant: normal" 
                                                                            runat="server">
                                                                            <asp:Panel ID="PnlZonaGraficoCriticidad" runat="server" ScrollBars="Auto"  Width="900px"></asp:Panel>
                                                                            <asp:HiddenField ID="hddReportHtml" runat="server" />
                                                                            <asp:Panel ID="PnlGrafico" runat="server" ScrollBars="Auto" Height="300px" Width="900px">
                                                                            <div id="chartdiv3">
			                                                                    
		                                                                    </div>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="Tr6" runat="server">
                                                                        <td id="Td7" style="height:10px" runat="server">
                                                                            <asp:ImageButton ID="IBtnExpPrint" runat="server" CausesValidation="False" 
                                                                            onclientclick="FromHTMLtoPDF();return false;" SkinID="IBtnExpImprimir" 
                                                                                Visible="False" ImageAlign="Right" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>    
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height:32px"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width:15px"></td>
                                        </tr>
                                    </table>
  

<%--    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $('a[rel*=facebox]').facebox()
        })
    </script>--%>	
    
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnActivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbseccionInfPolines">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CmbEqInfPolines" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="Hddseccion" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="Hddequipo" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="Hddtipo" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="Hddcrit" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="Hddtime" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="hddxml" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
<%--                    <telerik:AjaxUpdatedControl ControlID="PnlGrafico" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>

</asp:Content>