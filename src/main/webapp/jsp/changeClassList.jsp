<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
		
		$("#btn-app").click(function(){
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要审批的转班信息！','error');
			}else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','请选择一条转班信息进行审批！','error');
			} else {
				$("#app-change-class-dialog").dialog({
					closed:false,
					buttons:[{
						text:'保存',
						handler:function(){
							$("#app-change-class-form").form('submit',{
								url:'../editChangeClassInfo.do?ccId='+$('#dg').datagrid('getSelected').ccId,
								onSubmit:function(){
									return $("#app-change-class-form").form("validate");
								},success:function(flag){
									if(flag){
										$('#dg').datagrid("reload");
										$("#app-change-class-dialog").dialog({closed:true});
										$("#app-change-class-form").form("clear");
										$.messager.show({
											title:'我的消息',
											msg:'操作成功！',
											timeout:5000,
											showType:'slide'
										});
									}else{
										$.messager.show({
											title:'我的消息',
											msg:'操作失败！',
											timeout:5000,
											showType:'slide'
										});
									}
								}
							})
						}
					}]
				})
			}
		})
		
		$("#btn-commit").click(function(){
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要提交的请假信息！','error');
			}else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','请选择一条转班信息进行提交！','error');
			} else {
				if($('#dg').datagrid('getSelected').appContext==null){
					$.messager.confirm('确认对话框', '确定要提交该转班信息吗(提交后无法修改)？', function(r){
						if(r){
							$.post("../commitChangeClass.do",{
								"ccId":$('#dg').datagrid('getSelected').ccId
							},function(flag){
								if(flag){
									$('#dg').datagrid("reload");
									$.messager.show({
										title:'我的消息',
										msg:'操作成功！',
										timeout:5000,
										showType:'slide'
									});
								}else{
									$.messager.show({
										title:'我的消息',
										msg:'操作失败！',
										timeout:5000,
										showType:'slide'
									});
								}
							});
						}
					});
				}else{
					$.messager.alert('警告','无法提交已审核的请假信息！','error'); 
				}
			}
		});
		
		$("#btn-add").click(function(){
			$("#add-change-class-dialog").dialog({
				closed:false,
				buttons:[{
					text:'保存',
					handler:function(){
						$("#add-change-class-form").form('submit',{
							url:"../addChangeClassInfo.do",
							onSubmit:function(){
								return $("#add-change-class-form").form("validate");
							},success:function(flag){
								if(flag){
									$("#add-change-class-dialog").dialog({closed:true});
									$("#add-change-class-form").form("clear");
									$('#dg').datagrid("reload");
									$.messager.show({
										title:'我的消息',
										msg:'操作成功！',
										timeout:5000,
										showType:'slide'
									});
								}else{
									$.messager.show({
										title:'我的消息',
										msg:'操作失败！',
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
						var changeClass = $('#dg').datagrid('getSelections');
						var ccIds = [];
						for(var i = 0;i < changeClass.length;i++){
							ccIds.push(changeClass[i].ccId);
						}
						$.post('../removeChangeClassInfo.do',{
							'ccIds[]':ccIds
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
				$.messager.alert('警告','请选择要修改的请假信息','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个请假信息修改','error');
			}else{
				if($('#dg').datagrid('getSelected').appContext!=null && $('#dg').datagrid('getSelected').appContext!=''){
					$.messager.alert('警告','只能选择未审批的请假信息进行修改','error');
				}else{
					$('#edit-change-class-form').form('load','../getChangeClassInfoById.do?ccId='+$('#dg').datagrid('getSelected').ccId);
					$("#edit-change-class-dialog").dialog({
						closed:false,
						buttons:[{
							text:'保存',
							handler:function(){
								$("#edit-change-class-form").form('submit',{
									url:"../editChangeClassInfo.do?ccId="+$('#dg').datagrid('getSelected').ccId,
									onSubmit:function(){
										return $("#edit-change-class-form").form("validate");
									},
									success:function(flag){
										if(flag){
											$("#edit-change-class-dialog").dialog({closed:true});
											$('#dg').datagrid("reload");
											$("#edit-change-class-form").form("clear");
											$('#dg').datagrid("unselectAll");
											$.messager.show({
												title:'我的消息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
										}else{
											$('#edit-change-class-form').form('load','../getChangeClassInfoById.do?ccId='+$('#dg').datagrid('getSelected').ccId);
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
			}
		});
		

		$('#dg').datagrid({
			url : '../findChangeClassWithPage.do',
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
				field : 'ccId',
				title : '转班ID',
				width : 100,
				checkbox : true
			}, {
				field : 'uName',
				title : '转班人',
				width : 100
			}, {
				field : 'reasion',
				title : '转班原因',
				width : 100,
			}, {
				field : 'appContext',
				title : '审批内容',
				width : 100,
			} , {
				field : 'appState',
				title : '审批状态',
				width : 100,
				formatter:function(val,rows,index){
					if(val=="已审核"){
						return "<span style='color: #D84C29'>"+val+"</span>";
					}else{
						return val;
					}
				}
			}, {
				field : 'appTime',
				title : '审批时间',
				width : 100,
			}, {
				field : 'commitTime',
				title : '提交时间',
				width : 100,
			}  , {
				field : 'remark',
				title : '备注',
				width : 100,
			} , {
				field : 'tName',
				title : '班主任',
				width : 100,
			}  ] ]
		});
	});
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">
		<shiro:hasAnyRoles name="3">
		<a id="btn-add" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-add'">增加转班信息</a>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="3">
		<a id="btn-edit" href="#" class="easyui-linkbutton" 
			data-options="plain:true,iconCls:'icon-edit'">修改转班信息</a>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="3">
		<a id="btn-remove" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-remove'">删除转班信息</a> 
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="4">
		<a id="btn-app" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:''">班主任审批</a> 
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="3">
		<a id="btn-commit" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-ok'">提交转班信息</a> 
		</shiro:hasAnyRoles>
	</div>

	<div id="add-change-class-dialog" class="easyui-dialog" title="新增转班信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="add-change-class-form" method="post">
			<table>
				<tr>
					<td>申请人：</td>
					<td><shiro:principal/></td>
				</tr>
				<tr>
					<td>转班原因：</td>
					<td><input id="reasion" name="reasion" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>班主任：</td>
					<td><input id="tId" class="easyui-combobox" name="tId"
						data-options="required:true,editable:false,valueField:'uId',textField:'uName',url:'../findAllTeacher.do'" />
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remark" name="remark" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	
		<div id="edit-change-class-dialog" class="easyui-dialog" title="修改用户信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-change-class-form" method="post">
			<table>
				<tr>
					<td>申请人：</td>
					<td><shiro:principal/></td>
				</tr>
				<tr>
					<td>转班原因：</td>
					<td><input id="reasion" name="reasion" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>班主任：</td>
					<td><input id="tId" class="easyui-combobox" name="tId"
						data-options="required:true,editable:false,valueField:'uId',textField:'uName',url:'../findAllTeacher.do'" />
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remark" name="remark" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="app-change-class-dialog" class="easyui-dialog" title="审批"
		style="width: 300px; height: 110px;"
		data-options="closed:true,iconCls:'icon-save',resizable:true,modal:true">
		<form id="app-change-class-form" method="post">
			<table>
				<tr>
					<td>审批内容：</td>
					<td><input id="appContext" name="appContext" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>