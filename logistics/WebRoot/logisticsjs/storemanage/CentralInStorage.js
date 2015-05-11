/**
 * 作者 ： 李亚方 日期 ：2011年7月15日
 * 
 */
var PurchaseProductOrderItemStore;
CentralInStorage = function(node) {

	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数
	var PurchaseProductOrderItemFields = ["purchaseProductOrderItemId", "productId","productName",
			"productQuantity", "realIntoQuantity", "purchaseProductOrderId","purchaseProductInStorageOrderId",'productPurchaseState'];
	PurchaseProductOrderItemStore = new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url: "PurchaseProductOrderItemStore.do?actionType=doSearch",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : PurchaseProductOrderItemFields,
							root : "data",
							id : "purchaseProductOrderItemId",
							totalProperty : "totalCount"
						}),
				groupField : 'productPurchaseState',
				sortInfo : {
					field : 'productPurchaseState',
					direction : "ASC"
				}
			});
	PurchaseProductOrderItemStore.load();

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "purchaseProductOrderItemId"
			});
	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([{
				header : "所属的购货入库单ID",
				dataIndex : "purchaseProductInStorageOrderId",
				tooltip : "所属的购货入库单ID",
				width : 80,
				sortable : true,
				renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
			}, {
				header : "购货单条目ID",
				dataIndex : "purchaseProductOrderItemId",
				tooltip : "购货入库单条目ID",
				width : 80,
				// 列不可操作
				// menuDisabled:true,
				// 可以进行排序
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "订购的商品ID",
				dataIndex : "productId",
				tooltip : "产品的名称",
				width : 80,
				// 列不可操作
				// menuDisabled:true,
				// 可以进行排序
				sortable : true,
				renderer : function(val) {
					return '<b><font color=green>' + val + '</font></b>';
				}
			}, {
				header : "订购的商品名称",
				dataIndex : "productName",
				tooltip : "产品的名称",
				width : 80,
				sortable : true,
				renderer : function(val) {
					return '<b><font color=purple>' + val + '</font></b>';
				}
			}, {
				header : "订购数量",
				tooltip : "订购数量",
				width : 80,
				dataIndex : "productQuantity",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "实际到货的数量",
				tooltip : "产品实际数量",
				width : 80,
				dataIndex : "realIntoQuantity",
				sortable : true,
				editor : new Ext.form.NumberField({
							style : 'text-align:left'
						}),
				renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
			},{
				header : "购货入库单的状态",
				dataIndex : "productPurchaseState",
				tooltip : "购货入库单的状态",
				width : 80,
				sortable : true,
				renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
			}]);

	// ----------------------------------------------------定义grid
	var CentralInStorageGrid = new Ext.grid.EditorGridPanel({
		id : "CentralInStorageGrid",
		store : PurchaseProductOrderItemStore,
		//sm : sm,
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
            hideGroupedColumn:true,
			showGroupsText : '是否采用分组显示',
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条记录" : "暂无记录"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : PurchaseProductOrderItemStore,
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
		tbar : [new Ext.Toolbar.TextItem("<font color=blue>请输入购货单号</font>"), {
					name : "purchaseProductOrderId",
					id : "purchaseProductOrderId",
					xtype : "textfield",
					editable : true,
					allowBlank : true
				}, "", "-", {
					text : "查询",
					// 默认样式为按下
					// pressed:true,
					tooltip : "查询",
					iconCls : "serchopenroomrecord",
					handler : function(){
						var tempID = Ext.get("purchaseProductOrderId").dom.value;
						//alert("purchaseProductOrderId="+tempID);
						PurchaseProductOrderItemStore.reload({
						params : {purchaseProductOrderId:tempID}
						});
					}
				}, "", "-", {
					text : "刷新信息",
					// 默认样式为按下
					// pressed:true,
					tooltip : "刷新当前页面信息",
					iconCls : "refreshicon",
					handler : function() {
						PurchaseProductOrderItemStore.reload();
					}
				}, "", "-", {
					text : "入库",
					tooltip : "填写入库信息",
					iconCls : "addicon",
					handler : function(e){
						var tempID = Ext.get("purchaseProductOrderId").dom.value;
						//var state = e.record.data.productPurchaseState;
						//alert("state"+state);
						WriteStoreInfo(tempID);
					}
				}, "", "-", "",
				new Ext.Toolbar.TextItem("<font color=blue>双击实际到货数量进行修改</font>")],
			listeners : {
			'contextmenu' : function(e) {
				e.stopEvent();
			},
			"afteredit" : function(e) {
				var g = e.grid;// 得到当前grid
				var r = e.record;// 得到当前行所有数据
				var f = e.field;// 得到修改列
				var v = e.value;// 得到修改列修改后值
				var orgin = e.originalValue;// 修改列修改前值
				var row = e.row;// 当前行索引
				var col = e.column;// 当前点击的列索引
				// alert("ID："+r.data.id+"-field:"+f+"-value:"+v+"-修改前值："+orgin+"-坐标:"+row+","+col);
				// 通过ajax请求修改数据
					Ext.Ajax.request({
								url: "PurchaseProductOrderItemStore.do?actionType=doUpdate",
								method : "POST",
								params : {
									field : f,
									quantity : r.data.realIntoQuantity,
									id: r.data.purchaseProductOrderItemId
								},
								success : function(response, option) {
									var responseArray = Ext.util.JSON
											.decode(response.responseText);
									var flag = responseArray.success;
									if (flag) {
										Ext.Msg.alert("恭喜您", "成功更新实际到货数量");
										PurchaseProductOrderItemStore.reload();
									} else {
										Ext.Msg.alert("对不起", responseArray.msg);
									}
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
								}
							});
				
			},
			"rowcontextmenu" : function(grid, rowIndex, e) {
				e.stopEvent();
				RoomRightClick.showAt(e.getXY());
			}
		}
	});
	GridMain(node, CentralInStorageGrid, "roomicons");
}
