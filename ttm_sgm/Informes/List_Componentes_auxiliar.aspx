<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List_Componentes_auxiliar.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_Componentes_auxiliar"  StyleSheetTheme="ttm" Theme="ttm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
    body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
    </style>
    <title>Componente</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />






</head>
<body>
    <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
            <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
            <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script> 

            <div style="width:900px; display:inline-block; float:left;">
                <div class="ContTopLiBx">
                    <div class="ContTitLiBx">Informe Estado de Componentes</div>
	                <div class="LogoTTMLiBx"></div>
	                <div class="limpiar"></div>
                </div>
	
            <!---- filtros ------>

	            <div>
		            <div class="PlContCell">
			            <div class="PlFiltNom">Selección Tipo de Equipo</div>
			            <div class="PlFiltConsl">
                            <telerik:RadComboBox ID="CmbTipoEqCompfiltro" runat="server" 
                                DataTextField="description" DataValueField="value" 
                            Skin="Default" CausesValidation="False" Sort="Ascending" Width="230px" 
                                AutoPostBack="True" 
                                onselectedindexchanged="CmbTipoEqCompfiltro_SelectedIndexChanged"></telerik:RadComboBox>
			            </div>
		            </div>

	            </div>
	
            <!---- lista detalle ------>

	            <div class="PlContList">
		            <div>	
                        <asp:Panel ID="PnlBuscar" runat="server" ScrollBars="Auto" Height="660px" Width="900px"></asp:Panel> 
                    </div>
	            </div>
            </div>

 
                                                        
		<script type="text/javascript">
		    function UpdateItemCountField(sender, args) {
		        //set the footer text
		        sender.get_dropDownElement().lastChild.innerHTML = "Total en " + sender.get_items().get_count() + " registros";
		    }
        </script>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>                                
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
        <%---------------------------------------parte de grid auxiliar ----------------------------------------------------------------%>
            <telerik:AjaxSetting AjaxControlID="CmbTipoEqCompfiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        <%---------------------------------------fin parte de grid auxiliar ----------------------------------------------------------------%>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</form>
</body>
</html>
