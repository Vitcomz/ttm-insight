<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sgm_espesores_lectura.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_espesores_lectura" 
StylesheetTheme="ttm" Theme="ttm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link type="text/css" href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" media="screen, projection" />
</head>
<body>
<SCRIPT>

//    function setCheck() {

//        var tbl = parent.document.getElementById('tabMedidas');
//        var tbl2 = document.getElementById('tabLect');

//        for (var i = 3; i < tbl.rows.length; i++) {
//            //alert(tbl.rows[i].children[0].children[1].innerText);
//            if (tbl.rows[i].children[0].children[1]) {
//                for (var j = 0; j < tbl2.rows.length; j++) {
//                    //alert(tbl2.rows[j].children[0].children[1].innerText + " " + tbl2.rows[j].cells[4].children[0].innerText);
//                    // tbl.rows[i].cells[0].children[0].value
//                    if (tbl.rows[i].cells[0].children[0].value == (tbl2.rows[j].children[0].children[1].innerText + tbl2.rows[j].cells[4].children[0].innerText)) {
//                        tbl2.rows[j].children[0].children[0].checked = true;
//                    } //end if
//                } // end for	
//            } //end if
//        } // end for

//    }


    function set(itr) {


        folio = itr.children[0].children[0].value;
        fecha = itr.children[2].innerHTML;
        equipo = itr.children[3].innerHTML;
        tipo = itr.children[5].children[0].value;
        total = itr.children[5].children[1].value;


        if (itr.children[0].children[0].checked) {
            //itr.children[0].children[0].checked=false;
            parent.getMedicion(folio, fecha, equipo, tipo, total);
        }else{
            //itr.children[0].children[0].checked=true;
            parent.delMedicion(folio, fecha, tipo);

        }


    }


</SCRIPT>
    <form id="form1" runat="server">
    <div style="width:100%; Height:340px; display:inline-block; float:left; overflow:auto;" class="ContTopLiBx">
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
