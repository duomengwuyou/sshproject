/**
 * 张文华
 * 商品管理 
 */
var ProductInfostore;
var firststroe;
var secondstroe; 
ProductInfoManage=function(node){ 
	//分页每页显示数量	 
	var pageSize = 12;

	//指定列参数
	var fields = ["productId","productName","firstClassName","secondClassName","unit","originalPrice","discount","costPrice","productType","supplier","manufacturer","guaranteePeriod","returnable","changeable","productRemark"];

	ProductInfostore = new Ext.data.Store({
		 
		 proxy:new Ext.data.HttpProxy(
           {
                url:"productInfo.do?actionType=product",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
   		   {
				fields:fields,
                root:"data",
                id:"productId",
                totalProperty:"totalCount"
           })
	});
	//加载时参数
	 ProductInfostore.load({params:{start:0,limit:pageSize}}); 
	 var supplierfields=Ext.data.Record.create([{name:"supplierId",mapping:"supplierId"},
{name:"supplierName",mapping:"supplierName"},
{name:"supplierAdd",mapping:"supplierAdd"},
{name:"contactPerson",mapping:"contactPerson"},
{name:"supplierTel",mapping:"supplierTel"},
{name:"bank",mapping:"bank"},
{name:"bankAccount",mapping:"bankAccount"},
{name:"fax",mapping:"fax"},
{name:"supplierZipCode",mapping:"supplierZipCode"},
{name:"legalPerson",mapping:"legalPerson"},
{name:"supplierRemark",mapping:"supplierRemark"}]);
 var proSupplierStore=new Ext.data.Store({
 proxy:new Ext.data.HttpProxy(
           {
                url:"supplierManage.do?actionType=display",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
   		   { 
                root:"data",
                id:"supplierId"
           },supplierfields),
            sortInfo: {field:'supplierId',direction: "ASC"}   
});   
	proSupplierStore.load();
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"productId"
	});
	//--------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([
		sm,{
		header:"商品代码",
		dataIndex:"productId",
		tooltip:"商品代码",
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
		width : 60,
        sortable:true
	},
		{
		header:"商品名称",
		tooltip:"商品名称",
		dataIndex:"productName",
		//可以进行排序
		width : 60,
        sortable:true,
        editor:new Ext.form.TextField({
				 style:'text-align:left'
				 }),
        renderer:function(value)
        {
            return "<font color='blue'>"+value+"</font>"
        }
	},{
		header:"商品一级分类",
		tooltip:"商品类别",
		dataIndex:"firstClassName",
		//可以进行排序
		width : 60,
        sortable:true 
	},{
		header:"商品二级分类",
		tooltip:"商品类别",
		dataIndex:"secondClassName",
		//可以进行排序
		width : 60,
        sortable:true 
	},{
		header:"计量单位",
		tooltip:"单位",
		dataIndex:"unit",
		width : 50,
		editor:new Ext.form.TextField({
				 style:'text-align:left'
				 }),
		//可以进行排序
        sortable:true
	},{
		header:"原价",
		tooltip:"原价",
		dataIndex:"originalPrice",
		width : 60,
		//可以进行排序
        sortable:true,
        editor:new Ext.form.NumberField({
            style:'text-align:left'
        })
	},{
		header:"商品折扣",
		tooltip:"商品折扣",
		dataIndex:"discount",
		width :60,
		editor:new Ext.form.NumberField({
				 style:'text-align:left'
				 }),
		//可以进行排序
        sortable:true,
        renderer:function(value)
        {
            return "<font color='red'>"+value+"</font>"
        }
	},{
		header:"成本价",
		tooltip:"成本价",
		dataIndex:"costPrice",
		width : 60,
		editor:new Ext.form.NumberField({
				 style:'text-align:left'
				 }),
		//可以进行排序
        sortable:true,
        editor:new Ext.form.NumberField({
            style:'text-align:left'
        })
	},{
		header:"型号",
		tooltip:"型号",
		dataIndex:"productType",
		width : 60,
		editor:new Ext.form.TextField({
				 style:'text-align:left'
				 }),
		//可以进行排序
        sortable:true
	},{
		header:"供应商",
		tooltip:"供应商",
		dataIndex:"supplier",
		width : 90,
		editor:new Ext.form.ComboBox({
        	store:proSupplierStore,
            typeAhead: true,
            tpl: '<tpl for="."><div ext:qtip="{supplierName}" class="x-combo-list-item">{supplierName}</div></tpl>',
	        forceSelection: true,
            triggerAction: 'all',
            selectOnFocus:true,
            width:130, 
            editable: false, 
            displayField:'supplierName',
            valueField: 'supplierId',
            mode: 'remote'
            }),
		//可以进行排序
        sortable:true
	},{
		header:"厂商",
		tooltip:"厂商",
		dataIndex:"manufacturer",
		width : 90,
		editor:new Ext.form.TextField({
				 style:'text-align:left'
				 }),
		//可以进行排序
        sortable:true
	},{
		header:"保质期限",
		tooltip:"保质期限",
		dataIndex:"guaranteePeriod",
		width : 60,
		editor:new Ext.form.TextField({ 
				format:'Y-m-d'
				 }),
		//可以进行排序
        sortable:true
	},{
		header:"是否可退货",
		tooltip:"是否可退货",
		dataIndex:"returnable",
		width : 60,
		//可以进行排序
        sortable:true,
        /* renderer:function(value)
	    {
	        if(value==0)
	        {
	            return "否";
	        }else
	        {
	          return "是";
	        }
	    },*/
	    editor:new Ext.form.ComboBox({
	        store:new Ext.data.SimpleStore({
	            data:[["否","0"],["是","1"]],
	            fields:["state","value"]
	        }),
	        tpl: '<tpl for="."><div ext:qtip="设置是否可退货--{state}" class="x-combo-list-item">{state}</div></tpl>',
	        displayField:"state",
	        mode:"local",
	        valueField:"value",
	        triggerAction:"all"
	    })
	},{
		header:"是否可换货",
		tooltip:"是否可换货",
		dataIndex:"changeable",
		width : 60,
		//可以进行排序
        sortable:true,
       /*  renderer:function(value)
	    {
	        if(value==0)
	        {
	            return "否";
	        }else
	        {
	          return "是";
	        }
	    },*/
	    editor:new Ext.form.ComboBox({
	        store:new Ext.data.SimpleStore({
	            data:[["否","0"],["是","1"]],
	            fields:["state","value"]
	        }),
	        tpl: '<tpl for="."><div ext:qtip="设置是否可换货--{state}" class="x-combo-list-item">{state}</div></tpl>',
	        displayField:"state",
	        mode:"local",
	        valueField:"value",
	        triggerAction:"all"
	    })
	},{
		header:"商品描述",
		tooltip:"商品相关描述内容",
		dataIndex:"productRemark",
		width : 90,
		//可以进行排序
        sortable:true,
        editor:new Ext.form.TextField({
				 style:'text-align:left'
				 })
	}
	]);
	
	//-----------------------------------------------------设置颜色
	
	cm.setRenderer(4,getColor);
	cm.setRenderer(4,getColor);
    function getColor(val)
    {
        if (val != "")
        {
            return '<font color=blue></font><span style="color:red;">' + val + '</span>';
        }
    }
   
    //右键菜单
    var ProductInfoRightClick=new Ext.menu.Menu
        ({
                items:
                [{
                    text: '添加商品',
                    iconCls:'addicon',
                    handler:AddProductInfoFn
                },{
                    text:'删除商品',
                    iconCls:'deleteicon',
                    handler:DeleteProductInfoFn
                }]
         });
    //----------------------------------------------------定义grid
	var grid = new Ext.grid.EditorGridPanel({
	    id:"ProductInfoGrid",
		store:ProductInfostore,
		sm:sm,
		cm:cm,
		loadMask:true,
		clicksToEdit : 2,
		//自适应宽度 参数为列数
		autoExpandColumn:7,
		//超过长度带自动滚动条
		autoScroll:true,
		border:false,
		viewConfig:{
			columnsText:"显示/隐藏列",
			sortAscText:"正序排列",
			sortDescText:"倒序排列"
		},
		//分页
		bbar:new Ext.PagingToolbar({
			store:ProductInfostore,
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
		{
			text:"添加",
			//默认样式为按下
			//pressed:true,
			tooltip:"添加商品",
			iconCls:"addicon",
			handler:AddProductInfoFn
		},"","-","",{
			text:"删除",
			tooltip:"删除商品",
			iconCls:"deleteicon",
			handler:DeleteProductInfoFn
		},"-"],listeners:{
            'contextmenu':function(e)
            {
                e.stopEvent();
            },
             'contextmenu':function(e)
			            {
			                e.stopEvent();
			            },
	           "afteredit":function(e)
	               {
	                  var g=e.grid;//得到当前grid
	                  var r=e.record;//得到当前行所有数据
	                  var f=e.field;//得到修改列
	                  var v=e.value;//得到修改列修改后值
	                  var orgin=e.originalValue;//修改列修改前值
	                  var row=e.row;//当前行索引
	                  var col=e.column;//当前点击的列索引
	                  //alert("ID："+r.data.taskOrderId+"-field:"+f+"-value:"+v+"-修改前值："+orgin+"-坐标:"+row+","+col);
	                  //通过ajax请求修改数据
	              
	                 
	                      Ext.Ajax.request({
	                          url:"productInfo.do?actionType=modify",//请求更新配送员
	                          method:"POST",
	                          params:{
	                              field:f,
	                              value:v,
	                              productId:r.data.productId
	                          },
	                          success:function(response,option)
	                          {
	                               var responseArray = Ext.util.JSON.decode(response.responseText); 
			                   var flag = responseArray.success;
			                   if(flag){
			                   		Ext.Msg.alert("恭喜您","更新成功");
			                   }else{
			                   	Ext.Msg.alert("对不起",responseArray.msg);
			                   }
			                   subTasksStore.reload();
	                          },
	                          failure:function(response,option)
							    {
			                           			Ext.Msg.alert("不好意思","更新失败了");
			                           			subTasksStore.reload();
							    }
	                      }); 
	               },
            'rowcontextmenu':function(grid,rowIndex,e)
            {
                e.stopEvent();
                ProductInfoRightClick.showAt(e.getXY());
            }
		}
	});
	
	//传入icon样式
	GridMain(node,grid,"goodsinfoicon");
};


//---------------------------------------------------------删除选中行商品信息
DeleteProductInfoFn=function()
{
        //得行单个record对象
        //var row=Ext.getCmp("GoodsInfoGrid").getSelectionModel().getSelected();
        //得到多个record对象
        var row=Ext.getCmp("ProductInfoGrid").getSelectionModel().getSelections();
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","请您至少选择一个!");
        }
        else{  
            Ext.Msg.confirm("提示!","您确定要删除该商品信息吗?",function(btn){ 
                if(btn=="yes")
                {
                   DeleteProductInfo(row);
                }
                else
                {
                   
                }
            })
        }  
}




//------------------------------------------------------增加商品信息

AddProductInfoFn=function()
{  
	AddProductInfo(); 
} 
