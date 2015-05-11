
//显示任务单详情 李莎

showDetailedInfo = function(node){
	//分页数大小
	var pageSize = 10;

	var taskOrderDetailField = ["taskorderid","taskstate","tasktype","Order","orderstate","deliversubstation","customername","requireddate",
	"ordertype","receiveAdd"];
	
	var productInfoField = ["productId","parentCategory","category","productName","originalPrice",
	"unit","productRemark","orderItemAmount","totalPrice","orderState"];
	taskOrderDetailStore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : "taskOrderDetail.do?actionType=doSearch&taskid="+node,
			method : "POST"
		}),
		reader : new Ext.data.JsonReader({
			fields : taskOrderDetailField,
			root : "data",
			id : "customerId",
			totalProperty : "totalCount"
		})
	});
	taskOrderDetailStore.load({params : {start : 0, limit : pageSize}});
	
	ProductStore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : "taskOrderProductDetail.do?actionType=doSearch&taskid="+node,
			method : "POST"
		}),
		reader : new Ext.data.JsonReader({
			fields : productInfoField,
			root : "data",
			id : "productId",
			totalProperty : "totalCount"
		})
	});
	ProductStore.load({params : {start : 0, limit : pageSize}});

	//--------------------------------------------------列选择模式
		//任务单信息条目
	var taskdetailInfoColumn = new Ext.grid.ColumnModel([{
		header:"任务单号",
        dataIndex:"taskorderid",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"任务单状态",
        dataIndex:"taskstate",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"任务单类型",
        dataIndex:"tasktype",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"对应的订单",
        dataIndex:"Order",
        menuDisabled:true,
        widdth:20,
       sortable:true
	},{
		header:"订单状态",
        dataIndex:"orderstate",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"订单类型",
        dataIndex:"ordertype",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"配送员",
        dataIndex:"deliversubstation",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"收货人",
        dataIndex:"customername",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"要求完成日期",
        dataIndex:"requireddate",
        menuDisabled:true,
        widdth:20,
        sortable:true
	},{
		header:"收货地址",
        dataIndex:"receiveAdd",
        menuDisabled:true,
        widdth:20
	}]);
	//商品信息条目
	var productInfoColumn = new Ext.grid.ColumnModel([{
		header:"商品分类",
        dataIndex:"parentCategory",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"商品子类",
        dataIndex:"category",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"商品名称",
        dataIndex:"productName",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"单价",
        dataIndex:"originalPrice",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"计量单位",
        dataIndex:"unit",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"商品说明",
        dataIndex:"productRemark",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"订购数量",
        dataIndex:"orderItemAmount",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"总价",
        dataIndex:"totalPrice",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"商品状态",
        dataIndex:"orderState",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	}]);
	
	//客户购买的商品信息
	var ProductInfo = new Ext.form.FieldSet({
		collapsible　:　true,
        title　:　"商品信息",
        border　:　true,
      //  labelWidth　: 35,
        width　:　800,
        autoHeight　:　true,
        height:200,
        layout　:　'form',
        defaults　:　{autoWidth:true},
        items :　[{
        	id : 'productInfoGrid',
        	xtype : 'grid',
            height : 200,
            cm : productInfoColumn,
            loadMask : true,
            store : ProductStore,
            border : false,
            viewConfig : {
                columnsText : "显示/隐藏列",
                sortAscText : "正序排列",
                sortDescText : "倒序排列",
                forceFit : true
            },
           // sm : sm,
            bbar:new Ext.PagingToolbar({
            	scope:this,
                store : ProductStore,
                pageSize : pageSize,
                displayInfo : true,
                displayMsg : ' {0}-{1} 条',
                emptyMsg : "No results to display",
                prevText : "上一页",
                nextText : "下一页",
                refreshText : "刷新",
                lastText : "最后页",
                firstText : "第一页",
                beforePageText : "当前页",
                afterPageText : "共{0}页"
               // scope:this
            }),
            listeners:{
                "render": function(g) {
		            g.getSelectionModel().selectRow(0);
	            },
	            delay: 10 
            }
        }]
	});
	//任务单详细信息
		var taskInfo = new Ext.form.FieldSet({
		collapsible　:　true,
        title　:　"任务单详情",
        border　:　true,
      //  labelWidth　: 35,
        width　:　800,
        autoHeight　:　true,
        height:100,
        layout　:　'form',
        defaults　:　{autoWidth:true},
        items :　[{
        	id : 'taskInfoGrid',
        	xtype : 'grid',
            height : 200,
            cm : taskdetailInfoColumn,
            loadMask : true,
            store : taskOrderDetailStore,
            border : false,
            viewConfig : {
                columnsText : "显示/隐藏列",
                sortAscText : "正序排列",
                sortDescText : "倒序排列",
                forceFit : true
            },
           // sm : sm,
            listeners:{
                "render": function(g) {
		            g.getSelectionModel().selectRow(0);
	            },
	            delay: 10 
            }
        }]
	});
	
	//查看订单Form
	var seeOrderGridForm = new Ext.FormPanel({
		id : 'seeOrderGridForm',
		frame : true,
		plain:true,
        bodyStyle : 'padding:5px',
        autoWidth : true,
        aotoHeight : true,
        border : false,
        layout : "form",
        baseCls:"x-plain",
        defaultType:"textfield",
        height:800,
        bodyStyle:"padding:0 0 0 0",
        defaults:{anchor:"95%",msgTarget:"side"},
        items :[taskInfo,ProductInfo]
	}); 

	//弹出查看订单Window
     var seeOrderWin=new Ext.Window({
			title:"查看任务单详细信息",
			width:800,
			height:550,
			plain:true,
			//layout:"form",
			iconCls:"editicon",
			//不可以随意改变大小
			resizable:false,
			//是否可以拖动
			//draggable:false,
			defaultType:"textfield",
			labelWidth:100,
			collapsible:true, //允许缩放条
            closeAction : 'hide',
            closable:true,
            plain : true,
            //弹出模态窗体
			modal: 'true', 
			buttonAlign:"center",
			bodyStyle:"padding:8px 0 0 10px",
			items:[seeOrderGridForm],
			listeners:{
				   "show":function(){
			        seeOrderGridForm.getForm().reset();
					}
			}
	});   
	seeOrderWin.show();
}