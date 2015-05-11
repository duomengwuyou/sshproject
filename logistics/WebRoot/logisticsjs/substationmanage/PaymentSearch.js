//缴款查询 李莎
	var productInfoStore;
	var subProductsStore;

PaymentSearch = function(node)
{

	//得到分站送过的所有商品信息
   var subProductsFields = Ext.data.Record.create([      
       {name: 'productId2',mapping:'productId2'},{name: 'productName2',mapping:'productName2'}                     
     ]);

    subProductsStore = new Ext.data.Store({      
        proxy: new Ext.data.HttpProxy({      
            url: "subProduct.do?actionType=doSearch",// 得到分站送过的所有商品
            method:"POST"
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'productId2'     
        },
        subProductsFields 
        ),      
        sortInfo: {field:'productId2',direction: "ASC"} 
    });   
    subProductsStore.load();

	//分页每页显示数量	 
	var pageSize = 12;
	
	//指定列参数
    var productInfoFields = ["id","productId","productName","category_second","category_first","sendAmount","payState","totalGet","totalReturn"];
 
	productInfoStore = new Ext.data.GroupingStore({
           proxy:new Ext.data.HttpProxy(
           {
                url:"subPaymentSearch.do?actionType=doSearch",//得到分站所有的送货商品统计信息
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
           {
                        fields:productInfoFields,
                        root:"data",
                        id:"id",
                        totalProperty:"totalCount"
           }),
           groupField:'productId',
           sortInfo: {field:'productId',direction: "ASC"} 
    });
	productInfoStore.load({params:{start:0,limit:pageSize}}); 
	

	//--------------------------------------------------列头
	        
	var cm = new Ext.grid.ColumnModel([
	{
		header:"商品ID",
		dataIndex:"productId",
		tooltip:"商品唯一标识ID",
		width:80,
        sortable:true
       
	},{
		header:"商品名称",
		dataIndex:"productName",
		tooltip:"商品名称",
		width:80,
        sortable:true
       
	},{
		header:"商品二级分类",
		dataIndex:"category_second",
		tooltip:"商品所属的二级分类信息",
		width:80,
        sortable:true
       
	},{
		header:"商品一级分类",
		dataIndex:"category_first",
		tooltip:"商品一级分类信息",
		width:80,
        sortable:true
        
	},{
		header:"送货数量",
		dataIndex:"sendAmount",
		tooltip:"商品唯一标识ID",
		width:80,
        sortable:true
       
	},{
		header:"收款情况",
		dataIndex:"payState",
		tooltip:"收款情况",
		width:80,
        sortable:true
       
	},{
		header:"收款金额",
		tooltip:"收款金额",
		dataIndex:"totalGet",
        sortable:true
        
	},{
		header:"退款金额",
		tooltip:"退款金额", //当任务单状态为已分配时不能够双击进行分配
		dataIndex:"totalReturn",
        sortable:true
	}]);
		
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"productId"
	});

    //----------------------------------------------------定义grid
	var payGrid = new Ext.grid.EditorGridPanel({
	   // id:"payGridid",
		store:productInfoStore,
		sm:sm,
		cm:cm,
		loadMask:true,
		stripeRows:true,
		
		clicksToEdit:2,
		//超过长度带自动滚动条
		autoScroll:true,
		border:false,
		view: new Ext.grid.GroupingView({
		    //自动填充
            forceFit:true,
            sortAscText :'正序排列',
            sortDescText :'倒序排列',
            hideGroupedColumn:true,
            columnsText:'列显示/隐藏',
            groupByText:'根据本列分组',
            showGroupsText:'是否采用分组显示',
            groupTextTpl: '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条任务单信息" : "暂无分站任务信息"]})'
        }), 
         bbar:new Ext.PagingToolbar({
			store:productInfoStore,
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
        //------------------------------------------------------定义显示框上部内容
		tbar:["                   ",
		new Ext.Toolbar.TextItem("<font color=red>请输入查询条件</font>")
		,"","-",new Ext.Toolbar.TextItem("<font color=red>开始日期</font>"),{
					    xtype:"datefield",
					    id:"startdate1",
					    format:"Y-m-d"
		}	,"","-",new Ext.Toolbar.TextItem("<font color=red>结束日期</font>"),{
					    xtype:"datefield",
					    name:"enddateAdmin",
					    id:"enddate",
					    format:"Y-m-d"
		},"","-",new Ext.Toolbar.TextItem("<font color=red>商品名称</font>"),{
						labelfield : "商品名称",
						xtype : "combo",
						tootip : "商品名称",
						iconCls:"editicon",
						hiddenName:"productnameAdmin",
						store : subProductsStore,
						width:90,
						readOnly : true,
						mode : "remote",
						displayField : "productName2",
						valueField : "productId2",
						triggerAction : "all"
		},"","-",{
						text:"查询",
						tooltip:"查询符合条件的任务单",
						iconCls:"serchopenroomrecord",
						handler:GetPaySeachCondictions
		},"","-",{
						text:"统计信息",
						tooltip:"totalstatistics",
						iconCls:"addicon",
						handler:ComputeTotal
		},""]
	});

    GridMain(node,payGrid,"roomicons");
}
GetPaySeachCondictions = function(){
	var start2= Ext.get("startdate1").dom.value;
    var end2= Ext.get("enddate").dom.value;
    var product2 = Ext.get("productnameAdmin").dom.value;
    productInfoStore.reload
    ({
            params:{start:0,limit:12,start:start2,end:end2,product:product2}
    });	
}
ComputeTotal= function(){
	var total= 0.0;
	for(var i=0; i < productInfoStore.data.length;i++){
		var data = productInfoStore.getAt(i).data;//data就是对应record的一个一个的对象
		total += parseFloat(data.totalGet); //获取的就是该对象dataIndex属性对应的值
	}
	Ext.Msg.alert("统计信息","总收款金额：￥"+ total+".0"+" \n"+"总退款金额：￥0.0");
	return total;
}