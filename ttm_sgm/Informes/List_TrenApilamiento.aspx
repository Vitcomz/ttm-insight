<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List_TrenApilamiento.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_TrenApilamiento" %>

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
    <div style="width:900px; display:inline-block; float:left;">
	    <div class="PlTit">DataSheet</div>
        <div class="PlContList">
		    <div style="padding-bottom:20px;" id="data_DataSheet" runat="server">
		    </div>
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
