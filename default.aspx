<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Insight.Default"  StylesheetTheme="login" Theme="login" %>
<%@ Register TagPrefix="qsf" TagName="Header" Src="~/ttm_skins/Common/Header.ascx" %>
<%@ Register TagPrefix="qsf" TagName="HeadTagGenereral" Src="~/ttm_skins/Common/HeadTagGenereral.ascx" %>
<%@ Register TagPrefix="qsf" TagName="Footer" Src="~/ttm_skins/Common/Footer.ascx" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <qsf:HeadTagGenereral runat="server" ID="headtitulo"></qsf:HeadTagGenereral>
   <link type="text/css" href="ttm_skins/css/style-ttm.css" rel="stylesheet"  media="screen, projection" />






    <script src="ttm_js/jquery171min.js" type="text/javascript"></script>
</head>
<body style="background-color:#f5f5f5;">
<form id="form1" runat="server">
<telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
<div class="wrapLn01">
<!---- left ----->
	<div class="LogoTTM"></div>
<!---- central ----->
<!---- right ----->
	<div class="WpRgth"><!---- PERFILES -----></div>	
</div>
<!-------------------------------------- SEGUNDO NIVEL ------------------------------------------->
<div class="wrapLn04">
</div>
<!-------------------------------------- NIVEL CENTRO ------------------------------------------->
<div style="display:inline-block;">
	<div class="NombreProyecto" style="width:800px;"></div>
	<div style="width:800px;">
