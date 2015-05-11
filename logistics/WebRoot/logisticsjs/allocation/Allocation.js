var AllocationStore;Allocation=function(node)
{
	//--------------------------------------
	 //分页每页显示数量	 
	var pageSize = 12;
	// 查询订单
	 AllocationFields = ["orderId", "requiredDate",
			"orderType", "orderState","receiveAdd", "deliverSubstation","payerAdd",
			"checkoutSubstation"];
	 AllocationStore =new Ext.data.GroupingStore({
				proxy : new Ext.data.HttpProxy({
							url:"Allocation.do?actionType=doQueryOrder",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : AllocationFields,
							root : "data",
							id : "orderId",
							totalProperty : "totalCount"
						}),
				groupField : 'requiredDate',
				sortInfo : {
					field : 'orderState',
					direction : "ASC"
				}
			});
			AllocationStore.load({params:{start:0,limit:pageSize}});
	//--------------------------------------------------列选择模式

	// 查询全部分站
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
	// 返回订单号，调度订单
	var AllocationOrderFields = Ext.data.Record.create([{
				name : 'orderId',
				mapping : 'orderId'
			}, {
				name : 'orderId',
				mapping : 'orderId'
			}]);
	// --------------------------------------------------列选择模式

	var sm = new Ext.grid.CheckboxSelectionModel({

		dataIndex:"orderId"
	});
	//--------------------------------------------------列头
	        
	var cm = new Ext.grid.ColumnModel([
		sm,{
		header:"订单ID",
		dataIndex:"orderId",
		tooltip:"订单唯一标识ID",
		width:80,
        sortable:true
	},{
		header:"要求完成日期",
		dataIndex:"requiredDate",
		tooltip:"要求完成日期",
		width:80,
		sortable:true,
        renderer:function(value){
            return "<b><font color=red>"+value+"</font></b>&nbsp;"
        }
	},{
		header:"订单类型",
		dataIndex:"orderType",
		tooltip:"订单所属类型",
		width:80,
        sortable:true
	},{
        header : "订单状态",
        dataIndex:"orderState",
		tooltip:"订单所属状态",
		width:80,
        sortable:true,
        renderer:function(value){
            return "<b><font color=red>"+value+"</font></b>&nbsp;"
        },
		editor : new Ext.form.ComboBox({
			displayField : 'show',
			valueField : 'value',
			triggerAction : "all",
		    store : new Ext.data.SimpleStore({
			fields : ["show", "value"],
			data : [["可分配", "可分配"]]
		    }),
		    typeAhead : true,
			forceSelection : true,
			triggerAction : 'all',
			selectOnFocus : true,
			width : 80,
			mode:'local'
			})
	},{
		header:"送货地址",
		dataIndex:"receiveAdd",
		tooltip:"送货地址",
		width:80,
        sortable:true
	},
    {
		header:"货物投递分站",
		dataIndex:"deliverSubstation",
		tooltip:"货物投递分站",
		width:80,
        sortable:true,
      	renderer : function(value, meta, record, rowIndex, colIndex,
						store) {
					if (value == null) {
						return "双击调度";
					} else {
						return "<b><font color=#008B8B>"
								+ value
								+ "</font></b>";
					}
					},
					
				editor : new Ext.form.ComboBox({
					 tpl: '<tpl for="."><div ext:qtip="{substationAdd}. {typeRemark}" class="x-combo-list-item">{substationAdd}</div></tpl>',
					store : SubStationStore,
					typeAhead : true,
					forceSelection : true,
					triggerAction : 'all',
					selectOnFocus : true,
					width : 130,
					value : "substationAdd",
					editable : false,
					displayField : 'substationAdd',
					valueField : 'substationId',
					mode : 'remote'
				})
	},{
		header:"付款人地址",
		dataIndex:"payerAdd",
		tooltip:"付款人地址",
		width:80,
        sortable:true
	},{
		header:"异地收款分站",
		dataIndex:"checkoutSubstation",
		tooltip:"异地收款分站",
		width:80,
        sortable:true,
         renderer : function(value, meta, record, rowIndex, colIndex,
						store) {
					if (value == null) {
						return "双击调度";
					} else {
						return "<b><font color=#008B8B>"
								+ value
								+ "</font></b>";
					}
				},
				editor : new Ext.form.ComboBox({
				 tpl: '<tpl for="."><div ext:qtip="{substationAdd}. {typeRemark}" class="x-combo-list-item">{substationAdd}</div></tpl>',
					store : SubStationStore,
					typeAhead : true,
					forceSelection : true,
					triggerAction : 'all',
					selectOnFocus : true,
					width : 130,
					value : "substationAdd",
					editable : false,
					displayField : 'substationAdd',
					valueField : 'substationId',
					mode : 'remote'
				})
	}]);    
	// ----------------------------------------------------定义grid
	var Allocationgrid = new Ext.grid.EditorGridPanel({
		id : "AllocationGridId",
		store : AllocationStore,
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
			hideGroupedColumn : true,
			columnsText : '列显示/隐藏',
			groupByText : '根据本列分组',
			showGroupsText : '是否采用分组显示',
			groupTextTpl : '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length>=0 ? "条调度信息" : "暂无调度信息"]})'
		}),
		bbar : new Ext.PagingToolbar({
					store : AllocationStore,
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
				new Ext.Toolbar.TextItem("<font color=red>请选择订单完成日期：</font>"),
				"", "-", {
					name : "requiredDate",
					id : "requiredDate",
					xtype : 'datefield',
					format:"Y-m-d",		
					fieldLabel : "完成日期",
					typeAhead : true,
					width : 150,
					allowBlank : true
			}	, "", "-", {
					labelfield : "订单类型",
					xtype : "combo",
					tootip : "订单类型",
					iconCls : "editicon",
					hiddenName : "orderType",
					width : 120,
					readOnly : true,
					mode : "local",
					emptyText : '请选择订单类型',
					displayField : "show",
					valueField : "value",
					triggerAction : "all",
					store : new Ext.data.SimpleStore({
								fields : ["show", "value"],
								data : [["新订", "新订"], ["异地收费", "异地收费"]]
							})
				}, "", "-", {
					labelfield : "是否到货",
					xtype : "combo",
					tootip : "是否到货",
					iconCls : "editicon",
					hiddenName : "shortageState",
					width : 120,
					readOnly : true,
					mode : "local",
					emptyText : '请选择是否到货',
					displayField : "show",
					valueField : "value",
					triggerAction : "all",
					store : new Ext.data.SimpleStore({
								fields : ["show", "value"],
								data : [["缺货", "缺货"], ["已解决", "已解决"]]
							})
				}, "", "-", {
					text : "查询",
					tooltip : "查询符合条件的订单",
					iconCls : "serchopenroomrecord",
			     	handler : GetOrder
				},"","-",{
						text:"调度",
						tooltip:"调度管理",
						iconCls:"refreshicon",
						handler:AllocationOrder
		}],
			listeners : {
			'contextmenu' : function(e) {
				e.stopEvent();
			},
			"afteredit" : function(e) {
				var g = e.grid;// 得到当前grid
				var r = e.record;// 得到当前行所有数据
				var f = e.field;// 得到修改列
				var v = e.value;// 得到修改列修改后值
				var orgin = e.originalValue;// 修改列修改前值
				var row = e.row;// 当前行索引
				var col = e.column;// 当前点击的列索引
				// alert("ID："+r.data.id+"-field:"+f+"-value:"+v+"-修改前值："+orgin+"-坐标:"+row+","+col);
				// 通过ajax请求修改数据
			//	alert("deliverSubstation"+r.data.deliverSubstation);
			if(orgin == "手动调度" || (orgin == "异地收费调度" && r.data.orderType == "异地收费" || f == "orderState")){
			Ext.Ajax.request({
								url : "Allocation.do?actionType=doModOrder",
								method : "POST",
								params : {
									field : f,
									value : v,
									orderid : r.data.orderId
								},
								
								success : function(response, option) {
									var responseArray = Ext.util.JSON
											.decode(response.responseText);
									var flag = responseArray.success;
									if (flag) {
										Ext.Msg.alert("恭喜您", "更新成功");
									}else {
										Ext.Msg.alert("对不起", responseArray.msg);
									}
									AllocationStore.reload();
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
									AllocationStore.reload();
								}
							});
			
			
			}
			else{
			
			AllocationStore.reload();
			                        Ext.Msg.alert("提示","对不起，不能修改");
			}	
					
			},
			"rowcontextmenu" : function(grid, rowIndex, e) {
				e.stopEvent();
			}
		}
	});
	GridMain(node, Allocationgrid, "roomicons");
}

