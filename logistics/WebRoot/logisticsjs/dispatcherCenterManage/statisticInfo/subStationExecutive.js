// JScript 文件
/**
 * 分站配送情况分析
 * 
 * @author:龚玉斌
 */
SubStationExecutive = function(node) {
	// alert("进到SubStationExetutive中了");

	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数
	var fields = ["substationAdd", "substationId", "tuskTotal", "productTotal",
			"cashTotal"];

	// 这里的store是分站的统计信息-----------------
	LogStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							//url : "servlet/LogServlet",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : fields,
							root : "data",
							id : "logId",
							totalProperty : "totalCount"
						})
			});
	// 加载时参数
	LogStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([

	{
				header : "分站地址",
				tooltip : "分站地址也就是分站名字",
				dataIndex : "substationAdd",
				sortable : true,
				renderer : function(value) {
					return "<font color=red>" + value + "</font>";
				}
			}, {
				header : "分站代码",
				tooltip : "分站代码",
				dataIndex : "substationId",
				sortable : true,
				renderer : function(value) {
					return "<font color=blue>" + value + "</font>";
				}
			}, {
				header : "送货付款任务数",
				tooltip : "送货付款任务数",
				dataIndex : "tuskTotal",
				sortable : true,
				renderer : function(value) {
					return "<font color=#EE9572>" + value + "</font>";
				}
			}, {
				header : "商品数量",
				tooltip : "商品数量",
				dataIndex : "productTotal",
				sortable : true
			}, {
				header : "金额",
				tooltip : "金额",
				dataIndex : "cashTotal",
				sortable : true
			}]);

	// ----------------------------------------------------定义grid
	var subStationEexcutive = new Ext.grid.GridPanel({
				id : "Loggrid",
				store : LogStore,

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
							store : LogStore,
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
						}, "", "-", {
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
						}, "", "-", {
							text : "查询",
							tooltip : "查询分站配送情况分析",
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
	GridMain(node, subStationEexcutive, "guesticon");
}

// -------------------------------------------------------搜索
function GetLogWanted() {
	var startTime = Ext.get("startTime").dom.value;
	// alert("Ext.get(startTime).dom.value"+Ext.get("startTime").dom.value);
	var endTime = Ext.get("endTime").dom.value;
	LogStore.reload({
				params : {
					start : 0,
					limit : 12,
					startTime : startTime,
					endTime : endTime
				}
			});
}