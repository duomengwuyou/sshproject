// JScript 文件
/**
 * 订购排行榜分析
 * 
 * @author:龚玉斌
 */
var LogStore;
var ProductHotStore;
ProductHotMost = function(node) {
	// alert("进到ProductHotMost中了");
	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数

	// rank是排行
	var fields = ["rank", "productId", "productName"];

	// 这里的store就应该是排行前五的商品
	ProductHotStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url : "productHotMost.do?actionType=doSearch",
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
	ProductHotStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([

	{
				header : "排行",
				tooltip : "排行",
				dataIndex : "rank",
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
					return "<font color=blue>" + value + "</font>";
				}
			}, {
				header : "商品名称",
				tooltip : "商品名称",
				dataIndex : "productName",
				sortable : true,
				renderer : function(value) {
					return "<font color=#EE9572>" + value + "</font>";
				}
			}]);

	// ----------------------------------------------------定义grid
	var productHotMostGrid = new Ext.grid.GridPanel({
				id : "productHotMostGridId",
				store : ProductHotStore,
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
							store : ProductHotStore,
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
							name : "startTimeTopHot",
							id : "startTimeTopHot",
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
							name : "endTimeTopHot",
							id : "endTimeTopHot",
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
							tooltip : "查询最热前五商品",
							iconCls : "serchopenroomrecord",
							handler : GetLogWanted11
						}, "-"],
				listeners : {
					'contextmenu' : function(e) {
						e.stopEvent();
					}
				}
			});

	// 传入icon样式
	GridMain(node, productHotMostGrid, "guesticon");
}

// -------------------------------------------------------搜索
function GetLogWanted11() {
	var startTime = Ext.get("startTimeTopHot").dom.value;
	// alert("Ext.get(startTime).dom.value"+Ext.get("startTime").dom.value);
	var endTime = Ext.get("endTimeTopHot").dom.value;
	ProductHotStore.reload({
				params : {
					start : 0,
					limit : 12,
					startTime : startTime,
					endTime : endTime
				}
			});
}