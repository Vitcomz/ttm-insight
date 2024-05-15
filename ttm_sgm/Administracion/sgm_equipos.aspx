<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="sgm_equipos.aspx.cs" Inherits="Insight.ttm_sgm.Administracion.sgm_equipos" 
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
    window.blockConfirm = function (text, mozEvent, oWidth, oHeight, callerObj2, oTitle) {
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
                    if (callerObj2.click) callerObj2.click(); //Works fine every time in IE, but does not work for links in Moz
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
<script src="../../ttm_js/jqgalscroll.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#one').jqGalScroll({ width: 200, height: 200 });
    });
    function pageLoad() { // this gets fired when the UpdatePanel.Update() completes
        $('#one').jqGalScroll({ width: 200, height: 200 });
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
                                                   	  <td style="width:100%; height: 10px;" valign="top" colspan="2">
                                                        	<div class="ContTopLiBx">
                                                                            <div class="ContTitLiBx">Administrador Equipos</div>
	                                                                        <div class="LogoTTMLiBx"></div>
	                                                                        <div class="limpiar"></div>
                                                                        </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    	<td width="140" align="center" valign="top" >
                                                    	    <asp:Panel runat="server" ID="PnlFilto" Visible="true" BackColor="#666">
                                                            <table width="100px" border="0" cellspacing="0" cellpadding="0" runat="Server" id="TblFiltoCompleto" bgcolor="#666">
                                                              <tr>
                                                                <td style="width:100px">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo2">
                                                                      <tr>
                                                                        <th align="left" valign="middle">FILTRO DE EQUIPOS</th>
                                                                        <th style="height: 21px; width:200px" align="right" valign="top">
                                                                        </th>
                                                                      </tr>
                                                                    </table>
                                                                </td>
                                                              </tr>
                                                              <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="filtroContenido2" id="tblFiltro" runat="server">
                                                                        <tr>
                                                                            <td style="height:20px" >
                                                                                <telerik:RadComboBox ID="cblequiposfiltros" runat="server"  Height="300" Width="220"
                                                                                     EmptyMessage="[-- Seleccione Equipo --]" EnableLoadOnDemand="true" 
                                                                                    EnableVirtualScrolling="true" CssClass="field3" 
                                                                                     Filter="Contains" LoadingMessage="Cargando..." MarkFirstMatch="True" 
                                                                                     onitemdatabound="cblequiposfiltros_ItemDataBound" 
                                                                                     ondatabound="cblequiposfiltros_DataBound" 
                                                                                     onitemsrequested="cblequiposfiltros_ItemsRequested" 
                                                                                     ontextchanged="cblequiposfiltros_TextChanged" 
                                                                                     onselectedindexchanged="cblequiposfiltros_SelectedIndexChanged" 
                                                                                    AutoPostBack="True">
                                                                                        <HeaderTemplate>
                                                                                             <h2>Equipos</h2>
                                                                                        </HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                             <div class="imageWrap">
                                                                                                  <img src="<%# BuscarFotoEquipo(Eval("IMAGEURL").ToString()) %>" alt=" <%# DataBinder.Eval(Container, "value")%> " />
                                                                                             </div>
                                                                                             <div>
                                                                                                  <ul class="personDetails">
                                                                                                       <li class="name"><span> <%# DataBinder.Eval(Container, "value")%> </span></li>
                                                                                                       <li class="title"><span> <%# DataBinder.Eval(Container, "text")%> </span></li>
                                                                                                  </ul>
                                                                                             </div>
                                                                                        </ItemTemplate>
                                                                                        <FooterTemplate>
                                                                                            Total Equipos: <asp:literal runat="server" id="RadComboItemsCount" />
                                                                                       </FooterTemplate>
                                                                                </telerik:RadComboBox>
                                                                          </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height:20px" >&nbsp;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                            	<!--va el tree panel-->
                                                                                <telerik:RadTreeView ID="TreeEq1" runat="server" Height="710px" Width="230px" 
                                                                                    Font-Bold="True" Font-Names="Arial" Font-Size="11px" 
                                                                                    onnodeclick="TreeEq1_NodeClick" BackColor="#666666" ForeColor="White">
                                                                                 <DataBindings>
                                                                                    <telerik:RadTreeNodeBinding Expanded="True"></telerik:RadTreeNodeBinding>
                                                                                </DataBindings>
                                                                                </telerik:RadTreeView>
                                                                            </td>
                                                                        </tr>
                                                                        
                                                                  </table>
                                                                
                                                                </td>
                                                              </tr>
                                                            </table>
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="center" valign="top" >
                                                            <asp:Panel ID="PnlNuevoRegistro" runat="server" Visible="true">
                                                             <table cellpadding="0" cellspacing="0" border="0" runat="server" id="TblRegistro" class="NuevoGrid" >
                                                                 <tr>
                                                                    <td>
                                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo">
                                                                          <tr>
                                                                            <th align="left" valign="middle">INFORMACION EQUIPO</th>
                                                                            <th style="height: 21px; width:200px" align="right" valign="top">
                                                                            </th>
                                                                          </tr>
                                                                        </table>
                                                                    </td>
                                                                  </tr>
                                                                <tr>
                                                                    <td style="height: 19px"><a href="javascript:labelvisible('txtayuda1')"><asp:Image id="ImgBtnAyuda" runat="server" SkinID="ImgAyuda" ImageAlign="Right"></asp:Image></a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="SingleParagraph" Font-Bold="True" Font-Names="Arial" Font-Size="10px" HeaderText="Por favor complete los siguientes campos:" Width="80%" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" /></td>
                                                                </tr>

                                                                <tr>
                                                    	            <td valign="top" style="margin: 1px; padding: 1px 1px 1px 10px">
                                                        	            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="FormularioMantenedores">
                                                            	            <tr>
                                                                              <td width="10" style="height:24px"></td>
                                                                              <td colspan="11" align="left" valign="top" class="obligatorio" 
                                                                                    style="height: 24px; width: 115px;"><table  border="0" width="40%" cellpadding="1" cellspacing="1">
                                                                                <!--DWLayoutTable-->
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td width="107" align="left" valign="top">Codigo<span style="width:134px">
                                                                                    <asp:HiddenField ID="hddistatusprocedure" runat="server" Value="0" />
                                                                                  </span></td>
                                                                                  <td align="left" valign="top">Descripci&oacute;n</td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                  <td align="left" valign="top">Codigo GSAP</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">
                                                                                      <telerik:RadComboBox ID="cblEquipo" runat="server" AutoPostBack="True" 
                                                                                                    DropDownWidth="480" EmptyMessage="Ingrese Codigo y Nombres de Equipo" 
                                                                                                    EnableLoadOnDemand="True" Filter="Contains" Height="300" 
                                                                                                    HighlightTemplatedItems="true" LoadingMessage="Cargando....." 
                                                                                                    MarkFirstMatch="True" Width="150" CausesValidation="False" 
                                                                                          onitemsrequested="cblEquipo_ItemsRequested" 
                                                                                          onselectedindexchanged="cblEquipo_SelectedIndexChanged"
                                                                                          ontextchanged="cblEquipo_TextChanged">
                                                                                                    <headertemplate>
                                                                                                        <table cellpadding="0" cellspacing="0" style="width: 450px">
                                                                                                            <tr>
                                                                                                                <td style="width: 100px;">
                                                                                                                    Codigo
                                                                                                                </td>
                                                                                                                <td style="width: 200px;">
                                                                                                                    Descripcion
                                                                                                                </td>
                                                                                                                <td style="width: 150px;">
                                                                                                                    Seccion
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
                                                                                      <asp:HiddenField ID="hddEquiposelect" runat="server" />
                                                                                    </td>
                                                                                  <td colspan="2" align="left" valign="top"><asp:TextBox ID="TxtDescripcion" runat="server" Width="300px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtGSAP" runat="server" Width="120px"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">Ubicaci&oacute;n/Faena</td>
                                                                                  <td align="left" valign="top">Seccion</td>
                                                                                  <td colspan="2" align="left" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo de Equipo </td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><asp:HiddenField ID="ListFaenas" runat="server" />
                                                                                    <asp:Label ID="lblListFaenas" runat="server" Text="Label"></asp:Label></td>
                                                                                  <td colspan="3" align="left" valign="top">
                                                                                      <asp:HiddenField ID="hddseccionselec" runat="server" /><asp:HiddenField ID="hddtiposelec" runat="server" />
                                                                                      <telerik:RadComboBox ID="CmbSecciones" runat="server"  
                                                                                          CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                          Filter="Contains"  
                                                                                          Skin="Default" Sort="Ascending" Width="190px" 
                                                                                          onselectedindexchanged="CmbSecciones_SelectedIndexChanged" 
                                                                                          AutoPostBack="True"> </telerik:RadComboBox>
                                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                    <telerik:RadComboBox ID="CmbTipoEq" runat="server" CausesValidation="False" 
                                                                                          DataTextField="description" DataValueField="value" 
                                                                                          Filter="Contains" 
                                                                                          Skin="Default" Sort="Ascending" Width="200px" Height="250px"> </telerik:RadComboBox></td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">Estado</td>
                                                                                  <td align="left" valign="top">Fecha Ingreso</td>
                                                                                  <td colspan="2" align="left" valign="top">Secuencia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ultimo Cambio y/o Mantenci&oacute;n.</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><telerik:RadComboBox ID="ListEstado" runat="server" AppendDataBoundItems="True" 
                                                                                                    Width="120px">
                                                                                    <Items>
                                                                                      <telerik:RadComboBoxItem Text="ACTIVO" Value="ACT" Selected="True" />
                                                                                      <telerik:RadComboBoxItem Text="MANTENCION" Value="MAN" />
                                                                                      <telerik:RadComboBoxItem Text="REPARACION" Value="REP" />
                                                                                      <telerik:RadComboBoxItem Text="SINIESTRO" Value="REP" />
                                                                                    </Items>
                                                                                  </telerik:RadComboBox></td>
                                                                                  <td align="left" valign="top"><telerik:RadDatePicker ID="TxtFecha" Runat="server" Width="110px"> </telerik:RadDatePicker></td>
                                                                                  <td colspan="2" align="left" valign="top"><asp:TextBox ID="txtSecuencia" runat="server" Width="70px"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadDatePicker ID="txtFechaUltima" Runat="server" Width="110px"> </telerik:RadDatePicker></td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td colspan="2" align="left" valign="top">Proveedor</td>
                                                                                  <td colspan="2" align="left" valign="top">Equipo Superior</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td colspan="2" align="left" valign="top">
                                                                                    <asp:HiddenField ID="TxtRutProveedor" runat="server" />
                                                                                    <telerik:RadComboBox ID="cblproveedor" runat="server" Height="200" Width="260"
                                                                                          DropDownWidth="380" EmptyMessage="Seleccione un proveedor" HighlightTemplatedItems="true"
                                                                                          EnableLoadOnDemand="True" Filter="Contains"
                                                                                          onitemsrequested="cblproveedor_ItemsRequested" 
                                                                                          onselectedindexchanged="cblproveedor_SelectedIndexChanged" 
                                                                                          LoadingMessage="Cargando....." MarkFirstMatch="True" AutoPostBack="True" 
                                                                                          ItemsPerRequest="-1">
                                                                                          <HeaderTemplate>
                                                                                               <table style="width: 350px" cellspacing="0" cellpadding="0">
                                                                                                    <tr>
                                                                                                         <td style="width: 80px;">
                                                                                                              Rut
                                                                                                         </td>
                                                                                                         <td style="width: 270px;">
                                                                                                              Nombre Proveedor
                                                                                                         </td>
                                                                                                    </tr>
                                                                                               </table>
                                                                                          </HeaderTemplate>
                                                                                          <ItemTemplate>
                                                                                               <table style="width: 350px" cellspacing="0" cellpadding="0">
                                                                                                    <tr>
                                                                                                         <td style="width: 80px;">
                                                                                                              <%# DataBinder.Eval(Container, "Attributes['unitRUT']")%>
                                                                                                         </td>
                                                                                                         <td style="width: 270px;">
                                                                                                              <%# DataBinder.Eval(Container, "Attributes['unitNOMBRE']")%>
                                                                                                         </td>
                                                                                                    </tr>
                                                                                               </table>
                                                                                          </ItemTemplate>
                                                                                     </telerik:RadComboBox>
                                                                                    </td>
                                                                                  <td colspan="2" align="left" valign="top"><asp:HiddenField ID="TxtCodEquipoPadre" runat="server" />
                                                                                    <telerik:RadComboBox runat="server" ID="cblCodEquipoPadre" Height="190px" Width="280px"
                                                                                           EmptyMessage="[-- Seleccione --]" MarkFirstMatch="true" EnableLoadOnDemand="true"
                                                                                           HighlightTemplatedItems="true" 
                                                                                          LoadingMessage="Cargando..." DataValueField="CODIGO" 
                                                                                          DataTextField="DESC_COMP" AutoPostBack="True" 
                                                                                          onselectedindexchanged="cblCodEquipoPadre_SelectedIndexChanged"> </telerik:RadComboBox></td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><span class="style4">% Criticidad</span></td>
                                                                                  <td align="left" valign="top">Tipo Horometro</td>
                                                                                  <td align="left" valign="top">Ton. Hora</td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtCriticidad" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><span class="texto">
                                                                                    <telerik:RadComboBox ID="listTipoHr" runat="server" AppendDataBoundItems="True" 
                                                                                                    Width="120px">
                                                                                      <Items>
                                                                                        <telerik:RadComboBoxItem Text="[--Seleccionar--]" Value="" />
                                                                                        <telerik:RadComboBoxItem Text="SECUENCIAL" Value="SEC" />
                                                                                        <telerik:RadComboBoxItem Text="CRONOLOGICO" Value="CRO" />
                                                                                      </Items>
                                                                                    </telerik:RadComboBox>
                                                                                  </span></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtCapacidad" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">Ancho</td>
                                                                                  <td align="left" valign="top">Espesor Cubierta</td>
                                                                                  <td align="left" valign="top">Espesor Retorno</td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;Espesor Seguridad</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><span class="texto">
                                                                                      <asp:HiddenField ID="TxtCodHorometro" runat="server" Value="MOT" />
                                                                                    <asp:TextBox ID="txtAncho" runat="server" Width="120px"></asp:TextBox>
                                                                                  </span></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtEspesor" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtEspesorR" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;<asp:TextBox 
                                                                                          ID="txtEspesorSeg" runat="server" Width="120px"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">Marca</td>
                                                                                  <td align="left" valign="top">Modelo</td>
                                                                                  <td align="left" valign="top">Dimensiones</td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">
                                                                                    <input name="txtPorCriticidad" type="hidden"	class="input" />
                                                                                    <asp:HiddenField ID="txtCodMarca" runat="server" />
                                                                                    <telerik:RadComboBox ID="cblmarcas" runat="server" Height="200" Width="140"
                                                                                          DropDownWidth="380" EmptyMessage="Seleccione marca" HighlightTemplatedItems="true"
                                                                                          EnableLoadOnDemand="true" Filter="Contains"
                                                                                          LoadingMessage="Cargando....." MarkFirstMatch="True"
                                                                                          AutoPostBack="True" onitemsrequested="cblmarcas_ItemsRequested" 
                                                                                          onselectedindexchanged="cblmarcas_SelectedIndexChanged">
                                                                                          <HeaderTemplate>
                                                                                               <table style="width: 340px" cellspacing="0" cellpadding="0">
                                                                                                    <tr>
                                                                                                         <td style="width: 140px;">
                                                                                                              Codigo
                                                                                                         </td>
                                                                                                         <td style="width: 180px;">
                                                                                                              Nombre Marca
                                                                                                         </td>
                                                                                                    </tr>
                                                                                               </table>
                                                                                          </HeaderTemplate>
                                                                                          <ItemTemplate>
                                                                                               <table style="width: 340px" cellspacing="0" cellpadding="0">
                                                                                                    <tr>
                                                                                                         <td style="width: 140px;">
                                                                                                              <%# DataBinder.Eval(Container, "Attributes['unitCOD']")%>
                                                                                                         </td>
                                                                                                         <td style="width: 180px;">
                                                                                                              <%# DataBinder.Eval(Container, "Attributes['unitDESC']")%>
                                                                                                         </td>
                                                                                                    </tr>
                                                                                               </table>
                                                                                          </ItemTemplate>
                                                                                     </telerik:RadComboBox></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtModelo" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtDimensiones" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td colspan="4" align="left" valign="top"><hr /></td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">Fecha Instalaci&oacute;n</td>
                                                                                  <td align="left" valign="top">Dias Trabajados</td>
                                                                                  <td colspan="2" align="left" valign="top">Proxima Mantenci&oacute;n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Alarma Mantenci&oacute;n /<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Proyectada &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Escala 
</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><telerik:RadDatePicker ID="TxtFechaInstalacion" Runat="server" Width="110px"> </telerik:RadDatePicker></td>
                                                                                  <td align="left" valign="top"><span class="texto">
                                                                                    <asp:TextBox ID="TxtHorometroVen" runat="server" Width="120px"></asp:TextBox>
                                                                                    &nbsp;</span></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="TxtHorometroMan" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td valign="top">
                                                                                    <asp:TextBox ID="TxtHorometroAlarm" runat="server" Width="30px"></asp:TextBox>&nbsp;<telerik:RadComboBox 
                                                                                          ID="listEscalaAlr" runat="server" AppendDataBoundItems="True" Width="100px">
                                                                                      <Items>
                                                                                        <telerik:RadComboBoxItem Text="[-Seleccionar-]" Value="" />
                                                                                        <telerik:RadComboBoxItem Text="Horas" Value="H" />
                                                                                        <telerik:RadComboBoxItem Text="Dias" Value="D" />
                                                                                        <telerik:RadComboBoxItem Text="Meses" Value="M" />
                                                                                        <telerik:RadComboBoxItem Text="Años" Value="A" />
                                                                                      </Items>
                                                                                    </telerik:RadComboBox></td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top">Horometro / Ton. Actual</td>
                                                                                  <td align="left" valign="top">Vida Util</td>
                                                                                  <td align="left" valign="top">Ton. Prom. Semanal</td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td align="left" valign="top"><asp:TextBox ID="TxtHorometro" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtVidaUtil" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><asp:TextBox ID="txtTonSemanal" runat="server" Width="120px"></asp:TextBox></td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td colspan="2" rowspan="2" align="left" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabImages">
                                                                                    <tr>
                                                                                      <td height="23" valign="top"><font class="calibri">&nbsp;Vista</font></td>
                                                                                      <td valign="top">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td width="233" height="194">
                                                                                            <div id="DropZone1">
                                                                                                <ul id="one">
                                                                                                <asp:Literal ID="ltlone" runat="server">
			                                                                                        
                                                                                                </asp:Literal>
                                                                                                </ul>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td align="center" valign="top"><telerik:RadProgressManager runat="server" ID="RadProgressManager1" />
                                                                                            <telerik:RadAsyncUpload ID="AsyncUpload1" runat="server" 
                                                                                                        AllowedFileExtensions="jpg,jpeg,png" 
                                                                                                        MaxFileInputsCount="1" MaxFileSize="700000" 
                                                                                                        AutoAddFileInputs="False" Width="180px" 
                                                                                        onfileuploaded="AsyncUpload1_FileUploaded" 
                                                                                        PostbackTriggers="ibtnSubirfoto" InputSize="16" HideFileInput="True" 
                                                                                                TargetFolder="~/sgm/chart/ly" TemporaryFolder="~/files/Temporal">
                                                                                                        <Localization Cancel="Cancelar" DropZone="Arrastrar aqui" Remove="Borrar" 
                                                                                                            Select="Buscar" />
                                                                                                            <FileFilters>
                                                                                                                <telerik:FileFilter Description="Images(jpg;png)" Extensions="jpg,png" />
                                                                                                            </FileFilters>
                                                                                                    </telerik:RadAsyncUpload>
                                                                                            <asp:ImageButton ID="ibtnSubirfoto" runat="server" skinid="IBtnSubirfoto" CausesValidation="False" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                      <td valign="top">
                                                                                              <telerik:RadProgressArea runat="server" ID="RadProgressArea1" Culture="es-CL" />
                                                                                      </td>
                                                                                      <td valign="top">&nbsp;</td>
                                                                                    </tr>
                                                                                  </table></td>
                                                                                  <td align="right" valign="top"><span class="calibri">Observaciones</span></td>
                                                                                  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                                <tr align="center" class="rotulo"  >
                                                                                  <td colspan="2" align="right" valign="top">
                                                                                      <asp:TextBox ID="txtObservacion" runat="server" Columns="30" Height="191px" Rows="12" 
                                                                                          TextMode="MultiLine"></asp:TextBox>
                                                                                      </td>
                                                                                </tr>
                                                                                <tr>
                                                                                  <td height="27"  colspan="4" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                                </tr>
                                                                              </table></td>
                                                                              <td width="17" align="left" valign="top" style="height: 24px">&nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                              <td style="height:24px"></td>
                                                                              <td colspan="11" align="left" valign="top">
                                                                               <div class="ContTitLiBxFoot">
                                                                                 <asp:ImageButton ID="IbtnNuevo" runat="server" CausesValidation="False" 
                                                                                    OnClick="IbtnNuevo_Click" skinid="IBtnNuevo" style="height: 20px" />                                                                  
                                                                                <asp:ImageButton ID="IbtnGrabar" runat="server" OnClick="IbtnGrabar_Click" 
                                                                                      SkinID="IBtnGrabar" />                                                                                                                                                              
                                                                                  <asp:ImageButton ID="IbtnBorrar" runat="server" OnClick="IbtnBorrar_Click" 
                                                                                      SkinID="IBtnBorrar" />
                                                                               </div>
                                                                               </td>
                                                                              <td align="left" style="height: 24px" valign="top">&nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                              <td style="height:24px"></td>
                                                                              <td width="134" align="left" valign="top" class="obligatorio" 
                                                                                    style="height: 24px; width: 115px;">&nbsp;</td>
                                                                              <td width="10" style="height: 24px"></td>
                                                                              <td width="354" align="left" valign="top" style="height: 24px; width: 154px;">&nbsp;</td>
                                                                              <td width="10" style="height: 24px"></td>
                                                                              <td width="108" align="left" valign="top" class="obligatorio" style="height: 24px; width: 115px;" >&nbsp;</td>
                                                                              <td width="242" style="height: 24px">&nbsp;</td>
                                                                              <td width="15" align="left" valign="top" style="height: 24px; width: 354px;">&nbsp;</td>
                                                                              <td width="10" style="height: 24px"></td>
                                                                              <td width="15" align="left" 
                                                                                    valign="top" class="obligatorio" style="height: 24px; width: 115px;">&nbsp;</td>
                                                                              <td width="10" style="height: 24px"></td>
                                                                              <td width="15" align="left" valign="top" style="height: 24px; width: 354px;">&nbsp;</td>
                                                                              <td align="left" style="height: 24px" valign="top">&nbsp;</td>
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
                                                </table>
                                          </td>
                                            <td style="width:15px"></td>
                                        </tr>
                                    </table>

    <asp:Literal ID="ltlcodeslide" runat="server"></asp:Literal>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
          <script type="text/javascript">
          //<![CDATA[

              var fileList = null,
                    fileListUL = null;

              function fileUploaded(sender, args) {
                  var name = args.get_fileName();
                  fileList = document.getElementById("one");
                  li = document.createElement("li");
                  li.innerHTML = "<img src='~/sgm/Chart/ly/" + name + "' border='0'/>";
                  fileList.appendChild(li);
                  //"<li><img src='~/sgm/Chart/ly/" + Dsequipo.Tables[0].Rows[i]["LAYOUT"].ToString() + "' border='0'/></li>"
              }
          //]]>
          </script>
     </telerik:RadScriptBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>                                    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cblequiposfiltros">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TreeEq1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="TreeEq1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbSecciones">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cblCodEquipoPadre" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cblproveedor">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TxtRutProveedor" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cblCodEquipoPadre">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TxtCodEquipoPadre" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cblmarcas">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtCodMarca" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadScriptBlock1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TreeEq1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cblEquipo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnNuevo">
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
