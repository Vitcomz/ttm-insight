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
        String ARRsec = Request.QueryString["sec"];
        String ARRf1 = Request.QueryString["f1"];
        String ARRf2 = Request.QueryString["f2"];
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;


        if (ARRsec == "[ -- Seleccionar -- ]")
        {
            ARRsec = "";
        }
        
        StringBuilder sb1Eq = new StringBuilder();
        StringBuilder sb2Eq = new StringBuilder();
        StringBuilder sb3Eq = new StringBuilder();
        StringBuilder sb4Eq = new StringBuilder();
        StringBuilder sb5Eq = new StringBuilder();
        StringBuilder sb6Eq = new StringBuilder();
        StringBuilder sb7Eq = new StringBuilder();
        StringBuilder sb8Eq = new StringBuilder();
        StringBuilder sb9Eq = new StringBuilder();
        StringBuilder sbjsEq = new StringBuilder();
        StringBuilder sbjsEq2 = new StringBuilder();

        Indicadores BsninfIndicadores = new Indicadores();
        BsninfIndicadores.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        BsninfIndicadores.Form.Atributos.SetValue("id_faena", strLogFaena);
        BsninfIndicadores.Form.Atributos.SetValue("id_seccion", ARRsec);
        BsninfIndicadores.Form.Atributos.SetValue("fecha_inicio", String.Format("{0:MM/dd/yyyy}", ARRf1));
        BsninfIndicadores.Form.Atributos.SetValue("fecha_termino", String.Format("{0:MM/dd/yyyy}", ARRf2));

        DataSetWeb BswinfIndicadores = BsninfIndicadores.listardatos();
        DataSet DsinfIndicadores = BswinfIndicadores.Object;
        
        String color = "";
        String colorx = "";
        sb1Eq.Append("<table width='480'  BORDER='0'  align='center' cellpadding='1' cellspacing='1' bgcolor='#FFFFFF'><tr><td HEIGHT='23' colspan='8' align='center' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/encabezado.jpg' width='480px'/></td></tr>");
        sb1Eq.Append("<tr><td HEIGHT='23' colspan='8' align='center' valign='top'><font size='2' face='Arial'>INFORME DE INDICADORES</font><br /><font size='1' face='Arial'>FECHA DESDE " + ARRf1 + " - FECHA HASTA " + ARRf2 + "<br />FAENA " + strLogFaena + " - SECCION " + ARRsec + "</font><BR /><BR /></td></tr>");
        sb1Eq.Append("<tr ><td colspan='8' valign='top'>");

        sb1Eq.Append("<table width='100%' border='1' cellpadding='2' cellspacing='0'  class='calibri' id='TblIndicadores'>");
        sb1Eq.Append("<TR><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Fecha</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Tiempo Calendario</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>StandBy</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Mantenci&oacute;n Programada</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Fallas x Mantenci&oacute;n</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Operacionales Programadas</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Fallas x Operaci&oacute;n</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Total Detenciones</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Tiempo de Producci&oacute;n</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Total Fallas</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Disponibilidad</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Utilizaci&oacute;n</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>MTBF</font></TD><TD bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>MTTR</font></TD></TR>");



        for (int i = 0; i <= DsinfIndicadores.Tables[0].Rows.Count - 1; i++)
        {


            sb1Eq.Append("<tr ><TD align='center' width='180'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["NOMBRE"].ToString());
            if (DsinfIndicadores.Tables[0].Rows[i]["ANO"].ToString().Trim() != "")
            {
                sb1Eq.Append(" - " + DsinfIndicadores.Tables[0].Rows[i]["ANO"].ToString());
            }

            sb1Eq.Append("</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["TC"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["ST"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["MP"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["FM"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["OP"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["FO"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["TT"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["TP"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["NF"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["DISP"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["UTIL"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["MTBF"].ToString() + "</font></TD><TD align='center'><font size='1' face='Arial'>" + DsinfIndicadores.Tables[0].Rows[i]["MTTR"].ToString() + "</font></TD></tr>");


            sb4Eq.AppendFormat("<category label='" + DsinfIndicadores.Tables[0].Rows[i]["NOMBRE"].ToString() + "'/>");


            sb5Eq.AppendFormat("<set value='" + DsinfIndicadores.Tables[0].Rows[i]["MTBF"].ToString().Replace(',', '.') + "' />");

            sb6Eq.AppendFormat("<set value='" + DsinfIndicadores.Tables[0].Rows[i]["MTTR"].ToString().Replace(',', '.') + "' />");

            sb7Eq.AppendFormat("<category label='" + DsinfIndicadores.Tables[0].Rows[i]["NOMBRE"].ToString() + "'/>");

            sb8Eq.AppendFormat("<set value='" + DsinfIndicadores.Tables[0].Rows[i]["MTTR"].ToString().Replace(',', '.') + "' />");

        }
        sb2Eq.Append("<chart palette='2' caption='MTBF/MTTR' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php' PYAxisName='MTBF' SYAxisName='MTTR'>");
        sb2Eq.Append("<categories>" + sb4Eq.ToString() + "</categories>");
        sb2Eq.Append("<dataset seriesName='MTBF'  showValues='1' color='99CC33'>" + sb5Eq.ToString() + "</dataset>");
        sb2Eq.Append("<dataset seriesName='MTTR'  showValues='1' color='94B0BE' parentYAxis='S'>" + sb6Eq.ToString() + "</dataset>");
        sb2Eq.Append("</chart>");

        sbjsEq.Append("var chart = new FusionCharts(\"MSCombiDY2D.swf\", \"ChartId\", \"650\", \"450\", \"0\", \"0\"); chart.setDataXML(\"" + sb2Eq.ToString() + "\"); chart.render(\"chartdiv1\"); ");

        sb3Eq.Append("<chart palette='2' caption='MTTR' shownames='1'  showvalues='1' overlapBars='1' showShadow='1' imageSave='1' imageSaveURL='FCExporter.php'>");
        sb2Eq.Append("<categories>" + sb7Eq.ToString() + "</categories>");
        sb2Eq.Append("<dataset seriesName='MTTR'  showValues='1' color='94B0BE'>" + sb8Eq.ToString() + "</dataset>");
        sb3Eq.Append("</chart>");

        sbjsEq2.Append("var chart = new FusionCharts(\"MSColumnLine3D.swf\", \"ChartId\", \"850\", \"300\", \"0\", \"0\"); chart.setDataXML(\"" + sb2Eq.ToString() + "\"); chart.render(\"chartdiv3\"); ");


        sb1Eq.Append("</table></td></tr>");

        //sb1Eq.Append("</td></tr>");

        sb1Eq.Append("<tr CLASS='calibri'><td  colspan='8' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/Pie_informe.jpg'  align='bottom' width='480px'/></td></tr></table>");

       
                
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=report_grid.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter s_w = new StringWriter();
        HtmlTextWriter h_w = new HtmlTextWriter(s_w);

        //PnlZona.RenderControl(h_w);

        StringReader sr = new StringReader(sb1Eq.ToString());

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
        
        //ClientScript.RegisterStartupScript(typeof(string), "", "CloseDialog();");
    }

    public static bool RemoteFileExists(string url, int timeout)
    {
        try
        {
            //Creating the HttpWebRequest
            HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;

            // ************ ADDED HERE
            // timeout the request after x milliseconds
            request.Timeout = timeout;
            // ************

            //Setting the Request method HEAD, you can also use GET too.
            request.Method = "HEAD";
            //Getting the Web Response.
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            //Returns TRUE if the Status code == 200
            return (response.StatusCode == HttpStatusCode.OK);
        }
        catch
        {
            //Any exception will returns false.
            return false;
        }
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
    <asp:Label ID="lblscript" runat="server" Text="Label"></asp:Label>
 </form>
</body>
</html>