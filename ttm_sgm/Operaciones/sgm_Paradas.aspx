<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="sgm_Paradas.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_paradas" 
StylesheetTheme="ttm" Theme="ttm" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">






    <script language="JavaScript" type="text/jscript">
<!--
    function labelvisible1(identificador) {
        if (document.getElementById(identificador).style.display != "none") {
            document.getElementById(identificador).style.display = "none";
        } else {
            document.getElementById(identificador).style.display = "inline";
        }
    }
    function labelvisible(identificador) {
        if (document.getElementById("LblAyuda2").style.display != "none") {
            document.getElementById("LblAyuda2").style.display = "none";
        } else {
            document.getElementById("LblAyuda2").style.display = "inline";
        }
    }
//-->
</script>
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
        var callerObj = ev.srcElement ? ev.srcElement : ev.target;

        //Call the original radconfirm and pass it all necessary parameters
        if (callerObj) {
            //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again.
            var callBackFn = function (arg) {
                if (arg) {
                    callerObj["onclick"] = "";
                    if (callerObj.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz
                    else if (callerObj.tagName == "A") //We assume it is a link button!
                    {
                        try {
                            eval(callerObj.href)
                        }
                        catch (e) { }
                    }
                }
            }

            radconfirm(text, callBackFn, oWidth, oHeight, callerObj, oTitle);
        }
        return false;
    }
