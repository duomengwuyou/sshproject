// JScript 文件
//定义房间类型编号

var typeids="";//获得传入ID
var rows="";//获得传入数据

var EditFirstCategoryForm=new Ext.form.FormPanel({
			width:375,
			height:160,
			plain:true,
			layout:"form",
			defaultType:"textfield",
			labelWidth:100,
            plain : true, 
            baseCls:"x-plain",
			//锚点布局-
			defaults:{anchor:"95%",msgTarget:"side"},
			buttonAlign:"center",
			bodyStyle:"padding:0 0 0 0",
			items:[   
			{
			        name:"categoryid",
					fieldLabel:"一级商品分类编号",
					readOnly:true
			},{
			        name:"categoryname",
					fieldLabel:"一级分类名称",
					allowBlank:false,//不允许为空 
                    blankText:"一级分类名称不允许为空"///快速提示框
			}]});


 var EditFirstCategoryWin=new Ext.Window({
			title:"修改一级分类信息",
			width:410,
			height:180,
			plain:true,
			//layout:"form",
			iconCls:"editicon",
			//不可以随意改变大小
			resizable:false,
			//是否可以拖动
			//draggable:false,
			defaultType:"textfield",
			labelWidth:100,
			collapsible:true, //允许缩放条
            closeAction : 'hide',
            closable:true,
            plain : true,
            //弹出模态窗体
			modal: 'true', 
			buttonAlign:"center",
			bodyStyle:"padding:8px 0 0 10px",
			items:[EditFirstCategoryForm], 
			listeners:{ 
					"show":function()
					{  
                        EditFirstCategoryForm.getForm().loadRecord(rows);//直接加载一行数据
                        
					}
			},
			buttons:[{
					text:"保存信息",
					minWidth:80,
					handler:function()
					{
						if(EditFirstCategoryForm.getForm().isValid())
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
                                EditFirstCategoryForm.getForm().submit({
                                    url:"category.do?actionType=edit",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","编辑一级分类信息成功!");
                                            //grid.store.reload();
                                            
                                            FirstCategoryStore.reload();
                                            EditFirstCategoryWin.hide();
                                            
                                        }
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
					minWidth:80,
					handler:function()
					{
					    EditFirstCategoryForm.getForm().loadRecord(rows);//直接加载一行数据
                        //设置combo状态
                        if(EditFirstCategoryForm.findByType("combo")[0].value=="否")
                         {
                                  
                            //禁用该组件
	                        EditFirstCategoryForm.findById("addbed").disable();
	                        EditFirstCategoryForm.findById("addbed").setValue("0.00");
                         }
                        else
                        {
                            //否则启动该组件
                            EditFirstCategoryForm.findById("addbed").enable();
                        }
					    
					}
			},{
					text:"取 消",
					minWidth:80,
					handler:function()
					{
					    EditFirstCategoryWin.hide();
					}
			}]
	
	});
    

EditFirstCategoryInfo=function(row)
{   
    rows=row; 
    EditFirstCategoryWin.show();
}
    
