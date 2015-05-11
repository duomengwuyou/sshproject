// JScript 文件
/**
 * 退货管理
 * 
 * @author:龚玉斌
 */
// alert("进到ReturnProduct中了=============");
ReturnProduct = function(node) {

	// alert("进到ReturnProduct中了");
	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数
	var fields = ["supplierName", "productId", "productName",
			"puchaseQuantity", "remainQuantity", "returnQuantity"];

	// 数据还没有开始工作 此store是商品信息
	var OrderStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url : "returnProduct.do?actionType=doSearch",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : fields,
							root : "data",
							id : "productId",
							totalProperty : "totalCount"
						})
			});
	// 加载时参数
	OrderStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "productId"
			});
	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([sm, {
				header : "供应商",
				tooltip : "供应商",
				dataIndex : "supplierName",
				sortable : true,
				renderer : function(value) {
					return "<font color=red>" + value + "</font>";
				}
			}, {
				header : "商品代码",
				tooltip : "商品代码",
				dataIndex : "productId",
				sortable : true,
				renderer : function(value) {
					return "<font color=#EE9572>" + value + "</font>";
				}
			}, {
				header : "商品名称",
				tooltip : "商品名称",
				dataIndex : "productName",
				sortable : true
			}, {
				// 进货数量就是入库的数量
				header : "进货数量",
				tooltip : "进货数量",
				dataIndex : "puchaseQuantity",
				sortable : true
			}, {
				header : "现库存量",
				tooltip : "现库存量",
				dataIndex : "remainQuantity",
				sortable : true
			}, {
				header : "退货数量",
				tooltip : "退货数量",
				dataIndex : "returnQuantity",
				// 可以进行排序
				sortable : true
			}]);

	// ----------------------------------------------------定义grid
	var returnProductGrid = new Ext.grid.GridPanel({
				id : "returnProductGridId",
				store : OrderStore,
				sm : sm,
				cm : cm,
				loadMask : true,
				// 超过长度带自动滚动条
				autoScroll : true,
				border : false,
				viewConfig : {
					columnsText : "显示/隐藏列",
					sortAscText : "正序排列",
					sortDescText : "倒序排列",
					forceFit : true
				},
				// 分页
				bbar : new Ext.PagingToolbar({
							store : OrderStore,
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
						new Ext.Toolbar.Fill(),
						new Ext.Toolbar.TextItem("<font color=red>供应商</font>"),
						{
							name : "supplierName",
							id : "supplierName1",
							xtype : "textfield",
							baseCls : "x-plain"
							// fieldLabel:"",
							// allowBlank:true,
							// emptyText:"请填写预定人姓名",
							// blankText:"预定人信息不能为空"
						},
						"",
						"-",
						new Ext.Toolbar.TextItem("起止时间"),
						"",
						"-",
						{
							name : "startTime",
							id : "startTime",
							xtype : 'datefield',
							format : "Y-m-d H:i:s.g",
							// xtype:'datetimefield',
							// format:'H:i',
							fieldLabel : "起始时间",
							typeAhead : true,
							emptyText : '请选择起始时间',
							width : 150,
							allowBlank : false,
							blankText : "起始时间不允许为空"
						},
						"",
						"-",
						{
							name : "endTime",
							id : "endTime",
							xtype : 'datefield',
							format : "Y-m-d H:i:s.g",
							// xtype:'datetimefield',
							// format:'H:i',
							typeAhead : true,
							emptyText : '请选择结束时间',
							width : 150,
							allowBlank : false,
							blankText : "结束时间不允许为空"
						},
						"",
						"-",
						new Ext.Toolbar.TextItem("<font color=red>商品编号</font>"),
						"", "-", {
							name : "productId",
							id : "productId1",
							xtype : "textfield",
							baseCls : "x-plain",
							// fieldLabel:"标准价格",
							allowBlank : true,
							// emptyText:"填写预订单号",
							// blankText:"预订单号不能为空",
							regex : /^[0-9]{1,10}$/,
							regexText : "1-5位数字"
						}, "", "-", {
							text : "查询",
							tooltip : "查询商品",
							iconCls : "serchopenroomrecord",
							handler : GetLogWanted
						}, "", "-", {
							text : "生成退货单",
							tooltip : "生成退货单",
							iconCls : "serchopenroomrecord",
							handler : GetLogWanted
						}],
				listeners : {
					'contextmenu' : function(e) {
						e.stopEvent();
					}
				}
			});

	// 传入icon样式
	GridMain(node, returnProductGrid, "guesticon");
}

function DelLogFn() {
	// 得到多个record对象
	var row = Ext.getCmp("ProductId").getSelectionModel().getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else {
		Ext.Msg.confirm("提示!", "您确定要退货吗?", function(btn) {
					if (btn == "yes") {
						DelLog(row);
					} else {
					}
				})
	}
}

// -------------------------------------------------------搜索
function GetLogWanted() {
	var startTime = Ext.get("startTime").dom.value;
	// alert("Ext.get(startTime).dom.value"+Ext.get("startTime").dom.value);
	var endTime = Ext.get("endTime").dom.value;
	OrderStore.reload({
				params : {
					start : 0,
					limit : 12,
					startTime : startTime,
					endTime : endTime
				}
			});
}