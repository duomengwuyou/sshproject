// JScript 文件
//定义二级分类编号

var typeids="";//获得传入ID
var rows="";//获得传入数据

var EditSecondCategoryForm=new Ext.form.FormPanel({
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
					fieldLabel:"二级分类编号",
					readOnly:true
					//Text:
			},{
			        name:"categoryname",
					fieldLabel:"二级分类名称",
					allowBlank:false,//不允许为空 
                    blankText:"二级分类名称不允许为空"///快速提示框
			},{
				    xtype:'combo',
			        hiddenName:"parentcategory",
					fieldLabel:"一级分类",
					tpl: '<tpl for="."><div ext:qtip="{categoryname}" class="x-combo-list-item">{categoryname}</div></tpl>',
	                displayField:"categoryname",
					valueField:"categoryid",
					allowBlank:false,
					 triggerAction:"all",
					store:FirstCategorystore
					
					
			}]});
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
           })  
    });

 var EditSecondCategorywin=new Ext.Window({
			title:"修改二级分类信息",
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
			items:[EditSecondCategoryForm],
			listeners:{
				    
					"show":function()
					{
                        EditSecondCategoryForm.getForm().loadRecord(rows);//直接加载一行数据
					}
			},
			buttons:[{
					text:"保存信息",
					minWidth:80,
					handler:function()
					{
						if(EditSecondCategoryForm.getForm().isValid())
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
                                EditSecondCategoryForm.getForm().submit({
                                    url:"category.do?actionType=edit",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","编辑二级分类信息成功!"); 
                                            SecondCategorystore.reload();
                                            EditSecondCategorywin.hide();
                                            
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
					minWidth:80,
					handler:function()
					{
					    EditSecondCategoryForm.getForm().loadRecord(rows);//直接加载一行数据
                        //设置combo状态
                        if(EditSecondCategoryForm.findByType("combo")[0].value=="否")
                         {
                                  
                            //禁用该组件
	                        EditSecondCategoryForm.findById("addbed").disable();
	                        EditSecondCategoryForm.findById("addbed").setValue("0.00");
                         }
                        else
                        {
                            //否则启动该组件
                            EditSecondCategoryForm.findById("addbed").enable();
                        }
					    
					}
			},{
					text:"取 消",
					minWidth:80,
					handler:function()
					{
					    EditSecondCategorywin.hide();
					}
			}]
	
	});
    

EditSecondCategoryInfo=function(row)
{  
    //typeids=typeid;
    rows=row;
    EditSecondCategorywin.show();
}
    
