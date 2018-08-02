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
	function delRoleInfoByUserId(userId){
		if($('#dg').datagrid('getSelections').length==0){
			$.messager.alert('警告','请选择要删除角色信息的用户','error'); 
		}else{
			$.messager.confirm("温馨提示","确定要删除吗？",function(r){
				if(r){
					$.post('../delRoleInfoByUserId.do',{uId:userId},function(flag){
						if(flag){
							$.messager.show({
								title:'我的消息',
								msg:'操作成功',
								timeout:5000,
								showType:'slide'
							});
						}else{
							$.messager.show({
								title:'我的消息',
								msg:'操作失败',
								timeout:5000,
								showType:'slide'
							});
						}
					});
				}else{
					$.messager.show({
						title:'我的消息',
						msg:'取消删除',
						timeout:5000,
						showType:'slide'
					});
				}
			})
		}
	}
	function getRoleInfoByUserId(userId){
		$("#roleInfo-dialog").dialog({closed:false});
		$('#roleInfo').datagrid({
			url : '../getRoleInfoByUserId.do',
			queryParams:{
				uId:userId
			},
			columns : [ [ {
				field : 'rId',
				title : '角色ID',
				checkbox:true
			}, {
				field : 'rDesc',
				title : '角色名称',
				width : 100
			}] ]
		});
	}

	$(function() {
		
		$("#btn-add").click(function(){
			$("#add-user-dialog").dialog({
				closed:false,
				buttons:[{
					text:'保存',
					handler:function(){
						$("#add-user-form").form('submit',{
							url:"../addUserInfo.do",
							onSubmit:function(){
								return $("#add-user-form").form("validate");
							},success:function(flag){
								if(flag==1){
									$("#add-user-dialog").dialog({closed:true});
									$("#add-user-form").form("clear");
									$('#dg').datagrid("reload");
									$.messager.show({
										title:'我的消息',
										msg:'操作成功！',
										timeout:5000,
										showType:'slide'
									});
								}else if(flag==0){
									$.messager.show({
										title:'我的消息',
										msg:'操作失败！',
										timeout:5000,
										showType:'slide'
									});
								}else if(flag==-1){
									$.messager.show({
										title:'我的消息',
										msg:'该用户已被注册！',
										timeout:5000,
										showType:'slide'
									});
								}
							}
						})
					}
				}]
			});
		});
		
		
		$("#btn-remove").click(function(){
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要修改的用户','error');
			}else{
				$.messager.confirm('确认对话框', '确定要删除选定用户吗(删除后数据不可恢复)？', function(r){
					if (r){
						var users = $('#dg').datagrid('getSelections');
						var uIds = [];
						for(var i = 0;i < users.length;i++){
							uIds.push(users[i].uId);
						}
						$.post('../removeUserInfo.do',{
							'uIds[]':uIds
						},function(flag){
							if(flag){
								$('#dg').datagrid("reload");
								$.messager.show({
									title:'我的消息',
									msg:'操作成功',
									timeout:5000,
									showType:'slide'
								});
							}else{
								$('#dg').datagrid("unselectAll");
								$.messager.show({
									title:'我的消息',
									msg:'操作失败',
									timeout:5000,
									showType:'slide'
								});
							}
						}) 
					}
				});
			}
		});
		
		$("#btn-edit").click(function(){
			
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要修改的用户','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个用户信息修改','error');
			} else {
				$('#edit-user-form').form('load','../getUserInfoById.do?uId='+$('#dg').datagrid('getSelected').uId);
				$("#edit-user-dialog").dialog({
					closed:false,
					buttons:[{
						text:'保存',
						handler:function(){
							$("#edit-user-form").form('submit',{
								url:"../editUserInfo.do?uId="+$('#dg').datagrid('getSelected').uId,
								onSubmit:function(){
									return $("#edit-user-form").form("validate");
								},
								success:function(flag){
									if(flag==1){
										$("#edit-user-dialog").dialog({closed:true});
										$('#dg').datagrid("reload");
										$("#edit-user-form").form("clear");
										$('#dg').datagrid("unselectAll");
										$.messager.show({
											title:'我的消息',
											msg:'操作成功',
											timeout:5000,
											showType:'slide'
										});
									}else if(flag==0){
										$('#edit-user-form').form('load','../getUserInfoById.do?uId='+$('#dg').datagrid('getSelected').uId);
										$.messager.show({
											title:'我的消息',
											msg:'操作失败！',
											timeout:5000,
											showType:'slide'
										});
									}else if(flag==-1){
										$.messager.show({
											title:'我的消息',
											msg:'该用户名已被占用！',
											timeout:5000,
											showType:'slide'
										});
									}
								}
							});
						}
					}]
				});
			}
		});
		
		$("#btn-add-role").click(function(){
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要添加角色信息的用户','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个用户进行角色信息分配','error');
			} else {
				$("#add-role-dialog").dialog({
					closed:false,
					buttons:[{
						text:'保存',
						handler:function(){
							$("#add-role-form").form('submit',{
								url:'../addUserOfRoleInfo.do?uId='+$('#dg').datagrid('getSelected').uId,
								onSubmit:function(){
									return $("#add-role-form").form('validate');
								},
								success:function(flag){
									if(flag){
										$("#add-role-dialog").dialog({closed:true})
										$('#dg').datagrid('reload');
										$('#dg').datagrid("unselectAll");
										$.messager.show({
											title:'我的消息',
											msg:'操作成功',
											timeout:5000,
											showType:'slide'
										});
									} else {
										$.messager.show({
											title:'我的消息',
											msg:'操作失败',
											timeout:5000,
											showType:'slide'
										});
									}
								}
							});
						}
					}]
				});
			}
		})
		
	


		$('#dg').datagrid({
			url : '../findUserWithPage.do',
			fit : true,
			fitColumns : true,
			toolbar : "#tb",
			pagination : true,
			rownumbers : true,
			pageNumber : 1,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			pagePosition : 'both',
			columns : [ [ {
				field : 'uId',
				title : '用户ID',
				width : 100,
				checkbox : true
			}, {
				field : 'uName',
				title : '用户姓名',
				width : 100
			}, {
				field : 'uPass',
				title : '用户密码',
				width : 100,
				formatter:function(val,rows,index){
					return "******";
				}
			},{
				field : 'xxx',
				title : '用户角色',
				width : 100,
				formatter:function(val,rows,index){
					return "<input type='button' value='查看用户角色信息' onclick='javascript:getRoleInfoByUserId("+rows.uId+")' />"+
					"<input type='button' value='删除用户角色信息' onclick='javascript:delRoleInfoByUserId("+rows.uId+")' />";
				}
			} ] ]
		});
	});
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">
		<a id="btn-add" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-add'">增加用户信息</a> <a id="btn-edit"
			href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'">修改用户信息</a>
		<a id="btn-remove" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-remove'">删除用户信息</a> <a id="btn-add-role"
			href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-man'">用户角色分配</a>
	</div>

	<div id="add-role-dialog" class="easyui-dialog" title="角色信息分配" style="width:auto;height:auto;"   
        data-options="closed:true,modal:true">
		<form action="" id="add-role-form" method="post">
			<table>
				<tr>
					<td>请选择要添加的角色：</td>
					<td><input id="rIds" class="easyui-combobox" name="rIds"
						data-options="valueField:'rId',editable:false,multiple:true,required:true,textField:'rDesc',url:'../findAllRoleInfo.do'" />
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="roleInfo-dialog" class="easyui-dialog" title="My Dialog"
		style="width: 250px; height: 200px;" data-options="modal:true,closed:true">
		<div id="roleInfo"></div>
	</div>

	<div id="add-user-dialog" class="easyui-dialog" title="新增用户"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="add-user-form" method="post">
			<table>
				<tr>
					<td>用户姓名：</td>
					<td><input id="uName" name="uName" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>用户密码：</td>
					<td><input id="uPass" name="uPass" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	
		<div id="edit-user-dialog" class="easyui-dialog" title="修改用户信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-user-form" method="post">
			<table>
				<tr>
					<td>用户姓名：</td>
					<td><input id="uName" name="uName" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>用户密码：</td>
					<td><input id="uPass" name="uPass" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>



</body>
</html>