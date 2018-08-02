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
<script type="text/javascript" src="../jquery/ajaxfileupload.js"></script>
<script type="text/javascript">
	function appsNum(val) {
		var reg = /^\d\d{3,7}$/;
		return reg.test(val);
	}

	function test1(arg) {
		if (!appsNum(arg)) {
			$("#appSnum").innerText = "请正确输入4-8位数字";
		} else {
			$("#appSnum").innerText = "√";
		}
		return appsNum(arg);
	}

	$(function() {

		$("#btn-export").click(
				function() {
					var students = $('#dg').datagrid('getSelections');
					var sIds = [];
					for (var i = 0; i < students.length; i++) {
						sIds.push(students[i].sId);
					}
					var sName = $("#sName").val();
					var gName = $("#gName").combobox("getValue");
					var sex = $("#sex").combobox("getValue");
					location.assign("../exportStudentInfo.do?sName=" + sName
							+ "&gName=" + gName + "&sex=" + sex + "&sIds="
							+ sIds);
				})

		$("#btn-search").click(function() {
			$('#dg').datagrid('load', {
				sName : $("#sName").val(),
				sex : $("#sex").combobox("getValue"),
				gName : $("#gName").combobox("getValue")
			})
		})

		$("#btn-import")
				.click(
						function() {
							$("#import-dialog")
									.dialog(
											{
												closed : false,
												buttons : [
														{
															text : '导入',
															iconCls : 'icon-save',
															handler : function() {
																$
																		.ajaxFileUpload({
																			url : '../importStudentInfo.do',//用于文件上传的服务器端请求地址
																			fileElementId : 'stuinfo',//文件上传空间的id属性
																			dataType : "json",
																			success : function(
																					data) {
																				if (data == -1) {
																					$.messager
																							.alert(
																									'消息提示',
																									'导入失败！',
																									'error');
																				} else {
																					$.messager
																							.alert(
																									'消息提示',
																									'导入成功！',
																									'info',
																									function() {
																										$(
																												"#import-dialog")
																												.dialog(
																														{
																															closed : true
																														});
																										$(
																												'#dg')
																												.datagrid(
																														"reload");
																									});
																				}
																			}
																		});

															}
														},
														{
															text : '关闭',
															iconCls : 'icon-cancel',
															handler : function() {
																$(
																		"#import-dialog")
																		.dialog(
																				{
																					closed : true
																				});

															}
														} ]
											})
						})

		$("#btn-add")
				.click(
						function() {
							$("#add-student-dialog")
									.dialog(
											{
												closed : false,
												buttons : [ {
													text : '保存',
													handler : function() {
														$("#add-student-form")
																.form(
																		'submit',
																		{
																			url : "../addStudentInfo.do",
																			onSubmit : function() {
																				//$("#sNum").val()

																				if ($(
																						"#gradeIdAdd")
																						.combobox(
																								"getValue") == null
																						|| $(
																								"#gradeIdAdd")
																								.combobox(
																										"getValue") == '') {
																					$.messager
																							.alert(
																									'警告',
																									'请选择学生所在班级！',
																									'error');
																					return false;
																				} else {
																					if (!test1($(
																							"#sNumAdd")
																							.val())) {
																						$.messager
																								.alert(
																										'警告',
																										'请正确输入4-8位数字学号！',
																										"error");
																					}
																					return $(
																							"#add-student-form")
																							.form(
																									"validate")
																							&& test1($(
																									"#sNumAdd")
																									.val());
																				}
																			},
																			success : function(
																					flag) {
																				if (flag == 1) {
																					$(
																							"#add-student-dialog")
																							.dialog(
																									{
																										closed : true
																									});
																					$(
																							"#add-student-form")
																							.form(
																									"clear");
																					$(
																							'#dg')
																							.datagrid(
																									"reload");
																					$.messager
																							.show({
																								title : '我的消息',
																								msg : '操作成功！',
																								timeout : 5000,
																								showType : 'slide'
																							});
																				} else if (flag == 0) {
																					$.messager
																							.show({
																								title : '我的消息',
																								msg : '操作失败！',
																								timeout : 5000,
																								showType : 'slide'
																							});
																				} else if (flag == -1) {
																					$.messager
																							.show({
																								title : '我的消息',
																								msg : '学号不能重复！',
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
														var students = $('#dg')
																.datagrid(
																		'getSelections');
														var sIds = [];
														for (var i = 0; i < students.length; i++) {
															sIds
																	.push(students[i].sId);
														}
														$
																.post(
																		'../delStudentInfo.do',
																		{
																			'sIds[]' : sIds
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
								$.messager.alert('警告', '请选择要修改的用户', 'error');
							} else if ($('#dg').datagrid('getSelections').length > 1) {
								$.messager.alert('警告', '最多选择一个用户信息修改', 'error');
							} else {
								$('#edit-student-form').form(
										'load',
										'../getStudentInfoById.do?sId='
												+ $('#dg').datagrid(
														'getSelected').sId);
								$("#edit-student-dialog")
										.dialog(
												{
													closed : false,
													buttons : [ {
														text : '保存',
														handler : function() {
															$(
																	"#edit-student-form")
																	.form(
																			'submit',
																			{
																				url : "../editStudentInfo.do?sId="
																						+ $(
																								'#dg')
																								.datagrid(
																										'getSelected').sId,
																				onSubmit : function() {
																					if ($(
																							"#gradeIdEdit")
																							.combobox(
																									"getValue") == null
																							|| $(
																									"#gradeIdEdit")
																									.combobox(
																											"getValue") == '') {
																						$.messager
																								.alert(
																										'警告',
																										'请选择学生所在班级！',
																										'error');
																						return false;
																					} else {
																						if (!test1($(
																								"#sNumEdit")
																								.val())) {
																							$.messager
																									.alert(
																											'警告',
																											'请正确输入4-8位数字学号！',
																											"error");
																						}
																						return $(
																								"#edit-student-form")
																								.form(
																										"validate")
																								&& test1($(
																										"#sNumEdit")
																										.val());
																					}
																				},
																				success : function(
																						flag) {
																					if (flag == 1) {
																						$(
																								"#edit-student-dialog")
																								.dialog(
																										{
																											closed : true
																										});
																						$(
																								'#dg')
																								.datagrid(
																										"reload");
																						$(
																								"#edit-student-form")
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
																					} else if (flag == 0) {
																						$(
																								'#edit-student-form')
																								.form(
																										'load',
																										'../getStudentInfoById.do?sId='
																												+ $(
																														'#dg')
																														.datagrid(
																																'getSelected').sId);
																						$.messager
																								.show({
																									title : '我的消息',
																									msg : '操作失败',
																									timeout : 5000,
																									showType : 'slide'
																								});
																					} else if (flag == -1) {
																						$.messager
																								.alert(
																										'警告',
																										'学号不能重复！',
																										"error");
																					}
																				}
																			});
														}
													} ]
												});
							}
						});

		$('#dg').datagrid({
			url : '../findStudentWithPage.do',
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
				field : 'sId',
				title : '学生ID',
				width : 100,
				checkbox : true
			}, {
				field : 'sNum',
				title : '学号',
				width : 100,
			}, {
				field : 'sName',
				title : '学生姓名',
				width : 100
			}, {
				field : 'sex',
				title : '性别',
				width : 100,
			}, {
				field : 'idCard',
				title : '身份证号码',
				width : 100,
			}, {
				field : 'gName',
				title : '所在班级',
				width : 100,
			}, {
				field : 'sTel',
				title : '联系电话',
				width : 100,
			}, {
				field : 'school',
				title : '毕业学校',
				width : 100,
			}, {
				field : 'major',
				title : '所学专业',
				width : 100,
			}, {
				field : 'graduateTime',
				title : '毕业时间',
				width : 100,
			}, {
				field : 'eState',
				title : '就业状态',
				width : 100,
				formatter:function(val,rows,index){
					if(val=="已就业"){
						return "<span style='color: #D84C29'>已就业</span>";
					}else{
						return "未就业";
					}
				}
			}, {
				field : 'employmentDate',
				title : '就业日期',
				width : 100,
			}, {
				field : 'company',
				title : '就业企业',
				width : 100,
			}, {
				field : 'remark',
				title : '备注',
				width : 100,
			}, {
				field : 'uName',
				title : '添加人',
				width : 100,
			} ] ]
		});
	});
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">
		学生姓名：<input id="sName" class="easyui-validatebox" data-options="" />
		学生性别：<select id="sex" class="easyui-combobox" name="sex"
			style="width: 200px;">
			<option value=""></option>
			<option>男</option>
			<option>女</option>
		</select> 学生班级：<input id="gName" class="easyui-combobox" name="gName"
			data-options="valueField:'gName',textField:'gName',url:'../getAllGrade.do'" />
		<a id="btn-search" href="#" class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true">查询</a> <a
			id="btn-export" href="#" class="easyui-linkbutton"
			data-options="iconCls:'icon-print',plain:true">导出学生信息</a> <span
			style="font-size: 5px; color: #D84C29;">(若有选中的学生信息，以选中的学生信息为主进行导出)</span><br>
		<a id="btn-add" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-add'">增加学生信息</a> <a
			id="btn-edit" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-edit'">修改学生信息</a> <a
			id="btn-remove" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-remove'">删除学生信息</a> <a
			id="btn-import" href="#" class="easyui-linkbutton"
			data-options="plain:true,iconCls:'icon-man'">批量导入学生信息</a>
	</div>


	<div id="add-student-dialog" class="easyui-dialog" title="新增学生"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="add-student-form" method="post">
			<table>
				<tr>
					<td>学生学号：</td>
					<td><input id="sNumAdd" name="sNum" onblur="test1(this.value)"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>学生姓名：</td>
					<td><input id="sNameAdd" name="sName"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>

				<tr>
					<td>联系电话：</td>
					<td><input id="sTelAdd" name="sTel" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><input type="radio" checked="checked" name="sex" value="男" />男
						<input type="radio" name="sex" value="女" />女</td>
				</tr>
				<tr>
					<td>身份证号码：</td>
					<td><input id="idCardAdd" name="idCard"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>所在班级：</td>
					<td><input id="gradeIdAdd" name="gradeId"
						class="easyui-combobox"
						data-options="editable:false,valueField:'gradeId',textField:'gName',url:'../getGradeList.do'" />
					</td>
				</tr>
				<tr>
					<td>毕业学校：</td>
					<td><input id="schoolAdd" name="school"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>所学专业：</td>
					<td><input id="majorAdd" name="major"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>毕业时间：</td>
					<td><input id="graduateTimeAdd" name="graduateTime"
						type="text" class="easyui-datebox" required="required"></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remarkAdd" name="remark"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="import-dialog" class="easyui-dialog" title="导入学生信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true,closable:false">
		<form method="post" id="import-form" enctype="multipart/form-data">
			<input type="file" name="stuinfo" id="stuinfo">
		</form>
	</div>

	<div id="edit-student-dialog" class="easyui-dialog" title="修改学生信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-student-form" method="post">
			<table>
				<tr>
					<td>学生学号：</td>
					<td><input id="sNumEdit" name="sNum"
						class="easyui-validatebox" onblur="test1(this.value)"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<td>学生姓名：</td>
					<td><input id="sName1Edit" name="sName"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>

				<tr>
					<td>联系电话：</td>
					<td><input id="sTelEdit" name="sTel"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><input type="radio" checked="checked" name="sex" value="男" />男
						<input type="radio" name="sex" value="女" />女</td>
				</tr>
				<tr>
					<td>身份证号码：</td>
					<td><input id="idCardEdit" name="idCard"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>所在班级：</td>
					<td><input id="gradeIdEdit" name="gradeId"
						class="easyui-combobox"
						data-options="editable:false,valueField:'gradeId',textField:'gName',url:'../getGradeList.do'" />
					</td>
				</tr>
				<tr>
					<td>毕业学校：</td>
					<td><input id="schoolEdit" name="school"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>所学专业：</td>
					<td><input id="majorEdit" name="major"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<td>毕业时间：</td>
					<td><input id="graduateTimeEdit" name="graduateTime"
						type="text" class="easyui-datebox" required="required"></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input id="remarkEdit" name="remark"
						class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>



</body>
</html>