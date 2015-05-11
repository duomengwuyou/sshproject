///<reference path="../../JS/ext.js" />


 var SecondCategorystore;


SecondCategoryManage = function(node){ 
  
var FirstCategorystore;

	//分页每页显示数量	 
	var pageSize = 12;

	//指定列参数
	var fields = ["categoryid","categoryname","parentcategory"];

	SecondCategorystore = new Ext.data.Store({
		 
		 proxy:new Ext.data.HttpProxy(
           {
                url:"category.do?actionType=second",
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
	 SecondCategorystore.load({params:{start:0,limit:pageSize}}); 

  
	//--------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"categoryid"
	});
	//--------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([
		sm,{
		header:"类型ID",
		tooltip:"二级分类ID",
		dataIndex:"categoryid",
		//列不可操作
		//menuDisabled:true,
		//可以进行排序
		width:280,
        sortable:true
	},{
		header:"二级分类名称",
		tooltip:"二级分类名称",
		dataIndex:"categoryname",
		//可以进行排序
        sortable:true,
        width:280,
        renderer:function(value)
        {
            return "<font color='blue'>"+value+"</font>"
        }
	},{
		header:"所属一级分类",
		tooltip:"一级分类",
		dataIndex:"parentcategory",
		//可以进行排序
        sortable:true,
        width:300,
        renderer:function(value)
        {
            return "<font color='red'>"+value+"</font>"
        }
     }]);
	
	 
    //----------------------------------------------------定义grid
	var grid = new Ext.grid.GridPanel({
	    id:"SecondCategoryGrid",
		store:SecondCategorystore,
		sm:sm,
		cm:cm,
		loadMask:true,
		//自适应宽度 参数为列数
		autoExpandColumn:3,
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
			store:SecondCategorystore,
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
			tooltip:"添加二级分类",
			iconCls:"addicon",
			handler:AddSecondCategoryFn
		},"","-","",{
			text:"编辑",
			tooltip:"编辑二级分类",
			iconCls:"editicon",
			handler:EditSecondCategoryFn
		},"","-","",{
			text:"删除",
			tooltip:"删除二级分类",
			iconCls:"deleteicon",
			handler:DeleteSecondCategoryFn
		},"-"],listeners:{
            'contextmenu':function(e)
            {
                e.stopEvent();
            },
            'rowcontextmenu':function(grid,rowIndex,e)
            {
                e.stopEvent();
                SecondCategoryRightClick.showAt(e.getXY());
            }
		}
	});
	
	//传入icon样式
	GridMain(node,grid,"secondCategoryicon");
};


//---------------------------------------------------------删除选中行房间信息
DeleteSecondCategoryFn=function()
{
        //得行单个record对象
        //var row=Ext.getCmp("SecondCategoryGrid").getSelectionModel().getSelected();
        //得到多个record对象
        var row=Ext.getCmp("SecondCategoryGrid").getSelectionModel().getSelections();
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","请您至少选择一个!");
        }
        else{  
            Ext.Msg.confirm("提示!","您确定要删除该二级分类信息吗?",function(btn){ 
                if(btn=="yes")
                {
                   DeleteSecondCategoryInfo(row);
                }
                else
                {
                   
                }
            })
        }  
}


//-----------------------------------------------------修改选中行二级分类信息
EditSecondCategoryFn=function()
{
        var row=Ext.getCmp("SecondCategoryGrid").getSelectionModel().getSelections();
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","您没有选中任何行!");
        }
        else if(row.length>1){  
            Ext.Msg.alert("提示信息","对不起只能选择一个!");
        }else if(row.length==1)
        {
            //调用修改二级分类函数 
            EditSecondCategoryInfo(row[0]);//传行一行记录直接加载
        } 
                    
}


//------------------------------------------------------增加房间信息

