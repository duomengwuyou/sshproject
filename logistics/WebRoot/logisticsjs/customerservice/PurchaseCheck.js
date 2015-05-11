/**
 * 
 * 作者 ：周诗龙 功能 ： 消费管理-消费结账管理
 * 
 */
var OrderDetailStore;
var ProductStore;
var guestId;
PurchaseCheck = function(node) {
	// 产品类别combox动态加载数据
	// var goodstypefileds = Ext.data.Record.create([
	// {name: 'goodsTypeId',mapping:'goodsTypeId'},{name:
	// 'goodsTypeName',mapping:'goodsTypeName'},{name:'typeRemark',mapping:'typeRemark'}
	// ]);
	// goodstypestore = new Ext.data.Store({
	// proxy: new Ext.data.HttpProxy({
	// url:'servlet/GoodsTypeServlet'
	// //url : 'servlet/PurchaseTempServlet'
	// }),
	// reader: new Ext.data.JsonReader({
	// root: 'data',
	// id:'goodsTypeId'
	// },
	// goodstypefileds
	// )
	// });
	// goodstypestore.load();
	// 分页数大小
	var pageSize = 10;
	// var fields =
	// ["goodsId","goodsName","goodsType","goodsPrice","unit","goodsDiscount","goodsRemark"];
	var orderDetailField = ["customerId", "customerName", "idCard",
			"deliverSubstation", "signedDate", "orderDate", "receiveAdd",
			"reveivePerson", "reveivePersonTel", "reveivePersonZip",
			"orderType"];
	// var purchaseFields = ["goodsId","goodsName","goodsNumber"];
	var productInfo = ["parentCategory", "category", "productName",
			"originalPrice", "unit", "productRemark", "orderItemAmount",
			"totalPrice", "orderState"];
	PurchaseStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							// url : null,
							url : "servlet/PurchaseTempServlet",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : purchaseFields,
							root : "data",
							id : "goodsId",
							totalProperty : "totalCount"
						})
			});
	PurchaseStore.load();
	// PurchaseStore.load({params : {start : 0, limit : pageSize}});
	ConsumeRecordStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url : "servlet/SearchAllGoodsInfo",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : fields,
							root : "data",
							id : "goodsId",
							totalProperty : "totalCount"
						})
			});
	ConsumeRecordStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});
	function FiltGoodsInfo() {
		var goodsTypeSelected = Ext.get("goodsType").dom.value;
		ConsumeRecordStore.reload({
					params : {
						gType : goodsTypeSelected
					}
				});
	}

	// var columnModel = new Ext.grid.ColumnModel([{
	// header : "商品号",
	// dataIndex : "goodsId",
	// // menuDisabled : true,
	// width : 30,
	// //排序
	// sortable : true
	// },{
	// header : "商品名",
	// dataIndex : "goodsName",
	// // menuDisabled : true,
	// width : 30,
	// //排序
	// sortable : true
	// },{
	// header : "商品类别",
	// dataIndex : "goodsType",
	// // menuDisabled : true,
	// width : 40,
	// //排序
	// sortable : true
	// },{
	// header : "商品价格",
	// dataIndex : "goodsPrice",
	// width : 40,
	// sortable : true
	// // renderer : function(v){
	// // // return "<font color=red>"+Ext.util.Format.usMoney(v)+"</font>";
	// // }
	// },{
	// header : "商品单位",
	// dataIndex : "unit",
	// // menuDisabled : true,
	// width : 40,
	// //排序
	// sortable : true
	// },{
	// header : "商品折扣率",
	// dataIndex : "goodsDiscount",
	// // menuDisabled : true,
	// width : 50,
	// //排序
	// sortable : true
	// },{
	// header : "备注",
	// dataIndex : "goodsRemark",
	// // menuDisabled : true,
	// width : 50,
	// //排序
	// sortable : true
	// }]);
	// 增加消费信息

	// 商品详细信息
	var goodsDetailInfo = new Ext.form.FieldSet({
				collapsible : true,
				title : "详细信息",
				border : true,
				labelWidth : 75,
				width : 350,
				buttonAlign : 'center',
				autoHeight : true,
				layout : 'form',
				defaults : {
					autoWidth : true
				},
				items : [{
							id : "goodsId",
							fieldLabel : "商品号",
							xtype : 'textfield',
							name : "goodsId"
						}, {
							fieldLabel : "商品名",
							xtype : 'textfield',
							name : "goodsName"
						}, {
							fieldLabel : "商品类别",
							xtype : 'textfield',
							name : "goodsType"
						}, {
							fieldLabel : "商品价格",
							xtype : 'textfield',
							name : "goodsPrice"
						}, {
							fieldLabel : "商品单位",
							xtype : 'textfield',
							name : "unit"
						}, {
							id : "goodsRemark",
							fieldLabel : "商品折扣率",
							xtype : 'textfield',
							name : "goodsDiscount"
						}, {
							id : "goodsRemark",
							fieldLabel : "备注",
							xtype : 'textfield',
							name : "goodsRemark"
						}, {
							id : "buyNumber",
							fieldLabel : "购买数量",
							xtype : 'textfield',
							name : "buyNumber",
							blankText : "购买数量不能为空",
							regex : /^[0-9]{1,100}$/,
							regexText : "只能是数字"
						}, {
							id : "guestId",
							fieldLabel : "入住单号",
							xtype : 'textfield',
							name : "guestId",
							blankText : "入住单号不能为空",
							regex : /^[0-9]{1,100}$/,
							regexText : "只能是数字",
							value : guestId
						}],
				buttons : [{
							text : '确定',
							minWidth : 60,
							handler : AddPurchaseInfo
						}, {
							text : '取消',
							minWidth : 60,
							handler : function() {
								Ext.get("buyNumber").dom.value = 1;
							}
						}]
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "index"
			});
	// 购买商品信息列名
	var purchaseInfoColumn = new Ext.grid.ColumnModel([sm, {
				header : "商品号",
				dataIndex : "goodsId",
				menuDisabled : true,
				width : 10,
				// 排序
				sortable : true
			}, {
				header : "商品名称",
				dataIndex : "goodsName",
				menuDisabled : true,
				width : 20,
				// 排序
				sortable : true
			}, {
				header : "购买数量",
				dataIndex : "goodsNumber",
				menuDisabled : true,
				width : 10,
				// 排序
				sortable : true
			}]);

	// 客户购买的商品信息
	var PurchaseInfo = new Ext.form.FieldSet({
				collapsible : true,
				title : "客户购买的物品",
				border : true,
				labelWidth : 35,
				width : 350,
				autoHeight : true,
				layout : 'form',
				defaults : {
					autoWidth : true
				},
				items : [{
							id : 'PurchaseInfoGrid',
							xtype : 'grid',
							height : 200,
							cm : purchaseInfoColumn,
							loadMask : true,
							store : PurchaseStore,
							border : false,
							viewConfig : {
								columnsText : "显示/隐藏列",
								sortAscText : "正序排列",
								sortDescText : "倒序排列",
								forceFit : true
							},
							sm : sm,
							// new Ext.grid.RowSelectionModel({
							// singleSelect: true,
							// listeners: {
							// "rowselect":function(sm, row, rec) {
							// Ext.getCmp("ConsumeRecordGridForm").getForm().loadRecord(rec);
							// }
							// }
							// }),
							tbar : [new Ext.Toolbar.Fill(), "", "-", "", {
										text : "刷新",
										// 默认样式为按下
										// pressed:true,
										tooltip : "刷新当前页面",
										iconCls : "refreshicon",
										handler : function() {
											PurchaseStore.reload();
										}
									}, "", "-", "", {
										text : "确定购买",
										tooltip : "购买以下所有选的的商品",
										iconCls : "editicon",
										handler : SurePurchase
									}, "", "-", "", {
										text : "删除",
										tooltip : "搜索数据",
										iconCls : "deleteicon",
										handler : DeletePurchaseInfo
									}, "", "-", ""],
							bbar : new Ext.PagingToolbar({
										store : PurchaseStore,
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
								"render" : function(g) {
									g.getSelectionModel().selectRow(0);
								},
								delay : 10
							}
						}]
			});

	var ConsumeRecordGridForm = new Ext.FormPanel({
				id : 'ConsumeRecordGridForm',
				frame : true,
				bodyStyle : 'padding:5px',
				autoWidth : true,
				aotoHeight : true,
				border : false,
				layout : 'column',
				defaults : {
					anchor : "95%"
				},
				items : [
						// {
						// columnWidth : 0.5,
						// layout : 'fit',
						// items : {
						// xtype : 'grid',
						// height : 550,
						// cm : columnModel,
						// loadMask : true,
						// store : ConsumeRecordStore,
						// border : false,
						// viewConfig : {
						// columnsText : "显示/隐藏列",
						// sortAscText : "正序排列",
						// sortDescText : "倒序排列",
						// forceFit : true
						// },
						// sm :new Ext.grid.RowSelectionModel({
						// singleSelect: true,
						// listeners: {
						// "rowselect":function(sm, row, rec) {
						// Ext.getCmp("ConsumeRecordGridForm").getForm().loadRecord(rec);
						// }
						// }
						// }),
						// tbar:[
						// new Ext.Toolbar.Fill(),
						// "","-",""
						// ,{
						// text : "刷新",
						// //默认样式为按下
						// //pressed:true,
						// tooltip : "刷新当前页面",
						// iconCls : "refreshicon",
						// handler : function(){
						// ConsumeRecordStore.reload();
						// }
						// },"","-","",{
						// text : "请选择商品类别",
						// //默认样式为按下
						// //pressed:true,
						// tooltip : "刷新当前页面",
						// iconCls : "editicon"
						//                        
						// },"","-","",{
						// id : 'goodsType',
						// labelfield : "商品类别",
						// xtype : "combo",
						// tootip : "查询消费信息",
						// iconCls:"editicon",
						// readOnly : true,
						// mode : "remote",
						// displayField : "goodsTypeName",
						// valueField : "goodsTypeId",
						// triggerAction : "all",
						// value : "食品",
						// editable :false,
						// store : goodstypestore,
						// action : FiltGoodsInfo
						// },"","-","",{
						// text : "搜索",
						// tooltip : "搜索数据",
						// handler : FiltGoodsInfo
						// },"","-",""
						// ],
						// bbar:new Ext.PagingToolbar({
						// store : ConsumeRecordStore,
						// pageSize : pageSize,
						// displayInfo : true,
						// displayMsg : ' {0}-{1} 条 共 {2} 条',
						// emptyMsg : "No results to display",
						// prevText : "上一页",
						// nextText : "下一页",
						// refreshText : "刷新",
						// lastText : "最后页",
						// firstText : "第一页",
						// beforePageText : "当前页",
						// afterPageText : "共{0}页"
						// }),
						// listeners:{
						// "render": function(g) {
						// g.getSelectionModel().selectRow(0);
						// },
						// delay: 10
						// }
						// }
						// },

						{
					columnWidth : 0.5,
					layout : 'form',
					autoWidth : true,
					height : 550,
					bodyStyle : Ext.isIE
							? 'padding:0 0 5px 15px;'
							: 'padding:10px 15px;',
					border : true,
					style : {
						"margin-left" : "10px",
						"margin-right" : Ext.isIE6 ? (Ext.isStrict
								? "-10px"
								: "-13px") : "0"
					},
					items : [goodsDetailInfo, PurchaseInfo]
				}]
			});
	// --------------------------显示表单
	GridMain(node, ConsumeRecordGridForm, "totalicon");
}
AddPurchaseInfo = function() {
	guestId = Ext.get("guestId").dom.value;
	var buyNumber = Ext.get("buyNumber").dom.value;
	var goodsId = Ext.get("goodsId").dom.value;
	var operation = "add";
	if (buyNumber == "0") {
		Ext.Msg.alert("提示", "不能为0！");
	} else {
		PurchaseStore.reload({
					params : {
						guestIdTemp : guestId,
						buyNumberTemp : buyNumber,
						goodsIdTemp : goodsId,
						operationTemp : operation
					}
				});
	}
};
DeletePurchaseInfo = function() {
	var row = Ext.getCmp("PurchaseInfoGrid").getSelectionModel()
			.getSelections();
	if (row.length == 0) {
		Ext.Msg.alert("提示信息", "请您至少选择一个!");
	} else if (row.length > 1) {
		Ext.Msg.alert("提示信息", "对不起只能选择一个!");
	} else if (row.length == 1) {
		guestId = Ext.get("guestId").dom.value;
		var buyNumber = row[0].data.goodsNumber;
		var goodsId = row[0].data.goodsId;
		var operation = "delete";
		PurchaseStore.reload({
					params : {
						guestIdTemp : guestId,
						buyNumberTemp : buyNumber,
						goodsIdTemp : goodsId,
						operationTemp : operation
					}
				});
	}
}
SurePurchase = function() {
	Ext.Ajax.request({
				url : "servlet/SurePurchaseServlet",
				method : "POST",
				params : {
					guestIdTemp : guestId
				},
				success : function() {
					PurchaseStore.reload({
								params : {
									guestIdTemp : guestId
								}
							});
					Ext.Msg.alert("恭喜您", "购买成功了!");

				},
				failure : function() {
					Ext.Msg.alert("提 示", "很抱歉购买失败了!");
				}
			});
}
