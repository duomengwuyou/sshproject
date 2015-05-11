/**
 * 作者 ： 周诗龙
 * 日期 ：2011年7月15日
 * 
 */
 var SubstationReturnStore;
CenterwarehouseOut=function(node){

    //分页每页显示数量	 
	var pageSize = 12;
	//指定列参数
 	var CenterwarehouseOutFields = ["id","returnProductOrderId","productName","productQuantity"];
	CenterwarehouseOutStore=new Ext.data.GroupingStore({
           proxy:new Ext.data.HttpProxy({
                url:"centerwarehouseOut.do?actionType=doSearch",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader({
                fields:CenterwarehouseOutFields,
                root:"data",
                id:"id",
                totalProperty:"totalCount"
           }),
           groupField:'returnProductOrderId',
           sortInfo: {field:'returnProductOrderId',direction: "ASC"} 
    });
	CenterwarehouseOutStore.load();
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"id"
	});
	//--------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([
		sm,{
		header:"退货单号",
		dataIndex:"returnProductOrderId",
		tooltip:"退货单号",
		width:80,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"产品名称",
		dataIndex:"productName",
		tooltip:"产品的名称",
		width:80,
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
        sortable:true
	},{
		header:"产品数量",
		tooltip:"产品数量",
		width:80,
		dataIndex:"productQuantity",
        sortable:true,
        renderer:function(val){
          return '<b><font color=blue>'+val+'</font></b>';
        }
	}]);
	
    //-----------------------右键菜单
    var CenterwarehouseOutRightClick=new Ext.menu.Menu({
        items:[{
            text: '刷新信息',
            iconCls:'addicon',
            handler:function(){ 
              CenterwarehouseOutStore.reload();
            }
        },{
            text:'查询任务单信息',
            iconCls:'editicon',
            handler:SearchReturnTaskOrder
        },{
            text:'中心库房退货出库',
            iconCls:'editicon',
            handler:SureCenterwarehouseOut
        }]
 	});
    //----------------------------------------------------定义grid
	var CenterwarehouseOutGrid = new Ext.grid.EditorGridPanel({
	    id:"CenterwarehouseOutGrid",
		store:CenterwarehouseOutStore,
		sm:sm,
		cm:cm,
		loadMask:true,
		stripeRows:true, 
		clicksToEdit:1,
		//autoExpandColumn:7,
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
            groupTextTpl: '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条产品信息" : "暂无产品信息"]})'
        }),
		//分页
		bbar:new Ext.PagingToolbar({
			store:CenterwarehouseOutStore,
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
		tbar:["                  ",
		new Ext.Toolbar.TextItem("<font color=red>退货单号</font>"),{
			name:"taskOrderSR",
			id:"taskOrderSR",
		    xtype:"textfield",
		  //  tpl: '<tpl for="."><div ext:qtip="{roomTypeName}. {typeRemark}" class="x-combo-list-item">{roomTypeName}</div></tpl>',
            editable: true, 
            allowBlank:true
		},"","-",{
			text:"查询",
			//默认样式为按下
			//pressed:true,
			tooltip:"查询",
			iconCls:"serchopenroomrecord",
			handler:SubstationReturnOutManage
		},"","-",
		{
			text:"刷新信息",
			//默认样式为按下
			//pressed:true,
			tooltip:"刷新当前页面信息",
			iconCls:"refreshicon",
			handler:function(){
			    CenterwarehouseOutStore.reload();
			}
		},"","-",{
			text:"中心库房退货出库",
			//默认样式为按下
			//pressed:true,
			tooltip:"中心库房退货出库",
			iconCls:"addicon",
			handler:SureCenterwarehouseOut
		},"-"],listeners:{
            'contextmenu':function(e){
                e.stopEvent();
            },
//             "afteredit":function(e){
//                var g=e.grid;//得到当前grid
//                var r=e.record;//得到当前行所有数据
//                var f=e.field;//得到修改列
//                var v=e.value;//得到修改列修改后值
//                var orgin=e.originalValue;//修改列修改前值
//                var row=e.row;//当前行索引
//                var col=e.column;//当前点击的列索引
//                //alert("ID："+r.data.id+"-field:"+f+"-value:"+v+"-修改前值："+orgin+"-坐标:"+row+","+col);
//                //通过ajax请求修改数据
//                if(r.data.bednumber<r.data.guestnumber){
//                    ConsumeStore.reload();
//                //    Ext.Msg.alert("提示","对不起客人数必须小于床位数");
//                }else{
//                    Ext.Ajax.request({
//                        url:"URL/Room/SaveEditGridRoomInfo.aspx",
//                        method:"POST",
//                        params:{
//                            field:f,
//                            value:v,
//                            roomid:r.data.roomid
//                        },
//                        success:function(response,option){
//                            ConsumeStore.reload();                               
//                        },
//                        failure:function(){
//                            ConsumeStore.reload();
//                            Ext.Msg.alert("不好意思","修改失败了!");
//                        }
//                    });
//                }
//             },
             "rowcontextmenu":function(grid,rowIndex,e){
                e.stopEvent();
                CenterwarehouseOutRightClick.showAt(e.getXY());
             }
		}
	});
    GridMain(node,CenterwarehouseOutGrid,"roomicons");
}


///--------------------------搜索验货单/分发单信息窗口
SubstationReturnOutManage = function(){
	//SearchValidateOrder();
}
SureCenterwarehouseOut = function(){
	var row = Ext.getCmp("CenterwarehouseOutGrid").getSelectionModel().getSelections();
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您至少选择一个!");
	}else if(row.length == 1){
		Ext.Msg.alert("提示信息","中心库房退货出库处理!");
    	//ModifyConsumeInfo(row[0]);
    }
}
//----------------------修改客户的消费信息窗口
ModifyConsumeInfoManage = function(){
	var row = Ext.getCmp("CenterwarehouseOutGrid").getSelectionModel().getSelections();
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您至少选择一个!");
	}else if(row.length>1){
        Ext.Msg.alert("提示信息","对不起只能选择一个!");
    }else if(row.length == 1){
    	//ModifyConsumeInfo(row[0]);
    }
}
//----------------------删除消费信息
DelConsumeInfo = function(){
	var row=Ext.getCmp("CenterwarehouseOutGrid").getSelectionModel().getSelections();
    if(row.length==0){
        Ext.Msg.alert("提示信息","请您至少选择一个!");
    }else if(row.length>1){
    	Ext.Msg.alert("提示信息","您只能选择一个!");
    }else{  
        Ext.Msg.confirm("提示!","您确定要删除该消费信息吗?",function(btn){ 
        if(btn=="yes"){
          //alert("删除客人信息！");
          DeleteConsumeInfoManage(row);
          //删除该客人信息的窗口
        }else{
        }
    })
  }  
}