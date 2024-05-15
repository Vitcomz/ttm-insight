<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.buffer=false%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <style>
      body {
	font: 10pt arial;
	margin-left: 0px;
	margin-top: 0px;
}
    </style>
             
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />



	<script src="Scripts/jquery-1.8.3.js"></script>
	<script src="Scripts/jquery-ui.js"></script>
    <script src="Scripts/jQRangeSliderMouseTouch.js"></script>
    <script src="Scripts/jQRangeSliderDraggable.js"></script>
    <script src="Scripts/jQRangeSliderHandle.js"></script>
    <script src="Scripts/jQRangeSliderBar.js"></script>
    <script src="Scripts/jQRangeSliderLabel.js"></script>
    <script src="Scripts/jQRangeSlider.js"></script>
    <script src="Scripts/jQDateRangeSliderHandle.js"></script>
    <script src="Scripts/jQDateRangeSlider.js"></script>
    <script src="Scripts/jQEditRangeSliderLabel.js"></script>
    <script src="Scripts/jQEditRangeSlider.js"></script>
    <script src="Scripts/jQRuler.js"></script>
    <link rel="stylesheet" href="Scripts/style_slider.css" type="text/css">
    <link rel="stylesheet" href="Scripts/demo_slider.css" type="text/css">
    <link rel="stylesheet" href="Scripts/iThing.css" type="text/css">
    <link rel="stylesheet" href="Scripts/bootstrap.min.css" type="text/css">            
    <script src="Scripts/d3.min.js"></script>
        <!--<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />-->
		<!--[if IE]><script type="text/javascript" src="Scripts/excanvas.min.js"></script><![endif]-->
		<script type="text/javascript" src='Scripts/SurfacePlot.js'></script>
		<script type="text/javascript" src='Scripts/ColourGradient.js'></script>
		
		<script type="text/javascript" src="Scripts/glMatrix-0.9.5.min.js"></script>
        <script type="text/javascript" src="Scripts/webgl-utils.js"></script>    
						<%
			
			id = request.querystring("ID")
			eq = request.querystring("EQ")
			fech = request.querystring("FCH")
			if fech <> "" then
				fech = replace(fech, "-","/")
				arrfech = split(fech, "$")
				fech = replace(fech, "$"," ")
			end if
			emp = request.querystring("EMP")
			seg = request.querystring("SEG")
			if seg <> "" then
				arrseg = split(seg, "-")
				if ubound(arrseg) > 0 then
					numb1 = arrseg(0)
					numb2 = arrseg(1)
					seg = numb1 & " " & numb2
				end if
			else
				numb1 = 0
				numb2 = 30
			end if
			
		
		%>
    
		<script id="shader-fs" type="x-shader/x-fragment">
            #ifdef GL_ES
            precision highp float;
            #endif
            
            varying vec4 vColor;
            varying vec3 vLightWeighting;
            
            void main(void)
            {
            	gl_FragColor = vec4(vColor.rgb * vLightWeighting, vColor.a);
            }
        </script>
        
        <script id="shader-vs" type="x-shader/x-vertex">
            attribute vec3 aVertexPosition;
            attribute vec3 aVertexNormal;
            attribute vec4 aVertexColor;
            
            uniform mat4 uMVMatrix;
            uniform mat4 uPMatrix;
            uniform mat3 uNMatrix;
            varying vec4 vColor;
            
            uniform vec3 uAmbientColor;
            uniform vec3 uLightingDirection;
            uniform vec3 uDirectionalColor;
            varying vec3 vLightWeighting;
            
            void main(void)
            {
                gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
                
                vec3 transformedNormal = uNMatrix * aVertexNormal;
                float directionalLightWeighting = max(dot(transformedNormal, uLightingDirection), 0.0);
                vLightWeighting = uAmbientColor + uDirectionalColor * directionalLightWeighting; 

                vColor = aVertexColor;
            }
        </script>
        
        <script id="axes-shader-fs" type="x-shader/x-fragment">
            precision mediump float;
			varying vec4 vColor;
			
			void main(void)
			{
				gl_FragColor = vColor;
			}
        </script>
        
        <script id="axes-shader-vs" type="x-shader/x-vertex">
            attribute vec3 aVertexPosition;
			attribute vec4 aVertexColor;
			uniform mat4 uMVMatrix;
			uniform mat4 uPMatrix;
			varying vec4 vColor;
			uniform vec3 uAxesColour;
			
			void main(void)
			{
				gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
				vColor =  vec4(uAxesColour, 1.0);
			} 
        </script>
        
		<script id="texture-shader-fs" type="x-shader/x-fragment">
            #ifdef GL_ES
            precision highp float;
            #endif
            
            varying vec2 vTextureCoord;
            
            uniform sampler2D uSampler;
            
            void main(void)
            {
                gl_FragColor = texture2D(uSampler, vTextureCoord);
            }
        </script>
        <script id="texture-shader-vs" type="x-shader/x-vertex">
            attribute vec3 aVertexPosition;
            
            attribute vec2 aTextureCoord;
            varying vec2 vTextureCoord;
            
            uniform mat4 uMVMatrix;
            uniform mat4 uPMatrix;
            
            void main(void)
            {
                gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
                vTextureCoord = aTextureCoord; 
            }
        </script>
		
	  
