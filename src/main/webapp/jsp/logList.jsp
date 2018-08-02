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
<script type="text/javascript"
	src="../jquery/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function() {

		$('#dg').datagrid({
			url : '../findLogWithPage.do',
			fit : true,
			fitColumns : true,
			pagination : true,
			rownumbers : true,
			pageNumber : 1,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			pagePosition : 'both',
			columns : [ [ {
				field : 'logId',
				title : '日志ID',
				width : 100,
				checkbox : true
			}, {
				field : 'uName',
				title : '登陆用户',
				width : 100
			}, {
				field : 'loginTime',
				title : '登录时间',
				width : 100
			}, {
				field : 'ip',
				title : '登陆ip地址',
				width : 100
			}, {
				field : 'logoutTime',
				title : '退出时间',
				width : 100
			} ] ]
		});
	});
	
</script>
</head>
<body>
	<div id="dg"></div>
</body>
</html>