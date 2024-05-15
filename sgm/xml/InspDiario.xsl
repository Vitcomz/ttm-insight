<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version = '1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
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
    <tr>
	     <td WIDTH="188" ROWSPAN="2" colspan="3"><img SRC="../Images/Logo1.jpg"/></td>
    	 <td WIDTH="405" HEIGHT="45" colspan="2" ALIGN="CENTER" VALIGN="TOP" CLASS="titulo">
         	SISTEMA DE GESTION INTEGRADO<br />
   	      INFORME DIARIO DE INSPECCIONES</td>
    	 <td WIDTH="402" VALIGN="TOP" CLASS="calibri" colspan="5">
         			FECHA DE INSPECCION DESDE: <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FECHA_INI"/> </xsl:for-each>
                    HASTA: 
                    <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FECHA_FIN"/> </xsl:for-each></td>
	</tr>
	<tr>
	     <td HEIGHT="25" CLASS="calibri" colspan="7">
         CLIENTE: <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FAENA"/> </xsl:for-each> 
          </td>
	     <td> </td>
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
                  <td><b>FOTOGRAFIAS</b></td>
			 </tr>
            <xsl:for-each select="*/ROW"> 
			<tr >
				<td valign="top" onClick="return;"><xsl:value-of select="ID"/></td>
				<td valign="top"><xsl:value-of select="FECHA"/></td>
                <td valign="top"><xsl:value-of select="EQUIPO"/></td>
				<td valign="top"><xsl:value-of select="EQUIPO"/></td>
				<td valign="top"><xsl:value-of select="DESCRIPCION"/></td>
				<td valign="top"><xsl:value-of select="CAUSA"/></td>
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
                <TD>
                <table class="LitleText">
                    	<tr>
                	           <img  WIDTH="200PX">
                	           <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
                	           </img>&#160;&#160;&#160;&#160;&#160;
                        </tr>
                	</table></TD>
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