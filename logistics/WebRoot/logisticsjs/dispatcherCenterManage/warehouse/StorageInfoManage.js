// JScript 文件
var ConfigStorageStorage;
StorageInfoManage = function(node) {
	
	var pageSize = 12;
	// 指定列参数
	var StorageFields = ["storageInfoId", "productId", "productName","warehouseName", "warningQuantity","maxQuantity","remainQuantity"];
	ConfigStorageStorage = new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url: "ConfigStorageStorage.do?actionType=search",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : StorageFields,
							root : "data",
							id : "storageInfoId",
							totalProperty : "totalCount"

						}),
				groupField : 'productName',
				sortInfo : {
					field : 'storageInfoId',
					direction : "ASC"
				}
			});
	ConfigStorageStorage.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "storageInfoId"
			});
	// --------------------------------------------------列头

	var cm = new Ext.grid.ColumnModel([sm, {
				header : "储备信息ID",
				dataIndex : "storageInfoId",
				tooltip : "储备信息ID",
				width : 80,
				sortable : true
			}, {
				header : "库房名称",
				tooltip : "库房名称D",
				dataIndex : "warehouseName",
				sortable : true,
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				}
			},{
				header : "商品ID",
				tooltip : "商品ID",
				dataIndex : "productId",
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
				header : "预警值",
				tooltip : "预警值",
				width : 80,
				dataIndex : "warningQuantity",
				sortable : true,
				editor : new Ext.form.NumberField({
							style : 'text-align:left'
						}),
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "最高值",
				tooltip : "最高值",
				width : 80,
				dataIndex : "maxQuantity",
				sortable : true,
				editor : new Ext.form.NumberField({
							style : 'text-align:left'
						}),
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			},{
				header : "库房剩余数量",
				tooltip : "库房剩余数量",
				width : 80,
				dataIndex : "remainQuantity",
				sortable : true,
				editor : new Ext.form.NumberField({
							style : 'text-align:left'
						}),
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}]);
	
	// ----------------------------------------------------定义grid
	var StorageInfoGrid = new Ext.grid.EditorGridPanel({
		id : "StorageInfoGrid",
		store : ConfigStorageStorage,
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
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条库房储备信息" : "暂无库房储备信息"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : ConfigStorageStorage,
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
					name : "SearchByName",
					id : "SearchByName",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "textfield",
					allowBlank : true
				},{
					text : "查询",
					tooltip : "查询符合条件的库房",
					iconCls : "serchopenroomrecord",
					handler : function(){
						var tempName = Ext.get("SearchByName").dom.value; 
						ConfigStorageStorage.reload({
						params : {productName:tempName}
						});
					}
				}, new Ext.Toolbar.TextItem("<font color=red>双击可编辑预警值和最高值</font>")
				 ],
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
								url : "ConfigStorageStorage.do?actionType=edit",
								method : "POST",
								params : {
									field : f,
									value : v,
									storageInfoId : r.data.storageInfoId
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
									ConfigStorageStorage.reload();
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
									ConfigStorageStorage.reload();
								}
							});
				
			},
			"rowcontextmenu" : function(grid, rowIndex, e) {
				e.stopEvent();
				RoomRightClick.showAt(e.getXY());
			}
		}
	});
	GridMain(node, StorageInfoGrid, "roomicons");
}

function GetRoomsWantedAdmin() {
	var productName = Ext.get("SearchByName").dom.value; 
	ConfigStorageStorage.reload({
				params : {
					start : 0,
					limit : 12, 
					productName : productName
				}
			});
}