/**
 * 添加供应商
 * @ author:罗荣博
 */
// JScript 文件

  //添加供应商时判断该供应商ID是否存在
    var SupplierisOK = false;
    
 

var AddSupplierForm=new Ext.form.FormPanel({
			width:400,
			height:400,
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
			        name:"supplierName",
			        id:'supplierName',
					fieldLabel:"供应商名称",
					allowBlank:false,
                    blankText:"供应商名称不允许为空"
			},{
			        name:"supplierAdd",
			        id:'supplierAdd',
					fieldLabel:"地址",
					allowBlank:false,
                    blankText:"地址不允许为空"
			},{
			        name:"contactPerson",
			        id:'contactPerson',
					fieldLabel:"联系人",
					allowBlank:false,
                    blankText:"联系人不允许为空"
			},{
			        name:"supplierTel",
			        id:'supplierTel',
					fieldLabel:"联系电话",
					allowBlank:false,
                    blankText:"联系电话不允许为空"
			},{
			        name:"bank",
			        id:'bank',
					fieldLabel:"开户行",
					allowBlank:false,
                    blankText:"开户行不允许为空"
			},{
			        name:"bankAccount",
			        id:'bankAccount',
					fieldLabel:"银行帐号",
					allowBlank:false,
                    blankText:"银行帐号不允许为空"
			},{
			        name:"fax",
			        id:'fax',
					fieldLabel:"传真",
					allowBlank:false,
                    blankText:"传真不允许为空"
			},{
			        name:"supplierZipCode",
			        id:'supplierZipCode',
					fieldLabel:"邮编",
					allowBlank:false,
                    blankText:"邮编不允许为空"
			},{
			        name:"legalPerson",
			        id:'legalPerson',
					fieldLabel:"法人",
					allowBlank:false,
                    blankText:"法人不允许为空"
			},{
			        name:"supplierRemark",
			        xtype:"textarea",
					fieldLabel:"备注",
					allowBlank:true,
                    regex:/^[\s\S]{1,50}$/,
                    regexText:"描述请不要超过50个字符"
			}]});

 var AddSupplierwin=new Ext.Window({
			title:"添加供应商信息",
			width:430,
			height:410,
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
			items:[AddSupplierForm],
			listeners:{
			    "show":function(){
			        //当window show事件发生时清空一下表单
			        AddSupplierForm.getForm().reset();
			    }
			},
			buttons:[{
					text:"保存信息",
					minWidth:70,
					handler:function(){
						if(AddSupplierForm.getForm().isValid()){
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
                                AddSupplierForm.form.submit({
                                    url:"supplierManage.do?actionType=add",
                                    method:"POST",
                                    success:function(form,action){
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag){
                                            Ext.MessageBox.alert("恭喜","添加供应商信息成功!");
                                            SupplierStore.reload();
                                            AddSupplierwin.hide();
                                            
                                        }
                                    },
                                    failure:function(form,action){
                                        Ext.MessageBox.alert("提示!","保存供应商信息失败!");
                                    }
                                });
                           }
					}
			},{
			    text:"重置",
			    minWidth:70,
			    qtip:"重置数据",
			    handler:function(){
			        AddSupplierForm.getForm().reset();
			    }
			},{
					text:"取 消",
					minWidth:70,
					handler:function(){
					    AddSupplierwin.hide();
					}
			}]
	});
AddSupplierInfo=function(){ 
	//alert("AddSupplierwin");
    AddSupplierwin.show();
}
    
