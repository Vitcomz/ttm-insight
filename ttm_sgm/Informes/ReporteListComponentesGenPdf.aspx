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
        String ARReq = Request.QueryString["eq"];
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;


        if (ARReq == "[ -- Seleccionar -- ]")
        {
            ARReq = "";
        }
        Componentes BsnComponentes = new Componentes();
        BsnComponentes.Form.Atributos.SetValue("procedimiento", "0");
        BsnComponentes.Form.Atributos.SetValue("id_equipo", "");
        BsnComponentes.Form.Atributos.SetValue("id_tipo", ARReq);
        BsnComponentes.Form.Atributos.SetValue("fecha_inicio", "");
        BsnComponentes.Form.Atributos.SetValue("fecha_termino", "");
        BsnComponentes.Form.Atributos.SetValue("id_faena", Session["emp"].ToString().ToUpper());
        BsnComponentes.Form.Atributos.SetValue("id_componente", "");
        BsnComponentes.Form.Atributos.SetValue("id_usuario", Session["log"].ToString().ToUpper());
        BsnComponentes.Form.Atributos.SetValue("criticidad", "");

        DataSetWeb BswComponentes = BsnComponentes.listardatos();
        DataSet DsComponentes = BswComponentes.Object;

        
        String color = "";
        String colorx = "";
        sb1Eq.Append("<table width='480'  BORDER='0'  align='center' cellpadding='1' cellspacing='1' bgcolor='#FFFFFF'><tr><td HEIGHT='23' colspan='8' align='center' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/encabezado.jpg' width='480px'/></td></tr>");
        sb1Eq.Append("<tr><td HEIGHT='23' colspan='8' align='center' valign='top'><font size='2' face='Arial'>INFORME DE COMPONENTES</font><br /><font size='1' face='Arial'>FECHA " + fecha2 + " - TIPO COMPONENTE " + ARReq + "<br />FAENA " + strLogFaena + "</font><BR /></td></tr>");
        sb1Eq.Append("<tr ><td colspan='8' valign='top'>");

        sb1Eq.Append("<table id='tabEquipos' class='calibri' border='1' cellspacing='0' cellpadding='1' width='100%'>");
        sb1Eq.Append("<tr><td bgcolor='#FFFF99' align='center' ><font size='1' face='Arial'>EQUIPO</font></td><td bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>Nº DE COMPONENTES</font></td><td bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>IDENTIFICACIÓN</font></td><td bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>CRIT.</font></td><td bgcolor='#FFFF99' align='center'><font size='1' face='Arial'>ÚLTIMA INTERVENCIÓN</td><td bgcolor='#FFFF99' align='center' ><font size='1' face='Arial'>DURACIÓN A LA FECHA</font></td><td bgcolor='#FFFF99' align='center' ><font size='1' face='Arial'>OBSERVACIONES</font></td><td bgcolor='#FFFF99' align='center' ><font size='1' face='Arial'>CAUSA</font></td></tr>");
        
            //sb1Eq.Append("<tbody>");
            for (int i = 0; i <= DsComponentes.Tables[0].Rows.Count - 1; i++)
            {
                switch (DsComponentes.Tables[0].Rows[i]["CRITICIDAD"].ToString())
                {
                    case "ALTA":
                        color = "bgcolor='#FF0000' ";
                        VarAlta = +1;
                        break;
                    case "MEDIA":
                        color = "bgcolor='#FFFF00' ";
                        VarMedia = +1;
                        break;
                    default:
                        color = "bgcolor='#3366FF' ";
                        VarBaja = +1;
                        break;
                }
                switch (DsComponentes.Tables[0].Rows[i]["DESCRIPCION"].ToString())
                {
                    case "Componente en buen estado":
                        color = "bgcolor='#00FF33' ";
                        break;
                    default:
                        color = "bgcolor='#3366FF' ";
                        break;
                }
                VarLInea = +1;

                sb1Eq.Append("<tr><td width='80' valign='middle'>" + DsComponentes.Tables[0].Rows[i]["EQUIPO"].ToString() + "</td><td width='80' align='center'>" + DsComponentes.Tables[0].Rows[i]["COUNT"].ToString() + "</td><td width='130'>" + DsComponentes.Tables[0].Rows[i]["COMPONENTE"].ToString() + "</td><td width='60'  " + color + ">" + DsComponentes.Tables[0].Rows[i]["CRITICIDAD"].ToString() + "</td><td width='90' align='center'></td>" + DsComponentes.Tables[0].Rows[i]["ULT_MAN"].ToString() + "<td width='90' align='center'>" + DsComponentes.Tables[0].Rows[i]["DURACION"].ToString() + "</td><td width='200'>" + DsComponentes.Tables[0].Rows[i]["DESCRIPCION"].ToString() + "</td><td width='120'>" + DsComponentes.Tables[0].Rows[i]["CAUSA"].ToString() + "</td></tr>");
            }
            //sb1Eq.Append("</tbody>");
        sb1Eq.Append("</table>");

        sb1Eq.Append("</td></tr>");

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