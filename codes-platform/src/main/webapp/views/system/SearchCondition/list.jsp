<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../resources/inc/easyui.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>搜索条件-列表</title>
</head>
<body>
	
	<div class="easyui-layout" style="width: 100%; height: 100%;" >
		<div data-options="region:'north',title:'选择实体',split:true"
			style="height: 100px;">
			<!-- 预备条件 -->
			<div style="margin: 5px;" >
				<!-- 实体选择 -->
				<label>请选择实体：</label>
				<select class="easyui-combobox" id="entityCombobox" name="entityName" ></select>
				<!-- 保存按钮 -->
				<a id="buttonSave" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
			</div>
		</div>
		<div data-options="region:'center',title:''"
			style="background: #eee;">
			<!-- 选中实体对应的条件 -->
			<table id="conditionGrid" title="实体条件列表" ></table>
		</div>
	</div>
	

	<script type="text/javascript"
		src="${ctx}/views/system/SearchCondition/js/list.js"></script>
</body>
</html>