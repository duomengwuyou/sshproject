// JScript 文件1
var SubstationReturnOutStore;
SubstationReturnOut=function(node){
   //指定房间类型combox动态加载数据

    roomtypefileds = Ext.data.Record.create([      
       {name: 'roomTypeId',mapping:'roomTypeId'},{name: 'roomTypeName',mapping:'roomTypeName'},{name:'typeRemark',mapping:'typeRemark'}                     
     ]);
    roomtypestore = new Ext.data.Store({      
        proxy: new Ext.data.HttpProxy({      
           // url:'servlet/RoomType'  
           method:"POST"
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'roomTypeId'     
        },
        roomtypefileds 
        ),
        sortInfo: {field:'roomTypeId',direction: "ASC"} 
    });   
    roomtypestore.load();
 
    //楼层combox动态加载数据
   
    floorfileds = Ext.data.Record.create([      
       {name: 'floorId',mapping:'floorId'},{name: 'floorName',mapping:'floorName'},{name:'floorRemark',mapping:'floorRemark'}                     
     ]);
    floorstore = new Ext.data.Store({      
        proxy: new Ext.data.HttpProxy({      
            //url:'servlet/FloorServlet' 
            method:"POST" 
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',
            id:'floorId'
        },
        floorfileds 
        ),      
        sortInfo: {field:'floorId',direction: "ASC"} 
    });   
    floorstore.load();
    //分页每页显示数量	 
	var pageSize = 12;
	//指定列参数
    var SubstationReturnOutFields=["id","returnProductOrderId","productName","unit","returnQuantity","returnDate"];
 
	SubstationReturnOutStore=new Ext.data.GroupingStore({
           proxy:new Ext.data.HttpProxy({
                url:"substationReturnOut.do?actionType=doSearch",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader({
                      fields:SubstationReturnOutFields,
                      root:"data",
                      id:"id",
                      totalProperty:"totalCount"
           }),
           groupField:'returnProductOrderId',
           sortInfo: {field:'returnProductOrderId',direction: "ASC"} 
    });
	SubstationReturnOutStore.load({params:{start:0,limit:pageSize}}); 
	
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"id"
	});
	//--------------------------------------------------列头
	        
	var cm = new Ext.grid.ColumnModel([
		sm,
	{
		header:"退货单号",
		dataIndex:"returnProductOrderId",
		tooltip:"退货单号",
		width:80,
        sortable:true
	},{
		header:"产品名称",
		tooltip:"产品名称",
		dataIndex:"productName",
        sortable:true
//        renderer:function(value,meta,record,rowIndex,colIndex,store)
//        {
//            
//            if(value<1)
//            {
//                return "暂无数据";
//            }else{     
//            // return "<b><font color=#008B8B>"+SubstationReturnOutStore.getAt(value).data.roomTypeName+"</font></b>";
//            }
//        }
	},{
	    header:"产品单位",
	    tooltip:"产品单位",
	    dataIndex:"unit",
	    sortable:true,
	    renderer:function(value)
	    {
	       return '<b><font color=red>'+value+'</font></b>';
	    }
	},{
		header:"退货数量",
		tooltip:"退货数量",
		dataIndex:"returnQuantity",
        sortable:true
//        renderer:function(value,meta,record,rowIndex,colIndex,store)
//        {
//            if(value<1)
//            {
//                return "暂无数据";
//            }
//            else
//            {      
//             return "<b><font color=#008B8B>"+floorstore.getAt(value).data.floorName+"</font></b>";
//            }
//        }
	},{
		header:"退货日期",
		tooltip:"退货日期",
		width:80,
		dataIndex:"returnDate",
        sortable:true,
        renderer:function(val)
        {
         return '<b><font color=blue>'+val+'</font></b>';
        }
	}]);
    //----------------------------------------------------定义grid
	var SubstationReturnOutgrid = new Ext.grid.EditorGridPanel({
	    id:"SubstationReturnOutGrid",
		store:SubstationReturnOutStore,
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
           // hideGroupedColumn:true,
            columnsText:'列显示/隐藏',
            groupByText:'根据本列分组',
            showGroupsText:'是否采用分组显示',
            groupTextTpl: '{text} (<b><font color=red>{[values.rs.length]}</font></b> {[values.rs.length > 0 ? "条产品信息" : "暂无产品信息"]})'
        }),
		//分页
		bbar:new Ext.PagingToolbar({
			store:SubstationReturnOutStore,
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
		new Ext.Toolbar.TextItem("<font color=red>开始日期</font>"),{
				    xtype:"datefield",
				    name:"begin",
				    id:"begin",
				    format:"Y-m-d",
				    minValue:new Date("2011-6-28")// 不知道好使吗？
		},"","-",new Ext.Toolbar.TextItem("<font color=red>结束日期</font>"),{
				    xtype:"datefield",
				    id:"end",
				    name:"end",
				    format:"Y-m-d",
				    minValue:"2011-6-28"
		},"","-",{
					text:"查询",
					tooltip:"查询符合条件的房间",
					iconCls:"serchopenroomrecord",
					handler:GetRoomsWanted
		},"","-",{
			text:"确认退货到中心库房",
			//默认样式为按下
			//pressed:true,
			tooltip:"确认退货到中心库房",
			iconCls:"addicon",
			handler:SureSubstationReturnOut
		},"-"]
	});
    GridMain(node,SubstationReturnOutgrid,"roomicons");
}
SureSubstationReturnOut = function(){
	var row = Ext.getCmp("SubstationReturnOutGrid").getSelectionModel().getSelections();
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您选择退货出库的信息!");
	}else{
		Ext.Msg.alert("提示信息","分站库房退货出库成功!");
    	//AddNotMemberReserveInfo(row[0],arrive,leave);
    }	
}
//-------------------------------------------------------搜索
function GetRoomsWanted()
{
  
    var roomTypeId2 = Ext.get("roomTypeIdStuff").dom.value;
    var floorId2 = Ext.get("floorIdStuff").dom.value;
    //var state2 = Ext.get("stateStuff").dom.value;
    var price2 = Ext.get("priceStuff").dom.value;
    var arrive2 = Ext.get("arrive").dom.value;
    var leave2 = Ext.get("leave").dom.value;
    SubstationReturnOutStore.reload
    ({
            params:{roomTypeId:roomTypeId2,floorId:floorId2,price:price2,arrive:arrive2,leave:leave2}
    });
}
GetRoomIdInReserve = function(){
	var row = Ext.getCmp("RoomSearchGrid").getSelectionModel().getSelections();
	var arrive = Ext.get("arrive").dom.value;
	var leave = Ext.get("leave").dom.value;
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您选择所要预定的客房信息!");
	}else if(row.length>1){
        Ext.Msg.alert("提示信息","对不起,您一次只能预订一个客房!");
    }else if(row.length == 1){
    	AddNotMemberReserveInfo(row[0],arrive,leave);
    }	
}
GetRoomIdInReserveGuest = function(){
	var row = Ext.getCmp("RoomSearchGrid").getSelectionModel().getSelections();
	var arrive = Ext.get("arrive").dom.value;
	var leave = Ext.get("leave").dom.value;
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您选择所要预定的客房信息!");
	}else if(row.length>1){
        Ext.Msg.alert("提示信息","对不起,您一次只能预订一个客房!");
    }else if(row.length == 1){
    	AddMemberReserveInfo(row[0],arrive,leave);
    }	
}
GetRoomIdInEnter = function(){
	var row = Ext.getCmp("RoomSearchGrid").getSelectionModel().getSelections();
	var arrive = Ext.get("arrive").dom.value;
	var leave = Ext.get("leave").dom.value;
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您选择所要入住的客房信息!");
	}else if(row.length>1){
        Ext.Msg.alert("提示信息","对不起,您一次只能入住一个客房!");
    }else if(row.length == 1){
    	AddNotMemberEnterInfo(row[0],arrive,leave);
    }	
}
GetRoomIdInEnterGuest = function(){
	var row = Ext.getCmp("RoomSearchGrid").getSelectionModel().getSelections();
	var arrive = Ext.get("arrive").dom.value;
	var leave = Ext.get("leave").dom.value;
	if(row.length == 0){
		Ext.Msg.alert("提示信息","请您选择所要入住的客房信息!");
	}else if(row.length>1){
        Ext.Msg.alert("提示信息","对不起,您一次只能入住一个客房!");
    }else if(row.length == 1){
    	AddMemberEnterInfo(row[0],arrive,leave);
    }	
}
