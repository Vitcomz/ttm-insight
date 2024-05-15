<%@ Page Language="C#" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Web" %>
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


        StringBuilder sb1Eq = new StringBuilder();
        StringBuilder sb2Eq = new StringBuilder();
        StringBuilder sb1EqTable = new StringBuilder();
        StringBuilder sb2EqTable = new StringBuilder();
        StringBuilder sbxEq = new StringBuilder();
        StringBuilder sbjsEq = new StringBuilder();
        String strLogFaena = Session["emp"].ToString().ToUpper();
        String strLogUsuario = Session["log"].ToString().ToUpper();
        String ARRseccion = Request.QueryString["sec"];
        String ARRf1 = Request.QueryString["fech1"];
        String fecha1 = "01/01/2009";
        String fecha2 = DateTime.Today.ToString("dd/MM/yyyy");
        Double VarAlta = 0;
        Double VarMedia = 0;
        Double VarBaja = 0;
        Double VarLInea = 0;
        GrafCriticidad Bsngrafcriticidad = new GrafCriticidad();
        Bsngrafcriticidad.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        Bsngrafcriticidad.Form.Atributos.SetValue("id_equipos", "");
        Bsngrafcriticidad.Form.Atributos.SetValue("fecha_criticidad", ARRf1);
        Bsngrafcriticidad.Form.Atributos.SetValue("id_faena", strLogFaena);
        Bsngrafcriticidad.Form.Atributos.SetValue("id_seccion", ARRseccion);
        Bsngrafcriticidad.Form.Atributos.SetValue("criticidad", "");
        DataSetWeb Bswgrafcriticidad = Bsngrafcriticidad.listardatos();
        DataSet Dsgrafcriticidad = Bswgrafcriticidad.Object;

        String color = "";
        String colorx = "";
        sb1Eq.Append("<table width='480'  BORDER='0'  align='center' cellpadding='1' cellspacing='1' bgcolor='#FFFFFF'><tr><td HEIGHT='23' colspan='2' align='center' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/encabezado.jpg' width='480px'/></td></tr>");
        sb1Eq.Append("<tr><td HEIGHT='23' colspan='2' align='center' valign='top'><font size='2' face='Arial, Helvetica, sans-serif'>INFORME DE CRITICIDAD</font><br /><font size='1' face='Arial, Helvetica, sans-serif'>FECHA " + fecha2 + "<br />FAENA " + strLogFaena + "</font><BR /></td></tr>");

        sb1Eq.Append("<tr ><td height='42' colspan='2'  valign='bottom'  align='left' color='#FFFFFF'  bgcolor='#0083cd'><font size='1' face='Arial, Helvetica, sans-serif'>SECCION : " + ARRseccion + "</font></td></tr><tr><td valign='top' align='left' width='200'>");


        sb1Eq.Append("<table id='basic-table' border='1' cellspacing='1' cellpadding='2' width='200'><tr><td bgcolor='#0072C6'><b><font size='-4' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>Equipo</font></b></td><td bgcolor='#0072C6'><b><font size='-4' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>Valor Criticidad</font></b></td><td bgcolor='#0072C6'><b><font size='-4' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>Criticidad</font></b></td></tr>");
            
            for (int i = 0; i <= Dsgrafcriticidad.Tables[0].Rows.Count - 1; i++)
            {
                switch (Dsgrafcriticidad.Tables[0].Rows[i]["COLOR"].ToString())
                {
                    case "ALTA":
                        color = " bgcolor='#FF3535' ";
                        colorx = " color='#ffffff'";
                        VarAlta = VarAlta + 1;
                        break;
                    case "MEDIA":
                        color = " bgcolor='#fff000'";
                        colorx = "";
                        VarMedia = VarMedia + 1;
                        break;
                    default:
                        color = " bgcolor='#0083cd'";
                        colorx = " color='#ffffff'";
                        VarBaja = VarBaja + 1;
                        break;
                }
                VarLInea = VarLInea + 1;
                sb1Eq.Append("<tr><td><font size='-4' face='Arial, Helvetica, sans-serif'>" + Dsgrafcriticidad.Tables[0].Rows[i]["EQUIPO"].ToString() + "</font></td><td><font size='-4' face='Arial, Helvetica, sans-serif'>" + Dsgrafcriticidad.Tables[0].Rows[i]["VALOR"].ToString() + "</font></td><td " + color + "><font size='-4' face='Arial, Helvetica, sans-serif' " + colorx + ">" + Dsgrafcriticidad.Tables[0].Rows[i]["COLOR"].ToString().ToUpperInvariant() + "</font></td></tr>");
                   
            }

            sb1Eq.Append("</table><br><br>");
            sb1Eq.Append("</td><td valign='top' align='left'><div align='center' class='text' id='chartdiv3' style='z-index:1;'>Grafica de Pie.. </div>");
            sb1Eq.Append("</td>");
            sb1Eq.Append("</tr>");
        
        sb1Eq.Append("<tr CLASS='calibri'><td  colspan='2' valign='top'></td></tr></table>");//<img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/Pie_informe.jpg'  align='bottom' width='480px'/>
        
        sb2Eq.Append("<chart palette='2' showPercentageValues='1' caption='Criticidad de Equipos' shownames='1' showvalues='1' showSum='1' decimals='1' overlapBars='1' showShadow='1' bgColor='99CCFF,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' showBorder='1' startingAngle='70'>");
        sb2Eq.AppendFormat("<set color='FF0000' label='ALTA' value='" + Math.Round((VarAlta / VarLInea) * 100, 0) + "' isSliced='1'/><set color='FFFF00' label='MEDIA' value='" + Math.Round((VarMedia / VarLInea) * 100, 0) + "' isSliced='1'/><set color='3366FF' label='BAJA' value='" + Math.Round((VarBaja / VarLInea) * 100, 0) + "' isSliced='1'/>");
        sb2Eq.Append("</chart>");




        StringWriter s_w = new StringWriter();
        HtmlTextWriter h_w = new HtmlTextWriter(s_w);

        PnlZona.RenderControl(h_w);

        StringReader sr = new StringReader(sb1Eq.ToString());
        System.Web.UI.HtmlControls.HtmlGenericControl CritDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
        CritDiv.ID = "CritDivCode";
        CritDiv.InnerHtml = sb1Eq.ToString();
        PnlZona.Controls.Add(CritDiv);

        sbjsEq.Append("var chart = new FusionCharts(\"Pie3D.swf\", \"ChartId\", \"450\", \"400\", \"0\", \"0\"); chart.setDataXML(\"" + sb2Eq.ToString() + "\"); chart.render(\"chartdiv3\"); ");
        ScriptManager.RegisterStartupScript(this, typeof(Page), "key", sbjsEq.ToString(), true);

        
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=report_grid.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Document pdfDoc = new Document(PageSize.LETTER, 80, 50, 30, 20);

        StyleSheet styles = new StyleSheet();
        //styles.LoadStyle("calibri16", "size", "12pt");
        //styles.LoadStyle("calibri16", "color", "#000000");
        //styles.LoadStyle("calibri16", "weight", "bold");
        //styles.LoadStyle("titulo", "size", "8pt");
        //styles.LoadStyle("titulo", "color", "#797C7D");
        //styles.LoadStyle("titulo", "weight", "bold");
        //styles.LoadStyle("calibri", "size", "6pt");
        //styles.LoadStyle("calibri", "color", "#000000");
        //styles.LoadStyle("calibri", "weight", "bold");
        //Arial,Helvetica,sans-serif


        //string path = Server.MapPath("~/sgm/Files");
        //FileStream stream = new FileStream(path + "/result.pdf", FileMode.Create);

        HTMLWorker htmlparser = new HTMLWorker(pdfDoc, new HTMLTagProcessors(), null);

        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //PdfWriter PDFWriter = PdfWriter.GetInstance(pdfDoc, stream);



        pdfDoc.Open();

        try
        {
            //pdfDoc.NewPage();
            htmlparser.Parse(sr);
            htmlparser.SetStyleSheet(styles);
        }
        catch (Exception)
        {
        }
        finally
        {
            //stream.Close();
        }
        pdfDoc.Close();

        Response.Write(pdfDoc);
        Response.End();



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
</head>
<body>
 <script type="text/javascript" src="FusionCharts.js"></script>
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

    <asp:Panel ID="PnlZona" runat="server" ScrollBars="Auto" Height="650px" Width="900px"></asp:Panel>
    <asp:HiddenField ID="hddReportHtml" runat="server" />
 </form>
</body>
</html>