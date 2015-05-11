/**
 * 张文华
 * 客户信息管理
 */
var Customerstore;

// alert("进入客户信息管理");
CustomerOrder = function(node) {
	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数
	var Customerfields = ["customerId", "customerName", "idcard", "workPlace",
			"phone", "mobile", "address", "customerZipCode", "email"];

	 Customerstore = new Ext.data.GroupingStore({
		proxy : new Ext.data.HttpProxy({
					 url:"customerInfo.do?actionType=doSearch",
					method : "POST"
				}),
		reader : new Ext.data.JsonReader({
					fields : Customerfields,
					root : "data",
					id : "customerId",
					totalProperty : "totalCount"
				})
		});
	Customerstore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "customerId"
			});
	// --------------------------------------------------列头

	var cm = new Ext.grid.ColumnModel([sm, {
				header : "客户编号",
				dataIndex : "customerId",
				tooltip : "客户的唯一标识",
				width : 80,
				sortable : true
			}, {
				header : "客户姓名",
				tooltip : "客户姓名",
				dataIndex : "customerName",
				sortable : true,
				 editor: new Ext.form.TextField({
				 style:'text-align:left'
				 }),
				renderer : function(value) {
					return "<b><font color=#008B8B>" + value + "</font></b>";
				}
			}, {
				header : "客户身份证",
				tooltip : "客户身份证",
				dataIndex : "idcard",
				sortable : true,
				
				renderer : function(value) {
					return '<b><font color=red>' + value + '</font></b>';
				},
				 editor: new Ext.form.TextField({
				 style:'text-align:left',
				 regex:/[1-9]/,
                 regexText:"数字组成"
				 })
			}, {
				header : "工作单位",
				tooltip : "工作单位",
				dataIndex : "workPlace",
				sortable : true,
				 editor:new Ext.form.TextField({
				 style:'text-align:left'
				 }),
				renderer : function(value) {

					return "<b><font color=#008B8B>" + value + "</font></b>";

				}
			}, {
				header : "固定电话",
				tooltip : "客户的固定电话",
				width : 80,
				dataIndex : "phone",
				sortable : true,
				 editor:new Ext.form.TextField({
				 style:'text-align:left',
				 regex:/[1-9]/,
                 regexText:"数字组成"
				 }),
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "移动电话",
				tooltip : "客户的移动电话",
				width : 80,
				dataIndex : "mobile",
				sortable : true,
				 editor:new Ext.form.TextField({
				 style:'text-align:left',
				 regex:/[1-9]/,
                 regexText:"数字组成"
				 }),
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "地址",
				tooltip : "客户的地址",
				width : 80,
				dataIndex : "address",
				sortable : true,
				 editor:new Ext.form.TextField({
				 style:'text-align:left'
				 }),
				renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
			}, {
				header : "邮编",
				tooltip : "客户所在地区邮编",
				width : 80,
				dataIndex : "customerZipCode",
				sortable : true,
				 editor:new Ext.form.TextField({
				 style:'text-align:left',
				 regex:/[1-9]/,
                 regexText:"数字组成"
				 }),
				renderer : function(val) {					
						return '<b><font color=blue>' + val + '</font></b>';						
				}
			}, {
				header : "邮箱",
				tooltip : "邮箱",
				dataIndex : "email",
				sortable : true,
				 editor:new Ext.form.TextField({
			 style:'text-align:left',
			 regex:/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/,
			 regexText:"**.@**.com"
			 })
		}]);

	// -----------------------右键菜单
	var CustomerRightClick = new Ext.menu.Menu({
				items : [{
							text : '刷新信息',
							iconCls : 'addicon',
							handler : function() {
								Customerstore.reload();
							}
						}, {
							text : '登记客户',
							iconCls : 'editicon',
							handler : AddCustomer
						}, {
							text : '删除客户',
							iconCls : 'deleteicon',
							handler : DelCustomerFn
						}]
			});

	// ----------------------------------------------------定义grid
	var CustomerManageGrid = new Ext.grid.EditorGridPanel({
		id : "CustomerManageGrid",
		store : Customerstore,
		sm : sm,
		cm : cm,
		loadMask : true,
		stripeRows : true,
		clicksToEdit : 2,
		autoScroll : true,
		border : false,
		view : new Ext.grid.GroupingView({
			// 自动填充
			forceFit : true,
			sortAscText : '正序排列',
			sortDescText : '倒序排列',
			hideGroupedColumn : true,
			columnsText : '列显示/隐藏',
			groupByText : '根据本列分组',
			showGroupsText : '是否采用分组显示',
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条房间信息" : "暂无房间信息"]})'
		}),
		// 分页

		tbar : ["                   ",
				new Ext.Toolbar.TextItem("<font color=red>客户姓名</font>"), "",
				"-", {
					name : "customerName1",
					id : "customerName1",
					xtype : "textfield",
					baseCls : "x-plain",
					allowBlank : true
				}, "", "-",
				new Ext.Toolbar.TextItem("<font color=red>联系方式</font>"), "",
				"-", {
					name : "mobile1",
					 id:"mobile1",
					xtype : "textfield",
					baseCls : "x-plain",
					allowBlank : true
				}, "", "-",
				new Ext.Toolbar.TextItem("<font color=red>身份证</font>"), "",
				"-", {
					name : "idcard1",
					 id:"idcard1",
					xtype : "textfield",
					baseCls : "x-plain",
					allowBlank : true
				}, "", "-", "", {
					text : "查询",
					tooltip : "查询符合条件的客户",
					iconCls : "serchopenroomrecord",
					handler : GetCustomerWanted
				}, "", "-", "", {
					text : "新建订单",
					tooltip : "新建订单",
					iconCls : "addicon",
					handler : AddOrderFn
				}, "", "-", "", {
					text : "登记客户",
					tooltip : "登记客户",
					iconCls : "editicon",
					handler : AddCustomer
				}, "", "-", "", {
					text : "删除客户",
					tooltip : "删除客户",
					iconCls : "deleteicon",
					handler : DelCustomerFn
				}, "-"],
				bbar:new Ext.PagingToolbar({
                    store : Customerstore,
                    pageSize : pageSize,
                    displayInfo : true,
                    displayMsg : ' {0}-{1} 条 共 {2} 条',
                    emptyMsg : "No results to display",
                    prevText : "上一页",
                    nextText : "下一页",
                    refreshText : "刷新",
                    lastText : "最后页",
                    firstText : "第一页",
                    beforePageText : "当前页",
                    afterPageText : "共{0}页"
                }),
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
								url : "customerInfo.do?actionType=modCustomer",
								method : "POST",
								params : {
									field : f,
									value : v,
									customerid : r.data.customerId
								},
								success : function(response, option) {
									var responseArray = Ext.util.JSON.decode(response.responseText);
									var flag = responseArray.success;
									if (flag) {
										Ext.Msg.alert("恭喜您", "更新成功");
									} else {
										Ext.Msg.alert("对不起", responseArray.msg);
									}
									Customerstore.reload();
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
									Customerstore.reload();
								}
							});
				
			},
			"rowcontextmenu" : function(grid, rowIndex, e) {
				e.stopEvent();
				CustomerRightClick.showAt(e.getXY());
			}
		}
	});
	GridMain(node, CustomerManageGrid, "roomicons");
};
// -------------------------------------------------------搜索
function GetCustomerWanted() {

	var customerName1 = Ext.get("customerName1").dom.value;
	var mobile1 = Ext.get("mobile1").dom.value;
	var idcard1 = Ext.get("idcard1").dom.value;
	Customerstore.reload({
				params : {
					start : 0,
					limit : 12,
					customerName2 : customerName1,
					mobile2 : mobile1,
					idcard2 : idcard1
				}
			});
	Ext.get("customerName1").dom.value=null;
	Ext.get("mobile1").dom.value=null;
	Ext.get("idcard1").dom.value=null;	
}
// -----------------------新增订单
 AddOrderFn = function(){
 	var row = Ext.getCmp("CustomerManageGrid").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您选择一个!");
	}  else if(row.length>1){  
            Ext.Msg.alert("提示信息","对不起只能选择一个!");
            }else if(row.length==1){		
						AddOrder(row[0]);
					}
}

