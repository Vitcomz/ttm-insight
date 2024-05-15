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
#page-break	{ page-break-before: always; }

</style> 
<body topmargin="0">
<table cellpadding="2" cellspacing="1"  BORDER="1" BORDERCOLOR="#000000"  CLASS="calibri">	
             <tr>
             	<td height="45" colspan="10"><img ><xsl:attribute name="src">../images/banner_<xsl:for-each select="*/ROW[1]"><xsl:value-of select="FAENA"/> </xsl:for-each>.jpg</xsl:attribute></img></td>
             </tr>
             <tr>
                 <td HEIGHT="25"  class='calibri_16' colspan="10">INFORME SEMANAL DE INSPECCIONES&#160;&#160;&#160;&#160;&#160;FAENA: <xsl:for-each select="*/ROW[1]">
                            <xsl:value-of select="FAENA"/> </xsl:for-each> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;FECHA DE INSPECCION DESDE: <xsl:for-each select="*/ROW[1]">
                            <xsl:value-of select="FECHA_INI"/> </xsl:for-each>
                            HASTA: 
                            <xsl:for-each select="*/ROW[1]">
                            <xsl:value-of select="FECHA_FIN"/> </xsl:for-each>
                 
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
                  <td><b>FOTOGRAFIAS</b></td>
			 </tr>
             

            <xsl:for-each select="*/ROW"> 
            <xsl:if test="N = 6 or N = 11 or N = 16 or N = 21 or N = 26 or N = 31 or N = 36 or N = 41 or N = 46 or N = 51 or N = 56 or N = 61 or N = 66 or N = 71 or N = 76 or N = 81 or N = 96 or N = 101">
             <tr id="page-break">
             	<td height="45" colspan="10"><img ><xsl:attribute name="src">../images/banner_<xsl:value-of select="FAENA"/>.jpg</xsl:attribute></img></td>
             </tr>
             <tr>
                 <td HEIGHT="25"  class='calibri_16' colspan="10">INFORME SEMANAL DE INSPECCIONES&#160;&#160;&#160;&#160;&#160;FAENA: <xsl:value-of select="FAENA"/> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;FECHA DE INSPECCION DESDE: 
                            <xsl:value-of select="FECHA_INI"/>
                            HASTA: 
                            <xsl:value-of select="FECHA_FIN"/>
                 
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
                  <td><b>FOTOGRAFIAS</b></td>
			 </tr>
            </xsl:if>
			<tr >
				<td valign="top" onClick="return;"><xsl:value-of select="ID"/></td>
				<td valign="top"><xsl:value-of select="FECHA"/></td>
                <td valign="top"><xsl:value-of select="EQUIPO_PRIN"/></td>
				<td valign="top"><xsl:value-of select="EQUIPO"/></td>
				<td valign="top"><xsl:value-of select="DESCRIPCION"/></td>
				<td valign="top"><xsl:value-of select="CAUSA"/>&#160;<br />
                			<xsl:choose>
			       			<xsl:when test="COLOR = 'ALTA'">
                            <span style="color:#FF0033">DIAS PENDIENTES <xsl:value-of select="DIAS"/></span>
                            </xsl:when>
                			</xsl:choose>
                            </td>
				<td  ALIGN="LEFT" valign="top">
                	<table class="LitleText">
  					<xsl:for-each select="FALLAS" >
                    	<tr>
                		<td width="100%"><xsl:value-of select="DESC_FALLA"/></td>
                    		<xsl:choose>
			       			<xsl:when test="VALOR_FALLA=1">
            				<td bgcolor="#3366FF" align="right"><xsl:value-of select="VALOR_FALLA"/></td>
          					</xsl:when>
                   			<xsl:when test="VALOR_FALLA=2">
            				<td bgcolor="#FFFF00" align="right"><xsl:value-of select="VALOR_FALLA"/></td>
          					</xsl:when>
                    		<xsl:when test="VALOR_FALLA=3">
            				<td bgcolor="#FF0000" align="right"><xsl:value-of select="VALOR_FALLA"/></td>
          					</xsl:when>
                			</xsl:choose>
                        </tr>
                	</xsl:for-each> 
                	</table>
                 </td>
                <xsl:choose>
			       	<xsl:when test="COLOR = 'BAJA'">
            			<td bgcolor="#3366FF"><xsl:value-of select="COLOR"/></td>
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
  					<xsl:for-each select="FILES" >
                    	<tr>
                		<a datafld="FILE" target="_blank">
                	           <img  WIDTH="200PX">
                	           <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
                	           </img></a>
                               &#160;&#160;&#160;&#160;&#160;
                        </tr>
                	</xsl:for-each> 
                	</table></TD>
			</tr>
            <xsl:if test="N = 5 or N = 10 or N = 15 or N = 20 or N = 25 or N = 30 or N = 35 or N = 40 or N = 45 or N = 50 or N = 55 or N = 60 or N = 65 or N = 70 or N = 75 or N = 80 or N = 95 or N = 100">
            
            </xsl:if>
          </xsl:for-each> 
</table>
<!--<center>
<img SRC="../Images/pie2.jpg"/>
</center>-->
</body>
                 
</html> 
</xsl:template> 
</xsl:stylesheet> 