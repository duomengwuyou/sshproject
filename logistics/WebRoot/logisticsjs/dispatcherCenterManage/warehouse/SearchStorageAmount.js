// JScript 文件

var StorageStore;
//alert("进入库存量查询");

var RemainStorage;

SearchStorageAmount = function(node) {
	
	var pageSize = 12;
	// 指定列参数
	var RemainStorageFields = ["id","warehouseName","productName","totalQuantity","returnQuantity","allocateQuantity","alreadyAllocateQuantity"];
	RemainStorage = new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url: "RemainStorage.do",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : RemainStorageFields,
							root : "data",
							id : "id",
							totalProperty : "totalCount"
						}),
				groupField : 'productName',
				sortInfo : {
					field : 'totalQuantity',
					direction : "ASC"
				}
			});
	RemainStorage.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "id"
			});
	// --------------------------------------------------列头

	var cm = new Ext.grid.ColumnModel([sm, {
				header : "查询结果ID",
				dataIndex : "id",
				tooltip : "查询结果ID",
				width : 80,
				sortable : true
			}, {
				header : "库房名称",
				tooltip : "库房名称",
				dataIndex : "warehouseName",
				sortable : true,
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			}, {
				header : "商品名称",
				tooltip : "商品名称",
				dataIndex : "productName",
				sortable : true,
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			}, {
				header : "总库存量",
				tooltip : "总库存量",
				width : 80,
				dataIndex : "totalQuantity",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "退回数量",
				tooltip : "退回数量",
				width : 80,
				dataIndex : "returnQuantity",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "已分配量",
				tooltip : "已分配量",
				width : 80,
				dataIndex : "allocateQuantity",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "可分配量",
				tooltip : "可分配量",
				width : 80,
				dataIndex : "alreadyAllocateQuantity",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}]);
	
	// ----------------------------------------------------定义grid
	var SearchStorageGrid = new Ext.grid.EditorGridPanel({
		id : "SearchStorageGrid",
		store : RemainStorage,
		sm : sm,
		cm : cm,
		loadMask : true,
		stripeRows : true,
		clicksToEdit : 2,
		// autoExpandColumn:7,
		// 超过长度带自动滚动条
		autoScroll : true,
		border : false,
		view : new Ext.grid.GroupingView({
			// 自动填充
			forceFit : true,
			sortAscText : '正序排列',
			sortDescText : '倒序排列',
			columnsText : '列显示/隐藏',
			groupByText : '根据本列分组',
			showGroupsText : '是否采用分组显示',
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条库存信息" : "暂无库存信息"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : RemainStorage,
					pageSize : pageSize,
					// 显示右下角信息
					displayInfo : true,
					displayMsg : '当前记录 {0} -- {1} 条 共 {2} 条记录',
					emptyMsg : "No results to display",
					prevText : "上一页",
					nextText : "下一页",
					refreshText : "刷新",
					lastText : "最后页",
					firstText : "第一页",
					beforePageText : "当前页",
					afterPageText : "共{0}页"
				}),
		tbar : [new Ext.Toolbar.TextItem("<font color=red>商品名称</font>"),
				{
					name : "productName",
					id : "name1",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "textfield",
					allowBlank : true
				},new Ext.Toolbar.TextItem("<font color=red>库房名称</font>"),
				{
					name : "warehouseName",
					id : "name2",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "textfield",
					allowBlank : true
				},{
					text : "查询",
					tooltip : "查询符合条件的库房",
					iconCls : "serchopenroomrecord",
					handler : function(){
						var tempName1 = Ext.get("name1").dom.value;
						var tempName2 = Ext.get("name2").dom.value; 
						RemainStorage.reload({
						params : {productName:tempName1,warehouseName:tempName2}
						});
					}
				}]
	
	});
	GridMain(node, SearchStorageGrid, "roomicons");
}

