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
		$("#btn-reply").click(function(){
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要回复的问题','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个问题信息回复','error');
			} else {
				$("#reply-question-dialog").dialog({
					closed:false,
					buttons:[{
						text:'保存',
						handler:function(){
							$("#reply-question-form").form('submit',{
								url:"../editQuestionInfo.do?qId="+$('#dg').datagrid('getSelected').qId,
								onSubmit:function(){
									return $("#reply-question-form").form("validate");
								},
								success:function(flag){
									if(flag){
										$("#reply-question-dialog").dialog({closed:true});
										$('#dg').datagrid("reload");
										$("#reply-question-form").form("clear");
										$('#dg').datagrid("unselectAll");
										$.messager.show({
											title:'我的消息',
											msg:'操作成功',
											timeout:5000,
											showType:'slide'
										});
									}else{
										$('#edit-question-form').form('load','../getQuestionInfoById.do?qId='+$('#dg').datagrid('getSelected').qId);
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
		});
		
		$("#btn-commit").click(function(){
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要修改的用户','error');
			}else{
				$.messager.confirm('确认对话框', '确定要删除选定用户吗(删除后数据不可恢复)？',function(result){
					if(result){
						var questions = $('#dg').datagrid('getSelections');
						var qIds = [];
						for(var i = 0;i < questions.length;i++){
							qIds.push(questions[i].qId);
						}
						$.post('../commitQuestion.do',{
							'qIds[]':qIds
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
						});
					}
				});
			}
		});
		
		$("#btn-add").click(function(){
			$("#add-question-dialog").dialog({
				closed:false,
				buttons:[{
					text:'保存',
					handler:function(){
						$("#add-question-form").form('submit',{
							url:"../addQuestionInfo.do",
							onSubmit:function(){
								return $("#add-question-form").form("validate");
							},success:function(flag){
								if(flag){
									$("#add-question-dialog").dialog({closed:true});
									$("#add-question-form").form("clear");
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
						var questions = $('#dg').datagrid('getSelections');
						var qIds = [];
						for(var i = 0;i < questions.length;i++){
							qIds.push(questions[i].qId);
						}
						$.post('../removeQuestionInfo.do',{
							'qIds[]':qIds
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
				$.messager.alert('警告','请选择要修改的问题','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个问题信息修改','error');
			} else {
				if($('#dg').datagrid('getSelected').reply==null){
					$('#edit-question-form').form('load','../getQuestionInfoById.do?qId='+$('#dg').datagrid('getSelected').qId);
					$("#edit-question-dialog").dialog({
						closed:false,
						buttons:[{
							text:'保存',
							handler:function(){
								$("#edit-question-form").form('submit',{
									url:"../editQuestionInfo.do?qId="+$('#dg').datagrid('getSelected').qId,
									onSubmit:function(){
										return $("#edit-question-form").form("validate");
									},
									success:function(flag){
										if(flag){
											$("#edit-question-dialog").dialog({closed:true});
											$('#dg').datagrid("reload");
											$("#edit-question-form").form("clear");
											$('#dg').datagrid("unselectAll");
											$.messager.show({
												title:'我的消息',
												msg:'操作成功',
												timeout:5000,
												showType:'slide'
											});
										}else{
											$('#edit-question-form').form('load','../getQuestionInfoById.do?qId='+$('#dg').datagrid('getSelected').qId);
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
				}else{
					$.messager.alert('警告','已回复的问题无法修改！','error');  
				}
			}
		});
	
		$('#dg').datagrid({
			url : '../findQuestionWithPage.do',
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
				field : 'qId',
				title : '问题ID',
				width : 100,
				checkbox : true
			}, {
				field : 'uName',
				title : '提问人',
				width : 100
			}, {
				field : 'question',
				title : '问题',
				width : 100,
			}, {
				field : 'questionTime',
				title : '问题提交时间',
				width : 100,
			},{
				field : 'reply',
				title : '回复',
				width : 100,
			}, {
				field : 'tName',
				title : '回复老师',
				width : 100,
			}, {
				field : 'replyTime',
				title : '回复时间',
				width : 100,
			}, {
				field : 'type',
				title : '问题类型',
				width : 100,
			}, {
				field : 'remark',
				title : '备注',
				width : 100,
			}] ]
		});
	});
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">
		<shiro:hasAnyRoles name="3">
			<a id="btn-add" href="#" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-add'">新增问题</a>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="3">
			<a id="btn-edit" href="#" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-edit'">修改问题</a>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="3">
			<a id="btn-remove" href="#" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-remove'">删除问题</a>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="3">
			<a id="btn-commit" href="#" class="easyui-linkbutton"
				data-options="plain:true,iconCls:''">提交问题</a>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="2,4">
			<a id="btn-reply" href="#" class="easyui-linkbutton"
				data-options="plain:true,iconCls:''">回复问题</a>
		</shiro:hasAnyRoles>
	</div>

	<div id="add-question-dialog" class="easyui-dialog" title="新增用户"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="add-question-form" method="post">
			<table>
				<tr>
					<td>提问人：</td>
					<td><shiro:principal/></td>
				</tr>
				<tr>
					<td>问题内容：</td>
					<td><input id="question" name="question" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>问题类型：</td>
					<td><select id="type" name="type">
						<option value="java">java</option>
						<option value="html">html</option>
						<option value="js">js</option>
						<option value="css">css</option>
						<option value="ajax">ajax</option>
					</select></td>
				</tr>
				<tr>
					<td>回复老师：</td>
					<td><input id="tId" class="easyui-combobox" name="tId"
						data-options="required:true,editable:false,valueField:'uId',textField:'uName',url:'../findAllTeacherReply.do'" /></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remark" name="remark" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	
	<div id="edit-question-dialog" class="easyui-dialog" title="修改用户信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-question-form" method="post">
			<table>
				<tr>
					<td>提问人：</td>
					<td><shiro:principal/></td>
				</tr>
				<tr>
					<td>问题内容：</td>
					<td><input id="question" name="question" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>问题类型：</td>
					<td><select id="type" name="type">
						<option value="java">java</option>
						<option value="html">html</option>
						<option value="js">js</option>
						<option value="css">css</option>
						<option value="ajax">ajax</option>
					</select></td>
				</tr>
				<tr>
					<td>回复老师：</td>
					<td><input id="tId" class="easyui-combobox" name="tId"
						data-options="required:true,editable:false,valueField:'uId',textField:'uName',url:'../findAllTeacherReply.do'" /></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remark" name="remark" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="reply-question-dialog" class="easyui-dialog" title="修改用户信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="reply-question-form" method="post">
			<table>
				<tr>
					<td>回复内容：</td>
					<td><input id="reply" name="reply" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>


</body>
</html>