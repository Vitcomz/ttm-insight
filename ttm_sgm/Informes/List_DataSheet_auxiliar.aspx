<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="List_DataSheet_auxiliar.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_DataSheet_auxiliar"  StyleSheetTheme="ttm" Theme="ttm"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../ttm_skins/css/style-ttm.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
    body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
    </style>
    <title>Datasheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />






</head>
<body>
    <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <script src="../../ttm_js/jslide/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../../ttm_skins/css/colorbox.css" type="text/css" />
    <script src="../../ttm_js/jquerycolorboxmin.js" type="text/javascript"></script> 
<script type="text/javascript">


    //the following code use radconfirm to mimic the blocking of the execution thread.
    //The approach has the following limitations:
    //1. It works inly for elements that have *click* method, e.g. links and buttons
    //2. It cannot be used in if(!confirm) checks
    window.blockConfirm = function (text, mozEvent, oWidth, oHeight, callerObj, oTitle) {
        var ev = mozEvent ? mozEvent : window.event; //Moz support requires passing the event argument manually
        //Cancel the event
        ev.cancelBubble = true;
        ev.returnValue = false;
        if (ev.stopPropagation) ev.stopPropagation();
        if (ev.preventDefault) ev.preventDefault();

        //Determine who is the caller
        var callerObj2 = ev.srcElement ? ev.srcElement : ev.target;

        //Call the original radconfirm and pass it all necessary parameters
        if (callerObj2) {
            //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again.
            var callBackFn = function (arg) {
                if (arg) {
                    callerObj2["onclick"] = "";
                    if (callerObj2.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz
                    else if (callerObj2.tagName == "A") //We assume it is a link button!
                    {
                        try {
                            eval(callerObj2.href)
                        }
                        catch (e) { }
                    }
                }
            }

            radconfirm(text, callBackFn, oWidth, oHeight, callerObj2, oTitle);
        }
        return false;
    }
</script>
<table cellpadding="0" cellspacing="0" border="0" width="939">
                                    	<tr>
                                        	<td style="width:15px"></td>
                                        	<td valign="top" style="width:744px">
                                            	<table cellpadding="0" cellspacing="0" border="0" style="width:900px">
                                                    <tr>
                                                        <td style="height:10px"></td>
                                                    </tr>
                                                    <tr>
                                                    	<td valign="top" style="width:900px;">
                                                    	    <asp:Panel ID="PnlBuscar" runat="server" ScrollBars="Auto" Height="700px" Width="900px"></asp:Panel>    
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height:32px"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width:15px"></td>
                                        </tr>
                                    </table>
		
    <asp:SqlDataSource ID="SqlDataSourcex1" runat="server"></asp:SqlDataSource>                                
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>                                    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
        <%---------------------------------------parte de template ----------------------------------------------------------------%>
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnActivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBorrarBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        <%---------------------------------------fin parte de template ----------------------------------------------------------------%>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
</form>
</body>
</html>

