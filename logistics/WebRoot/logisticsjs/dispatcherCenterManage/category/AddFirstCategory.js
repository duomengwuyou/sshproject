// JScript 文件
 
AddFirstCategoryInfo = function()
{  
    AddFirstCategoryWin.show();
}



var AddFirstCategoryForm=new Ext.form.FormPanel({
			width:375,
			height:100,
			plain:true,
			layout:"form",
			defaultType:"textfield",
			labelWidth:85,
            baseCls:"x-plain",
			//锚点布局-
			defaults:{anchor:"95%",msgTarget:"side"},
			buttonAlign:"center",
			bodyStyle:"padding:0 0 0 0",
			items:[   
			{
			        name:"categoryName",
			        id:'categoryname',
					fieldLabel:"<font color=red>一级分类名称</font>",
					allowBlank:false,
                    blankText:"一级分类名称不允许为空"
			}]});


 var AddFirstCategoryWin=new Ext.Window({
			title:"添加一级分类",
			width:410,
			height:130,
			plain:true,
			//layout:"form",
			iconCls:"addicon",
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
			items:[AddFirstCategoryForm],
			listeners:{
			    "show":function()
			    {
			        //当window show事件发生时清空一下表单
			        AddFirstCategoryForm.getForm().reset();
			    }
			},
			buttons:[{
					text:"保存信息",
					minWidth:70,
					handler:function()
					{
						if(AddFirstCategoryForm.getForm().isValid())
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
                                AddFirstCategoryForm.form.submit({
                                    url:"category.do?actionType=add",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                       /* var flag=action.result.success;
                                        if(flag)
                                        {*/
                                            Ext.MessageBox.alert("恭喜","添加一级分类信息成功!");
                                            FirstCategoryStore.reload(); 
                                            AddFirstCategoryWin.hide();
                                            
                                       /* }*/
                                    },
                                    failure:function(form,action)
                                    {
                                        Ext.MessageBox.alert("提示!","保存一级分类信息失败!");
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
			        AddFirstCategoryForm.getForm().reset();
			    }
			},{
					text:"取 消",
					minWidth:70,
					handler:function()
					{
					    AddFirstCategoryWin.hide();
					}
			}]
	
	});
    

    
