<%@ Page Language="C#" MasterPageFile="~/ttm_skins/ttm_template.Master"  AutoEventWireup="true" CodeBehind="SubMenu.aspx.cs" Inherits="Insight.sgi.SubMenu" StyleSheetTheme="ttm" Theme="ttm" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
<table border="0" cellpadding="0" cellspacing="0" class="ContenidoPrincipal"  style="width:100%">
    <!--DWLayoutTable-->
    <tr>
        <td style="width:10px;height:10px"></td>
        <td style="width:870px"></td>
        <td style="width:10px"></td>
    </tr>
    <tr>
        <td></td>
        <td valign="top" align="center" style="height:400px">






            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        </td>
        <td></td>
    </tr>
    <tr>
        <td style="height:10px"></td>
        <td></td>
        <td></td>
    </tr>
</table>
</asp:Content>