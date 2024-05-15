<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;"> ]>
    
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
<xsl:template match="/">

<html>

        
<style>


.LitleText{
font-family:"Times New Roman", Times, serif;
font-weight:bold;
font-size:9px;
}

.calibri {
	font-family:"Times New Roman", Times, serif;
	font-size:13px;
	font-weight:bold;
	color:Black;
}

.txtAzul {
	font-family:"Times New Roman", Times, serif;
	font-size:12px;
	font-weight:bold;
	color:#0000CC;
}

.titulo {
	
	font-family:"Times New Roman", Times, serif;
	font-size:13px;
	font-style:italic;
	font-stretch:expanded;
	text-decoration:underline;
	font-weight:bold;
	color:#663300;
}

.titulo2 {
	
	font-family:"Times New Roman", Times, serif;
	font-size:13px;
	font-style:italic;
	font-stretch:expanded;
	font-weight:bold;
	color:Black;
}

.normal {
	
	font-family:"Times New Roman", Times, serif;
	font-size:12px;
	color:Black;
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
 

 div#content{
 
  top:220;
  width:100%;
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
<div id="header" align="center">
 <table width="800"  BORDER="0" cellpadding="0" cellspacing="0" >
    <tr>
	    <td HEIGHT="82" colspan="5" VALIGN="TOP" CLASS="calibri">
	       <img src="..\images\pie.jpg" /></td>
	</tr>
 </table>
</div>
<div id="footer" align="center">
<img src="..\images\pie2.jpg"  align="bottom"/>	 
</div>  
<body topmargin="120" bottommargin="100">
<div id="content">
	<table width="800"  BORDER="0" cellpadding="2" cellspacing="1" >
	<tr>
	  <td HEIGHT="23" colspan="5" align="center" valign="top">
      <span class="calibri"><b>INFORME DE INSPECCION N°
      <xsl:for-each select="*/ROW[1]"><xsl:value-of select="NUM"/>
      &#160;<xsl:value-of select="PLANTA"/></xsl:for-each></b>
      </span></td>
	</tr>
	<tr>
	  <td width="57" HEIGHT="118"></td>
      <td colspan="2" valign="top">
        <span class="calibri">
      		PARA		:<br />
      		REF.		:<br />
            FECHA		:<br />
            INSPECTORES :<br />
            OT DE INSPECCION.:<br />
        </span></td>
	  <td colspan="2" valign="top" CLASS="normal">
                JEFES DE TURNO<br />
                <xsl:for-each select="*/ROW[1]">
           		INFORME Nº <xsl:value-of select="NUM"/>&#160;<xsl:value-of select="PLANTA"/><br />
                <xsl:value-of select="INICIO"/> AL 
                <xsl:value-of select="TERMINO"/><br />
                JORGE BALLINAY – L.HURTADO <br />
            	<xsl:value-of select="FOLIO_OT"/>
                </xsl:for-each>            </td>
      </tr>
            <xsl:for-each select="*/ROW"> 
			<tr >
			  <td height="42" colspan="2" valign="top" >
              	<span class="titulo"><xsl:value-of select="EQUIPO_PRIN"/></span><BR /><BR />
                <span class="titulo2"><xsl:value-of select="DESC_EQUIPO"/></span></td>
			  <td colspan="2" valign="top" class="normal"></td>
			  <td valign="top" class="normal"></td>
			</tr>
            <xsl:for-each select="DESCRIP" >
			  <tr>
				<td colspan="2" valign="top" CLASS="calibri" width="20%"></td>
			  <td colspan="2" valign="top" class="normal" width="70%">
              	<xsl:value-of select="DESCRIPCION" />
                 Fecha Inspeccion <xsl:value-of select="FECHA" />
                 ID<xsl:value-of select="ID" />&#160;
                 <span  class="txtAzul">AVISO/OT <xsl:value-of select="REPORT" /></span><BR />
                 <center>
                  <xsl:for-each select="FILES" >
              	           <img  WIDTH="200PX" style="border:1PX #000000">
                	           <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
                	       </img>&#160;&#160;&#160;
           	      	</xsl:for-each>
                </center></td>
		      <td width="10%">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
			  </tr>
             </xsl:for-each> 
			<tr>
			  <td  colspan="2" valign="top" CLASS="calibri" >RECOMENDACIÓN</td>
			  <td colspan="2" valign="top" class="normal"><xsl:value-of select="RECOMENDACION"/></td>
			  <td></td>
			</tr>
              	<!--tr >
			  <td colspan="2" valign="top" CLASS="txtAzul">AVISO</td>
			  <td colspan="2" valign="top" CLASS="txtAzul">
                <xsl:value-of select="REPORT"/>
                <xsl:choose>
			       	<xsl:when test="COLOR = 'BAJA'"></xsl:when>
                   	<xsl:when test="COLOR = 'MEDIA'"></xsl:when>
                    <xsl:when test="COLOR = 'ALTA'"></xsl:when>
                  <xsl:otherwise></xsl:otherwise>
                </xsl:choose></td>
			  <td></td>
           	  </tr-->
              	<tr>
              	  <td height="50">&#160;</td>
              	  <td width="119">&#160;</td>
              	  <td width="86">&#160;</td>
              	  <td width="489">&#160;</td>
   	              <td></td>
   	  			</tr> 
            </xsl:for-each>  
</table>
</div> 
</body>             
</html> 
</xsl:template>
</xsl:stylesheet> 