// JScript 文件
var InOutStore;

//alert("进入出入单查询");

SearchInOutOrder = function(node) {
	
	var pageSize = 12;
	// 指定列参数
	var InOutFields = ["id","style","OrderId","wareHouseName","productId","productName","costPrice","Quantity","MoneyAmount","Date"];
	InOutStore = new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url: "InOutStore.do",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : InOutFields,
							root : "data",
							id : "id",
							totalProperty : "totalCount"

						}),
				groupField : 'style',
				sortInfo : {
					field : 'productId',
					direction : "ASC"
				}
			});
	InOutStore.load({
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
				header : "类型",
				tooltip : "类型",
				dataIndex : "style",
				sortable : true,
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			}, {
				header : "单号",
				tooltip : "单号",
				dataIndex : "OrderId",
				sortable : true,
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			}, {
				header : "库房",
				tooltip : "库房",
				width : 80,
				dataIndex : "wareHouseName",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "商品代码",
				tooltip : "商品代码",
				width : 80,
				dataIndex : "productId",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "商品名称",
				tooltip : "商品名称",
				width : 80,
				dataIndex : "productName",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "成本价",
				tooltip : "成本价",
				width : 80,
				dataIndex : "costPrice",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "数量",
				tooltip : "数量",
				width : 80,
				dataIndex : "Quantity",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "金额",
				tooltip : "金额",
				width : 80,
				dataIndex : "MoneyAmount",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "日期",
				tooltip : "金额",
				width : 80,
				dataIndex : "Date",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}]);
	
	// ----------------------------------------------------定义grid
	var InOutOrderGrid = new Ext.grid.EditorGridPanel({
		id : "InOutOrderGrid",
		store : InOutStore,
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
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条出入单信息" : "暂无出入单信息"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : InOutStore,
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
		tbar : [new Ext.Toolbar.TextItem("<font color=red>开始日期</font>"),
				{
					name : "startTime",
					id : "time1",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "datefield",
					format: "Y-m-d",
					allowBlank : true
				},new Ext.Toolbar.TextItem("<font color=red>结束时间</font>"),
				{
					name : "endTime",
					id : "time2",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "datefield",
					format: "Y-m-d",
					allowBlank : true
				},new Ext.Toolbar.TextItem("<font color=red>商品名称</font>"),
				{
					name : "productName",
					id : "name3",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "textfield",
					allowBlank : true
				},{
					text : "查询",
					tooltip : "查询符合条件的库房",
					iconCls : "serchopenroomrecord",
					handler : function(){
						var tempTime1 = Ext.get("time1").dom.value;
						var tempTime2 = Ext.get("time2").dom.value;
						var tempName3 = Ext.get("name3").dom.value; 
						InOutStore.reload({
						params : {startTime:tempTime1,endTime:tempTime2,productName:tempName3}
						});
					}
				}]
	
	});
	GridMain(node, InOutOrderGrid, "roomicons");
}

