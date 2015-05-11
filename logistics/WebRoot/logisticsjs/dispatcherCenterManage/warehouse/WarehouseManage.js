// JScript 文件
var WareHouseStore;
var ManageStore;

//alert("进入库房设置");

WarehouseManage = function(node) { 
	ManageFields = Ext.data.Record.create([{
				name : 'userId',
				mapping : 'userId'
			}, {
				name : 'Username',
				mapping : 'Username'
			}]);
	ManageStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url: "ManageStore.do",
							method:'post'
						}),
				reader : new Ext.data.JsonReader({
							root : 'data',
							id : 'userId'
						}, ManageFields),
				sortInfo : {
					field : 'userId',
					direction : "ASC"
				}
			});
	ManageStore.load(); 
	var pageSize = 12;
	// 指定列参数
	var WareHouseFields = ["warehouseId", "warehouseName", "warehouseAddress", "warehouseType",
			"warehouseManager"];

	WareHouseStore = new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url: "WareHouseStore.do",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : WareHouseFields,
							root : "data",
							id : "warehouseId",
							totalProperty : "totalCount"

						}),
				groupField : 'warehouseManager',
				sortInfo : {
					field : 'warehouseId',
					direction : "ASC"
				}
			});
	WareHouseStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "warehouseId"
			});
	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([sm, {
				header : "库房ID",
				dataIndex : "warehouseId",
				tooltip : "库房ID",
				width : 80,
				sortable : true
			}, {
				header : "库房名称",
				tooltip : "库房名称",
				dataIndex : "warehouseName", 
				editor :new Ext.form.TextField(),
				sortable : true
			}, {
				header : "库房地址",
				tooltip : "库房地址",
				dataIndex : "warehouseAddress",
				sortable : true,
				editor :new Ext.form.TextField(),
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			}, {
				header : "库房类型",
				tooltip : "库房类型",
				dataIndex : "warehouseType",
				sortable : true,
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			}, {
				header : "库房管理员",
				tooltip : "库房管理员",
				width : 80,
				dataIndex : "warehouseManager",
				sortable : true,
				renderer : function(value, meta, record, rowIndex, colIndex,
						store) {
					if (value < 1) {
						return "暂无数据";
					} else {
						return "<b><font color=#008B8B>"
								+ /*ManageStore.getAt(value).data.Username*/value
								+ "</font></b>";
					}
				},
				editor : new Ext.form.ComboBox({
					store : ManageStore,
					typeAhead : true,
					forceSelection : true,
					triggerAction : 'all',
					selectOnFocus : true,
					width : 130,
					value : "userId",
					editable : false,
					displayField : 'Username',
					valueField : 'userId',
					mode : 'remote'
				})
			}]);
	// ----------------------------------------------------定义grid
	var WareHouseManageGrid = new Ext.grid.EditorGridPanel({
		id : "WareHouseManageGrid",
		store : WareHouseStore,
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
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条库房信息" : "暂无库房信息"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : WareHouseStore,
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
		tbar : [
				new Ext.Toolbar.TextItem("<font color=red>输入库房地址直接查询</font>"),
				{
					name : "SearchByAddress",
					id : "SearchByAddress",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "textfield",
					allowBlank : true
				}, {
					text : "查询",
					tooltip : "查询符合条件的库房",
					iconCls : "serchopenroomrecord",
					handler : GetWareHouseWanted
				}, "", "-", new Ext.Toolbar.Fill(),{
					text : "添加库房",
					tooltip : "添加库房",
					iconCls : "addicon",
					handler : AddWareHouseInfo
				}, "", "-", "", {
					text : "删除库房",
					tooltip : "删除库房",
					iconCls : "deleteicon",
					handler : DelWareHouseInfo
				}, "-"],
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
								url : "warehouse.do?actionType=edit",
								method : "POST",
								params : {
									field : f,
									value : v,
									warehouseId : r.data.warehouseId
								},
								success : function(response, option) {
									var responseArray = Ext.util.JSON
											.decode(response.responseText);
									var flag = responseArray.success;
									if (flag) {
										Ext.Msg.alert("恭喜您", "更新成功");
										WareHouseStore.reload();
									} else {
										Ext.Msg.alert("对不起", responseArray.msg);
									}
									//WareHouseStore.reload();
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
									WareHouseStore.reload();
								}
							});
			},
			"rowcontextmenu" : function(grid, rowIndex, e) {
				e.stopEvent();
				RoomRightClick.showAt(e.getXY());
			}
		}
	});
	GridMain(node, WareHouseManageGrid, "roomicons");
}

function GetWareHouseWanted() { 
	var address = Ext.get("SearchByAddress").dom.value;
	WareHouseStore.reload({
				params : {
					start : 0,
					limit : 12,
					SearchByAddress : address
				}
			});
}
// /--------------------------添加房间信息
AddWareHouseInfo = function() {
	AddWareHouse();
}

// ----------------------删除房间信息 test
DelWareHouseInfo = function() {
	var row = Ext.getCmp("WareHouseManageGrid").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else {
		Ext.Msg.confirm("提示!", "您确定要删除房间信息吗?", function(btn) {
					if (btn == "yes") {
						DelWareHouseInfos(row);
					} else {

					}
				})
	}

}

DelWareHouseInfos = function(row) {
	var deletesplit = "";
	for (var i = 0; i < row.length; i++) {
		if (row.length == 1) {
			deletesplit = row[i].data.warehouseId;
		} else {

			if (i < (row.length - 1)) {
				deletesplit = row[i].data.warehouseId + "," + deletesplit;
			}
			if (i == (row.length - 1)) {
				deletesplit = deletesplit + row[i].data.warehouseId;
			}
		}
	}
	Ext.Ajax.request({
				url : "warehouse.do?actionType=delete",
				method : "POST",
				params : {
					warehouseIds : deletesplit
				},
				success : function() {
					/*var responseArray = Ext.util.JSON
							.decode(response.responseText);*/
					//var flag = responseArray.success;
					/*if (flag) {*/
						Ext.Msg.alert("恭喜您", "成功删除库房");
						WareHouseStore.reload();
					/*} else {
						Ext.Msg.alert("对不起", responseArray.msg);
					}*/
					//WareHouseStore.reload();
				},
				failure : function() {
					/*var responseArray = Ext.util.JSON
							.decode(response.responseText);
					*/
					Ext.Msg.alert("提 示", "删除失败了!");
					//WareHouseStore.reload();
				}
			});
}