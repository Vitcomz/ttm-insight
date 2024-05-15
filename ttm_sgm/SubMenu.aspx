<%@ Page Language="C#" MasterPageFile="~/ttm_skins/ttm_template.Master"  AutoEventWireup="true" CodeBehind="SubMenu.aspx.cs" Inherits="Insight.sgm.SubMenu" StyleSheetTheme="ttm" Theme="ttm" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/ttm_skins/ttm_template.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="../ttm_skins/css/jslide/royalslider.css" rel="stylesheet" type="text/css"/>






<script src="../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../ttm_js/jslide/jquery.royalslider.min.js" type="text/javascript"></script>
<script src="../ttm_js/jquery.jorbital.js" type="text/javascript"></script>
<link href="../ttm_skins/css/jslide/rs-default.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="../ttm_skins/css/colorbox.css" type="text/css" />
<script src="../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script>



<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td valign="top">
            <asp:HiddenField ID="hddwinwidth" runat="server" />
            <asp:HiddenField ID="hddwinheight" runat="server" />
            <asp:Panel ID="PanelLayoutFaena" runat="server">
                <div class="content-slider-bg" runat="server" id="content_slider">
                    <div id="content-slider-1" class="royalSlider contentSlider rsDefault">
                        <div>
                            <div id="holder" align="left" style="position:absolute; height:100%; width:100%"  runat ="server" >
                	            <div id="zone_moviles1"  runat ="server" >
                    	            <ul id="moviles1"></ul>
                                </div>
                                <div id="imagin"  style="position:absolute; width:100%"  runat ="server" ><img id="x2x1" /></div>
                                    <dl class="map" id="idMap1">
                                        <dt><a onclick="verOT('semilla');" class="polLnk" id="semilla" target="_blank"></a></dt>
                                        <dd id="pol1Title"></dd>
                                    </dl>
                            </div>
	                        <span class="rsTmb">Planta 1</span>
                        </div>
            
                        <div>
                            <div id="holder2" align="left" style="position:absolute; height:100%; width:100%"  runat ="server" >
                	            <div id="zone_moviles2"  runat ="server" ><ul id="moviles2"></ul></div>
                                <div id="imagin2"  style="position:absolute; width:100%"  runat ="server" ><img id="x2x2" /></div>
                                    <dl class="map" id="idMap2">
                                        <dt><a onclick="verOT('semilla');" class="polLnk" id="semilla2" target="_blank"></a></dt>
                                        <dd id="pol1Title2"></dd>
                                    </dl>
                            </div>
	                        <span class="rsTmb">Planta 2</span>
                        </div>
            
                    </div>
                </div>    
                            
            </asp:Panel>
            <asp:Panel ID="PanelLayoutEquipo" runat="server">
                <div id="holderEq" align="left" style="position:absolute; width:100%"  runat ="server" >
                    <div id="imaginEq"  style="position:absolute; width:100%"  runat ="server" ><img id="x2x1Eq" src="" alt="" /></div>
                    <dl class="map" id="idMapEq">
                            <dt><a onclick="verOT('semilla');" class="polLnk" id="semillaEq" target="_blank"></a></dt>
                            <dd id="pol1TitleEq"></dd>
                        </dl>
                </div>
                <div id="ajaxdiv" style="width:750px; height:500px; overflow:auto; border:1px solid black; padding: 10px; background:#D9FAFF; visibility:hidden; z-index:50;"></div>
            </asp:Panel>
        </td>
    </tr>
