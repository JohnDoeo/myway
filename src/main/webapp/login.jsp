
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	$(function() {
		$("#login-dialog").dialog({
			buttons : [ {
				text : '登录',
				iconCls:'icon-man',
				handler : function() {
					$("#login-form").form('submit', {
						url : 'login.do',
						onSubmit : function() {
							return $("#login-form").form('validate');
						},
						success : function(flag) {
							if (flag == "1") {
								window.location.href = "index.jsp";
							} else if (flag == "-1") {
								alert("用户名不匹配");
							} else if (flag == "-2") {
								alert("认证失败");
							} else if (flag == "0") {
								alert("密码错误");
							}
						}
					});
				}
			} ]
		})
	})
</script>
</head>
<body>

	<div id="login-dialog" class="easyui-dialog"
		data-options="modal:true,closed:false,title:'登录'"
		style="width: auto; height: auto">
		<form id="login-form" method="post">
			<table>
				<tr>
					<td>用户名：</td>
					<td><input id="uName" name="uName" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input id="uPass" name="uPass"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>