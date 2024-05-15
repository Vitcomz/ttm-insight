<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>



</head>
    <style>
      body {
	font: 10pt arial;
	margin-left: 0px;
	margin-top: 0px;
}
    </style>
             
    <script type="text/javascript" src="-http://www.google.com/jsapi"></script>
    <script type="text/javascript" src="Scripts/graph3d.js"></script>
    
    <script type="text/javascript">
      var data = null;
      var graph = null;
    
      google.load("visualization", "1");
      
      // Set callback to run when API is loaded
      google.setOnLoadCallback(drawVisualization); 

      function custom(x, y) {
        return (Math.sin(x/50) * Math.cos(y/50) * 50 + 50);
      }

      // Called when the Visualization API is loaded.
      function drawVisualization() {
        // Create and populate a data table.
        data = new google.visualization.DataTable();
        data.addColumn('number', 'Tiempo [s]');
        data.addColumn('number', 'Ch 1 - 8');
        data.addColumn('number', '');

        // create some nice looking data with sin/cos
        var steps = 30;  // number of datapoints will be steps*steps
        var axisMax = 314;
        axisStep = axisMax / steps;
		
		<%
			Response.buffer=true
			id = request.querystring("ID")
			eq = request.querystring("EQ")
			fech = request.querystring("FCH")
			if fech <> "" then
				fech = replace(fech, "-","/")
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
			end if

		
		%>
		<!--#include file="standard/DBConnScanner.asp" -->	
		<%

		Dim query, ID
		Dim oDB
		Set oDB = New DBConn
		Session.LCID = 2057

		query = "SELECT ID_SCANNER,FECHA,SEGUNDOS,ENCODER,CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,FALLAS,EQUIPO,FAENA FROM DATA_SCANNER WHERE ID_SCANNER= '" & id & "' and Convert(varchar(10), FECHA, 103) like '%" & fech & "%'"
		if eq <> "" and eq <> "undefined" then
			query =  query & " and EQUIPO = '" & eq & "' "
		end if
		if emp <> "" and emp <> "undefined" then
			query = query & " and FAENA= '" & emp & "' "
		end if
		if seg <> "" and seg <> "undefined" then
			query = query & " and segundos between " &numb1& " and " &numb2&  " "
		else
			query = query & " and segundos between 0 and 100 "
		end if
		'response.write query
		'response.end
		Set ORs =oDB.EjecutaSql(query)
		While Not ORs.EOF 
			  'Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",0,0]);  "
			  if CDbl(ORs.Fields.Item(4).Value) < CDbl(ORs.Fields.Item(5).Value) then
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",2," & ORs.Fields.Item(5).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"				
			  elseif CDbl(ORs.Fields.Item(5).Value) < CDbl(ORs.Fields.Item(6).Value) then
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",3," & ORs.Fields.Item(6).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"			
			  elseif CDbl(ORs.Fields.Item(6).Value) < CDbl(ORs.Fields.Item(7).Value) then
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",4," & ORs.Fields.Item(7).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"				
			  elseif CDbl(ORs.Fields.Item(7).Value) < CDbl(ORs.Fields.Item(8).Value) then
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",5," & ORs.Fields.Item(8).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"				
			  elseif CDbl(ORs.Fields.Item(8).Value) < CDbl(ORs.Fields.Item(9).Value) then
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",6," & ORs.Fields.Item(9).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"			
			  elseif CDbl(ORs.Fields.Item(9).Value) < CDbl(ORs.Fields.Item(10).Value) then
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"			  
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",7," & ORs.Fields.Item(10).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"
			  elseif CDbl(ORs.Fields.Item(10).Value) < CDbl(ORs.Fields.Item(11).Value) then
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",1,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"			  
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",8," & ORs.Fields.Item(11).Value & "]);"
			  elseif CDbl(ORs.Fields.Item(11).Value) < CDbl(ORs.Fields.Item(4).Value) then
			  	Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",1," & ORs.Fields.Item(4).Value & "]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",2,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",3,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",4,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",5,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",6,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",7,0]);"
				Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",8,0]);"
			  end if
			  'Response.Write " data.addRow([" & ORs.Fields.Item(2).Value & ",1," & ORs.Fields.Item(4).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",2," & ORs.Fields.Item(5).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",3," & ORs.Fields.Item(6).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",4," & ORs.Fields.Item(7).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",5," & ORs.Fields.Item(8).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",6," & ORs.Fields.Item(9).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",7," & ORs.Fields.Item(10).Value & "]); data.addRow([" & ORs.Fields.Item(2).Value & ",8," & ORs.Fields.Item(11).Value & "]);"
			  'Response.Write "  data.addRow([" & ORs.Fields.Item(2).Value & ",9,0]);"
			ORs.MoveNext
		Wend
		Set ORs = Nothing
		Set ODB = Nothing	
		
		%>	

//	        case "dot":       return links.Graph3d.STYLE.DOT;
//        case "dot-line":  return links.Graph3d.STYLE.DOTLINE;
//        case "dot-color": return links.Graph3d.STYLE.DOTCOLOR;
//        case "dot-size":  return links.Graph3d.STYLE.DOTSIZE;
//        case "line":      return links.Graph3d.STYLE.LINE;
//        case "grid":      return links.Graph3d.STYLE.GRID;
//        case "surface":   return links.Graph3d.STYLE.SURFACE;
	

        // specify options
        options = {width:  "900px", 
                   height: "395px",
                   style: "surface",
                   showPerspective: true,
                   showGrid: false,
                   showShadow: false,
                   keepAspectRatio: false,
                   verticalRatio: 0.3,
                   cameraPosition: {
                       distance: 1.5,
                       horizontal: 0,
                       vertical: 2
                     },
					valueMax:1
                   };

        // Instantiate our graph object.
        graph = new links.Graph3d(document.getElementById('mygraph'));

        // Draw our graph with the created data and options 
        graph.draw(data, options);
      }
	  

   </script>
   

<body>
<FORM NAME="formulario" id="formulario">
<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td height="5">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="11"><div id="mygraph"></div><div id="info"></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <TD WIDTH="211" height="29"  CLASS="titulo">SCANNER&nbsp;N&ordm;&nbsp;&nbsp;<% response.write id %></TD>
    <td>&nbsp;</td>
    <td>RANGO&nbsp;&nbsp;</td>
    <td>&nbsp;</td>
    <td>EQUIPO&nbsp;&nbsp;<% response.write eq %></td>
    <td>&nbsp;</td>
    <td>FECHA&nbsp;&nbsp;<% response.write fech %></td>
    <td>&nbsp;</td>
    <td>FAENA&nbsp;&nbsp;<% response.write emp %> </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</FORM>   
</body>
</html>
