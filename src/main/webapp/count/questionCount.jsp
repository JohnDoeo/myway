<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="../jquery/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../jquery/themes/icon.css">
<script type="text/javascript" src="../jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../jquery/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jquery/echarts-all.js"></script>
<script type="text/javascript" src="../jquery/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function(){
		//对div进行初始化，获取myChart对象
		 var myChart = echarts.init(document.getElementById('echartsIdsZhu'));
		 
		$.post("../questionCount.do",{flag:"zhu"},function(data){
			var count = data.countList;//y轴数据
	   		var typeList = data.nameList;//x轴数据
	   		var option = {//获取数据
	   			 title : {
				        text: '不同类型问题数量统计图',//标题
				        subtext: '柱状图'//副标题
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['库存数量']
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {show: true, type: ['line', 'bar']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : typeList
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:'发布数量',
				            type:'bar',
				            data:count
				        }
				    ]
				};
				//把数据添加到myChart对象
			  myChart.setOption(option);
		  },"json");
	});
	
	$(function(){
		//饼状图
		 var myChart = echarts.init(document.getElementById('echartsIdsBing'));
		 
			$.post("../questionCount.do",{flag:"bing"},function(data){
			var count = data.mapList;
	   		var typeList = data.nameList;  
	   		var option = {
	   			   title : {
	   		        text: '不同类型问题数量统计图',
	   		        subtext: '饼状图',
	   		        x:'center'
	   		    },
	   		    tooltip : {
	   		        trigger: 'item',
	   		        formatter: "{a} <br/>{b} : {c} ({d}%)"
	   		    },
	   		    legend: {
	   		        orient : 'vertical',
	   		        x : 'left',
	   		        data:typeList
	   		    },
	   		    toolbox: {
	   		        show : true,
	   		        feature : {
	   		            mark : {show: true},
	   		            dataView : {show: true, readOnly: false},
	   		            magicType : {
	   		                show: true, 
	   		                type: ['pie', 'funnel'],
	   		            },
	   		            restore : {show: true},
	   		            saveAsImage : {show: true}
	   		        }
	   		    },
	   		    calculable : true,
	   		    series : [
	   		        {
	   		            name:'访问来源',
	   		            type:'pie',
	   		            radius : '55%',
	   		            center: ['50%', '60%'],
	   		            data:count
	   		        }
	   		    ]
	   		};
	   		  myChart.setOption(option);
	   	   },"json"); 
	});
</script>
</head>
<body>
	<table>
		<tr>
			<td><div id="echartsIdsZhu" style="width:500px;height:500px"></div></td>
			<td><div id="echartsIdsBing" style="width:500px;height:500px"></div></td>
		</tr>
	</table>
</body>
</html>