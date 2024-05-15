<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/ttm_template.Master" AutoEventWireup="true" CodeBehind="sci_usuarios.aspx.cs" Inherits="Insight.sci.sci_usuarios" 
StylesheetTheme="ttm" Theme="ttm"%>
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
            document.getElementById("LblAyuda3").style.display = "none";
            document.getElementById("LblAyuda4").style.display = "none";
            document.getElementById("LblAyuda5").style.display = "none";
            document.getElementById("LblAyuda6").style.display = "none";
            document.getElementById("LblAyuda7").style.display = "none";
            document.getElementById("LblAyuda8").style.display = "none";
        } else {
            document.getElementById("LblAyuda2").style.display = "inline";
            document.getElementById("LblAyuda3").style.display = "inline";
            document.getElementById("LblAyuda4").style.display = "inline";
            document.getElementById("LblAyuda5").style.display = "inline";
            document.getElementById("LblAyuda6").style.display = "inline";
            document.getElementById("LblAyuda7").style.display = "inline";
            document.getElementById("LblAyuda8").style.display = "inline";
        }
    }
    function activar(identificador) {
        if (document.getElementById(identificador).style.display != "none") {
            document.getElementById(identificador).style.display = "none";
            document.getElementById("desactivar").style.display = "none";
            document.getElementById("activar").style.display = "inline";
        } else {
            document.getElementById(identificador).style.display = "inline";
            document.getElementById("desactivar").style.display = "inline";
            document.getElementById("activar").style.display = "none";
        }
    }//-->
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
    </style>
