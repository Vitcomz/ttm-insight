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
   			<tr BGCOLOR="#666666">
				  <td width="188"><b>FOTOS</b></td>
   				  <td width="188"><b>FECHA</b></td>
                  <td width="188"><b>EQUIPO</b></td>
   				  <td width="405"><b>COMPONENTE</b></td>
				  <td><b>OBSERVACION</b></td>
                  <td width="402"><b>CAUSA RAIZ</b></td>
				  <td><b>ORIGENES DE LAS FALLAS</b></td>
				  <td><b>GRADO DE CRITICIDAD</b></td>
  				  <td><b>TRATAMIENTO TECNICO TTM</b></td>
			 </tr>
            <xsl:for-each select="*/ROW"> 
			<tr height="150">
				<td valign="top" ><xsl:value-of select="ID"/><BR />
                	<img  WIDTH="200PX">
                	           <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
                	</img>                 </td>
				<td valign="top"><xsl:value-of select="FECHA"/></td>
                <td valign="top"><xsl:value-of select="EQUIPO_PRIN"/>&nbsp;<xsl:value-of select="DESC_EQ_PRINCIPAL"/></td>
				<td valign="top"><xsl:value-of select="EQUIPO"/>&nbsp;<xsl:value-of select="COMPONENTE"/></td>
				<td valign="top"><xsl:value-of select="DESCRIPCION"/></td>
				<td valign="top"><xsl:value-of select="CAUSA"/></td>
				<td  ALIGN="LEFT" valign="top">                 </td>
                <xsl:choose>
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
                </xsl:choose>
			    <td ALIGN="LEFT" valign="top"><xsl:value-of select="RECOMENDACION"/></td>
			</tr>
          </xsl:for-each> 
</table>
<center>
<img SRC="../Images/pie2.jpg"/>
</center>
</body>
                 
</html> 
</xsl:template> 
</xsl:stylesheet> 