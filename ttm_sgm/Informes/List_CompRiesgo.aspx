<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List_CompRiesgo.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_CompRiesgo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Componentes en Riesgo</title>






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link type="text/css" href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" media="screen, projection" />
    <script src="../../ttm_js/facebox.js" type="text/javascript"></script>
    <link href="../../ttm_skins/css/facebox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:900px; display:inline-block;">
        <div class="ContTopLiBx">
	        <div class="ContTitLiBx">Componentes en Riesgo</div>
	        <div class="LogoTTMLiBx"></div>
	        <div class="limpiar"></div>
        </div>
        <div style="padding:0px 20px 20px 16px;" id="dataCompRiesgos" runat="server">

        <!----------- INICIO COMP RIESGO ------------------->
	        <div class="ContDtllComp">
		        <div style="float:left; width:757px;">
			        <div class="ContDtllCompBgGr">
				        <div class="ContDtllCompNom">Equipo</div>
				        <div class="ContDtllCompDet TxtRj">Detalle</div>
				        <div class="ContDtllCompNom">Componente</div>
				        <div class="ContDtllCompDet TxtRj">Detalle</div>
			        </div>
			        <div class="ContDtllCompBgGr">
				        <div class="ContDtllCompNom">Fecha</div>
				        <div class="ContDtllCompDet TxtRj">Detalle</div>
				        <div class="ContDtllCompNom">Dias Pendientes</div>
				        <div class="ContDtllCompDet TxtRj">Detalle</div>
				        <div class="ContDtllCompNom">Criticidad</div>
				        <div class="ContDtllCompDet TxtRj">Detalle</div>			
			        </div>
			        <div class="ContDtllCompBgGr">
				        <div class="ContDtllCompNom">Observaciones</div>
				        <div class="ContDtllCompDet">Detalle</div>			
			        </div>
			        <div class="ContDtllCompBgGr">
				        <div class="ContDtllCompNom">Recomendación</div>
				        <div class="ContDtllCompDet">Detalle</div>
			        </div>
		        </div>
		        <div style="float:right; background-color:lime; width:100px; height:74px;">	
			        <img height="74" src="recursos/images/center/Img-CompRiesgo-02.png" width="100" />
		        </div>
		        <div class="limpiar"></div>
	        </div>
        <!----------- FIN COMP RIESGO ------------------->
        </div>
        </div>
    </form>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $('a[rel*=facebox]').facebox()
        })
    </script>	
</body>
</html>
