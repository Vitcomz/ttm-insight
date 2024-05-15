<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="sgm_tipos_paradas.aspx.cs" Inherits="Insight.ttm_sgm.Administracion.sgm_tipos_paradas" 
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
                                                                            <div class="ContTitLiBx">Administrador Tipo Paradas</div>
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
                                                                                        <td style="height: 24px" align="center" valign="top">Tipo Equipo</td>
                                                                                        <td align="left" valign="top">
                                                                                            <telerik:RadComboBox ID="CmbTipoEQfiltro" runat="server" AutoPostBack="True" 
                                                                                                CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                                Skin="Default" Sort="Ascending" Width="190px">
                                                                                            </telerik:RadComboBox>
                                                                                        </td>
                                                                                        <td align="center" valign="top">Tipo</td>
                                                                                        <td align="left" valign="top">
                                                                                            <asp:DropDownList ID="CblTipoFallafiltro" runat="server" skinID="listamediano">
                                                                                                <asp:ListItem Value="">[--Seleccionar--]</asp:ListItem>
                                                                                                <asp:ListItem Value="FO">FALLA OPERACIONAL</asp:ListItem> 
                                                                                                <asp:ListItem Value="OP">OPERACIONAL PROGRAMADA</asp:ListItem> 
                                                                                                <asp:ListItem Value="FM">FALLA MTTO MECANICO</asp:ListItem>
                                                                                                <asp:ListItem Value="FE">FALLA MTTO ELECTRICO</asp:ListItem>
                                                                                                <asp:ListItem Value="FI">FALLA MTTO INSTRUMENTAL</asp:ListItem>
                                                                                                <asp:ListItem Value="FG">FALLA MTTO GENERAL</asp:ListItem>
                                                                                                <asp:ListItem Value="MP">MTTO PROGRAMADO</asp:ListItem>
                                                                                                <asp:ListItem Value="RS">RESERVA</asp:ListItem>
                                                                                                <asp:ListItem Value="ST">STANDBY</asp:ListItem>
                                                                                                <asp:ListItem Value="MI">MINA</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td align="center" valign="top">Estado</td>
                                                                                        <td align="left" valign="top">
                                                                                            <asp:DropDownList ID="CblEstadotipo_paradafiltro" runat="server" skinID="listamediano">
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
                                                    	        	                    <asp:ImageButton runat="server" ID="IBtnNuevoRegistro" SkinID="IBtnNuevoGrid" OnClick="IBtnNuevoRegistro_Click" />&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LBtnNuevoRegistro" Text="AGREGAR NUEVO TIPO PARADA" SkinID="LBtnNuevoRegistro" OnClick="LBtnNuevoRegistro_Click" CausesValidation="False"></asp:LinkButton>
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
                                                                                        <telerik:GridBoundColumn DataField="ID" HeaderText="Codigo" 
                                                                                            UniqueName="column2">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="descripcion" HeaderText="Tipo Parada" 
                                                                                            UniqueName="column3">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="35%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="TIP_EQ_DESC"  HeaderText="Tipo Equipo"
                                                                                            UniqueName="column4">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="FALLAS"  HeaderText="Tipo Falla"
                                                                                            UniqueName="column5">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="TIPO_EQUIPO"  HeaderText="Tipo Equipo"
                                                                                            UniqueName="column6" Visible="false">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="TIPO_FALLA"  HeaderText="Tipo Falla"
                                                                                            UniqueName="column7" Visible="false">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="20%" />
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
                                                        	            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="FormularioMantenedores">
                                                            	            <tr>
                                                                	            <td style="height:20px" colspan="11">
                                                                                    <asp:HiddenField ID="hddistatusprocedure" runat="server" Value="0" />
                                                                                    &nbsp; &nbsp; &nbsp; &nbsp; </td>
                                                                            </tr>
                                                                            <tr>
                                                                	            <td style="height:24px"></td>
                                                                                <td valign="top" align="left" class="obligatorio" 
                                                                                    style="height: 24px;">Codigo Tipo Parada</td>
                                                                                <td style="height: 24px">
                                                                                    </td>
                                                                                <td valign="top" align="left" style="height: 24px; width: 174px;">
                                                                                    <asp:TextBox ID="Txtcodigotipo_parada" runat="server" SkinID="TextBoxCorto"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Txtcodigotipo_parada"
                                                                                        ErrorMessage="Codigo." Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Txtcodigotipo_parada"
                                                                                        Display="Dynamic" ErrorMessage="Formato no valido solo numero en Codigo tipo parada"
                                                                                         ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                <td style="height: 24px; width:30px"></td>
                                                                                <td align="left" style="height: 24px; width: 115px;" valign="top" class="obligatorio" >
                                                                                    Descripcion</td>
                                                                                <td style="height: 24px"></td>
                                                                                <td align="left" style="height: 24px; " valign="top" colspan="3">
                                                                                    <asp:TextBox ID="Txtnombretipo_parada" runat="server" SkinID="TextBoxlargo"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Txtnombretipo_parada"
                                                                                        ErrorMessage="Nombre." Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Txtnombretipo_parada"
                                                                                        Display="Dynamic" ErrorMessage="Formato no valido solo caracteres en Descripcion"
                                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td align="left" style="height: 24px" valign="top">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height:24px">&nbsp;
                                                                                    
                                                                                </td>
                                                                                <td align="left" class="obligatorio" style="height: 24px;" valign="top">
                                                                                    Tipo Equipo</td>
                                                                                <td style="height: 24px">&nbsp;
                                                                                    
                                                                                </td>
                                                                                <td align="left" style="height: 24px; width: 174px;" valign="top">
                                                                                    <telerik:RadComboBox ID="CmbTipoEQ" runat="server" DataTextField="description" DataValueField="value" 
                                                                                        Skin="Default" Sort="Ascending" Width="190px">
                                                                                    </telerik:RadComboBox>
                                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="CmbTipoEQ"
                                                                                        Display="Dynamic" ErrorMessage="Seleccione Tipo Equipo" Operator="NotEqual" ValueToCompare="[--Seleccionar--]">*</asp:CompareValidator>
                                                                                </td>
                                                                                <td style="height: 24px">&nbsp;
                                                                                    
                                                                                </td>
                                                                                <td align="left" class="obligatorio" style="height: 24px; width: 115px;" 
                                                                                    valign="top">
                                                                                    Tipo Falla</td>
                                                                                <td style="height: 24px">&nbsp;
                                                                                    
                                                                                </td>
                                                                                <td align="left" style="height: 24px; " valign="top" colspan="3">
                                                                                    <telerik:RadComboBox ID="CblTipoFalla" runat="server" Skin="Default" 
                                                                                        Sort="Ascending" Width="190px" >
                                                                                    </telerik:RadComboBox>
                                                                                    <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                                                                        ControlToValidate="CblTipoFalla" Display="Dynamic" 
                                                                                        ErrorMessage="Seleccione Tipo Equipo" Operator="NotEqual" 
                                                                                        ValueToCompare="[--Seleccionar--]">*</asp:CompareValidator>
                                                                                    &nbsp;
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
                                                                                <td style="height:10px">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                    	            <td style="width:900px" valign="top">                                                        	<table cellpadding="0" cellspacing="0" border="0" style="width:100%">
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
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" UpdatePanelCssClass=""  LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnActivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" UpdatePanelCssClass=""  LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"  LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" UpdatePanelCssClass=""  LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" UpdatePanelCssClass=""  LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrar">
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
