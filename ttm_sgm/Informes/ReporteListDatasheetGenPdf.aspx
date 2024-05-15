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
        infdatasheet Bsninfdatasheet = new infdatasheet();
        Bsninfdatasheet.Form.Atributos.SetValue("procedimiento", "0");
        Bsninfdatasheet.Form.Atributos.SetValue("id_equipo", ARReq);
        Bsninfdatasheet.Form.Atributos.SetValue("id_faena", Session["emp"].ToString().ToUpper());
        DataSetWeb Bswinfdatasheet = Bsninfdatasheet.listardatos();
        DataSet Dsinfdatasheet = Bswinfdatasheet.Object;

        
        String color = "";
        String colorx = "";
        sb1Eq.Append("<table width='480'  BORDER='0'  align='center' cellpadding='1' cellspacing='1' bgcolor='#FFFFFF'><tr><td HEIGHT='23' colspan='8' align='center' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/encabezado.jpg' width='480px'/></td></tr>");
        sb1Eq.Append("<tr><td HEIGHT='23' colspan='8' align='center' valign='top'><font size='2' face='Arial'>INFORME DE COMPONENTES</font><br /><font size='1' face='Arial'>FECHA " + fecha2 + " - EQUIPO " + ARReq + "<br />FAENA " + strLogFaena + "</font><BR /></td></tr>");
        //sb1Eq.Append("<tr ><td colspan='8' valign='top'>");

        if (Dsinfdatasheet.Tables[0].Rows.Count > 0)
        {

            for (int i = 0; i <= Dsinfdatasheet.Tables[0].Rows.Count - 1; i++)
            {
            //<TABLE width='100%'  border='1' cellpadding='0' cellspacing='0' BORDERCOLOR='#000000' BORDERCOLORDARK='#FFFFFF' id='tabSheet'>
                sb1Eq.Append("<TR align='center'    ><TD COLSPAN='2' ROWSPAN='3' align='center' valign='MIDDLE'><font size='4' face='Arial'><STRONG>" + Dsinfdatasheet.Tables[0].Rows[i]["UBICACION"].ToString() + "</STRONG></font></TD><TD HEIGHT='16' colspan='2' ALIGN='CENTER' valign='top'><font size='1' face='Arial'><STRONG>DATA SHEET EQUIPOS PLANTA MINERA </STRONG></font></TD><TD  ALIGN='LEFT' valign='top'><font size='1' face='Arial'>Area</font></TD><TD  ALIGN='LEFT' valign='top' ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["SECCION"].ToString() + "</font></TD></TR><TR align='center'  ><TD colspan='2' ROWSPAN='2' align='center' valign='TOP' ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["CODIGO"].ToString() + " <BR />" + Dsinfdatasheet.Tables[0].Rows[i]["DESCRIPCION_EQ"].ToString() + "</font></TD><TD HEIGHT='21' ALIGN='LEFT' valign='TOP' ><font size='1' face='Arial'>C&oacute;digo Area</font></TD><TD ALIGN='LEFT' ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["SECCION"].ToString() + "</font></TD></TR><TR align='center'  ><TD HEIGHT='21' ALIGN='LEFT' valign='TOP' ><font size='1' face='Arial'>Numero de Serie</font></TD><TD ALIGN='LEFT' ><font size='1' face='Arial'><SPAN datafld='SERIE' id='SERIE'></SPAN></font></TD></TR><TR align='center' CLASS='rotulo'><TD HEIGHT='21' colspan='3' align='CENTER' ><font size='1' face='Arial'>DATOS PRINCIPALES</font></TD><TD colspan='3' align='CENTER' ><font size='1' face='Arial'>LAYOUT</font></TD></TR><TR align='center' VALIGN='MIDDLE' ><TD  HEIGHT='21' align='left'   ><font size='1' face='Arial'>MARCA</font></TD><TD colspan='2'  align='left'   ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["MARCA"].ToString() + "</font></TD><TD colspan='3' ROWSPAN='5'  align='CENTER' valign='TOP' >");


                getArchivolist BsngetArchivolist = new getArchivolist();
                BsngetArchivolist.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
                BsngetArchivolist.Form.Atributos.SetValue("id", ARReq);
                BsngetArchivolist.Form.Atributos.SetValue("familia", "EQUIPOS");
                DataSetWeb BswgetArchivolist = BsngetArchivolist.listardatos();
                DataSet DsgetArchivolist = BswgetArchivolist.Object;
                if (DsgetArchivolist.Tables[0].Rows.Count > 0)
                {
                //    //sb1Eq.Append("<table>");
                //    for (int x = 0; x <= DsgetArchivolist.Tables[0].Rows.Count - 1; x++)
                //    {

                    //        sb1Eq.Append("<TABLE  border='0' cellpadding='5' cellspacing='0' datapagesize='1' id='tabImages'><TR><TD  height='201'  align='center' valign='top'><A datafld='FILEIMAGE' target='_blank' id='FILEIMAGELINK'><IMG src='/sgm/Files/" + DsgetArchivolist.Tables[0].Rows[x]["ID"].ToString() + "." + DsgetArchivolist.Tables[0].Rows[x]["EXT"].ToString() + "' name='FILEIMAGE' width='450' border='0' align='middle' id='FILEIMAGE' onerror='this.src='../images/noDisponible.png';'></A><BR></TD></TR></TABLE>");
                //    }
                //    //sb1Eq.Append("</table>");
                    for (int x = 0; x <= DsgetArchivolist.Tables[0].Rows.Count - 1; x++){
                        if (File.Exists(HttpContext.Current.Request.Url.Authority + "/sgm/Files/" + DsgetArchivolist.Tables[0].Rows[x]["ID"].ToString() + "." + DsgetArchivolist.Tables[0].Rows[x]["EXT"].ToString()))
                        {
                            sb1Eq.Append("<TABLE  border='0' cellpadding='5' cellspacing='0' datapagesize='1' id='tabImages'><TR><TD  height='201'  align='center' valign='top'><IMG src='http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/" + DsgetArchivolist.Tables[0].Rows[x]["ID"].ToString() + "." + DsgetArchivolist.Tables[0].Rows[x]["EXT"].ToString() + "' name='FILEIMAGE' width='230' border='0' align='middle'><BR></TD></TR></TABLE>");
                        }
                        else
                        {
                            sb1Eq.Append("<TABLE  border='0' cellpadding='5' cellspacing='0' datapagesize='1' id='tabImages'><TR><TD  height='201'  align='center' valign='top'><IMG src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/Skin/noDisponible.png' name='FILEIMAGE' width='230' border='0' align='middle'><BR></TD></TR></TABLE>");
                        }   
                    }                 
                }
                else
                {
                    sb1Eq.Append("<TABLE  border='0' cellpadding='5' cellspacing='0' datapagesize='1' id='tabImages'><TR><TD  height='201'  align='center' valign='top'><IMG src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/Skin/noDisponible.png' name='FILEIMAGE' width='230' border='0' align='middle'><BR></TD></TR></TABLE>");
                }



                sb1Eq.Append("</TD></TR><TR align='left' ><TD HEIGHT='21' align='left' valign='top' ><font size='1' face='Arial'>MODELO</font></TD><TD colspan='2' ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["MODELO"].ToString() + "</font></TD></TR><TR align='center' ><TD HEIGHT='21' align='left' ><font size='1' face='Arial'>DIMENSIONES </font></TD><TD COLSPAN='2'  align='left' ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["DIMENSIONES"].ToString() + "</font></TD></TR><TR align='center'><TD HEIGHT='24' align='left' ><font size='1' face='Arial'>CAPACIDAD</font></TD><TD COLSPAN='2' align='left' ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["CAPACIDAD"].ToString() + "</font></TD></TR><TR align='center'><TD HEIGHT='131' COLSPAN='3' ALIGN='LEFT' valign='TOP'  ><font size='1' face='Arial'>" + Dsinfdatasheet.Tables[0].Rows[i]["OBSERVACION"].ToString() + "</font></TD></TR><TR align='center'><TD HEIGHT='254' COLSPAN='6' VALIGN='TOP' ALIGN='LEFT' ><TABLE WIDTH='100%' BORDERCOLOR='#000000'  CELLPADDING='0' CELLSPACING='0' BORDERCOLORDARK='#FFFFFF' id='xmlSubEquipos'><tbody>");

                infdatasheetSub BsninfdatasheetSub = new infdatasheetSub();
                BsninfdatasheetSub.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
                BsninfdatasheetSub.Form.Atributos.SetValue("id_faena", Session["emp"].ToString().ToUpper());
                BsninfdatasheetSub.Form.Atributos.SetValue("id_equipo", ARReq);
                DataSetWeb BswinfdatasheetSub = BsninfdatasheetSub.listardatos();
                DataSet DsinfdatasheetSub = BswinfdatasheetSub.Object;
                if (DsinfdatasheetSub.Tables[0].Rows.Count > 0)
                {

                    for (int ii = 0; ii <= DsinfdatasheetSub.Tables[0].Rows.Count - 1; ii++)
                    {
                        sb1Eq.Append("<TR>");
                        sb1Eq.Append("<TD WIDTH='237' VALIGN='TOP' ><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["DESCRIPCION"].ToString() + "</font></TD>");
                        sb1Eq.Append("<TD WIDTH='120' ><font size='1' face='Arial'>MARCA</font></TD><TD WIDTH='149' ALIGN='LEFT' ><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["MARCA"].ToString() + "</TD>");
                        sb1Eq.Append("<TD WIDTH='101' ><font size='1' face='Arial'>MODELO</font></TD><TD WIDTH='347' ALIGN='LEFT' ><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["MODELO"].ToString() + "</font></TD></TR><TR>");
                        sb1Eq.Append("<TD WIDTH='237' VALIGN='TOP' ><TD ><font size='1' face='Arial'>DIMENSIONES</font></TD><TD ALIGN='LEFT' ><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["DIMENSIONES"].ToString() + "</font></TD>");
                        sb1Eq.Append("<TD ><font size='1' face='Arial'>NUMERO SERIE</font></TD><TD ALIGN='LEFT' ><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["SERIE"].ToString() + "</font></TD></TR><TR>");
                        sb1Eq.Append("<TD WIDTH='237' VALIGN='TOP' ><TD  STYLE='BORDER-BOTTOM:#dfdfdf 1px ridge'><font size='1' face='Arial'>CODIGO GSAP</font></TD><TD ALIGN='LEFT'  STYLE='BORDER-BOTTOM:#dfdfdf 1px ridge'><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["GSAP"].ToString() + "</font></TD><TD  STYLE='BORDER-BOTTOM:#dfdfdf 1px ridge'><font size='1' face='Arial'>OTROS</font></TD><TD ALIGN='LEFT'  STYLE='BORDER-BOTTOM:#dfdfdf 1px ridge'><font size='1' face='Arial'>" + DsinfdatasheetSub.Tables[0].Rows[ii]["OBSERVACION"].ToString() + "</font></TD>");
                        sb1Eq.Append("</TR>");
                        
                    }
                }
                sb1Eq.Append("</tbody></TABLE></TD></TR>");//</TABLE>
            }

        }

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