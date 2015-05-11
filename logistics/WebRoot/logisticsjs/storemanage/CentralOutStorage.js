/**
 * 作者 ： 李亚方 日期 ：2011年7月15日
 * 
 */
var AllocationOrderStore;
CentralOutStorage = function(node) {

	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数
	var AllocationOrderFields = ["allocationOrder", "order","RequiredDate","warehouse","substation",
			"allocationDate", "operator", "allocationState"];
	AllocationOrderStore = new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url: "AllocationOrderStore.do?actionType=doSearch",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : AllocationOrderFields,
							root : "data",
							id : "allocationOrder",
							totalProperty : "totalCount"
						}),
				groupField : 'allocationState',
				sortInfo : {
					field : 'allocationDate',
					direction : "ASC"
				}
			});
	AllocationOrderStore.load();

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "allocationOrder"
			});
	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([sm, {
				header : "调拨单编号",
				dataIndex : "allocationOrder",
				tooltip : "调拨单编号",
				width : 80,
				// 列不可操作
				// menuDisabled:true,
				// 可以进行排序
				sortable : true,
				renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
			}, {
				header : "订单编号",
				dataIndex : "order",
				tooltip : "订单编号",
				width : 80,
				// 列不可操作
				// menuDisabled:true,
				// 可以进行排序
				sortable : true,
				renderer : function(val) {
					return '<b><font color=green>' + val + '</font></b>';
				}
			}, {
				header : "订单要求完成的日期",
				tooltip : "订单要求完成的日期",
				width : 110,
				dataIndex : "RequiredDate",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
			}, {
				header : "分站地址",
				tooltip : "分站地址",
				width : 80,
				dataIndex : "substation",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "分库名称",
				tooltip : "分库名称",
				width : 80,
				dataIndex : "warehouse",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "操作员",
				tooltip : "操作员",
				width : 80,
				dataIndex : "operator",
				sortable : true,
				renderer : function(val) {
					return '<b><font color=grey>' + val + '</font></b>';
				}
			},{
				header : "调拨单执行状态",
				dataIndex : "allocationState",
				tooltip : "调拨单执行状态",
				width : 80,
				sortable : true,
				renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
			}]);

	// ----------------------------------------------------定义grid
	var OutStorageGrid = new Ext.grid.EditorGridPanel({
		id : "OutStorageGrid",
		store : AllocationOrderStore,
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
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条记录" : "暂无记录"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : AllocationOrderStore,
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
		tbar : [new Ext.Toolbar.TextItem("<font color=blue>请输入要求完成日期的调拨单号</font>"), {
					name : "RequiredDate",
					id : "RequiredDate",
					xtype : "datefield",
					format : "Y-m-d",
					editable : true,
					allowBlank : true
				}, "", "-", {
					text : "查询",
					// 默认样式为按下
					// pressed:true,
					tooltip : "查询",
					iconCls : "serchopenroomrecord",
					handler : function(){
						var tempDate = Ext.get("RequiredDate").dom.value;
						AllocationOrderStore.reload({
						params : {RequiredDate:tempDate}
						});
					}
				}, "", "-", "",{
					text :"订单详情",
					tooltip : "查看订单详情",
					iconCls : "addicon",
					handler: OrderDetail
				}, "", "-", "",{
					text :"调拨详情",
					tooltip : "选择查看调拨详情",
					iconCls : "addicon",
					handler: deliverStationDetail
				}, "", "-", {
					text : "调拨出库",
					tooltip : "出库",
					iconCls : "addicon",
					handler : GetAllocationOrder
				}],
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
								//url : "servlet/UpdateRoom",
								method : "POST",
								params : {
									field : f,
									value : v,
									roomid : r.data.roomId
								},
								success : function(response, option) {
									var responseArray = Ext.util.JSON
											.decode(response.responseText);
									var flag = responseArray.success;
									if (flag) {
										Ext.Msg.alert("恭喜您", "更新成功");
									} else {
										Ext.Msg.alert("对不起", responseArray.msg);
									}
									AllocationOrderStore.reload();
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
									AllocationOrderStore.reload();
								}
							});
				
			},
			"rowcontextmenu" : function(grid, rowIndex, e) {
				e.stopEvent();
				RoomRightClick.showAt(e.getXY());
			}
		}
	});
	GridMain(node, OutStorageGrid, "roomicons");
}
GetAllocationOrder = function() {
	var row = Ext.getCmp("OutStorageGrid").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else {
		StartAllocation(row);
	}
}
StartAllocation = function(row) {
	var ids = "";
	var flag = true;
	for (var i = 0; i < row.length; i++) {
	    if(row[i].data.allocationState=='已调拨'){
	      flag = false;
	    }
		if (row.length == 1) {
			ids = row[i].data.allocationOrder;
		} else {

			if (i < (row.length - 1)) {
				ids = row[i].data.allocationOrder + "," + ids;
			}
			if (i == (row.length - 1)) {
				ids = ids + row[i].data.allocationOrder;
			}
		}
	}
	
	if(flag){
		Ext.Ajax.request({
				url: "AllocationOrderStore.do?actionType=saveAllocation",
				method : "POST",
				params : {
					allocationOrders : ids
				},
				success : function(response, option) {
					Ext.Msg.alert("恭喜您", "调拨单："+ids+",调拨出库成功");
					AllocationOrderStore.reload();
				},
				failure : function(response, option) {
					Ext.Msg.alert("系统错误", responseArray.msg);
					AllocationOrderStore.reload();
				}
				
			});
	}else{
			Ext.Msg.alert("提示信息", "调拨单已经调拨出库,不能对其再次进行调拨出库!");
	}
}
deliverStationDetail = function(){
	//alert("查询订单详细信息");
	//OrderDetailInfo();
	var row = Ext.getCmp("OutStorageGrid").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else {
		showDetail(row);
	}
}


OrderDetail = function(){
	//alert("查询订单详细信息");
	//OrderDetailInfo();
	var row = Ext.getCmp("OutStorageGrid").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else {
		OrderDetailInfo(row[0].data.order);
	}
}