<!--usuario--->
		<div class="Caja01">
		<!--cell 01 -->
            <asp:Panel runat="server" ID="Panel1_1" Visible="False">
			<div id="miContenido1" class="Caja01A">
				<div style="height:110px;"></div>
				<div><asp:ImageButton ID="btn1_1_login" runat="server" SkinID="IBtn1_1_login" 
                        onclick="btn1_1_login_Click"/></div>
			</div>
            </asp:Panel>
		<!--cell 02 -->
            <asp:Panel runat="server" ID="Panel1_2" Visible="False" DefaultButton="Login1$btn1_2_login">
			<div id="miContenido2" class="Caja01B">
				<div style="height:100px;">
					<div>Paso 2 de 3</div>
                    <asp:Login ID="Login1" runat="server" CssClass="login" UserNameLabelText="Usuario :" CreateUserUrl="" PasswordRecoveryText="Recuperar Contraseña" 
                    PasswordRecoveryUrl="" PasswordRequiredErrorMessage="Contraseña Obligatoria" RememberMeText="Recordar usuario" UserNameRequiredErrorMessage="Usuario Obligatorio." DestinationPageUrl="" 
                    PasswordLabelText="Contraseña :" Width="200px" OnAuthenticate="Login1_Authenticate" RememberMeSet="True">
                                                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="12px" ForeColor="White" Font-Names="Arial" Font-Strikeout="False" />
                                                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                                        <TextBoxStyle Font-Size="10px" Font-Names="Arial" />
                                                        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11px" ForeColor="#284775" />
                                                        <CheckBoxStyle Font-Names="Arial" Font-Size="9px" />
                                                        <ValidatorTextStyle Font-Italic="False" Font-Names="Arial" Font-Size="8px" />
                                                        <LabelStyle Font-Italic="False" Font-Names="Arial" Font-Size="10px" />
                                                        <FailureTextStyle Font-Names="Arial" Font-Size="8px" />
                                                        <LayoutTemplate>
                                                        
                                                          <div style="padding:15px 0px;">
                                                                <asp:TextBox ID="UserName" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    Width="150px" BorderStyle="Solid" BorderWidth="1px" Height="16px" 
                                                                    SkinID="TextBox" CausesValidation="True" MaxLength="20" 
                                                                    ToolTip="Ingrese Usuario a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Usuario Obligatorio." Font-Italic="False" Font-Names="Arial" Font-Size="8px"
                                                                                                                                                                        ToolTip="Usuario Obligatorio." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:0px 0px;">
                                                                <asp:TextBox ID="Password" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    TextMode="Password"  Width="150px" BorderStyle="Solid" BorderWidth="1px" 
                                                                    Height="16px"  SkinID="TextBox" 
                                                                    CausesValidation="True" ToolTip="Ingrese Contraseña a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Contraseña Obligatoria" Font-Italic="False" Font-Names="Arial"
                                                                                                                                                                        Font-Size="8px" ToolTip="Contraseña Obligatoria" ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:15px 0px;">
                                                                <asp:ImageButton ID="btn1_2_login" runat="server" CommandName="Login"  
                                                                    SkinID="IBtn1_1_login" onclick="btn1_2_login_Click" />
                                                          </div>
                                                          <div style="padding:7px 0px;">
                                                                <asp:Label ID="lblAlert1" runat="server" Text="Label" BackColor="#FF3300" 
                                                                Font-Bold="True" Font-Names="Arial" Font-Size="12px" ForeColor="White" 
                                                                Visible="False" Width="190px"></asp:Label>
                                                          </div>
                                                        </LayoutTemplate>

                    </asp:Login>
                
				</div>
			</div>
            </asp:Panel>
		<!--cell 03 -->
			<div id="miContenido3" class="Caja01B" style="display:none;">
				<div style="height:100px;">
					<div>Paso 3 de 3</div> 
					<div style="padding:15px 0px;">
						<select id="" name="" class="field2">
                        <option value="pais1">Selección de Faena</option>
                        <option value="pais2">Spence</option>
                        <option value="pais3">Escondida</option>
                        <option value="pais3">Cerro Colorado</option>
                        <option value="pais3">PTMP</option>
                        <option value="pais3">Andina</option>
                        <option value="pais3">Codelco Norte</option>
                        <option value="pais3">El Abra</option>
                        <option value="pais3">Vale Bayovar Mina</option>
                        <option value="pais3">Vale Bayovar Puerto</option>
                        <option value="pais3">Radomiro Tomic</option>
                        <option value="pais3">CEl Abra - Escorpión</option>
                        </select>
					</div>
				</div>
				<div><a href="default.html?perfil=usuario" target="_self"></a></div>
			</div>
            <asp:Panel runat="server" ID="Panel1_3" Visible="False">
			<div id="miContenido3" class="Caja01B">
				<div style="height:100px;">
					<div>Paso 3 de 3</div>
                    <div style="padding:6px 0px;">
						<div style="padding:2px 0px;">
                            <asp:Label ID="lblnombre1" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
                        <div style="padding:2px 0px;">
                            <asp:Label ID="lblcargo1" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
					</div>
					<div style="padding:2px 0px;">
                        <telerik:RadComboBox ID="CmbFaenasFiltro1" runat="server" class="field2" 
                            DataTextField="description" DataValueField="value" CausesValidation="False" 
                            AutoPostBack="True" 
                            onselectedindexchanged="CmbFaenasFiltro1_SelectedIndexChanged">
                        </telerik:RadComboBox>
					</div>
				</div>
			</div>
            </asp:Panel>
		</div>
