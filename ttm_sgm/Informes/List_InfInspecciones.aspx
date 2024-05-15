<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="List_InfInspecciones.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_InfInspecciones"  StyleSheetTheme="ttm" Theme="ttm"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">






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
        var secT = document.getElementById("ctl00_ContentPlaceHolder1_HddseccionT").value;
        var tip = document.getElementById("ctl00_ContentPlaceHolder1_Hddtipo").value;
        var crit = document.getElementById("ctl00_ContentPlaceHolder1_Hddcrit").value;
        var time = document.getElementById("ctl00_ContentPlaceHolder1_Hddtime").value;
        var alltime = time * 1500;
        var oManager = window.radopen("ReporteInsp2.0GenPdf.aspx?sec=" + sec + "&secT=" + secT + "&eq=" + eq + "&tip=" + tip + "&crit=" + crit, null);
        oManager.setSize(5, 5); //Width, Height
        oManager.center();
        oManager.SetActive();
        setTimeout(function () { oManager.close(); }, alltime);
    }

    function FromHTMLtoEXCEL() {
        var $tableBody2 = $('#ctl00_ContentPlaceHolder1_tabMedidas2');
        $tableBody2.html('<tbody></tbody>');
        var $tablebodyin = $('#ctl00_ContentPlaceHolder1_tabMedidas2').find("tbody");
        var $tableBody = $('#ctl00_ContentPlaceHolder1_CritDivCode').find("[id='tbl_rows']").find("tbody");
        $tablebodyin.append("<tr><td>ID</td><td>COMPONENTE</td><td>EQUIPO</td><td>DESC_COMPONENTE</td><td>DESC_EQUIPO</td><td>FECHA</td><td>DESCRIPCION</td><td>CRITICIDAD EQUIPO %</td><td>CRITI. COMPONENTE</td><td>AVISO/OT</td><td>RECOMENDACION</td><td>CAUSA RAIZ</td></tr>");
        $tableBody.find("[name='rowsdata']").each(function (i, tr) {
            $trNew = "<tr><td>" + $(this).find("[id='1x']").html() + "</td><td>" + $(this).find("[id='2x']").html() + "</td><td>" + $(this).find("[id='3x']").html().replace('EQUIPO : ','') + "</td><td>" + $(this).find("[id='4x']").html() + "</td><td>" + $(this).find("[id='5x']").html() + "</td><td>" + $(this).find("[id='6x']").html() + "</td><td>" + $(this).find("[id='7x']").html() + "</td><td>" + $(this).find("[id='8x']").html() + "</td><td>" + $(this).find("[id='9x']").html() + "</td><td>" + $(this).find("[id='10x']").html() + "</td><td>" + $(this).find("[id='11x']").html() + "</td><td>" + $(this).find("[id='12x']").html() + "</td></tr>";
            $tablebodyin.append($trNew);
        });
        $('#ctl00_ContentPlaceHolder1_tabMedidas2').tableExport({ type: 'excel', escape: 'false' });
        $tableBody2.html('<tbody></tbody>');

    }

    function clientItemChecking(sender, args) {
        var checkedItems = sender.get_checkedItems().length;
        if (checkedItems >= 2 && (args.get_item().get_checked() == false)) {
            args.set_cancel(true);
            radalert("Seleccione 2 Area maximo")
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
                                                                            <div class="ContTitLiBx">Informe Inspecciones</div>
	                                                                        <div class="LogoTTMLiBx"></div>
	                                                                        <div class="limpiar"></div>
                                                                        </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    	<td style="height:10px">
                                                    	    <asp:Panel runat="server" ID="PnlFilto" meta:resourcekey="PnlFiltoResource1">
                                                            <table width="900" border="0" cellspacing="0" cellpadding="0" runat="server" 
                                                                    id="TblFiltoCompleto">
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
                                                                                            <td style="width:11px"></td>
                                                                                            <td style="width:100px;"></td>
                                                                                            <td style="width:200px;"></td>
                                                                                            <td style="width: 89px"></td>
                                                                                            <td style="width: 89px">
                                                                                                &nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td style="width: 11px"></td>
                                                                                            <td valign="top" align="center"><strong>Area</strong></td>
                                                                                            <td align="left" valign="top">
                                                                                                <telerik:RadComboBox ID="CmbSeccionfiltro" runat="server" 
                                                                                                    AutoPostBack="True" CausesValidation="False" DataTextField="description" 
                                                                                                    DataValueField="value" CheckBoxes="true"
                                                                                                    Skin="Default" Sort="Ascending" Width="190px" Filter="Contains" 
                                                                                                    Culture="es-CL" DropDownAutoWidth="Enabled" 
                                                                                                    onselectedindexchanged="CmbSeccionfiltro_SelectedIndexChanged" 
                                                                                                    onclientitemchecking="clientItemChecking" 
                                                                                                    ondatabound="CmbSeccionfiltro_DataBound">
                                                                                                    <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                                </telerik:RadComboBox>
                                                                                            </td>
                                                                                            <td><strong>Equipo</strong></td>
                                                                                            <td align="left">
                                                                                                <telerik:RadComboBox ID="CmbEqfiltro" runat="server" CausesValidation="False" DataTextField="description" 
                                                                                                    DataValueField="value" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                                                                    Skin="Default" Sort="Ascending" Width="190px" Filter="Contains" 
                                                                                                    Height="350px">
                                                                                                    <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                                </telerik:RadComboBox>
                                                                                            </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="width: 11px">
                                                                                            &nbsp;</td>
                                                                                        <td align="center" valign="top">
                                                                                            &nbsp;</td>
                                                                                        <td align="left" valign="top">
                                                                                            &nbsp;</td>
                                                                                        <td>
                                                                                            &nbsp;</td>
                                                                                        <td align="left">
                                                                                            &nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="width: 11px">
                                                                                            &nbsp;</td>
                                                                                        <td align="center" valign="top">
                                                                                            <strong>Tipo de Equipo</strong></td>
                                                                                        <td align="left" valign="top">
                                                                                            <telerik:RadComboBox ID="CmbTipoEqfiltro" runat="server" 
                                                                                                CausesValidation="False" DataTextField="description" 
                                                                                                DataValueField="value" CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                                                                Skin="Default" Sort="Ascending" Width="190px" Filter="Contains" 
                                                                                                Height="350px">
                                                                                                <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <strong>Criticidad</strong></td>
                                                                                        <td align="left">
                                                                                            <telerik:RadComboBox ID="CmbCritfiltro" runat="server" 
                                                                                                AutoPostBack="True" CausesValidation="False" DataTextField="description" 
                                                                                                DataValueField="value"  CheckBoxes="true" EnableCheckAllItemsCheckBox="true"
                                                                                                Skin="Default" Sort="Ascending" Width="190px"  Filter="Contains">
                                                                                                <Localization AllItemsCheckedString="Todos seleccionados" 
                                                                                                        CheckAllString="Seleccionar todos" ItemsCheckedString="seleccionado(s)" 
                                                                                                        NoMatches="No hay seleccion" 
                                                                                                        ShowMoreFormatString="&lt;b&gt;1&lt;/b&gt;-&lt;b&gt;{0}&lt;/b&gt; de &lt;b&gt;{1}&lt;/b&gt; seleccionados" />
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="4" style="height:10px"></td>
                                                                                            <td style="height:10px">
                                                                                                &nbsp;</td>
                                                                                     </tr>
                                                                                </table>
                                                                            </td>
                                                                            <td id="Td4" style="width:180px" valign="top" runat="server">
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="180">
                                                                                    <tr>
                                                                                        <td style="height:10px"></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="height:50px" align="right" valign="top">
                                                                                            <asp:HiddenField ID="Hddseccion" runat="server" />
                                                                                            <asp:HiddenField ID="HddseccionT" runat="server" />
                                                                                            <asp:HiddenField ID="Hddequipo" runat="server" />
                                                                                            <asp:HiddenField ID="HddequipoT" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtipo" runat="server" />
                                                                                            <asp:HiddenField ID="Hddcrit" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtime" runat="server" />
                                                                                            <asp:ImageButton ID="IbtnBuscar" runat="server" OnClick="IbtnBuscar_Click" SkinID="IBtnBuscar" CausesValidation="False" />
                                                                                            <asp:ImageButton ID="IbtnBorrarBuscar" runat="server" 
                                                                                                OnClick="IbtnBorrarBuscar_Click" SkinID="IBtnBorrarBuacar" 
                                                                                                CausesValidation="False" />
                                                                                            <asp:ImageButton ID="IbtnPdf" runat="server" SkinID="IBtnPdf" CausesValidation="False"  onclientclick="FromHTMLtoPDF();"/> <%--onclick="IbtnPdf_Click"  --%>
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
                                                                            <asp:Panel ID="PnlZona" runat="server" ScrollBars="Auto" Height="650px" Width="900px"></asp:Panel>
                                                                            <asp:HiddenField ID="hddReportHtml" runat="server" />
                                                                            <table ID="tabMedidas2" runat="server"  border="1" cellpadding="0" cellspacing="0" width="100%">
                                                                                <tbody></tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="Tr6" runat="server">
                                                                        <td id="Td7" style="height:10px" runat="server"></td>
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
		<script type="text/javascript">
		    function UpdateItemCountField(sender, args) {
		        //set the footer text
		        sender.get_dropDownElement().lastChild.innerHTML = "Total en " + sender.get_items().get_count() + " registros";
		    }
        </script>
    <asp:SqlDataSource ID="SqlDataSourcex1" runat="server"></asp:SqlDataSource>                                
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
            <telerik:AjaxSetting AjaxControlID="CmbSeccionfiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CmbEqfiltro" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="htmlPdf" 
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
                        
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</asp:Content>
