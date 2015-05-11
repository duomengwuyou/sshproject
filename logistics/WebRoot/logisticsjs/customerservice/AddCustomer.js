/**
 * 张文华
 * 添加客户
 */
//alert("addcustomer!!!");
AddCustomerInfo = function(){  
	var AddCustomerForm=new Ext.form.FormPanel({
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
			        name:"customerName",
			       // id:'customerName',
					fieldLabel:"<font color=red>客户姓名</font>",
					allowBlank:false,
                    blankText:"客户姓名不允许为空"
			},{
			        name:"idcard",
			      //  id:'idCard',
					fieldLabel:"<font color=red>客户身份证</font>",
					allowBlank:false,
                    blankText:"客户身份证号不允许为空",
                    regex:/[1-9]/,
                    regexText:"数字组成"
			},{
			        name:"workPlace",
			      //  id:'workPlace',
					fieldLabel:"工作单位",
					allowBlank:true
			},{
			        name:"phone",
					fieldLabel:"固定电话",
					allowBlank:true,
					//regex:/^[1-9][0-9.]{1,10}$/,
                    regex:/[1-9]/,
                    regexText:"数字组成"
			},{
			        name:"mobile",
					fieldLabel:"<font color=red>移动电话</font>",
					allowBlank:false,
                    blankText:"移动电话不允许为空",
                    regex:/[1-9]/,
                    regexText:"数字组成"
					
			},{
			        name:"address",
					fieldLabel:"<font color=red>地址</font>",
					allowBlank:false,
                    blankText:"地址不允许为空"
					
			},{
			        name:"customerZipCode",
					fieldLabel:"邮编",
					allowBlank:true,
                    regex:/[1-9]/,
                    regexText:"数字组成"
					
			},{
			        name:"email",
					fieldLabel:"邮箱",
					allowBlank:true,
                    regex:/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/,
                    regexText:"**.@**.com"
					
			}]});
 	var AddCustomerwin=new Ext.Window({
			title:"添加客户信息",
			width:410,
			height:330,
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
			items:[AddCustomerForm],
			listeners:{
			    "show":function()
			    {
			        //当window show事件发生时清空一下表单
			        AddCustomerForm.getForm().reset();
			    }
			},
			buttons:[{
					text:"保存信息",
					minWidth:70,
					handler:function()
					{
						if(AddCustomerForm.getForm().isValid())
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
                                AddCustomerForm.form.submit({
                                    url:"customerInfo.do?actionType=addCustomer",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","添加客户信息成功!");
                                          
                                            Customerstore.reload();
                                            AddCustomerwin.hide();
                                        }
                                    },
                                    failure:function(form,action)
                                    {
                                        Ext.MessageBox.alert("提示!","保存客户信息失败!");
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
			        AddCustomerForm.getForm().reset();
			    }
			},{
					text:"取 消",
					minWidth:70,
					handler:function()
					{
					    AddCustomerwin.hide();
					}
			}]
	});
    AddCustomerwin.show();
}
