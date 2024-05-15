<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sgm_bitacoras_auxiliar.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_bitacoras_auxiliar"  StyleSheetTheme="ttm" Theme="ttm" %>

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
    <title>Formulario Bitacora</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />






</head>
<body>
    <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
            <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
            <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script> 
                                                    	    <asp:Panel ID="PnlBuscar" runat="server" Width="900px">
                                                    	    	<table id="TblBuscar" runat="server" cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    	        	<tr id="Tr4" runat="server">
                                                    	        	    <td id="Td5" style="width:900px" runat="server">
                                                    	        	        <table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    	        	            <tr>    
                                                    	        	                <td style="width:300px; height: 20px;" valign="top" align="left">
                                                    	        	                    <asp:ImageButton runat="server" ID="IBtnNuevoRegistro" SkinID="IBtnNuevoGrid" OnClick="IBtnNuevoRegistro_Click" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LBtnNuevoRegistro" Text="AGREGAR NUEVA BITACORA" SkinID="LBtnNuevoRegistro" OnClick="LBtnNuevoRegistro_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
                                                                                    <td align="center" style="width: 181px; height: 20px">&nbsp;
                                                                                        
                                                                                    </td>
                                                    	        	                <td style="width:600; height: 20px;" align="right">
                                                    	        	                    <asp:ImageButton runat="server" ID="IbtnRefresh" SkinID="IBtnRefrescarGrid" OnClick="IbtnRefresh_Click" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LbtnRefresh" Text="REFRESCAR BUSQUEDA DE DATOS" SkinID="LBtnNuevoRegistro" OnClick="LbtnRefresh_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
                                                    	        	            </tr>
                                                    	        	            
                                                    	        	        </table>
                                                    	        	        
                                                    	        	    </td>
                                                    	        	</tr>
                                                    	    	    <tr id="Tr5" runat="server">
                                                    	    	        <td id="Td6" valign="top" 
                                                                            style="font-size: 11px; vertical-align: text-top; font-style: normal; font-family: Arial; height: 5%; text-align: right; font-variant: normal" 
                                                                            runat="server">
                                                                            <telerik:radgrid id="RadGrid1Aux" runat="server" AllowPaging="True" 
                                                                                AllowSorting="True" AutoGenerateColumns="False" CellPadding="0" CellSpacing="0" 
                                                                                GridLines="None" OnItemCommand="RadGrid1_ItemCommand" 
                                                                                OnSortCommand="RadGrid1_SortCommand" 
                                                                                OnPageIndexChanged="RadGrid1_PageIndexChanged" 
                                                                                OnPageSizeChanged="RadGrid1_PageSizeChanged" 
                                                                                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" 
                                                                                ShowStatusBar="True" AllowFilteringByColumn="True" 
                                                                                onitemdatabound="RadGrid1_ItemDataBound" Culture="es-CL" 
                                                                                GroupingEnabled="False" PageSize="15">
                                                                                <ExportSettings>
                                                                                    <Pdf PageWidth="">
                                                                                    </Pdf>
                                                                                </ExportSettings>
                                                                                <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True"  EnablePostBackOnRowClick="true">
                                                                                    <Selecting AllowRowSelect="True" />
                                                                                    <Scrolling AllowScroll="True" ScrollHeight="550px" UseStaticHeaders="True" />
                                                                                </ClientSettings>
                                                                                <MasterTableView CellPadding="0" CellSpacing="0" GridLines="Both" 
                                                                                    DataKeyNames="ID" PageSize="30" HierarchyLoadMode="Client">
                                                                                       <NoRecordsTemplate>
                                                                                         <div style="text-align:center;"><asp:Image runat="server" ID="ImgNoRecord" SkinID="ImgAlertGrid" /></div>
                                                                                       </NoRecordsTemplate>
                                                                                    <Columns>
                                                                                        <telerik:GridBoundColumn DataField="ID" HeaderText="Id" 
                                                                                            UniqueName="id" Resizable="False" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                                                                                            ShowFilterIcon="false">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                                                                            <ItemStyle HorizontalAlign="Center"/>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn UniqueName="FECHA" DataField="FECHA" HeaderText="Fecha"
                                                                                            DataFormatString="{0:dd/MM/yyyy}">
                                                                                            <FilterTemplate>
                                                                                                De
                                                                                                <telerik:RadDatePicker ID="DeFecha" runat="server" Width="97px" ClientEvents-OnDateSelected="FromDateSelected"
                                                                                                    MinDate="01-01-2000" MaxDate="05-06-2099" 
                                                                                                    DbSelectedDate='<%# startDate %>' Font-Size="8px" /><br>
                                                                                                al
                                                                                                <telerik:RadDatePicker ID="AlFecha" runat="server" Width="97px" ClientEvents-OnDateSelected="ToDateSelected"
                                                                                                    MinDate="01-01-2000" MaxDate="05-06-2099" 
                                                                                                    DbSelectedDate='<%# endDate %>' Font-Size="8px" />
                                                                                                <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                                                                                    <script type="text/javascript">
                                                                                                        function FromDateSelected(sender, args) {
                                                                                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                            var ToPicker = $find('<%# ((GridItem)Container).FindControl("AlFecha").ClientID %>');

                                                                                                            var fromDate = FormatSelectedDate(sender);
                                                                                                            var toDate = FormatSelectedDate(ToPicker);

                                                                                                            tableView.filter("FECHA", fromDate + " " + toDate, "Between");

                                                                                                        }
                                                                                                        function ToDateSelected(sender, args) {
                                                                                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                            var FromPicker = $find('<%# ((GridItem)Container).FindControl("DeFecha").ClientID %>');

                                                                                                            var fromDate = FormatSelectedDate(FromPicker);
                                                                                                            var toDate = FormatSelectedDate(sender);

                                                                                                            tableView.filter("FECHA", fromDate + " " + toDate, "Between");
                                                                                                        }
                                                                                                        function FormatSelectedDate(picker) {
                                                                                                            var date = picker.get_selectedDate();
                                                                                                            var dateInput = picker.get_dateInput();
                                                                                                            var formattedDate = dateInput.get_dateFormatInfo().FormatDate(date, dateInput.get_displayDateFormat());

                                                                                                            return formattedDate;
                                                                                                        }
                                                                                                    </script>
                                                                                                </telerik:RadScriptBlock>
                                                                                            </FilterTemplate>
                                                                                            <HeaderStyle Width="125px" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="EQUIPO" HeaderText="Componente" 
                                                                                            UniqueName="componente">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                            <FilterTemplate>
                                                                                                <telerik:RadComboBox ID="RadComboBoxEQ" Height="200px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("componente").CurrentFilterValue %>'
                                                                                                    runat="server" OnClientSelectedIndexChanged="FilterEQSelectedIndexChanged">
                                                                                                </telerik:RadComboBox>
                                                                                                <telerik:RadScriptBlock ID="RadScriptBlock4" runat="server">
                                                                                                    <script type="text/javascript">
                                                                                                        function FilterEQSelectedIndexChanged(sender, args) {
                                                                                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                            tableView.filter("componente", args.get_item().get_value(), "EqualTo");
                                                                                                        }
                                                                                                    </script>
                                                                                                </telerik:RadScriptBlock>
                                                                                            </FilterTemplate>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="DESCRIPCION" HeaderText="Descripcion" 
                                                                                            UniqueName="descripcion" AllowFiltering="False" AllowSorting="False">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="240px" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="RESPONSABLE" HeaderText="Responsable" 
                                                                                            UniqueName="responsable">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="110px" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                            <FilterTemplate>
                                                                                                <telerik:RadComboBox ID="RadComboBoxResp" Height="200px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("responsable").CurrentFilterValue %>'
                                                                                                    runat="server" OnClientSelectedIndexChanged="FilterRespSelectedIndexChanged">
                                                                                                    <Items>
                                                                                                        <telerik:RadComboBoxItem Text="All" />
                                                                                                    </Items>
                                                                                                </telerik:RadComboBox>
                                                                                                <telerik:RadScriptBlock ID="RadScriptBlock5" runat="server">
                                                                                                    <script type="text/javascript">
                                                                                                        function FilterRespSelectedIndexChanged(sender, args) {
                                                                                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                            tableView.filter("responsable", args.get_item().get_value(), "EqualTo");
                                                                                                        }
                                                                                                    </script>
                                                                                                </telerik:RadScriptBlock>
                                                                                            </FilterTemplate>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridTemplateColumn DataField="COLOR" 
                                                                                            FilterControlAltText="Filter criticidad column" HeaderText="Cricitidad" 
                                                                                            UniqueName="criticidad">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="COLORTextBox" runat="server" Text='<%# Bind("COLOR") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                            <ItemTemplate> 
                                                                                                <asp:Image ID="COLORLabel" ImageUrl='<%# "~/ttm_skins/Images/_center/" + Eval("COLOR") +"icon15x15.png"%>' runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <FilterTemplate>
                                                                                                <telerik:RadComboBox ID="cblcolor" runat="server" AppendDataBoundItems="true" 
                                                                                                    OnClientSelectedIndexChanged="FilterColorSelectedIndexChanged" 
                                                                                                    SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("criticidad").CurrentFilterValue %>' 
                                                                                                    Width="70px">
                                                                                                    <Items>
                                                                                                        <telerik:RadComboBoxItem Text="TODOS" Value="TOD" />
                                                                                                        <telerik:RadComboBoxItem Text="ALTA" Value="ALTA" />
                                                                                                        <telerik:RadComboBoxItem Text="MEDIA" Value="MEDIA" />
                                                                                                        <telerik:RadComboBoxItem Text="BAJA" Value="BAJA" />
                                                                                                    </Items>
                                                                                                </telerik:RadComboBox>
                                                                                                <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
                                                                                                    <script type="text/javascript">


                                                                                                    function FilterColorSelectedIndexChanged(sender, args) {
                                                                                                        var tableView1x = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                        var filterVal1x = args.get_item().get_value();
                                                                                                        if (filterVal1x == "TOD") {
                                                                                                            tableView1x.filter("COLOR", filterVal, "NoFilter");
                                                                                                        }
                                                                                                        else if (filterVal1x == "ALTA") {
                                                                                                            tableView1x.filter("COLOR", "ALTA", "EqualTo");
                                                                                                        }
                                                                                                        else if (filterVal1x == "MEDIA") {
                                                                                                            tableView1x.filter("COLOR", "MEDIA", "EqualTo");
                                                                                                        }
                                                                                                        else if (filterVal1x == "BAJA") {
                                                                                                            tableView1x.filter("COLOR", "MEDIA", "EqualTo");
                                                                                                        }
                                                                                                    }  
                                                                                                </script>
                                                                                                </telerik:RadScriptBlock>
                                                                                            </FilterTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn DataField="IND_DANO" 
                                                                                            FilterControlAltText="Filter danos column" HeaderText="Daños" 
                                                                                            UniqueName="danos">
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="IND_DANOTextBox" runat="server" Text='<%# Bind("IND_DANO") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                            <ItemTemplate>
                                                                                                <%--<asp:CheckBox ID="chk_IND_DANO" runat="server" Checked="<%# Eval("IND_DANO") %>" />--%>
                                                                                            </ItemTemplate>
                                                                                            <FilterTemplate>
                                                                                                <telerik:RadComboBox ID="cbldanos" runat="server" AppendDataBoundItems="true" 
                                                                                                    OnClientSelectedIndexChanged="ImportedFilterSelectedIndexChanged" 
                                                                                                    SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("danos").CurrentFilterValue %>' 
                                                                                                    Width="70px">
                                                                                                    <Items>
                                                                                                        <telerik:RadComboBoxItem Text="TODOS" Value="TOD" />
                                                                                                        <telerik:RadComboBoxItem Text="Si" Value="TRUE" />
                                                                                                        <telerik:RadComboBoxItem Text="No" Value="FALSE" />
                                                                                                    </Items>
                                                                                                </telerik:RadComboBox>
                                                                                                <telerik:RadScriptBlock ID="RadScriptBlock12" runat="server">
                                                                                                    <script type="text/javascript">


                                                                                                    function ImportedFilterSelectedIndexChanged(sender, args) {
                                                                                                        var tableView1 = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                        var filterVal1 = args.get_item().get_value();
                                                                                                        if (filterVal1 == "TOD") {
                                                                                                            tableView1.filter("IND_DANO", filterVal, "NoFilter");
                                                                                                        }
                                                                                                        else if (filterVal1 == "TRUE") {
                                                                                                            tableView1.filter("IND_DANO", "TRUE", "EqualTo");
                                                                                                        }
                                                                                                        else if (filterVal1 == "FALSE") {
                                                                                                            tableView1.filter("IND_DANO", "FALSE", "EqualTo");
                                                                                                        }
                                                                                                    }  
                                                                                                </script>
                                                                                                </telerik:RadScriptBlock>
                                                                                            </FilterTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn DataField="IND_SOLUCION" 
                                                                                            FilterControlAltText="Filter solucion column" HeaderText="Solucion" 
                                                                                            UniqueName="solucion">
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="IND_SOLUCIONTextBox" runat="server" 
                                                                                                    Text='<%# Bind("IND_SOLUCION") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                            <ItemTemplate>
                                                                                                <%--<asp:CheckBox ID="chk_IND_SOLUCION" runat="server" Checked="<%# Eval("IND_SOLUCION") %>" />--%>
                                                                                            </ItemTemplate>
                                                                                            <FilterTemplate>
                                                                                                <telerik:RadComboBox ID="ImportedFilter" runat="server" 
                                                                                                    AppendDataBoundItems="true" 
                                                                                                    OnClientSelectedIndexChanged="ImportedFilterSelectedIndexChanged" 
                                                                                                    SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("solucion").CurrentFilterValue %>' 
                                                                                                    Width="70px">
                                                                                                    <Items>
                                                                                                        <telerik:RadComboBoxItem Text="TODOS" Value="TOD" />
                                                                                                        <telerik:RadComboBoxItem Text="Si" Value="TRUE" />
                                                                                                        <telerik:RadComboBoxItem Text="No" Value="FALSE" />
                                                                                                    </Items>
                                                                                                </telerik:RadComboBox>
                                                                                                <telerik:RadScriptBlock ID="RadScriptBlock13" runat="server">
                                                                                                    <script type="text/javascript">


                                                                                                    function ImportedFilterSelectedIndexChanged(sender, args) {
                                                                                                        var tableView2 = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                                                        var filterVal2 = args.get_item().get_value();
                                                                                                        if (filterVal2 == "TOD") {
                                                                                                            tableView2.filter("IND_SOLUCION", filterVal, "NoFilter");
                                                                                                        }
                                                                                                        else if (filterVal2 == "TRUE") {
                                                                                                            tableView2.filter("IND_SOLUCION", "TRUE", "EqualTo");
                                                                                                        }
                                                                                                        else if (filterVal2 == "FALSE") {
                                                                                                            tableView2.filter("IND_SOLUCION", "FALSE", "EqualTo");
                                                                                                        }
                                                                                                    }  
                                                                                                </script>
                                                                                                </telerik:RadScriptBlock>
                                                                                            </FilterTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                    </Columns>
                                                                                    <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" AlwaysVisible="True" />
                                                                                </MasterTableView>
                                                                                <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" AlwaysVisible="True" />
                                                                                </telerik:radgrid></td>
                                                                    </tr>
                                                                    <tr id="Tr6" runat="server">
                                                                        <td id="Td7" style="height:10px" runat="server"></td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>    
                                                        
		<script type="text/javascript">
		    function UpdateItemCountField(sender, args) {
		        //set the footer text
		        sender.get_dropDownElement().lastChild.innerHTML = "Total en " + sender.get_items().get_count() + " registros";
		    }
        </script>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>                                
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" UpdatePanelsRenderMode="Inline">
        <AjaxSettings>
        <%---------------------------------------parte de grid auxiliar ----------------------------------------------------------------%>
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
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
            <telerik:AjaxSetting AjaxControlID="CmbSecBitacorafiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CmbEqBitacorafiltro" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        <%---------------------------------------fin parte de grid auxiliar ----------------------------------------------------------------%>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</form>
</body>
</html>