</head>
<body>
<!--<FORM NAME="formulario" id="formulario">-->
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td colspan="3" style="height:490px"><div id='surfacePlotDiv' style="width: 373px; height: 500px; left:80px; top:10px; background: #fff; position:absolute; z-index:9999999"></div><div id='surfacePlotDiv2' style="width: 490px; height: 500px; left:386px; top:10px; background: #fff; position:absolute;"></div></td>
  </tr>
  <tr>
    <td width="2">&nbsp;</td>
    <TD height="29"  CLASS="titulo"><div id="chartcontainer" style="width: 800px; position:relative"></div></TD>
    <td width="1">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <TD align="center"><table width="85%" border="0" cellspacing="1" cellpadding="1">
      <tr>
        <td bgcolor="#CCCCCC"><table width="100%" border="0" cellspacing="2" cellpadding="5">
          <tr>
            <td bgcolor="#FFFFFF">SCANNER&nbsp;N&ordm;&nbsp;&nbsp;</td>
            <td bgcolor="#FFFFFF"><% response.write id %>
              <input name="txt_tiempo" type="hidden" id="txt_tiempo" value="<%response.write seg%>"></td>
            <td bgcolor="#FFFFFF">FECHA</td>
            <td bgcolor="#FFFFFF"><% response.write fech %></td>
            <td bgcolor="#FFFFFF">Canal</td>
            <td bgcolor="#FFFFFF"><select name="select" id="cbl_filter">
              <option value="-1">-- General --</option>
            </select></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF">EQUIPO</td>
            <td bgcolor="#FFFFFF"><% response.write eq %></td>
            <td bgcolor="#FFFFFF">FAENA</td>
            <td bgcolor="#FFFFFF"><% response.write emp %></td>
            <td bgcolor="#FFFFFF">&nbsp;</td>
            <td bgcolor="#FFFFFF">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></TD>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
    				
                    <div class="sliderContainer">
                    	<div id="slider"></div>
                    </div>
			      <div class="sliderContainer">
                     <div id="editSlider"></div><div class="sliderButton"><img src="images/zoom_mode_image.png" width="40" height="40" id="btn_scan" style="cursor:pointer"></div>
   	  </div>
                    
        </td>
    <td>&nbsp;</td>
  </tr>
</table>
		<script type='text/javascript'>
			function roundNumber(number, decimals) { // Arguments: number to round, number of decimal places
				var newnumber = new Number(number+'').toFixed(parseInt(decimals));
				return parseFloat(newnumber); // Output the result to the form field (change for your purposes)
			}

			Array.range= function(from, to, step){
				if(typeof from== 'number'){
					var A= [from];
					step= typeof step== 'number'? Math.abs(step):1;
					if(from> to){
						while((from -= step)>= to) A.push(roundNumber(from,1));
					}
					else{
						while((from += step)<= to) A.push(roundNumber(from,1));
					}
					return A;
				}   
			}
			
