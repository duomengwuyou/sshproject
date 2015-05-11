//任务单查询
SubTaskSearch = function(node)
{	
	//指定分站配送员combox动态加载数据
    delivermanFields = Ext.data.Record.create([      
       {name: 'delivermanId',mapping:'delivermanId'},{name: 'delivermanName',mapping:'delivermanName'}                     
     ]);

    delivermanStore = new Ext.data.Store({      
        proxy: new Ext.data.HttpProxy({      
            url:'subGetAllDeliverman.do?actionType=doSearch',// 得到所有分站配送员  
            method:"POST"
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'delivermanId'     
        },
        delivermanFields 
        ),      
        sortInfo: {field:'delivermanId',direction: "ASC"} 
    });   
    delivermanStore.load();

	//分页每页显示数量	 
	var pageSize = 12;
	
	//指定列参数
    subTasksFields = ["taskOrderId","RequiredDate","taskOrderType","taskOrderState","delivermanId"];
 
	subTasksStore = new Ext.data.GroupingStore({
           proxy:new Ext.data.HttpProxy(
           {
                url:"subGetAllTask.do?actionType=doSearch",//得到所有的该分站的任务单
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
           {
                        fields:subTasksFields,
                        root:"data",
                        id:"taskOrderId",
                        totalProperty:"totalCount"
           }),
           //groupField:'taskOrderId',
           sortInfo: {field:'taskOrderId',direction: "ASC"} 
    });
	subTasksStore.load({params:{start:0,limit:pageSize}});   
	
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"taskOrderId"
	});

	//--------------------------------------------------列头
	        
	var cm = new Ext.grid.ColumnModel([
		sm,
	{
		header:"任务单ID",
		dataIndex:"taskOrderId",
		tooltip:"任务单唯一标识ID",
		width:80,
        sortable:true
        
	},{
		header:"要求完成日期",
		tooltip:"任务单要求完成日期",
		dataIndex:"RequiredDate",
        sortable:true
       
	},{
		header:"任务类型",
		tooltip:"描述任务单的类型",
		dataIndex:"taskOrderType",
        sortable:true
        
	},{
		header:"任务状态",
		tooltip:"任务单当前的状态",
		dataIndex:"taskOrderState",
        sortable:true
        
	},{
		header:"配送员",
		//tooltip:"双击可以进行任务分配", //当任务单状态为已分配时不能够双击进行分配
		dataIndex:"delivermanId",
        sortable:true,
        renderer:function(value,meta,record,rowIndex,colIndex,store)
        { 
            if(value == "null")
            {
                return "暂无数据";
            }else{     
             return /*delivermanStore.getAt(value).data.delivermanName*/value;
            }
        }
	}]);

    //----------------------------------------------------定义grid
	var subTaskGrid = new Ext.grid.EditorGridPanel({
	    id:"subTaskSearchGrid",
		store:subTasksStore,
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
			store:subTasksStore,
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
		,"","-",new Ext.Toolbar.TextItem("<font color=red>要求完成日期</font>"),{
					    xtype:"datefield",
					    //name:"requredatesearch",
					    id:"requredatesearch",
					    format:"Y-m-d"
					   // minValue:new Date("2011-6-28")
		},"","-",new Ext.Toolbar.TextItem("<font color=red>任务类型</font>"),{
						labelfield : "任务类型",
						xtype : "combo",
						tootip : "任务类型",
						iconCls:"editicon",
						hiddenName:"tasktypesearch",
						width:90,
						readOnly : true,
						mode : "local",
						displayField : "show",
						valueField : "value",
						triggerAction : "all", 
                        store : new Ext.data.SimpleStore({
                        	fields:["show","value"],
                        	data:[["任意","任意"],["全部","全部"],["送货收款","送货收款"],["送货","送货"],["收款","收款"],["换货","换货"],["退货","退货"]]
                        })
		},"","-",new Ext.Toolbar.TextItem("<font color=red>任务状态</font>"),{
						labelfield : "任务状态",
						xtype : "combo",
						tootip : "描述任务状态",
						iconCls:"editicon",
						hiddenName:"taskstatesearch",
						width:90,
						readOnly : true,
						mode : "local",
						displayField : "show",
						valueField : "value",
						triggerAction : "all", 
                        store : new Ext.data.SimpleStore({
                        	fields:["show","value"],
                        	data:[["任意","任意"],["已调度","已调度"],["可分配","可分配"],["已分配","已分配"],["已领货","已领货"],["已完成","已完成"],["失败","失败"]]
                        })
		},"","-",{
						text:"查询",
						tooltip:"查询符合条件的任务单",
						iconCls:"serchopenroomrecord",
						handler:GetTasksWantedAdmin
						
		},"","-",{
						text:"详情",
						tooltip:"点击可以查看任务单详情",
						iconCls:"addicon",
						handler: ShowTaskDetail//showDetailedInfo //ShowTaskDetail
		},""] 
	});

    GridMain(node,subTaskGrid,"roomicons");
}

//查询符合条件的任务单信息

GetTasksWantedAdmin = function(){
	var requredate2= Ext.get("requredatesearch").dom.value;
    var tasktype2= Ext.get("tasktypesearch").dom.value;
    var taskstate2 = Ext.get("taskstatesearch").dom.value;
    subTasksStore.reload
    ({
            params:{start:0,limit:12,RequiredDate:requredate2,taskOrderType:tasktype2,taskOrderState:taskstate2}
    });
}
ShowTaskDetail = function(){
	var row=Ext.getCmp("subTaskSearchGrid").getSelectionModel().getSelections();
    if(row.length == 0){
		Ext.Msg.alert("提示信息","您没选中任何行！");
	}else if(row.length>1){
		Ext.Msg.alert("提示信息","对不起，只能选择一个！");
	}else if(row.length == 1){
		showDetailedInfo(row[0].data.taskOrderId);
	}
}