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
		
		$("#btn-add").click(function(){
			$("#add-course-dialog").dialog({
				closed:false,
				buttons:[{
					text:'保存',
					handler:function(){
						$("#add-course-form").form('submit',{
							url:"../addCourseInfo.do",
							onSubmit:function(){
								if($("#tIdAdd").combobox("getValue")==null || $("#tIdAdd").combobox("getValue")==''){
									$.messager.alert('警告','请选择授课老师','error');
									return false;
								}else{
									return $("#add-course-form").form("validate");
								}
							},success:function(flag){
								if(flag==1){
									$("#add-course-dialog").dialog({closed:true});
									$("#add-course-form").form("clear");
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
										msg:'该课程已存在！',
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
				$.messager.alert('警告','请选择要修改的课程','error');
			}else{
				$.messager.confirm('确认对话框', '确定要删除选定课程吗(删除后数据不可恢复)？', function(r){
					if (r){
						var courses = $('#dg').datagrid('getSelections');
						var cIds = [];
						for(var i = 0;i < courses.length;i++){
							cIds.push(courses[i].cId);
						}
						$.post('../removeCourseInfo.do',{
							'cIds[]':cIds
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
				$.messager.alert('警告','请选择要修改的课程','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个课程信息修改','error');
			} else {
				
				$('#edit-course-form').form('load','../getCourseInfoById.do?cId='+$('#dg').datagrid('getSelected').cId);
				$("#edit-course-dialog").dialog({
					closed:false,
					buttons:[{
						text:'保存',
						handler:function(){
							$("#edit-course-form").form('submit',{
								url:"../editCourseInfo.do?cId="+$('#dg').datagrid('getSelected').cId,
								onSubmit:function(){
									if($("#tIdEdit").combobox("getValue")==null || $("#tIdEdit").combobox("getValue")==''){
										$.messager.alert('警告','请选择授课老师','error');
										return false;
									}else{
										return $("#edit-course-form").form("validate");
									}
								},
								success:function(flag){
									if(flag){
										$("#edit-course-dialog").dialog({closed:true});
										$('#dg').datagrid("reload");
										$("#edit-course-form").form("clear");
										$('#dg').datagrid("unselectAll");
										$.messager.show({
											title:'我的消息',
											msg:'操作成功',
											timeout:5000,
											showType:'slide'
										});
									}else{
										$('#edit-course-form').form('load','../getCourseInfoById.do?uId='+$('#dg').datagrid('getSelected').uId);
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
		
		$('#dg').datagrid({
			url : '../findCourseWithPage.do',
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
				field : 'cId',
				title : '课程ID',
				width : 100,
				checkbox : true
			}, {
				field : 'name',
				title : '课程名称',
				width : 100
			},{
				field : 'tName',
				title : '授课老师',
				width : 100
			}, {
				field : 'remark',
				title : '备注',
				width : 100
			}] ]
		});
	});
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">
		<a id="btn-add" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-add'">增加课程信息</a>
		<a id="btn-edit" href="#" class="easyui-linkbutton" 
			data-options="plain:true,iconCls:'icon-edit'">修改课程信息</a>
		<a id="btn-remove" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-remove'">删除课程信息</a> 
	</div>

	<div id="add-course-dialog" class="easyui-dialog" title="新增课程"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="add-course-form" method="post">
			<table>
				<tr>
					<td>课程名称：</td>
					<td><input id="name" name="name" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>授课老师：</td>
					<td><input id="tIdAdd" name="tId" class="easyui-combobox"   
   						 data-options="required:true,editable:false,valueField:'uId',textField:'uName',url:'../getTeachTeacher.do'" /> 
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
	
	<div id="edit-course-dialog" class="easyui-dialog" title="修改用户信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-course-form" method="post">
			<table>
				<tr>
					<td>课程名称：</td>
					<td><input id="name" name="name" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>授课老师：</td>
					<td><input id="tIdEdit" name="tId" class="easyui-combobox"   
   						 data-options="editable:false,valueField:'uId',textField:'uName',url:'../getTeachTeacher.do'" /> 
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
</body>
</html>