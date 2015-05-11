/**
 * 
 * 作者 ：罗荣博
 * 功能 ： 查看订单
 * 
 */
var  OrderDetailStore;
var  ProductStore;

var  guestId;
//var ConsumeRecordStore;
//var PurchaseStore;
OrderDetailInfo = function(node){
//OrderDetailInfo = function(){
//alert("orderdetailINfo");
//alert(node);
	//分页数大小
	var pageSize = 10;
	var orderDetailField = ["orderId","customerId","customerName","idCard","deliverSubstation","signedDate",
	"orderDate","receiveAdd","reveivePerson","reveivePersonTel","reveivePersonZip","orderType"];
	
	var productInfoField = ["productId","parentCategory","category","productName","originalPrice",
	"unit","productRemark","orderItemAmount","totalPrice","orderState"];
	
	OrderDetailStore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : "orderDetail.do?actionType=findOrderDetail&orderId="+node,
			method : "POST"
		}),
		reader : new Ext.data.JsonReader({
			fields : orderDetailField,
			root : "data",
			id : "orderId",
			totalProperty : "totalCount"
		})
	});
	//OrderDetailStore.load();
	OrderDetailStore.load({params : {start : 0, limit : pageSize}});
	
	ProductStore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : "productDetail.do?actionType=findProductDetail&orderId="+node,
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
//	function FiltGoodsInfo(){
//		var goodsTypeSelected = Ext.get("goodsType").dom.value;
//		ConsumeRecordStore.reload({
//			params:{gType : goodsTypeSelected}
//		});
//	}
	
	var sm1= new Ext.grid.CheckboxSelectionModel({
		dataIndex:"orderId"
	});
	//订单详细信息内容
	var orderDetailColumn = new Ext.grid.ColumnModel([sm1,{
		header : "订单号",
        dataIndex : "orderId",
        menuDisabled : true,
        width : 20,
        //排序
        sortable : true
	},{
		header : "客户编号",
        dataIndex : "customerId",
        menuDisabled : true,
        width : 20,
        //排序
        sortable : true
	},{
		header : "客户姓名",
        dataIndex : "customerName",
        menuDisabled : true,
        width : 20,
        //排序
        sortable : true
	},{
		header : "身份证编号",
        dataIndex : "idCard",
        menuDisabled : true,
        width : 40,
        //排序
        sortable : true
	},{
         header : "配送分站",
         dataIndex : "deliverSubstation",
         width : 20,
         sortable : true
  	 },{
		header : "送货日期",
        dataIndex : "signedDate",
        menuDisabled : true,
        width : 30,
        //排序
        sortable : true
	},{
		header : "订单生成日期",
        dataIndex : "orderDate",
        menuDisabled : true,
        width : 30,
        //排序
        sortable : true
	},{
		header : "送货地址",
        dataIndex : "receiveAdd",
        menuDisabled : true,
        width : 40,
        //排序
        sortable : true
	},{
		header : "收货人",
        dataIndex : "reveivePerson",
        menuDisabled : true,
        width : 20,
        //排序
        sortable : true
	},{
		header : "收货人电话",
        dataIndex : "reveivePersonTel",
        menuDisabled : true,
        width : 30,
        //排序
        sortable : true
	},{
		header : "邮编",
        dataIndex : "reveivePersonZip",
        menuDisabled : true,
        width : 20,
        //排序
        sortable : true
	},{
		header : "订单类型",
        dataIndex : "orderType",
        menuDisabled : true,
        width : 20,
        //排序
        sortable : true
	}]);

	//订单详细信息
	var orderInfo = new Ext.form.FieldSet({
		collapsible : true,
        title : "订单信息",
        border : true,
       // labelWidth : 75,
        width : 900,
       // buttonAlign :'center',
        autoHeight : true,
        layout : 'form',
        defaults : {autoWidth:true},
        items : [{
        	id:'orderInfo',
        	xtype:'grid',
        	height:250,
        	cm:orderDetailColumn,
        	loadMask:true,
        	store:OrderDetailStore,
        	border:false,
        	viewConfig : {
                columnsText : "显示/隐藏列",
                sortAscText : "正序排列",
                sortDescText : "倒序排列",
                forceFit : true
            },
            sm : sm1,

            bbar:new Ext.PagingToolbar({
                store : OrderDetailStore,
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
                afterPageText : "共{0}页",
                scope:this
            }),
            listeners:{
                "render": function(g) {
		            g.getSelectionModel().selectRow(0);
	            },
	            delay: 10 
            }
        }]
	});
	
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"productId"
	});
	//商品信息条目
		var productInfoColumn = new Ext.grid.ColumnModel([sm,{
		header:"商品编号",
        dataIndex:"productId",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"商品一级分类",
        dataIndex:"category",
        menuDisabled:true,
        width:20,
        //排序
        sortable:true
	},{
		header:"商品二级分类",
        dataIndex:"parentCategory",
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
        width　:　900,
        autoHeight　:　true,
        layout　:　'form',
        defaults　:　{autoWidth:true},
        items :　[{
        	id : 'ProductInfo',
        	xtype : 'grid',
            height : 250,
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
            sm : sm,
            bbar:new Ext.PagingToolbar({
            	scope:this,
                store : ProductStore,
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
                afterPageText : "共{0}页",
                scope:this
            }),
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
        bodyStyle : 'padding:5px',
        autoWidth : true,
        aotoHeight : true,
        border : false,
        layout : 'column',
        defaults : {anchor:"95%"},
        items : [
		{
			columnWidth: 0.5,
			layout:'form',
		    autoWidth:true,
		    height:630,
		    bodyStyle: Ext.isIE ? 'padding:0 0 5px 15px;' : 'padding:10px 15px;',
		    border: true,
		    style: {
		        "margin-left": "10px", 
		        "margin-right": Ext.isIE6 ? (Ext.isStrict ? "-10px" : "-13px") : "0"  
		    },
		    items: [orderInfo,ProductInfo]
		}]
	}); 

//    GridMain(node,ConsumeRecordGridForm,"totalicon");

	//弹出查看订单Window
     var seeOrderWin=new Ext.Window({
			title:"查看订单",
			width:1000,
			height:670,
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
		//	listeners:{
				//   "show":function(e){
				   	
				   		//alert("前台穿过来的row[0]为"+row[0]);
                       // seeOrderGridForm.getForm().loadRecord(row[0]);//直接加载一行数据
                      	
                       // alert(rows.data.
					//当window show事件发生时清空一下表单
			    //    seeOrderGridForm.getForm().reset();
				//	}
		//	}
	});   
	//alert("seeOrderWin");
	seeOrderWin.show();
}
 