// ----------------------登记客户
AddCustomer = function() {
	AddCustomerInfo();
	// AddCustomerwin.show();
};
// ----------------------删除客户
DelCustomerFn = function() {
	var row = Ext.getCmp("CustomerManageGrid").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else {
		Ext.Msg.confirm("提示!", "您确定要删除客户信息吗?", function(btn) {
					if (btn == "yes") {
						DelCustomer(row);
						//Customerstore.reload();
					} else {

					}
				})
	}

}

DelCustomer = function(row) {
	var deletesplit = "";
	for (var i = 0; i < row.length; i++) {
		if (row.length == 1) {
			deletesplit = row[i].data.customerId;
		} else {

			if (i < (row.length - 1)) {
				deletesplit = row[i].data.customerId + "," + deletesplit;
			}
			if (i == (row.length - 1)) {
				deletesplit = deletesplit + row[i].data.customerId;
			}
		}
	}
	Ext.Ajax.request({
			    url:"customerInfo.do?actionType=delCustomer",
				method : "POST",
				params : {
					customerid : deletesplit
				},
				success : function(response, option) {
					var responseArray = Ext.util.JSON.decode(response.responseText);
					var flag = responseArray.success;
					if (flag) {
						Ext.Msg.alert("恭喜您", "成功删除" + responseArray.deleteid+ "号客户");
					} else {
						Ext.Msg.alert("对不起",+ responseArray.deleteid+ "号客户有订单，不能删除！");
					}
					Customerstore.reload();
				},
				failure : function(response, option) {
					var responseArray = Ext.util.JSON.decode(response.responseText);
					Ext.Msg.alert("系统错误", responseArray.msg);
					Customerstore.reload();
				}
			});
}
