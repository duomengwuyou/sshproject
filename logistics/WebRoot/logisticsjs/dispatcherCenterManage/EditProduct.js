// JScript 文件
//定义房间类型编号

var typeids="";//获得传入ID
var rows="";//获得传入数据
var goodststore;
var goodstfileds = Ext.data.Record.create([      
       {name: 'goodsTypeId',mapping:'goodsTypeId'},{name: 'goodsTypeName',mapping:'goodsTypeName'},{name:'goodsTypeRemark',mapping:'goodsTypeRemark'}                     
     ]);
    goodststore = new Ext.data.Store({      
        proxy: new Ext.data.HttpProxy({      
            ////url:'servlet/GoodsTypeServlet'  
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'goodsTypeId'     
        },
        goodstfileds 
        )      
    });   
    goodststore.load();
var EditGoodsForm=new Ext.form.FormPanel({
			width:375,
			height:280,
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
			        name:"goodsId",
					fieldLabel:"商品类别编号",
					readOnly:true
			},{
			        name:"goodsName",
					fieldLabel:"<font color=red>商品名称</font>",
					allowBlank:false,
                    blankText:"商品名称不允许为空"
			},
				{     
			        
			         name:"goodsType",
				    xtype:"combo",
				    tpl: '<tpl for="."><div ext:qtip="{goodsTypeName}. {goodsTypeRemark}" class="x-combo-list-item">{goodsTypeName}</div></tpl>',
	                store:goodststore,
	                typeAhead: true,
	                fieldLabel:'商品类别',
	                //hiddenName:'goodsTypeId',
	                //name:'typeids',
	                forceSelection: true,
	                triggerAction: 'all',
	                emptyText:'请选择商品类别',
	                selectOnFocus:true,
	                width:130,
	                editable: false, 
	                allowBlank:false, 
	                blankText:'请选择类别', 
	                displayField:'goodsTypeName',
	                valueField: 'goodsTypeId',
	                mode: 'remote'
			},{
			       
			        name:"goodsPrice",
					fieldLabel:"单价",
					allowBlank:false,
                    blankText:"单价不允许为空",
					regex:/[0-9.][1-9]{1,10}$/,
                    regexText:"小数-第一位不允许有小数点"
					
			},{
					name:"unit",
					fieldLabel:"单位",
//					xtype:"datafield",
					allowBlank:false,
					blankText:"单位不能为空"
			},{
			       
			        name:"goodsDiscount",
					fieldLabel:"商品折扣率",
					allowBlank:false,
                    blankText:"商品折扣率不允许为空",
                    regex:/[0.][1-9]|[1.][0]/
			},{
			        name:"goodsRemark",
			        xtype:"textarea",
					fieldLabel:"商品描述",
					allowBlank:true,
                   // blankText:"商品描述不允许为空"
					regex:/^[\s\S]{1,50}$/,
                    regexText:"描述请不要超过50个字符"
					
			}]});


 var EditGoodswin=new Ext.Window({
			title:"修改商品类别信息",
			width:410,
			height:300,
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
			items:[EditGoodsForm],
			listeners:{
				    
					"show":function()
					{
						    EditGoodsForm.getForm().loadRecord(rows);
					}

                        
			},
			buttons:[{
					text:"保存信息",
					minWidth:80,
					handler:function()
					{
						if(EditGoodsForm.getForm().isValid())
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
                                EditGoodsForm.getForm().submit({
                                    //url:"servlet/UpdateGoodsServlet",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            Ext.MessageBox.alert("恭喜","编辑商品信息成功!");
                                            //grid.store.reload();
                                            GoodsInfostore.reload();
                                            EditGoodswin.hide();
                                            
                                        }
                                    },
                                    failure:function(form,action)
                                    {
                                        Ext.MessageBox.alert("提示!","保存商品类别信息失败!");
                                    }
                                });
                           }
					}
			},{
					text:"重置",
					minWidth:80,
					handler:function()
					{
					    EditGoodsForm.getForm().loadRecord(rows);//直接加载一行数据
                        //设置combo状态
//                        if(EditGoodsTypeForm.findByType("combo")[0].value=="否")
//                         {
//                                  
//                            //禁用该组件
//	                        EditRoomTypeForm.findById("addbed").disable();
//	                        EditRoomTypeForm.findById("addbed").setValue("0.00");
//                         }
//                        else
//                        {
//                            //否则启动该组件
//                            EditRoomTypeForm.findById("addbed").enable();
//                        }				    
					}
			},{
					text:"取 消",
					minWidth:80,
					handler:function()
					{
					    EditGoodswin.hide();
					}
			}]
	
	});
    

EditGoodsInfo=function(row)
{  
    //typeids=typeid;
    rows=row;
    EditGoodswin.show();
}
    
