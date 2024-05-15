<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="List_InfParadas.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_InfParadas"  StyleSheetTheme="ttm" Theme="ttm"  %>
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
<script type="text/javascript" src="../../ttm_js/libs/base64.js"></script>
<script type="text/javascript" src="../../ttm_js/libs/sprintf.js"></script>
<%--<script type="text/javascript" src="../../ttm_js/jspdf.js"></script>--%>

<script type="text/javascript" src="../../ttm_js/jspdf.debug.js"></script>
<script type="text/javascript" src="../../ttm_js/tableExport.js"></script>
<script type="text/javascript" src="../../ttm_js/jquery.base64.js"></script>


<script type="text/javascript">
//    function FromHTMLtoPDF() {

//        var pdf = new jsPDF('p', 'pt', 'letter', true);
//        //        pdf.table(10, 10, null, null, {
//        //            left: 10,
//        //            top: 10,
//        //            bottom: 10,
//        //            width: 170,
//        //            autoSize: false,
//        //            printHeaders: true,
//        //            fontSize: 8
//        //        });
//        // source can be HTML-formatted string, or a reference
//        // to an actual DOM element from which the text will be scraped.
//        source = $('#ctl00_ContentPlaceHolder1_CritDivCode')[0];

//        // we support special element handlers. Register them with jQuery-style 
//        // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
//        // There is no support for any other type of selectors 
//        // (class, of compound) at this time.
//        specialElementHandlers = {
//            //            element with id of "bypass" - jQuery style selector

//            //            '#editor': function (element, renderer) {
//            //                // true = "handled elsewhere, bypass text extraction"
//            //                return true
//            //          }

//            '#ctl00_ContentPlaceHolder1_CritDivCode': function (element, renderer) {
//                return true;
//            }
//            //            '#bypassme': function (element, renderer) {
//            //                // true = "handled elsewhere, bypass text extraction"
//            //                return true
//            //            }
//        };

//        margins = {
//            top: 60,
//            bottom: 30,
//            left: 40,
//            width: 1000
//        };
//        // all coords and widths are in jsPDF instance's declared units
//        // 'inches' in this case
//        pdf.fromHTML(
//    source, // HTML string or DOM elem ref.
//    margins.left, // x coord
//    margins.top, { // y coord
//        'width': margins.width, // max width of content on PDF
//        'elementHandlers': specialElementHandlers
//    },

//    function (dispose) {
//        // dispose: object with X, Y of the last line add to the PDF 
//        //          this allow the insertion of new lines after html
//        pdf.save('Reporte_Componentes.pdf');
//    }, margins);
//        pdf.autoPrint();

//        //      $('#tabEquipos').tableExport({ type: 'pdf', escape: 'false' });  

