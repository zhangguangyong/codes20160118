$(function(){
	var _entityProperties;
	var $entityCombobox = $('#entityCombobox');
	var $conditionGrid = $('#conditionGrid');
	
	var dataTypes = [{'value':'Byte','text':'字节型'}, {'value':'Short','text':'短整型'}, {'value':'Integer','text':'整型'}, {'value':'Float','text':'单精度浮点型'}, {'value':'Double','text':'双精度浮点型'}, {'value':'Array','text':'数组类型'}];
	
	// 条件操作表达式
	var expressionData = [
		{text: '等于', value: 'eq'},
		{text: '等于列', value: 'eqProperty'},
		// {text: '等于或为空', value: 'eqOrIsNull'},
		
		{text: '不等于', value: 'ne'},
		{text: '不等于列', value: 'neProperty'},
		// {text: '不等于或非空', value: 'neOrIsNotNull'},
		
		{text: '大于', value: 'gt'},
		{text: '大于列', value: 'gtProperty'},
		
		{text: '大于等于', value: 'ge'},
		{text: '大于等于列', value: 'geProperty'},
		
		{text: '小于', value: 'lt'},
		{text: '小于列', value: 'ltProperty'},
		
		{text: '小于等于', value: 'le'},
		{text: '小于等于列', value: 'leProperty'},
		
		{text: '属于', value: 'in'},
		{text: '不属于', value: 'nin'},
		{text: '介于', value: 'between'},
		{text: '不介于', value: 'nbetween'},
		
		/*
		{text: '为空字符', value: 'isEmpty'},
		{text: '为非空字符', value: 'isNotEmpty'},
		*/
		{text: '为空', value: 'isNull'},
		{text: '为非空', value: 'isNotNull'},
		
		// 不区分大小写匹配
		{text: '匹配', value: 'ilike'},
		{text: '包含', value: 'ailike'},
		{text: '前包含', value: 'silike'},
		{text: '后包含', value: 'eilike'},
		{text: '不匹配', value: 'nilike'},
		{text: '不包含', value: 'nailike'},
		{text: '前不包含', value: 'nsilike'},
		{text: '后不包含', value: 'neilike'}
		// 分区大小写匹配
		/*
		{text: '_匹配', value: 'like'},
		{text: '_包含', value: 'alike'},
		{text: '_前包含', value: 'slike'},
		{text: '_后包含', value: 'elike'},
		{text: '_不匹配', value: 'nlike'},
		{text: '_不包含', value: 'nalike'},
		{text: '_前不包含', value: 'nslike'},
		{text: '_后不包含', value: 'nelike'}
		*/		
	];
	
	var joinTypeData = [
		{text: '并且', value: 'and'},
		{text: '或者', value: 'or'}
	];

	var groupNoData = [
		{text: '1', value: '1'},
		{text: '2', value: '2'},
		{text: '3', value: '3'}
	];
	
	/**
	 * 初始化实体条件
	 */
	function initEntityCondition(entityName){
		$.util.ajax({
			url: WEB_ROOT + '/system/SearchCondition/doList',
			success: function(result){
				// TODO 列表展示
			}
		});
	}
	
	/**
	 * 初始化实体名称下拉框
	 */
	function initEntityCombbox(){
		$entityCombobox.combobox({
			editable: false,
			width: 400,
			height: 25,
			url: WEB_ROOT + '/system/SearchCondition/getEntityNameMap',
			onSelect: function(record){
				var entityName = $(this).combobox('getValue');
				// 根据EntityName 获取Entity相关属性
				getEntityProperty(entityName);
			}
		});
	}
	
	/**
	 * 初始化属性表格
	 */
	function initConditionGrid(entityName){
		var gridData;
		//获取实体数据
		$.util.sjax({
			url: WEB_ROOT + '/system/SearchCondition/getEntityCondition?entityName='+entityName,
			success: function(result){
				if( result ){
					gridData = $.util.toJsonObject( result['properties'] );
				}
			}
		});
		
		$conditionGrid.edatagrid({
			toolbar:[{
				iconCls: 'icon-add',
				text: '新增',
				handler: function(){
					buttonActionHandler(this, 'add');
				}
			},{
				iconCls: 'icon-save',
				text: '保存',
				handler: function(){
					buttonActionHandler(this, 'save');
				}
			},{
				iconCls: 'icon-back',
				text: '取消编辑',
				handler: function(){
					buttonActionHandler(this, 'cancel');
				}
			},{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function(){
					buttonActionHandler(this, 'destroy');
				}
			}],
			columns: [[
				// 属性名
				{field: 'Condition', title: '属性名称', width: '20%', editor : {
					type:'combobox',
					options:{
						data: _entityProperties,
						editable: false,
						required:true
					}
				}},
				// 操作符
				{field: 'expressions', title: '操作符', width: '40%', editor : {
					type:'combobox',
					options:{
						data: expressionData,
						multiple:true,
						editable: false,
						required:true
					}
				}},
				// 连接类型
				{field: 'joinType', title: '连接类型', width: 80, editor : {
					type:'combobox',
					options:{
						data: joinTypeData,
						editable: false,
						required:true
					}
				}},
				// 分组号
				{field: 'groupNo', title: '分组号', width: 80, editor : {
					type:'combobox',
					options:{
						data: groupNoData,
						required:true
					}
				}},
				// 分组连接类型
				{field: 'groupJoinType', title: '分组连接类型', width: 100, editor : {
					type:'combobox',
					options:{
						data: joinTypeData,
						editable: false,
						required:true
					}
				}}
			]]
		});
		
		if( gridData ){
			$conditionGrid.datagrid('loadData', gridData);
		}
	}
	
	/**
	 * 获取实体的属性
	 */
	function getEntityProperty(entityName){
		$.util.ajax({
			url: WEB_ROOT + '/system/SearchCondition/getEntityProperty?entityName='+entityName,
			success: function(result){
				_entityProperties = result;
				initConditionGrid(entityName);
			}
		});
	}
	
	/**
	 * 按钮动作处理
	 */
	function buttonActionHandler(target, action){
		var $dg = $(target).closest('.datagrid-toolbar').next('.datagrid-view').children('table:hidden');
		switch(action){
			case 'add': $dg.edatagrid('addRow'); break; 
			case 'save': $dg.edatagrid('saveRow'); break;
			case 'cancel': $dg.edatagrid('cancelRow'); break;
			case 'destroy': $dg.edatagrid('destroyRow'); break;
		}
	}
	
	// 保存实体设置搜索条件
	$('#buttonSave').click(function(){
		var properties = getJsonData($conditionGrid);
		console.info( properties );
		searchCondition = {};
		searchCondition['properties'] = properties; 
		searchCondition['entityName'] = getEntityName; 
		$.util.ajax({
			url: WEB_ROOT + '/system/SearchCondition/saveEntityCondition',
			data: searchCondition, 
			success: function(result){
				console.info( result );
			}
		});
	});
	
	function init(){
		initEntityCombbox();
	}
	
	init();
	
	// 辅助借口 -----------------------------------
	function getJsonData(datagrid){
		var rows = datagrid.datagrid('getRows');
		if( rows.length > 0 ){
			return $.toJSON( rows );
		}
		return '';
	}
	
	function getEntityName(){
		return $entityCombobox.combobox('getValue');
	}
	
});