//			Array.range= function(a, b, step){
//				var A= [];
//				if(typeof a== 'number'){
//					A[0]= a;
//					step= step || 1;
//					while(a+step<= b){
//						A[A.length]= a+= step;
//					}
//				}
//				else{
//					var s= 'abcdefghijklmnopqrstuvwxyz';
//					if(a=== a.toUpperCase()){
//						b=b.toUpperCase();
//						s= s.toUpperCase();
//					}
//					s= s.substring(s.indexOf(a), s.indexOf(b)+ 1);
//					A= s.split('');        
//				}
//				return A;
//			}			
					
		    var surfacePlot;
		    var surfacePlot2;
			var data, data2, options, basicPlotOptions, basicPlotOptions2, glOptions, glOptions2, animated, plot1, plot2, values, values2;
			
			function setUp()
			{
				var numRows = 1792;
				var numCols = 8;
				
				var tooltipStrings = new Array();
				var tooltipStrings2 = new Array();
				values = new Array();
				values2 = new Array();
				
				//var d = 360 / numRows;
				var idx = 0;
				
				
		<!--#include file="standard/DBConnScanner.asp" -->	
		<%

		Dim query, ID
		Dim oDB
		Set oDB = New DBConn
		Session.LCID = 2057
		
		prom = (CDbl(numb1) + CDbl(numb2)) / 2
		query = "SELECT ID_SCANNER,FECHA,SEGUNDOS,ENCODER,CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,FALLAS,EQUIPO,FAENA, (SELECT MAX(SEGUNDOS) FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & arrfech(0) & "%' and Convert(varchar(8), FECHA, 108) like '%" & arrfech(1) & "%' "
		if emp <> "" and emp <> "undefined" then
			query = query & " and FAENA= '" & emp & "' "
		end if
		query = query & ") AS MAXDAT FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & arrfech(0) & "%' and Convert(varchar(8), FECHA, 108) like '%" & arrfech(1) & "%' "
		if eq <> "" and eq <> "undefined" then
			query =  query & " and EQUIPO = '" & eq & "' "
		end if
		if emp <> "" and emp <> "undefined" then
			query = query & " and FAENA= '" & emp & "' "
		end if
		if seg <> "" and seg <> "undefined" then
			query = query & " and segundos between " &numb1& " and " &prom&  " "
		else
			query = query & " and segundos between 0 and 15 "
		end if
		query = query & " order by SEGUNDOS "
		'response.write query
		'response.end
		Set ORs =oDB.EjecutaSql(query)
		linea = 0
		While Not ORs.EOF 
			'MAXDAT = ORs.Fields.Item(15).Value
			%>
			values[<%=linea%>] = new Array();
			values[<%=linea%>][0] = <% Response.Write ORs.Fields.Item(4).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 1 + " = " + <% Response.Write ORs.Fields.Item(4).Value%> ;
			values[<%=linea%>][1] = <% Response.Write ORs.Fields.Item(5).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 2 + " = " + <% Response.Write ORs.Fields.Item(5).Value%> ;
			values[<%=linea%>][2] = <% Response.Write ORs.Fields.Item(6).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 3 + " = " + <% Response.Write ORs.Fields.Item(6).Value%> ;
			values[<%=linea%>][3] = <% Response.Write ORs.Fields.Item(7).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 4 + " = " + <% Response.Write ORs.Fields.Item(7).Value%> ;
			values[<%=linea%>][4] = <% Response.Write ORs.Fields.Item(8).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 5 + " = " + <% Response.Write ORs.Fields.Item(8).Value%> ;
			values[<%=linea%>][5] = <% Response.Write ORs.Fields.Item(9).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 6 + " = " + <% Response.Write ORs.Fields.Item(9).Value%> ;
			values[<%=linea%>][6] = <% Response.Write ORs.Fields.Item(10).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 7 + " = " + <% Response.Write ORs.Fields.Item(10).Value%> ;
			values[<%=linea%>][7] = <% Response.Write ORs.Fields.Item(11).Value%>  
			tooltipStrings[idx] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 8 + " = " + <% Response.Write ORs.Fields.Item(11).Value%> ;
			
			idx++;
						// y = canales
						// x = segundos
			<%
			linea = linea + 1		
			ORs.MoveNext
		Wend
		%>
						data = {nRows: <%=linea%>, nCols: numCols, formattedValues: values};
						var idx2 = 0;
		<%
		query = "SELECT ID_SCANNER,FECHA,SEGUNDOS,ENCODER,CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,FALLAS,EQUIPO,FAENA, (SELECT MAX(SEGUNDOS) FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & arrfech(0) & "%' and Convert(varchar(8), FECHA, 108) like '%" & arrfech(1) & "%' "
		if emp <> "" and emp <> "undefined" then
			query = query & " and FAENA= '" & emp & "' "
		end if
		query = query & ") AS MAXDAT, CASE WHEN DATA_SCANNER.CH1 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH2 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH3 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH4 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH5 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH6 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH7 IS NULL THEN 0 ELSE 1 END + CASE WHEN DATA_SCANNER.CH8 IS NULL THEN 0 ELSE 1 END AS CANALES FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & arrfech(0) & "%' and Convert(varchar(8), FECHA, 108) like '%" & arrfech(1) & "%' "
		if eq <> "" and eq <> "undefined" then
			query =  query & " and EQUIPO = '" & eq & "' "
		end if
		if emp <> "" and emp <> "undefined" then
			query = query & " and FAENA= '" & emp & "' "
		end if
		if seg <> "" and seg <> "undefined" then
			query = query & " and segundos between " &prom& " and " &numb2&  " "
		else
			query = query & " and segundos between 15 and 30 "
		end if
		query = query & " order by SEGUNDOS "
		'response.write query
		'response.end
		Set ORs =oDB.EjecutaSql(query)
		linea = 0
		While Not ORs.EOF 
			MAXDAT = ORs.Fields.Item(15).Value
			CANALES = ORs.Fields.Item(16).Value
			%>
			values2[<%=linea%>] = new Array();
			values2[<%=linea%>][0] = <% Response.Write ORs.Fields.Item(4).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 1 + " = " + <% Response.Write ORs.Fields.Item(4).Value%> ;
			values2[<%=linea%>][1] = <% Response.Write ORs.Fields.Item(5).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 2 + " = " + <% Response.Write ORs.Fields.Item(5).Value%> ;
			values2[<%=linea%>][2] = <% Response.Write ORs.Fields.Item(6).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 3 + " = " + <% Response.Write ORs.Fields.Item(6).Value%> ;
			values2[<%=linea%>][3] = <% Response.Write ORs.Fields.Item(7).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 4 + " = " + <% Response.Write ORs.Fields.Item(7).Value%> ;
			values2[<%=linea%>][4] = <% Response.Write ORs.Fields.Item(8).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 5 + " = " + <% Response.Write ORs.Fields.Item(8).Value%> ;
			values2[<%=linea%>][5] = <% Response.Write ORs.Fields.Item(9).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 6 + " = " + <% Response.Write ORs.Fields.Item(9).Value%> ;
			values2[<%=linea%>][6] = <% Response.Write ORs.Fields.Item(10).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 7 + " = " + <% Response.Write ORs.Fields.Item(10).Value%> ;
			values2[<%=linea%>][7] = <% Response.Write ORs.Fields.Item(11).Value%>  
			tooltipStrings2[idx2] = "x:" + <%=ORs.Fields.Item(2).Value%> + ", y:" + 8 + " = " + <% Response.Write ORs.Fields.Item(11).Value%> ;
			
			idx2++;
						// y = canales
						// x = segundos
			<%
			linea = linea + 1		
			ORs.MoveNext
		Wend
		
		Set ORs = Nothing
		'Set ODB = Nothing	
		
		%>	

				data2 = {nRows: <%=linea%>, nCols: numCols, formattedValues: values2};
				
//				var d = 360 / numRows;
//				for (var i = 0; i < numRows; i++) 
//				{
//					//values[i] = new Array();
//					values2[i] = new Array();
//					
//					for (var j = 0; j < numCols; j++)
//					{
//						//var value = (Math.sin(i * d * Math.PI / 180.0) * Math.cos(j * d * Math.PI / 180.0));
//						var value2 = (Math.cos(i * d * Math.PI / 180.0) * Math.cos(j * d * Math.PI / 180.0));
//						
//						//values[i][j] = value;
//						values2[i][j] = value2;
//						//alert(values[i][j] + ' - '  + values2[i][j]);
//						// y = canales
//						// x = segundos
//						
//						
//						//tooltipStrings[idx] = "x:" + i + ", y:" + j + " = " + value;
//						tooltipStrings2[idx2] = "x:" + i + ", y:" + j + " = " + value2;
//						idx2++;
//					}
//				}

				surfacePlot = new SurfacePlot(document.getElementById("surfacePlotDiv"));
				surfacePlot2 = new SurfacePlot(document.getElementById("surfacePlotDiv2"));
				
				// Don't fill polygons in IE < v9. It's too slow.
				var fillPly = false;
				
				// Define a colour gradient.
//				var colour1 = {red:0, green:0, blue:255};
//				var colour2 = {red:0, green:198, blue:151};
//				var colour3 = {red:0, green:255, blue:0};
//				var colour4 = {red:128, green:255, blue:0};
//				var colour5 = {red:255, green:255, blue:0};
//				var colour6 = {red:255, green:200, blue:0};
//				var colour7 = {red:255, green:128, blue:0};
//				var colour8 = {red:255, green:64, blue:0};
//				var colour9 = {red:255, green:0, blue:0};
//				var colours = [colour1, colour2, colour3, colour4, colour5, colour6, colour7, colour8, colour9];

				var colour1 = {red:0, green:0, blue:255};
				var colour2 = {red:0, green:255, blue:255};
				var colour3 = {red:0, green:255, blue:0};
				var colour4 = {red:255, green:255, blue:0};
				var colour5 = {red:255, green:0, blue:0};
				var colours = [colour1, colour2, colour3, colour4, colour5];
								
				// Axis labels.
				<%
					intval = ((numb2 - numb1) / 10)
					x = CANALES
					for i = 1 to x 
						varx = varx & i & ", "
					next
					allvarx = left(varx, len(varx) - 2)
				%>
				var xAxisHeader	= "Tiempo [s]";
				var yAxisHeader	= "Ch 1 - <%=x%>";
				var zAxisHeader	= "";//"Amplitude [a.u.]";
				
				var renderDataPoints = true;
				var background = '#FFFFFF';
				var axisForeColour = '#000000';
				var hideFloorPolygons = false;
				var chartOrigin = {x: 0, y: 0};
				
				// Options for the basic canvas pliot.
				basicPlotOptions = {fillPolygons: fillPly, tooltips: tooltipStrings, renderPoints: renderDataPoints }
				basicPlotOptions2 = {fillPolygons: fillPly, tooltips: tooltipStrings2, renderPoints: renderDataPoints }
				
				// Options for the webGL plot.
				
				//valor dividirlo por 10 para rango Y
				var xLabels = Array.range(<%=numb1%>,<%=prom%>,<%=intval%>);
				var xLabels2 = Array.range(<%=prom%>,<%=numb2%>,<%=intval%>);
				
				var yLabels = [<%=allvarx%>];
				var zLabels = "";//[0, 1]; // These labels ar eused when autoCalcZScale is false;
				
				glOptions = {xLabels: xLabels, yLabels: "", zLabels: zLabels, chkControlId: "allowWebGL", autoCalcZScale: false, animate: false};
				// Options common to both types of plot.
				options1 = {xPos: 0, yPos: 0, width: 373, height: 495, colourGradient: colours, 
					xTitle: "", yTitle: "", zTitle: "", 
					backColour: background, axisTextColour: axisForeColour, hideFlatMinPolygons: hideFloorPolygons, origin: chartOrigin};

				glOptions2 = {xLabels: xLabels2, yLabels: yLabels, zLabels: zLabels, chkControlId: "allowWebGL", autoCalcZScale: false, animate: false};
				
				options2 = {xPos: 0, yPos: 0, width: 490, height: 495, colourGradient: colours, 
					xTitle: xAxisHeader, yTitle: yAxisHeader, zTitle: zAxisHeader, 
					backColour: background, axisTextColour: axisForeColour, hideFlatMinPolygons: hideFloorPolygons, origin: chartOrigin};
				surfacePlot.draw(data, options1, basicPlotOptions, glOptions);
				surfacePlot2.draw(data2, options2, basicPlotOptions2, glOptions2);
				
				coordinateCharts();
				
			}
			
			function coordinateCharts() {
				
				// Link the two charts for rotation.
                plot1 = surfacePlot.getChart();
                plot2 = surfacePlot2.getChart();
                
                plot1.otherPlots = [plot2];  
                plot2.otherPlots = [plot1];  
				
			}
			
			function animateCharts() {
				
				if (!animated) {
					surfacePlot.draw(data2, options, basicPlotOptions2, glOptions2);
					surfacePlot2.draw(data, options, basicPlotOptions, glOptions);
					animated = true;
				}
				else {
					surfacePlot.draw(data, options, basicPlotOptions, glOptions);
					surfacePlot2.draw(data2, options, basicPlotOptions2, glOptions2);
					animated = false;
				}
				
				coordinateCharts();
				
			}
			
			setUp();
			
			function toggleChart(chkbox)
            { 
                surfacePlot.draw(data, options, basicPlotOptions, glOptions);
                surfacePlot2.draw(data2, options, basicPlotOptions2, glOptions2);
				
				coordinateCharts();
            } 
			function getURLParameter(name) {
			  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)|| [,""])[1].replace(/\+/g, '%20'))|| ''
			}
			function reading(e) {
			  tecla = document.all ? e.keyCode : e.which;
			  if(tecla==13){ 
			  	if (document.getElementById("txt_tiempo").value != ''){
			  	  var arrnumb = document.getElementById("txt_tiempo").value;
				  arrnumb = arrnumb.split(' ');
				  var paths = window.location.pathname.split("?");
				  var var_id = getURLParameter('ID');
				  var var_eq = getURLParameter('EQ');
				  var var_fch = getURLParameter('FCH');
				  var var_emp = getURLParameter('EMP');
				  var var_vtz = getURLParameter('VTZ');
				  
				  var newUrl = window.location.protocol + "//" + window.location.host +  paths[0] + '?ID=' + var_id + '&EQ=' + var_eq + '&FCH=' + var_fch + '&EMP=' + var_emp + '&VTZ=' + var_vtz + '&SEG=' + arrnumb[0] + '-' + arrnumb[1];
				  //ID=Prototipo&EQ=&FCH=24-10-2013&EMP=ESCONDIDA&VTZ=0.12850032762305785
				  window.location = newUrl;
			  		//alert(newUrl);
				}
			  }
			} 		
			Number.prototype.round = function(places){
				places = Math.pow(10, places); 
				return Math.round(this * places)/places;
			}			
		</script>
