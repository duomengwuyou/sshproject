// JScript 文件
/**
 * 订单管理
 * @author:罗荣博
 */
var OrderStore;

OrderManage=function(node){
	alert("进到Ordermange中了");
	//分页每页显示数量	 
	var pageSize = 12;
	//指定列参数
	var fields = ["orderId","customerId","customerName","mobile","orderType","orderState","orderDate"];

	OrderStore = new Ext.data.Store({	 
		 proxy:new Ext.data.HttpProxy({
                url:"servlet/LogServlet",//~~~~~~~~~~~~~~~~~~`
                method:"POST"
           }),
           reader:new Ext.data.JsonReader({
				fields:fields,
                root:"data",
                id:"orderId",
                totalProperty:"totalCount"
           })
	});
	//加载时参数
	 OrderStore.load({params:{start:0,limit:pageSize}}); 
	alert("1");
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"orderId"
	});
	//--------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([
		sm,
	{
		header:"订单号",
		tooltip:"订单的唯一标识",
		dataIndex:"orderId",
        sortable:true,
        renderer:function(value){
            return "<font color=red>"+value+"</font>";
        }
	},{
		header:"客户编号",
		tooltip:"客户的唯一标识",
		dataIndex:"customerId",
        sortable:true,
        renderer:function(value){
            return "<font color=blue>"+value+"</font>";
        }
	},{
		header:"客户姓名",
		tooltip:"客户姓名",
		dataIndex:"customerName",
        sortable:true,
        renderer:function(value){
            return "<font color=#EE9572>"+value+"</font>";
        }
	},{
		header:"移动电话",
		tooltip:"用户的移动电话",
		dataIndex:"mobile",
        sortable:true
	},{
		header:"订单类型",
		tooltip:"订单类型",
		dataIndex:"orderType",
        sortable:true
    },{
		header:"订单状态",
		tooltip:"订单状态",
		dataIndex:"orderState",
		//可以进行排序
        sortable:true
	},{
		header:"订单日期",
		tooltip:"订单日期",
		dataIndex:"orderDate",
		//可以进行排序
        sortable:true
	}]);
   alert("2");
    //----------------------------------------------------定义grid
	var Ordergrid = new Ext.grid.GridPanel({
	    id:"Ordergrid",
		store:OrderStore,
		sm:sm,
		cm:cm,
		loadMask:true,
		//超过长度带自动滚动条
		autoScroll:true,
		border:false,
		viewConfig:{
			columnsText:"显示/隐藏列",
			sortAscText:"正序排列",
			sortDescText:"倒序排列",
			forceFit:true
		},
		//分页
		bbar:new Ext.PagingToolbar({
			store:OrderStore,
			pageSize:pageSize,
			//显示右下角信息
			displayInfo:true,
			displayMsg:'当前记录 {0} -- {1} 条 共 {2} 条记录',
		    emptyMsg:"No results to display",
		    prevText:"上一页",
			nextText:"下一页",
			refreshText:"刷新",
			lastText:"最后页",
			firstText:"第一页",
			beforePageText:"当前页",
			afterPageText:"共{0}页"
		
		}),
		tbar:[
		new Ext.Toolbar.Fill(),
		new Ext.Toolbar.TextItem("请选择查询条件"),
		"","-",{
			name:"startTime",
			id:"startTime",
			xtype:'datefield',
			format:"Y-m-d",
		//	format:"Y-m-d H:i:s.g",
			typeAhead: true,
			emptyText:'请选择开始时间',
			//width:150,
			allowBlank:false,
			blankText:"起始时间不允许为空" 
		},"","-",{
			name:"endTime",
			id:"endTime",
			xtype:'datefield',
			format:"Y-m-d",
		//	format:"Y-m-d H:i:s.g",
			typeAhead: true,
			emptyText:'请选择结束时间',
			//width:150,
			allowBlank:false,
			blankText:"结束时间不允许为空"
		},"","-",{
			name:"orderId",
			id:"orderId",
			emptyText:'按订单号查询',
			xtype:'textfield',
			width:100,
			baseCls:'x-plain'
		},"","-",{
			id:"orderType",
			//fieldLabel:"订单类型",
			xtype:'combo',
			emptyText:'按订单类型查询',
			hiddenName:"orderType",
			mode:"local",
			displayField:"show",
			valueField:"value",
			triggerAction:"all",
			width:100,
			value:"0",
			store:new Ext.data.SimpleStore({
			fields:["show","value"],
				data:[["全部","0"],["新订","1"],["异地收费","2"]]
			})
		},"","-",{
			id:"orderState",
			xtype:'combo',
			emptyText:'按订单状态查询',
			hiddenName:"orderState",
			mode:"local",
			displayField:"show",
			valueField:"value",
			triggerAction:"all",
			value:"0",
			width:100,
			store:new Ext.data.SimpleStore({
			fields:["show","value"],
				data:[["可分配","0"],["缺货","1"],["已调度","2"],["中心库房出库","3"],["分站到货","4"],["已分配","5"],["已领货","6"],["已完成","7"],["失败","8"]]
			})
		}
		,"","-",{
			name:"customerName",
			id:"customerName",
			xtype:'textfield',
			typeAhead: true,
			emptyText:'按客户姓名查询',
			width:100,
			allowBlank:true
		},"","-",{
			name:"mobile",
			id:"mobile",
			xtype:'textfield',
			typeAhead: true,
			emptyText:'按联系电话查询',
			width:100,
			allowBlank:true
		},"","-"],listeners:{
            'contextmenu':function(e)
            {
                e.stopEvent();
            }
		}
	});
	alert("3");
	//传入icon样式
	GridMain(node,Ordergrid,"guesticon");
}

//-------------------------------------------------------搜索
function GetOrderWanted(){
	var startTime = Ext.get("startTime").dom.value;
//	alert("Ext.get(startTime).dom.value"+Ext.get("startTime").dom.value);
	var endTime = Ext.get("endTime").dom.value;
	var orderId = Ext.get("orderId").dom.value;
	var orderType = Ext.get("orderType").dom.value;
	var orderState = Ext.get("orderState").dom.value;
	var customerName = Ext.get("customerName").dom.value;
	var mobile = Ext.get("mobile").dom.value;
	
	OrderStore.reload({
		params:{start:0,limit:12,startTime:startTime,endTime:endTime,orderId:orderId,orderType:orderType,orderState:orderState,customerName:customerName,mobile:mobile}
	});
}