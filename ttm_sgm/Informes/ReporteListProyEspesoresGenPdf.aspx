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
        String fechaT = DateTime.Today.ToString("dd/MM/yyyy");
        String ARRsec = Request.QueryString["sec"];
        String ARRsecT = Request.QueryString["secT"];
        
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

        ProyEspesores BsninfProyEspesores = new ProyEspesores();
        BsninfProyEspesores.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        BsninfProyEspesores.Form.Atributos.SetValue("id_faena", strLogFaena);
        BsninfProyEspesores.Form.Atributos.SetValue("id_seccion", ARRsec);
        BsninfProyEspesores.Form.Atributos.SetValue("id_usuario", strLogUsuario);
        DataSetWeb BswinfProyEspesores = BsninfProyEspesores.listardatos();
        DataSet DsinfProyEspesores = BswinfProyEspesores.Object;


        PnlZona.Controls.Clear();

        System.Web.UI.HtmlControls.HtmlGenericControl CritDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
        
        CritDiv.ID = "CritDivCode";
        String color = "";
        String colorx = "";
        sb1Eq.Append("<table width='800'  BORDER='0'  align='center' cellpadding='0' cellspacing='3' class='calibri'><tr><td HEIGHT='23' colspan='3' align='center' valign='top'><img src='../../ttm_skins/images/_header/encabezado.jpg' width='800px'/></td></tr>");
        sb1Eq.Append("<tr><td HEIGHT='23' colspan='3' align='center' valign='top'><span class='calibri16'>INFORME PROYECCION ESPESORES </span><br /><span class='titulo'>FECHA " + fechaT + "</span><br /><span class='titulo'>FAENA " + strLogFaena + " - SECCION " + ARRsecT + "</span><BR /></td></tr>");

        sb1Eq.Append("<table width='100%' border='1' cellpadding='2' cellspacing='0'  class='calibri' id='TblProyEspesores'>");
        sb1Eq.Append("<tr><td HEIGHT='23' colspan='6' align='center' valign='top'  bgcolor='#FFFF99' ><span class='calibri16'>PROYECCIONES DE DESGASTE POR EQUIPO</span><br /></td></tr>");
        sb1Eq.Append("<TR><TD bgcolor='#FFFF99' align='center'>Equipo</TD><TD bgcolor='#FFFF99' align='center'>Prom. Desgaste</TD><TD bgcolor='#FFFF99' align='center'>Fecha Muestreo</TD><TD bgcolor='#FFFF99' align='center'>Ultimo Cambio</TD><TD bgcolor='#FFFF99' align='center'>Dias de Operacion</TD><TD bgcolor='#FFFF99' align='center'>Proyecci&oacute;n para Cambio</TD></TR>");



        for (int i = 0; i <= DsinfProyEspesores.Tables[0].Rows.Count - 1; i++)
        {


            sb1Eq.Append("<tr ><TD align='center'>" + DsinfProyEspesores.Tables[0].Rows[i]["EQUIPO"].ToString());
            sb1Eq.Append("</TD><TD align='center'>" + DsinfProyEspesores.Tables[0].Rows[i]["DESGASTE"].ToString() + "</TD><TD align='center'>" + String.Format("{0:dd/MM/yyyy}", DsinfProyEspesores.Tables[0].Rows[i]["FECHA_M"]) + "</TD><TD align='center'>" + String.Format("{0:dd/MM/yyyy}", DsinfProyEspesores.Tables[0].Rows[i]["FECHA_UTM"]) + "</TD><TD align='center'>" + DsinfProyEspesores.Tables[0].Rows[i]["DIAS"].ToString() + "</TD><TD align='center'>" + DsinfProyEspesores.Tables[0].Rows[i]["FECHA_CAMBIO"].ToString() + "</TD></tr>");


            sb4Eq.AppendFormat("<category label='" + DsinfProyEspesores.Tables[0].Rows[i]["EQUIPO"].ToString() + "'/>");

            sb5Eq.AppendFormat("<set label='" + DsinfProyEspesores.Tables[0].Rows[i]["EQUIPO"].ToString() + "'  value='" + DsinfProyEspesores.Tables[0].Rows[i]["DESGASTE"].ToString().Replace(',', '.') + "' />");

        }
        sb2Eq.Append("<chart palette='2' caption='% DE DESGASTE' shownames='1'  showvalues='1' formatNumberScale='0' showShadow='1' formatNumber='0'  rotateLabels='1' showYAxisValues='1' showDivLineValues='1' divLineThickness='3'  imageSave='1' imageSaveURL='../FCExporter.php'>");
        sb2Eq.Append("<categories>" + sb4Eq.ToString() + "</categories>");
        sb2Eq.Append("<dataset seriesName='% Desgaste'  showValues='1' color='FF0000'>" + sb5Eq.ToString() + "</dataset>");

        sb2Eq.Append("</chart>");

        sbjsEq.Append("var chart = new FusionCharts(\"MSColumn3D.swf\", \"ChartId\", \"850\", \"400\", \"0\", \"0\"); chart.setDataXML(\"" + sb2Eq.ToString() + "\"); chart.render(\"chartdiv1\"); ");

        sb1Eq.Append("</table></br></td></tr>");
        sb1Eq.Append("<tr CLASS='calibri'><td  colspan='3' valign='top'><div align='center' class='text' id='chartdiv1' style='z-index:1;'>Grafica de Pie.. </div></td></tr>");

        sb1Eq.Append("<tr CLASS='calibri'><td  colspan='3' valign='top'><img src='../../ttm_skins/images/_header/Pie_informe.jpg'  align='bottom'/></td></tr></table>");

        CritDiv.InnerHtml = sb1Eq.ToString();
        PnlZona.Controls.Add(CritDiv);
        ScriptManager.RegisterStartupScript(this, typeof(Page), "key", sbjsEq.ToString(), true);
        ScriptManager.RegisterStartupScript(this, typeof(Page), "key2", sbjsEq2.ToString(), true);

                
        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition", "attachment;filename=report_grid.pdf");
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //StringWriter s_w = new StringWriter();
        //HtmlTextWriter h_w = new HtmlTextWriter(s_w);

        ////PnlZona.RenderControl(h_w);

        //StringReader sr = new StringReader(sb1Eq.ToString());

        //Document pdfDoc = new Document(PageSize.LETTER, 80, 50, 30, 20);
        
        //StyleSheet styles = new StyleSheet();
        ////styles.LoadStyle("calibri16", "size", "12pt");
        ////styles.LoadStyle("calibri16", "color", "#000000");
        ////styles.LoadStyle("calibri16", "weight", "bold");
        ////styles.LoadStyle("titulo", "size", "8pt");
        ////styles.LoadStyle("titulo", "color", "#797C7D");
        ////styles.LoadStyle("titulo", "weight", "bold");
        ////styles.LoadStyle("calibri", "size", "6pt");
        ////styles.LoadStyle("calibri", "color", "#000000");
        ////styles.LoadStyle("calibri", "weight", "bold");
        ////Arial,Helvetica,sans-serif
            
        
        ////string path = Server.MapPath("~/sgm/Files");
        ////FileStream stream = new FileStream(path + "/result.pdf", FileMode.Create);

        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc, new HTMLTagProcessors(), null);
        
        //PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        ////PdfWriter PDFWriter = PdfWriter.GetInstance(pdfDoc, stream);


        
        //pdfDoc.Open();

        //try
        //{
        //    //pdfDoc.NewPage();
        //    htmlparser.Parse(sr);
        //    htmlparser.SetStyleSheet(styles);
        //}
        //catch (Exception)
        //{
        //}
        //finally
        //{
        //    //stream.Close();
        //}
        //pdfDoc.Close();

        //Response.Write(pdfDoc);
        //Response.End();
        
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
<script src="../Operaciones/fusioncharts_.js" type="text/javascript"></script>
<script src="../Operaciones/fusioncharts.charts_.js" type="text/javascript"></script>
<script src="../Operaciones/fusioncharts.theme.fint_.js" type="text/javascript"></script>
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
<STYLE type="text/css">
<!--
body {
    color: #333333;
    font-family: MyriadPro-Regular, Arial, Tahoma, Verdana;
    font-size: 11px;
    text-align: center;
}
-->
</STYLE>



    <asp:Panel ID="PnlZona" runat="server" Width="900px"></asp:Panel>
    <asp:HiddenField ID="hddReportHtml" runat="server" />
    <asp:Label ID="lblscript" runat="server" Text=""></asp:Label>
 </form>
 <script type="text/javascript">
     setTimeout(function () { window.print(); setTimeout(function () { window.close(); }, 1000); }, 6000);

</script>
</body>
</html>