//    }

    function FromHTMLtoPDF() {
        var eq = document.getElementById("ctl00_ContentPlaceHolder1_Hddequipo").value;
        var sec = document.getElementById("ctl00_ContentPlaceHolder1_Hddseccion").value;
        var tip = document.getElementById("ctl00_ContentPlaceHolder1_Hddtipo").value;
        var tipT = document.getElementById("ctl00_ContentPlaceHolder1_HddtipoT").value;
        var act = document.getElementById("ctl00_ContentPlaceHolder1_Hddact").value;
        var t1 = document.getElementById("ctl00_ContentPlaceHolder1_Hddt1").value;
        var t2 = document.getElementById("ctl00_ContentPlaceHolder1_Hddt2").value;

        var time = document.getElementById("ctl00_ContentPlaceHolder1_Hddtime").value;
        var alltime = time * 1500;
        var oManager = window.radopen("ReporteListParadasGenPdf.aspx?sec=" + sec + "&eq=" + eq + "&tip=" + tip + "&tipT=" + tipT + "&act=" + act + "&t1=" + t1 + "&t2=" + t2, null);
        oManager.setSize(5, 5); //Width, Height
        oManager.center();
        oManager.SetActive();
        setTimeout(function () { oManager.close(); }, alltime);
    }

    function FromHTMLtoEXCEL() {
        $('#tabEquipos').tableExport({ type: 'excel', escape: 'false' });
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
                                                                            <div class="ContTitLiBx">Informe Listado Paradas</div>
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
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" 
                                                                        class="filtroContenido" id="tblFiltro" runat="server">
                                                                        <tr id="Tr3" runat="server">
                                                                          <td id="Td3" valign="top" runat="server">
                                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%">
                                                                                    <tr>
                                                                                            <td style="width:11px"></td>
                                                                                            <td style="width:100px;">                                                                                            </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td style="width: 11px"></td>
                                                                                    </tr>
                                                                            </table>
                                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:700px">
                                                                              <tr>
                                                                                    <td style="width:11px"></td>
                                                                                    <td style="width:100px;"></td>
                                                                                    <td style="width:200px;"></td>
                                                                                    <td style="width: 89px"></td>
                                                                                    <td style="width: 89px">&nbsp;</td>
                                                                                    <td style="width: 89px">&nbsp;</td>
                                                                                    <td style="width: 89px">&nbsp;</td>
                                                                                  </tr>
                                                                                  <tr>
                                                                                    <td style="width: 11px"></td>
                                                                                    <td valign="top" align="center" style="height: 17px"><strong>Seccion</strong></td>
                                                                                    <td align="left" valign="top" style="height: 17px">
                                                                                        <telerik:RadComboBox ID="CmbSecParadafiltro" runat="server" AutoPostBack="True" 
                                                                                            CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                            onselectedindexchanged="CmbSecParadafiltro_SelectedIndexChanged" Skin="Default" 
                                                                                            Sort="Ascending" Width="190px">
                                                                                        </telerik:RadComboBox>
                                                                                      </td>
                                                                                    <td style="height: 17px"  align="center"><strong>Equipo</strong></td>
                                                                                    <td align="left" style="height: 17px">
                                                                                        <telerik:RadComboBox ID="CmbEqParadafiltro" runat="server" 
                                                                                            CausesValidation="False" DataTextField="description" DataValueField="value" 
                                                                                            onselectedindexchanged="CmbEqParadafiltro_SelectedIndexChanged" Skin="Default" 
                                                                                            Sort="Ascending" Width="230px">
                                                                                        </telerik:RadComboBox>
                                                                                      </td>
                                                                                    <td align="left" style="height: 17px">&nbsp;</td>
                                                                                    <td align="left" style="height: 20px">
                                                                                        <asp:DropDownList ID="CblEstadoParadasfiltro" runat="server" 
                                                                                            skinID="listamediano">
                                                                                            <asp:ListItem Value="">[--Seleccionar--]</asp:ListItem>
                                                                                            <asp:ListItem Value="ACT">Activo</asp:ListItem>
                                                                                            <asp:ListItem Value="INACT">Inactivo</asp:ListItem>
                                                                                            <asp:ListItem Value="ELI">Eliminado</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                      </td>
                                                                                  </tr>
                                                                                  <tr>
                                                                                    <td>&nbsp;</td>
                                                                                    <td style="height: 24px" align="center" valign="top"><strong>Desde</strong></td>
                                                                                    <td align="left" valign="top">
                                                                                        <telerik:RadDatePicker ID="rddate1" runat="server">
                                                                                        </telerik:RadDatePicker>
                                                                                      </td>
                                                                                    <td align="center" valign="top"><strong>Hasta</strong></td>
                                                                                    <td align="left" valign="top">
                                                                                        <telerik:RadDatePicker ID="rddate2" runat="server">
                                                                                        </telerik:RadDatePicker>
                                                                                      </td>
                                                                                    <td align="center" valign="top"><strong>Tipo Deteccion</strong></td>
                                                                                    <td align="left" valign="top">
                                                                                        <telerik:RadComboBox ID="CblTipoDetec" runat="server" AutoPostBack="True" 
                                                                                            DataTextField="description" DataValueField="value" DropDownWidth="250px" 
                                                                                            onselectedindexchanged="CblTipoDetec_SelectedIndexChanged" Skin="Default" 
                                                                                            Sort="Ascending" Width="220px">
                                                                                        </telerik:RadComboBox>
                                                                                      </td>
                                                                                  </tr>
                                                                                  <tr>
                                                                                    <td colspan="4" style="height:10px"></td>
                                                                                    <td style="height:10px">&nbsp;</td>
                                                                                    <td style="height:10px">&nbsp;</td>
                                                                                    <td style="height:10px">&nbsp;</td>
                                                                                  </tr>
                                                                                </table></td>
                                                                            <td id="Td4" style="width:150px" valign="top" runat="server">
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                    <tr>
                                                                                        <td style="height:10px"></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="height:40px" align="right" valign="top">
                                                                                            <asp:HiddenField ID="Hddseccion" runat="server" />
                                                                                            <asp:HiddenField ID="Hddequipo" runat="server" />
                                                                                            <asp:HiddenField ID="HddseccionT" runat="server" />
                                                                                            <asp:HiddenField ID="HddequipoT" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtipo" runat="server" />
                                                                                            <asp:HiddenField ID="HddtipoT" runat="server" />
                                                                                            <asp:HiddenField ID="Hddact" runat="server" />
                                                                                            <asp:HiddenField ID="Hddt1" runat="server" />
                                                                                            <asp:HiddenField ID="Hddt2" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtime" runat="server" />
                                                                                            <asp:ImageButton ID="IbtnBuscar" runat="server" OnClick="IbtnBuscar_Click" SkinID="IBtnBuscar" CausesValidation="False" />
                                                                                            <asp:ImageButton ID="IbtnBorrarBuscar" runat="server" OnClick="IbtnBorrarBuscar_Click" SkinID="IBtnBorrarBuacar" CausesValidation="False" />
                                                                                            <asp:ImageButton ID="IbtnPdf" runat="server" SkinID="IBtnPdf" onclientclick="FromHTMLtoPDF();"  CausesValidation="False"   Visible="False"/>
                                                                                            <asp:ImageButton ID="IbtnExcel" runat="server" SkinID="IBtnExcel" onclientclick="FromHTMLtoEXCEL();"  CausesValidation="False"   Visible="False"/>
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
                                                    	    <asp:Panel ID="PnlBuscar" runat="server" ScrollBars="Auto" Height="700px" Width="900px"></asp:Panel>    
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
        <%---------------------------------------parte de template ----------------------------------------------------------------%>
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
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
            <telerik:AjaxSetting AjaxControlID="CmbTipoEquipofiltro">
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
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
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
