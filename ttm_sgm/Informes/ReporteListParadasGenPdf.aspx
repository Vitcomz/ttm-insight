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
        String ARRtip = Request.QueryString["tip"];
        String ARRtipT = Request.QueryString["tipT"];
        String ARRact = Request.QueryString["act"];
        String ARRt1 = Request.QueryString["t1"];
        String ARRt2 = Request.QueryString["t2"];
        String seccion = ARRseccion;
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;



        Paradas BsnParadas = new Paradas();
        BsnParadas.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        BsnParadas.Form.Atributos.SetValue("id_seccion", ARRseccion);
        BsnParadas.Form.Atributos.SetValue("id_faena", Session["emp"].ToString().ToUpper());
        BsnParadas.Form.Atributos.SetValue("id_equipo", ARReq);
        BsnParadas.Form.Atributos.SetValue("id_paradas", "");
        BsnParadas.Form.Atributos.SetValue("id_tipo_falla", ARRtip);
        BsnParadas.Form.Atributos.SetValue("fecha_ini_Paradas", ARRt1);
        BsnParadas.Form.Atributos.SetValue("fecha_fin_Paradas", ARRt2);
        BsnParadas.Form.Atributos.SetValue("estado_Paradas", ARRact);

        DataSetWeb BswParadas = BsnParadas.listardatos();
        DataSet DsParadas = BswParadas.Object;

        String color = "";
        String colorx = "";
        sb1Eq.Append("<table BORDER='0'  align='center' cellpadding='1' cellspacing='1' bgcolor='#FFFFFF'><tr><td  align='center' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/encabezado.jpg' width='500px'/></td></tr>");
        sb1Eq.Append("<tr><td align='center' valign='top'><font size='2' face='Arial, Helvetica, sans-serif'>INFORME DE PARADAS</font><br /><font size='1' face='Arial, Helvetica, sans-serif'>FECHA DESDE " + ARRt1.Substring(0, 10) + " - FECHA HASTA " + ARRt2.Substring(0, 10) + "<br />FAENA " + strLogFaena + "<BR />");
        if (seccion != ""){
            sb1Eq.Append("-  AREA " + seccion + "<BR />");
        }
        if (ARRtipT != "")
        {
            sb1Eq.Append(" TIPO DETECCION " + ARRtipT);
        }
        sb1Eq.Append("</font><BR /><BR /></td></tr></table>");
        sb1Eq.Append("<table id='tabEquipos'  border='1' cellspacing='0' cellpadding='1'  width='100%'>");
        sb1Eq.Append("<tr><td bgcolor='#FFFF99' align='center' ><p style='font-family:arial; font-size:6px;'>FOLIO</p></td><td bgcolor='#FFFF99' align='center'><p style='font-family:arial; font-size:6px;'>F. INICIO</p></td><td bgcolor='#FFFF99' align='center'><p style='font-family:arial; font-size:6px;'>F.TERMINO</p></td><td bgcolor='#FFFF99' align='center'><p style='font-family:arial; font-size:6px;'>TOTAL HRS.</p></td><td bgcolor='#FFFF99' align='center'><p style='font-family:arial; font-size:6px;'>EQUIPO</p></td><td bgcolor='#FFFF99' align='center' ><p style='font-family:arial; font-size:6px;'>COMPONENTE</p></td><td bgcolor='#FFFF99' align='center' ><p style='font-family:arial; font-size:6px;'>TIPO</p></td><td bgcolor='#FFFF99' align='center' ><p style='font-family:arial; font-size:6px;'>CAUSA</p></td><td bgcolor='#FFFF99' align='center' ><p style='font-family:arial; font-size:6px;'>OBSERVACION</p></td></tr>");

        sb1Eq.Append("<tbody>");
        for (int i = 0; i <= DsParadas.Tables[0].Rows.Count - 1; i++)
        {
            //switch (DsParadas.Tables[0].Rows[i]["CRITICIDAD"].ToString())
            //{
            //    case "ALTA":
            //        color = "bgcolor='#FF0000' ";
            //        VarAlta = +1;
            //        break;
            //    case "MEDIA":
            //        color = "bgcolor='#FFFF00' ";
            //        VarMedia = +1;
            //        break;
            //    default:
            //        color = "bgcolor='#3366FF' ";
            //        VarBaja = +1;
            //        break;
            //}

            sb1Eq.Append("<tr><td width='70'  valign='middle' align='center' ><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["ID"].ToString() + "</p></td><td width='140' align='center'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["FECHAI"].ToString() + "</p></td><td width='140' align='center'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["FECHAT"].ToString() + "</p></td><td width='70' align='center' valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["TOTAL_HRS"].ToString() + "</p></td><td width='100' align='center'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["EQUIPO"].ToString() + "</p></td><td width='130' align='center'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["CODIGO"].ToString() + "</p></td><td  width='140' align='center'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["TIPO"].ToString() + "</p></td><td  width='150'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["CAUSA"].ToString() + "</p></td><td  width='250'  valign='middle'><p style='font-family:arial; font-size:6px;'>" + DsParadas.Tables[0].Rows[i]["OBSERVACION"].ToString() + "</p></td></tr>");
        }
        sb1Eq.Append("</table>");
        sb1Eq.Append("<table><tr CLASS='calibri'><td  align='center' valign='middle'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/Pie_informe.jpg'  align='bottom' width='500px'/></td></tr></table>");

       
                
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=report_grid.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter s_w = new StringWriter();
        HtmlTextWriter h_w = new HtmlTextWriter(s_w);

        //PnlZona.RenderControl(h_w);

        StringReader sr = new StringReader(sb1Eq.ToString());

        Document pdfDoc = new Document(PageSize.LETTER, 70, 40, 30, 40);
        
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