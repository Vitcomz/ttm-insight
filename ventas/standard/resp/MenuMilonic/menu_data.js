fixMozillaZIndex=true; //Fixes Z-Index problem  with Mozilla browsers but causes odd scrolling problem, toggle to see if it helps
_menuCloseDelay=500;
_menuOpenDelay=150;
_subOffsetTop=2;
_subOffsetLeft=-2;




with(menuStyle=new mm_style()){
bordercolor="#999999";
borderstyle="solid";
borderwidth=1;
fontfamily="Verdana, Tahoma, Arial";
fontsize="75%";
fontstyle="normal";
headerbgcolor="#ffffff";
headercolor="#000000";
offbgcolor="#eeeeee";
offcolor="#000000";
onbgcolor="#ddffdd";
oncolor="#000099";
outfilter="randomdissolve(duration=0.3)";
overfilter="Fade(duration=0.2);Alpha(opacity=90);Shadow(color=#777777', Direction=135, Strength=3)";
padding=4;
pagebgcolor="#82B6D7";
pagecolor="black";
separatorcolor="#999999";
separatorsize=1;
subimage="http://www.milonic.com/menuimages/arrow.gif";
subimagepadding=2;
}

with(milonic=new menuname("Main Menu")){
alwaysvisible=1;
left=10;
orientation="horizontal";
style=menuStyle;
top=10;
aI("text=Vitcomz;url=http://vitcomz.110mb.com/;");
aI("showmenu=Ingresos;text=Ingresos;");
aI("showmenu=Mantencion;text=Mantencion;");
aI("showmenu=Informes;text=Informes;");
aI("showmenu=Links;text=Links;");
}

with(milonic=new menuname("Ingresos")){
overflow="scroll";
style=menuStyle;
aI("text=Usuarios;url=Usuarios/Usuarios.html;")
aI("text=Hardware;url=Hardware/Hardware.html;")
aI("text=Software;url=Software/Software.html;")

}

with(milonic=new menuname("Mantencion")){
style=menuStyle;
aI("text=Product Purchasing Page;url=http://www.milonic.com/cbuy.php;");
aI("text=Contact Us;url=http://www.milonic.com/contactus.php;");
aI("text=Newsletter Subscription;url=http://www.milonic.com/newsletter.php;");
aI("text=FAQ;url=http://www.milonic.com/menufaq.php;");
aI("text=Discussion Forum;url=http://www.milonic.com/forum/;");
aI("text=Software License Agreement;url=http://www.milonic.com/license.php;");
aI("text=Privacy Policy;url=http://www.milonic.com/privacy.php;");
}

with(milonic=new menuname("Informes")){
style=menuStyle;
aI("text=(aq) Web Hosting;url=http://www.a-q.co.uk/;");
aI("text=WebSmith;url=http://www.softidiom.com/?milonicmenu;");
aI("text=SMS 2 Email;url=http://www.sms2email.com/;");
}

with(milonic=new menuname("Links")){
style=menuStyle;
aI("text=Apache Web Server;url=http://www.apache.org/;");
aI("text=MySQL Database Server;url=http://ww.mysql.com/;");
aI("text=PHP - Development;url=http://www.php.net/;");
aI("text=phpBB Web Forum System;url=http://www.phpbb.net/;");
aI("showmenu=Anti Spam;text=Anti Spam Tools;");
}

drawMenus();

