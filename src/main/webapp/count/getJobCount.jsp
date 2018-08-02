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
<script type="text/javascript"
	src="../jquery/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function() {
		//柱状图
		//对div进行初始化，获取myChart对象
		var myChart = echarts.init(document.getElementById('echartsIdsZhu'));
		$.post("../getJobCount.do", {
			flag : "zhu"
		}, function(data) {
			var count = data.countList;//y轴数据
			var typeList = data.nameList;//x轴数据
			var option = {
				title : {
					x : 'center',
					text : '就业状态信息统计',
					subtext : '柱状图',
					link : 'http://echarts.baidu.com/doc/example.html'
				},
				tooltip : {
					trigger : 'item'
				},
				toolbox : {
					show : true,
					feature : {
						dataView : {
							show : true,
							readOnly : false
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
				},
				calculable : true,
				grid : {
					borderWidth : 0,
					y : 80,
					y2 : 60
				},
				xAxis : [ {
					type : 'category',
					show : false,
					data : typeList
				} ],
				yAxis : [ {
					type : 'value',
					show : false
				} ],
				series : [ {
					name : '就业状态人数统计',
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								// build a color map as your need.
								var colorList = [ '#C1232B', '#B5C334',
										'#FCCE10', '#E87C25', '#27727B',
										'#FE8463', '#9BCA63', '#FAD860',
										'#F3A43B', '#60C0DD', '#D7504B',
										'#C6E579', '#F4E001', '#F0805A',
										'#26C0C0' ];
								return colorList[params.dataIndex]
							},
							label : {
								show : true,
								position : 'top',
								formatter : '{b}\n{c}'
							}
						}
					},
					data : count,
					markPoint : {
						tooltip : {
							trigger : 'item',
							backgroundColor : 'rgba(0,0,0,0)',
							formatter : function(params) {
								return '<img src="'
										+ params.data.symbol.replace(
												'image://', '') + '"/>';
							}
						},
						data : []
					}
				} ]
			};
			//把数据添加到myChart对象
			myChart.setOption(option);
		}, "json");
	});

	$(function() {
		//饼状图
		var myChart = echarts.init(document.getElementById('echartsIdsBing'));

		$.post("../getJobCount.do", {
			flag : "bing"
		}, function(data) {
			var count = data.dataList;
			var typeList = data.nameList;

			var option = {
				title : {
					text : '就业状态信息统计',
					subtext : '饼状图',
					x : 'center'
				},
				tooltip : {
					trigger : 'item',
					formatter : "{a} <br/>{b} : {c} ({d}%)"
				},
				legend : {
					orient : 'vertical',
					x : 'left',
					data : typeList
				},
				toolbox : {
					show : true,
					feature : {
						mark : {
							show : true
						},
						dataView : {
							show : true,
							readOnly : false
						},
						magicType : {
							show : true,
							type : [ 'pie', 'funnel' ],
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
				},
				calculable : true,
				series : [ {
					name : '人数',
					type : 'pie',
					radius : '55%',
					center : [ '50%', '60%' ],
					data : count
				} ]
			};
			myChart.setOption(option);
		}, "json");
	});

	$(function() {

		var myChart = echarts.init(document.getElementById('echartsIdsZhu1'));

		$.post("../getJobCount.do", {
			flag : "zhu1"
		}, function(data) {
			var x = data.nameList;
			var y1 = data.manList;
			var y2 = data.womenList;
			var option = {
				title : {
					text : '就业状态信息统计图',
					subtext : '柱状图'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '男', '女' ]
				},
				toolbox : {
					show : true,
					feature : {
						mark : {
							show : true
						},
						dataView : {
							show : true,
							readOnly : false
						},
						magicType : {
							show : true,
							type : [ 'line', 'bar' ]
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
				},
				calculable : true,
				xAxis : [ {
					type : 'category',
					data : x
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					name : '男',
					type : 'bar',
					data : y1,
					markPoint : {
						data : [ {
							type : 'max',
							name : '最大值'
						}, {
							type : 'min',
							name : '最小值'
						} ]
					},

				}, {
					name : '女',
					type : 'bar',
					data : y2,
				} ]
			};
			myChart.setOption(option);
		}, "json");
	})
</script>
</head>
<body>
	<table>
		<tr>
			<td><div id="echartsIdsZhu" style="width: 500px; height: 400px"></div></td>
			<td><div id="echartsIdsBing" style="width: 500px; height: 400px"></div></td>
		</tr>
		<tr>
			<td><div id="echartsIdsZhu1" style="width: 500px; height: 400px"></div></td>
		</tr>
	</table>
</body>
</html>