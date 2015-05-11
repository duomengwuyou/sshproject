// JScript 文件
AddWareHouse = function() {
ManageFields = Ext.data.Record.create([{
				name : 'userId',
				mapping : 'userId'
			}, {
				name : 'Username',
				mapping : 'Username'
			}]);
	ManageStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url: "ManageStore.do",
							method:'post'
						}),
				reader : new Ext.data.JsonReader({
							root : 'data',
							id : 'userId'
						}, ManageFields),
				sortInfo : {
					field : 'userId',
					direction : "ASC"
				}
			});
	ManageStore.load(); 
	var AddWareHouseForm = new Ext.form.FormPanel({
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
					name : "warehouseName",
					fieldLabel : '库房名称',
					allowBlank : false
				}, {
					name : "warehouseAdress",
					fieldLabel : '库房地址',
					allowBlank : false
				}, {
					xtype : "combo",
					name : 'warehouseType',
					fieldLabel : '库房类型',
					allowBlank : false,
					editable : false,
					hiddenName : 'warehouseType',
					store : new Ext.data.SimpleStore({
								data : [["分库", "分库"],["中心库房", "中心库房"]],
								fields : ["warehouseType", "value"]
							}),
					displayField : "warehouseType",
					mode : "local",
					valueField : "value",
					triggerAction : "all"
				},{
					name : "warehouseManager",
					tpl: '<tpl for="."><div ext:qtip="{Username}" class="x-combo-list-item">{Username}</div></tpl>',
	                xtype : "combo",
					store : ManageStore,
					typeAhead : true,
					fieldLabel : '管理员',
					hiddenName : 'warehouseManager',
					forceSelection : true,
					triggerAction : 'all',
					selectOnFocus : true,
					width : 130,
					editable : false,
					allowBlank : false,
					displayField : 'Username',
					valueField : 'userId',
					mode : 'remote'
				}
				]
	});
	var AddWareHouseWin = new Ext.Window({
		title : "增加库房",
		width : 410,
		height : 250,
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
		items : [AddWareHouseForm],
		listeners : {
			"show" : function() {
				// 当window show事件发生时清空一下表单
				AddWareHouseForm.getForm().reset();
			}
		},
		buttons : [{
			text : "保存信息",
			minWidth : 70,
			handler : function() {
				if (AddWareHouseForm.getForm().isValid()) {
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
					AddWareHouseForm.form.submit({
								url : "warehouse.do?actionType=add",
								method : "POST",
								success : function(form, action) {
									/*var flag = action.result.success;
									if (flag) {*/
										Ext.MessageBox.alert("恭喜", "设置库房成功!"); 
										WareHouseStore.reload();
										AddWareHouseWin.hide();
									/*}*/
								},
								failure : function(form, action) { 
									Ext.MessageBox.alert("提示!", "保存库房信息失败!");
								}
							});
				}
			}
		}, {
			text : "重置",
			minWidth : 70,
			qtip : "重置数据",
			handler : function() {
				AddWareHouseForm.getForm().reset();
			}
		}, {
			text : "取 消",
			minWidth : 70,
			handler : function() {
				AddWareHouseWin.hide();
			}
		}]

	});
	AddWareHouseWin.show();
}