<table cellpadding="0" cellspacing="0" border="0" width="939">
                                    	<tr>
                                        	<td style="width:15px"></td>
                                        	<td valign="top" style="width:744px">
                                            	<table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                	<tr>
                                                    	<td style="width:900; height: 10px;" valign="top">
                                                        	<div class="ContTopLiBx">
                                                                            <div class="ContTitLiBx">Administrador Usuarios</div>
	                                                                        <div class="LogoTTMLiBx"></div>
	                                                                        <div class="limpiar"></div>
                                                                        </div>
                                                        </td>
                                                    </tr>
                                                    
                                                    
                                                    <tr>
                                                    	<td style="height:10px">
                                                    	    <asp:Panel runat="server" ID="PnlFilto" meta:resourcekey="PnlFiltoResource1">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" 
                                                                    id="TblFiltoCompleto">
                                                              <tr id="Tr1" runat="server">
                                                                <td id="Td1" style="width:900px; height:20px" runat="server">
                                                                    <table width="900" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo">
                                                                  <tr>
                                                                    <th align="left" valign="middle" style="width:700px">FILTRO DE BUSQUEDA</th>
                                                                    <th style="height: 21px; width:200px" align="right" valign="top">
                                                                    <asp:ImageButton runat="server" ID="IbtnDesactivar"  OnClick="IbtnDesactivar_Click" 
                                                                            SkinID="IBtnDesactivarFiltro" CausesValidation="False"  
                                                                            ToolTip="Desactivar filtro" style="height: 11px"  />
                                                                    <asp:ImageButton runat="server" ID="IbtnActivar" Visible="False" 
                                                                            OnClick="IbtnActivar_Click" SkinID="IBtnActivarFilto" CausesValidation="False" 
                                                                            ToolTip="Activar filtro" />
                                                                        </th>
                                                                  </tr>
                                                                </table></td>
                                                              </tr>
                                                              <tr id="Tr2" runat="server">
                                                                <td id="Td2" valign="top" runat="server">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" 
                                                                        class="filtroContenido" id="tblFiltro" runat="server">
                                                                        <tr id="Tr3" runat="server">
                                                                            <td id="Td3" valign="top" runat="server">
                                                                                <table border="0" cellpadding="0" cellspacing="0" style="width:100%">
                                                                                    <tr>
                                                                                            <td style="width:11px"></td>
                                                                                            <td style="width:120px; height:10px"></td>
                                                                                            <td></td>
                                                                                            <td style="width:120px;"></td>
                                                                                            <td></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td style="width: 11px"></td>
                                                                                            <td align="left" valign="top">Nombres</td>
                                                                                            <td align="left" valign="top">
                                                                                                <telerik:RadComboBox ID="cblusuario" runat="server" AutoPostBack="True" 
                                                                                                    DropDownWidth="480" EmptyMessage="Ingrese Codigo y Nombres de Usuario" 
                                                                                                    EnableLoadOnDemand="True" Filter="Contains" Height="200" 
                                                                                                    HighlightTemplatedItems="true" LoadingMessage="Cargando....." 
                                                                                                    MarkFirstMatch="True" onitemsrequested="cblusuario_ItemsRequested" 
                                                                                                    onselectedindexchanged="cblusuario_SelectedIndexChanged" Width="260" 
                                                                                                    CausesValidation="False">
                                                                                                    <headertemplate>
                                                                                                        <table cellpadding="0" cellspacing="0" style="width: 450px">
                                                                                                            <tr>
                                                                                                                <td style="width: 100px;">
                                                                                                                    ID Usuario
                                                                                                                </td>
                                                                                                                <td style="width: 200px;">
                                                                                                                    Nombres Usuario
                                                                                                                </td>
                                                                                                                <td style="width: 150px;">
                                                                                                                    Rol Usuario
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </headertemplate>
                                                                                                    <itemtemplate>
                                                                                                        <table cellpadding="0" cellspacing="0" style="width: 450px">
                                                                                                            <tr>
                                                                                                                <td style="width: 120px;">
                                                                                                                    <%# DataBinder.Eval(Container, "Attributes['unitCOD']")%>
                                                                                                                </td>
                                                                                                                <td style="width: 220px;">
                                                                                                                    <%# DataBinder.Eval(Container, "Attributes['unitDESC']")%>
                                                                                                                </td>
                                                                                                                <td style="width: 150px;">
                                                                                                                    <%# DataBinder.Eval(Container, "Attributes['unitCARG']")%>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </itemtemplate>
                                                                                                </telerik:RadComboBox>
                                                                                            </td>
                                                                                            <td style="height: 24px" valign="top" align="left">Usuario</td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="txtcodusuario" runat="server" skinid="TextBoxCorto"></asp:TextBox>
                                                                                                <asp:HiddenField ID="TxtNombreusuariofiltro" runat="server" />
                                                                                                <asp:HiddenField ID="TxtApellidousuariofiltro" runat="server" />

                                                                                            </td>
                                                                                            
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="width: 11px">&nbsp;
                                                                                            </td>
                                                                                        <td align="left" style="height: 24px" valign="top">
                                                                                            Rol </td>
                                                                                        <td align="left" valign="top">
                                                                                            
                                                                                            <telerik:RadComboBox ID="Cmbrolusuariofiltro" runat="server" 
                                                                                                CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                                Skin="Default" Sort="Ascending" Width="190px">
                                                                                            </telerik:RadComboBox>
                                                                                            
                                                                                        </td>
                                                                                        <td align="left" valign="top">
                                                                                            Estado</td>
                                                                                        <td><asp:DropDownList ID="CmbEstadousuariofiltro" runat="server" 
                                                                                                    skinID="listamediano">
                                                                                          <asp:ListItem Value="">[--Seleccionar--]</asp:ListItem>
                                                                                          <asp:ListItem Value="ACTIVO">Activo</asp:ListItem>
                                                                                          <asp:ListItem Value="INACTIVO">Inactivo</asp:ListItem>
                                                                                          <asp:ListItem Value="ELIMINADO">Eliminado</asp:ListItem>
                                                                                        </asp:DropDownList></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="5" style="height:10px"></td>
                                                                                     </tr>
                                                                                </table>
                                                                            </td>
                                                                            <td id="Td4" style="width:180px" valign="top" runat="server">
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="180">
                                                                                    <tr>
                                                                                        <td style="height:10px"></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="height:80px" align="right" valign="top">
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
                                                                    style="width:900px">
                                                    	    	
                                                    	        	<tr id="Tr4" runat="server">
                                                    	        	    <td id="Td5" style="width:900px" runat="server">
                                                    	        	        <table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    	        	            <tr>    
                                                    	        	                <td style="width:300px; height: 20px;" valign="top" align="left">
                                                    	        	                    <asp:ImageButton runat="server" ID="IBtnNuevoRegistro" SkinID="IBtnNuevoGrid" OnClick="IBtnNuevoRegistro_Click" CausesValidation="False"/>&nbsp;&nbsp;<asp:LinkButton runat="server" ID="LBtnNuevoRegistro" Text="AGREGAR NUEVO USUARIO" SkinID="LBtnNuevoRegistro" OnClick="LBtnNuevoRegistro_Click" CausesValidation="False"></asp:LinkButton>
                                                    	        	                </td>
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
                                                                            <telerik:radgrid id="RadGrid1" runat="server" AllowPaging="True" 
                                                                                AllowSorting="True" AutoGenerateColumns="False" CellPadding="1" CellSpacing="1" 
                                                                                GridLines="None" OnItemCommand="RadGrid1_ItemCommand" 
                                                                                OnSortCommand="RadGrid1_SortCommand" 
                                                                                OnPageIndexChanged="RadGrid1_PageIndexChanged" 
                                                                                OnPageSizeChanged="RadGrid1_PageSizeChanged" 
                                                                                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" ShowStatusBar="True" 
                                                                                Skin="Default">
                                                                                <MasterTableView CellPadding="1" CellSpacing="1" GridLines="Both" ShowFooter="True" DataKeyNames="id_usuario" PageSize="5">
                                                                                       <NoRecordsTemplate>
                                                                                         <div style="text-align:center;"><asp:Image runat="server" ID="ImgNoRecord" SkinID="ImgAlertGrid" /></div>
                                                                                       </NoRecordsTemplate>
                                                                                    <Columns>
                                                                                        <telerik:GridTemplateColumn AllowFiltering="False" ShowFilterIcon="False" 
                                                                                            UniqueName="TemplateColumn2">
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ibtnActualizar" runat="server" CausesValidation="false" Visible='<%# Convert.ToBoolean(Eval("estadoactualizar")) %>' 
                                                                                                    CommandName="Modificar" SkinID="IBtnActualizarGrid" ToolTip="Modificar" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn AllowFiltering="False" DataField="estado" 
                                                                                            HeaderText="Estado" UniqueName="column2">
                                                                                            <EditItemTemplate>
                                                                                                <asp:TextBox ID="estadoTextBox" runat="server" Text='<%# Bind("estado") %>'></asp:TextBox>
                                                                                            </EditItemTemplate>
                                                                                            <HeaderTemplate>
                                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                                                                    CommandArgument="estado_usuario" CommandName="Sort" SkinID="LBtnNuevoRegistro" 
                                                                                                    Width="40px">Estado</asp:LinkButton>
                                                                                            </HeaderTemplate>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="lbtnsemaforo" runat="server" CausesValidation="False"  
                                                                                                    ImageUrl='<%# bind("Icon") %>' CommandArgument='<%# bind("id_usuario") %>'  OnClientClick='return confirm("¿Desea cambiar el estado?");'  
                                                                                                    OnClick="lbtnsemaforo_click" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn DataField="id_usuario" HeaderText="Imagen" UniqueName="Upload"  AllowFiltering="False" >
                                                                                            <ItemTemplate>
                                                                                                <asp:Image ID="Imagen_usuario" runat="server" ImageUrl='<%# BuscarFoto(Eval("id_usuario").ToString()) %>' Height="60px" Width="60px"/>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridBoundColumn AllowFiltering="False" DataField="id_usuario" 
                                                                                            HeaderText="ID usuario" UniqueName="column5">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="30%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="nombre" HeaderText="Nombre" 
                                                                                            UniqueName="column11">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="40%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn AutoPostBackOnFilter="True" DataField="ROL" 
                                                                                            HeaderText="Rol" ShowFilterIcon="False" UniqueName="column3">
                                                                                            <HeaderStyle HorizontalAlign="Center" Width="40%" />
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </telerik:GridBoundColumn>
                                                                                        
                                                                                        <telerik:GridTemplateColumn AllowFiltering="False" UniqueName="TemplateColumn">
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ibtnEliminar" runat="server" CausesValidation="False" 
                                                                                                    CommandName="Eliminar" 
                                                                                                    OnClientClick="return confirm(&quot;¿Desea Eliminar este registro?&quot;);" 
                                                                                                    SkinID="IBtnEliminarGrid" ToolTip="Eliminar" Visible='<%# Convert.ToBoolean(Eval("estadoactualizar")) %>' />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                                                        </telerik:GridTemplateColumn>
                                                                                    </Columns>
                                                                                    <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" />
                                                                                </MasterTableView>
                                                                                <PagerStyle NextPageText="Siguiente" PrevPageText="Anterior" />
