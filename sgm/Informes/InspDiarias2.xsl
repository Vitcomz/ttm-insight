<?xml version="1.0" encoding="utf-8"?><!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
						doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">
<html>
<style>
.body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family:Verdana, Tahoma, Arial;
	font-size: 11px;
	font-weight:normal;
}

.LitleText{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:9px;
}

.calibri {
	
	font-family: Arial, Helvetica, sans-serif;
	font-size:11px;
	font-weight:bold;
	color:Black;
}

</style> 
<body topmargin="0">
	<table cellpadding="2" cellspacing="1"  BORDER="1" BORDERCOLOR="#000000"  CLASS="calibri">

            <xsl:for-each select="*/ROW"> 
            <xsl:if test="BREAK = 1">
            <tr bgcolor="#CCCCCC">
                <td width="204"><b>IMAGEN</b></td>
                <td width="152"><b>OBSERVACION</b></td>
                <td width="152"><b>RECOMENDACION</b></td>
                <td width="106"><b>POSIBLES CAUSAS RAICES</b></td>
                <td width="115"><b>CRITICIDAD 1SAP</b></td>
            </tr>		
            </xsl:if>	
    		<tr height="150">
				<td valign="top" >
                                    
                    ID:&nbsp;<xsl:value-of select="ID"/></span>&nbsp;&nbsp;<xsl:value-of select="DESC_EQ_PRINCIPAL"/><BR />
  					<img STYLE="border-color:#666666" BORDER="1" height="230px" ALIGN="middle" 
    				ONERROR="this.src='../images/noDisponible.png';"  src="../images/noDisponible.png">
                    <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute></img><BR />
            		<xsl:value-of select="EQUIPO"/>&nbsp;<xsl:value-of select="COMPONENTE"/>
             </td>
				<td valign="top"><xsl:value-of select="DESCRIPCION"/></td>
                <td valign="top"><xsl:value-of select="RECOMENDACION"/></td>
				<td valign="top"><xsl:value-of select="CAUSA"/></td>
				<td  ALIGN="LEFT" valign="top"><select datafld="CRITICIDAD_2" class="calibri_16">
    					<option value="1">1  <24 hrs</option>
                        <option value="2">2  <7  días</option>
                        <option value="3">3  <30 días</option>
                        <option value="4">4  <90 días</option>
    					</select>&nbsp;<BR />
                        <SPAN class="tinyText" >AVISO/OT</SPAN><BR />
            			<INPUT datafld="REPORT" class="tinyTextBox" size="17"/></td>
<!--                <xsl:choose>
			       	<xsl:when test="COLOR = 'BAJA'">
            			<td bgcolor="#0033FF"><xsl:value-of select="COLOR"/></td>
          			</xsl:when>
                   	<xsl:when test="COLOR = 'MEDIA'">
            			<td bgcolor="#FFFF00"><xsl:value-of select="COLOR"/></td>
          			</xsl:when>
                    <xsl:when test="COLOR = 'ALTA'">
            			<td bgcolor="#FF0000"><xsl:value-of select="COLOR"/></td>
        			</xsl:when>
                     <xsl:otherwise><td>&#160;</td></xsl:otherwise>
                </xsl:choose>-->
			</tr>
          </xsl:for-each> 
</table>
</body>
                 
</html> 
</xsl:template> 
</xsl:stylesheet> 