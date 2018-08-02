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

		$("#btn-add").click(function() {
			$("#add-grade-dialog").dialog({
				closed : false,
				buttons : [ {
					text : '保存',
					handler : function() {
						$("#add-grade-form").form('submit', {
							url : "../addGradeInfo.do",
							onSubmit : function() {
								return $("#add-grade-form").form("validate");
							},
							success : function(flag) {
								if (flag == 1) {
									$("#add-grade-dialog").dialog({
										closed : true
									});
									$("#add-grade-form").form("clear");
									$('#dg').datagrid("reload");
									$.messager.show({
										title : '我的消息',
										msg : '操作成功！',
										timeout : 5000,
										showType : 'slide'
									});
								} else if (flag == 0) {
									$.messager.show({
										title : '我的消息',
										msg : '操作失败！',
										timeout : 5000,
										showType : 'slide'
									});
								} else if (flag == -1) {
									$.messager.show({
										title : '我的消息',
										msg : '班级名称已存在！',
										timeout : 5000,
										showType : 'slide'
									});
								}
							}
						})
					}
				} ]
			});
		});

		$("#btn-remove")
				.click(
						function() {
							if ($('#dg').datagrid('getSelections').length == 0) {
								$.messager.alert('警告', '请选择要修改的用户', 'error');
							} else {
								$.messager
										.confirm(
												'确认对话框',
												'确定要删除选定用户吗(删除后数据不可恢复)？',
												function(r) {
													if (r) {
														var grades = $('#dg')
																.datagrid(
																		'getSelections');
														var gradeIds = [];
														for (var i = 0; i < grades.length; i++) {
															gradeIds
																	.push(grades[i].gradeId);
														}
														$
																.post(
																		'../removeGradeInfo.do',
																		{
																			'gradeIds[]' : gradeIds
																		},
																		function(
																				flag) {
																			if (flag) {
																				$(
																						'#dg')
																						.datagrid(
																								"reload");
																				$.messager
																						.show({
																							title : '我的消息',
																							msg : '操作成功',
																							timeout : 5000,
																							showType : 'slide'
																						});
																			} else {
																				$(
																						'#dg')
																						.datagrid(
																								"unselectAll");
																				$.messager
																						.show({
																							title : '我的消息',
																							msg : '操作失败',
																							timeout : 5000,
																							showType : 'slide'
																						});
																			}
																		})
													}
												});
							}
						});

		$("#btn-edit")
				.click(
						function() {

							if ($('#dg').datagrid('getSelections').length == 0) {
								$.messager.alert('警告', '请选择要修改的班级信息', 'error');
							} else if ($('#dg').datagrid('getSelections').length > 1) {
								$.messager.alert('警告', '最多选择一个班级信息修改', 'error');
							} else {
								$('#edit-grade-form').form(
										'load',
										'../getGradeInfoById.do?gradeId='
												+ $('#dg').datagrid(
														'getSelected').gradeId);
								$("#edit-grade-dialog")
										.dialog(
												{
													closed : false,
													buttons : [ {
														text : '保存',
														handler : function() {
															$(
																	"#edit-grade-form")
																	.form(
																			'submit',
																			{
																				url : "../editGradeInfo.do?gradeId="
																						+ $(
																								'#dg')
																								.datagrid(
																										'getSelected').gradeId,
																				onSubmit : function() {
																					return $(
																							"#edit-grade-form")
																							.form(
																									"validate");
																				},
																				success : function(
																						flag) {
																					if (flag) {
																						$(
																								"#edit-grade-dialog")
																								.dialog(
																										{
																											closed : true
																										});
																						$(
																								'#dg')
																								.datagrid(
																										"reload");
																						$(
																								"#edit-grade-form")
																								.form(
																										"clear");
																						$(
																								'#dg')
																								.datagrid(
																										"unselectAll");
																						$.messager
																								.show({
																									title : '我的消息',
																									msg : '操作成功',
																									timeout : 5000,
																									showType : 'slide'
																								});
																					} else {
																						$(
																								'#edit-grade-form')
																								.form(
																										'load',
																										'../getGradeInfoById.do?gradeId='
																												+ $(
																														'#dg')
																														.datagrid(
																																'getSelected').gradeId);
																						$.messager
																								.show({
																									title : '我的消息',
																									msg : '操作失败',
																									timeout : 5000,
																									showType : 'slide'
																								});
																					}
																				}
																			});
														}
													} ]
												});
							}
						});

		$("#btn-search").click(function() {
			$('#dg').datagrid('load', {
				gName : $("#gName").val(),
				classType : $("#classType").val(),
				startTime : $("#startTime").datebox("getValue"),
				endTime : $("#endTime").datebox("getValue"),
				state : $("#state").combobox("getValue")
			})
		})

		$('#dg').datagrid({
			url : '../findGradeWithPage.do',
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
				field : 'gradeId',
				title : '班级ID',
				width : 100,
				checkbox : true
			}, {
				field : 'gName',
				title : '班级名称',
				width : 100
			}, {
				field : 'uName',
				title : '班主任',
				width : 100
			}, {
				field : 'classType',
				title : '班级类型',
				width : 100
			}, {
				field : 'startTime',
				title : '开班时间',
				width : 100
			}, {
				field : 'endTime',
				title : '结课时间',
				width : 100
			}, {
				field : 'state',
				title : '班级状态',
				width : 100,
				formatter:function(val,rows,index){
					if(val=="已开班"){
						return "<span style='color: #D84C29'>已开班</span>";
					}else{
						return val;
					}
				}
			}, {
				field : 'remark',
				title : '备注',
				width : 100
			} ] ]
		});
	});
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">

		<table>
			<tr>
				<td>班级名称：</td>
				<td><input id="gName" class="easyui-validatebox" /></td>
				<td>班级类型：</td>
				<td><input id="classType" class="easyui-validatebox" /></td>
				<td>开班时间：</td>
				<td><input id="startTime" type="text" class="easyui-datebox" /></td>
				<td>结课时间：</td>
				<td><input id="endTime" type="text" class="easyui-datebox"/></td>
				<td>班级状态：</td>
				<td><select id="state" class="easyui-combobox" name="state"
					style="width: 200px;">
						<option value="">--请选择--</option>
						<option value="已开班">已开班</option>
						<option value="未开班">未开班</option>
				</select></td>
				<td><a id="btn-search" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">查询</a></td>
			</tr>
		</table>

		<a id="btn-add" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-add'">增加班级信息</a> <a
			id="btn-edit" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-edit'">修改班级信息</a> <a
			id="btn-remove" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-remove'">删除班级信息</a>
	</div>

	<div id="add-grade-dialog" class="easyui-dialog" title="新增用户"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="add-grade-form" method="post">
			<table>
				<tr>
					<td>班级名称：</td>
					<td><input id="gName" name="gName" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>班级类型：</td>
					<td><input id="classType" name="classType"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>开课时间：</td>
					<td><input id="startTime" name="startTime" type="text"
						class="easyui-datebox" required="required" /></td>
				</tr>
				<tr>
					<td>结课时间：</td>
					<td><input id="endTime" name="endTime" type="text"
						class="easyui-datebox" required="required" /></td>
				</tr>
				<tr>
					<td>班级状态：</td>
					<td><select id="state" class="easyui-combobox" name="state"
						style="width: 174px;" data-options="required:true">
							<option value="">--请选择--</option>
							<option>已开班</option>
							<option>未开班</option>
					</select></td>
				</tr>
				<tr>
					<td>班主任：</td>
					<td><input id="uId" class="easyui-combobox" name="uId"
						data-options="valueField:'uId',textField:'uName',url:'../findAllTeacher.do'" />
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remark" name="remark"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>


	<div id="edit-grade-dialog" class="easyui-dialog" title="修改用户信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-grade-form" method="post">
			<table>
				<tr>
					<td>班级名称：</td>
					<td><input id="gName" name="gName" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>班级类型：</td>
					<td><input id="classType" name="classType"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>开课时间：</td>
					<td><input id="startTime" name="startTime" type="text"
						class="easyui-datebox" required="required" /></td>
				</tr>
				<tr>
					<td>结课时间：</td>
					<td><input id="endTime" name="endTime" type="text"
						class="easyui-datebox" required="required" /></td>
				</tr>
				<tr>
					<td>班级状态：</td>
					<td><select id="state" class="easyui-combobox" name="state"
						style="width: 174px;" data-options="required:true">
							<option value="">--请选择--</option>
							<option>已开班</option>
							<option>未开班</option>
					</select></td>
				</tr>
				<tr>
					<td>班主任：</td>
					<td><input id="uId" class="easyui-combobox" name="uId"
						data-options="valueField:'uId',textField:'uName',url:'../findAllTeacher.do'" />
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remark" name="remark"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>



</body>
</html>