</telerik:radgrid></td>
                                                                    </tr>
                                                                    <tr id="Tr6" runat="server">
                                                                        <td id="Td7" style="height:10px" runat="server"></td>
                                                                    </tr>
                                                                    <tr id="Tr7" runat="server"><td id="Td8" align="right" valign="top" runat="server">&nbsp;
                                                                        </td></tr>
                                                                </table>
                                                            </asp:Panel>    
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height:32px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width:900px" valign="top">
                                                            <asp:Panel ID="PnlNuevoRegistro" runat="server" Width="900px" Visible="False">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="900" runat="server" id="TblRegistro" class="NuevoGrid" >
                                                                <tr id="Tr8" runat="server">
                                                                    <td id="Td9" style="height: 19px" runat="server"><a href="javascript:labelvisible('txtayuda1')">
                                                                        <asp:Image id="ImgBtnAyuda" runat="server" SkinID="ImgAyuda" ImageAlign="Right"></asp:Image></a></td>
                                                                </tr>
                                                                <tr id="Tr9" runat="server">
                                                                    <td id="Td10" runat="server">&nbsp;</td>
                                                                </tr>

                                                                <tr id="Tr10" runat="server">
                                                    	            <td id="Td11" valign="top" runat="server">
                                                        	            <table width="100%"  border="0" cellpadding="1" cellspacing="1">
                                                            <!--DWLayoutTable-->
                                                            <tr class="texto" >
                                                              <td width="130" align="right" valign="top">Usuario : </td>
                                                              <td align="left" valign="top" >
                                                                  <asp:Label ID="Lblid_usuario" runat="server" Font-Bold="True" Font-Names="Arial" 
                                                                      Font-Size="Small" Visible="False"></asp:Label>
                                                                  <asp:HiddenField ID="hddistatusprocedure" runat="server" Value="0" 
                                                                      Visible="False" />
                                                                  <asp:TextBox ID="TxtidUser" runat="server" skinid="TextBoxCorto"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" 
                                                                      ControlToValidate="TxtidUser" Display="Dynamic" ErrorMessage="Id usuario">*</asp:RequiredFieldValidator>
                                                                  <asp:RegularExpressionValidator ID="RegularExpressionValidator13" 
                                                                      runat="server" ControlToValidate="TxtidUser" Display="Dynamic" 
                                                                      ErrorMessage="Formato no valido solo caracteres y numeros en Id usuario, " 
                                                                      ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
                                                              </td>
                                                              <td width="110" align="right" valign="top" >Password : </td>
                                                              <td align="left" valign="top" >
                                                                  <asp:TextBox ID="Txtpass" 
                                                                      runat="server" skinid="TextBoxCorto"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                                                                        ControlToValidate="Txtpass" Display="Dynamic" ErrorMessage="clave usuario">*</asp:RequiredFieldValidator>
                                                              <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" 
                                                                        ControlToValidate="Txtpass" Display="Dynamic" 
                                                                        ErrorMessage="Formato no valido solo caracteres y numeros en cortaseña, " 
                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator></td>
                                                              <td rowspan="9" valign="top"><table width="200" height="89%" border="0" cellpadding="0" cellspacing="0" datapagesize="1"
                  id="tabImages">
                                                               
                                                                <tr>
                                                                    <td width="233" height="194" align="center" valign="top" >
                                                                        <table width="100%" border="0" cellpadding="1" cellspacing="2" bgcolor="#0072C6">
                                                                          <tr>
                                                                            <td align="center" valign="top">
                                                                                <asp:Panel ID="pnlview" runat="server" BackColor="#0072C6">
                                                                                <asp:ImageButton ID="btnimgphoto" runat="server" 
                                                                                        ImageUrl="~/ttm_skins/css/images/icon_people.png" onclick="btnimgphoto_Click" 
                                                                                        Width="180px" CausesValidation="False" />
                                                                                 
                                                                                </asp:Panel>                                                                            
                                                                            </td>
                                                                          </tr>
                                                                          <tr>
                                                                            <td align="left" valign="top">
                                                                                <asp:Panel ID="pnlupload" runat="server"  BackColor="#0072C6">
                                                                                <telerik:RadAsyncUpload ID="AsyncUpload1" runat="server" 
                                                                                                        AllowedFileExtensions="jpeg,jpg,png,gif,bmp" 
                                                                                                        MaxFileInputsCount="1" MaxFileSize="1048576" 
                                                                                                        AutoAddFileInputs="False" OnClientValidationFailed="validationFailed"
                                                                                        MultipleFileSelection="Automatic" Width="180px" 
                                                                                        onfileuploaded="AsyncUpload1_FileUploaded" 
                                                                                        PostbackTriggers="ibtnSubirfoto" InputSize="16" 
                                                                                        TargetFolder="~/Files/usuarios" TemporaryFolder="~/files/Temporal">
                                                                                                        <Localization Cancel="Cancelar" DropZone="Arrastrar aqui" Remove="Borrar" 
                                                                                                            Select="Buscar" />
                                                                                                            <FileFilters>
                                                                                                                <telerik:FileFilter Description="Images(jpeg;jpg;png;gif;bmp)" Extensions="jpeg,jpg,png,gif,bmp" />
                                                                                                            </FileFilters>
                                                                                                    </telerik:RadAsyncUpload>
                                                                                                    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                                                                                        <script type="text/javascript">
                                                                                                            //<![CDATA[
                                                                                                            var $ = $telerik.$;
                                                                                                            function validationFailed(radAsyncUpload, args) {
                                                                                                                var $row = $(args.get_row());
                                                                                                                var erorMessage = getErrorMessage(radAsyncUpload, args);
                                                                                                                var span = createError(erorMessage);
                                                                                                                $row.addClass("ruError");
                                                                                                                $row.append(span);
                                                                                                            }
        
                                                                                                            function getErrorMessage(sender, args) {
                                                                                                                var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
                                                                                                                if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
                                                                                                                    if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                                                                                                                        return ("El tipo de archivo no soporta.");
                                                                                                                    }
                                                                                                                    else {
                                                                                                                        return ("Imagen excede al tamaño maximo de 500 KB.");
                                                                                                                    }
                                                                                                                }
                                                                                                                else {
                                                                                                                    return ("Extension no permitida.");
                                                                                                                }
                                                                                                            }
        
                                                                                                            function createError(erorMessage) {
                                                                                                                var input = '<span class="ruErrorMessage">' + erorMessage + ' </span>';
                                                                                                                return input;
                                                                                                            }
                                                                                                         //]]>
                                                                                                        </script>
                                                                                                     </telerik:RadScriptBlock>
       																					 <asp:ImageButton ID="ibtnSubirfoto" runat="server" 
                                                                                        skinid="IBtnSubirfoto" CausesValidation="False" />     
                                                                              </asp:Panel>                                                                            
                                                                            </td>
                                                                          </tr>
                                                                        </table>
                                                                        
                                                                        
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td valign="top">&nbsp;</td>
                                                                </tr>
                                                              </table></td>
                                                            </tr>
                                                            <tr class="texto" >
                                                              <td height="22" align="right" valign="top">Nombres :</td>
                                                              <td align="left" valign="top" ><asp:TextBox ID="TxtNombreUsuario" runat="server" skinid="TextBoxlargo"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                                                                        ControlToValidate="TxtNombreUsuario" Display="Dynamic" ErrorMessage="Nombres">*</asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator10" 
                                                                        runat="server" ControlToValidate="TxtNombreUsuario" Display="Dynamic" 
                                                                        ErrorMessage="Formato no valido solo caracteres en Nombres, " 
                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator></td>
                                                              <td align="right" valign="top" >Apellidos :</td>
                                                              <td align="left" valign="top" >
                                                              <asp:TextBox ID="TxtApellidoUsuario" runat="server" skinid="TextBoxlargo"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                                                                        ControlToValidate="TxtApellidoUsuario" Display="Dynamic" 
                                                                        ErrorMessage="Apellidos">*</asp:RequiredFieldValidator>
                                                              <asp:RegularExpressionValidator ID="RegularExpressionValidator11" 
                                                                        runat="server" ControlToValidate="TxtApellidoUsuario" Display="Dynamic" 
                                                                        ErrorMessage="Formato no valido solo caracteres en Apellidos, " 
                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator></td>
                                                            </tr>
                                                            <tr class="texto" >
                                                              <td height="22" align="right" valign="top">RUT :</td>
                                                              <td align="left" valign="top" ><asp:TextBox ID="Txtrut" runat="server" 
                                                                      skinid="TextBoxCorto"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                                                                        ControlToValidate="Txtrut" Display="Dynamic" ErrorMessage="Rut usuario">*</asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" 
                                                                        ControlToValidate="Txtrut" Display="Dynamic" 
                                                                        ErrorMessage="Formato no valido solo numeros y guion medio en Rut, " 
                                                                        ValidationExpression=".*[0-9a-zA-Z-_@Á-Úá-ú-_@]+">*</asp:RegularExpressionValidator>
  &nbsp;Ej. 12666124-k </td>
                                                              <td align="right" valign="top" >E-Mail :</td>
                                                              <td align="left" valign="top" ><asp:TextBox ID="Txtemail" 
                                                                      runat="server" skinid="TextBoxlargo" TextMode="Email"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" 
                                                                        ControlToValidate="Txtemail" Display="Dynamic" 
                                                                        ErrorMessage="Email">*</asp:RequiredFieldValidator>
                                                              <asp:RegularExpressionValidator ID="RegularExpressionValidator12" 
                                                                        runat="server" ControlToValidate="Txtemail" Display="Dynamic" 
                                                                        ErrorMessage="Ingrese e-mail valido" 
                                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></td>
                                                              </tr>
                                                            <tr class="texto" >
                                                              <td height="27" align="right" valign="top">Fecha de Nacimiento : </td>
                                                              <td align="left" valign="top" ><span class="datos">
                                                                <input  name="BirthDate" type="hidden" datafld="FECHA_NAC" />
                                                                </span>
                                                                <telerik:RadDatePicker ID="TxtFecha3" Runat="server" Width="130px" 
                                                                      MaxDate="2199-12-31" MinDate="1900-01-01"> </telerik:RadDatePicker></td>
                                                              <td align="right" valign="top" >Sexo : </td>
                                                              <td align="left" valign="top" >
                                                              <asp:RadioButtonList ID="rdsexo" runat="server" RepeatColumns="2">
                                                                    <asp:ListItem Value="M" Selected="True">Masculino</asp:ListItem>
                                                                    <asp:ListItem Value="F">Femenino</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                            <tr class="texto" >
                                                              <td height="24" align="right" valign="top">Fono : </td>
                                                              <td align="left" valign="top" >
                                                                  <asp:TextBox ID="Txtfono" runat="server" skinid="TextBoxCorto" 
                                                                      TextMode="Phone"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                                                                      ControlToValidate="Txtfono" Display="Dynamic" ErrorMessage="Fono">*</asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                                        ControlToValidate="Txtrut" Display="Dynamic" 
                                                                        ErrorMessage="Formato no valido solo numeros en Fono, " 
                                                                        ValidationExpression="\d{9}">*</asp:RegularExpressionValidator></td>
                                                              <td align="right" valign="top" >Fono Movil :</td>
                                                              <td align="left" valign="top" ><asp:TextBox ID="Txtmovil" runat="server" skinid="TextBoxCorto" 
                                                                      TextMode="Phone"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                                      ControlToValidate="Txtmovil" Display="Dynamic" ErrorMessage="Fono Movil">*</asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                                                        ControlToValidate="Txtmovil" Display="Dynamic" 
                                                                        ErrorMessage="Formato no valido solo numeros en Fono Movil, " 
                                                                        ValidationExpression="\d{9}">*</asp:RegularExpressionValidator></td>
                                                            </tr>
                                                            <tr class="texto" >
                                                              <td height="22" align="right" valign="top">Empresa :</td>
                                                              <td align="left" valign="top" >
                                                                  <asp:Label ID="lblEmpresa" runat="server" Font-Bold="True" Font-Names="Arial" 
                                                                      Font-Size="Small" Text="TTM"></asp:Label>
                                                                  <asp:TextBox ID="TxtEmpresa" runat="server" skinid="TextBoxCorto" 
                                                                      TextMode="Phone" Visible="False"></asp:TextBox>
                                                                  <asp:HiddenField ID="hddempresa" runat="server" Value="TTM" />
                                                                </td>
                                                              <td align="right" valign="top" >Fecha Ingreso: 
                                                                </td>
                                                              <td><telerik:RadDatePicker ID="TxtFechaing" Runat="server" Width="130px" MaxDate="2199-12-31" MinDate="1900-01-01">
                                                              </telerik:RadDatePicker></td>
                                                              </tr>
                                                            <tr class="texto">
                                                              <td height="22" align="right" valign="top"> Lugar de Trabajo :</td>
                                                              <td align="left" valign="top" >
                                                                  <telerik:RadComboBox ID="cblFaenas" 
                                                                      Runat="server" DropDownWidth="250px" Filter="Contains" Height="220px" 
                                                                      MarkFirstMatch="True" CausesValidation="False">
                                                                  </telerik:RadComboBox>
                                                                  <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                                                      ControlToValidate="cblFaenas" Display="Dynamic" 
                                                                      ErrorMessage="Seleccione lugar trabajo" Operator="NotEqual" 
                                                                      ValueToCompare="[ -- Seleccionar -- ]">*</asp:CompareValidator>
                                                                </td>
                                                              <td align="right" valign="top" >Area :</td>
                                                              <td align="left" valign="top" ><asp:TextBox ID="txtcodarea" runat="server" Width="40px"></asp:TextBox>                                                              
                                                                  <telerik:RadComboBox ID="cblArea" Runat="server" Filter="Contains" 
                                                                      MarkFirstMatch="True" DropDownWidth="320px" 
                                                                      onselectedindexchanged="cblArea_SelectedIndexChanged" Width="180px" 
                                                                      CausesValidation="False" AutoPostBack="True"> </telerik:RadComboBox>
                                                                      <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                                                      ControlToValidate="cblArea" Display="Dynamic" 
                                                                      ErrorMessage="Seleccione Area" Operator="NotEqual" 
                                                                      ValueToCompare="[ -- Seleccionar -- ]">*</asp:CompareValidator></td>
                                                              </tr>
                                                            <tr class="texto">
                                                              <td height="24" align="right" valign="top">Rol de Sistema :</td>
                                                              <td align="left" valign="top" >
                                                                  <telerik:RadComboBox ID="cblrol" runat="server" 
                                                                      CausesValidation="False" DataTextField="description" 
                                                                      DataValueField="value" AllowCustomText="True" DropDownWidth="220px" 
                                                                      Filter="Contains" Height="220px" MarkFirstMatch="True">
                                                                  </telerik:RadComboBox>
                                                                  <asp:CompareValidator ID="CompareValidator5" runat="server" 
                                                                      ControlToValidate="cblrol" Display="Dynamic" 
                                                                      ErrorMessage="Seleccione Rol de sistema" Operator="NotEqual" 
                                                                      ValueToCompare="[ -- Seleccionar -- ]">*</asp:CompareValidator>
                                                                &nbsp;</td>
                                                              <td align="right" valign="top" >Cargo :</td>
                                                              <td align="left" valign="top" >
                                                                  <telerik:RadComboBox ID="cblCargos" 
                                                                      Runat="server"  DataTextField="description" DataValueField="value" 
                                                                      AllowCustomText="True" DropDownWidth="320px" Filter="Contains" Height="220px" 
                                                                      MarkFirstMatch="True" CausesValidation="False">
                                                                  </telerik:RadComboBox>
                                                                  <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                                                      ControlToValidate="cblCargos" Display="Dynamic" 
                                                                      ErrorMessage="Seleccione Cargo" Operator="NotEqual" 
                                                                      ValueToCompare="[ -- Seleccionar -- ]">*</asp:CompareValidator></td>
                                                              </tr>
                                                            <tr class="texto">
                                                              <td height="24" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                              <td colspan="1" align="left" valign="top" >Acceso Total DB.<asp:CheckBox ID="chkAccesoDB" runat="server" />
                                                                    Acceso Total Empresas <asp:CheckBox ID="chkAccesoEMP" runat="server"/>
                                                                    
                                                              </td>
                                                              <td align="right" valign="top" >Activo</td>
                                                              <td  align="left" valign="top">
                                                                  <asp:CheckBox ID="chkActivo" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr align="center" valign="middle">
                                                              <td height="22" colspan="6" valign="middle"><asp:ValidationSummary ID="ValidationSummary2" runat="server" 
                                                                        DisplayMode="SingleParagraph" Font-Bold="True" Font-Italic="False" 
                                                                        Font-Names="Arial" Font-Overline="False" Font-Size="10px" 
                                                                        Font-Strikeout="False" Font-Underline="False" 
                                                                        HeaderText="Por favor complete los siguientes campos:" Width="80%" /></td>
                                                              </tr>
                                                            <tr align="center" valign="middle">
                                                              <td valign="top" colspan="6">
                                                              <div class="ContTitLiBxFoot">
                                                                  <asp:ImageButton ID="IbtnNuevo" runat="server" CausesValidation="False" 
                                                                      OnClick="IbtnNuevo_Click" skinid="IBtnNuevo" style="height: 20px" />
                                                                  <asp:ImageButton ID="IbtnGrabar" runat="server" OnClick="IbtnGrabar_Click" 
                                                                        skinid="IBtnGrabar" CausesValidation="False" />                                                              
                                                                <asp:ImageButton ID="IbtnBorrar" runat="server" OnClick="IbtnBorrar_Click" 
                                                                        skinid="IBtnBorrar" CausesValidation="False" />
                                                               </div>
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
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnActivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnimgphoto">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlview" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="pnlupload" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="AsyncUpload1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlview" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="pnlupload" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="cblArea">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtcodarea" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
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
