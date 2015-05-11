
/**
 * 作者: 周诗龙
 * 编写时间： 2011年7月29日
 */
SureTakeProductInfo = function(row){
	var SureTakeProductInfoContent = new Ext.form.FormPanel({
		width : 375,
		height : 600,
		plain : true,
		layout : "form",
		defaultType : "textfield",
		baseCls : "x-plain",
		//锚点布局-
		fieldDefaults : {anchor: '95%',msgTarget:"side",labelWidth : 75},
		buttonAlign : "center",
		bodyStyle : "padding:5 0 0 5",
		items:[{
				name : "taskOrderId",
				width : 200,
				fieldLabel : "任务单号",
				readOnly : false
			},{
				name : "deliverman",
				width : 200,
				fieldLabel : "领货人",
				readOnly : false
			},{
				name : "takeProductDate",
				xtype : "datefield",
				format: "Y-m-d",
				width : 200,
				fieldLabel : "领货日期",
				readOnly : false
			}]
	});
	//换房登记管理主窗体
	var SureTakeProductInfoWin = new Ext.Window({
		title : "修改消费信息",
		width : 410,
		height : 150,
		plain : true,
		//不可以随意改变大小
		resizable : true,
		//可以拖动
		draggable : true,
		defaultType : "textfield",
		labelWidth : 100,
		collapsible : true,//允许缩放条
		closeAction : 'hide',
		closable : true,
		//弹出模态窗体
		modal : 'true',
		buttonAlign : "center",
		bodyStyle : "padding : 10px 0 0 15px",
		items : [SureTakeProductInfoContent],
		listeners : {
			"show" : function(){
				//当window show事件发生时清空一下表单
				//SureTakeProductInfoContent.getForm().reset();
				SureTakeProductInfoContent.getForm().loadRecord(row);
			}
		},
		buttons : [{
			text : "确认更改",
			minWidth : 70,
			handler : function(){
				if(SureTakeProductInfoContent.getForm().isValid()){
					//弹出效果
					Ext.MessageBox.show({
						msg : '正在处理，请稍等...',
						progressText : 'Searching...',
						width : 300,
						wait : true,
						waitConfig : {interval : 200},
						animEl : 'saving'
					});
					setTimeout(function(){Ext.MessageBox.hide();},1000);
					SureTakeProductInfoContent.form.submit({
						url : "takeProduct.do?actionType=doSureTakeProduct",
						method : "POST",
						success : function(form,action){
							TakeProductStore.reload();
							Ext.MessageBox.alert("恭喜你","修改成功!");
							SureTakeProductInfoWin.hide();
						},
						failure : function(form,action){
							Ext.MessageBox.alert("提示!","修改失败!");
							SureTakeProductInfoWin.hide();
						}
					});
				}
			}
		},{
			text : "取 消",
			minWidth : 70,
			handler : function(){
				//ModifyConsumeInfoWin.clearCls;
			    SureTakeProductInfoWin.hide();
			}
		}]
	});
///-----------------------------------修改消费信息
	SureTakeProductInfoWin.show();
}




















