
WriteStoreInfo = function(tempID) {
	var InStoreForm = new Ext.form.FormPanel({
				width : 350,
				height : 250,
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
					name : "purchaseProductOrderId",
					width : 100,
					fieldLabel : "<font color=red>购货单号</font>",
					value: tempID
			  },{
					name : "productPurchaseState",
					fieldLabel : "购货单状态",
					xtype : "combo",
					tootip : "购货单状态",
					iconCls : "editicon",
					mode : "local",
					displayField : "show",
					valueField : "value",
					triggerAction : "all",
					//value : "1",
					store : new Ext.data.SimpleStore({
								fields : ["show", "value"],
								data : [["完全到货", "完全到货"], ["部分到货", "部分到货"], ["未到货", "未到货"]]
							})
			  },{
					xtype : "datefield",
					name : "purchaseDate",
					format : "Y-m-d",
					fieldLabel : "入库时间",
					allowBlank : false,
					minValue : "2011-6-28"
				},{
					name : "puchaseRemark",
					xtype : "textarea",
					fieldLabel : "购货单备注",
					allowBlank : false,
					blankText : "房间描述不允许为空",
					regex : /^[\s\S]{1,25}$/,
					regexText : "房间描述请不要超过25个字符"
				}]
			});
	var InStoreWin = new Ext.Window({
		title : "填写购货单信息",
		width : 400,
		height : 300,
		plain : true,
		// layout:"form",
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
		items : [InStoreForm],
		listeners : {
			"show" : function() {
				// 当window show事件发生时清空一下表单
				//InStoreForm.getForm().loadRecord(row);
			}
		},
		buttons : [{
			text : "保存信息",
			minWidth : 70,
			handler : function() {
				if (InStoreForm.getForm().isValid()) {
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
					InStoreForm.form.submit({
								url : "PurchaseProductOrderItemStore.do?actionType=saveInStorage",
								method : "POST",
								success : function(form, action) {
									// 成功后
									var flag = action.result.success;
									if (flag) {
										Ext.MessageBox.alert("恭喜您", "入库成功");
										PurchaseProductOrderItemStore.reload();
										InStoreWin.close();
									}
								},
								failure : function(form, action) {
									PurchaseProductOrderItemStore.reload();
									Ext.MessageBox.alert("提示!", "入库失败!");
								}
							});
				}
			}
		}, {
			text : "重置",
			minWidth : 70,
			qtip : "重置数据",
			handler : function() {
				InStoreForm.getForm().reset();
			}
		}, {
			text : "取 消",
			minWidth : 70,
			handler : function() {
				InStoreWin.close();
			}
		}]

	});

	InStoreWin.show();
}