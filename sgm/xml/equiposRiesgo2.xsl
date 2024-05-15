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
<table WIDTH="900px"  BORDER="1" cellpadding="0" cellspacing="0" BORDERCOLOR="#000000"
        	 	class="texto" id="tabBitacora">
     <!--DWLayoutTable-->
     
	<tr>
	     <td ROWSPAN="2" COLSPAN="2" align="center">
        <H1> <xsl:for-each select="*/ROW[1]"><xsl:value-of select="FAENA"/></xsl:for-each></H1>
         </td>
      <td HEIGHT="45" COLSPAN="3"  ALIGN="CENTER" VALIGN="TOP" CLASS="titulo">
         	SISTEMA DE GESTION INTEGRADO<br/>
   	      	INFORME DIARIO DE INSPECCIONES</td>
      </tr>
	<tr>
	     <td HEIGHT="25" COLSPAN="3" VALIGN="TOP" CLASS="calibri">
         		FAENA:  
                	<xsl:for-each select="*/ROW[1]"><xsl:value-of select="FAENA"/> </xsl:for-each>
                   &#160;&#160;&#160; FECHA DE EMISION :  <xsl:for-each select="*/ROW[1]">
                	<xsl:value-of select="FECHA_EMI"/> </xsl:for-each>
        </td>
      </tr>
  
 	<tr BGCOLOR="#999999" CLASS="calibri">
	    <td WIDTH="250"><b>EQUIPO</b></td>
   				  <td WIDTH="220"><b>COMPONENTE</b></td>
				  <td WIDTH="130" VALIGN="TOP"><b>ORIGENES DE LAS FALLAS</b></td>
				  <td COLSPAN="2" VALIGN="TOP"><b>OBSERVACION</b></td>
                  </tr>
      <xsl:for-each select="*/ROW"> 
			<tr >
				<td HEIGHT="26" valign="top"  width="120px">
                 <b><xsl:value-of select="EQUIPO_PRI"/></b><br />
                <b><xsl:value-of select="DESC_EQUIPO"/></b>	
       		  </td>
			    <xsl:choose>
                  <xsl:when test="COLOR='BAJA'">
                    <td bgcolor="#00FF33" valign="top" width="150px">
                    			<b><xsl:value-of select="EQUIPO"/></b><br />
                                 <span class="LitleText">
                                  ID:&#160;<xsl:value-of select="ID"/>&#160;<xsl:value-of select="FECHA"/>&#160;<br />
                                  DÍAS ATRASO:&#160;<xsl:value-of select="DIAS"/> <br />
                                 <b>CRITICIDAD:&#160;<xsl:value-of select="COLOR"/></b><br />
                				 </span>
                	</td></xsl:when>
                   <xsl:when test="COLOR='MEDIA'">
                    <td bgcolor="#FFFF00" valign="top" width="150px">
                				<b><xsl:value-of select="EQUIPO"/></b><br />
                                 <span class="LitleText">
                                  ID:&#160;<xsl:value-of select="ID"/>&#160;<xsl:value-of select="FECHA"/>&#160;<br />
                                  DÍAS ATRASO:&#160;<xsl:value-of select="DIAS"/> <br />
                                 <b>CRITICIDAD:&#160;<xsl:value-of select="COLOR"/></b><br />
                				 </span>
                	</td></xsl:when>
                    
                   <xsl:when test="COLOR='ALTA'">
					<td bgcolor="#FF0000" valign="top" width="150px">
                				<b><xsl:value-of select="EQUIPO"/></b><br />
                                 <span class="LitleText">
                                  ID:&#160;<xsl:value-of select="ID"/>&#160;<xsl:value-of select="FECHA"/>&#160;<br />
                                  DÍAS ATRASO:&#160;<xsl:value-of select="DIAS"/> <br />
                                 <b>CRITICIDAD:&#160;<xsl:value-of select="COLOR"/></b><br />
                				 </span>
                	</td></xsl:when>
                    
                    <xsl:otherwise>
            				  <td valign="top" width="150px">
								<b><xsl:value-of select="EQUIPO"/></b><br />
                                 <span class="LitleText">
                                  ID:&#160;<xsl:value-of select="ID"/>&#160;<xsl:value-of select="FECHA"/>&#160;<br />
                          		  DÍAS ATRASO:&#160;<xsl:value-of select="DIAS"/> <br />
                                 <b>CRITICIDAD:&#160;<xsl:value-of select="COLOR"/></b><br />
                				 </span>
                	</td></xsl:otherwise>
              </xsl:choose>
				<td VALIGN="TOP">
                     <table class="LitleText">
                          <xsl:for-each select="FALLAS" >
                               <tr>
                                  <td width="130px"><xsl:value-of select="DESC_FALLA"/></td>
                    		     	<xsl:choose>
                    		          	<xsl:when test="VALOR_FALLA=1">
                    		               <td bgcolor="#00FF33" align="right"><xsl:value-of select="VALOR_FALLA"/></td>
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
                  </table></td>
				<td COLSPAN="2" VALIGN="TOP"><xsl:value-of select="DESCRIPCION"/></td>
	    </tr>
             <tr class="noborder" valign="top">
				<td  COLSPAN="5"  ALIGN="CENTER" >
                	 <xsl:for-each select="FILES" >
                	      <a datafld="FILE" target="_blank">
                	           <img  WIDTH="200PX">
                	           <xsl:attribute name="src"><xsl:value-of select="FILE" /></xsl:attribute>
                	           </img></a>&#160;&#160;&#160;
           	      	</xsl:for-each>                   </td>
	    </tr>
		             <tr>
				<td  COLSPAN="5"  ALIGN="CENTER" valign="top">    	 &#160;     </td>
			    </tr>
      </xsl:for-each> 
	</table>
</body>
</html>
</xsl:template> 
</xsl:stylesheet> 