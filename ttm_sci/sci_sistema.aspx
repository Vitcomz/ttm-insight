<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/ttm_template.Master" AutoEventWireup="true" CodeBehind="sci_sistema.aspx.cs" Inherits="Insight.sci.sci_sistema" 
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
<table cellpadding="0" cellspacing="0" border="0" width="939">
                                    	<tr>
                                        	<td style="width:15px"></td>
                                        	<td valign="top" style="width:744px">
                                            	<table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                	<tr>
                                                    	<td style="width:900; height: 10px;" valign="top">
                                                        	<div class="ContTopLiBx">
                                                                            <div class="ContTitLiBx">Administrador Sistema</div>
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
                                                                                        <td style="height: 24px" align="center" valign="top">Codigo
                                                                                            <br />
                                                                                            Sistema</td>
                                                                                        <td align="left" valign="top"><asp:TextBox ID="Txtidsistemafiltro" runat="server" SkinID="TextBoxBuscar"></asp:TextBox></td>
                                                                                        <td align="center" valign="top">Nombre
                                                                                            <br />
                                                                                            Sistema</td>
                                                                                        <td align="left" valign="top"><asp:TextBox ID="Txtsistemafiltro" runat="server" SkinID="TextBoxBuscar"></asp:TextBox></td>
                                                                                        <td align="center" valign="top">Estado
                                                                                            <br />
                                                                                            Sistema</td>
                                                                                        <td align="left" valign="top">
                                                                                            <asp:DropDownList ID="CblEstadosistemafiltro" runat="server" skinID="listamediano">
                                                                                                <asp:ListItem Value="">[--Seleccionar--]</asp:ListItem>
                                                                                                <asp:ListItem Value="ACTIVO">Activo</asp:ListItem>
                                                                                                <asp:ListItem Value="INACTIVO">Inactivo</asp:ListItem>
                                                                                                <asp:ListItem Value="ELIMINADO">Eliminado</asp:ListItem>
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
                                                    	        	                    <asp:ImageButton runat="server" ID="IBtnNuevoRegistro" SkinID="IBtnNuevoGrid" OnClick="IBtnNuevoRegistro_Click" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LBtnNuevoRegistro" Text="AGREGAR NUEVO SISTEMA" SkinID="LBtnNuevoRegistro" OnClick="LBtnNuevoRegistro_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
                                                    	        	                <td style="width:600; height: 20px;" align="right">
                                                    	        	                    <asp:ImageButton runat="server" ID="IbtnRefresh" SkinID="IBtnRefrescarGrid" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LbtnRefresh" Text="REFRESCAR BUSQUEDA DE DATOS" SkinID="LBtnNuevoRegistro" OnClick="LbtnRefresh_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
                                                    	        	            </tr>
                                                    	        	            
                                                    	        	        </table>
                                                    	        	        
                                                    	        	    </td>
                                                    	        	</tr>
                                                    	    	    <tr>
                                                    	    	        <td valign="top" style="font-size: 11px; vertical-align: text-top; font-style: normal; font-family: Arial; height: 5%; text-align: right; font-variant: normal">
                                                                            <telerik:radgrid id="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="1" CellSpacing="1" GridLines="None" OnItemCommand="RadGrid1_ItemCommand" OnSortCommand="RadGrid1_SortCommand" OnPageIndexChanged="RadGrid1_PageIndexChanged" OnPageSizeChanged="RadGrid1_PageSizeChanged" OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
                                                                                <MasterTableView CellPadding="1" CellSpacing="1" GridLines="Both" ShowFooter="True" DataKeyNames="id" PageSize="8">
                                                                                    <NoRecordsTemplate>
                                                                                         <div style="text-align:center;"><asp:Image runat="server" ID="ImgNoRecord" SkinID="ImgAlertGrid" /></div>
                                                                                    </NoRecordsTemplate>
                                                                                    <Columns>
                                                                                    
                                                                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn2">
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ibtnActualizar" runat="server" CommandName="Modificar" SkinID="IBtnActualizarGrid" ToolTip="Modificar" CausesValidation="false" Visible='<%# Convert.ToBoolean(Eval("estadoactualizar")) %>'/>
                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn DataField="Icon" HeaderText="Estado" UniqueName="column1">
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="estadoTextBox" runat="server" Text='<%# Bind("Icon") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID='lbtnsemaforo' runat='server' ImageUrl='<%# bind("Icon") %>' CommandArgument='<%# bind("id") %>' OnClick='lbtnsemaforo_click' CausesValidation="False" OnClientClick='return confirm("¿Desea cambiar el estado?");'/>
                                                                                            </ItemTemplate>
                                                                                            <HeaderTemplate>
                                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument="estado"
                                                                                                    CommandName="Sort" SkinID="LBtnNuevoRegistro" Width="40px">Estado</asp:LinkButton>
                                                                                            </HeaderTemplate>
                                                                                            <HeaderStyle Width="10px" />
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridBoundColumn DataField="id" HeaderText="Codigo" UniqueName="column2">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="nombre" HeaderText="Sistema" UniqueName="column3">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="fecha" HeaderText="Fecha" UniqueName="column4">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="autor" HeaderText="Autor" UniqueName="column5">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="30%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="BD" HeaderText="DB" UniqueName="column6" 
                                                                                            Display="False">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="30%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="VERSION" HeaderText="VERSION" 
                                                                                            UniqueName="column7" Display="False">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="30%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="UBICACION" HeaderText="UBICACION" 
                                                                                            UniqueName="column8" Display="False">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="30%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="DESCRIPCION" HeaderText="DESCRIPCION" 
                                                                                            UniqueName="column9" Display="False">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="30%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />                                                                                        
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center"></ItemStyle>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ibtnEliminar" OnClientClick='return confirm("¿Desea Eliminar este registro?");' runat="server" CommandName="Eliminar" SkinID="IBtnEliminarGrid" ToolTip="Eliminar" CausesValidation="False" Visible='<%# Convert.ToBoolean(Eval("estadoactualizar")) %>'/>
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
                                                                        <asp:Image ID="Image1" runat="server" SkinID="ImgLeyendaGrid" /></td></tr>
                                                                </table>
                                                            </asp:Panel>    
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width:900px" valign="top">
                                                            <asp:Panel ID="PnlNuevoRegistro" runat="server" Width="900px" Visible="true">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="900" runat="server" id="TblRegistro" visible="false" class="NuevoGrid" >
                                                                <tr>
                                                                    <td style="height: 19px"><a href="javascript:labelvisible('txtayuda1')"><asp:Image id="ImgBtnAyuda" runat="server" SkinID="ImgAyuda" ImageAlign="Right"></asp:Image></a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="SingleParagraph" Font-Bold="True" Font-Names="Arial" Font-Size="10px" HeaderText="Por favor complete los siguientes campos:" Width="80%" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" /></td>
                                                                </tr>

                                                                <tr>
                                                    	            <td valign="top">
                                                        	            <table cellpadding="0" cellspacing="0" border="0" width="900" class="FormularioMantenedores">
                                                            	            <tr>
                                                                	            <td width="10" style="width:10px; height:20px"></td>
                                                                                <td width="134" style="width:134px">
                                                                                    <asp:HiddenField ID="hddistatusprocedure" runat="server" Value="0" />
                                                                                </td>
                                                                                <td width="10" style="width:10px"></td>
                                                                                <td width="354">&nbsp;
                                                                                </td>
                                                                                <td width="10" style="width:10px"></td>
                                                                                <td width="108" style="height: 24px; width: 115px;">&nbsp;</td>
                                                                                <td width="242" style="width:10px"></td>
                                                                                <td width="15">&nbsp;</td>
                                                                                <td width="17">&nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                	            <td style="height:24px"></td>
                                                                                <td valign="top" align="left" class="obligatorio" 
                                                                                    style="height: 24px; width: 115px;">Codigo sistema</td>
                                                                                <td style="height: 24px">
                                                                                    </td>
                                                                                <td valign="top" align="left" style="height: 24px; width: 354px;">
                                                                                    <asp:TextBox ID="Txtcodigosistema" runat="server" SkinID="TextBoxCorto"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Txtcodigosistema"
                                                                                        ErrorMessage="Codigo." Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Txtcodigosistema"
                                                                                        Display="Dynamic" ErrorMessage="Formato no valido solo caracteres en nombre sistema"
                                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                <td style="height: 24px"></td>
                                                                                <td align="left" style="height: 24px; width: 115px;" valign="top" class="obligatorio" >
                                                                                    <label ID="LblAyuda2" class="ayuda" style="display:none">
                                                                                    Ingrese el nombre del sistema, la que permite al administrador asignar a un 
                                                                                    usuario al sistema correspondiente.
                                                                                    </label>
                                                                                    Version</td>
                                                                                <td style="height: 24px"></td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    <asp:TextBox ID="Txtversionsistema" runat="server" SkinID="TextBoxCorto"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Txtversionsistema"
                                                                                        ErrorMessage="Version." Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="Txtversionsistema"
                                                                                        Display="Dynamic" ErrorMessage="Formato no valido solo caracteres en nombre sistema"
                                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">
                                                                                    </td>
                                                                                <td valign="top" align="left" class="obligatorio" 
                                                                                    style="height: 24px; width: 115px;">Nombre sistema</td>
                                                                                <td style="height: 24px">
                                                                                    </td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <asp:TextBox ID="Txtnombresistema" runat="server" SkinID="TextBoxlargo"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Txtnombresistema"
                                                                                        ErrorMessage="Nombre." Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Txtnombresistema"
                                                                                        Display="Dynamic" ErrorMessage="Formato no valido solo caracteres en nombre sistema"
                                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td style="height: 24px"></td>
                                                                                <td align="left" style="height: 24px; width: 115px;" valign="top" class="obligatorio" >
                                                                                    Autor</td>
                                                                                <td style="height: 24px"></td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    <asp:TextBox ID="Txtautorsistema" runat="server" SkinID="TextBoxlargo"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Txtautorsistema"
                                                                                        ErrorMessage="Autor." Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="Txtautorsistema"
                                                                                        Display="Dynamic" ErrorMessage="Formato no valido solo caracteres en nombre sistema"
                                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">&nbsp;
                                                                                    </td>
                                                                                <td align="left" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Base de datos</td>
                                                                                <td style="height: 24px">&nbsp;
                                                                                    </td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <asp:TextBox 
                                                                                        ID="Txtbasedatossistema" runat="server" SkinID="TextBoxCorto"></asp:TextBox>
                                                                                </td>
                                                                                <td style="height: 24px">&nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 115px;" valign="top" class="obligatorio" >
                                                                                    Fecha Ingreso</td>
                                                                                <td style="height: 24px">&nbsp;</td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    <telerik:RadDatePicker ID="Txtcalendarsistema" Runat="server" 
                                                                                        AutoPostBack="False" Culture="es-ES" MaxDate="3000-12-31" MinDate="1970-01-01">
                                                                                        <calendar ID="Calendar1" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar>
                                                                                        <DateInput AutoPostBack="True" DateFormat="dd/MM/yyyy" 
                                                                                            DisplayDateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                                                            <EmptyMessageStyle Resize="None" />
                                                                                            <ReadOnlyStyle Resize="None" />
                                                                                            <FocusedStyle Resize="None" />
                                                                                            <DisabledStyle Resize="None" />
                                                                                            <InvalidStyle Resize="None" />
                                                                                            <HoveredStyle Resize="None" />
                                                                                            <EnabledStyle Resize="None" />
                                                                                        </DateInput>
                                                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                                                    </telerik:RadDatePicker>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                                                        ControlToValidate="Txtcalendarsistema" Display="Dynamic" ErrorMessage="Fecha.">*</asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">&nbsp;
                                                                                    </td>
                                                                                <td align="left"  style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Descripcion</td>
                                                                                <td style="height: 24px">&nbsp;
                                                                                    </td>
                                                                                <td align="left" style="height: 24px; width: 354px;" valign="top">
                                                                                    <asp:TextBox ID="Txtdescripcionsistema" runat="server" Columns="40" Rows="3" 
                                                                                        TextMode="MultiLine" SkinID="TextBoxDetalles"></asp:TextBox>
                                                                                </td>
                                                                                <td style="height: 24px">&nbsp;</td>
                                                                                <td align="left" style="height: 24px; width: 115px;" valign="top">
                                                                                    Ubicacion</td>
                                                                                <td style="height: 24px">&nbsp;</td>
                                                                                <td align="left" style="height: 24px" valign="top">
                                                                                    <asp:TextBox ID="Txtubicacionsistema" runat="server" SkinID="TextBoxlargo"></asp:TextBox>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                            <tr>
                                                                	            <td colspan="6" style="height:10px"></td>
                                                                	            <td style="height:10px">&nbsp;</td>
                                                                                <td style="height:10px">&nbsp;
                                                                                    </td>
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
                                                                                    <asp:ImageButton ID="IbtnBorrar" runat="server" SkinID="IBtnBorrar" OnClick="IbtnBorrar_Click" /></td>
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
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
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
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
