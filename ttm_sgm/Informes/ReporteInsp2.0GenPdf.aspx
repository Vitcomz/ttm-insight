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
        String ARRseccionT = Request.QueryString["secT"];
        String ARReq = Request.QueryString["eq"];
        String ARRtip = Request.QueryString["tip"];
        String ARRcrit = Request.QueryString["crit"];
        String seccion = ARRseccion;
        Int32 VarAlta = 0;
        Int32 VarMedia = 0;
        Int32 VarBaja = 0;
        Int32 VarLInea = 0;



        infInspecciones BsninfInspecciones = new infInspecciones();
        BsninfInspecciones.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
        BsninfInspecciones.Form.Atributos.SetValue("id_equipo", ARReq);
        BsninfInspecciones.Form.Atributos.SetValue("id_tipo_eq", ARRtip);
        BsninfInspecciones.Form.Atributos.SetValue("id_seccion", ARRseccion);
        //DateTime dt1 = Convert.ToDateTime(rddate1.SelectedDate);
        BsninfInspecciones.Form.Atributos.SetValue("fecha_inicio", "");
        BsninfInspecciones.Form.Atributos.SetValue("id_faena", strLogFaena);
        BsninfInspecciones.Form.Atributos.SetValue("criticidad", ARRcrit);

        DataSetWeb BswinfInspecciones = BsninfInspecciones.listardatos();
        DataSet DsinfInspecciones = BswinfInspecciones.Object;

        String color = "";
        String colorx = "";
        Int16 lin = 0;
        sb1Eq.Append("<table BORDER='0'  align='center' cellpadding='1' cellspacing='1' bgcolor='#FFFFFF'><tr><td colspan='3' align='center' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/encabezado.jpg' width='500px'/></td></tr>");
        sb1Eq.Append("<tr><td colspan='3' align='center' valign='top'><font size='2' face='Arial, Helvetica, sans-serif'>INFORME DE INSPECCION 2.0</font><br /><font size='1' face='Arial, Helvetica, sans-serif'>FECHA " + fecha2 + "<br />FAENA " + strLogFaena + "  -  AREA " + ARRseccionT + "</font><BR /><BR /></td></tr>");

        for (int i = 0; i <= DsinfInspecciones.Tables[0].Rows.Count - 1; i++)
        {
            lin += 1;
            switch (DsinfInspecciones.Tables[0].Rows[i]["COLOR"].ToString())
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
            sb1Eq.Append("<tr ><td height='42' colspan='3'  valign='bottom'  align='left' color='#FFFFFF'  bgcolor='#0083cd'><font size='1' face='Arial, Helvetica, sans-serif'>EQUIPO : " + DsinfInspecciones.Tables[0].Rows[i]["EQUIPO_PRIN"].ToString() + "" + DsinfInspecciones.Tables[0].Rows[i]["DESC_EQUIPO_PRIN"].ToString() + "<BR />COMPONENTE : " + DsinfInspecciones.Tables[0].Rows[i]["EQUIPO"].ToString() + "&#160;" + DsinfInspecciones.Tables[0].Rows[i]["DESC_EQUIPO"].ToString() + "</font></td></tr><tr><td valign='top' align='left' width='20%'>");


            String sRECOMENDACION = "";
            String sCAUSA = "";
            String sREPORT = "";
            getDescripList BsngetDescripList = new getDescripList();
            BsngetDescripList.Form.Atributos.SetValue("PROCEDIMIENTO", "0");
            BsngetDescripList.Form.Atributos.SetValue("id", DsinfInspecciones.Tables[0].Rows[i]["ID"].ToString());
            BsngetDescripList.Form.Atributos.SetValue("id_faena", strLogFaena);
            BsngetDescripList.Form.Atributos.SetValue("id_equipo", DsinfInspecciones.Tables[0].Rows[i]["EQUIPO"].ToString());
            DataSetWeb BswgetDescripList = BsngetDescripList.listardatos();
            DataSet DsgetDescripList = BswgetDescripList.Object;
            if (DsgetDescripList.Tables[0].Rows.Count > 0)
            {

                for (int ii = 0; ii <= DsgetDescripList.Tables[0].Rows.Count - 1; ii++)
                {

                    //    sb1Eq.Append("<table class='LitleText'><tr>");
                    //    sb1Eq.Append("<td width='100%' class='PlTitDet1'><strong>" + DsgetDescripList.Tables[0].Rows[x]["DESCRIPCION"].ToString() + "</strong></td><td align='right' style='border-bottom: 1px solid #D5D5D5;'" + colorx.ToString() + "><strong>" + DsgetDescripList.Tables[0].Rows[x]["VALOR"].ToString() + "</strong></td>");

                    //    sb1Eq.Append("</tr></table>");
                    sb1Eq.Append("<table border='1' cellpadding='1' cellspacing='2' width='95%'><tr>");
                    sb1Eq.Append("<td width='10'><p style='font-family:arial; font-size:7px;'>ID</p></td align='center'><td width='10' align='center'><p style='font-family:arial; font-size:7px;'>" + DsgetDescripList.Tables[0].Rows[ii]["ID"].ToString().Trim() + "</p></td></tr>");
                    
                    //sb1Eq.Append("</td>");
                    sb1Eq.Append("<tr><td><p style='font-family:arial; font-size:7px;'>FECHA</p></td><td align='center'><p style='font-family:arial; font-size:7px;'>" + DsgetDescripList.Tables[0].Rows[ii]["FECHA"].ToString() + "</p></td></tr>");
                    sb1Eq.Append("<tr><td><p style='font-family:arial; font-size:7px;'>CRITICIDAD EQ.</p></td><td align='center'><p style='font-family:arial; font-size:7px;'>" + DsinfInspecciones.Tables[0].Rows[ii]["CRITICIDAD"].ToString() + "</p></td></tr>");
                    
                    switch (DsgetDescripList.Tables[0].Rows[ii]["COLOR"].ToString().Trim())
                    {
                        case "ALTA":
                            colorx = "bgcolor='#FF3535' color='#FFFFFF'";
                            break;
                        case "MEDIA":
                            colorx = "bgcolor='#fff000' color='#000000'";
                            break;
                        default:
                            colorx = "bgcolor='#0083cd' color='#FFFFFF'";
                            break;
                    }

                    sb1Eq.Append("<tr><td><p style='font-family:arial; font-size:7px;'>CRITICIDAD COMPONENTE</p></td><td " + colorx + " align='center'><p style='font-family:arial; font-size:7px;'>" + DsgetDescripList.Tables[0].Rows[ii]["COLOR"].ToString() + "</p></td></tr>");
                    sb1Eq.Append("<tr><td><p style='font-family:arial; font-size:7px;'>AVISO/OT:</p></td><td align='center'><p style='font-family:arial; font-size:7px;'>" + DsgetDescripList.Tables[0].Rows[ii]["REPORT"].ToString() + "</p></td></tr></table>");

                    sb1Eq.Append("</td><td valign='top' align='left' colspan='2' width='80%'><p style='font-family:verdana; font-size:7px; text-align: justify; '>" + DsgetDescripList.Tables[0].Rows[ii]["DESCRIPCION"].ToString().Trim() + "</p><BR><BR>");
                    
                    getFileslist BsngetFileslist = new getFileslist();
                    BsngetFileslist.Form.Atributos.SetValue("PROCEDIMIENTO", "1");
                    BsngetFileslist.Form.Atributos.SetValue("id", DsinfInspecciones.Tables[0].Rows[i]["ID"].ToString());
                    DataSetWeb BswgetFileslist = BsngetFileslist.listardatos();
                    DataSet DsgetFileslist = BswgetFileslist.Object;
                    if (DsgetFileslist.Tables[0].Rows.Count > 0)
                    {
                        //sb1Eq.Append("<table>");
                        for (int x = 0; x <= DsgetFileslist.Tables[0].Rows.Count - 1; x++)
                        {
                            
                            //<a href='/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim() + "'  rel='facebox'  id='screenfile" + i + "_href'></a><div style='padding: 4px; width: 90px;'></div>
                            if (RemoteFileExists("http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim(), 3600))
                            {
                                sb1Eq.Append("<img src='http://" + HttpContext.Current.Request.Url.Authority + "/sgm/Files/imagen.aspx?image=/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString().Trim() + "' width='90' style='border: 2px solid #CCCCCC;' id='screenfile" + x + "_img'/>");
                            }
                            
                            //sb1Eq.Append("<tr><td width='100%' class='PlTitDet2'><img src='/sgm/Files/" + DsgetFileslist.Tables[0].Rows[x]["FILENAME"].ToString() + "' width='25' /></td></tr>");
                        }
                        //sb1Eq.Append("</table>");
                    }                    
                    
                    sREPORT += " - " + DsgetDescripList.Tables[0].Rows[ii]["REPORT"].ToString() + "</BR>";
                    sRECOMENDACION += " - " + DsgetDescripList.Tables[0].Rows[ii]["RECOMENDACION"].ToString() + "</BR>";
                    sCAUSA += " - " + DsgetDescripList.Tables[0].Rows[ii]["CAUSA"].ToString() + "</BR>";
                    //sb1Eq.Append("<tr><td>RECOMENDACIÓN:</td><td colspan='2'>&nbsp;</td></tr>");
                    //sb1Eq.Append("<tr><td>CAUSA RAIZ:</td><td colspan='2'>&nbsp;</td>");
                    sb1Eq.Append("</tr>");
                }
            }


            sb1Eq.Append("</td>");
            //sb1Eq.Append("<TD class='PlTitDet1'></TD>");



            sb1Eq.Append("</tr>");

            sb1Eq.Append("<tr CLASS='calibri'><td valign='top' align='left'><p style='font-family:arial; font-size:7px;'>RECOMENDACIÓN:</p></td><td valign='top' align='left' colspan='2'><p style='font-family:arial; font-size:7px;'>" + sRECOMENDACION + "</p></td></tr><tr CLASS='calibri'><td valign='top'  align='left'><p style='font-family:arial; font-size:7px;'>CAUSA RAIZ:</p></td><td valign='top' align='left' colspan='2'><p style='font-family:arial; font-size:7px;'>" + sCAUSA + "</p></td></tr><tr CLASS='calibri'><td  colspan='3' valign='top'>&nbsp;</td></tr>");

            if (lin == 4 && i < (DsinfInspecciones.Tables[0].Rows.Count - 1))
            {
                sb1Eq.Append("<tr><td colspan='3' ><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/inv.png' width='90' height='20'/></td></tr><tr><td colspan='3' ><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/inv.png' width='90' height='20'/></td></tr>");
                lin = -1;
            }
            
            
            //sb1Eq.Append("<div class='PlContListDet' style='width:420px;'><div class='CellDet' style='width:155px;'>" + DsinfInspecciones.Tables[0].Rows[i]["EQUIPO"].ToString() + "</div><div class='CellDet' style='width:125px;'>" + DsinfInspecciones.Tables[0].Rows[i]["VALOR"].ToString() + "</div><div class='CellDet' style='width:46px; " + color + "'>" + DsinfInspecciones.Tables[0].Rows[i]["COLOR"].ToString().ToUpperInvariant() + "</div><div class='CellDet PlBtList Der' style='width:50px; margin:0px;'><a href='#' onclick=loadrisk('" + DsinfInspecciones.Tables[0].Rows[i]["EQUIPO"].ToString() + "');>Ver</a></div><div class='limpiar'></div></div>");

        }

        sb1Eq.Append("<tr CLASS='calibri'><td  colspan='3' valign='top'><img src='http://" + HttpContext.Current.Request.Url.Authority + "/ttm_skins/images/_header/Pie_informe.jpg'  align='bottom' width='500px'/></td></tr></table>");

       
                
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