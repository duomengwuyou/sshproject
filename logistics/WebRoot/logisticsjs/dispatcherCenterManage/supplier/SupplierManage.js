///<reference path="../../JS/ext.js" />
/**
 * 供应商管理
 * @author:罗荣博
 */
var SupplierStore;
SupplierManage = function(node){
	//分页每页显示数量
	var pageSize = 36;
	var flag1 = 1;
	//指定列参数
	var fields = ["supplierId","supplierName","supplierAdd","contactPerson","supplierTel","bank","bankAccount","fax","supplierZipCode","legalPerson","supplierRemark"];
	//RoomOpenInfostore=new Ext.data.GroupingStore({
	SupplierStore = new Ext.data.GroupingStore({
		 proxy:new Ext.data.HttpProxy({
                url:'supplierManage.do?actionType=display',
                method:"POST"
           }),
         reader:new Ext.data.JsonReader({
                    fields:fields,
                    root:"data",
                    id:"supplierId",
                    totalProperty:"totalCount"
                   
        })
    });
    //加载时参数
    SupplierStore.load({params:{start:0,limit:36,flag:100}});
  
	//--------------------------------------------------列选择模式
    
    var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"supplierId"
	});
	//--------------------------------------------------列头
		var cm = new Ext.grid.ColumnModel([
		sm,{
		header:"供应商名称",
		dataIndex:"supplierName",
		tooltip:"供应商名称",
		width:120,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"地址",
		tooltip:"地址",
		dataIndex:"supplierAdd",
		width: 200,
        sortable:true
//        renderer:function(value)
//        {
//            return "<font color='blue'>"+value+"</font>"
//        }
	},{
		header:"联系人",
		dataIndex:"contactPerson",
		tooltip:"联系人",
		width: 100,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"联系电话",
		dataIndex:"supplierTel",
		tooltip:"联系电话",
		width: 120,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"开户行",
		dataIndex:"bank",
		tooltip:"开户行",
		width: 120,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"银行帐号",
		dataIndex:"bankAccount",
		tooltip:"银行帐号",
		width: 240,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"传真",
		dataIndex:"fax",
		tooltip:"传真",
		width: 100,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"邮编",
		dataIndex:"supplierZipCode",
		tooltip:"邮编",
		width: 100,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"法人",
		dataIndex:"legalPerson",
		tooltip:"法人",
		width: 120,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"备注",
		tooltip:"备注",
		dataIndex:"supplierRemark",
        sortable:true,
        width:300
	}]);
	
    //----右键菜单
   // var OpenRoomrightClick = new Ext.menu.Menu
	var SupplierRightClick = new Ext.menu.Menu({
	        items:
	        [{
	            text: '添加供应商',
	            iconCls:'addicon',
	            handler:AddSupplierInfoFn
	        },{
	            text:'编辑供应商信息',
	            iconCls:'editicon',
	            handler:EditSupplierInfoFn
	        },{
	            text:'删除供应商信息',
	            iconCls:'deleteicon',
	            handler:DeleteSupplierInfoFn
	        }]
	 });
    //----------------------------------------------------定义grid
	var grid = new Ext.grid.GridPanel({
	    id:"SupplierInfoGrid",
		store:SupplierStore,
		sm:sm,
		cm:cm,
		loadMask:true,
		stripeRows:true, 
		autoExpandColumn:3,
		//超过长度带自动滚动条
		autoScroll:true,
		border:false,
		view: new Ext.grid.GroupingView({
		    //自动填充
            forceFit:true,
            sortAscText :'正序排列',
            sortDescText :'倒序排列',
            columnsText:'列显示/隐藏',
            groupByText:'根据本列分组',
            showGroupsText:'是否采用分组显示',
            groupTextTpl: '{text} (<b><font color=red>{[values.rs.length]}</font> </b>{[values.rs.length > 0 ? "条供应商信息" : "暂无供应商信息"]})'
        }),//???
		//分页
		bbar:new Ext.PagingToolbar({
			store:SupplierStore,
			//cls:"FloorInfoGridbbar",
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
			text:"添加供应商",
			//默认样式为按下
			//pressed:true,
			tooltip:"新建供应商",
			iconCls:"addicon",
		    handler:AddSupplierInfoFn
		},"","-","",{
			text:"编辑供应商信息",
			tooltip:"编辑当前供应商信息",
			iconCls:"editicon",
			handler:EditSupplierInfoFn
		},"","-","",{
			text:"删除供应商",
			tooltip:"删除供应商",
			iconCls:"deleteicon",
			handler:DeleteSupplierInfoFn
		},"-"],listeners:{
            'contextmenu':function(e){
                e.stopEvent();
            },
            "rowcontextmenu":function(grid,rowIndex,e){
                e.stopEvent();
                SupplierRightClick.showAt(e.getXY());
            }
		}
	});
	
	//传入icon样式
	GridMain(node,grid,"openroomiconinfo");
};

//---------------------------------------------------------删除选中行供应商信息
DeleteSupplierInfoFn=function(){
//		alert("DeleteSupplierInfoFn");
        var row=Ext.getCmp("SupplierInfoGrid").getSelectionModel().getSelections();
        if(row.length==0){
            Ext.Msg.alert("提示信息","请您至少选择一个!");
        }else{
            Ext.Msg.confirm("提 示!","您确定要删除供应商吗?",function(btn){ 
                if(btn=="yes"){
                   DeleteSupplierInfo(row);//这里的row表示要删除的供应商，可以为多个
                }else{
                   
                }
            })
        }  
}


//-----------------------------------------------------修改选中行供应商信息

EditSupplierInfoFn=function(){
	var row = Ext.getCmp("SupplierInfoGrid").getSelectionModel().getSelections();
	if(row.length==0){
		Ext.Msg.alert("提示信息","您没选中任何行！");
	}else if(row.length>1){
		Ext.Msg.alert("提示信息","对不起，只能选择一个！");
	}else if(row.length==1){
		//调用修改供应商函数
		EditSupplierInfo(row[0]);//这里只表示所编辑的供应商，只能为一个
	}
}



////------------------------------------------------------增加供应商信息

AddSupplierInfoFn=function(){
    AddSupplierInfo();
}