</table>
<SCRIPT>
    function loadrisk(Equipo, subEquipo) {
        var url = "http://www.ttminsight.cl/sgm/detalleInspecciones2.asp?EQUIPO='" + Equipo + "'&DT=1&SUB_EQUIPO='" + subEquipo + "'&VTZ=" + Math.random();
        alwaysOnTop.init({
            targetid: 'ajaxdiv',
            orientation: 1,
            position: [10, 100],
            fadeduration: [1000, 1000],
            frequency: 0.95,
            hideafter: 30000
        })
        jQuery.get(url, {}, function (data) {
            jQuery('#ajaxdiv').html(data);
            //alert(data);
        });
    }

    function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1);
        var sURLVariables = sPageURL.split('&');
        for (var i = 0; i < sURLVariables.length; i++) {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam) {
                return sParameterName[1];
            }
        }
    }

    var faena = "<%= Session["emp"].ToString().ToUpper() %>";
    if (faena == "CERRO COLORADO") {
        jQuery(document).ready(function ($) {
            // Please note that autoHeight option has some conflicts with options like imageScaleMode, imageAlignCenter and autoScaleSlider
            // it's recommended to disable them when using autoHeight module
            $('#ajaxdiv').hide();
            $('#content-slider-1').royalSlider({
                autoHeight: false,
                arrowsNav: false,
                fadeinLoadedSlide: false,
                controlNavigationSpacing: 0,
                controlNavigation: 'tabs',
                imageScaleMode: 'none',
                navigateByClick: false,
                imageAlignCenter: true,
                loop: false,
                loopRewind: true,
                numImagesToPreload: 2,
                keyboardNavEnabled: true,
                usePreloader: false,
                slidesSpacing: 0
            });
            $("#moviles1").empty().append("<li><img src='../images/ajax-loader.gif' alt='Loading' /></li>");
            $.ajax({
                url: "../xml/eq_moviles.asp?RECURSO=listTrenGroupScreen&FAENA=" + faena + "&PLANTA=PLANTA-1&Z=" + Math.random(),
                success: function (html) {
                    $("#moviles1").empty().append(html);
                },
                error: function () {
                    $('#moviles1').append('<li>Error</li>');
                }
            });
            $("#moviles2").empty().append("<li><img src='../images/ajax-loader.gif' alt='Loading' /></li>");
            $.ajax({
                url: "../xml/eq_moviles.asp?RECURSO=listTrenGroupScreen&FAENA=" + faena + "&PLANTA=PLANTA-2&Z=" + Math.random(),
                success: function (html) {
                    $("#moviles2").empty().append(html);
                },
                error: function () {
                    $('#moviles2').append('<li>Error</li>');
                }
            });
        });
        (function ($) {
            $(window).load(function () {
                $("#moviles1").mCustomScrollbar({
                    horizontalScroll: true,
                    advanced: {
                        autoExpandHorizontalScroll: true,
                        updateOnContentResize: true
                    },
                    scrollButtons: {
                        enable: true
                    },
                    theme: "dark-thin",
                    set_height: "90px",
                    set_width: "96%"
                });
                $("#moviles2").mCustomScrollbar({
                    horizontalScroll: true,
                    advanced: {
                        autoExpandHorizontalScroll: true,
                        updateOnContentResize: true
                    },
                    scrollButtons: {
                        enable: true
                    },
                    theme: "dark-thin",
                    set_height: "90px",
                    set_width: "96%"
                });
            });

        })(jQuery);

        $('#zone_moviles1').show();
        $('#zone_moviles2').show();
        $('#holder2').show();

    } else {
        $('#ctl00_ContentPlaceHolder1_zone_moviles1').hide();
        $('#ctl00_ContentPlaceHolder1_zone_moviles2').hide();
        $('#holder2').hide();

    }
    //        $('#CH3A-CVT-A-CIN0lnk').wheelmenu({trigger: 'hover', animation: 'fly', animationSpeed: 'fast', angle: 'all'}); 
    //        $('#CH3A-CVT-A-CHU1lnk').wheelmenu({trigger: 'hover', animation: 'fly', animationSpeed: 'fast', angle: 'all'}); 
    //        $('#CH3A-CVT-A-PCAR2lnk').wheelmenu({trigger: 'hover', animation: 'fly', animationSpeed: 'fast', angle: 'all'}); 
    //        $('#CH3A-CVT-A-RAS3lnk').wheelmenu({trigger: 'hover', animation: 'fly', animationSpeed: 'fast', angle: 'all'});

    if (window.outerWidth) {
        deltaW = window.outerWidth - window.innerWidth;
        deltaH = window.outerHeight - window.innerHeight;
    } else {
        deltaW = 18;
        deltaH = 110; //110; modificado
    }

    var lados = 400;
    var parmtrs = getUrlParameter('streq');
    lados = 0;
    if (parmtrs == undefined) {
        CheckAdjustScreenGral();       
        //window.setTimeout('CheckAdjustScreenGral()',200); 
    } else {
        CheckAdjustScreen();
        //window.setTimeout('CheckAdjustScreen()',400);
    }
        
    function CheckAdjustScreenGral() {
        

        if ($(window).height() == 1080) {
            $("#ctl00_ContentPlaceHolder1_x2x1").css("height", ($(window).height() / 100) * 92 + 'px');
        } else if ($(window).height() > 1082) {
            $("#ctl00_ContentPlaceHolder1_x2x1").css("height", ($(window).height() / 100) * 93.5 + 'px');
        } else if ($(window).height() > 900 && $(window).height() < 1080) {
            $("#ctl00_ContentPlaceHolder1_x2x1").css("height", ($(window).height() / 100) * 87.6 + 'px');
        } else if ($(window).height() < 900) {
            $("#ctl00_ContentPlaceHolder1_x2x1").css("height", ($(window).height() / 100) * 82 + 'px'); 	//88
            //lados = lados - 400;
        }

        //var ancho = ($(window).width()); //  - lados
        var ancho = (($(window).width() / 100) * 100);
        lados = 0;
        var ladosx = 0;
        //ladosx = ($(window).width() - $("#ctl00_ContentPlaceHolder1_x2x1").css("width").replace('px', ''));
        if ($(window).width() > 1500){
            ladosx = ($(window).width() - 1500)/2 ;
        }else{
            ladosx = (1500 - $(window).width())/2 ;
        }
        //ladosx = ($(window).width() * 0.10);
        lados = ladosx;
        
        $("#ctl00_ContentPlaceHolder1_x2x1").css("height", ($(window).height() - 124) + 'px');
        $("#ctl00_ContentPlaceHolder1_x2x1").css("width", ($(window).width() - (ladosx * 2)) + 'px');
        $("#ctl00_ContentPlaceHolder1_imagin").css("padding-left", ladosx + 'px');
        $("#ctl00_ContentPlaceHolder1_imagin").css("padding-right", ladosx + 'px');
        

        $("#ctl00_ContentPlaceHolder1_hddwinwidth").val($("#ctl00_ContentPlaceHolder1_x2x1").css("width").replace('px', ''));
        $("#ctl00_ContentPlaceHolder1_hddwinheight").val($("#ctl00_ContentPlaceHolder1_x2x1").css("height").replace('px', ''));

        //$("#content-slider-1").css('paddingLeft', lados + 'px');

        //alert($(window).width() + 'x' + $(window).height() + '<--->' + $("#ctl00_ContentPlaceHolder1_x2x1").css("width") + ' ' + $("#ctl00_ContentPlaceHolder1_x2x1").css("height"));
        //alert($(window).width() + 'x'  + $(window).height()  + '<--->'  + $("#ctl00_ContentPlaceHolder1_x2x1").css("width").replace('px', '') + 'x' + $("#ctl00_ContentPlaceHolder1_x2x1").css("height").replace('px', ''));
        var screenw = $("#ctl00_ContentPlaceHolder1_x2x1").css("width").replace('px', '');
        var screenh = $("#ctl00_ContentPlaceHolder1_x2x1").css("height").replace('px', '');
//        $(function () {
//            $(".share-button").jOrbital({ inDuration: 300, radius: 1.5 });
//        });

         var wporc = ((screenw*100)/1500)/100;
         var hporc = ((screenh*100)/950)/100;
         var xalt = 25; //236;
         var walt = 180;//200;
        $('#ctl00_ContentPlaceHolder1_x2x1')
	    .load(function(){
            $("[name='IMGLAYOUT']").preload(function(perc, done) {
              //console.log(this, perc, done);
            });

            $(".share-button").delay(2500).each(function (index, value) { //.delay(2000)
                
                    var style = $(this).attr('style').split(';');
                    var tops = style[1].replace('top:', '').replace('%', '');
                    var lefts = style[0].replace('left:', '').replace('%', '');
                    //alert(lefts);
                    //console.log($(this).children('a').children("[name='IMGLAYOUT']"));

//                        var childwitdh = $(this).children('a').children().css("width").replace('px', '');
//                        var childheight = $(this).children('a').children().css("height").replace('px', '');
//                        $(this).css("left", (((($("#ctl00_ContentPlaceHolder1_x2x1").css("width").replace('px', '') ) * (lefts / 100)) + ladosx) + 'px') );
//                        $(this).css("top", (((($("#ctl00_ContentPlaceHolder1_x2x1").css("height").replace('px', '') ) * (tops / 100)) + xalt) + 'px') );
//                        var wi = (childwitdh * wporc);
//                        var hi = (childheight * hporc);
//                        $(this).children('a').children().css("width", wi + 'px');
//                        $(this).children('a').children().css("height", hi + 'px');
                        $(this).css("left", (((($("#ctl00_ContentPlaceHolder1_x2x1").css("width").replace('px', '') ) * (lefts / 100)) + ladosx) + 'px') );
                        $(this).css("top", (((($("#ctl00_ContentPlaceHolder1_x2x1").css("height").replace('px', '') ) * (tops / 100)) + xalt) + 'px') );

                    $(this).children('a').children("[name='IMGLAYOUT']").load(function(){
                        var childwitdh = $(this).css("width").replace('px', '');
                        var childheight = $(this).css("height").replace('px', '');
                        var wi = (childwitdh * wporc);
                        var hi = (childheight * hporc);
                        $(this).css("width", wi + 'px');
                        $(this).css("height", hi + 'px');
                        
                   })
                   .error(function(){
                        var link = $(this).attr("src");
                        var newPath= link.replace('http://www.ttminsight.cl/sgm/Chart/ly/','');
                        var arr = newPath.split('-');
                        //console.log(link);
		                $(this).attr("src", "http://www.ttminsight.cl/sgm/Chart/ly/icon_"+ arr[0] +"_800.png");
	               });
            });
        })
        .error(function(){
		    window.setTimeout('CheckAdjustScreenGral()',500);
	    });
    }

    function imgError(img) {
        var link = img.src;
        var newPath= link.replace('http://www.ttminsight.cl/sgm/Chart/ly/','');
        var arr = newPath.split('-');
        img.src = "http://www.ttminsight.cl/sgm/Chart/ly/icon_"+ arr[0] +"_800.png";
    }
     

    function CheckAdjustScreen() {
        $('#ctl00_ContentPlaceHolder1_x2x1Eq')
	    .load(function(){
            lados = 200;
            var ladosx = 0;
            var stylex;
            //var ancho = ($(window).width()); //  - lados
            var ancho = (($(window).width() / 100) * 100);
            //alert($(window).width() + ' ' + $("#ctl00_ContentPlaceHolder1_imaginEq").css("width").replace('px', ''));
            if (ancho > $("#ctl00_ContentPlaceHolder1_imaginEq").css("width").replace('px', '')) {
                ladosx = $(window).width() - $("#ctl00_ContentPlaceHolder1_imaginEq").css("width").replace('px', '');
                lados = ladosx / 2;
                $("#ctl00_ContentPlaceHolder1_imaginEq").css("height", ($(window).height() - 124) + 'px');
                $("#ctl00_ContentPlaceHolder1_PanelLayoutEquipo").css("height", ($(window).height() - 124) + 'px');
                $("#ctl00_ContentPlaceHolder1_imaginEq").css({'left': (lados) + 'px'});
                $(".cboxElement").each(function (index, value) {
                    if ($(this).children().attr('style') != undefined){
                        stylex = $(this).children().attr('style').split(';');
                        for(i=0;i<stylex.length-1;i++){
                            if (stylex[i].indexOf('top:') != -1){
                                var tops = stylex[i].replace('top:', '').replace('px', '');
                            }else if (stylex[i].indexOf('left:') != -1){
                                var lefts = parseInt(stylex[i].replace('left:', '').replace('px', ''));
                            }
                        }
                
                        $(this).children().css("left", (lefts + lados) + 'px');
                        //$(this).children('a').children().css("height", hi + 'px');
                    }
                });

            }
	    })
	    .error(function(){
		    window.setTimeout('CheckAdjustScreen()',600);
	    });

    }

    $.fn.preload = function (callback) {
      var length = this.length;
      var iterator = 0;

      return this.each(function () {
        var self = this;
        var tmp = new Image();

        if (callback) tmp.onload = function () {
          callback.call(self, 100 * ++iterator / length, iterator === length);
        };

        tmp.src = this.src;
      });
    };
</script>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="LinkClienteU">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkClienteA">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="BtPfClienteA" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfAdminA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfIspectorA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfCinternoA" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkAdminA">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="BtPfClienteA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfAdminA" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfIspectorA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfCinternoA" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkIspectorA">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="BtPfClienteA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfAdminA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfIspectorA" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfCinternoA" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkCinternoA">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="BtPfClienteA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfAdminA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfIspectorA" />
                    <telerik:AjaxUpdatedControl ControlID="BtPfCinternoA" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkClienteI">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkIspectorI">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkClienteC">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LinkCinternoC">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelMenu" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="link3">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFaenas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFotos" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelUpdateUsuario" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="link4">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFaenas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFotos" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelUpdateUsuario" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbFaenasFiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelComboEquipos" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFaenas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelNivelCentro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCerrarCambioFaena">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFaenas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnk7">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFaenas" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PanelCambiosFotos" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="PanelUpdateUsuario" 
                        LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</asp:Content>