<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="List_InfBitacora_auxiliar.aspx.cs" Inherits="Insight.ttm_sgm.Informes.List_InfBitacora_auxiliar"  StyleSheetTheme="ttm" Theme="ttm"  %>
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
    <title>Bitacora</title>
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
                                                    	<td style="height:10px">
                                                    	    <asp:Panel runat="server" ID="PnlFilto" meta:resourcekey="PnlFiltoResource1">
                                                            <table width="900" border="0" cellspacing="0" cellpadding="0" runat="server" 
                                                                    id="TblFiltoCompleto">
                                                              <tr id="Tr2" runat="server">
                                                                <td id="Td2" valign="top" runat="server">
                                                                    <table width="900" border="0" cellspacing="0" cellpadding="0" 
                                                                        class="filtroContenido" id="tblFiltro" runat="server">
                                                                        <tr id="Tr3" runat="server">
                                                                            <td id="Td3" valign="top" runat="server">
                                                                                <table cellpadding="0" cellspacing="0" border="0" style="width:700px">
                                                                                    <tr>
                                                                                            <td style="width:11px"></td>
                                                                                            <td style="width:100px;"></td>
                                                                                            <td style="width:200px;"></td>
                                                                                            <td style="width: 89px"></td>
                                                                                            <td style="width: 89px">&nbsp;
                                                                                                </td>
                                                                                            <td style="width: 89px">
                                                                                                &nbsp;</td>
                                                                                            <td style="width: 89px">
                                                                                                &nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>&nbsp;</td>
                                                                                        <td style="height: 24px" align="center" valign="top"><strong>Desde</strong></td>
                                                                                        <td align="left" valign="top">
                <telerik:RadDatePicker ID="rddate1" runat="server">
                </telerik:RadDatePicker>
                                                                                        </td>
                                                                                        <td align="center" valign="top"><strong>Hasta</strong></td>
                                                                                        <td align="left" valign="top">
            <telerik:RadDatePicker ID="rddate2" runat="server">
            </telerik:RadDatePicker>
			                                                                            </td>
                                                                                        <td align="center" valign="top"><strong>Solucionado</strong></td>
                                                                                        <td align="left" valign="top">
                                                                                            <asp:CheckBox ID="ChkSolucion" runat="server" AutoPostBack="True" 
                                                                                                oncheckedchanged="ChkSolucion_CheckedChanged" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                            <td colspan="4" style="height:10px"></td>
                                                                                            <td style="height:10px">&nbsp;
                                                                                                </td>
                                                                                            <td style="height:10px">
                                                                                                &nbsp;</td>
                                                                                            <td style="height:10px">
                                                                                                &nbsp;</td>
                                                                                     </tr>
                                                                                </table>
                                                                            </td>
                                                                            <td id="Td4" style="width:180px" valign="top" runat="server">
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="180">
                                                                                    <tr>
                                                                                        <td style="height:10px"></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="height:50px" align="right" valign="top">
                                                                                            <asp:ImageButton ID="IbtnNuevo" runat="server" CausesValidation="False" onclick="IbtnNuevo_Click" SkinID="IBtnNuevoF" />
                                                                                            <asp:ImageButton ID="IbtnBuscar" runat="server" OnClick="IbtnBuscar_Click" SkinID="IBtnBuscar" CausesValidation="False" />
                                                                                        </td>
                                                                                  </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                </table>
                                                                
                                                                </td>
                                                              </tr>
                                                            </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
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
		<script type="text/javascript">
		    function UpdateItemCountField(sender, args) {
		        //set the footer text
		        sender.get_dropDownElement().lastChild.innerHTML = "Total en " + sender.get_items().get_count() + " registros";
		    }
        </script>
    <asp:SqlDataSource ID="SqlDataSourcex1" runat="server"></asp:SqlDataSource>                                
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>                                    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
        <%---------------------------------------parte de template ----------------------------------------------------------------%>
            <telerik:AjaxSetting AjaxControlID="IbtnDesactivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnActivar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="CmbTipoEquipofiltro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CmbEqBitacorafiltro" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnBuscar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
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
            <telerik:AjaxSetting AjaxControlID="IBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LBtnNuevoRegistro">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="IbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="LbtnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                    <telerik:AjaxUpdatedControl ControlID="PnlBuscar" 
                        LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlFilto" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
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
