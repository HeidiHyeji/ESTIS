<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="SystemMonitoring.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/gauge.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

<link rel="stylesheet" type="text/css" href="/ESTIS/Estis/Css/adminsystemmonitoring.css" />
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  	 <% 
		SystemMonitoring sm=new SystemMonitoring();
		CPUVo cpuVo=new CPUVo();
		MemoryVo memoryVo=new MemoryVo();
		cpuVo=sm.getCPU();
		memoryVo=sm.getMemory();
		//int cpuusertime=(int)cpuVo.getUserTime();
	%>
   <script type="text/javascript">
   var chart = AmCharts.makeChart("chartdiv", {
	   "theme": "light",
	   "type": "gauge",
	   "axes": [{
	     "topTextFontSize": 20,
	     "topTextYOffset": 70,
	     "axisColor": "#31d6ea",
	     "axisThickness": 1,
	     "endValue": 100,
	     "gridInside": true,
	     "inside": true,
	     "radius": "50%",
	     "valueInterval": 10,
	     "tickColor": "#67b7dc",
	     "startAngle": -90,
	     "endAngle": 90,
	     "unit": "%",
	     "bandOutlineAlpha": 0,
	     "bands": [{
	       "color": "#0080ff",
	       "endValue": 100,
	       "innerRadius": "105%",
	       "radius": "170%",
	       "gradientRatio": [0.5, 0, -0.5],
	       "startValue": 0
	     }, {
	       "color": "#3cd3a3",
	       "endValue": 0,
	       "innerRadius": "105%",
	       "radius": "170%",
	       "gradientRatio": [0.5, 0, -0.5],
	       "startValue": 0
	     }]
	   }],
	   "arrows": [{
	     "alpha": 1,
	     "innerRadius": "35%",
	     "nailRadius": 0,
	     "radius": "170%"
	   }]
	 });
 	 
	 setInterval(memoryValue, 2000);

	 // set random value
	 function memoryValue() {
	   var value = Math.round(Math.random() * 100);
	   chart.arrows[0].setValue(<%=memoryVo.getPercent()%>);
	   chart.axes[0].setTopText(<%=memoryVo.getPercent()%> + " %");
	   // adjust darker band to new value
	   chart.axes[0].bands[1].setEndValue(<%=memoryVo.getPercent()%>);
	 }
	 
	 <!--반도넛2-->
	  var chart2 = AmCharts.makeChart("chartdiv2", {
		   "theme": "light",
		   "type": "gauge",
		   "axes": [{
		     "topTextFontSize": 20,
		     "topTextYOffset": 70,
		     "axisColor": "#31d6ea",
		     "axisThickness": 1,
		     "endValue": 100,
		     "gridInside": true,
		     "inside": true,
		     "radius": "50%",
		     "valueInterval": 10,
		     "tickColor": "#67b7dc",
		     "startAngle": -90,
		     "endAngle": 90,
		     "unit": "%",
		     "bandOutlineAlpha": 0,
		     "bands": [{
		       "color": "#0080ff",
		       "endValue": 100,
		       "innerRadius": "105%",
		       "radius": "170%",
		       "gradientRatio": [0.5, 0, -0.5],
		       "startValue": 0
		     }, {
		       "color": "#3cd3a3",
		       "endValue": 0,
		       "innerRadius": "105%",
		       "radius": "170%",
		       "gradientRatio": [0.5, 0, -0.5],
		       "startValue": 0
		     }]
		   }],
		   "arrows": [{
		     "alpha": 1,
		     "innerRadius": "35%",
		     "nailRadius": 0,
		     "radius": "170%"
		   }]
		 });
	 	 
		 setInterval(cpuValue, 2000);

		 // set random value
		 function cpuValue() {
		   var value = Math.round(Math.random() * 100);
		   chart2.arrows[0].setValue(<%=cpuVo.getUserTime()%>);
		   chart2.axes[0].setTopText(<%=cpuVo.getUserTime()%> + " %");
		   // adjust darker band to new value
		   chart2.axes[0].bands[1].setEndValue(<%=cpuVo.getUserTime()%>);
		 }
	 <!--메모리 게이지차트-->
      google.charts.load('current', {'packages':['gauge']});
      google.charts.setOnLoadCallback(drawChart3);

      function drawChart3() {

        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['Total(GB)', <%=memoryVo.getTotal()%>],
          ['Used(GB)', <%=memoryVo.getUsed()%>],
          ['Free(GB)', <%=memoryVo.getFree()%>]
        ]);

        var options = {
          width: 400, height: 120,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };

        var chart = new google.visualization.Gauge(document.getElementById('gaugechart1'));

        chart.draw(data, options);

        /*setInterval(function() {
          data.setValue(0, 1, 40 + Math.round(60 * Math.random()));
          chart.draw(data, options);
        }, 13000);
        setInterval(function() {
          data.setValue(1, 1, 40 + Math.round(60 * Math.random()));
          chart.draw(data, options);
        }, 5000);
*/
      }
      google.charts.setOnLoadCallback(drawChart4);

      function drawChart4() {

        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['User Time(%)', <%=cpuVo.getUserTime()%>],
          ['Sys Time(%)', <%=cpuVo.getTotalSysTime()%>],
          ['Idle(%)', <%=cpuVo.getTotalIdle()%>]
        ]);

        var options = {
          width: 400, height: 120,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };

        var chart = new google.visualization.Gauge(document.getElementById('gaugechart2'));

        chart.draw(data, options);

        /*setInterval(function() {
          data.setValue(0, 1, 40 + Math.round(60 * Math.random()));
          chart.draw(data, options);
        }, 13000);
        setInterval(function() {
          data.setValue(1, 1, 40 + Math.round(60 * Math.random()));
          chart.draw(data, options);
        }, 5000);
*/
      }
    </script>
</head>
<body>
<jsp:include page="Admin_Top.jsp" flush="true" />

<div class="missiontitle">
   <b>System Monitoring</b> 
   <hr class="titleline">
</div>
	

	
	
		<div style="width:100%; border:1px solid #687672;" align=center>
		<span style="width:50%;float:left;font-size: 13px;background-color: #a1bbd0;">Memory Monitor</span>
       <span style="width:50%;float:right;background-color: #a1bbd0;font-size: 13px;">CPU Monitor</span>
</div>
	<div class="mainchartdiv" align=center>
       <div id="chartdiv" class="mainchart" ></div>
		<div id="chartdiv2" class="mainchart"></div> 
</div>
	<div class="subchartdiv" align=center >
	<div id="gaugechart1" class="subchart"></div>
	<div id="gaugechart2" class="subchart2"></div>
	</div>
	
	<jsp:include page="Bottom.jsp" flush="true" />
	
	
</body>
</html>