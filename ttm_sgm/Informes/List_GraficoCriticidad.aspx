<%@ Page Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="List_GraficoCriticidad.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_GraficoCriticidad" StyleSheetTheme="ttm" Theme="ttm"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">







    <script type="text/javascript" src="FusionCharts.js"></script>
    <%--
    
    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link type="text/css" href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" media="screen, projection" />
    <script src="../../ttm_js/facebox.js" type="text/javascript"></script>
    <link href="../../ttm_skins/css/facebox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script>--%>
    <script  type="text/javascript">
            function loadrisk(subEquipo){
        //    jQuery(document).ready(function($) {
        //	   $(".det_comp_riesgo").fadeIn("slow");
        //    })

        //	alwaysOnTop.init({
        //		targetid: 'ajaxdiv',
        //		orientation: 2,
        //		position: [20, 100],
        //		hideafter: 10000,
        //		externalsource: 'bc.htm'
        //	})
	        //$("#chartdiv3").hide();
	        var url ="/sgm/detalleInspecciones2.asp?EQUIPO='" + subEquipo + "'&VTZ=" + Math.random();
	        //window.open(url);
        //	var url = "/sgm/detalleInspecciones2.html?EQUIPO=40-CV-008&DT=1&SUB_EQUIPO=35CV001-PCAR&VTZ=0.7181835407363142"
	        alwaysOnTop.init({
		        targetid: 'ajaxdiv',
		        orientation: 1,
		        position: [10, 100],
		        fadeduration: [1000, 1000],
		        frequency: 0.95
		        //,hideafter: 60000
	        })
                //$(document).ready(function() {
        //			$("#ajaxdiv").load(url, function(response, status, xhr) {
        //			  if (status == "error") {
        //				var msg = "Sorry but there was an error: ";
        //				$("#error").html(msg + xhr.status + " " + xhr.statusText);
        //			  }
        //			});
			        jQuery.get(url, {}, function(data){
				        jQuery('#ajaxdiv').html(data);
			        });
                //});  	 alert(data);
        //	$.get(url, function(data){
        //                  $('#ajaxdiv').html(data);
        //     });
        }


        </script>
<script type="text/javascript" src="../../ttm_js/libs/base64.js"></script>
<script type="text/javascript" src="../../ttm_js/libs/sprintf.js"></script>
<%--<script type="text/javascript" src="../../ttm_js/jspdf.js"></script>--%>

<script type="text/javascript" src="../../ttm_js/jspdf.debug.js"></script>
<script type="text/javascript" src="../../ttm_js/tableExport.js"></script>
<script type="text/javascript" src="../../ttm_js/jquery.base64.js"></script>
<script type="text/javascript">

//   function FromHTMLtoPDF() {
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
//        source = $('.PlContList').html();

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

//            '.PlContList': function (element, renderer) {
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
//        pdf.save('Reporte_Grafico_Criticidad.pdf');
//    }, margins);
//        pdf.autoPrint();

//        //      $('#tabEquipos').tableExport({ type: 'pdf', escape: 'false' });  

//    }


    function FromHTMLtoEXCEL() {
//        var $tableBody2 = $('#ctl00_ContentPlaceHolder1_tabMedidas2');
//        $tableBody2.html('<tbody></tbody>');
//        var $tablebodyin = $('#ctl00_ContentPlaceHolder1_tabMedidas2').find("tbody");
//        var $tableBody = $('#ctl00_ContentPlaceHolder1_CritDivCode').find("[id='tbl_rows']").find("tbody");
//        $tablebodyin.append("<tr><td>ID</td><td>COMPONENTE</td><td>EQUIPO</td><td>DESC_COMPONENTE</td><td>DESC_EQUIPO</td><td>FECHA</td><td>DESCRIPCION</td><td>CRITICIDAD EQUIPO %</td><td>CRITI. COMPONENTE</td><td>AVISO/OT</td><td>RECOMENDACION</td><td>CAUSA RAIZ</td></tr>");
//        $tableBody.find("[name='rowsdata']").each(function (i, tr) {
//            $trNew = "<tr><td>" + $(this).find("[id='1x']").html() + "</td><td>" + $(this).find("[id='2x']").html() + "</td><td>" + $(this).find("[id='3x']").html().replace('EQUIPO : ', '') + "</td><td>" + $(this).find("[id='4x']").html() + "</td><td>" + $(this).find("[id='5x']").html() + "</td><td>" + $(this).find("[id='6x']").html() + "</td><td>" + $(this).find("[id='7x']").html() + "</td><td>" + $(this).find("[id='8x']").html() + "</td><td>" + $(this).find("[id='9x']").html() + "</td><td>" + $(this).find("[id='10x']").html() + "</td><td>" + $(this).find("[id='11x']").html() + "</td><td>" + $(this).find("[id='12x']").html() + "</td></tr>";
//            $tablebodyin.append($trNew);
//        });

        $('#basic-table').show();
        $('#basic-table').tableExport({ type: 'excel', escape: 'false' });
        $('#basic-table').css('display', 'none');
        //$tableBody2.html('<tbody></tbody>');

    }