<!--fin usuario--->
<!--Admin -->
		<div class="Caja02">
		<!--cell 01 -->
            <asp:Panel runat="server" ID="Panel2_1" Visible="False">
			<div id="miContenido4" class="Caja02A">
				<div style="height:110px;"></div>
				<div><asp:ImageButton ID="btn2_1_login" runat="server" SkinID="IBtn2_1_login" 
                        onclick="btn2_1_login_Click"/></div>
			</div>
            </asp:Panel>
		<!--cell 02 -->
            <asp:Panel runat="server" ID="Panel2_2" Visible="False" DefaultButton="Login2$btn2_2_login">
			<div id="miContenido5" class="Caja02B">
				<div style="height:100px;">
					<div>Paso 2 de 3</div>
                    <asp:Login ID="Login2" runat="server" CssClass="login" UserNameLabelText="Usuario :" CreateUserUrl="" PasswordRecoveryText="Recuperar Contraseña" 
                    PasswordRecoveryUrl="" PasswordRequiredErrorMessage="Contraseña Obligatoria" RememberMeText="Recordar usuario" UserNameRequiredErrorMessage="Usuario Obligatorio." DestinationPageUrl="" 
                    PasswordLabelText="Contraseña :" Width="200px" OnAuthenticate="Login2_Authenticate" RememberMeSet="True">
                                                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="12px" ForeColor="White" Font-Names="Arial" Font-Strikeout="False" />
                                                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                                        <TextBoxStyle Font-Size="10px" Font-Names="Arial" />
                                                        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11px" ForeColor="#284775" />
                                                        <CheckBoxStyle Font-Names="Arial" Font-Size="9px" />
                                                        <ValidatorTextStyle Font-Italic="False" Font-Names="Arial" Font-Size="8px" />
                                                        <LabelStyle Font-Italic="False" Font-Names="Arial" Font-Size="10px" />
                                                        <FailureTextStyle Font-Names="Arial" Font-Size="8px" />
                                                        <LayoutTemplate>
                                                        
                                                          <div style="padding:15px 0px;">
                                                                <asp:TextBox ID="UserName" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    Width="150px" BorderStyle="Solid" BorderWidth="1px" Height="16px" 
                                                                    SkinID="TextBox" CausesValidation="True" MaxLength="20" 
                                                                    ToolTip="Ingrese Usuario a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Usuario Obligatorio." Font-Italic="False" Font-Names="Arial" Font-Size="8px"
                                                                                                                                                                        ToolTip="Usuario Obligatorio." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:0px 0px;">
                                                                <asp:TextBox ID="Password" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    TextMode="Password"  Width="150px" BorderStyle="Solid" BorderWidth="1px" 
                                                                    Height="16px" SkinID="TextBox" 
                                                                    CausesValidation="True" ToolTip="Ingrese Contraseña a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Contraseña Obligatoria" Font-Italic="False" Font-Names="Arial"
                                                                                                                                                                        Font-Size="8px" ToolTip="Contraseña Obligatoria" ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:15px 0px;">
                                                                <asp:ImageButton ID="btn2_2_login" runat="server" CommandName="Login"  
                                                                    SkinID="IBtn2_1_login" onclick="btn2_2_login_Click" />
                                                          </div>
                                                          <div style="padding:7px 0px;">
                                                                <asp:Label ID="lblAlert2" runat="server" Text="Label" BackColor="#FF3300" 
                                                                Font-Bold="True" Font-Names="Arial" Font-Size="12px" ForeColor="White" 
                                                                Visible="False" Width="190px"></asp:Label>
                                                          </div>
                                                        </LayoutTemplate>

                    </asp:Login>
                
				</div>
			</div>
            </asp:Panel>
		<!--cell 03 -->
            <asp:Panel runat="server" ID="Panel2_3" Visible="False">
			<div id="miContenido6" class="Caja02B">
				<div style="height:100px;">
					<div>Paso 3 de 3</div>
                    <div style="padding:6px 0px;">
						<div style="padding:2px 0px;">
                            <asp:Label ID="lblnombre2" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
                        <div style="padding:2px 0px;">
                            <asp:Label ID="lblcargo2" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
					</div>
					<div style="padding:2px 0px;">
                        <telerik:RadComboBox ID="CmbFaenasFiltro2" runat="server" class="field2" 
                            DataTextField="description" DataValueField="value" CausesValidation="False" 
                            AutoPostBack="True" 
                            onselectedindexchanged="CmbFaenasFiltro2_SelectedIndexChanged">
                        </telerik:RadComboBox>
					</div>
				</div>
			</div>
            </asp:Panel>
		</div>