function GetOrder(){
	var requiredDate2 = Ext.get("requiredDate").dom.value;
    var orderType2 = Ext.get("orderType").dom.value;
    var shortageState2 = Ext.get("shortageState").dom.value;
    AllocationStore.reload
    ({
            params:{start:0,limit:12,requiredDate:requiredDate2,orderType:orderType2,shortageState:shortageState2}
    });
}


//获取选择的行
function AllocationOrder()
{
        var row=Ext.getCmp("AllocationGridId").getSelectionModel().getSelections();
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","请您至少选择一个!");
        }
        else
        { 
                Ext.Msg.confirm("提示!","您确定要调度吗?",function(btn){ 
                if(btn=="yes")
                {
                	ToAllocationOrders(row);
                }
                else
                {
                   
                }
            })
       	 }  
  
}

//请求后台
ToAllocationOrders=function(row)
{
     var orderIds="";
    for(var i=0;i<row.length;i++)
    {
                if(row.length==1)
                {
                    orderIds=row[i].data.orderId;                
                }
                else
                {                  
                    if(i<(row.length-1))
                    {
                        orderIds=row[i].data.orderId+","+orderIds; 
                    }
                    if(i==(row.length-1))
                   {
                        orderIds=orderIds+row[i].data.orderId;       
                   } 
                }
     } 
     
      Ext.Ajax.request({
            url : "Allocation.do?actionType=doAllocationOrder",
			method : "POST",
            params:{
                   orderIds:orderIds,    
            },
            success:function(response,option)
            {
                   var responseArray = Ext.util.JSON.decode(response.responseText); 
                   var flag = responseArray.success;
                   if(flag){
                   		Ext.Msg.alert("恭喜您","生成任务单和调拨单成功");
                   }else{
                   		Ext.Msg.alert("对不起",responseArray.msg);
                   }
                   AllocationStore.reload();
            },
            failure:function(response,option)
            {
	                var responseArray = Ext.util.JSON.decode(response.responseText); 
	                Ext.Msg.alert("系统错误",responseArray.msg);
	                Ext.Msg.alert("恭喜您,生成任务单和调拨单成功");
                   		AllocationStore.reload();
            }
            });
}

 


