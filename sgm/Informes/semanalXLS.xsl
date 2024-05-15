<?xml version="1.0" encoding="utf-8"?>
<!-- DWXMLSource="../prueba.xml" -->
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
	<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Untitled Document</title>
</head>

<body topmargin="0">
	<table width="1258"  BORDER="1" cellpadding="2" cellspacing="1" BORDERCOLOR="#000000"  CLASS="calibri">
  <tr>
	     <td WIDTH="220" ROWSPAN="2" colspan="3"><img SRC="http://www.ttminsight.cl/sgm/Images/Logo1.jpg"/></td>
    	 <td WIDTH="405" HEIGHT="65" colspan="2" ALIGN="CENTER" VALIGN="TOP" CLASS="titulo">
         <strong>SISTEMA DE GESTION INTEGRADO<br />
   	      INFORME SEMANAL DE INSPECCIONES
          </strong></td>
    	 <td WIDTH="402" VALIGN="TOP" CLASS="calibri" colspan="5">
         		<strong>
         			FECHA DE INSPECCION DESDE: <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FECHA_INI"/> </xsl:for-each>
                    HASTA: 
                    <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FECHA_FIN"/> </xsl:for-each>
                </strong>
          </td>
	</tr>
	<tr>
	     <td HEIGHT="35" CLASS="calibri" colspan="7">
         CLIENTE: <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FAENA"/> </xsl:for-each> 
         AREA:<xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="SECCION"/> </xsl:for-each> 
          </td>
     </tr>
   			<tr BGCOLOR="#666666">
				  <td><b>ID</b></td>
   				  <td><b>FECHA</b></td>
                  <td width="80px"><b>EQUIPO</b></td>
   				  <td width="80px"><b>COMPONENTE</b></td>
				  <td><b>OBSERVACION</b></td>
                  <td><b>CAUSA RAIZ</b></td>
				  <td><b>ORIGENES DE LAS FALLAS</b></td>
				  <td><b>GRADO DE CRITICIDAD</b></td>
  				  <td><b>TRATAMIENTO TECNICO TTM</b></td>
			 </tr>
            <xsl:for-each select="*/ROW"> 
			<tr >
				<td valign="top" onClick="return;"><xsl:value-of select="ID"/></td>
				<td valign="top"><xsl:value-of select="FECHA"/></td>
                <td valign="top"><xsl:value-of select="EQUIPO_PRIN"/></td>
				<td valign="top"><xsl:value-of select="EQUIPO"/></td>
				<td valign="top"><xsl:value-of select="DESCRIPCION"/></td>
				<td valign="top"><xsl:value-of select="CAUSA"/>&#160;<br /></td>
				<td  ALIGN="LEFT" valign="top">
  
                 </td>
                <xsl:choose>
			       	<xsl:when test="COLOR = 'BAJA'">
            			<td bgcolor="#00FF33"><xsl:value-of select="COLOR"/></td>
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
<img SRC="http://www.ttminsight.cl/sgm/Images/pie2.jpg"/>
</center>
</body>
</html>

</xsl:template>
</xsl:stylesheet>