<!-- fin admin -->
<!-- C interno -->
		<div class="Caja03">
		<!--cell 01 -->
            <asp:Panel runat="server" ID="Panel3_1" Visible="False">
			<div id="miContenido7" class="Caja03A">
				<div style="height:110px;"></div>
				<div><asp:ImageButton ID="btn3_1_login" runat="server" SkinID="IBtn3_1_login" 
                        onclick="btn3_1_login_Click"/></div>
			</div>
            </asp:Panel>
		<!--cell 02 -->
            <asp:Panel runat="server" ID="Panel3_2" Visible="False"  DefaultButton="Login3$btn3_2_login">
			<div id="miContenido8" class="Caja03B">
				<div style="height:100px;">
					<div>Paso 2 de 3</div>
                    <asp:Login ID="Login3" runat="server" CssClass="login" UserNameLabelText="Usuario :" CreateUserUrl="" PasswordRecoveryText="Recuperar Contraseña" 
                    PasswordRecoveryUrl="" PasswordRequiredErrorMessage="Contraseña Obligatoria" RememberMeText="Recordar usuario" UserNameRequiredErrorMessage="Usuario Obligatorio." DestinationPageUrl="" 
                    PasswordLabelText="Contraseña :" Width="200px" OnAuthenticate="Login3_Authenticate" RememberMeSet="True">
                                                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="12px" ForeColor="White" Font-Names="Arial" Font-Strikeout="False" />
                                                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                                        <TextBoxStyle Font-Size="10px" Font-Names="Arial" />
                                                        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11px" ForeColor="#284775" />
                                                        <CheckBoxStyle Font-Names="Arial" Font-Size="9px" />
                                                        <ValidatorTextStyle Font-Italic="False" Font-Names="Arial" Font-Size="8px" />
                                                        <LabelStyle Font-Italic="False" Font-Names="Arial" Font-Size="10px" />
                                                        <FailureTextStyle Font-Names="Arial" Font-Size="8px" />
                                                        <LayoutTemplate>
                                                        
                                                          <div style="padding:15px 0px;">
                                                                <asp:TextBox ID="UserName" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    Width="150px" BorderStyle="Solid" BorderWidth="1px" Height="16px" 
                                                                    SkinID="TextBox" CausesValidation="True" MaxLength="20" 
                                                                    ToolTip="Ingrese Usuario a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Usuario Obligatorio." Font-Italic="False" Font-Names="Arial" Font-Size="8px"
                                                                                                                                                                        ToolTip="Usuario Obligatorio." ValidationGroup="Login3">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:0px 0px;">
                                                                <asp:TextBox ID="Password" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    TextMode="Password"  Width="150px" BorderStyle="Solid" BorderWidth="1px" 
                                                                    Height="16px"  SkinID="TextBox" 
                                                                    CausesValidation="True" ToolTip="Ingrese Contraseña a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Contraseña Obligatoria" Font-Italic="False" Font-Names="Arial"
                                                                                                                                                                        Font-Size="8px" ToolTip="Contraseña Obligatoria" ValidationGroup="Login3">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:15px 0px;">
                                                                <asp:ImageButton ID="btn3_2_login" runat="server" CommandName="Login"  
                                                                    SkinID="IBtn3_1_login" onclick="btn3_2_login_Click" />
                                                          </div>
                                                          <div style="padding:7px 0px;">
                                                                <asp:Label ID="lblAlert3" runat="server" Text="Label" BackColor="#FF3300" 
                                                                Font-Bold="True" Font-Names="Arial" Font-Size="12px" ForeColor="White" 
                                                                Visible="False" Width="190px"></asp:Label>
                                                          </div>
                                                        </LayoutTemplate>

                    </asp:Login>
                
				</div>
			</div>
            </asp:Panel>
		<!--cell 03 -->
            <asp:Panel runat="server" ID="Panel3_3" Visible="False">
			<div id="miContenido9" class="Caja03B">
				<div style="height:100px;">
					<div>Paso 3 de 3</div>
                    <div style="padding:6px 0px;">
						<div style="padding:2px 0px;">
                            <asp:Label ID="lblnombre3" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
                        <div style="padding:2px 0px;">
                            <asp:Label ID="lblcargo3" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
					</div>
					<div style="padding:2px 0px;">
                        <telerik:RadComboBox ID="CmbFaenasFiltro3" runat="server" class="field2" 
                            DataTextField="description" DataValueField="value" CausesValidation="False" 
                            AutoPostBack="True" 
                            onselectedindexchanged="CmbFaenasFiltro3_SelectedIndexChanged" >
                        </telerik:RadComboBox>
					</div>
				</div>
			</div>
            </asp:Panel>
		</div>
