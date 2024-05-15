<?xml version="1.0" encoding="ISO-8859-1"?><!-- DWXMLSource="../prueba.xml" --> 
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
	font-size:10px;
	font-weight:bold;
	color:Black;
}

.calibri16 {
	
	font-family: Arial, Helvetica, sans-serif;
	font-size:15px;
	font-weight:bold;
	color:Black;
}

.titulo{
font-family:Geneva, Arial, Helvetica, sans-serif;
font-size:12px;
font-weight: bold;
color:#797c7d;
	
}

.texto{
font-family:Arial, Helvetica, sans-serif;
color:#000000;
font-size:10px;
}


.body {
	top:100px;
	margin-left: 0px;
	margin-top: 100px;
	margin-right: 0px;
	margin-bottom: 20px;
	font-family:Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight:normal;
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
  bottom:30px;
  left:0;
  width:100%;
  height:0px;
 }
 
@media print{
  div#header{
   position:fixed;
   height:80%;
  }
 
  div#content{
  top:100px;
  margin-bottom:20px;
   height:80%;
  }
  
  div#footer{
   position:fixed;
     bottom:70px;
  left:0;
  width:990px;
  height:0px;
  }
  
  body{
  overflow:hidden;
  background-color:#FFFFFF;
 }
 
}

 @media screen{
  
   div#footer{
   position:fixed;
   visibility:hidden;
  }
  
}

 * html body{
  overflow:hidden;
 } 
 * html div#content{
  height:100%;
 }
 
 
</style>
 
<body bgcolor="#666666" topmargin="111" bottommargin="35" >
<div id="header" align="center">
 <table width="800"  BORDER="0" cellpadding="2" cellspacing="0" >
    <tr>
	    <td colspan="5" VALIGN="TOP" CLASS="calibri">
	       <img src="..\Images\encabezado.jpg" width="997" height="111" /></td>
	</tr>
 </table>
</div>
<div id="content" >
	<table width="997"  BORDER="0"  align="center" cellpadding="0" cellspacing="3" bgcolor="#FFFFFF">
	<tr>
	  <td HEIGHT="23" colspan="3" align="center" valign="top">
      <xsl:for-each select="*/ROW[1]">
      <span class="calibri16">INFORME DE INSPECCION    </span><br />
      <span class="titulo">FECHA <xsl:value-of select="FECHA_IMP"/></span><br />
      <span class="titulo">AREA <xsl:value-of select="SECCION_DES"/></span><BR />
      </xsl:for-each>
      </td>
	</tr>

           <xsl:for-each select="*/ROW"> 
			<tr >
            
			  <td height="42" colspan="3"  valign="bottom" >
              	<span class="titulo">EQUIPO <xsl:value-of select="EQUIPO_PRIN"/></span>
                <span class="titulo"><xsl:value-of select="DESC_EQUIPO_PRIN"/></span><BR />
                <span class="titulo">COMPONENTE <xsl:value-of select="EQUIPO"/>&#160;
                		<xsl:value-of select="DESC_EQUIPO"/></span></td>
			  </tr>
            <xsl:for-each select="DESCRIP" >
			  <tr>
				<td valign="top" CLASS="calibri">
                <strong>
                ID :&#160;<xsl:value-of select="ID" /><BR /></strong>
                FECHA :&#160;<xsl:value-of select="FECHA" /><BR />
                CRITICIDAD EQUIPO:&#160;<xsl:value-of select="CRITICIDAD_EQUIPO" /><BR />
                CRITI. COMPONENTE:&#160;
                 <xsl:choose>
                  <xsl:when test="COLOR='BAJA'">
                    <SPAN style="background-color:#3366FF">BAJA</SPAN>
                   </xsl:when>
                   <xsl:when test="COLOR='MEDIA'">
                    <SPAN style="background-color:#FFFF00">MEDIA</SPAN>
                    </xsl:when>
                    
                   <xsl:when test="COLOR='ALTA'">
                   <SPAN style="background-color:#FF0000">ALTA</SPAN>
                   </xsl:when>
                    
                    <xsl:otherwise>
            		</xsl:otherwise>
                  </xsl:choose><BR />
                  
                AVISO/OT:&#160;<xsl:value-of select="REPORT" /></td>
			  <td width="523" valign="top" CLASS="calibri">
       	      <xsl:value-of select="DESCRIPCION" /><BR />
            <BR />
                 <center>
                  	<xsl:for-each select="FILES">
                    		<xsl:choose>
                              <xsl:when test="EXT = 'pdf'">
                                      <a href="" title="Ver documento adjunto" target="_blank"><xsl:attribute name="href"><xsl:value-of select="FILE" /></xsl:attribute><img src="../images/btn_new.png" width="40" height="40" /></a>
                              </xsl:when>
                              <xsl:otherwise>
                                <img  WIDTH="200PX"  style="border: 1px solid #CCCCCC;">
                	           		<xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
                	       		</img>&#160;&#160;&#160;
                              </xsl:otherwise>
                            </xsl:choose>
           	      	</xsl:for-each>
                  </center>                </td>
		      </tr>
             </xsl:for-each> 
			<tr CLASS="calibri">
			  <td colspan="2" valign="top">RECOMENDACIÓN:<xsl:value-of select="RECOMENDACION"/></td>
			  </tr>
			<tr CLASS="calibri">
			  <td  colspan="3" valign="top">CAUSA RAIZ:<xsl:value-of select="CAUSA"/><BR /></td>
			  </tr>
			<tr CLASS="calibri">
			  <td  colspan="3" valign="top">&nbsp;</td>
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
    </xsl:for-each>  
</table>
</div> 
</body>  
<div id="footer" align="center">
<img src="..\images\pie2.jpg"  align="bottom"  width="990" height="69"/>	 
</div>            
</html> 
</xsl:template>
</xsl:stylesheet> 