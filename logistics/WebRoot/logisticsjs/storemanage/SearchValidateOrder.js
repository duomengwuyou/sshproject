/**
 * 作者 : 周诗龙 日期 ： 2011年7月15日
 */
// //------------------------------------------------------查询入住信息
// 搜索主窗体中的内容组件
var SearchValidateOrderContent = new Ext.form.FormPanel({
			width : 375,
			height : 600,
			plain : true,
			layout : "form",
			defaultType : "textfield",
			labelWidth : 75,
			baseCls : "x-plain",
			// 锚点布局-
			defaults : {
				anchor : "95%",
				msgTarget : "side"
			},
			buttonAlign : "center",
			bodyStyle : "padding:10 0 0 0",
			items : [{
				id : "searchContentValidateOrder",
				name : "searchContentValidateOrder",
				fieldLabel : "<font color=red>验货单号：</font>",
				allowBlank : true
					// blankText : "搜索内容不允许为空"
				}]
		});
// 搜索的主窗体
var SearchValidateOrderWin = new Ext.Window({
			title : "查询验货单/分发单信息",
			width : 410,
			height : 120,
			plain : true,
			// 不可以随意改变大小
			resizable : false,
			// 可以拖动
			draggable : false,
			defaultType : "textfield",
			labelWidth : 100,
			collapsible : true,// 允许缩放条
			closeAction : 'hide',
			closable : true,
			// 弹出模态窗体
			modal : 'true',
			buttonAlign : "center",
			bodyStyle : "padding : 10px 0 0 15px",
			items : [SearchValidateOrderContent],
			listeners : {
				"show" : function() {
					// 当window show事件发生时清空一下表单
					SearchValidateOrderContent.getForm().reset();
				}
			},
			buttons : [{
						text : "搜索",
						minWidth : 70,
						handler : function() {
							if (SearchValidateOrderContent.getForm().isValid()) {
								// 弹出效果
								Ext.MessageBox.show({
											msg : '正在搜索，请稍等...',
											progressText : '搜索中...',
											width : 300,
											wait : true,
											waitConfig : {
												interval : 200
											},
											animEl : 'saving'
										});
								setTimeout(function() {
											Ext.MessageBox.hide();
										}, 1000);
								enterIdTemp = Ext.get("searchContent").dom.value;
								// alert("获取的enterIdTemp为:"+enterIdTemp);
								SubstationIntoStore.reload({
											params : {
												enterId : enterIdTemp
											}
										});
								SearchPurchaseInfoWin.hide();
								// SearchPurchaseInfoContent.form.submit({
								// url : "根据搜索项查询信息的servlet",
								// method : "POST",
								// success : function(form,action){
								// //成功后
								// var flag=action.result.success;
								// if (flag == "true"){
								//							
								// }
								// },
								// failure : function(form,action){
								// Ext.MessageBox.alert("提示!","搜索失败!");
								// }
								// });
							}
						}
					}, {
						text : "重置",
						minWidth : 70,
						qtip : "重置",
						handler : function() {
							SearchValidateOrderContent.getForm().reset();
						}
					}, {
						text : "取 消",
						minWidth : 70,
						handler : function() {
							SearchValidateOrderWin.hide();
						}
					}]
		});
SearchValidateOrder = function() {
	SearchValidateOrderWin.show();
}