///<reference path="../../JS/ext.js" />
var FirstCategoryStore;
FirstCaterygoryManage=function(node){

	 //alert("进到FirstCaterygoryManage中了");
   //var FirstCategoryStore;

	//分页每页显示数量	 
	var pageSize = 12;

	//指定列参数
	var fields = ["categoryid","categoryname"];

	FirstCategoryStore = new Ext.data.Store({
		 
		 proxy:new Ext.data.HttpProxy(
           {
                url:"category.do?actionType=first",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
   		   {
				fields:fields,
                root:"data",
                id:"categoryid",
                totalProperty:"totalCount"
           })
	});
	//加载时参数
	 FirstCategoryStore.load({params:{start:0,limit:pageSize}}); 
    
	
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"categoryid"
	});
	//--------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([
		sm,{
		header:"商品分类编号",
		dataIndex:"categoryid",
		tooltip:"商品分类编号",
		width:350,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"分类名称",
		tooltip:"分类名称",
		dataIndex:"categoryname",
		width:500,
		//可以进行排序
        sortable:true,
        renderer:function(value)
        {
            return "<font color='blue'>"+value+"</font>"
        }
	}]);
   
    //----------------------------------------------------定义grid
	var grid = new Ext.grid.GridPanel({
	    id:"CategoryIdGrid",
		store:FirstCategoryStore,
		sm:sm,
		cm:cm,
		loadMask:true,
		//自适应宽度 参数为列数
		autoExpandColumn:2,
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
			store:FirstCategoryStore,
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
		new Ext.Toolbar.Fill()
		,{
			text:"添加",
			//默认样式为按下
			//pressed:true,
			tooltip:"添加一级分类",
			iconCls:"addicon",
			handler:AddFirstCategoryFn
		},"","-","",{
			text:"编辑",
			tooltip:"编辑一级分类",
			iconCls:"editicon",
			handler:EditFirstCategoryFn
		},"","-","",{
			text:"删除",
			tooltip:"删除一级分类",
			iconCls:"deleteicon",
			handler:DeleteFirstCategoryFn
		},"-"],listeners:{
            'contextmenu':function(e)
            {
                e.stopEvent();
            },
            'rowcontextmenu':function(grid,rowIndex,e)
            {
                e.stopEvent();
                FirstCategoryRightClick.showAt(e.getXY());
            }
		}
	});
	
	//传入icon样式
	GridMain(node,grid,"roomtypeicon");
};


//---------------------------------------------------------删除选中行房间信息
DeleteFirstCategoryFn=function()
{ 
        var row=Ext.getCmp("CategoryIdGrid").getSelectionModel().getSelections();
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","请您至少选择一个!");
        }
        else{  
            Ext.Msg.confirm("提示!","您确定要删除该一级分类信息吗?",function(btn){ 
                if(btn=="yes")
                {
                   DeleteFirstCategoryInfo(row);
                }
                else
                {
                   
                }
            })
        }  
}


//-----------------------------------------------------修改选中行一级分类信息
EditFirstCategoryFn=function()
{
        var row=Ext.getCmp("CategoryIdGrid").getSelectionModel().getSelections();
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","您没有选中任何行!");
        }
        else if(row.length>1){  
            Ext.Msg.alert("提示信息","对不起只能选择一个!");
        }else if(row.length==1)
        {
            //调用修改一级分类函数 
            EditFirstCategoryInfo(row[0]);//传行一行记录直接加载
        } 
                    
}



//------------------------------------------------------增加房间信息

AddFirstCategoryFn=function()
{ 
    AddFirstCategoryInfo();
    
}
    