<script>
		(function($){
			$(document).ready(function(){
				$("#slider").editRangeSlider({
					formatter:function(val){ var value = Math.round(val * 5) / 5, decimal = value - Math.round(val); return decimal == 0 ? value.toString() + ".0" : value.toString();},
					bounds:{min: 0, max: <%=MAXDAT%>},
					range: {min: 3, max: 30},
					defaultValues: {min: <%=numb1%>, max: <%=numb2%>}
					}).bind("valuesChanged", function(e, data){
						document.getElementById("txt_tiempo").value = data.values.min.round(1) + " " + data.values.max.round(1);
						//alert("Values just changed. min: " + data.values.min + " max: " + data.values.max);
				});
				//alert('init done');
				for (var j=1;j<=<%=x%>;j++)
				{
					//$("#cbl_filter").append("<option value=" + j + ">-- Canal " + j + " --</option>");
					$('#cbl_filter').append($("<option></option>")
                        .attr("value",j)
                        .text("-- Canal " + j + " --"));
				}
				
			});
			$("#btn_scan").click(function () {
				if (document.getElementById("txt_tiempo").value != ''){
			  	  var arrnumb = document.getElementById("txt_tiempo").value;
				  arrnumb = arrnumb.split(' ');
				  var paths = window.location.pathname.split("?");
				  var var_id = getURLParameter('ID');
				  var var_eq = getURLParameter('EQ');
				  var var_fch = getURLParameter('FCH');
				  var var_emp = getURLParameter('EMP');
				  var var_vtz = getURLParameter('VTZ');
				  
				  var newUrl = window.location.protocol + "//" + window.location.host +  paths[0] + '?ID=' + var_id + '&EQ=' + var_eq + '&FCH=' + var_fch + '&EMP=' + var_emp + '&VTZ=' + var_vtz + '&SEG=' + arrnumb[0] + '-' + arrnumb[1];
				  //ID=Prototipo&EQ=&FCH=24-10-2013&EMP=ESCONDIDA&VTZ=0.12850032762305785
				  window.location = newUrl;
			  		//alert(newUrl);
				}
			})
			$("#cbl_filter").change(function () {
				  //alert($('select[id=cbl_filter]').val());
			 	  var var_id = getURLParameter('ID');
				  var var_eq = getURLParameter('EQ');
				  var var_fch = getURLParameter('FCH');
				  var var_emp = getURLParameter('EMP');
				  var var_seg = getURLParameter('SEG');
				  var var_canal = $('select[id=cbl_filter]').val();
				  datback(var_id,var_eq,var_fch,var_emp,var_seg,var_canal)
			})			
		})(jQuery);
	</script>
	<script src="Scripts/jscharts.js"></script>     
    <script type="text/javascript">
	//id1 = numb1, id2 = numb2, id3 = arrfech(0), id4 = arrfech(1), canal = canal
	
	function colectdat(dat){
			//alert(dat);
			var myData = eval(dat);//new Array(eval(dat));
			var myChart = new JSChart('chartcontainer', 'line');
			myChart.setDataArray(myData);
			myChart.setAxisColor('#656565');
			myChart.setAxisNameColor('#4A4A4A');
			myChart.setAxisNameFontSize(9);
			myChart.setAxisNameX(' ');
			myChart.setAxisNameY('Amplitud');
			myChart.setAxisPaddingBottom(5);
			myChart.setAxisPaddingLeft(75);
			myChart.setAxisPaddingRight(10);
			myChart.setAxisPaddingTop(5);
			myChart.setAxisValuesColor('#656565');
			myChart.setAxisValuesNumberX(10);
			myChart.setAxisValuesNumberY(7);
			myChart.setBackgroundColor('#FFF');
			myChart.setGrid(true);
	//		myChart.setLabelY([0.01, 'Bajo']);
	//		myChart.setLabelY([3, 'Medio']);
	//		myChart.setLabelY([6, 'Alto']);
			myChart.setLineColor('#8638D5');
			myChart.setShowYValues(true);
			myChart.setShowXValues(false);
			myChart.setTitle(' ');
			myChart.setTitleColor('#505050');
			myChart.setSize(810, 120);
			myChart.setTextPaddingBottom(5);
			myChart.setTextPaddingLeft(20);
			myChart.setTextPaddingTop(5);
			myChart.setFlagRadius(6);
			//myChart.setTooltip([12, 'Empalme 201']); //marca de empalme
			//myChart.setTooltip([40, 'Tooltip for value 40 on X axis']);
			myChart.draw();
	}
		
	function datback(v1,v2,v3,v4,v5,v6) {
		 $.ajax({
		   method: 'POST',
		   url: 'xml/scanner.asp',
		   data: {id: v1, eq: v2, emp: v4, RECURSO: 'GetAmplitud', id1: <%=numb1%>, id2: <%=numb2%>, id3: '<%=arrfech(0)%>', id4: '<%=arrfech(1)%>', canal: v6 },
		   dataType: 'html',
		   success: function (data) {
			 colectdat(data);
		   },
		   error: function(xhr, textStatus, error){
			  console.log(xhr.statusText);
			  console.log(textStatus);
			  console.log(error);
		   }
  		 });	
<%
		'arrdanos = left(arrdat2, len(arrdat2)-1)
		'response.write arrdanos
%>	
	}
	
	function callback() {
		alert('User click');
	}
			
	var var_id = getURLParameter('ID');
	var var_eq = getURLParameter('EQ');
	var var_fch = getURLParameter('FCH');
	var var_emp = getURLParameter('EMP');
	var var_seg = getURLParameter('SEG');
	var var_canal = $('select[id=cbl_filter]').val();
	datback(var_id,var_eq,var_fch,var_emp,var_seg,var_canal);
	//$('div[style*=top: -120px]').remove(this);
	</script>
<!--</FORM>   -->
</body>
</html>
