
showDetail=function(row)
{

	var allocationIds="";
    for(var i=0;i<row.length;i++)
    {
                if(row.length==1)
                {
                    allocationIds=row[i].data.allocationOrder;
                }
                else
                {
                    if(i<(row.length-1))
                    {
                        allocationIds=row[i].data.allocationOrder+","+allocationIds;
                    }
                    if(i==(row.length-1))
                   {
                        allocationIds=allocationIds+row[i].data.allocationOrder;
                   } 
                }
     } 
	var pageSize = 12;
//指定列参数
    var detailFields=["id","warehouse","productId","productName","amount"];
   
	var detailStore=new Ext.data.GroupingStore({
           proxy:new Ext.data.HttpProxy(
           {
                url:"AllocationOrderStore.do?actionType=showDetail&allocationIds="+allocationIds,
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
           {
                        fields: detailFields,
                        root:"data",
                        id:"id",
                        totalProperty:"totalCount"
                       
           }),
           groupField:'warehouse',
           sortInfo: {field:'id',direction: "ASC"} 
    });
	detailStore.load({params:{start:0,limit:pageSize}}); 
	
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"id"
	});
	//--------------------------------------------------列头
	        
	var cm = new Ext.grid.ColumnModel([
		//sm,
	{
		header:"条目",
		dataIndex:"id",
		width:80,
        sortable:true
	},{
		header:"分库名称",
		dataIndex:"warehouse",
		width:80,
        sortable:true,
	},{
	    header:"商品ID",
	    dataIndex:"productId",
	    width:80,
	    sortable:true,
	    renderer : function(val) {
					return '<b><font color=green>' + val + '</font></b>';
				}
	},{
	    header:"商品名称",
	    dataIndex:"productName",
	    width:80,
	    sortable:true,
	    renderer : function(val) {
					return '<b><font color=blue>' + val + '</font></b>';
				}
	},{
		header:"商品数量",
		dataIndex:"amount",
        sortable:true,
        width:80,
        renderer : function(val) {
					return '<b><font color=red>' + val + '</font></b>';
				}
	}]);    
	var seeDetailFieldSet = new Ext.form.FieldSet({
		collapsible　:　true,
        title　:　"商品信息",
        border　:　true,
      //  labelWidth　: 35,
        width　:　550,
        autoHeight　:　true,
        layout　:　'form',
        defaults　:　{autoWidth:true},
        items :　[{
        	id : 'seeDetailFieldSet',
        	xtype : 'grid',
            height : 620,
            cm : cm,
            loadMask : true,
            stripeRows : true,
            store : detailStore,
            border : true,
          	view: new Ext.grid.GroupingView({
		    //自动填充
            forceFit:true,
            sortAscText :'正序排列',
            sortDescText :'倒序排列',
            hideGroupedColumn:true,
            columnsText:'列显示/隐藏',
            groupByText:'根据本列分组',
            showGroupsText:'是否采用分组显示',
            groupTextTpl: '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条记录" : "暂无记录"]})'
        	}),
            //sm : sm,
            bbar:new Ext.PagingToolbar({
            	scope:this,
                store : detailStore,
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
		var seeDetailForm = new Ext.FormPanel({
		id : 'seeDetailForm',
		frame : true,
        bodyStyle : 'padding:5px',
        autoWidth : true,
        aotoHeight : true,
        border : false,
        layout : 'column',
        defaults : {anchor:"100%"},
        items : [seeDetailFieldSet]
	}); 
	
    var detailWin=new Ext.Window({
			title:"每个分站的商品信息",
			width:600,
			height:700,
			plain:true,
			//layout:"form",
			iconCls:"openroomicon",
			//不可以随意改变大小
			resizable:false,
			//是否可以拖动
			//draggable:false,
			defaultType:"textfield",
			labelWidth:100,
			collapsible:true, //允许缩放条
            closeAction : 'hide',
            closable:true,
            //弹出模态窗体
			modal: 'true', 
			buttonAlign:"center",
			bodyStyle:"padding:10px 0 0 15px",
			items:[seeDetailForm],
			listeners:{
			    "show":function()
			    {
			        
			    }
			},
	});
    detailWin.show();
}

