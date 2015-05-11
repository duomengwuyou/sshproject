// 李莎
// 添加回执信息
AddFeedback = function(node) {

	// 添加form表单
	var AddFeedbackForm = new Ext.form.FormPanel({
		width : 375,
		height : 200,
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
		bodyStyle : "padding:0 0 0 0",
		items : [{
			readOnly:true,
			name : "signedOrder",
			//id : "signedOrder1",
			fieldLabel : "<font color=red>任务单号</font>",
			allowBlank : false,
			value:node
			}, {

			xtype : "combo",
			name : 'state',
			fieldLabel : '完成状态',
			emptyText : '请选择回执状态',
			allowBlank : false,
			blankText : '请选择回执状态',
			editable : false,
			hiddenName : 'state',
			store : new Ext.data.SimpleStore({
						data : [["完成", "完成"], ["部分完成", "部分完成"], ["失败", "失败"]],
						fields : ["state", "value"]
					}),
			tpl : '<tpl for="."><div ext:qtip="填写任务完成状态为--{state}" class="x-combo-list-item">{state}</div></tpl>',
			displayField : "state",
			mode : "local",
			valueField : "value",
			triggerAction : "all"

		}, {
			xtype : "combo",
			name : 'state',
			fieldLabel : '客户满意度',
			emptyText : '请选择客户满意度',
			allowBlank : false,
			blankText : '请选择客户满意度',
			editable : false,
			hiddenName : 'satisfaction',
			store : new Ext.data.SimpleStore({
						data : [["1", "1"], ["2", "2"], ["3", "3"], ["4", "4"], ["5", "5"]],
						fields : ["state", "value"]
					}),
			tpl : '<tpl for="."><div ext:qtip="请选择客户满意度为--{state}" class="x-combo-list-item">{state}</div></tpl>',
			displayField : "state",
			mode : "local",
			valueField : "value",
			triggerAction : "all"
		}, {
			name : "feedBackRemark",
			//id : "feedBackRemark1",
			fieldLabel : "<font color=red>备注信息</font>",
			allowBlank : true
		}]
	})

	var AddFeedbackwin = new Ext.Window({
		title : "增加回执信息",
		width : 410,
		height : 230,
		plain : true,
		iconCls : "openroomicon",
		// 不可以随意改变大小
		resizable : false,
		// 是否可以拖动
		// draggable:false,
		defaultType : "textfield",
		labelWidth : 100,
		collapsible : true, // 允许缩放条
		closeAction : 'hide',
		closable : true,
		// 弹出模态窗体
		modal : 'true',
		buttonAlign : "center",
		bodyStyle : "padding:10px 0 0 15px",
		items : [AddFeedbackForm],
		listeners : {
			"show" : function() {
				// 当window show事件发生时清空一下表单
				AddFeedbackForm.getForm().reset();
			}
		},
		buttons : [{
			text : "保存信息",
			minWidth : 70,
			handler : function() {
				if (AddFeedbackForm.getForm().isValid()) {
					// 弹出效果
					Ext.MessageBox.show({
								msg : '正在保存，请稍等...',
								progressText : 'Saving...',
								width : 300,
								wait : true,
								waitConfig : {
									interval : 200
								},
								icon : 'download',
								animEl : 'saving'
							});
					setTimeout(function() {
							}, 1000);
					AddFeedbackForm.form.submit({
						
								url : "subsavefeedback.do?actionType=doSearch",// 保存回执信息的servlet
								method : "POST",
								success : function(form, action) {
									var flag = action.result.success;
									if (flag) {
										Ext.MessageBox.alert("恭喜", "添加回执信息成功!相应任务单状态和订单状态已修改！");
										subTasksStore.reload();
										AddFeedbackwin.hide();
									}
								},
								failure : function(form, action) {
									subTasksStore.reload();
									Ext.MessageBox.alert("提示!", "保存回执信息失败!");
								}
							});
				}
			}
		}, {
			text : "重置",
			minWidth : 70,
			qtip : "重置数据",
			handler : function() {
				AddFeedbackForm.getForm().reset();
			}
		}, {
			text : "取 消",
			minWidth : 70,
			handler : function() {
				AddFeedbackwin.hide();
			}
		}]

	});
	AddFeedbackwin.show();
}
