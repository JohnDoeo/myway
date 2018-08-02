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
<script type="text/javascript" src="../jquery/datagrid-cellediting.js"></script>
<script type="text/javascript">


	$(function() {
		
		$("#btn-search").click(function(){
			$('#dg').datagrid('load',{
				sName:$("#sName").val(),
				sex:$("#sex").combobox("getValue"),
				gName:$("#gName").combobox("getValue"),
				eState:$("#eState").combobox("getValue")
			})
		})
		
		$("#btn-edit").click(function(){
			
			if($('#dg').datagrid('getSelections').length==0){
				$.messager.alert('警告','请选择要修改的用户','error');  
			} else if($('#dg').datagrid('getSelections').length>1){
				$.messager.alert('警告','最多选择一个用户信息修改','error');
			} else {
				$('#edit-student-form').form('load','../getStudentInfoById.do?sId='+$('#dg').datagrid('getSelected').sId);
				$("#edit-student-dialog").dialog({
					closed:false,
					buttons:[{
						text:'保存',
						handler:function(){
							$("#edit-student-form").form('submit',{
								url:"../editStudentInfo.do?sId="+$('#dg').datagrid('getSelected').sId,
								onSubmit:function(){
									if($("#eState").val()==null || $("#eState").val()==''){
										$.messager.alert('警告','请选择就业状态！','error');
										return false;
									}else{
										return $("#edit-student-form").form("validate");	
									}
								},
								success:function(flag){
									if(flag){
										$("#edit-student-dialog").dialog({closed:true});
										$('#dg').datagrid("reload");
										$("#edit-student-form").form("clear");
										$('#dg').datagrid("unselectAll");
										$.messager.show({
											title:'我的消息',
											msg:'操作成功',
											timeout:5000,
											showType:'slide'
										});
									}else{
										$('#edit-student-form').form('load','../getStudentInfoById.do?sId='+$('#dg').datagrid('getSelected').sId);
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
				field : 'sName',
				title : '学生姓名',
				width : 100
			},{
				field : 'sex',
				title : '性别',
				width : 100,
			}, {
				field : 'idCard',
				title : '身份证号码',
				width : 100,
			}, {
				field : 'sNum',
				title : '学号',
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
			}, {
				field : 'employmentDate',
				title : '就业日期',
				width : 100,
			}, {
				field : 'company',
				title : '就业企业',
				width : 100,
			} , {
				field : 'remark',
				title : '备注',
				width : 100,
			}, {
				field : 'uName',
				title : '添加人',
				width : 100,
			}] ]
		});
	});
	
</script>
</head>
<body>
	<div id="dg"></div>
	<div id="tb">
		学生姓名：<input id="sName" class="easyui-validatebox" /> 
		学生性别：<select id="sex" class="easyui-combobox" name="sex"
				style="width: 200px;">
				<option value=""></option>
				<option>男</option>
				<option>女</option>
			</select> 
			就业状态：<select id="eState" class="easyui-combobox" name="eState"
				style="width: 200px;">
				<option value=""></option>
				<option>已就业</option>
				<option>未就业</option>
			</select> 
		学生班级：<input id="gName" class="easyui-combobox" name="gName"   
 				   data-options="valueField:'gName',textField:'gName',url:'../getAllGrade.do'" />
		<a id="btn-search" href="#" class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true">查询</a> <br>  
		<a id="btn-edit" href="#" class="easyui-linkbutton" 
			data-options="plain:true,iconCls:'icon-edit'">修改学生就业信息</a>
			
	</div>
	
	<div id="edit-student-dialog" class="easyui-dialog" title="修改学生信息"
		style="width: auto; height: auto;"
		data-options="modal:true,closed:true">
		<form id="edit-student-form" method="post">
		<table>
				<tr>
					<td>就业状态：</td>
					<td><select id="eState" name="eState" size="1px">
							<option value="" selected="selected">--请选择--</option>
							<option value="已就业">已就业</option>
							<option value="未就业">未就业</option>
						</select></td>
				</tr>
				<tr>
					<td>就业时间：</td>
					<td><input  id="employmentDate" name="employmentDate" type="text" 
						class="easyui-datebox" ></td>
				</tr>
				<tr>
					<td>就业企业(公司)：</td>
					<td><input id="company" name="company" class="easyui-validatebox"/></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>