AddSecondCategoryFn=function()
{	   
var AddSecondCategoryWin=new Ext.Window({
			title:"添加二级分类",
			width:410,
			height:180,
			plain:true, 
			iconCls:"addicon",
			//不可以随意改变大小
			resizable:false, 
			defaultType:"textfield",
			labelWidth:100,
			collapsible:true, //允许缩放条
            closeAction : 'hide',
            closable:true, 
			modal: 'true', //弹出模态窗体 
			buttonAlign:"center",
			bodyStyle:"padding:10px 0 0 15px",
			items:[AddSecondCategoryForm], 
			listeners:{
			    "show":function()
			    {
			        //当window show事件发生时清空一下表单
			        AddSecondCategoryForm.getForm().reset();
			    }
			},
			buttons:[{
					text:"保存信息",
					minWidth:70,
					handler:function()
					{
						if(AddSecondCategoryForm.getForm().isValid())
                            {
                                //弹出效果
                                Ext.MessageBox.show
                                (
                                    {
                                        msg: '正在保存，请稍等...',
							            progressText: 'Saving...',
							            width:300,
							            wait:true,
							            waitConfig: {interval:200},
							            icon:'download',
							            animEl: 'saving'
                                    }
                                );
                                setTimeout(function(){}, 1000);
                                AddSecondCategoryForm.form.submit({
                                    url:"category.do?actionType=add",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","添加二级分类信息成功!");
                                          
                                            SecondCategorystore.reload();
                                            AddSecondCategoryWin.hide();
                                            
                                        }
                                    },
                                    failure:function(form,action)
                                    {
                                        Ext.MessageBox.alert("提示!","保存二级分类信息失败!");
                                    }
                                });
                           }
					}
			},{
			    text:"重置",
			    minWidth:70,
			    qtip:"重置数据",
			    handler:function()
			    {
			        AddSecondCategoryForm.getForm().reset();
			    }
			},{
					text:"取 消",
					minWidth:70,
					handler:function()
					{
					    AddSecondCategoryWin.hide();
					}
			}]
		
	}
	);
	AddSecondCategoryWin.show();
}
var FirstCategoryFields = Ext.data.Record.create([{
				name : 'categoryid',
				mapping : 'categoryid'
			}, {
				name : 'categoryname',
				mapping : 'categoryname'
			}]);
 // var fields = ["categoryid","categoryname"];  
  var pageSize = 12;
var FirstCategorystore=new Ext.data.Store({
   	 proxy:new Ext.data.HttpProxy(
           {
                url:"category.do?actionType=first",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
   		   { 
                root:"data",
                id:"categoryid"
           },FirstCategoryFields),
           sortInfo: {field:'categoryid',direction: "ASC"}   
    });
	FirstCategorystore.load({params:{start:0,limit:pageSize}});
	
    var AddSecondCategoryForm=new Ext.form.FormPanel({
			width:375,
			height:160,
			plain:true,
			layout:"form",
			defaultType:"textfield",
			labelWidth:75,
            baseCls:"x-plain",
            
			//锚点布局-
			defaults:{anchor:"95%",msgTarget:"side"},
			buttonAlign:"center",
			bodyStyle:"padding:0 0 0 0",
			items:[{
			        name:"categoryName",
			        id:'secondCategoryName',
					fieldLabel:"<font color=red>类型名称</font>",
					allowBlank:false,
                    blankText:"二级分类名称不允许为空"
			},{
					xtype:"combo",
			        name:"firstCategory",
					fieldLabel:"<font color=red>一级分类</font>",
					tpl: '<tpl for="."><div ext:qtip="{categoryname}" class="x-combo-list-item">{categoryname}</div></tpl>',
	                hiddenName:"firstcategoryselected",
	                allowBlank:false,
					valueField:"categoryid",
					displayField:"categoryname",
			        triggerAction:"all",
                    blankText:"请指定一级分类" ,  
                    store:FirstCategorystore
			}]})


DeleteSecondCategoryInfo=function(row)
{ 
            var deletesplit="";
            for(var i=0;i<row.length;i++)
            {
                        if(row.length==1)
                        {
                            deletesplit=row[i].data.categoryid;
                        }
                        else
                        {
                            
                            if(i<(row.length-1))
                            {
                                deletesplit=row[i].data.categoryid+","+deletesplit;
                            }
                            if(i==(row.length-1))
                           {
                                deletesplit=deletesplit+row[i].data.categoryid;
                           } 
                        } 
             }  
            Ext.Ajax.request({
            url:"category.do?actionType=delete",
            method:"POST",
            params:{
                   categoryId:deletesplit
            },
            success:function()
            {
                   Ext.Msg.alert("恭喜您","删除成功了!"); 
                   SecondCategorystore.reload();
            },
            failure:function()
            {
                   Ext.Msg.alert("提 示","删除失败了!");
            }
            });

}
