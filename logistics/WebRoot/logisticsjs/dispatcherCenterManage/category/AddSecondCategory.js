// JScript 文件
/*var AddSecondCategoryWin=new Ext.Window({
			title:"添加二级分类",
			width:410,
			height:200,
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
                                    url:"servlet/AddSecondCategoryServlet",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","添加二级分类信息成功!");
                                          
                                            SecondCategorystore.reload();
                                            AddSecondCategorywin.hide();
                                            
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
					    AddFirstCategoryWin.hide();
					}
			}]
	
	});
	
    var AddSecondCategoryForm=new Ext.form.FormPanel({
			width:375,
			height:270,
			plain:true,
			layout:"form",
			defaultType:"textfield",
			labelWidth:75,
            baseCls:"x-plain",
			//锚点布局-
			defaults:{anchor:"95%",msgTarget:"side"},
			buttonAlign:"center",
			bodyStyle:"padding:0 0 0 0",
			items:[   
			{
			        name:"roomTypeId",
			        id:'roomTypeId',
					fieldLabel:"<font color=red>类型ID</font>",
					allowBlank:false,
                    blankText:"房间类型ID不允许为空",
                   // validator:CheckRoomTypeIsOk,//指定验证器
                    invalidText:'该商品类别ID己在存在'
			},{
			        name:"roomTypeName",
			        id:'roomTypeName',
					fieldLabel:"<font color=red>类型名称</font>",
					allowBlank:false,
                    blankText:"房间类型名称不允许为空"
			},{
			        name:"limitedNum",
					fieldLabel:"<font color=red>额定人数</font>",
					allowBlank:false,
                    blankText:"额定人数不允许为空",
					//regex:/^[1-9][0-9.]{1,10}$/,
                    regex:/[1-9]/,
                    regexText:"1到9的数字"
			},{
			        name:"typeRemark",
			        xtype:"textarea",
					fieldLabel:"类型描述",
					allowBlank:true,
                   // blankText:"房间类型描述不允许为空",
                    regex:/^[\s\S]{1,50}$/,
                    regexText:"描述请不要超过50个字符"
					
			}]})*/



//添加二级分类
/*
AddSecondCategoryInfo = function()
{  	alert("2在添加二级分类页面中，开始添加--！");
    AddSecondCategoryWin.show();
}
*/