<!-- fin C interno -->
<!-- Inspector -->
		<div class="Caja04">
		<!--cell 01 -->
            <asp:Panel runat="server" ID="Panel4_1" Visible="False">
			<div id="miContenido10" class="Caja04A">
				<div style="height:110px;"></div>
				<div><asp:ImageButton ID="btn4_1_login" runat="server" SkinID="IBtn4_1_login" 
                        onclick="btn4_1_login_Click"/></div>
			</div>
            </asp:Panel>
		<!--cell 02 -->
            <asp:Panel runat="server" ID="Panel4_2" Visible="False"  DefaultButton="Login4$btn4_2_login">
			<div id="miContenido11" class="Caja04B">
				<div style="height:100px;">
					<div>Paso 2 de 3</div>
                    <asp:Login ID="Login4" runat="server" CssClass="login" UserNameLabelText="Usuario :" CreateUserUrl="" PasswordRecoveryText="Recuperar Contraseña" 
                    PasswordRecoveryUrl="" PasswordRequiredErrorMessage="Contraseña Obligatoria" RememberMeText="Recordar usuario" UserNameRequiredErrorMessage="Usuario Obligatorio." DestinationPageUrl="" 
                    PasswordLabelText="Contraseña :" Width="200px" OnAuthenticate="Login4_Authenticate" RememberMeSet="True">
                                                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="12px" ForeColor="White" Font-Names="Arial" Font-Strikeout="False" />
                                                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                                        <TextBoxStyle Font-Size="10px" Font-Names="Arial" />
                                                        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Arial" Font-Size="11px" ForeColor="#284775" />
                                                        <CheckBoxStyle Font-Names="Arial" Font-Size="9px" />
                                                        <ValidatorTextStyle Font-Italic="False" Font-Names="Arial" Font-Size="8px" />
                                                        <LabelStyle Font-Italic="False" Font-Names="Arial" Font-Size="10px" />
                                                        <FailureTextStyle Font-Names="Arial" Font-Size="8px" />
                                                        <LayoutTemplate>
                                                        
                                                          <div style="padding:15px 0px;">
                                                                <asp:TextBox ID="UserName" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    Width="150px" BorderStyle="Solid" BorderWidth="1px" Height="16px" 
                                                                    SkinID="TextBox" CausesValidation="True" MaxLength="20" 
                                                                    ToolTip="Ingrese Usuario a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Usuario Obligatorio." Font-Italic="False" Font-Names="Arial" Font-Size="8px"
                                                                                                                                                                        ToolTip="Usuario Obligatorio." ValidationGroup="Login4">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:0px 0px;">
                                                                <asp:TextBox ID="Password" runat="server" Font-Names="Arial" Font-Size="12px" 
                                                                    TextMode="Password"  Width="150px" BorderStyle="Solid" BorderWidth="1px" 
                                                                    Height="16px" SkinID="TextBox" 
                                                                    CausesValidation="True" ToolTip="Ingrese Contraseña a autenticar"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Contraseña Obligatoria" Font-Italic="False" Font-Names="Arial"
                                                                                                                                                                        Font-Size="8px" ToolTip="Contraseña Obligatoria" ValidationGroup="Login4">*</asp:RequiredFieldValidator>
                                                          </div>
                                                          <div style="padding:15px 0px;">
                                                                <asp:ImageButton ID="btn4_2_login" runat="server" CommandName="Login"  
                                                                    SkinID="IBtn4_1_login" onclick="btn4_2_login_Click" />
                                                          </div>
                                                          <div style="padding:0px 0px;">
                                                                <asp:Label ID="lblAlert4" runat="server" Text="Label" BackColor="#FF3300" 
                                                                Font-Bold="True" Font-Names="Arial" Font-Size="12px" ForeColor="White" 
                                                                Visible="False" Width="190px"></asp:Label>
                                                          </div>
                                                        </LayoutTemplate>

                    </asp:Login>
                
				</div>
			</div>
            </asp:Panel>
		<!--cell 03 -->
            <asp:Panel runat="server" ID="Panel4_3" Visible="False">
			<div id="miContenido12" class="Caja04B">
				<div style="height:100px;">
					<div>Paso 3 de 3</div>
                    <div style="padding:6px 0px;">
						<div style="padding:2px 0px;">
                            <asp:Label ID="lblnombre4" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                                Width="190px" Height="16px"></asp:Label>
                        </div>
                        <div style="padding:2px 0px;">
                            <asp:Label ID="lblcargo4" runat="server"  
                            Font-Bold="True" Font-Names="Arial" Font-Size="11px" ForeColor="White" 
                            Visible="True" Width="190px"></asp:Label>
                        </div>
					</div>
					<div style="padding:2px 0px;">
                        <telerik:RadComboBox ID="CmbFaenasFiltro4" runat="server" class="field2" 
                            DataTextField="description" DataValueField="value" CausesValidation="False" 
                            AutoPostBack="True" 
                            onselectedindexchanged="CmbFaenasFiltro4_SelectedIndexChanged" >
                        </telerik:RadComboBox>
					</div>
				</div>
			</div>
            </asp:Panel>
		</div>
