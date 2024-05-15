<%@ Page Language="C#" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="iTextSharp.text" %>
<%@ Import Namespace="iTextSharp.text.html" %>
<%@ Import Namespace="iTextSharp.text.pdf" %>
<%@ Import Namespace="iTextSharp.text.html.simpleparser" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.UI.WebControls.WebParts" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>
<%@ Import Namespace="ttm.DataLayer" %>
<%@ Import Namespace="ttm.Business" %>
<%@ Import Namespace="ttm.ViewFunctionLibrary" %>
<%@ Import Namespace="Telerik.Web.UI" %>
<%@ Import Namespace="ttm.Security" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">






<script runat="server">
    public int actprocedimiento = 0;
    public string key;
    private vFx vFx = new vFx();
    public StringBuilder sb1Eq = new StringBuilder();
    public StringBuilder sb2Eq = new StringBuilder();
    private void CargaGrid()
    {


        String strLogFaena = Session["emp"].ToString().ToUpper();
        String strLogUsuario = Session["log"].ToString().ToUpper();
        String fecha1 = "01/01/2009";
        String fecha2 = DateTime.Today.ToString("dd/MM/yyyy");
        String ARRseccion = Request.QueryString["sec"];
        String ARReq = Request.QueryString["eq"];
        String ARRcrit = Request.QueryString["crit"];
        String ARRf1 = Request.QueryString["fech1"];
        String ARRf2 = Request.QueryString["fech2"];
        String seccion = ARRseccion;
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;



        infpolines Bsninfpolines = new infpolines();
        Bsninfpolines.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        Bsninfpolines.Form.Atributos.SetValue("id_equipo", ARReq);
        Bsninfpolines.Form.Atributos.SetValue("id_seccion", ARRseccion);
        //DateTime dt1 = Convert.ToDateTime(rddate1.SelectedDate);
        //DateTime dt2 = Convert.ToDateTime(rddate2.SelectedDate);
        Bsninfpolines.Form.Atributos.SetValue("fecha_inicio", ARRf1.ToString());
        Bsninfpolines.Form.Atributos.SetValue("fecha_termino", ARRf2.ToString());
        Bsninfpolines.Form.Atributos.SetValue("id_faena", strLogFaena);
        //Bsninfpolines.Form.Atributos.SetValue("id_usuario", strLogUsuario);
        Bsninfpolines.Form.Atributos.SetValue("criticidad", ARRcrit);

        DataSetWeb Bswinfpolines = Bsninfpolines.listardatos();
        DataSet Dsinfpolines = Bswinfpolines.Object;

        PnlZona.Controls.Clear();

        System.Web.UI.HtmlControls.HtmlGenericControl CritDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
        CritDiv.ID = "CritDivCode";
        //CritDiv.Style.Add(HtmlTextWriterStyle.Width, "460px");
        //CritDiv.Style.Add(HtmlTextWriterStyle.Height, "582px");
        String color = "";
        String colorx = "";
        sb1Eq.Append("<table cellpadding='2' cellspacing='0'  BORDER='0' BORDERCOLOR='#000000'  CLASS='calibri'><tr><td WIDTH='188' ROWSPAN='2' colspan='2'><img SRC='../../ttm_skins/images/_header/Logo_informe.jpg'/></td>");
        sb1Eq.Append("<td WIDTH='405' HEIGHT='45' colspan='2' ALIGN='CENTER' VALIGN='TOP' CLASS='PlTit2'>SISTEMA DE GESTION INTEGRADO<br />INFORME POLINES DE INSPECCIONES</td>");
        sb1Eq.Append("<td WIDTH='402' VALIGN='TOP' CLASS='PlTit3' colspan='3'>FECHA DE INSPECCION </br>DESDE: " + ARRf1.ToString() + " HASTA: " + ARRf2.ToString() + "</td></tr>");
        sb1Eq.Append("<tr><td HEIGHT='25' CLASS='PlTit3' colspan='7'>CLIENTE: " + strLogFaena + " - SECCION " + ARRseccion + " - EQUIPO " + ARReq + "</td>");
        sb1Eq.Append("</tr>");
        //Hddtime.Value = Dsinfpolines.Tables[0].Rows.Count.ToString();


        sb1Eq.Append("<tr name='rowsdata'><td class='PlTitDet1' colspan='5'>");

        sb1Eq.Append("<table><tr><td><table cellpadding='2' cellspacing='1'  BORDER='1' BORDERCOLOR='#000000'  CLASS='calibri'><tr><td HEIGHT='15' colspan='10' align='center'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='center' class='LitleTextTit3'><b>IZQUIERDA</b></td><td align='center' class='LitleTextTit3'><b>CENTRO</b></td><td align='center' class='LitleTextTit3'><b>DERECHA</b></td></tr><tr><td VALIGN='TOP'><table width='100%' border='0' cellpadding='1' cellspacing='0'><tr bordercolor='#000000' class='PlTitEncab1'><td></td><td align='center'><b>MESA</b></td><td align='center'><b>ESTACION</b></td><td align='center'><b>TIPO</b></td><td align='center'><b>FALLA</b></td><td align='center'><b>INSPECCION</b></td><td align='center'><b>CAMBIO</b></td></tr>");

        for (int i = 0; i <= Dsinfpolines.Tables[0].Rows.Count - 1; i++)
        {
            if (Dsinfpolines.Tables[0].Rows[i]["POSICION"].ToString() == "IZQ")
            {

                switch (Dsinfpolines.Tables[0].Rows[i]["COLOR"].ToString())
                {
                    case "ALTA":
                        color = "bgcolor='#FF3535' ";
                        VarAlta = +1;
                        break;
                    case "MEDIA":
                        color = "bgcolor='#fff000' ";
                        VarMedia = +1;
                        break;
                    default:
                        color = "bgcolor='#0083cd' ";
                        VarBaja = +1;
                        break;
                }
                VarLInea = +1;
                sb1Eq.Append("<tr><td " + color + ">" + Dsinfpolines.Tables[0].Rows[i]["COLOR"].ToString() + "</td><td class='PlTitDet1'><span id='1x'>" + Dsinfpolines.Tables[0].Rows[i]["MESA"].ToString() + "</span></td><td class='PlTitDet1'><span id='2x'>" + Dsinfpolines.Tables[0].Rows[i]["ESTACION"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["TIPO"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["FALLAS"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["INSPECCION"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["CAMBIO"].ToString() + "</span></td></tr>");
            }
        }
        sb1Eq.Append("</table></td><td VALIGN='TOP'><table width='100%' border='0' cellpadding='1' cellspacing='0'><tr bordercolor='#000000' class='PlTitEncab1'><td></td><td align='center'><b>MESA</b></td><td align='center'><b>ESTACION</b></td><td align='center'><b>TIPO</b></td><td align='center'><b>FALLA</b></td><td align='center'><b>INSPECCION</b></td><td align='center'><b>CAMBIO</b></td></tr>");
        for (int i = 0; i <= Dsinfpolines.Tables[0].Rows.Count - 1; i++)
        {
            if (Dsinfpolines.Tables[0].Rows[i]["POSICION"].ToString() == "CEN")
            {
                switch (Dsinfpolines.Tables[0].Rows[i]["COLOR"].ToString())
                {
                    case "ALTA":
                        color = "bgcolor='#FF3535' ";
                        VarAlta = +1;
                        break;
                    case "MEDIA":
                        color = "bgcolor='#fff000' ";
                        VarMedia = +1;
                        break;
                    default:
                        color = "bgcolor='#0083cd' ";
                        VarBaja = +1;
                        break;
                }
                VarLInea = +1;
                sb1Eq.Append("<tr><td " + color + ">" + Dsinfpolines.Tables[0].Rows[i]["COLOR"].ToString() + "</td><td class='PlTitDet1'><span id='1x'>" + Dsinfpolines.Tables[0].Rows[i]["MESA"].ToString() + "</span></td><td class='PlTitDet1'><span id='2x'>" + Dsinfpolines.Tables[0].Rows[i]["ESTACION"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["TIPO"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["FALLAS"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["INSPECCION"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["CAMBIO"].ToString() + "</span></td></tr>");
            }
        }
        sb1Eq.Append("</table></td><td VALIGN='TOP'><table width='100%' border='0' cellpadding='1' cellspacing='0'><tr bordercolor='#000000' class='PlTitEncab1'><td></td><td align='center'><b>MESA</b></td><td align='center'><b>ESTACION</b></td><td align='center'><b>TIPO</b></td><td align='center'><b>FALLA</b></td><td align='center'><b>INSPECCION</b></td><td align='center'><b>CAMBIO</b></td></tr>");
        for (int i = 0; i <= Dsinfpolines.Tables[0].Rows.Count - 1; i++)
        {
            if (Dsinfpolines.Tables[0].Rows[i]["POSICION"].ToString() == "DER")
            {
                switch (Dsinfpolines.Tables[0].Rows[i]["COLOR"].ToString())
                {
                    case "ALTA":
                        color = "bgcolor='#FF3535' ";
                        VarAlta = +1;
                        break;
                    case "MEDIA":
                        color = "bgcolor='#fff000' ";
                        VarMedia = +1;
                        break;
                    default:
                        color = "bgcolor='#0083cd' ";
                        VarBaja = +1;
                        break;
                }
                VarLInea = +1;
                sb1Eq.Append("<tr><td " + color + ">" + Dsinfpolines.Tables[0].Rows[i]["COLOR"].ToString() + "</td><td class='PlTitDet1'><span id='1x'>" + Dsinfpolines.Tables[0].Rows[i]["MESA"].ToString() + "</span></td><td class='PlTitDet1'><span id='2x'>" + Dsinfpolines.Tables[0].Rows[i]["ESTACION"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["TIPO"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["FALLAS"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["INSPECCION"].ToString() + "</span></td><td class='PlTitDet1'><span id='3x'>" + Dsinfpolines.Tables[0].Rows[i]["CAMBIO"].ToString() + "</span></td></tr>");
            }
        }
        sb1Eq.Append("</table></td></tr></table></td></tr></table></td></tr></table>");

        sb1Eq.Append("</TD></tr>");


        sb1Eq.Append("</table>");
        CritDiv.InnerHtml = sb1Eq.ToString();
        PnlZona.Controls.Add(CritDiv);

        infpolines Bsninfpolines2 = new infpolines();
        Bsninfpolines2.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        Bsninfpolines2.Form.Atributos.SetValue("id_equipo", ARReq);
        Bsninfpolines2.Form.Atributos.SetValue("id_seccion", ARRseccion);
        //DateTime dt1x = Convert.ToDateTime(rddate1.SelectedDate);
        //DateTime dt2x = Convert.ToDateTime(rddate2.SelectedDate);
        Bsninfpolines2.Form.Atributos.SetValue("fecha_inicio", ARRf1.ToString());
        Bsninfpolines2.Form.Atributos.SetValue("fecha_termino", ARRf2.ToString());
        Bsninfpolines2.Form.Atributos.SetValue("id_faena", strLogFaena);
        //Bsninfpolines2.Form.Atributos.SetValue("id_usuario", strLogUsuario);
        Bsninfpolines2.Form.Atributos.SetValue("criticidad", ARRcrit);
        DataSetWeb Bswinfpolines2 = Bsninfpolines2.listardatos();
        DataSet Dsinfpolines2 = Bswinfpolines2.Object;

        String strXML = "";
        String strXMLTit;
        String auxs = "";
        String auxs2 = "</dataset>";
        int posx = 0;
        int totpos = 0;
        String cssx = "";
        int xs = 3;
        string[] arrColor = { "FF0000", "FF8000", "FF8000", "40FF00", "00FFFF", "0040FF", "BF00FF", "FF0080", "F6E3CE", "D8F6CE", "F6CEF5", "CEE3F6" };

        for (int i = 0; i <= Dsinfpolines2.Tables[0].Rows.Count - 1; i++)
        {
            if (auxs != Dsinfpolines2.Tables[0].Rows[i]["FALLAS"].ToString())
            {
                if (auxs != "") { strXML = strXML + auxs2; }
                //cssx = RandomHexString();
                if ((xs - 3) == 12)
                {
                    xs = 0;
                }
                cssx = arrColor[xs - 3];
                auxs = Dsinfpolines2.Tables[0].Rows[i]["FALLAS"].ToString();
                strXML = strXML + "<dataset seriesName='" + Dsinfpolines2.Tables[0].Rows[i]["FALLAS"].ToString() + "' color='" + cssx + "' anchorSides='" + xs + "' anchorRadius='5' anchorBorderThickness = '1' anchorBgColor='" + cssx + "' anchorBorderColor='" + cssx + "'>";
                xs = xs + 1;
                //color='009900' anchorSides='3' anchorRadius='4' anchorBgColor='D5FFD5' anchorBorderColor='009900'
            }
            // 	IZQ = 2.5; CEN = 1.5; DER = 0.5
            int mes = Convert.ToInt16(Dsinfpolines2.Tables[0].Rows[i]["MESA"].ToString().Replace('N', ' '));
            if (mes > posx)
            {
                posx = mes;
            }
            if (Dsinfpolines2.Tables[0].Rows[i]["POSICION"].ToString() == "IZQ")
            {
                strXML = strXML + "<set y='0.5' x='" + mes + "' ></set>";
            }
            else if (Dsinfpolines2.Tables[0].Rows[i]["POSICION"].ToString() == "CEN")
            {
                strXML = strXML + "<set y='1.5' x='" + mes + "' ></set>";
            }
            else if (Dsinfpolines2.Tables[0].Rows[i]["POSICION"].ToString() == "DER")
            {
                strXML = strXML + "<set y='2.5' x='" + mes + "' ></set>";
            }
        }
        strXML = strXML + auxs2;
        strXML = strXML + "<categories verticalLineColor='666666' verticalLineThickness='1'>";
        if (posx <= 10)
        {
            totpos = 10;
            strXML = strXML + "<category y='1' label='1' ></category><category label='2' x='2' showVerticalLine='0'></category><category label='3' x='3' showVerticalLine='0'></category><category label='4' x='4' showVerticalLine='0'></category><category label='5' x='5' showVerticalLine='0'></category><category label='6' x='6' showVerticalLine='0'></category><category label='7' x='7' showVerticalLine='0'></category><category label='8' x='8' showVerticalLine='0'></category><category label='9' x='9' showVerticalLine='0'></category><category label='10' x='10' showVerticalLine= '0'></category>";
        }
        else if (posx <= 50)
        {
            totpos = 50;
            strXML = strXML + "<category y='1' label='1' ></category><category label='5' x='5' showVerticalLine='0'></category><category label='10' x='10' showVerticalLine='0'></category><category label='15' x='15' showVerticalLine='0'></category><category label='20' x='20' showVerticalLine='0'></category><category label='25' x='25' showVerticalLine='0'></category><category label='30' x='30' showVerticalLine='0'></category><category label='35' x='35' showVerticalLine='0'></category><category label='40' x='40' showVerticalLine='0'></category><category label='45' x='45' showVerticalLine='0'></category><category label='50' x='50' showVerticalLine= '0'></category>";
        }
        else if (posx <= 100)
        {
            totpos = 100;
            strXML = strXML + "<category y='1' label='1' ></category><category label='10' x='10' showVerticalLine='0'></category><category label='20' x='20' showVerticalLine='0'></category><category label='30' x='30' showVerticalLine='0'></category><category label='40' x='40' showVerticalLine='0'></category><category label='50' x='50' showVerticalLine='0'></category><category label='60' x='60' showVerticalLine='0'></category><category label='70' x='70' showVerticalLine='0'></category><category label='80' x='80' showVerticalLine='0'></category><category label='90' x='90' showVerticalLine='0'></category><category label='100' x='100' showVerticalLine= '0'></category>";
        }
        else if (posx <= 1000)
        {
            totpos = 1000;
            strXML = strXML + "<category y='1' label='1' showVerticalLine='0' ></category><category label='100' x='100' showVerticalLine='0'></category><category label='200' x='200' showVerticalLine='0'></category><category label='300' x='3000' showVerticalLine='0'></category><category label='400' x='400' showVerticalLine='0'></category><category label='500' x='500' showVerticalLine='0'></category><category label='600' x='600' showVerticalLine='0'></category><category label='700' x='700' showVerticalLine='0'></category><category label='800' x='800' showVerticalLine='0'></category><category label='900' x='900' showVerticalLine='0'></category><category label='1000' x='1000' showVerticalLine= '0'></category>";
        }
        else if (posx <= 2000)
        {
            totpos = 2000;
            strXML = strXML + "<category y='1' label='1' ></category><category label='200' x='200' showVerticalLine='0'></category><category label='400' x='400' showVerticalLine='0'></category><category label='600' x='600' showVerticalLine='0'></category><category label='800' x='800' showVerticalLine='0'></category><category label='1000' x='1000' showVerticalLine='0'></category><category label='1200' x='1200' showVerticalLine='0'></category><category label='1400' x='1400' showVerticalLine='0'></category><category label='1600' x='1600' showVerticalLine='0'></category><category label='1800' x='1800' showVerticalLine='0'></category><category label='2000' x='2000' showVerticalLine= '0'></category>";
        }

        strXMLTit = "<chart palette='2' caption='Eventos' yAxisName='IZQ          CEN          DER' xAxisName='Cinta Transportadora' xAxisMaxValue='" + totpos + "'  xAxisMinValue='0' yAxisMaxValue='3'  >";

        strXML = strXML + "</categories>";
        strXML = strXML + "</chart>";

        //->hddxml.Value = strXMLTit + strXML;
        lblscript.Text = strXMLTit + strXML;
        //PnlGrafico.Controls.Clear();
        //System.Web.UI.HtmlControls.HtmlGenericControl CritDiv2 = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
        //CritDiv2.InnerHtml = "<div align='center' class='text' id='chartdiv3' style='z-index:1;'>Grafica de Pie.. </div>";<
        //PnlGrafico.Controls.Add(CritDiv2);
        //->sb2Eq.Append("var chart = new FusionCharts(\"Scatter.swf\", \"ChartId\", \"900\", \"300\", \"0\", \"1\"); chart.setDataXML(\"" + strXMLTit + strXML + "\"); chart.render(\"chartdiv3\"); ");
        ////updateChart('chartdiv3');
        //->ScriptManager.RegisterStartupScript(this, typeof(Page), "key", sb2Eq.ToString(), true);
        //ScriptManager.RegisterStartupScript(this, typeof(Page), "key", "updateChart('chartdiv3');", true);

        
        //ClientScript.RegisterStartupScript(typeof(string), "", "CloseDialog();");
    }

       
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            CargaGrid();
        }
    }

</script>
 

 
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
 <title></title>
 <script type="text/javascript" src="FusionCharts.js"></script>
 <link href="../../App_Themes/ttm/ttm.css" type="text/css" rel="stylesheet">
 <link href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" type="text/css">
 <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css">

</head>
<body>
 <form id="form1" runat="server">
 <telerik:RadCodeBlock runat="server" ID="rcb1">
<script language="javascript" type="text/javascript">

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function CloseDialog(button) {
        GetRadWindow().close();
    }  

</script>
</telerik:RadCodeBlock>
    <asp:Panel ID="PnlZona" runat="server" ScrollBars="Auto"  Width="900px"></asp:Panel>
    <asp:Panel ID="PnlGrafico" runat="server" ScrollBars="Auto" Height="300px" Width="900px">
        <div id="chartdiv3"></div>
    </asp:Panel>
    <asp:HiddenField ID="hddReportHtml" runat="server" />
    <asp:Label ID="lblscript" runat="server"></asp:Label>
 </form>
 <script language="JavaScript">
     function generateXML(animate) {
         var scripts = document.getElementById("lblscript").innerHTML;
         return scripts;
     }
     FusionCharts.printManager.enabled(true);

     FusionCharts.setCurrentRenderer('javascript');
     var chart1 = new FusionCharts("Scatter.swf", "chart1Id", "900", "300", "0", "1");
     //Initialize chart with empty data. We'll feed it data on the chart's FC_Rendered event.

     chart1.setDataXML("<chart></chart>");
     //chart1.setDataXML(strXMLTit + strXML);
     chart1.render("chartdiv3");


     FusionCharts.addEventListener(
			  FusionChartsEvents.PrintReadyStateChange,
			  function (identifier, parameter) {
			      if (parameter.ready) {
			          //alert("Chart is now ready for printing.");
			      }
			  });

     function FC_Rendered(domId) {
         //It is in this method that you can update chart's data using JS methods.
         //Check if this is the chart that we want to update
         if (domId == "chart1Id") {
             //Set chartLoaded flag to true
             chartLoaded = true;

             //Get reference to chart object using Dom ID
             var chartObj = getChartFromId(domId);
             //Update it's XML - set animate Flag to true
             chartObj.setDataXML(generateXML(true));
         }	
         setTimeout(function () { FusionCharts.printManager.managedPrint(); }, 2000);

         return true;


     }					
			
		</script>
</body>
</html>