//分配任务单及查询任务单  李莎
    var delivermanStore;
	var delivermanFields;
	var subTasksStore;
	var subTasksFields;
	var taskStateStore;
	var taskTypeStore;

AllocateTask = function(node)
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
		tooltip:"双击可以进行任务分配", //当任务单状态为已分配时不能够双击进行分配
		dataIndex:"delivermanId",
        sortable:true,
        renderer:function(value,meta,record,rowIndex,colIndex,store)
        {
            if(value == '无' || value == "null")
            {	
                return "<b><font color=#008B8B>待分配</font></b>";
            }else{  
            	return "<b><font color=#008B8B>"+value+/*delivermanStore.getAt(value).data.delivermanName+*/"</font></b>";
            }
        },
        
        editor:new Ext.form.ComboBox({
        	store:delivermanStore,
            typeAhead: true,
            forceSelection: true,
            triggerAction: 'all',
            selectOnFocus:true,
            width:130,
            value:"delivermanId",
            editable: false, 
            displayField:'delivermanName',
            valueField: 'delivermanId',
            mode: 'remote'
            })
	}]);
	 //----------------------------------------------------定义grid
	var subTaskGrid = new Ext.grid.EditorGridPanel({
	    id:"subTaskGrid",
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
					    name:"requredateAdmin",
					    id:"requredateAdmin",
					    format:"Y-m-d"
		},"","-",new Ext.Toolbar.TextItem("<font color=red>任务类型</font>"),{
						labelfield : "任务类型",
						xtype : "combo",
						tootip : "任务类型",
						iconCls:"editicon",
						hiddenName:"tasktypeAdmin",
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
						hiddenName:"taskstateAdmin",
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
						handler:GetTasksWanted
		},"","-",{
						text:"详情",
						tooltip:"点击可以查看任务单详情",
						iconCls:"addicon",
						handler:ShowTaskDetailInfo//ShowTaskDetail
		},"","-",new Ext.Toolbar.TextItem("<font color=#008B8B>双击可进行任务分配</font>"),""],
		listeners:{
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
			                    if(r.data.taskOrderState != "可分配")
			                    {
			                        subTasksStore.reload();
			                        Ext.Msg.alert("提示","只能对状态为\"可分配\"的任务单进行分配！");
			                    }
			                    else
			                    {
			                        Ext.Ajax.request({
			                            url:"allocateDeliverman.do?actionType=doSearch",//请求更新配送员
			                            method:"POST",
			                            params:{
			                                field:f,
			                                value:v,
			                                taskOrderId:r.data.taskOrderId
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
			                    }
			                 },
		                 "rowcontextmenu":function(grid,rowIndex,e)
		                 {
		                    e.stopEvent();
		                    RoomRightClick.showAt(e.getXY());
		                 }
		} 
	});

    GridMain(node,subTaskGrid,"roomicons");
}

//查询符合条件的任务单信息
GetTasksWanted = function(){
	
	var requredate2= Ext.get("requredateAdmin").dom.value;
    var tasktype2= Ext.get("tasktypeAdmin").dom.value;
    var taskstate2 = Ext.get("taskstateAdmin").dom.value;
    
    subTasksStore.reload
    ({
            params:{start:0,limit:12,RequiredDate:requredate2,taskOrderType:tasktype2,taskOrderState:taskstate2}
    });
}
ShowTaskDetailInfo = function (){
	var row=Ext.getCmp("subTaskGrid").getSelectionModel().getSelections();
    if(row.length == 0){
		Ext.Msg.alert("提示信息","您没选中任何行！");
	}else if(row.length>1){
		Ext.Msg.alert("提示信息","对不起，只能选择一个！");
	}else if(row.length == 1){
		showDetailedInfo(row[0].data.taskOrderId);
	}
}