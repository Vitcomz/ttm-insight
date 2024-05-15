<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List_GraficoCriticidad_auxiliar.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_GraficoCriticidad_auxiliar" StyleSheetTheme="ttm" Theme="ttm"%>

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
    <title>Grafico Criticidad</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />






</head>
<body>
    <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="FusionCharts.js"></script>
    <link type="text/css" href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" media="screen, projection" />
    <script src="../../ttm_js/facebox.js" type="text/javascript"></script>
    <link href="../../ttm_skins/css/facebox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script>
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
    <div style="width:900px; display:inline-block;">
    	
<!---- filtros ------>
	
	<div class="PlContFilt">
		<div class="PlContCell">
			<div class="PlFiltNom">Fecha de Consulta</div>
			<div class="PlFiltConsl">
                <telerik:RadComboBox ID="CmbFechCriticidadfiltro" runat="server" 
                                DataTextField="description" DataValueField="value" 
                            Skin="Default" CausesValidation="False" Sort="Ascending" Width="230px" 
                                AutoPostBack="True" DropDownWidth="280px" 
                                EmptyMessage="No hay fecha" Filter="Contains" Height="300px" 
                    onselectedindexchanged="CmbFechCriticidadfiltro_SelectedIndexChanged"></telerik:RadComboBox>
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
            <asp:Panel ID="PnlZonaGraficoCriticidad" runat="server" ScrollBars="Auto" Height="650px" Width="440px">
            </asp:Panel>

		</div>
		<div class="Der">
            <asp:Panel ID="PnlGrafico" runat="server" ScrollBars="Auto" Height="550px" Width="450px">
            </asp:Panel>
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
                    <telerik:AjaxUpdatedControl ControlID="PnlGrafico" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Literal1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbseccionhCriticidadfiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlZonaGraficoCriticidad" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlGrafico" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Literal1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>

</form>
</body>
</html>
