// JScript 文件
var TaskOrderStore;
TaskOrderQuery = function(node) {
	var pageSize = 12;
	// 指定列参数
	var TaskOrderFields = Ext.data.Record.create(["taskOrderId", "orderId",
			"deliverman", "taskOrderState", "taskOrderType",
			"operator","operateDate"]);

	//store任务订单
	TaskOrderStore	=new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url:"TaskOrderQuery.do?actionType=doQueryTaskOrder",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : TaskOrderFields,
							root : "data",
							id : "taskOrderId",
							totalProperty : "totalCount"
						}),
				groupField : 'taskOrderType',
				sortInfo : {
					field : 'taskOrderId',
					direction : "ASC"
				}
				
			});
			TaskOrderStore.load({params:{start:0,limit:pageSize}});
		//得到任务单号
		var TaskOrderIdFields = Ext.data.Record.create([
		{name:'taskOrderId',mapping:'taskOrderId'},{name:'taskOrderId',mapping:'taskOrderId'}
		]);
		
		//store任务单号
		TaskOrderIdStore = new Ext.data.Store({
		proxy: new Ext.data.HttpProxy({
		url: "TaskOrderQuery.do?actionType=doQueryOrderId",
		method:"POST"
		}),
		reader:new Ext.data.JsonReader({
		root:'data',
		id:'taskOrderId'
		},
		TaskOrderIdFields
		),
		sortInfo:{field:'taskOrderId',direction:"ASC"}
		});
		TaskOrderIdStore.load();
		//得到执行货物分站
		// 指定列参数
	var SubStationFields = Ext.data.Record.create([{
				name : 'substationId',
				mapping : 'substationId'
			}, {
				name : 'substationAdd',
				mapping : 'substationAdd'
			}]);
	var SubStationStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url : "Allocation.do?actionType=doFindAllSubstation",
							method:'post'
						}),
				reader : new Ext.data.JsonReader({
							root : 'data',
							id : 'substationId'
						}, SubStationFields),
				sortInfo : {
					field : 'substationAdd',
					direction : "ASC"
				}
			});
	SubStationStore.load();
	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "taskOrderId"
			});
	// --------------------------------------------------列头

	var cm = new Ext.grid.ColumnModel([sm, {
				header : "任务单号",
				dataIndex : "taskOrderId",
				tooltip : "任务单唯一标识ID",
				width : 80,
				sortable : true
			}, {
				header : "订单号",
				dataIndex : "orderId",
				tooltip : "订单唯一标识ID",
				width : 80,
				sortable : true
			}, {
				header : "配送员",
				dataIndex : "deliverman",
				tooltip : "配送员",
				width : 80,
				sortable : true
			}, {
				header : "任务单状态",
				dataIndex : "taskOrderState",
				tooltip : "任务单所属状态",
				width : 80,
				sortable : true
			}, {
				header : "任务单类型",
				dataIndex : "taskOrderType",
				tooltip : "任务单所属类型",
				width : 80,
				sortable : true
			}, {
				header : "操作人员",
				dataIndex : "operator",
				tooltip : "任务单操作人员",
				width : 80,
				sortable : true
			}, {
				header : "任务单生成日期",
				dataIndex : "operateDate",
				tooltip : "操作人员生成任务单的日期",
				width : 80,
				sortable : true
			}]);
	
	// ----------------------------------------------------定义grid
	var TaskOrderQuerygrid = new Ext.grid.EditorGridPanel({
		id : "TaskOrderQueryGrid",
		store : TaskOrderStore,
		sm : sm,
		cm : cm,
		loadMask : true,
		stripeRows : true,
		clicksToEdit : 2,
		autoScroll : true,
		border : false,
		view : new Ext.grid.GroupingView({
			// 自动填充
			forceFit : true,
			sortAscText : '正序排列',
			sortDescText : '倒序排列',
			columnsText : '列显示/隐藏',
			groupByText : '根据本列分组',
			showGroupsText : '是否采用分组显示',
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条调度信息" : "暂无调度信息"]})'
		}),
		// 分页
		bbar : new Ext.PagingToolbar({
					store : TaskOrderStore,
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
				new Ext.Toolbar.TextItem("<font color=red>请输入查询条件：</font>"),
				"", "-", {
					name : "requiredDate",
					id : "requiredDate",
					xtype : 'datefield',
					format : "Y-m-d",
					fieldLabel : "完成日期",
					emptyText : '完成日期',
					typeAhead : true,
					width : 100,
					
					allowBlank : true
			}	, "", "-", {
					xtype : "combo",
					tootip : "任务单号",
					iconCls : "editicon",
					hiddenName : "taskOrderId",
					store:TaskOrderIdStore,
					width : 80,
					readOnly : true,
					mode : "remote",
					emptyText : '任务单号',
					displayField : "taskOrderId",
					valueField : "taskOrderId",
					triggerAction : "all",
				}, "", "-", {
					labelfield : "任务单类型",
					xtype : "combo",
					tootip : "任务单类型",
					iconCls : "editicon",
					hiddenName : "taskOrderType",
					width : 95,
					readOnly : true,
					mode : "local",
					emptyText : '任务单类型',
					displayField : "show",
					valueField : "value",
					triggerAction : "all",
					store : new Ext.data.SimpleStore({
								fields : ["show", "value"],
								data : [["全部", "全部"], ["收款", "收款"],
										["送货收款", "送货收款"], ["送货", "送货"],
										["退货", "退货"], ["换货", "换货"]]
							})
				}, "", "-", {
					xtype : "combo",
					tootip : "任务单状态",
					iconCls : "editicon",
					hiddenName : "taskOrderState",
					width : 95,
					readOnly : true,
					mode : "local",
					emptyText : '任务单状态',
					displayField : "show",
					valueField : "value",
					triggerAction : "all",
					store : new Ext.data.SimpleStore({
								fields : ["show", "value"],
								data : [["已调度", "已调度"], ["可分配", "可分配"],
										["已分配", "已分配"], ["已领货", "已领货"], ["已完成", "已完成"]]
							})
				}, "", "-", {	
					labelfield : "执行任务分站",
					xtype : "combo",
					tootip : "执行任务分站",
					iconCls : "editicon",
					hiddenName : "deliverSubstation",
					store : SubStationStore,
					width : 100,
					readOnly : true,
					mode : "remote",
					displayField : "substationAdd",
					valueField : "substationId",
					emptyText : '执行任务分站',
					triggerAction : "all"
					
				}, "", "-",new Ext.Toolbar.TextItem("<font color=red>客户姓名</font>"),
				{
					name : "custormerName",
					id : "custormerName",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 90,
					xtype : "textfield",
					allowBlank : true
				}, "", "-",new Ext.Toolbar.TextItem("<font color=red>联系方式</font>"),
				{
					name : "receivePersonTel",
					id : "receivePersonTel",// 注意获取textfield的值不能采用hiddenName(combox才用)
					width : 100,
					xtype : "textfield",
					allowBlank : true
				}, "", "-", {
					text : "查询",
					tooltip : "查询符合条件的任务单",
					iconCls : "serchopenroomrecord",
					handler :GetTaskOrder
				}],
	});
	GridMain(node, TaskOrderQuerygrid, "roomicons");
}
GetTaskOrder=function(){
	var tempDate = Ext.get("requiredDate").dom.value;
	var tempTaskOrderId = Ext.get("taskOrderId").dom.value;
	var tempTaskOrderType = Ext.get("taskOrderType").dom.value;
	var tempTaskOrderState = Ext.get("taskOrderState").dom.value;
	var tempDeliverSubstation = Ext.get("deliverSubstation").dom.value;
	var tempcustormerName = Ext.get("custormerName").dom.value;
	var tempReceivePersonTel = Ext.get("receivePersonTel").dom.value;
	TaskOrderStore.reload({
						params : {requiredDate:tempDate,taskOrderId:tempTaskOrderId,
						taskOrderType:tempTaskOrderType,taskOrderState:tempTaskOrderState,
						deliverSubstation:tempDeliverSubstation,custormerName:tempcustormerName,
						receivePersonTel:tempReceivePersonTel}
						});
}