<!-- fin Inspector -->
	</div>
</div>
<asp:HiddenField ID="hddwinwidth" runat="server" />
<asp:HiddenField ID="hddwinheight" runat="server" />
<script>
    var lados = 400;
    if ($(window).height() < 900) {
        lados = lados - 400;
    }

    var ancho = ($(window).width() );//- lados
    
    $("#hddwinwidth").val(ancho);
    $("#hddwinheight").val($(window).height());

</script>
<!-------------------------------------- NIVEL INFO GENERAL ------------------------------------------->

<div class="wrapLn05">
	<div class="txtProp">Sistema :: <span style="font-family:MyriadPro-Semibold, Helvetica, sans-serif;">TTM Insight</span></div>
	<div class="txtDatco">Powered by TTM Chile</div>
</div>

    <telerik:radwindowmanager id="RadWindowManager1" runat="server" behavior="Default" initialbehavior="None" left="" top=""></telerik:radwindowmanager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
          <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="btn1_1_login">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel1_1"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel1_2"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="Login1">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel1_2" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel1_3" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btn2_1_login">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel2_1"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel2_2"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="Login2">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel2_2" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel2_3" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btn3_1_login">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel3_1"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel3_2"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="Login3">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel3_2" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel3_3" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btn4_1_login">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel4_1"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel4_2"
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="Login4">
                  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="Panel4_2" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="Panel4_3" 
                          LoadingPanelID="RadAjaxLoadingPanel1" />
                  </UpdatedControls>
              </telerik:AjaxSetting>
          </AjaxSettings>
      </telerik:RadAjaxManagerProxy>
      <telerik:radajaxloadingpanel id="RadAjaxLoadingPanel1" runat="server" skin="Default"></telerik:radajaxloadingpanel>


  
</form>
</body>
</html>