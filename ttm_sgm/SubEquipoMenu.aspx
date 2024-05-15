<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubEquipoMenu.aspx.cs" Inherits="Insight.ttm_sgm.SubEquipoMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SubEquipos</title>






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link type="text/css" href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" media="screen, projection" />
    <script src="../../ttm_js/facebox.js" type="text/javascript"></script>
    <link href="../../ttm_skins/css/facebox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width:650px; display:inline-block;">
            <%--<div class="ContTopLiBx">
	            <div class="ContTitLiBx">Componentes en Riesgo</div>
	            <div class="LogoTTMLiBx"></div>
	            <div class="limpiar"></div>
            </div>--%>
            <div style="padding:20px 20px 20px 16px;" id="dataSubEquipos" runat="server">
            </div>
        </div>
    </form>	
</body>
</html>