</script>
<%--    <script src="../../ttm_js/jspdf.min.js" type="text/javascript"></script>
    <script src="../../ttm_js/jspdf.plugin.autotable.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        function FromHTMLtoPDF() {
            var sec = document.getElementById("ctl00_ContentPlaceHolder1_CmbseccionhCriticidadfiltro_Input").value;
            if (sec == "[ -- Todos -- ]") {
                sec = "";
            }
            var f1 = document.getElementById("ctl00_ContentPlaceHolder1_CmbFechCriticidadfiltro_Input").value;
            var alltime = 20000;
            var oManager = window.radopen("ReporteGrafCriticidadGenPdf.aspx?sec=" + sec + "&fech1=" + f1, null);
            oManager.setSize(5, 5); //Width, Height
            oManager.center();
            oManager.SetActive();
            setTimeout(function () { oManager.close(); }, alltime);
        }


</script>

    <div style="width:900px; display:inline-block;">
    <div class="ContTopLiBx">
	    <div class="ContTitLiBx">Informe de Criticidad</div>
	    <div class="LogoTTMLiBx"></div>
	    <div class="limpiar"></div>
    </div>
	
<!---- filtros ------>
	
	<div class="PlContFilt">
		<div class="PlContCell">
			<div class="PlFiltNom">Fecha de Consulta</div>
			<div class="PlFiltConsl">
                <telerik:RadComboBox ID="CmbFechCriticidadfiltro" runat="server" 
                                DataTextField="description" DataValueField="value" 
                            Skin="Default" CausesValidation="False" Sort="Ascending" Width="170px" 
                                AutoPostBack="True" DropDownWidth="170px" 
                                EmptyMessage="No hay fecha" Filter="Contains" Height="300px" 
                    onselectedindexchanged="CmbFechCriticidadfiltro_SelectedIndexChanged"></telerik:RadComboBox>
			</div>
            <div class="PlFiltNom">Seccion</div>
			<div class="PlFiltConsl"><telerik:RadComboBox ID="CmbseccionhCriticidadfiltro" runat="server" 
                                DataTextField="description" DataValueField="value" 
                            Skin="Default" CausesValidation="False" Sort="Ascending" Width="230px" 
                                AutoPostBack="True" 
                    onselectedindexchanged="CmbseccionhCriticidadfiltro_SelectedIndexChanged"></telerik:RadComboBox>
            </div>
            <div class="PlFiltConsl">
                    <asp:ImageButton ID="IbtnPdf" runat="server" SkinID="IBtnPdf" 
                        onclientclick="FromHTMLtoPDF();return false;"  />
                    <asp:ImageButton ID="IbtnExcel" runat="server" SkinID="IBtnExcel" 
                        onclientclick="FromHTMLtoEXCEL();return false;" CausesValidation="False" />
			</div>
		</div>
	</div>
		
<!---- lista detalle ------>

	<div class="PlContList">
		<div class="Izq" style="width:400px;">
			<div class="PlContTopDet" style="width:400px;">
				<div class="Izq" style="width:160px;">Equipo</div>
				<div class="Izq" style="width:120px; padding-left:5px;">Valor Criticidad</div>
				<div class="Izq" style="width:60px; padding-left:5px;">Criticidad</div>
				<div class="Izq" style="width:45px; padding-left:5px;">Acción</div>
			</div>
            <asp:Panel ID="PnlZonaGraficoCriticidad" runat="server" ScrollBars="Auto" Height="650px" Width="440px"></asp:Panel>
            <asp:Panel ID="PnlZonaGraficoCriticidadhidden" runat="server" ScrollBars="Auto" 
                Height="650px" Width="440px"></asp:Panel>
            <asp:Literal ID="Literal2" runat="server"></asp:Literal>
            <table ID="tabMedidas2" runat="server"  border="1" cellpadding="0" cellspacing="0" width="100%">
                <tbody></tbody>
            </table>
		</div>
		<div class="Der">
            <asp:Panel ID="PnlGrafico" runat="server" ScrollBars="Auto" Height="550px" Width="450px"></asp:Panel>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
		</div>
	</div>
    </br>
    </br>
    </br>

</div>

    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $('a[rel*=facebox]').facebox()
        })
    </script>	
    
<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="CmbFechCriticidadfiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlZonaGraficoCriticidad" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Literal2"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlGrafico" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="Literal1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbseccionhCriticidadfiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlZonaGraficoCriticidad" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Literal2"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlGrafico" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="Literal1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnPdf">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlZonaGraficoCriticidad" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Literal2"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlGrafico" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="Literal1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>

</asp:Content>