</script>
<script type="text/javascript">
    function TimeChanged(sender, eventArgs) {
        var datePicker = $find('RadDateTimePicker1');
        var datePicker1 = $find('RadDateTimePicker2');

        var date = datePicker.get_selectedDate();
        var date1 = datePicker1.get_selectedDate();
        //arg.IsValid = (difference(date, date1));
        alert(difference(date, date1));

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
                                                                            <div class="ContTitLiBx">Administrador Paradas</div>
	                                                                        <div class="LogoTTMLiBx"></div>
	                                                                        <div class="limpiar"></div>
                                                                        </div>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                    	<td style="height:10px">
                                                    	    <asp:Panel runat="server" ID="PnlFilto" Visible="true">
                                                            <table width="900" border="0" cellspacing="0" cellpadding="0" runat="Server" id="TblFiltoCompleto">
                                                              <tr>
                                                                <td style="width:900px; height:20px">
                                                                    <table width="900" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo">
                                                                  <tr>
                                                                    <th align="left" valign="middle" style="width:700px">FILTRO DE BUSQUEDA</th>
                                                                    <th style="height: 21px; width:200px" align="right" valign="top">
                                                                    <asp:ImageButton runat="server" ID="IbtnDesactivar" Visible="true"  OnClick="IbtnDesactivar_Click" SkinID="IBtnDesactivarFiltro" CausesValidation="False"  ToolTip="Desactivar filtro"  />
                                                                    <asp:ImageButton runat="server" ID="IbtnActivar" Visible="false" OnClick="IbtnActivar_Click" SkinID="IBtnActivarFilto" CausesValidation="False" ToolTip="Activar filtro" />
                                                                        </th>
                                                                  </tr>
                                                                </table></td>
                                                              </tr>
                                                              <tr>
                                                                <td>
                                                                    <table width="900" border="0" cellspacing="0" cellpadding="0" class="filtroContenido" id="tblFiltro" runat="server" visible="true">
                                                                        <tr>
                                                                            <td>
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
                                                                                            <telerik:RadComboBox ID="CmbSecParadafiltro" runat="server" AutoPostBack="True" 
                                                                                                CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                                Skin="Default" Sort="Ascending" Width="190px" 
                                                                                                onselectedindexchanged="CmbSecParadafiltro_SelectedIndexChanged">
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                        <td align="center" valign="top">Equipo</td>
                                                                                        <td align="left" valign="top">
                                                                                            <telerik:RadComboBox ID="CmbEqParadafiltro" runat="server" 
                                                                                                CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                                Skin="Default" Sort="Ascending" Width="230px" 
                                                                                                onselectedindexchanged="CmbEqParadafiltro_SelectedIndexChanged">
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                        <td align="center" valign="top">Estado
                                                                                            <br />
                                                                                            Parada</td>
                                                                                        <td align="left" valign="top">
                                                                                            <asp:DropDownList ID="CblEstadoParadasfiltro" runat="server" skinID="listamediano">
                                                                                                <asp:ListItem Value="">[--Seleccionar--]</asp:ListItem>
                                                                                                <asp:ListItem Value="ACT">Activo</asp:ListItem>
                                                                                                <asp:ListItem Value="INACT">Inactivo</asp:ListItem>
                                                                                                <asp:ListItem Value="ELI">Eliminado</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="6" style="height:10px"></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                            <td style="width:180px">
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="180">
                                                                                    <tr>
                                                                                        <td colspan="6" align="right" valign="top">
                                                                                            &nbsp;
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
                                                    	    <asp:Panel ID="PnlBuscar" runat="server" Width="900px">
                                                    	    	<table id="TblBuscar" runat="server" cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    	    	
                                                    	        	<tr>
                                                    	        	    <td style="width:900px">
                                                    	        	        <table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    	        	            <tr>    
                                                    	        	                <td style="width:300px; height: 20px;" valign="top" align="left">
                                                    	        	                    <asp:ImageButton runat="server" ID="IBtnNuevoRegistro" SkinID="IBtnNuevoGrid" OnClick="IBtnNuevoRegistro_Click" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LBtnNuevoRegistro" Text="AGREGAR NUEVA Parada" SkinID="LBtnNuevoRegistro" OnClick="LBtnNuevoRegistro_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
                                                    	        	                <td style="width:600; height: 20px;" align="right">
                                                    	        	                    <asp:ImageButton runat="server" ID="IbtnRefresh" SkinID="IBtnRefrescarGrid" 
                                                                                            onclick="IbtnRefresh_Click" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LbtnRefresh" Text="REFRESCAR BUSQUEDA DE DATOS" SkinID="LBtnNuevoRegistro" OnClick="LbtnRefresh_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
                                                    	        	            </tr>
                                                    	        	            
                                                    	        	        </table>
                                                    	        	        
                                                    	        	    </td>
                                                    	        	</tr>
                                                    	    	    <tr>
                                                    	    	        <td valign="top" style="font-size: 11px; vertical-align: text-top; font-style: normal; font-family: Arial; height: 5%; text-align: right; font-variant: normal">
                                                                            <telerik:radgrid id="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="1" CellSpacing="1" GridLines="None" OnItemCommand="RadGrid1_ItemCommand" OnSortCommand="RadGrid1_SortCommand" OnPageIndexChanged="RadGrid1_PageIndexChanged" OnPageSizeChanged="RadGrid1_PageSizeChanged" OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
                                                                                <ExportSettings>
                                                                                    <Pdf PageWidth="">
                                                                                    </Pdf>
                                                                                </ExportSettings>
                                                                                <MasterTableView CellPadding="1" CellSpacing="1" DataKeyNames="ID" 
                                                                                    GridLines="Both" PageSize="8" ShowFooter="True">
                                                                                    <NoRecordsTemplate>
                                                                                        <div style="text-align:center;">
                                                                                            <asp:Image ID="ImgNoRecord" runat="server" SkinID="ImgAlertGrid" />
                                                                                        </div>
                                                                                    </NoRecordsTemplate>
                                                                                    <Columns>
                                                                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn2">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="10px" />
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ibtnActualizar" runat="server" CausesValidation="false" 
                                                                                                    CommandName="Modificar" SkinID="IBtnActualizarGrid" ToolTip="Modificar" 
                                                                                                    Visible='<%# Convert.ToBoolean(Eval("estadoactualizar")) %>' />
                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn DataField="Icon" HeaderText="Estado" 
                                                                                            UniqueName="column1">
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="estadoTextBox" runat="server" Text='<%# Bind("Icon") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" Width="10px" />
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="lbtnsemaforo" runat="server" CausesValidation="False" 
                                                                                                    CommandArgument='<%# bind("ID") %>' ImageUrl='<%# bind("Icon") %>' 
                                                                                                    OnClick="lbtnsemaforo_click" 
                                                                                                    OnClientClick="return confirm(&quot;¿Desea cambiar el estado?&quot;);" />
                                                                                            </ItemTemplate>
                                                                                            <HeaderTemplate>
                                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                                                                    CommandArgument="estado" CommandName="Sort" SkinID="LBtnNuevoRegistro" 
                                                                                                    Width="10px">Estado</asp:LinkButton>
                                                                                            </HeaderTemplate>
                                                                                            <HeaderStyle Width="10px" />
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridBoundColumn DataField="id" HeaderText="Folio" 
                                                                                            UniqueName="column2">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="10%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="FECHAI"  HeaderText="Inicio"
                                                                                            UniqueName="column3">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="18%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn> 
                                                                                        <telerik:GridBoundColumn DataField="FECHAT" HeaderText="Termino" 
                                                                                            UniqueName="column4">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="18%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="TOTAL_HRS" HeaderText="Total Hrs." 
                                                                                            UniqueName="column5">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="8%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="EQUIPO"  HeaderText="Equipo"
                                                                                            UniqueName="column6">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="18%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="CODIGO"  HeaderText="Componente"
                                                                                            UniqueName="column7">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="18%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="TIPO"  HeaderText="Tipo"
                                                                                            UniqueName="column8">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="18%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="CAUSA"  HeaderText="Causa"
                                                                                            UniqueName="column9">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="18%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="OBSERVACION"  HeaderText="Observacion"
                                                                                            UniqueName="column10">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="40%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="OT"  HeaderText="OT"
                                                                                            UniqueName="column11" Display="False" EmptyDataText="">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="1%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ibtnEliminar" runat="server" CausesValidation="False" 
                                                                                                    CommandName="Eliminar" 
                                                                                                    OnClientClick="return confirm(&quot;¿Desea Eliminar este registro?&quot;);" 
                                                                                                    SkinID="IBtnEliminarGrid" ToolTip="Eliminar" 
                                                                                                    Visible='<%# Convert.ToBoolean(Eval("estadoactualizar")) %>' />
                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                    </Columns>
                                                                                    <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" />
                                                                                </MasterTableView>
                                                                                <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" />
</telerik:radgrid>&nbsp;&nbsp;
                                                                        </td>
                                                                    </tr>
																	<tr><td align="right" valign="top">
                                                                        &nbsp;</td></tr>
                                                                </table>
                                                            </asp:Panel>    
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width:900px" valign="top">
                                                            <asp:Panel ID="PnlNuevoRegistro" runat="server" Width="900px" Visible="false">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="900" runat="server" id="TblRegistro" class="NuevoGrid" >
                                                                <tr>
                                                                    <td style="height: 19px"><a href="javascript:labelvisible('txtayuda1')"><asp:Image id="ImgBtnAyuda" runat="server" SkinID="ImgAyuda" ImageAlign="Right"></asp:Image></a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="SingleParagraph" Font-Bold="True" Font-Names="Arial" Font-Size="10px" HeaderText="Por favor complete los siguientes campos:" Width="80%" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                                        <asp:CompareValidator ID="dateCompareValidator" runat="server" 
                                                                            ControlToCompare="RadDateTimePicker1" ControlToValidate="RadDateTimePicker2" 
                                                                            ErrorMessage="La fecha termino debe ser superior a la fecha inicio !!!" 
                                                                            Operator="GreaterThan" Type="Date"></asp:CompareValidator>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                    	            <td valign="top">
                                                        	            <table cellpadding="0" cellspacing="0" border="0" width="900" class="FormularioMantenedores">
                                                            	            <tr>
                                                                	            <td width="10" style="width:10px; height:20px"></td>
                                                                                <td width="134" style="width:134px">
                                                                                    &nbsp;</td>
                                                                                <td width="10" style="width:10px"></td>
                                                                                <td width="354">&nbsp;
                                                                                </td>
                                                                                <td width="10" style="width:10px"></td>
                                                                                <td width="108" style="height: 24px; width: 115px;">&nbsp;</td>
                                                                                <td width="242" style="width:10px"></td>
                                                                                <td width="15">&nbsp;</td>
                                                                                <td style="width:10px" width="10">
                                                                                </td>
                                                                                <td width="30">
                                                                                    &nbsp;</td>
                                                                                <td style="width:10px" width="10">
                                                                                </td>
                                                                                <td width="15">
                                                                                    &nbsp;</td>
                                                                                <td width="17">&nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Equipo</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 154px;" valign="top">
                                                                                    <telerik:RadComboBox ID="CmbEqParada" runat="server" CausesValidation="False" 
                                                                                        DataTextField="description" DataValueField="value" Skin="Default" 
                                                                                        Sort="Ascending" Width="220px" DropDownWidth="280px" AutoPostBack="True" 
                                                                                        onselectedindexchanged="CmbEqParada_SelectedIndexChanged" 
                                                                                        Filter="Contains">
                                                                                    </telerik:RadComboBox>
                                                                                </td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Componente</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <telerik:RadComboBox ID="CmbTipoEQ" runat="server" CausesValidation="False" 
                                                                                        DataTextField="description" DataValueField="value" 
                                                                                        Skin="Default" 
                                                                                        Sort="Ascending" Width="220px" 
                                                                                                DropDownWidth="280px" EmptyMessage="No hay Componente" Filter="Contains" 
                                                                                                Height="300px">
                                                                                    </telerik:RadComboBox>
                                                                                </td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top" width="30">
                                                                                    O.T.</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <asp:TextBox ID="txtOT" runat="server"></asp:TextBox>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    &nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Fecha Inicio</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 154px;" valign="top">
                                                                                    <telerik:RadDateTimePicker ID="RadDateTimePicker1" Runat="server" 
                                                                                        Culture="es-ES">
                                                                                        <TimeView CellSpacing="-1" Columns="8" Culture="es-ES" Interval="00:15:00">
                                                                                        </TimeView>
                                                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                                                        <calendar ID="Calendar1" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar>
                                                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                                                                                            LabelWidth="40%">
                                                                                            <EmptyMessageStyle Resize="None" />
                                                                                            <ReadOnlyStyle Resize="None" />
                                                                                            <FocusedStyle Resize="None" />
                                                                                            <DisabledStyle Resize="None" />
                                                                                            <InvalidStyle Resize="None" />
                                                                                            <HoveredStyle Resize="None" />
                                                                                            <EnabledStyle Resize="None" />
                                                                                        </DateInput>
                                                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                                                    </telerik:RadDateTimePicker>
                                                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="RadDateTimePicker1"
                                                                                    ErrorMessage="Ingresar una fecha !"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Fecha Termino</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <telerik:RadDateTimePicker ID="RadDateTimePicker2" Runat="server" 
                                                                                        Culture="es-ES" onselecteddatechanged="RadDateTimePicker2_SelectedDateChanged">
                                                                                        <TimeView CellSpacing="-1" Columns="8" Culture="es-ES" Interval="00:15:00">
                                                                                        </TimeView>
                                                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                                                        <calendar ID="Calendar2" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar>
                                                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                                                                                            LabelWidth="40%">
                                                                                            <EmptyMessageStyle Resize="None" />
                                                                                            <ReadOnlyStyle Resize="None" />
                                                                                            <FocusedStyle Resize="None" />
                                                                                            <DisabledStyle Resize="None" />
                                                                                            <InvalidStyle Resize="None" />
                                                                                            <HoveredStyle Resize="None" />
                                                                                            <EnabledStyle Resize="None" />
                                                                                        </DateInput>
                                                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                                                    </telerik:RadDateTimePicker>
                                                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="RadDateTimePicker2"
                                                                                    ErrorMessage="Ingresar una fecha !"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top" width="30">
                                                                                    Hrs. Detenidas</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <asp:Label ID="lblHrsDetenidas" runat="server" Font-Size="12px"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    &nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Tipo deteccion</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 154px;" valign="top">
                                                                                    <telerik:RadComboBox ID="CblTipoDetec" runat="server" Skin="Default" 
                                                                                        DataTextField="description" DataValueField="value" 
                                                                                        Sort="Ascending" Width="220px" DropDownWidth="250px" AutoPostBack="True" 
                                                                                        onselectedindexchanged="CblTipoDetec_SelectedIndexChanged">
                                                                                    </telerik:RadComboBox>
                                                                                </td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Causa</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <telerik:RadComboBox ID="CblTipoFalla" runat="server" 
                                                                                        CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                        Skin="Default" Sort="Ascending" Width="220px" 
                                                                                                DropDownWidth="280px" EmptyMessage="No hay Causa" Filter="Contains" 
                                                                                                Height="300px">
                                                                                    </telerik:RadComboBox>
                                                                                </td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top" width="30">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    &nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Observaciones</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; " valign="top" colspan="5">
                                                                                    <textarea ID="txtobservaciones" cols="65" name="S1" rows="5" runat="server"></textarea></td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top" width="30">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    &nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                </td>
                                                                                <td align="left" style="height: 24px; width: 154px;" valign="top">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                </td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                </td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    &nbsp;</td>
                                                                                <td style="height: 24px">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    &nbsp;</td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    &nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                	            <td colspan="6" style="height:10px"></td>
                                                                	            <td style="height:10px">&nbsp;</td>
                                                                                <td style="height:10px">&nbsp;
                                                                                    </td>
                                                                                <td style="height:10px">
                                                                                    &nbsp;</td>
                                                                                <td style="height:10px">
                                                                                    &nbsp;</td>
                                                                                <td style="height:10px">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                    	            <td style="width:900px" valign="top">                                                        	<table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                        		            <tr>
                                                                                <td style="height: 50px;" valign="top" colspan="2" align="center">
                                                                                    <asp:ImageButton ID="IbtnGrabar" runat="server" SkinID="IBtnGrabar" OnClick="IbtnGrabar_Click" />
                                                                                    <asp:ImageButton ID="IbtnBorrar" runat="server" SkinID="IBtnBorrar" OnClick="IbtnBorrar_Click" />
                                                                                    <asp:HiddenField ID="hddistatusprocedure" runat="server" Value="0" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                 <tr>
                                                    	            <td style="width:900px" valign="top">
                                                    	                <table cellpadding="0" cellspacing="0" border="0" style="width:900px" class="ComentarioFormulario">
                                                        		            <tr>
                                                                	            <td style="height:30px" valign="top" align="right">
                                                                                    Todos los datos en negrita son de ingreso obligatorio</td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                             </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td style="width:900px; height: 69px;" valign="top">
                                                            <asp:Panel ID="PnlActualizarRegistro" runat="server" Width="900px">
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td style="height:20px" ></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                                <tr>
                                                                    <td style="width:900px" align="right">
                                                                        </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width:15px"></td>
                                        </tr>
                                    </table>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>                                    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnActivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbSecParadafiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CmbEqParadafiltro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" UpdatePanelCssClass="" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbEqParada">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CmbTipoEQ" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="CblTipoDetec" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDateTimePicker1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblHrsDetenidas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDateTimePicker2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDateTimePicker2" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lblHrsDetenidas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CblTipoDetec">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CblTipoFalla" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
