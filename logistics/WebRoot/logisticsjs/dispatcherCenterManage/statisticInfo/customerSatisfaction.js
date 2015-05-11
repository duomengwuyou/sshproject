// JScript 文件
/**
 * 客户满意度
 * 
 * @author:龚玉斌
 */
CustomerSatisfaction = function(node) {
	// alert("进到CustomerSatisfaction中了");
	// 分页每页显示数量
	var pageSize = 12;

	// 指定列参数
	// satisfiedRatio是顾客满意度
	var fields = ["customerName", "customerId", "satisfiedRatio"];

	// 这里的store就客户的信息 以及满意度
	CustomerSatisfactionsStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url : "customerSatisfaction.do?actionType=doSearch",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : fields,
							root : "data",
							id : "customerId",
							totalProperty : "totalCount"
						})
			});
	// 加载时参数
	CustomerSatisfactionsStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([

	{
				header : "客户名",
				tooltip : "客户名",
				dataIndex : "customerName",
				sortable : true,
				renderer : function(value) {
					return "<font color=red>" + value + "</font>";
				}
			}, {
				header : "客户代码",
				tooltip : "客户代码",
				dataIndex : "customerId",
				sortable : true,
				renderer : function(value) {
					return "<font color=blue>" + value + "</font>";
				}
			}, {
				header : "满意度",
				tooltip : "满意度",
				dataIndex : "satisfiedRatio",
				sortable : true,
				renderer : function(value) {
					return "<font color=#EE9572>" + value + "</font>";
				}
			}]);

	// ----------------------------------------------------定义grid
	var customerSatisfactionGrid = new Ext.grid.GridPanel({
				id : "customerSatisfactionGridId",
				store : CustomerSatisfactionsStore,
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
							store : CustomerSatisfactionsStore,
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
				tbar : [new Ext.Toolbar.Fill(),
						new Ext.Toolbar.TextItem("请选择查询起止时间"), "", "-", {
							name : "startTimeCustomerSatisfaction",
							id : "startTimeCustomerSatisfaction",
							xtype : 'datefield',
							format : "Y-m-d",
							// xtype:'datetimefield',
							// format:'H:i',
							fieldLabel : "起始时间",
							typeAhead : true,
							emptyText : '请选择起始时间',
							width : 150,
							allowBlank : false,
							blankText : "起始时间不允许为空"
						}, "", "-", {
							name : "endTimeCustomerSatisfaction",
							id : "endTimeCustomerSatisfaction",
							xtype : 'datefield',
							format : "Y-m-d",
							// xtype:'datetimefield',
							// format:'H:i',
							typeAhead : true,
							emptyText : '请选择结束时间',
							width : 150,
							allowBlank : false,
							blankText : "结束时间不允许为空"
						}, "", "-", {
							text : "查询",
							tooltip : "查询客户满意度",
							iconCls : "serchopenroomrecord",
							handler : GetLogWanted
						}, "-"],
				listeners : {
					'contextmenu' : function(e) {
						e.stopEvent();
					}
				}
			});

	// 传入icon样式
	GridMain(node, customerSatisfactionGrid, "guesticon");
}

// -------------------------------------------------------搜索
function GetLogWanted() {
	var startTime = Ext.get("startTimeCustomerSatisfaction").dom.value;
	// alert("Ext.get(startTime).dom.value"+Ext.get("startTime").dom.value);
	var endTime = Ext.get("endTimeCustomerSatisfaction").dom.value;
	CustomerSatisfactionsStore.reload({
				params : {
					start : 0,
					limit : 12,
					startTime : startTime,
					endTime : endTime
				}
			});
}