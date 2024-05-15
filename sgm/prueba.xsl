<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl"> 

<xsl:template match="/"> 
<html> 
<body> 
<style>
.jr{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-size:9px;
background-color:#33CCFF;
}
</style>
<table border="1"  class="jr"> 
<tr> 
<td><b>Nombre</b></td> 
<td><b>Mercado</b></td> 
<td><b>Precio</b></td> 
<td><b>Fecha</b></td> 
</tr> 

<xsl:for-each select="*/cotizacion" order-by="nombre"> 
<tr> 
<td><xsl:value-of select="nombre"/></td> 
<td><xsl:value-of select="mercado"/></td> 
<td><xsl:value-of select="precio"/></td> 
<td><xsl:value-of select="fecha/dia"/>-<xsl:value-of select="fecha/mes"/>-<xsl:value-of select="fecha/anio"/></td> 
</tr> 
</xsl:for-each> 
</table> 
</body> 
</html> 
</xsl:template> 
</xsl:stylesheet> 