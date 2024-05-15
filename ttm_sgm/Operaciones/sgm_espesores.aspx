<%@ Page Title="" Language="C#" MasterPageFile="~/ttm_skins/1nivel/ttm_template_1nivel.Master" AutoEventWireup="true" CodeBehind="sgm_espesores.aspx.cs" Inherits="Insight.ttm_sgm.Operaciones.sgm_espesores" 
StylesheetTheme="ttm" Theme="ttm" validateRequest="false" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">






    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script> 
    <script language="JavaScript" type="text/jscript">
<!--
    function labelvisible1(identificador) {
        if (document.getElementById(identificador).style.display != "none") {
            document.getElementById(identificador).style.display = "none";
        } else {
            document.getElementById(identificador).style.display = "inline";
        }
    }
    function labelvisible(identificador) {
        if (document.getElementById("LblAyuda2").style.display != "none") {
            document.getElementById("LblAyuda2").style.display = "none";
        } else {
            document.getElementById("LblAyuda2").style.display = "inline";
        }
    }
//-->
</script>
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
        var callerObj = ev.srcElement ? ev.srcElement : ev.target;

        //Call the original radconfirm and pass it all necessary parameters
        if (callerObj) {
            //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again.
            var callBackFn = function (arg) {
                if (arg) {
                    callerObj["onclick"] = "";
                    if (callerObj.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz
                    else if (callerObj.tagName == "A") //We assume it is a link button!
                    {
                        try {
                            eval(callerObj.href)
                        }
                        catch (e) { }
                    }
                }
            }

            radconfirm(text, callBackFn, oWidth, oHeight, callerObj, oTitle);
        }
        return false;
    }
