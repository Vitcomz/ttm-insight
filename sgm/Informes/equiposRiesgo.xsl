<?xml version="1.0" encoding="ISO-8859-1"?> 

    
<xsl:stylesheet version = '1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
<xsl:output method="html" encoding="ISO-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">
<html>
<style>

 
.LitleText{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:9px;
}

.noborder{
border:solid 0px #000000;
}



.calibri {
	
	font-family: Arial, Helvetica, sans-serif;
	font-size:11px;
	font-weight:bold;
	color:Black;
}

.titulo{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:12px;
	font-weight:bold;
	
}

.texto{
font-family:Verdana, Tahoma, Arial;
font-size:11px;
font-weight:normal;
border:solid 1px #FFFFFF;
}

.body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family:"Times New Roman", Times, serif;
	font-size: 11px;
	font-weight:normal;
	padding:120px 0px 65px 0px;
}

 div#header{
  position:absolute;
  top:0;
  left:0;
  width:100%;
  height:120px;
 }
 



div#footer{
  position:absolute;
  bottom:0;
  left:0;
  width:100%;
  height:70px;
 }
 
@media print{
  body>div#header{
   position:fixed;
   height:80%;
  }
 
  body>div#content{
  margin-bottom:100px;
   height:80%;
  }
  
   body>div#footer{
   position:fixed;
  }
}

 @media screen{
  
   body>div#footer{
   position:fixed;
   height:0px;
  }
  
}

 * html body{
  overflow:hidden;
 } 
 * html div#content{
  height:80%;
 }
 
</style>

<body>
<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="1" id="tabBitacora">
<xsl:for-each select="*/ROW">
<TR>
	<TD WIDTH="210px" >
   					CORRELATIVO:<b><xsl:value-of select="N"/></b><br />
                    ID:<b><xsl:value-of select="ID"/></b><br />
    				EQUIPO:<b><xsl:value-of select="EQUIPO_PRI"/></b><br />
                    COMPONENTE:<b><xsl:value-of select="EQUIPO"/></b><br />
    				F. INSPECCION<b><xsl:value-of select="FECHA"/></b><br />
                    DIAS PENDIENTE<b><xsl:value-of select="DIAS"/></b><br />
                    CRITICIDAD<b><xsl:value-of select="COLOR"/></b><br />
              </TD>
    <TD WIDTH="466px">
    <b><xsl:value-of select="DESCRIPCION" /></b><br />
    RECOMENDACION:<b><xsl:value-of select="RECOMENDACION" /></b><br />
    </TD>
  <TD WIDTH="106">
  <img  WIDTH="200px">
      <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
  </img>
   </TD>
</TR>
</xsl:for-each> 
</TABLE>
</body>
</html>
</xsl:template>
</xsl:stylesheet>