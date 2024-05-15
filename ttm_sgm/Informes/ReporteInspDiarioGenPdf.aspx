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
        string[] strArr = null;
        string[] strArr2 = null;
        String strLogFaena = Session["emp"].ToString().ToUpper();
        String strLogUsuario = Session["log"].ToString().ToUpper();
        String fecha1 = "01/01/2009";
        String fecha2 = DateTime.Today.ToString("dd/MM/yyyy");
        String ARRinf = Request.QueryString["inf"];
        String ARRresp = Request.QueryString["resp"];
        String ARRfech = Request.QueryString["fech"];
        String ARRbit = Request.QueryString["bit"];
        String ARRstr = Request.QueryString["allstr"];
        char[] splitchar = { '|' };
        strArr = ARRstr.Split(splitchar);
        char[] splitchar2 = { '-' };
        
        //String seccion = ARRseccion;
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;
        String xAux = "";


        infdiario Bsninfdiario = new infdiario();
        Bsninfdiario.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        Bsninfdiario.Form.Atributos.SetValue("faena", strLogFaena);
        if (ARRbit != "")
        {
            int ln = ARRbit.Length - 2;
            int tt = ARRbit.Length;
            String verx = ARRbit.Substring(ARRbit.Length - 1, 1);

            if (verx == ",")
            {
                Bsninfdiario.Form.Atributos.SetValue("bitacoras", ARRbit.ToString().Substring(0, ARRbit.Length - 1));
            }
            else
            {
                Bsninfdiario.Form.Atributos.SetValue("bitacoras", ARRbit.ToString());
            }
        }


        DataSetWeb Bswinfdiario = Bsninfdiario.listardatos();
        DataSet Dsinfdiario = Bswinfdiario.Object;


        String color = "";
        String colorx = "";
        String crit = "";
        String ot = "";
        sb1Eq.Append("<table cellpadding='2' cellspacing='0'  border='1' bordercolor='#cccccc'  class='calibri'>");
        sb1Eq.Append("<tr><td width='190' rowspan='2' colspan='1'><img SRC='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/Logo_informe.jpg' width='95px'/></td>");
        sb1Eq.Append("<td width='405' height='45' colspan='2' align='center' valign='top' bgcolor='#0072C6'><font size='1' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>SISTEMA DE GESTION INTEGRADO</font><br><font size='1' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>INFORME DIARIO DE INSPECCIONES</font></td>");
        sb1Eq.Append("<td width='402' valign='top' colspan='2' bgcolor='#0072C6'><p style='font-family:arial; font-size:7px; color:#FFFFFF'>FECHA DE INSPECCION " + ARRfech + "</p></td></tr>");
        sb1Eq.Append("<tr><td height='25' bgcolor='#0072C6' colspan='4'><font size='1' face='Arial, Helvetica, sans-serif' color='#FFFFFF'>CLIENTE: " + strLogFaena + "</font></td>");
        sb1Eq.Append("</tr><tr class='PlTitEncab1'><td width='110' bgcolor='#0072C6'></td><td width='60' bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>IMAGEN</p></b></td><td bgcolor='#0072C6'></td><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>RECOMENDACION</p></b></td>");
        sb1Eq.Append("<td bgcolor='#0072C6' width='70'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'> CRITICIDAD 1SAP</p></b></td>");
        for (int i = 0; i <= Dsinfdiario.Tables[0].Rows.Count - 1; i++)
        {
            switch (Dsinfdiario.Tables[0].Rows[i]["COLOR"].ToString())
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



            sb1Eq.Append("<tr><td class='PlTitDet1'><table width='100%' border='1' cellpadding='1' cellspacing='1'><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>ID</p></b></td></tr><tr><td><p style='font-family:arial; font-size:7px;'>" + Dsinfdiario.Tables[0].Rows[i]["ID"].ToString().Trim() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>FECHA</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'><p style='font-family:arial; font-size:7px;'>" + Dsinfdiario.Tables[0].Rows[i]["FECHA"].ToString() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>EQUIPO</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'><p style='font-family:arial; font-size:7px;'>" + Dsinfdiario.Tables[0].Rows[i]["EQUIPO_PRIN"].ToString().Trim() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6' align='center'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>COMPONENTE</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'><p style='font-family:arial; font-size:7px;'>" + Dsinfdiario.Tables[0].Rows[i]["EQUIPO"].ToString().Trim() + " " + Dsinfdiario.Tables[0].Rows[i]["TIPO"].ToString() + "</p></td></tr></table></td>");
            sb1Eq.Append("<td class='PlTitDet1'>");
            getFileslist BsngetFileslist = new getFileslist();
            BsngetFileslist.Form.Atributos.SetValue("PROCEDIMIENTO", "1");
            BsngetFileslist.Form.Atributos.SetValue("id", Dsinfdiario.Tables[0].Rows[i]["ID"].ToString());
            DataSetWeb BswgetFileslist = BsngetFileslist.listardatos();
            DataSet DsgetFileslist = BswgetFileslist.Object;
            if (DsgetFileslist.Tables[0].Rows.Count > 0)
            {
                //    //sb1Eq.Append("<table>");
                for (int x = DsgetFileslist.Tables[0].Rows.Count - 1; x >= 0; x--)
                {
                    if (x >= DsgetFileslist.Tables[0].Rows.Count - 1)
                    {
                        if (RemoteFileExists("http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim(), 3600))
                        {
                            sb1Eq.Append("<img src='http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/imagen.aspx?image=/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim() + "' width='95'  id='screenfile" + x + "_img'/>");
                        }
                        else
                        {
                            sb1Eq.Append("<img src='http://" + HttpContext.Current.Request.Url.Authority + "/sgm/images/noDisponible.png' width='95'  id='screenfile" + x + "_img'/>");
                        }

                    }

                }
                //    //sb1Eq.Append("</table>");
            }
            else
            {
                sb1Eq.Append("<img src='http://" + HttpContext.Current.Request.Url.Authority + "/sgm/images/noDisponible.png' width='190'  id='screenfile99_img'/>");
            }
            sb1Eq.Append("</td>");
            sb1Eq.Append("<td class='PlTitDet1'><table width='100%' border='0' cellpadding='1' cellspacing='1'><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>OBSERVACION</p></b></td></tr><tr><td><p style='font-family:arial; font-size:7px; text-align: justify; '>" + Dsinfdiario.Tables[0].Rows[i]["DESCRIPCION"].ToString().Trim() + "</p></td></tr><tr bordercolor='#000000' class='PlTitEncab1'><td bgcolor='#0072C6'><b><p style='font-family:arial; font-size:7px; color:#FFFFFF'>CAUSA RAIZ</p></b></td></tr><tr bordercolor='#000000' class='calibri'><td class='PlTitDet1'>");
            sb1Eq.Append("<p style='font-family:arial; font-size:7px;'>" + Dsinfdiario.Tables[0].Rows[i]["CAUSA"].ToString().Trim() + "</p><br />");
            sb1Eq.Append("</td></tr></table></td>");
            sb1Eq.Append("<td  ALIGN='LEFT' class='PlTitDet1'><p style='font-family:arial; font-size:7px;'>");
            sb1Eq.Append("" + Dsinfdiario.Tables[0].Rows[i]["RECOMENDACION"].ToString().Trim() + "</p>");
            sb1Eq.Append("<input type='hidden' id='7x' value='" + xAux + "'></td>");
            xAux = "";
            sb1Eq.Append("<TD class='PlTitDet1'>");
            strArr2 = strArr[i].Split(splitchar2);
            crit = strArr2[0].ToString();
            ot = strArr2[1].ToString();
            String f_crit = "";
            if (crit == "1")
            {
                f_crit = "1  -24 hrs";
            }
            else if (crit == "2")
            {
                f_crit = "2  -7  días";
            }
            else if (crit == "3")
            {
                f_crit = "3  -30 días";
            }
            else if (crit == "4")
            {
                f_crit = "4  -90 días";
            }
            else
            {
                f_crit = "";
            }
            sb1Eq.Append("<p style='font-family:arial; font-size:8px;'>" + f_crit + "</p>&nbsp;<BR /><p style='font-family:arial; font-size:7px;'>AVISO/OT : &nbsp;<BR />" + ot.ToString() + "</p>");

            sb1Eq.Append("</TD></tr>");

            //sb1Eq.Append("<div class='PlContListDet' style='width:420px;'><div class='CellDet' style='width:155px;'>" + Dsinfdiario.Tables[0].Rows[i]["EQUIPO"].ToString() + "</div><div class='CellDet' style='width:125px;'>" + Dsinfdiario.Tables[0].Rows[i]["VALOR"].ToString() + "</div><div class='CellDet' style='width:46px; " + color + "'>" + Dsinfdiario.Tables[0].Rows[i]["COLOR"].ToString().ToUpperInvariant() + "</div><div class='CellDet PlBtList Der' style='width:50px; margin:0px;'><a href='#' onclick=loadrisk('" + Dsinfdiario.Tables[0].Rows[i]["EQUIPO"].ToString() + "');>Ver</a></div><div class='limpiar'></div></div>");

        }
        sb1Eq.Append("</table>");
       
                
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=report_grid.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter s_w = new StringWriter();
        HtmlTextWriter h_w = new HtmlTextWriter(s_w);

        //PnlZona.RenderControl(h_w);

        StringReader sr = new StringReader(sb1Eq.ToString());

        Document pdfDoc = new Document(PageSize.LETTER, 70, 40, 30, 20);
        
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