</script>
<%--<script src="../../ttm_js/windowfiles/dhtmlwindow.js" type="text/javascript"></script>
<link href="../../ttm_js/windowfiles/dhtmlwindow.css" rel="stylesheet" type="text/css" />--%>
<script src="FusionCharts_.js" type="text/javascript"></script>
<script src="fusioncharts.charts_.js" type="text/javascript"></script>
<script src="fusioncharts.theme.fint_.js" type="text/javascript"></script>
<script type="text/javascript" src="../../ttm_js/jspdf.debug.js"></script>
<script type="text/javascript" src="../../ttm_js/tableExport.js"></script>
<script type="text/javascript" src="../../ttm_js/jquery.base64.js"></script>
<script type="text/javascript">


    function _hoy() {

        var mydate = new Date();
        var Hora = mydate.getHours();
        var Min = mydate.getMinutes();
        var day_month = mydate.getDate();
        var month = mydate.getMonth() + 1;
        var year = mydate.getFullYear();
        var day = mydate.getDay();

        if ((Hora + "").length == 1) sHora = '0' + Hora;
        else sHora = Hora;

        if ((Min + "").length == 1) sMin = '0' + Min;
        else sMin = Min;

        if ((day_month + "").length == 1) sDay = '0' + day_month;
        else sDay = day_month;

        if ((month + "").length == 1) month = '0' + month;

        return (sDay + "/" + month + "/" + year);

    }



    //    function delMedicion(_folio, _fecha, _tipo) {
    //        var idfolio = _folio + _tipo;
    //        var tbl = document.getElementById('ctl00_ContentPlaceHolder1_tabMedidas');
    //        for (var i = 3; i < tbl.rows.length; i++) {
    //            if (tbl.rows[i].cells[0].children[0].value == idfolio) {
    //                tbl.deleteRow(i);
    //            }
    //        }
    //        if (tbl.rows.length == 4) {
    //            document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value = "U"
    //            for (var i = 3; i < tbl.rows.length; i++) { // comparo fecha para insertar medicion ordenada
    //                for (var x = 1; x < tbl.rows[i].cells.length; x++) {
    //                    tbl.rows[i].cells[x].children[0].disabled = false;
    //                }
    //            }
    //        }

    //        //	if (tbl.rows.length <= 3){
    //        //		limpiarAllRows(tbl);
    //        //	}
    //    }




    function listLecturas(tipo, folio, fecha, total, xx, pos) {

        var Arrdat1 = tipo.substring(0, (tipo.length - 1));
        var Arrdat2 = folio.substring(0, (folio.length - 1));
        var Arrdat3 = fecha.substring(0, (fecha.length - 1));
        var Arrdat4 = total.substring(0, (total.length - 1));
        var Arrdat5 = xx.substring(0, (xx.length - 1));
        var Arrdat6 = pos.substring(0, (pos.length - 1));

        var dist, cv, tbl, xx, rowCount, zz, tipo_, folio_, fecha_, xx_, pos_;
        tbl = document.getElementById("ctl00_ContentPlaceHolder1_tabMedidas");
        xx = document.getElementById("ctl00_ContentPlaceHolder1_txtAncho").value;

        var rounds1 = Arrdat1.split('§');
        var rounds2 = Arrdat2.split('§');
        var rounds3 = Arrdat3.split('§');
        var rounds4 = Arrdat4.split('§');
        var rounds5 = Arrdat5.split('§');
        var rounds6 = Arrdat6.split('§');
        var totlin = rounds1.length;
        for (var i = 0; i < rounds1.length; i++) {
            tipo_ = rounds1[i];
            folio_ = rounds2[i];
            fecha_ = rounds3[i];
            total_ = rounds4[i];
            //xx_ = rounds5[i];
            pos_ = rounds6[i];
            rowCount = $('#ctl00_ContentPlaceHolder1_tabMedidas >tbody >tr').length;
            zz = Math.round(parseFloat(xx) / (parseFloat(total_) + 5))
            //alert(xx);
            if (zz <= 50) {
                dist = 50
            } else {
                dist = 100
            }
            if (rowCount <= 0) {
                makeHead(tbl, dist);
                insertMedicion(tbl, tipo_, folio_, fecha_, xx, pos_, totlin);
            } else {
                insertMedicion(tbl, tipo_, folio_, fecha_, xx, pos_, totlin);
            }
        }

        i = 1;
        return;

    }


    function insertMedicion(tbl, _tipo, _folio, _fecha, _ancho, _pos, totx) {

        i = 1;
        var tbl = document.getElementById("ctl00_ContentPlaceHolder1_tabMedidas");
        var tbl2 = document.getElementById("ctl00_ContentPlaceHolder1_tabMedidas");
        var ancho = Math.ceil(_ancho);
        var Arrdatax = document.getElementById("ctl00_ContentPlaceHolder1_HDDDataEsp" + _pos).value;
        var Arrdata = Arrdatax.substring(0, (Arrdatax.length - 1));
        var lineas = $('#ctl00_ContentPlaceHolder1_tabMedidas >tbody >tr').length; // Math.ceil(document.getElementById("ctl00_ctl00_ContentPlaceHolder1_RadWindow1_C_swcheckPanel").value);
        //alert(Arrdatax);

        if (_tipo == "CAR") {
            if (tbl.rows.length > 3) {
                for (var i = 3; i < tbl.rows.length; i++) { // comparo fecha para insertar medicion ordenada
                    if (parseFloat(tbl.rows[i].cells[0].children[0].value) < parseFloat(_folio)) {
                        row = tbl.insertRow(i);
                        break;
                    }
                    else {
                        if (!tbl.rows[i + 1]) {//!tbl.rows[i+1].children[0].children[1]
                            row = tbl.insertRow(i + 1);
                            break;
                        }
                    }
                }
            } else {
                row = tbl.insertRow(-1);
            }
        } else { row = tbl.insertRow(-1); }
        //row = tbl.insertRow(-1);
        if ((totx + 3) > 5) {
            document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value = "M"
            for (var i = 3; i < (tbl2.rows.length); i++) { // comparo fecha para insertar medicion ordenada}
                if (i == 4) {
                    for (var x = 1; x < tbl2.rows[i].cells.length; x++) {
                        tbl2.rows[i].cells[x].children[0].disabled = true;
                    }
                }
            }

        } else if ((totx + 3) <= 5) {
            document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value = "U"
        }
        cell = row.insertCell(0);
        cell.innerHTML = "<input type='hidden' name='id" + _folio + _tipo + "' id='id" + _folio + _tipo + "' value='" + _folio + _tipo + "'/><span class='tinyText'>LECTURA " + _fecha + " Nº</span><span>" + _folio + "</span>&nbsp;<span>" + _tipo + "<span>";
        cell.width = 250;
        var i = 0; j = 1; k = 0;
        //---------------------------------------------------llena contenidos------------------------------------------------------------------------
        var cell = row.insertCell(j); //celda en blanco para los bordes de la cinta
        //alert(document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value);
        if ((document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == "C" || document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == "U") || _pos == 0) {
            cell.innerHTML = "<INPUT class='tinyInput' TYPE=TEXT SIZE=3 onChange='cambio(this);' /> ";
        } else {
            cell.innerHTML = "<span  class='tinyInputBlocked'   style='width:32; height:15;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> ";
        }
        cell.align = "center";
        cell.width = 30;
        j = 2;
        k = k + lenMedida;
        var tree = Arrdata.split('§');

        for (var i = 0; i < tree.length; i++) { // muestra los datos segun lectura
            //var node = tree.childNodes.item(i);
            valor = tree[i]; //getChildNodeValue(node, "VALOR");
            var cell = row.insertCell(j);
            if ((document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == "C" || document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == "U") || _pos == 0) {
                //onKp = "onkeypress='format(this);'";
                onKp = " onkeypress = 'return isNumberKey(event)' ";
                onCh = " onChange='format(this)' ";
                cell.innerHTML = "<INPUT class='tinyInput' TYPE=TEXT SIZE=3 " + onKp + " " + onCh + " " +
								" value='" + valor + "' /> ";
            } else {
                cell.innerHTML = "<span  class='tinyInputBlocked'   style='width:32; height:15;' >" + valor + "</span> ";
            }
            k = k + lenMedida;
            j = j + 1;
            cell.align = "center";
            cell.width = 30;
            if (k > ancho)
                break;
        }
        while (k <= ancho) {//inserta celdas vacias para completar
            var cell = row.insertCell(j);
            if ((document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == "C" || document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == "U") || _pos == 0) {
                cell.innerHTML = "<INPUT class='tinyInput' TYPE=TEXT SIZE=3 onChange='cambio(this);' /> ";
            } else {
                cell.innerHTML = "<span  class='tinyInputBlocked'  style='width:32; height:15;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> ";
            }

            k = k + lenMedida;
            //j=j+1;
            cell.align = "center";
            cell.width = 30;
            if (k > ancho)
                break;
        }
        //------------------------------------------------------------------------------------------------------------------------------
    }


    function makeHead(tbl, _dist) {

        //limpiarAllRows(tbl);
        var tbl = document.getElementById('ctl00_ContentPlaceHolder1_tabMedidas');
        var i = 0; j = 1;
        ancho = Math.ceil(document.getElementById("ctl00_ContentPlaceHolder1_txtAncho").value);
        espesor = Math.ceil(document.getElementById("ctl00_ContentPlaceHolder1_txtEspesor").value);
        espesor_r = Math.ceil(document.getElementById("ctl00_ContentPlaceHolder1_txtEspesorR").value);

        var fechaCambio = document.getElementById("ctl00_ContentPlaceHolder1_TxtFechaInstalacion_dateInput").value;
        var dFechaCambio = new Date(fechaCambio.substr(6, 4),
						  fechaCambio.substr(3, 2) - 1,
						  fechaCambio.substr(0, 2));

        var fechaActual = _hoy();

        var dFecha = new Date(fechaActual.substr(6, 4),
					  fechaActual.substr(3, 2) - 1,
					  fechaActual.substr(0, 2));

        document.getElementById("ctl00_ContentPlaceHolder1_txtdiasop").value = Math.round((dFecha.getTime() - dFechaCambio.getTime()) / (24 * 1000 * 60 * 60));


        if (ancho <= 0) {
            alert("El equipo no registra el ancho.");
            return;
        }


        if (document.getElementById("ctl00_ContentPlaceHolder1_CmbTipoEq_Input").value == "POLEA")
            lenMedida = 100;
        else
            lenMedida = parseInt(_dist);



        row = tbl.insertRow(-1);
        cell = row.insertCell(0);
        cell.innerHTML = "<INPUT class='tinyText' size='27' value='N° DE MEDIDAS.' />";
        cell.width = 250;


        while (i <= ancho) {
            //alert(i + " " + ancho);
            var cell = row.insertCell(j);
            cell.innerHTML = "<SPAN class='tinyText'> " + j + "</SPAN>";
            i = i + lenMedida;
            j = j + 1;
            cell.align = "center";
            cell.width = 30;
        }

        row = tbl.insertRow(-1);
        cell = row.insertCell(0);
        cell.innerHTML = "<SPAN class='tinyText'>DISTANCIA (mm)</SPAN>";
        var i = 0; j = 1;
        while (i <= ancho) {
            var cell = row.insertCell(j);
            cell.innerHTML = "<SPAN class='tinyText'> " + i + "</SPAN>";
            i = i + lenMedida;
            j = j + 1;
            cell.align = "center";
            cell.width = 30;
        }

        row = tbl.insertRow(-1);
        cell = row.insertCell(0);
        cell.innerHTML = "<SPAN class='tinyText'>CUBIERTA ORIGINAL</SPAN>";
        var i = 0; j = 1;
        while (i <= ancho) {
            var cell = row.insertCell(j);
            cell.innerHTML = "<SPAN class='tinyText'> " + espesor + "</SPAN>";
            i = i + lenMedida;
            j = j + 1;
            cell.align = "center";
            cell.width = 30;
        }
    }

    function creaLectura(_fecha, _dist, _inspector, _tipo) {
        //alert(_fecha+ ' |'+ _dist+ ' |'+ _inspector+ ' |'+ _tipo);
        var tbl = document.getElementById('ctl00_ContentPlaceHolder1_tabMedidas');
        ancho = parseFloat(document.getElementById("ctl00_ContentPlaceHolder1_txtAncho").value);

        fecha = _fecha;
        lenMedida = parseFloat(_dist);
        inspector = _inspector;

        if (tbl.rows.length <= 0) {
            makeHead(tbl, _dist);
        }


        if (_tipo == "CAR") {
            row = tbl.insertRow(3);
            onCh = "onChange='cambio(this);'";
        }
        else {
            row = tbl.insertRow(-1);
            onCh = "onChange='cambioR(this);'";
        }

        onKu = "onkeyup=fn(this.form,this);";
        //onKp = "onkeypress='format(this);'";
        onKp = " onkeypress = 'return isNumberKey(event)' ";
        onCh = " onChange='format(this)' ";
        cell = row.insertCell(0);
        cell.innerHTML = "<input type='hidden' name='id" + _tipo + "' id='id" + _tipo + "' value=''/><span class='tinyText'>LECTURA " + fecha + "  Nº</SPAN><SPAN>&nbsp;</SPAN><SPAN>" + _tipo + "</SPAN>";
        cell.width = 250;
        var i = 0; j = 1; k = 0;


        var cell = row.insertCell(j); //celda en blanco para los bordes de la cinta
        cell.innerHTML = "<INPUT class='tinyInput' TYPE=TEXT SIZE=3  disabled /> ";

        j = 2;
        rnd = (Math.random() + " ").substring(1, 3);
        k = k + parseInt(_dist);
        //alert(k);
        document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value = "C";
        while (k <= ancho) {
            var cell = row.insertCell(j);
            cell.innerHTML = "<INPUT class='tinyInput' TYPE=TEXT SIZE=3 name='D" + j + rnd + "' " + onKp + " " + onCh + "  id='D" + j + rnd + "' /> ";
            k = k + parseInt(_dist);
            //alert(k + " " + ancho);
            j = j + 1;
            cell.align = "center";
            cell.width = 30;
        }

        row.children[2].focus();

    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
            return false;
        return true;
    }

    function redondear(numero) {
        var original = parseInt(numero);
        var result = Math.round(original * 100) / 100;
        return result;
    }

    function format(input) {
        var num = input.value.replace(/\,/g, '');
        var msg = "";
        var swx = 0;
        var swx2 = 0;
        if (!isNaN(num) || (num == '-')) {
            if (num.indexOf('.') > -1) {
                splitter = '.'
            } else {
                splitter = ','
            }
            if (num.indexOf(splitter) > -1) {
                num = num.split('.');
                num[0] = num[0].toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g, '$1,').split('').reverse().join('').replace(/^[\,]/, '');
                if (num[0].length > 3) {
                    //alert('Solo permite 3 numeros!');
                    swx = 1;
                    num[0] = num[0].substring(0, num[0].length - 1);
                }
                if (num[1].length > 2) {
                    //alert('Solo permite 2 decimales!');
                    swx2 = 1;
                    num[1] = num[1].substring(0, num[1].length - 1);
                }
                if (swx == 1 && swx2 == 1){
                    alert('Solo permite 3 numeros y 2 decimales!');
                }else if (swx == 0 && swx2 == 1) {
                    alert('Solo permite 2 decimales!');
                } else if (swx == 1 && swx2 == 0) {
                    alert('Solo permite 3 numeros!');
                }
                input.value = num[0].replace(',','') + splitter + num[1];

            } else {
                input.value = num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g, '$1,').split('').reverse().join('').replace(/^[\,]/, '')
            }
        } else {
            input.value = num.substring(0, num.length - 1);
            alert('Solo ingrese numeros!');
        }
    }


    function cambio(obj) {
        tbl = obj.parentElement.parentElement.parentElement;
        col = obj.parentElement.cellIndex;

        return;



    }

    function cambioR(obj) {
        tbl = obj.parentElement.parentElement.parentElement;
        col = obj.parentElement.cellIndex;

        valor = obj.value.replace(",", ".");

        if (valor > 0)
            obj.value = valor * -1;
        else
            obj.value = valor;


        tbl.rows[9].children[col].innerText = redond(valor - (espesor_r), 2);
    }


    function guardarValorMedicion() {

        var muestreo = "";
        var retorno = "";
        var tbl = document.getElementById("ctl00_ContentPlaceHolder1_tabMedidas");

        ncols = tbl.rows[3].children.length - 2;
        i = 3;
        x = 2;
        while (x < ncols) {
            if (tbl.rows[i].children[x].children[0].value == "") {
                alert('No se puede grabar, Falta datos en lecturas');
                return;
            }
            x = x + 1;
        }
        ncols = tbl.rows[3].children.length;

        var indx = 3;

        if (tbl.rows[indx].children[0].children[1]) {
            if (document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value != 'C') {
                folio = tbl.rows[indx].children[0].children[2].innerHTML;
                fecha = tbl.rows[indx].children[0].children[1].innerHTML.substring(8, 18);
                tipo = tbl.rows[indx].children[0].children[3].innerHTML.replace('<span></span>', '');
                document.getElementById("ctl00_ContentPlaceHolder1_hddkeyln").value = folio + "§" + fecha + "§" + tipo;

            } else {
                fecha = tbl.rows[indx].children[0].children[1].innerHTML.substring(8, 18);
                tipo = tbl.rows[indx].children[0].children[3].innerHTML.replace('<span></span>', '');
                document.getElementById("ctl00_ContentPlaceHolder1_hddkeyln").value = "0" + "§" + fecha + "§" + tipo;

            }
        }
        var i = 2;
        while (i < ncols) {
            if (tbl.rows[indx].children[i].children[0].value) {
                valor = tbl.rows[indx].children[i].children[0].value;
                muestreo = muestreo + ";" + valor;
            }
            i = i + 1;
        }
        var lengh = muestreo.length;
        document.getElementById("ctl00_ContentPlaceHolder1_hddvalue" + (indx - 3)).value = muestreo.substring(1, lengh);
    }

    function checkstatus0() {

        if (document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == 'C') {
            radalert('<strong>No permite visualizar datos hasta grabar la nueva lectura! </strong>', 330, 100, 'TTM Insight');
            hideMe();
            return false;

        }
        showMe();
        return true;
    }

    function checkstatus3() {
        if (document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value == 'C') {
            radalert('<strong>No permite crear hasta grabar la nueva lectura! </strong>', 330, 100, 'TTM Insight');
            return false;
        }
        return true;
    }

    function checkstatus4() {
        hideMe();
    }

    String.prototype.replaceAll = function (find, replace) {
        var str = this;
        return str.replace(new RegExp(find.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'), replace);
    };


    function addgraphic() {
        var winCfg;
        var inlinewin2;
        var data = document.getElementById("ctl00_ContentPlaceHolder1_hddkeydata").value;
        var dat1 = data.replaceAll("±", "'");
        var dat2 = dat1.replaceAll("&", "<");
        var dat3 = dat2.replaceAll("$", ">");
        var dat4 = dat3.replaceAll("Ω", "/");
        data = dat4.replaceAll("π", "?");

        var chart = new FusionCharts("MSLine.swf", "ChartId", "1010", "280", "0", "1");
        chart.setDataXML(data.toString());
        chart.render("ctl00_ContentPlaceHolder1_PnlmedGraf"); // problema esta aca en renderizacion 

//        var url = "boxGraphics.html";
//        url += "?data=" + data;
////        url += "&FECHA_INST=" + formulario.txtFechaInst.value;
////        url += "&ESPESOR_SEG=" + formulario.txtEspesorSeg.value;
//        winCfg = "width=1000px,height=290px,left=" + 50 + "px,top=" + 100 + "px,resize=1,scrolling=0";
        //        inlinewin2 = dhtmlwindow.open("graphicsBox", "iframe", url, "GRAFICO", winCfg, "recal");


//        window.open("boxGraphics.html");
//        var oManager = window.radopen("boxGraphics.html", null);
//        oManager.setSize(1000, 290); //Width, Height
//        oManager.center();
//        oManager.SetActive();
        //return false;
    }

//  function Print_report() {
    function openRadWindow() { 
            var oWnd = radopen("boxGraphics.html", "rwShowMember"); 
            var TitleBar = oWnd.GetTitlebar(); 
            var parent = TitleBar.parentNode; 
             
            var oUL = parent.getElementsByTagName('UL')[0]; 
            //oUL.style.width = "700px"; 
             
            var li = document.createElement("LI"); 
            var a = document.createElement("A"); 
            li.appendChild(a);                         
            a.className = "custombutton"; 
            a.title = "Print Content";             
            a.onmousedown = printWin; 
                         
            oUL.insertBefore(li, oUL.firstChild);
            oWnd.center();
            //oWnd.setSize(100, 100);
    } 
         
    function printWin(e) { 
            var oManager = GetRadWindowManager(); 
            var oWnd = oManager.GetWindowByName("rwShowMember"); 
            var content = oWnd.GetContentFrame().contentWindow; 
            var printDocument = content.document; 
            if (document.all) { 
                printDocument.execCommand("Print"); 
            } 
            else { 
                content.print(); 
            } 
             
            //Cancel event! 
            if (!e) e = window.event; 
             
            return $telerik.cancelRawEvent(e); 
    }

    function FromHTMLtoEXCEL() {
        var $tableBody2 = $('#ctl00_ContentPlaceHolder1_tabMedidas2');
        $tableBody2.html('<tbody></tbody>');
        var $tablebodyin = $('#ctl00_ContentPlaceHolder1_tabMedidas2').find("tbody");
        var $tableBody = $('#ctl00_ContentPlaceHolder1_tabMedidas').find("tbody");
        $tableBody.find('tr').each(function (i, tr) {
            $trNew = $(this).clone();
            $trNew.find('td').each(function (ix, trx) {
                $(this).html($(this).find('input').not('input[type=hidden]').val(function (i, v) { return v.replace(".", ","); }).val());
            });
            $tablebodyin.append($trNew);
        });
        $('#ctl00_ContentPlaceHolder1_tabMedidas2').tableExport({ type: 'excel', escape: 'false' });
        $tableBody2.html('<tbody></tbody>');

    }
         
    isIE=document.all;
    isNN=!document.all&&document.getElementById;
    isN4=document.layers;
    isHot = false;    
    
    function ddInit(e){
      topDog=isIE ? "BODY" : "HTML";
      whichDog = isIE ? document.all.theLayer : document.getElementById("ctl00_ContentPlaceHolder1_RadWindow1");  
      hotDog=isIE ? event.srcElement : e.target;  
      while (hotDog.id!="titleBar"&&hotDog.tagName!=topDog){
        hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
      }  
      if (hotDog.id=="titleBar"){
        offsetx=isIE ? event.clientX : e.clientX;
        offsety=isIE ? event.clientY : e.clientY;
        nowX=parseInt(whichDog.style.left);
        nowY=parseInt(whichDog.style.top);
        ddEnabled=true;
        document.onmousemove=dd;
      }
    }

    function dd(e){
      if (!ddEnabled) return;
      whichDog.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx; 
      whichDog.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
      return false;  
    }

    function ddN4(whatDog){
      if (!isN4) return;
      N4=eval(whatDog);
      N4.captureEvents(Event.MOUSEDOWN|Event.MOUSEUP);
      N4.onmousedown=function(e){
        N4.captureEvents(Event.MOUSEMOVE);
        N4x=e.x;
        N4y=e.y;
      }
      N4.onmousemove=function(e){
        if (isHot){
          N4.moveBy(e.x-N4x,e.y-N4y);
          return false;
        }
      }
      N4.onmouseup=function(){
        N4.releaseEvents(Event.MOUSEMOVE);
      }
    }

    function hideMe(){
      if (isIE||isNN) whichDog.style.visibility="hidden";
      else if (isN4) document.theLayer.visibility="hide";
    }

    function showMe(){
      if (isIE||isNN) whichDog.style.visibility="visible";
      else if (isN4) document.theLayer.visibility="show";
    }

    //if (document.getElementById("ctl00_ContentPlaceHolder1_txt_seleccion").value != 'C') {
        document.onmousedown = ddInit;
        document.onmouseup = Function("ddEnabled=false");
    //}
</script>
<style type="text/css">

.rsbHeader ul,
.rsbListItem ul {
     margin: 0;
     padding: 0;
     width: 100%;
     display: inline-block;
     list-style-type: none;
}
 
.rsbHeader ul {
     padding-left:5px;
}
 
.col1,
.col3 {
     margin: 0;
     padding: 0 5px 0 0;
     width: 160px;
     line-height: 14px;
     float: left;
}
.col2 
{
     margin: 0;
     padding: 0 5px 0 0;
     width: 250px;
     line-height: 14px;
     float: left;
}
.rcbTemplate {
    padding: 5px 5px 5px 5px !important;
}
.tinyInput{
    font-family:Verdana, Arial, Helvetica, sans-serif;
    font-size:8px;
    font-weight:bold;
    border:solid 1px #000000;
    color:#003399;
}
.tinyInputBlocked{
    font-family:Verdana, Arial, Helvetica, sans-serif;
    font-size:8px;
    font-weight:bold;
    border:solid 1px #000000;
    color:#777;
}
</style>
<table cellpadding="0" cellspacing="0" border="0" width="939">
                                    	<tr>
                                        	<td style="width:15px"></td>
                                        	<td valign="top" style="width:744px">
                                            	<table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                	<tr>
                                                   	  <td style="width:100%; height: 10px;" valign="top" colspan="2">
                                                        	<div class="ContTopLiBx">
                                                                            <div class="ContTitLiBx">Administrador Espesores</div>
	                                                                        <div class="LogoTTMLiBx"></div>
	                                                                        <div class="limpiar"></div>
                                                                        </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                      <td width="140" align="center" valign="top" >
                                                    	    <asp:Panel runat="server" ID="PnlFilto" Visible="true" BackColor="#666">
                                                            <table width="100px" border="0" cellspacing="0" cellpadding="0" runat="Server" id="TblFiltoCompleto" bgcolor="#666">
                                                              <tr>
                                                                <td style="width:100px">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo2">
                                                                      <tr>
                                                                        <th align="left" valign="middle">FILTRO DE EQUIPOS</th>
                                                                        <th style="height: 21px; width:200px" align="right" valign="top">
                                                                        </th>
                                                                      </tr>
                                                                    </table>
                                                                </td>
                                                              </tr>
                                                              <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="filtroContenido2" id="tblFiltro" runat="server">
                                                                        <tr>
                                                                            <td style="height:20px" >
                                                                                <telerik:RadComboBox ID="cblequiposfiltros" runat="server"  Height="300" 
                                                                                    Width="220" EnableLoadOnDemand="true" EnableVirtualScrolling="true" CssClass="field3" 
                                                                                     Filter="Contains" LoadingMessage="Cargando..." MarkFirstMatch="True" 
                                                                                     onitemdatabound="cblequiposfiltros_ItemDataBound" 
                                                                                     ondatabound="cblequiposfiltros_DataBound" 
                                                                                     onitemsrequested="cblequiposfiltros_ItemsRequested" 
                                                                                     ontextchanged="cblequiposfiltros_TextChanged" 
                                                                                     onselectedindexchanged="cblequiposfiltros_SelectedIndexChanged" 
                                                                                    AutoPostBack="True" onclientdropdownopened="_DropDownOpening1">
                                                                                        <HeaderTemplate>
                                                                                             <h2>Equipos</h2>
                                                                                        </HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                             <div class="imageWrap">
                                                                                                  <img src="<%# BuscarFotoEquipo(Eval("IMAGEURL").ToString()) %>" alt=" <%# DataBinder.Eval(Container, "value")%> " />
                                                                                             </div>
                                                                                             <div>
                                                                                                  <ul class="personDetails">
                                                                                                       <li class="name"><span> <%# DataBinder.Eval(Container, "value")%> </span></li>
                                                                                                       <li class="title"><span> <%# DataBinder.Eval(Container, "text")%> </span></li>
                                                                                                  </ul>
                                                                                             </div>
                                                                                        </ItemTemplate>
                                                                                        <FooterTemplate>
                                                                                            Total Equipos: <asp:literal runat="server" id="RadComboItemsCount" />
                                                                                       </FooterTemplate>
                                                                                </telerik:RadComboBox>
                                                                          </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height:20px" >&nbsp;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                            	<!--va el tree panel-->
                                                                                <telerik:RadTreeView ID="TreeEq2" runat="server" Height="710px" Width="230px" 
                                                                                    Font-Bold="True" Font-Names="Arial" Font-Size="11px" 
                                                                                    onnodeclick="TreeEq2_NodeClick" BackColor="#666666" ForeColor="White" CausesValidation="False">
                                                                                 <DataBindings>
                                                                                    <telerik:RadTreeNodeBinding Expanded="True"></telerik:RadTreeNodeBinding>
                                                                                </DataBindings>
                                                                                </telerik:RadTreeView>
                                                                            </td>
                                                                        </tr>
                                                                        
                                                                  </table>
                                                                
                                                                </td>
                                                              </tr>
                                                            </table>
                                                            </asp:Panel>
                                                      </td>
                                                      <td align="center" valign="top" >
                                                      
                                                        <asp:Panel ID="PnlNuevoRegistro" runat="server" Visible="true">
                                                          <table cellpadding="0" cellspacing="0" border="0" runat="server" id="TblRegistro" class="NuevoGrid" >
                                                            <tr>
                                                              <td>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="filtroTitulo">
                                                                  <tr>
                                                                    <th align="left" valign="middle">INFORMACION EQUIPO</th>
                                                                    <th style="height: 21px; width:200px" align="right" valign="top">
                                                                    </th>
                                                                  </tr>
                                                                  </table>
                                                               </td>
                                                              </tr>
                                                            <tr>
                                                              <td style="height: 19px"><a href="javascript:labelvisible('txtayuda1')"><asp:Image id="ImgBtnAyuda" runat="server" SkinID="ImgAyuda" ImageAlign="Right"></asp:Image></a></td>
                                                             </tr>
                                                            <tr>
                                                              <td><asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="SingleParagraph" Font-Bold="True" Font-Names="Arial" Font-Size="10px" HeaderText="Por favor complete los siguientes campos:" Width="80%" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" /></td>
                                                             </tr>
                                                            
                                                            <tr>
                                                              <td valign="top" style="margin: 1px; padding: 1px 1px 1px 10px">
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="FormularioMantenedores">
                                                                  <tr>
                                                                    <td width="10" style="height:24px"></td>
                                                                    <td colspan="11" align="left" valign="top" class="obligatorio" 
                                                                                    style="height: 24px; width: 115px; color: #FFF; font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold;"><table  border="0" width="100%" cellpadding="1" cellspacing="1">
                                                                      <!--DWLayoutTable-->
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td width="107" align="left" valign="top">Codigo<span style="width:134px">
                                                                          <asp:HiddenField ID="hddistatusprocedure" runat="server" Value="0" />
                                                                        </span></td>
                                                                        <td align="left" valign="top">Descripci&oacute;n</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top">Tipo Equipo</td>
                                                                        <td align="left" valign="top">&nbsp;<asp:Label 
                                                                                ID="lblectura" runat="server" Text="Lectura" Visible="False"></asp:Label>
                                                                          </td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top">
                                                                          
                                                                            <asp:TextBox ID="txtcodeq" runat="server" Width="120px"></asp:TextBox>
                                                                          </td>
                                                                        <td colspan="2" align="left" valign="top"><asp:TextBox ID="TxtDescripcion" runat="server" Width="300px"></asp:TextBox>
                                                                            
                                                                            
                                                                            
                                                                          </td>
                                                                        <td align="left" valign="top"><telerik:RadComboBox ID="CmbTipoEq" runat="server" CausesValidation="False" 
                                                                                          DataTextField="description" DataValueField="value" 
                                                                                          Filter="Contains" 
                                                                                          Skin="Default" Sort="Ascending" Width="200px" Height="250px" 
                                                                                Enabled="False"> </telerik:RadComboBox></td>
                                                                        <td align="left" valign="top"><asp:Panel ID="pnlectura" runat="server" Visible="False">
                                                                            <asp:ImageButton ID="btnlectura0" runat="server" skinid="btnlectrura1" 
                                                                                onclick="btnlectura0_Click" CausesValidation="False" 
                                                                                onclientclick="return checkstatus0();" />
                                                                            <asp:ImageButton ID="btnlectura3" runat="server" skinid="btnlectrura3" 
                                                                                onclick="btnlectura3_Click" CausesValidation="False" 
                                                                                onclientclick="return checkstatus3();"/>
                                                                            <asp:ImageButton ID="btnlectura2" runat="server" skinid="btnlectrura2" 
                                                                                onclick="btnlectura2_Click" CausesValidation="False" 
                                                                                onclientclick="checkstatus4();"/>
                                                                            <asp:ImageButton ID="btnlectura5" runat="server" SkinID="btnlectrura5" 
                                                                                CausesValidation="False" onclientclick="openRadWindow(); return false;" />
                                                                            <asp:HiddenField ID="txt_seleccion" runat="server" />  
                                                                            <asp:HiddenField ID="hddsessionemp" runat="server" />  
                                                                            <asp:HiddenField ID="hddsessionrol" runat="server" />  
                                                                            </asp:Panel>
                                                                          </td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top"><asp:Panel ID="RadWindow1" runat="server" Visible="False" style="position:absolute;z-index: 999;">
                                                                                    <table border="0" width="450" bgcolor="#0072C6" cellspacing="0" cellpadding="1">
                                                                                    <tr>
                                                                                    <td width="100%">
                                                                                      <table border="0" width="100%" cellspacing="0" cellpadding="4" height="36">
                                                                                      <tr>
                                                                                      <td id="titleBar" style="" width="100%">
                                                                                      <ilayer width="100%" onSelectStart="return false">
                                                                                      <layer width="100%" onMouseover="isHot=true;if (isN4) ddN4(theLayer)" onMouseout="isHot=false">
                                                                                      <font face="Arial" color="#FFFFFF" size="2">Lecturas</font>
                                                                                      </layer>
                                                                                      </ilayer>
                                                                                      </td>
                                                                                      <td style="cursor:hand" valign="top">
                                                                                      <a href="#" onClick="hideMe();return false"><font color=#ffffff size=2 face=arial  style="text-decoration:none">X</font></a>
                                                                                      </td>
                                                                                      </tr>
                                                                                      <tr>
                                                                                      <td width="100%" bgcolor="#FFFFFF" style="padding:1px" colspan="2">
                                                                                            <asp:GridView ID="GridLectura" runat="server" AllowPaging="True" 
                                                                                                AlternatingRowStyle-BackColor="#C2D69B" AutoGenerateColumns="False" 
                                                                                                BackColor="#0072C6" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
                                                                                                Font-Names="Arial" Font-Size="10pt" 
                                                                                                ForeColor="#333333" GridLines="None" HeaderStyle-BackColor="green" 
                                                                                                OnPageIndexChanging="OnPaging" PageSize="15">
                                                                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                                                <Columns>
                                                                                                    <asp:TemplateField ShowHeader="False">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:CheckBox ID="Chk" runat="server" AutoPostBack="True" 
                                                                                                                oncheckedchanged="Chk_CheckedChanged" />
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:BoundField DataField="FOLIO" HeaderText="Folio" ItemStyle-Width="60px" 
                                                                                                        ShowHeader="False">
                                                                                                    <ItemStyle Width="60px" />
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="FECHA" DataFormatString="{0:d}" HeaderText="Fecha" 
                                                                                                        ItemStyle-Width="90px" ShowHeader="False">
                                                                                                    <ItemStyle Width="80px" />
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="EQUIPO" HeaderText="Componente" 
                                                                                                        ItemStyle-Width="80px" ShowHeader="False">
                                                                                                    <ItemStyle Width="70px" />
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="INSPECTOR" HeaderText="Usuario" 
                                                                                                        ItemStyle-Width="70px" ShowHeader="False">
                                                                                                    <ItemStyle Width="50px" />
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="TIPO" HeaderText="Tipo" ItemStyle-Width="90px" 
                                                                                                        ShowHeader="False">
                                                                                                    <ItemStyle Width="50px" />
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="TOTAL" HeaderText="total" ShowHeader="False" />
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
                                                        </asp:Panel>Fecha Instalaci&oacute;n</td>
                                                                        <td align="left" valign="top">Ancho</td>
                                                                        <td align="left" valign="top">Espesor Cubierta</td>
                                                                        <td align="left" valign="top">Espesor Retorno</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top"><telerik:RadDatePicker ID="TxtFechaInstalacion" 
                                                                                Runat="server" Width="110px" Culture="es-CL"> 
                                                                            <calendar ID="Calendar1" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar>
                                                                            <DateInput ID="DateInput1" DateFormat="dd-MM-yyyy" DisplayDateFormat="dd-MM-yyyy" 
                                                                                LabelWidth="40%" Runat="server">
                                                                                <EmptyMessageStyle Resize="None" />
                                                                                <ReadOnlyStyle Resize="None" />
                                                                                <FocusedStyle Resize="None" />
                                                                                <DisabledStyle Resize="None" />
                                                                                <InvalidStyle Resize="None" />
                                                                                <HoveredStyle Resize="None" />
                                                                                <EnabledStyle Resize="None" />
                                                                            </DateInput>
                                                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                                            </telerik:RadDatePicker></td>
                                                                        <td align="left" valign="top"><span class="texto">
                                                                          <asp:TextBox ID="txtAncho" runat="server" Width="100px"></asp:TextBox>
                                                                          mm
                                                                        </span></td>
                                                                        <td align="left" valign="top"><asp:TextBox ID="txtEspesor" runat="server" 
                                                                                Width="100px"></asp:TextBox> 
                                                                          mm</td>
                                                                        <td align="left" valign="top"><asp:TextBox ID="txtEspesorR" runat="server" 
                                                                                Width="100px"></asp:TextBox> 
                                                                          mm</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top"><span class="style4">Dias Operacion</span></td>
                                                                        <td align="left" valign="top">Dureza</td>
                                                                        <td align="left" valign="top">Fecha Cambio</td>
                                                                        <td align="left" valign="top">Proyeccion</td>
                                                                        <td align="left" valign="top">Espesor Seguridad</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top">
                                                                            <asp:TextBox ID="txtdiasop" runat="server" 
                                                                                Width="100px"></asp:TextBox></td>
                                                                        <td align="left" valign="top">
                                                                            <asp:TextBox ID="txtdureza" runat="server" 
                                                                                Width="100px"></asp:TextBox> 
                                                                          Shore A</td>
                                                                        <td align="left" valign="top"><telerik:RadDatePicker ID="TxtFechaCambio" 
                                                                                Runat="server" Width="110px"> </telerik:RadDatePicker></td>
                                                                        <td align="left" valign="top"><span class="texto">
                                                                          <asp:TextBox ID="txtproyeccion" runat="server" Width="100px"></asp:TextBox> 
                                                                          Dias</span></td>
                                                                        <td align="left" valign="top">
                                                                            <asp:TextBox ID="txtEspesorSeg" runat="server" Width="30px"></asp:TextBox>
                                                                          mm</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top">Observaciones</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top">&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td colspan="5" align="left" valign="top"><asp:TextBox 
                                                                                ID="txtobservaciones" runat="server" Columns="90" Rows="4" 
                                                                                TextMode="MultiLine"></asp:TextBox>
                                                                        </td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top">&nbsp;</td>
                                                                        <td align="left" valign="top">&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td colspan="6" align="left" valign="top"><hr /></td>
                                                                        </tr>
                                                                        <tr align="center" class="rotulo"  >
                                                                        <td colspan="6" align="left" valign="top">
                                                                            <asp:Panel ID="pnlmeding" runat="server" Visible="False">
                                                                            <table width="100%">
                                                                                    <tr>
                                                                                      <td height="11" colspan="5" align="left" valign="top" class="ContTitLiBxFoot" >Nueva Lectura</td>
                                                                                    </tr>
				                                                                                <tr>
				                                                                                  <td width="0" height="21" valign="top">Fecha</td>
				                                                                                  <td width="0" valign="top">Distancia entre mediciones</td>
				                                                                                  <td width="0" valign="top" onclick="return;">Tipo</td>
				                                                                                  <td width="0"> Inspector</td>
				                                                                                  <td width="0" valign="top">&nbsp;</td>
                                                                                    </tr>
				                                                                                <tr>
				                                                                                  <td width="0" height="20">
                                                                                                      <telerik:RadDatePicker ID="TxtFechamed" Runat="server" MinDate="2000-01-01" 
                                                                                                          Culture="es-CL">
                                                                                                          <calendar ID="Calendar2" usecolumnheadersasselectors="False" 
                                  userowheadersasselectors="False" firstdayofweek="Monday" runat="server"><SpecialDays> 
            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Green"> 
                <ItemStyle BackColor="#6699FF" ForeColor="White" />
            </telerik:RadCalendarDay> 
        </SpecialDays></calendar>
                                                                                                          <dateinput ID="Dateinput2" dateformat="dd-MM-yyyy" displaydateformat="dd-MM-yyyy" 
                                                                                                              labelwidth="40%" Runat="server">
                                                                                                              <emptymessagestyle resize="None" />
                                                                                                              <readonlystyle resize="None" />
                                                                                                              <focusedstyle resize="None" />
                                                                                                              <disabledstyle resize="None" />
                                                                                                              <invalidstyle resize="None" />
                                                                                                              <hoveredstyle resize="None" />
                                                                                                              <enabledstyle resize="None" />
                                                                                                          </dateinput>
                                                                                                          <datepopupbutton hoverimageurl="" imageurl="" />
                                                                                                      </telerik:RadDatePicker>
                                                                                                    </td>
				                                                                                  <td width="0">
                                                                                                      &nbsp;<telerik:RadComboBox ID="listDist" runat="server" Width="100px" Filter="StartsWith">
                                                                                                          <Items>
                                                                                                              <telerik:RadComboBoxItem Runat="server" Text="50mm" Value="50" />
                                                                                                              <telerik:RadComboBoxItem Runat="server" Text="100mm" Value="100" />
                                                                                                          </Items>
                                                                                                      </telerik:RadComboBox>
                                                                                                    </td>
				                                                                                  <td width="0" valign="top" onclick="return;">
                                                                                                      <telerik:RadComboBox ID="listCarga" runat="server" Width="100px" Filter="StartsWith">
                                                                                                          <Items>
                                                                                                              <telerik:RadComboBoxItem Runat="server" Text="CARGA" Value="CAR" />
                                                                                                              <telerik:RadComboBoxItem Runat="server" Text="RETORNO" Value="RET" />
                                                                                                          </Items>
                                                                                                      </telerik:RadComboBox>
                                                                                                    </td>
				                                                                                  <td width="0" valign="top">
                                                                                                      <telerik:RadComboBox ID="listInsp" runat="server" 
                                                                                                          AppendDataBoundItems="True" Filter="Contains">
                                                                                                          <Items>
                                                                                                              <telerik:RadComboBoxItem Runat="server" Text="[-Seleccionar-]" Value="" />
                                                                                                              <telerik:RadComboBoxItem Runat="server" Value="AALFARO" Text="ALVARO ALFARO" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="ALUARTE" Text="ANANIAS LUARTE" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="CLETELIER" Text="CARLOS LETELIER" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="CRIVERA" Text="CRISTIAN RIVERA" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="JSALINAS" Text="JUAN P. SALINAS" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="RCAMPUSANO" Text="RODRIGO CAMPUSANO" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="HZELADA" Text="HUMBERTO ZELADA" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="JBALLINAY" Text="JORGE BALLINAY" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="LHUERTA" Text="LEONARDO HUERTA" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="MCERECEDA" Text="MICHAEL CERECEDA" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="RACUNA" Text="RODRIGO ACUNA" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="PROJAS" Text="PEDRO ROJAS" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="JLCONTRERAS" Text="JOSE L CONTRERAS" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="SLEON" Text="SERGIO LEON" />
				                                                                                                <telerik:RadComboBoxItem Runat="server" Value="LPEZO" Text="LEANDRO PEZO" />
                                                                                                          </Items>
                                                                                                      </telerik:RadComboBox>
                                                                                                    </td>
				                                                                                  <td width="0">
                                                                                                      <asp:Button ID="btningmed" runat="server" onclick="btningmed_Click" 
                                                                                                          Text="Aceptar" CausesValidation="False" />
                                                                                                  </td>
		                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td height="20" width="0">
                                                                                            &nbsp;</td>
                                                                                        <td width="0">
                                                                                            &nbsp;</td>
                                                                                        <td onclick="return;" valign="top" width="0">
                                                                                            &nbsp;</td>
                                                                                        <td valign="top" width="0">
                                                                                            &nbsp;</td>
                                                                                        <td width="0">
                                                                                            &nbsp;</td>
                                                                                    </tr>
                                                                                  </table>
                                                                            </asp:Panel>
                                                                            <asp:Panel ID="PnlmedGraf" runat="server" Visible="False" Height="280px"><div id="ctl00_ContentPlaceHolder1_PnlmedGraf"></div> 
                                                                            </asp:Panel>
                                                                            <%----%>
                                                                            <br>
                                                                            <asp:Panel ID="Pnlmedform" runat="server" Visible="False">
                                                                                <table ID="tabMedidas" runat="server" border="1" cellpadding="0" 
                                                                                    cellspacing="0" width="100%">
                                                                                </table>
                                                                                <table ID="tabMedidas2" runat="server"  border="1" cellpadding="0" 
                                                                                    cellspacing="0" width="100%">
                                                                                    <tbody></tbody>
                                                                                </table>
                                                                                <asp:ImageButton ID="IBtnExpExcel" runat="server" CausesValidation="False" 
                                                                                    onclientclick="FromHTMLtoEXCEL();return false;" SkinID="IBtnExpExcel" 
                                                                                    Visible="False" ImageAlign="Right" />
                                                                            </asp:Panel>
                                                                            <div id="theLayer" style="position:absolute;width:350px;left:100;top:100;visibility:visible"></div>
                                                                            
                                                                        </td>
                                                                      </tr>
                                                                      <%--<tr align="center" class="rotulo"  >
                                                                        <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                      <tr align="center" class="rotulo"  >
                                                                        <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>--%>
                                                                      
                                                                      <tr>
                                                                        <td height="27"  colspan="6" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                                                      </tr>
                                                                    </table></td>
                                                                    <td width="17" align="left" valign="top" style="height: 24px">&nbsp;</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td style="height:24px"></td>
                                                                    <td colspan="11" align="left" valign="top">
                                                                      <div class="ContTitLiBxFoot">
                                                                          <asp:ImageButton ID="IbtnNuevo" runat="server" CausesValidation="False" 
                                                                              OnClick="IbtnNuevo_Click" skinid="IBtnNuevo" />
                                                                          <asp:ImageButton ID="IbtnGrabar" runat="server" CausesValidation="False" 
                                                                              onclientclick="guardarValorMedicion();" SkinID="IBtnGrabar"  onclick="IbtnGrabar_Click" />
                                                                      </div>
                                                                     </td>
                                                                    <td align="left" style="height: 24px" valign="top">&nbsp;</td>
                                                                    </tr>
                                                                  <tr>
                                                                    <td style="height:24px"></td>
                                                                    <td width="134" align="left" valign="top" class="obligatorio" 
                                                                                    style="height: 24px; width: 115px;">&nbsp;</td>
                                                                    <td width="10" style="height: 24px"></td>
                                                                    <td width="354" align="left" valign="top" style="height: 24px; width: 154px;">&nbsp;</td>
                                                                    <td width="10" style="height: 24px"></td>
                                                                    <td width="108" align="left" valign="top" class="obligatorio" style="height: 24px; width: 115px;" >&nbsp;</td>
                                                                    <td width="242" style="height: 24px">&nbsp;</td>
                                                                    <td width="15" align="left" valign="top" style="height: 24px; width: 354px;">&nbsp;</td>
                                                                    <td width="10" style="height: 24px"></td>
                                                                    <td width="15" align="left" 
                                                                                    valign="top" class="obligatorio" style="height: 24px; width: 115px;">&nbsp;</td>
                                                                    <td width="10" style="height: 24px"></td>
                                                                    <td width="15" align="left" valign="top" style="height: 24px; width: 354px;">&nbsp;</td>
                                                                    <td align="left" style="height: 24px" valign="top">&nbsp;</td>
                                                                    </tr>
                                                                  </table>
                                                                </td>
                                                             </tr>
                                                            
                                                          </table>
                                                          </asp:Panel>
                                                      </td>
                                                  </tr>
                                                </table>
                                          </td>
                                            <td style="width:15px"></td>
                                        </tr>
                                    </table>
                                                                                <asp:HiddenField ID="hddkeyln" runat="server" />
                                                                                <asp:HiddenField ID="hddkeyln2" runat="server" />
                                                                                <asp:HiddenField ID="hddkeydata" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue0" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue1" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue2" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue3" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue4" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue5" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue6" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue7" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue8" runat="server" />
                                                                                <asp:HiddenField ID="hddvalue9" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp0" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp1" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp2" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp3" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp4" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp5" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp6" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp7" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp8" runat="server" />
                                                                                <asp:HiddenField ID="HDDDataEsp9" runat="server" />
<script type="text/javascript">
    jQuery.curCSS = jQuery.css;
    function _DropDownOpening1(sender, eventArgs) {
        sender.clearSelection();
        sender.set_emptyMessage("");
    }

//    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
//    function EndRequestHandler(sender, args) {
//        if (args.get_error() != undefined) {
//            args.set_errorHandled(true);
//        }
//    }
</script>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" 
        VisibleOnPageLoad="True" AutoSize="True" AutoSizeBehaviors="Width, Height" 
        Behaviors="Minimize, Close" DestroyOnClose="True" 
        EnableViewState="False">
    </telerik:RadWindowManager>                                    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            
            <telerik:AjaxSetting AjaxControlID="cblequiposfiltros">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TreeEq2" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
          
            <telerik:AjaxSetting AjaxControlID="TreeEq2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="pnlmeding" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                        
                </UpdatedControls>
            </telerik:AjaxSetting>
             
            <telerik:AjaxSetting AjaxControlID="btnlectura0">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlmeding" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="RadWindow1" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="swcheck" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="RadWindow1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
                     
            <telerik:AjaxSetting AjaxControlID="GridLectura">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlmedGraf" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp0" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp1" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp2" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp3" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp4" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp5" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp6" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp7" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp8" />
                    <telerik:AjaxUpdatedControl ControlID="HDDDataEsp9" />
                    <telerik:AjaxUpdatedControl ControlID="hddkeyln" />
                    <telerik:AjaxUpdatedControl ControlID="hddkeyln2" />
                    <telerik:AjaxUpdatedControl ControlID="swcheck" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />

                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnlectura2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="hddkeydata" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlmedGraf" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnlectura3">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlmeding" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="RadWindow1" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlmedGraf" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="btningmed">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlmeding" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="IbtnGrabar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlmeding" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="pnlectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="GridLectura" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />    
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <%--
            <telerik:AjaxSetting AjaxControlID="Chk">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Pnlmedform" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
                            
            <telerik:AjaxSetting AjaxControlID="IbtnNuevo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlNuevoRegistro" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

           
--%>            
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
