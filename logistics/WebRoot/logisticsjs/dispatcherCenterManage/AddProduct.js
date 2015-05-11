// JScript 文件
var GoodsisOK=false;
var goodststore;
var goodstfileds = Ext.data.Record.create([      
       {name: 'goodsTypeId',mapping:'goodsTypeId'},{name: 'goodsTypeName',mapping:'goodsTypeName'},{name:'goodsTypeRemark',mapping:'goodsTypeRemark'}                     
     ]);
    goodststore = new Ext.data.Store({      
        proxy: new Ext.data.HttpProxy({      
            //url:'servlet/GoodsTypeServlet' 
            method:"POST" 
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'goodsTypeId'     
        },
        goodstfileds 
        )      
    });   
    goodststore.load();
    CheckGoodsIsOk=function()
    {
           
            var goodsId=Ext.get('goodsId').dom.value;
            Ext.Ajax.request({
                    //url:'servlet/CheckGoodsIdServlet',
                    method:"POST",
                    params:{goodsId:goodsId},
                    success: function(response, options) {  
                       var responseArray = Ext.util.JSON.decode(response.responseText); 
                                                         
                       if(responseArray.success == true){ //房间号已经存在       
                           SetValue(false);
                       }else{//房间号可以使用               
                           SetValue(true);
                       }  
                    }  
                });
            function SetValue(b){
                  GoodsisOK = b;//给变量赋值
            }
           return GoodsisOK;
     }
     
var AddGoodsInfofp=new Ext.form.FormPanel({
			width:375,
			height:600,
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
				name:"goodsId",
				id:"goodsId",
				fieldLabel:"<font color=red>商品ID</font>",
				allowBlank:false,
				blankText:"商品ID不允许为空",
				validator:CheckGoodsIsOk,//指定验证器
                invalidText:'该商品ID己在存在'
			},
				{
			        name:"goodsName",
					fieldLabel:"<font color=red>商品名称</font>",
					allowBlank:false,
                    blankText:"商品名称不允许为空"
			},
				{     
			        //id : 'goodsType',
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
				//	regex:/[0-9.][1-9]{0,10}$/,
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
			


 var AddGoodsInfoWin=new Ext.Window({
			title:"添加商品信息",
			width:410,
			height:310,
			plain:true,
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
            plain : true,
            //弹出模态窗体
			modal: 'true', 
			buttonAlign:"center",
			bodyStyle:"padding:10px 0 0 15px",
			items:[AddGoodsInfofp],
			listeners:{
			    "show":function()
			    {
			        //当window show事件发生时清空一下表单
			        AddGoodsInfofp.getForm().reset();
			    }
			},
			buttons:[{
					text:"保存信息",
					minWidth:70,
					handler:function()
					{
						if(AddGoodsInfofp.getForm().isValid())
                            {
                                //弹出效果
                                Ext.MessageBox.show({
                                        msg: '正在保存，请稍等...',
							            progressText: 'Saving...',
							            width:300,
							            wait:true,
							            waitConfig: {interval:200},
							            icon:'download',
							            animEl: 'saving'
                                    }
                                );
                                setTimeout(function(){Ext.MessageBox.hide();
                                }, 1000);
                                AddGoodsInfofp.form.submit({
                                    //url:"servlet/AddGoodsServlet",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            //填 写开房房间信息
                                        	Ext.MessageBox.alert("恭喜","添加商品信息成功!");
                                        	GoodsInfostore.reload();
                                            AddGoodsInfoWin.hide();
                                           // OpenRoomInfoWin.show();
                                        }
                                    },
                                    failure:function(form,action)
                                    {
                                    	GoodsInfostore.reload();
                                        Ext.MessageBox.alert("提示!","保存商品信息失败!");
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
			        AddGoodsInfofp.getForm().reset();
			    }
			},{
					text:"取 消",
					minWidth:70,
					handler:function()
					{
					    AddGoodsInfoWin.hide();
					}
			}]
	
	});


AddGoodsInfo=function()
{
    AddGoodsInfoWin.show();
}
