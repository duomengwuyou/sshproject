// JScript 文件
/**
 * 修改供应商信息
 * @author:罗荣博
 */
//定义供应商编号

var typeids="";//获得传入ID
var rows="";//获得传入数据

var EditSupplierForm=new Ext.form.FormPanel({
			width:400,
			height:400,
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
			items:[{
			        name:"supplierId",
					fieldLabel:"供应商编号",
					//hiddenName:"floorId",
					//disabled:true,
					blankText:"供应商编号不能修改",
					readOnly:true
			},{
			        name:"supplierName",
					fieldLabel:"供应商名称",
					allowBlank:false,//不允许为空 
                    blankText:"供应商名称不允许为空"///快速提示框
			},{
			        name:"supplierAdd",
					fieldLabel:"地址",
					allowBlank:false,//不允许为空 
                    blankText:"地址不允许为空"///快速提示框
			},{
			        name:"contactPerson",
					fieldLabel:"联系人",
					allowBlank:false,//不允许为空 
                    blankText:"联系人不允许为空"///快速提示框
			},{
			        name:"supplierTel",
					fieldLabel:"联系电话",
					allowBlank:false,//不允许为空 
                    blankText:"联系电话不允许为空"///快速提示框
			},{
			        name:"bank",
					fieldLabel:"开户行",
					allowBlank:false,//不允许为空 
                    blankText:"开户行不允许为空"///快速提示框
			},{
			        name:"bankAccount",
					fieldLabel:"银行帐号",
					allowBlank:false,//不允许为空 
                    blankText:"银行帐号不允许为空"///快速提示框
			},{
			        name:"fax",
					fieldLabel:"传真",
					allowBlank:false,//不允许为空 
                    blankText:"传真不允许为空"///快速提示框
			},{
			        name:"supplierZipCode",
					fieldLabel:"邮编",
					allowBlank:false,//不允许为空 
                    blankText:"邮编不允许为空"///快速提示框
			},{
			        name:"legalPerson",
					fieldLabel:"法人",
					allowBlank:false,//不允许为空 
                    blankText:"法人不允许为空"///快速提示框
			},{
			        name:"supplierRemark",
			        xtype:"textarea",
					fieldLabel:"备注",
					allowBlank:true,//允许为空
                    regex:/^[\s\S]{1,50}$/,
                    regexText:"描述请不要超过50个字符"//正则表达报错
					
			}]});


 var EditSupplierwin=new Ext.Window({
			title:"修改供应商信息",
			width:430,
			height:410,
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
			items:[EditSupplierForm],
			listeners:{
				   "show":function(){
                        EditSupplierForm.getForm().loadRecord(rows);//直接加载一行数据
					}
			},
			buttons:[{
					text:"保存信息",
					minWidth:80,
					handler:function(){
						if(EditSupplierForm.getForm().isValid())
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
                                EditSupplierForm.getForm().submit({
                                    url:"supplierManage.do?actionType=mod",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","修改供应商信息成功!");
                                            //grid.store.reload();
                                            SupplierStore.reload();
                                            EditSupplierwin.hide();
                                            
                                        }
                                    },
                                    failure:function(form,action)
                                    {
                                        Ext.MessageBox.alert("提示!","保存供应商信息失败!");
                                    }
                                });
                           }
					}
			},{
					text:"重置",
					minWidth:80,
					handler:function(){
					    EditSupplierForm.getForm().loadRecord(rows);//直接加载一行数据
					}
			},{
					text:"取 消",
					minWidth:80,
					handler:function(){
					    EditSupplierwin.hide();
					}
			}]
	
	});
    

EditSupplierInfo=function(row){   
    rows=row;
    EditSupplierwin.show();
}
    
