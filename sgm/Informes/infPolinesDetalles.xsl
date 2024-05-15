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
	font-size: 10px;
	font-weight:normal;
}

.LitleText{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:7px;
background-color:#FFF;
}

.LitleTextinv{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:8px;
color:#FFF !important;
}


.LitleTextinvBlack{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:8px;
color:#000 !important;
}

.LitleTextTit{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:8px;
color:#FFF;
background-color:#666;
}

.LitleTextTit2{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:10px;
color:#FFF;
background-color:#666;
}

.LitleTextTit3{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-weight:bold;
font-size:11px;
}

.calibri {
	
	font-family: Arial, Helvetica, sans-serif;
	font-size:11px;
	font-weight:bold;
	color:Black;
}

.titulo {
	
	font-family: Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight:bold;
	color:Black;
}

</style> 
<body topmargin="0" leftmargin="0">
<table>
    <tr>
	     <td>
	<table cellpadding="0" cellspacing="0"  BORDER="1" BORDERCOLOR="#000000"  CLASS="calibri">
<!--     <tr BGCOLOR="#666666">
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
			</tr>-->
            <tr>
				 <td HEIGHT="15" colspan="10" align="center">
                 	<table width="930" border="0" cellspacing="0" cellpadding="0">
                     <tr>
                          <td align="center" class="LitleTextTit3"><b>IZQUIERDA</b></td>
                          <td align="center" class="LitleTextTit3"><b>CENTRO</b></td>
                          <td align="center" class="LitleTextTit3"><b>DERECHA</b></td>
                     </tr>
                      <tr>
                         <td VALIGN="TOP">
                                     <table>
                                     <tr BGCOLOR="#666666" class="LitleTextTit">
                                          <td></td>
                                          <td align="center" width="80px"><b>MESA</b></td>
                                          <td align="center"><b>ESTACION</b></td>
                                          <td align="center"><b>TIPO</b></td>
                                          <td align="center"><b>FALLA</b></td>
                                          <td align="center"><b>INSPECCION</b></td>
                                          <td align="center"><b>CAMBIO</b></td>
                                     </tr>
                        <xsl:for-each select="*/ROW"> 
                                      <tr BGCOLOR="#ffffff"  class="LitleText" >
                                      <xsl:choose>
                                      <xsl:when test="POS = 'IZQ'">
                                                      <xsl:choose>
                                                            <xsl:when test="COLOR = 'BAJA'">
                                                                <td bgcolor="#3366FF"  class="LitleTextinv"  VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                            <xsl:when test="COLOR = 'MEDIA'">
                                                                <td bgcolor="#FFFF00" class="LitleTextinvBlack"  VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                            <xsl:when test="COLOR = 'ALTA'">
                                                                <td bgcolor="#FF0000" class="LitleTextinv"  VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                             <xsl:otherwise><td>&#160;</td></xsl:otherwise>
                                                      </xsl:choose>
                                                      <td valign="top"><xsl:value-of select="MESA"/></td>
                                                      <td valign="top"><xsl:value-of select="ESTACION"/></td>
                                                      <td valign="top"><xsl:value-of select="TIPO"/></td>
                                                      <td valign="top"><xsl:value-of select="FALLAS"/></td>
                                                      <td valign="top"><xsl:value-of select="INSPECCION"/></td>
                                                      <td valign="top"><xsl:value-of select="CAMBIO"/></td> 
                                    </xsl:when>
                                    </xsl:choose>
                                    </tr>
                        </xsl:for-each> 
                        </table>
                        </td>
                         <td VALIGN="TOP">
                                     <table>
                                     <tr BGCOLOR="#666666" class="LitleTextTit">
                                          <td></td>
                                          <td align="center" width="80px"><b>MESA</b></td>
                                          <td align="center"><b>ESTACION</b></td>
                                          <td align="center"><b>TIPO</b></td>
                                          <td align="center"><b>FALLA</b></td>
                                          <td align="center"><b>INSPECCION</b></td>
                                          <td align="center"><b>CAMBIO</b></td>
                                     </tr>
                        <xsl:for-each select="*/ROW"> 
                                      <tr BGCOLOR="#ffffff"  class="LitleText">
                                      <xsl:choose>
                                      <xsl:when test="POS = 'CEN'">
                                                      <xsl:choose>
                                                            <xsl:when test="COLOR = 'BAJA'">
                                                                <td bgcolor="#3366FF"  class="LitleTextinv" VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                            <xsl:when test="COLOR = 'MEDIA'">
                                                                <td bgcolor="#FFFF00" class="LitleTextinvBlack" VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                            <xsl:when test="COLOR = 'ALTA'">
                                                                <td bgcolor="#FF0000" class="LitleTextinv" VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                             <xsl:otherwise><td>&#160;</td></xsl:otherwise>
                                                      </xsl:choose>
                                                      <td valign="top"><xsl:value-of select="MESA"/></td>
                                                      <td valign="top"><xsl:value-of select="ESTACION"/></td>
                                                      <td valign="top"><xsl:value-of select="TIPO"/></td>
                                                      <td valign="top"><xsl:value-of select="FALLAS"/></td>
                                                      <td valign="top"><xsl:value-of select="INSPECCION"/></td>
                                                      <td valign="top"><xsl:value-of select="CAMBIO"/></td> 
                                    </xsl:when>
                                    </xsl:choose>
                                    </tr>
                        </xsl:for-each> 
                        </table>
                        </td>
                        <td VALIGN="TOP">
                                     <table>
                                     <tr BGCOLOR="#666666" class="LitleTextTit">
                                          <td></td>
                                          <td align="center" width="80px"><b>MESA</b></td>
                                          <td align="center"><b>ESTACION</b></td>
                                          <td align="center"><b>TIPO</b></td>
                                          <td align="center"><b>FALLA</b></td>
                                          <td align="center"><b>INSPECCION</b></td>
                                          <td align="center"><b>CAMBIO</b></td>
                                     </tr>
                        <xsl:for-each select="*/ROW"> 
                                      <tr BGCOLOR="#ffffff"  class="LitleText">
                                      <xsl:choose>
                                      <xsl:when test="POS = 'DER'">
                                                      <xsl:choose>
                                                            <xsl:when test="COLOR = 'BAJA'">
                                                                <td bgcolor="#3366FF"  class="LitleTextinv" VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                            <xsl:when test="COLOR = 'MEDIA'">
                                                                <td bgcolor="#FFFF00" class="LitleTextinvBlack" VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                            <xsl:when test="COLOR = 'ALTA'">
                                                                <td bgcolor="#FF0000" class="LitleTextinv" VALIGN="TOP"><xsl:value-of select="COLOR"/></td>
                                                            </xsl:when>
                                                             <xsl:otherwise><td>&#160;</td></xsl:otherwise>
                                                      </xsl:choose>
                                                      <td valign="top"><xsl:value-of select="MESA"/></td>
                                                      <td valign="top"><xsl:value-of select="ESTACION"/></td>
                                                      <td valign="top"><xsl:value-of select="TIPO"/></td>
                                                      <td valign="top"><xsl:value-of select="FALLAS"/></td>
                                                      <td valign="top"><xsl:value-of select="INSPECCION"/></td>
                                                      <td valign="top"><xsl:value-of select="CAMBIO"/></td> 
                                    </xsl:when>
                                    </xsl:choose>
                                    </tr>
                        </xsl:for-each> 
                        </table>
                        </td>
                      </tr>
                    </table>
                 </td>
			</tr>
</table>
</td></tr>
</table>
</body>               
</html> 
</xsl:template> 
</xsl:stylesheet> 