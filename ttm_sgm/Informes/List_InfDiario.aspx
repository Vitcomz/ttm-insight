<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="List_InfDiario.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_InfDiario"  StyleSheetTheme="ttm" Theme="ttm"  %>
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
        var inf = document.getElementById("ctl00_ContentPlaceHolder1_Hddinforme").value;
        var resp = document.getElementById("ctl00_ContentPlaceHolder1_Hddresponsable").value;
        var fech = document.getElementById("ctl00_ContentPlaceHolder1_Hddfecha").value;
        var bit = document.getElementById("ctl00_ContentPlaceHolder1_Hddbitacoras").value;
        var alltime = document.getElementById("ctl00_ContentPlaceHolder1_Hddtime").value;
        var $tableBody2 = $('#ctl00_ContentPlaceHolder1_tabMedidas2');
        $tableBody2.html('<tbody></tbody>');
        var $tablebodyin = $('#ctl00_ContentPlaceHolder1_tabMedidas2').find("tbody");
        var $tableBody = $('#ctl00_ContentPlaceHolder1_CritDivCode').find("tbody");
        var allstr = "";
        $tableBody.find("[name='rowsdata']").each(function (i, tr) {
            var $sel = $(this).find("[id='8x']").val();
            var ot = $(this).find("[id='9x']").val();
            allstr = allstr + $sel + "-" + ot + "|";
        });
        var time;
        var alltime = time * 1500;
        var oManager = window.radopen("ReporteInspDiarioGenPdf.aspx?inf=" + inf + "&resp=" + resp + "&fech=" + fech + "&bit=" + bit + "&allstr=" + allstr, null);
        oManager.setSize(5, 5); //Width, Height
        oManager.center();
        oManager.SetActive();
        setTimeout(function () { oManager.close(); }, alltime);
    }

    function FromHTMLtoEXCEL() {
        var $tableBody2 = $('#ctl00_ContentPlaceHolder1_tabMedidas2');
        $tableBody2.html('<tbody></tbody>');
        var $tablebodyin = $('#ctl00_ContentPlaceHolder1_tabMedidas2').find("tbody");
        var $tableBody = $('#ctl00_ContentPlaceHolder1_CritDivCode').find("tbody");
        $tablebodyin.append("<tr><td>ID</td><td>FECHA</td><td>EQUIPO</td><td>COMPONENTE</td><td>OBSERVACION</td><td>CAUSA RAIZ</td><td>RECOMENDACION</td><td>CRITICIDAD 1SAP</td><td>AVISO/OT</td></tr>");
        $tableBody.find("[name='rowsdata']").each(function (i, tr) {
            var $sel = $(this).find("[id='8x']").val();
            var options = $(this).find("[id='8x']").find("option[value=" + $sel + "]").text();
            $trNew = "<tr><td>" + $(this).find("[id='1x']").html() + "</td><td>" + $(this).find("[id='2x']").html() + "</td><td>" + $(this).find("[id='3x']").html() + "</td><td>" + $(this).find("[id='4x']").html() + "</td><td>" + $(this).find("[id='5x']").html() + "</td><td>" + $(this).find("[id='6x']").html() + "</td><td>" + $(this).find("[id='7x']").html() + "</td><td>" + options.replace("<", "-") + "</td><td>" + $(this).find("[id='9x']").val() + "</td></tr>";
            //$('#dropdownId option:selected').html()
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
    isIE = document.all;
    isNN = !document.all && document.getElementById;
    isN4 = document.layers;
    isHot = false;

    function ddInit(e) {
        topDog = isIE ? "BODY" : "HTML";
        whichDog = isIE ? document.all.theLayer : document.getElementById("ctl00_ContentPlaceHolder1_RadWindow1");
        hotDog = isIE ? event.srcElement : e.target;
        while (hotDog.id != "titleBar" && hotDog.tagName != topDog) {
            hotDog = isIE ? hotDog.parentElement : hotDog.parentNode;
        }
        if (hotDog.id == "titleBar") {
            offsetx = isIE ? event.clientX : e.clientX;
            offsety = isIE ? event.clientY : e.clientY;
            nowX = parseInt(whichDog.style.left);
            nowY = parseInt(whichDog.style.top);
            ddEnabled = true;
            document.onmousemove = dd;
        }
    }

    function dd(e) {
        if (!ddEnabled) return;
        whichDog.style.left = isIE ? nowX + event.clientX - offsetx : nowX + e.clientX - offsetx;
        whichDog.style.top = isIE ? nowY + event.clientY - offsety : nowY + e.clientY - offsety;
        return false;
    }

    function ddN4(whatDog) {
        if (!isN4) return;
        N4 = eval(whatDog);
        N4.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP);
        N4.onmousedown = function (e) {
            N4.captureEvents(Event.MOUSEMOVE);
            N4x = e.x;
            N4y = e.y;
        }
        N4.onmousemove = function (e) {
            if (isHot) {
                N4.moveBy(e.x - N4x, e.y - N4y);
                return false;
            }
        }
        N4.onmouseup = function () {
            N4.releaseEvents(Event.MOUSEMOVE);
        }
    }

    function hideMe() {
        if (isIE || isNN) whichDog.style.visibility = "hidden"; 
        else if (isN4) document.theLayer.visibility = "hide";
    }

    function showMe() {
        if (isIE || isNN) whichDog.style.visibility = "visible";
        else if (isN4) document.theLayer.visibility = "show";
    }

    //if (document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value != 'C') {
    document.onmousedown = ddInit;
    document.onmouseup = Function("ddEnabled=false");
</script>
<script type="text/javascript">
    function checkAll(objRef) {

        var GridView = document.getElementById("ctl00_ContentPlaceHolder1_GridLectura");

        var inputList = GridView.getElementsByTagName("input");

        for (var i = 0; i < inputList.length; i++) {

            //Get the Cell To find out ColumnIndex

            var row = inputList[i].parentNode.parentNode;

            if (inputList[i].type == "checkbox" && objRef != inputList[i]) {

                if (objRef.checked) {

                    inputList[i].checked = true;

                }

                else {

                    inputList[i].checked = false;

                }

            }

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
                                                                            <div class="ContTitLiBx">Informe Diario Inspecciones</div>
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
                                                                                            <td valign="top" align="center"><strong>Informe Folio</strong></td>
                                                                                            <td align="left" valign="top">
                                                                                                <telerik:RadComboBox ID="cblfoliosfiltros" runat="server"  Height="220px" Width="120px"  DropDownWidth="330px"
                                                                                                     EmptyMessage="[-- Seleccione --]" EnableLoadOnDemand="true" 
                                                                                                     ShowMoreResultsBox="False" EnableVirtualScrolling="true" CssClass="field3" 
                                                                                                     Filter="Contains" LoadingMessage="Cargando..." MarkFirstMatch="True" 
                                                                                                     onitemdatabound="cblfoliosfiltros_ItemDataBound" 
                                                                                                     ondatabound="cblfoliosfiltros_DataBound" 
                                                                                                     onitemsrequested="cblfoliosfiltros_ItemsRequested" 
                                                                                                     ontextchanged="cblfoliosfiltros_TextChanged" 
                                                                                                     onselectedindexchanged="cblfoliosfiltros_SelectedIndexChanged" 
                                                                                                    AutoPostBack="True">
                                                                                                        <HeaderTemplate>
                                                                                                             <h2>INFORME DIARIOS</h2>
                                                                                                        </HeaderTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <table>
                                                                                                                <tr>
                                                                                                                    <td width="50px"><ul>
                                                                                                                       <li class="name"><span> <%# DataBinder.Eval(Container.DataItem, "description")%> </span>
                                                                                                                       <asp:HiddenField ID="hddfolio" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "IDS")%>' />
                                                                                                                       </li>
                                                                                                                  </ul></td><td width="100px"><ul>
                                                                                                                       <li class="name"><span> <%# DataBinder.Eval(Container.DataItem, "FECHA")%> </span></li>
                                                                                                                  </ul></td><td width="140px"><ul>
                                                                                                                       <li class="name"><span> <%# DataBinder.Eval(Container.DataItem, "RESPONSABLE")%> </span></li>
                                                                                                                  </ul></td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </ItemTemplate>
                                                                                                        <FooterTemplate>
                                                                                                            Total Folios: <asp:literal runat="server" id="RadComboItemsCount" />
                                                                                                       </FooterTemplate>
                                                                                                </telerik:RadComboBox>
                                                                                            </td>
                                                                                            <td><strong>Fecha</strong></td>
                                                                                            <td align="left">
                                                                                                <telerik:RadDatePicker ID="rddate1" runat="server" AutoPostBack="True" 
                                                                                                    onselecteddatechanged="rddate1_SelectedDateChanged">
                                                                                                    <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" 
                                                                                                        UseRowHeadersAsSelectors="False">
                                                                                                    </Calendar>
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
                                                                                            <strong>Responsable</strong></td>
                                                                                        <td align="left" valign="top">
                                                                                            <asp:Label ID="lblresponsable" runat="server" Text="Label"></asp:Label>
                                                                                            
                                                                                        </td>
                                                                                        <td width="150px" valign="top">
                                                                                            <strong>Bitacoras del Dia</strong>&nbsp;&nbsp;<asp:ImageButton ID="btnlectura0" runat="server" skinid="btnlectrura1" 
                                                                                onclick="btnlectura0_Click" CausesValidation="False"/></td>
                                                                                        <td align="left" width="300px" valign="top">
                                                                                            <asp:TextBox ID="txtbitdia" runat="server" Width="250px"></asp:TextBox>
                                                                                            <asp:ImageButton ID="btnsave" runat="server" skinid="btnlectrura4" 
                                                                                CausesValidation="False" onclick="btnsave_Click"/>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="4" style="height:10px"><asp:Panel ID="RadWindow1" 
                                                                                                    runat="server" style="position:absolute;z-index: 999;" Visible="False">
                                                                                                <table bgcolor="#0072C6" border="0" cellpadding="1" cellspacing="0" width="550">
                                                                                                    <tr>
                                                                                                        <td width="100%">
                                                                                                            <table border="0" cellpadding="4" cellspacing="0" height="36" width="100%">
                                                                                                                <tr>
                                                                                                                    <td ID="titleBar" style="" width="100%">
                                                                                                                        <ilayer onselectstart="return false" width="100%">
                                                                                                                            <layer onMouseout="isHot=false" 
                                                                                                                                onMouseover="isHot=true;if (isN4) ddN4(theLayer)" width="100%">
                                                                                                                                <font color="#FFFFFF" face="Arial" size="2">Bitacoras</font>
                                                                                                                            </layer>
                                                                                                                        </ilayer>
                                                                                                                    </td>
                                                                                                                    <td style="cursor:hand" valign="top">
                                                                                                                        <a href="#" onClick="hideMe();return false"><font color="#ffffff" face="arial" 
                                                                                                                            size="2" style="text-decoration:none">X</font></a>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td bgcolor="#FFFFFF" colspan="2"  style="padding:1px" width="100%">
                                                                                                                        Fecha <telerik:RadDatePicker ID="rddate2" runat="server" AutoPostBack="True" 
                                                                                                                            onselecteddatechanged="rddate2_SelectedDateChanged">
                                                                                                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" 
                                                                                                                                UseRowHeadersAsSelectors="False">
                                                                                                                            </Calendar>
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
                                                                                                </telerik:RadDatePicker>  Seleccionar todos <asp:CheckBox ID="ChkAll" runat="server" onclick="checkAll(this);" AutoPostBack="true" />
                                                                                                                    </td>
                                                                                                                    
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td bgcolor="#FFFFFF" colspan="2" style="padding:1px" width="100%">
                                                                                                                        <asp:GridView ID="GridLectura" runat="server" AllowPaging="True" 
                                                                                                                            AlternatingRowStyle-BackColor="#C2D69B" AutoGenerateColumns="False" 
                                                                                                                            BackColor="#0072C6" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
                                                                                                                            Font-Names="Arial" Font-Size="10pt" ForeColor="#333333" GridLines="None" 
                                                                                                                            HeaderStyle-BackColor="green" OnPageIndexChanging="OnPaging" PageSize="15" 
                                                                                                                            Width="99%" EmptyDataText="SIN DATOS A VISUALIZAR">
                                                                                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                                                                            <Columns>
                                                                                                                                <asp:TemplateField ShowHeader="False" ItemStyle-Width="20px">
                                                                                                                                    <ItemTemplate>
                                                                                                                                        <asp:CheckBox ID="Chk" runat="server" AutoPostBack="True" 
                                                                                                                                            oncheckedchanged="Chk_CheckedChanged" />
                                                                                                                                    </ItemTemplate>
                                                                                                                                </asp:TemplateField>
                                                                                                                                <asp:BoundField DataField="ID" HeaderText="Id" ItemStyle-Width="60px" 
                                                                                                                                    ShowHeader="False">
                                                                                                                                <ItemStyle Width="60px" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="FECHA" DataFormatString="{0:d}" HeaderText="Fecha" 
                                                                                                                                    ItemStyle-Width="90px" ShowHeader="False">
                                                                                                                                <ItemStyle Width="80px" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="EQUIPO" HeaderText="Componente" 
                                                                                                                                    ItemStyle-Width="100px" ShowHeader="False">
                                                                                                                                <ItemStyle Width="70px" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="CRITICIDAD" HeaderText="Criticidad" 
                                                                                                                                    ItemStyle-Width="70px" ShowHeader="False">
                                                                                                                                <ItemStyle Width="50px" />
                                                                                                                                </asp:BoundField>
                                                                                                                                <asp:BoundField DataField="OBSERVACIONES" HeaderText="Observaciones" ItemStyle-Width="160px" 
                                                                                                                                    ShowHeader="False">
                                                                                                                                <ItemStyle Width="50px" />
                                                                                                                                </asp:BoundField>
                                                                                                                                
                                                                                                                            </Columns>
                                                                                                                            <EditRowStyle BackColor="#999999" />
                                                                                                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                                                            <HeaderStyle BackColor="#0072C6" Font-Bold="True" ForeColor="White" />
                                                                                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                                                                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                                                                                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                                                                                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                                                                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                                                                                                        </asp:GridView>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <asp:HiddenField ID="swcheck" runat="server" />
                                                                                                </asp:Panel></td>
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
                                                                                            <asp:HiddenField ID="Hddinforme" runat="server" />
                                                                                            <asp:HiddenField ID="Hddresponsable" runat="server" />
                                                                                            <asp:HiddenField ID="Hddfecha" runat="server" />
                                                                                            <asp:HiddenField ID="Hddbitacoras" runat="server" />
                                                                                            <asp:HiddenField ID="Hddtime" runat="server" />
                                                                                            <asp:ImageButton ID="IbtnBuscar" runat="server" OnClick="IbtnBuscar_Click" SkinID="IBtnBuscar" CausesValidation="False"/>
                                                                                            <asp:ImageButton ID="IbtnBorrarBuscar" runat="server" 
                                                                                                OnClick="IbtnBorrarBuscar_Click" SkinID="IBtnBorrarBuacar" 
                                                                                                CausesValidation="False" />
                                                                                            <asp:ImageButton ID="IbtnPdf" runat="server" SkinID="IBtnPdf" CausesValidation="False"  onclientclick="FromHTMLtoPDF();"  Visible="False"/> <%--onclick="IbtnPdf_Click"  --%>
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
            <telerik:AjaxSetting AjaxControlID="btnlectura0">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadWindow1" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="GridLectura">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtbitdia" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rddate1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rddate2" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="GridLectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rddate2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rddate1" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="GridLectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="ChkAll" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="txtbitdia" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rddate1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rddate2" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>                       
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cblfoliosfiltros">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlZona" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>                        
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlZona" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting> 
            <telerik:AjaxSetting AjaxControlID="ChkAll">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtbitdia" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="GridLectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</asp:Content>
