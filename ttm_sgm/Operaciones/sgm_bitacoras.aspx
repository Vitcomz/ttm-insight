<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="sgm_bitacoras.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_bitacoras"  StyleSheetTheme="ttm" Theme="ttm"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script> 
<script type="text/javascript">


    //the following code use radconfirm to mimic the blocking of the execution thread.
    //The approach has the following limitations:
    //1. It works inly for elements that have *click* method, e.g. links and buttons
    //2. It cannot be used in if(!confirm) checks
    window.blockConfirm = function (text, mozEvent, oWidth, oHeight, callerObj, oTitle) {
        var ev = mozEvent ? mozEvent : window.event; //Moz support requires passing the event argument manually
        //Cancel the event
        ev.cancelBubble = true;
        ev.returnValue = false;
        if (ev.stopPropagation) ev.stopPropagation();
        if (ev.preventDefault) ev.preventDefault();

        //Determine who is the caller
        var callerObj2 = ev.srcElement ? ev.srcElement : ev.target;

        //Call the original radconfirm and pass it all necessary parameters
        if (callerObj2) {
            //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again.
            var callBackFn = function (arg) {
                if (arg) {
                    callerObj2["onclick"] = "";
                    if (callerObj2.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz
                    else if (callerObj2.tagName == "A") //We assume it is a link button!
                    {
                        try {
                            eval(callerObj2.href)
                        }
                        catch (e) { }
                    }
                }
            }

            radconfirm(text, callBackFn, oWidth, oHeight, callerObj2, oTitle);
        }
        return false;
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
                                                                            <div class="ContTitLiBx">Administrador Bitacoras</div>
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
                                                                                            <td style="width: 89px">&nbsp;
                                                                                                </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td style="width: 11px"></td>
                                                                                            <td align="center"><strong>Seccion</strong></td>
                                                                                            <td align="left" valign="top"><telerik:RadComboBox ID="CmbSecBitacorafiltro" 
                                                                                                    runat="server" DataTextField="description" DataValueField="value" 
                                                                                                    Skin="Default" CausesValidation="False" Sort="Ascending" Width="190px" 
                                                                                                    onselectedindexchanged="CmbSecBitacorafiltro_SelectedIndexChanged" 
                                                                                                    AutoPostBack="True"></telerik:RadComboBox></td>
                                                                                            <td><strong>Equipo</strong></td>
                                                                                            <td align="left"><telerik:RadComboBox ID="CmbEqBitacorafiltro" 
                                                                                                    runat="server" DataTextField="description" DataValueField="value" 
                                                                                                    Skin="Default" CausesValidation="False" Sort="Ascending" Width="230px"></telerik:RadComboBox>
                                                                                            </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                      <td style="width: 11px"></td>
                                                                                      <td align="center"><strong>Fecha Desde</strong></td>
                                                                                      <td align="left" valign="top">
                                                                                          <telerik:RadDatePicker ID="TxtFechaDesde" Runat="server" Width="110px"><calendar ID="Calendar1" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar></telerik:RadDatePicker>
                                                                                        </td>
                                                                                      <td align="center"><strong>Fecha Hasta</strong></td>
                                                                                      <td align="left">
                                                                                          <telerik:RadDatePicker ID="TxtFechaHasta" Runat="server" Width="110px"><calendar ID="Calendar2" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar></telerik:RadDatePicker>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="4" style="height:10px"></td>
                                                                                            <td style="height:10px">&nbsp;
                                                                                                </td>
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
                                                                                            
                                                                                            <asp:ImageButton ID="IbtnNuevoF" runat="server" SkinID="IBtnNuevoF" CausesValidation="False" onclick="IbtnNuevoF_Click" />
                                                                                            <asp:ImageButton ID="IbtnBuscar" runat="server" OnClick="IbtnBuscar_Click" SkinID="IBtnBuscar" CausesValidation="False" />
                                                                                            <asp:ImageButton ID="IbtnBorrarBuscar" runat="server" OnClick="IbtnBorrarBuscar_Click" SkinID="IBtnBorrarBuacar" CausesValidation="False" />
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
                                                                    style="width:900px" visible="False">
                                                    	    	
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
                                                                            <telerik:radgrid id="RadGrid1" runat="server" AutoGenerateColumns="False" 
                                                                                CellPadding="0" CellSpacing="0" 
                                                                                GridLines="None" OnItemCommand="RadGrid1_ItemCommand" 
                                                                                ShowStatusBar="True" 
                                                                                onitemdatabound="RadGrid1_ItemDataBound" Culture="es-CL">
                                                                                <ExportSettings ExportOnlyData="True">
                                                                                    <Pdf PageWidth="">
                                                                                    </Pdf>
                                                                                </ExportSettings>
                                                                                <ClientSettings  EnablePostBackOnRowClick="true">
                                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="550px" />
                                                                                    <Selecting AllowRowSelect="True" />
                                                                                </ClientSettings>
                                                                                <MasterTableView CellPadding="0" CellSpacing="0" GridLines="Both" 
                                                                                    DataKeyNames="ID,EQUIPO" PageSize="50">
                                                                                       <NoRecordsTemplate>
                                                                                         <div style="text-align:center;"><asp:Image runat="server" ID="ImgNoRecord" SkinID="ImgAlertGrid" /></div>
                                                                                       </NoRecordsTemplate>
                                                                                       <CommandItemSettings ShowExportToExcelButton="True" />
                                                                                       <RowIndicatorColumn Visible="False">
                                                                                       </RowIndicatorColumn>
                                                                                       <ExpandCollapseColumn Created="True">
                                                                                       </ExpandCollapseColumn>
                                                                                    <Columns>
                                                                                        <telerik:GridBoundColumn DataField="ID" HeaderText="Id" 
                                                                                            UniqueName="ID" Resizable="False" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
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
                                                                                                            tableView.filter("EQUIPO", args.get_item().get_value(), "EqualTo");
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
                                                                                    <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" 
                                                                                           AlwaysVisible="True" />
                                                                                       <CommandItemTemplate>
                                                                                           test
                                                                                       </CommandItemTemplate>
                                                                                </MasterTableView>
                                                                                <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" 
                                                                                    AlwaysVisible="True" />
</telerik:radgrid></td>
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
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
        <%---------------------------------------parte de template ----------------------------------------------------------------%>
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
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
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
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
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
        <%---------------------------------------fin parte de template ----------------------------------------------------------------%>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</asp:Content>
