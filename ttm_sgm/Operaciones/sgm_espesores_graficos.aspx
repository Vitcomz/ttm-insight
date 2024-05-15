<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sgm_espesores_graficos.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_espesores_graficos" 
StylesheetTheme="ttm" Theme="ttm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="FusionCharts.js" type="text/javascript"></script>
    <link type="text/css" href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" media="screen, projection" />
</head>
<body>
<SCRIPT>


    function graph() {
        var folios = "";
        var tipo = "";
        var folio_ret = "";

        var tbl = window.parent.document.getElementById('ctl00_ContentPlaceHolder1_tabMedidas');
        //espesor = Math.ceil(parent.document.getElementById('ctl00_ContentPlaceHolder1_txtEspesor').value);
        
        //
        //				if(tbl.rows[i].children[0].children[1]&&tbl.rows[i].children[0].children[1].innerText == folio&&formulario.txt_seleccion.value == "C"){
        //				    index = i;
        //					break;
        //				}else if (tbl.rows[i].children[0].children[1]&&tbl.rows[i].children[0].children[2].innerText == folio&&formulario.txt_seleccion.value == "U"){
        //				    index = i;
        //					break;					
        //				}

        for (var i = 3; i < tbl.rows.length; i++) {
            if (tbl.rows[i].children[0].children[1]) {

                tipo = tbl.rows[i].children[0].children[3].innerText;

                if (tipo == 'CAR')
                    folios = folios + tbl.rows[i].children[0].children[2].innerText;
                else
                    folio_ret = tbl.rows[i].children[0].children[2].innerText;

                if (tbl.rows[i + 1] && tbl.rows[i + 1].children[0].children[3].innerText == 'CAR')
                    folios = folios + ",";


            }

        } //end for
        alert(tbl.rows.length);

        document.getElementById('hddFathertipos').value = tipo;
        document.getElementById('hddFatherfolios').value = folios;
        document.getElementById('hddFatherfoliosRet').value = folio_ret;
        document.getElementById('hddFatherespesor').value = Math.ceil(parent.document.getElementById('ctl00_ContentPlaceHolder1_txtEspesor').value);
        document.getElementById('hddFatherespesorRet').value = Math.ceil(parent.document.getElementById('ctl00_ContentPlaceHolder1_txtEspesorR').value);
    }


</SCRIPT>
    
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hddFathertipos" runat="server" />
    <asp:HiddenField ID="hddFatherfolios" runat="server" />
    <asp:HiddenField ID="hddFatherfoliosRet" runat="server" />
    <asp:HiddenField ID="hddFatherespesor" runat="server" />
    <asp:HiddenField ID="hddFatherespesorRet" runat="server" />
    <div style="width:100%; Height:340px; display:inline-block; float:left; overflow:auto;">
	    <%--<div class="ContTitLiBx">Lecturas</div></br>--%>
        <div class="PlContList">
		    <div id="data_lectura" runat="server" style="overflow:auto; font-size:small; font-family: MyriadPro-Cond,Helvetica,sans-serif; font-weight:bold;"></div>
	         
        </div>
        <%--<div style="float:right; margin-right: 20px;">
                 <asp:ImageButton ID="btnvisualizar" runat="server" onclick="btnvisualizar_Click" SkinID="btnvisualizar" />      
	    </div>--%>
    </div>
    </form>
</body>
</html>
