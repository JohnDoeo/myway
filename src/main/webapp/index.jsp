<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="jquery/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
<script type="text/javascript" src="jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	if (window.history && window.history.pushState) {
		$(window).on('popstate', function() {
			window.history.pushState('forward', null, '');
			window.history.forward(1);
		});
	}
	window.history.pushState('forward', null, ''); //在IE中必须得有这两行
	window.history.forward(1);

	function openTabs(name, url) {
		//alert(window.closed);
		var myContext = "<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src="
				+ url + "></iframe>";
		if ($('#tabs').tabs('exists', name)) {
			$('#tabs').tabs('select', name);
			var tab = $("#tabs").tabs("getTab", name);
			$("#tabs").tabs("update", {
				tab : tab,
				options : {
					title : name,
					content : myContext,
					closable : true
				}
			});
		} else {
			$("#tabs").tabs('add', {
				title : name,
				content : myContext,
				closable : true
			});
		}
	}

	//页面刷新或退出触发（）
	function myFunction() {
		$.post("logout.do");
		//window.location.assign("logout.do");
	}
</script>
</head>
<body class="easyui-layout" ondragstart="window.event.returnValue=false" oncontextmenu="window.event.returnValue=false" onselectstart="window.event.returnValue=false">
	<div data-options="region:'north',title:'教务管理系统',split:true"
		style="height: 100px;">
		<div align="right">
			<a id="btn" href="#" data-options="plain:true,iconCls:'icon-man'"
				class="easyui-linkbutton"><shiro:principal /></a> <a id="btn"
				href="logout.do" data-options="plain:true,iconCls:'icon-redo'"
				class="easyui-linkbutton">注销</a>
		</div>
	</div>

	<div data-options="region:'west',title:'操作菜单',split:true"
		style="width: 200px;">
		<div id="aa" class="easyui-accordion" data-options="fit:true">
			<shiro:hasAnyRoles name="3,4">
				<div title="请假信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('请假信息管理','jsp/leaveList.jsp')"
						class="easyui-linkbutton" style="width: 100%">请假信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="3,4">
				<div title="转班信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('转班信息管理','jsp/changeClassList.jsp')"
						class="easyui-linkbutton" style="width: 100%">转班信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="3,4">
				<div title="休学信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('休学信息管理','jsp/suspensionSchoolList.jsp')"
						class="easyui-linkbutton" style="width: 100%">休学信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<!-- 学生提问，可以指定班主任或者教师来回答 -->
			<shiro:hasAnyRoles name="2,3,4">
				<div title="问题信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('问题信息管理','jsp/questionList.jsp')"
						class="easyui-linkbutton" style="width: 100%">问题信息管理</a>
					<shiro:hasAnyRoles name="2,4">
						<a id="btn-category" href="#" data-options="plain:true"
							onclick="javascript:openTabs('问题信息统计图','count/questionCount.jsp')"
							class="easyui-linkbutton" style="width: 100%">问题信息统计图</a>
					</shiro:hasAnyRoles>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="4">
				<div title="课程信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('课程信息管理','jsp/courseList.jsp')"
						class="easyui-linkbutton" style="width: 100%">课程信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="4">
				<div title="班级信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('班级信息管理','jsp/gradeList.jsp')"
						class="easyui-linkbutton" style="width: 100%">班级信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="1,5">
				<div title="就业信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('就业信息管理','jsp/employmentStuList.jsp')"
						class="easyui-linkbutton" style="width: 100%">就业信息管理</a> <a
						id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('就业信息统计','count/getJobCount.jsp')"
						class="easyui-linkbutton" style="width: 100%">就业信息统计</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="1,4">
				<div title="学生信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('学生信息管理','jsp/studentList.jsp')"
						class="easyui-linkbutton" style="width: 100%">学生信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="0">
				<div title="用户信息管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('用户信息管理','jsp/userList.jsp')"
						class="easyui-linkbutton" style="width: 100%">用户信息管理</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="0">
				<div title="日志信息" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('日志信息','jsp/logList.jsp')"
						class="easyui-linkbutton" style="width: 100%">日志信息</a> <a
						id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('用户登陆日志图标分析','count/logCount.jsp')"
						class="easyui-linkbutton" style="width: 100%">用户登陆日志图标分析</a>
				</div>
			</shiro:hasAnyRoles>
			<shiro:hasAnyRoles name="0">
				<div title="sql监控管理" style="overflow: auto; padding: 10px;">
					<a id="btn-category" href="#" data-options="plain:true"
						onclick="javascript:openTabs('sql监控管理','<%=request.getContextPath()%>/druid/index.html')"
						class="easyui-linkbutton" style="width: 100%">sql监控管理</a>
				</div>
			</shiro:hasAnyRoles>

		</div>
	</div>

	<div data-options="region:'center',title:'数据显示'"
		style="padding: 5px; background: #eee;">
		<div id="tabs" class="easyui-tabs" data-options="fit:true">
			<div title="首页"
				style="padding: 20px; display: none; text-align: center; background-color: #E0ECFF;">
				<span style="font-size: 96px; color: #826598; padding: inherit;">欢迎进入XXX教务管理系统首页</span>
			</div>
		</div>
	</div>
</body>
</html>