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
        String ARRcrit = Request.QueryString["crit"];
        String ARRf1 = Request.QueryString["fech1"];
        String ARRf2 = Request.QueryString["fech2"];
        String seccion = ARRseccion;
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;



        infsemanal Bsninfsemanal = new infsemanal();
        Bsninfsemanal.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        Bsninfsemanal.Form.Atributos.SetValue("id_equipo", ARReq);
        Bsninfsemanal.Form.Atributos.SetValue("id_tipo_eq", ARRtip);
        Bsninfsemanal.Form.Atributos.SetValue("id_seccion", ARRseccion);
        Bsninfsemanal.Form.Atributos.SetValue("fecha_inicio", ARRf1);
        Bsninfsemanal.Form.Atributos.SetValue("fecha_termino", ARRf2);
        Bsninfsemanal.Form.Atributos.SetValue("id_faena", strLogFaena);
        Bsninfsemanal.Form.Atributos.SetValue("id_usuario", strLogUsuario);
        Bsninfsemanal.Form.Atributos.SetValue("id_responsable", "");
        Bsninfsemanal.Form.Atributos.SetValue("criticidad", ARRcrit);
        Bsninfsemanal.Form.Atributos.SetValue("danos", "");
        Bsninfsemanal.Form.Atributos.SetValue("turno", "");
        Bsninfsemanal.Form.Atributos.SetValue("incidente", "");

        DataSetWeb Bswinfsemanal = Bsninfsemanal.listardatos();
        DataSet Dsinfsemanal = Bswinfsemanal.Object;

        String color = "";
        String colorx = "";
        sb1Eq.Append("<table cellpadding='2' cellspacing='0'  border='1' bordercolor='#cccccc'  class='calibri'><tr><td width='190' rowspan='2' colspan='2'><img SRC='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/Logo_informe.jpg' width='140px'/></td>");
        sb1Eq.Append("<td width='405' height='45' colspan='3' align='center' valign='top' bgcolor='#0072C6'><font size='1' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>SISTEMA DE GESTION INTEGRADO</font><br><font size='1' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>INFORME SEMANAL DE INSPECCIONES</font></td>");
        sb1Eq.Append("<td width='402' valign='top' colspan='2' bgcolor='#0072C6'><p style='font-family:arial; font-size:7px; color:#FFFFFF'>FECHA DE INSPECCION<br>DESDE: " + ARRf1 + " HASTA: " + ARRf2 + "</p></td></tr>");
        sb1Eq.Append("<tr><td height='25' bgcolor='#0072C6' colspan='5'><font size='1' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>CLIENTE: " + strLogFaena + "</font></td>");
        sb1Eq.Append("</tr><tr class='PlTitEncab1'><td width='110' bgcolor='#0072C6'></td><td width='60' bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>COMPONENTE</p></b></td><td bgcolor='#0072C6'></td><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>ORIGENES DE LAS FALLAS</p></b></td>");
        sb1Eq.Append("<td bgcolor='#0072C6' width='100'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'> GRADO DE CRITICIDAD</p></b></td><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>TRATAMIENTO TECNICO TTM</p></b></td><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>FOTOGRAFIAS</p></b></td></tr>");
        for (int i = 0; i <= Dsinfsemanal.Tables[0].Rows.Count - 1; i++)
        {
            switch (Dsinfsemanal.Tables[0].Rows[i]["COLOR"].ToString())
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



            sb1Eq.Append("<tr><td class='PlTitDet1' valign='middle'>");
            sb1Eq.Append("<table width='100%' border='1' cellpadding='1' cellspacing='1'><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>ID</p></b></td></tr><tr><td><p style='font-family:arial; font-size:7px;'>" + Dsinfsemanal.Tables[0].Rows[i]["ID"].ToString().Trim() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>FECHA</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'><p style='font-family:arial; font-size:7px;'>" + Dsinfsemanal.Tables[0].Rows[i]["FECHA"].ToString() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>EQUIPO</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'><p style='font-family:arial; font-size:7px;'>" + Dsinfsemanal.Tables[0].Rows[i]["EQUIPO_PRIN"].ToString().Trim() + "</p></td></tr></table>");
            sb1Eq.Append("</td><td class='PlTitDet1' valign='middle' width='60'><p style='font-family:arial; font-size:7px;'>" + Dsinfsemanal.Tables[0].Rows[i]["EQUIPO"].ToString().Trim() + "</p></td><td class='PlTitDet1' valign='top'>");
            sb1Eq.Append("<table width='100%' border='0' cellpadding='1' cellspacing='1'><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>OBSERVACION</p></b></td></tr><tr><td><p style='font-family:arial; font-size:7px; text-align: justify; '>" + Dsinfsemanal.Tables[0].Rows[i]["DESCRIPCION"].ToString().Trim() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>CAUSA RAIZ</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'>");
            sb1Eq.Append("<p style='font-family:arial; font-size:7px;'>" + Dsinfsemanal.Tables[0].Rows[i]["CAUSA"].ToString().Trim() + "</p><br />");
            if (Dsinfsemanal.Tables[0].Rows[i]["COLOR"].ToString() == "ALTA")
            {
                sb1Eq.Append("<span style='color:#FF0033'><p style='font-family:arial; font-size:7px;'>DIAS PENDIENTES " + Dsinfsemanal.Tables[0].Rows[i]["DIAS"].ToString() + "</p></span>");
            }
            sb1Eq.Append("</td></tr></table>");
            sb1Eq.Append("</td><td  align='LEFT' class='PlTitDet1' valign='middle' width='60'>");

            getChecklist BsngetChecklist = new getChecklist();
            BsngetChecklist.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
            BsngetChecklist.Form.Atributos.SetValue("id", Dsinfsemanal.Tables[0].Rows[i]["ID"].ToString());
            BsngetChecklist.Form.Atributos.SetValue("TipoEquipo", Dsinfsemanal.Tables[0].Rows[i]["TIPO_EQUIPO"].ToString());
            DataSetWeb BswgetChecklist = BsngetChecklist.listardatos();
            DataSet DsgetChecklist = BswgetChecklist.Object;
            if (DsgetChecklist.Tables[0].Rows.Count > 0)
            {
                sb1Eq.Append("<table class='LitleText'><tr>");
                for (int x = 0; x <= DsgetChecklist.Tables[0].Rows.Count - 1; x++)
                {
                    switch (DsgetChecklist.Tables[0].Rows[x]["VALOR"].ToString())
                    {
                        case "3":
                            colorx = "bgcolor='#FF3535' ";
                            break;
                        case "2":
                            colorx = "bgcolor='#fff000' ";
                            break;
                        default:
                            colorx = "bgcolor='#0083cd' ";
                            break;
                    }
                    sb1Eq.Append("<td width='100%' class='PlTitDet1'><strong><p style='font-family:arial; font-size:5px;'>" + DsgetChecklist.Tables[0].Rows[x]["DESCRIPCION"].ToString().Trim() + "</p></strong></td><td width='10' align='right' style='border-bottom: 1px solid #D5D5D5;'" + colorx.ToString() + "><strong><p style='font-family:arial; font-size:6px;'>" + DsgetChecklist.Tables[0].Rows[x]["VALOR"].ToString() + "</p></strong></td>");
                }
                sb1Eq.Append("</tr></table>");
            }
            sb1Eq.Append("</td>");
            sb1Eq.Append("<td " + color.ToString() + " valign='middle' width='10'><strong><p style='font-family:arial; font-size:7px;'>" + Dsinfsemanal.Tables[0].Rows[i]["COLOR"].ToString() + "</p></strong></td>");
            sb1Eq.Append("<td align='LEFT' class='PlTitDet1' valign='middle'><p style='font-family:arial; font-size:7px; text-align: justify; '>" + Dsinfsemanal.Tables[0].Rows[i]["RECOMENDACION"].ToString().Trim() + "</p></td>");


            sb1Eq.Append("<TD class='PlTitDet1' valign='middle'>");
            getFileslist BsngetFileslist = new getFileslist();
            BsngetFileslist.Form.Atributos.SetValue("PROCEDIMIENTO", "1");
            BsngetFileslist.Form.Atributos.SetValue("id", Dsinfsemanal.Tables[0].Rows[i]["ID"].ToString());
            DataSetWeb BswgetFileslist = BsngetFileslist.listardatos();
            DataSet DsgetFileslist = BswgetFileslist.Object;
            if (DsgetFileslist.Tables[0].Rows.Count > 0)
            {
                for (int x = 0; x <= DsgetFileslist.Tables[0].Rows.Count - 1; x++)
                {

                    if (RemoteFileExists("http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim(), 3600))
                    {
                        sb1Eq.Append("<div class='PlTitDet2'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/imagen.aspx?image=/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim() + "' width='70'  id='screenfile" + x + "_img'/></div>");
                    }
                }
            }
            sb1Eq.Append("</TD></tr>");


        }
        sb1Eq.Append("</table>");
    
                
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=report_grid.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter s_w = new StringWriter();
        HtmlTextWriter h_w = new HtmlTextWriter(s_w);

        //PnlZona.RenderControl(h_w);

        StringReader sr = new StringReader(sb1Eq.ToString().Trim());

        Document pdfDoc = new Document(PageSize.LETTER, 60, 30, 30, 20);
        
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