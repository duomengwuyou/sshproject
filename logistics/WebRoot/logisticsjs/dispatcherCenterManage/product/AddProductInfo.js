/**
 * 添加商品
 * 张文华
 */
	
AddProductInfo=function()
{
var firstcategoryfields=Ext.data.Record.create([{name:"categoryid",mapping:"categoryid"},{name:"categoryname",mapping:"categoryname"}]);
var secondcategoryfields=Ext.data.Record.create([{name:"categoryid",mapping:"categoryid"},{name:"categoryname",mapping:"categoryname"}]);
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
           },firstcategoryfields),
           sortInfo: {field:'categoryid',direction: "ASC"}   
    }); 
    FirstCategorystore.load();
    var SecondCategorystore=new Ext.data.Store({
   	 proxy:new Ext.data.HttpProxy(
           {
                url:"category.do?actionType=second",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
   		   { 
                root:"data",
                id:"categoryid"
           },secondcategoryfields),
           sortInfo: {field:'categoryid',direction: "ASC"}   
    });
    SecondCategorystore.load();
var supplierfields=Ext.data.Record.create([{name:"supplierId",mapping:"supplierId"},
{name:"supplierName",mapping:"supplierName"},
{name:"supplierAdd",mapping:"supplierAdd"},
{name:"contactPerson",mapping:"contactPerson"},
{name:"supplierTel",mapping:"supplierTel"},
{name:"bank",mapping:"bank"},
{name:"bankAccount",mapping:"bankAccount"},
{name:"fax",mapping:"fax"},
{name:"supplierZipCode",mapping:"supplierZipCode"},
{name:"legalPerson",mapping:"legalPerson"},
{name:"supplierRemark",mapping:"supplierRemark"}]);
var proSupplierStore=new Ext.data.Store({
 proxy:new Ext.data.HttpProxy(
           {
                url:"supplierManage.do?actionType=display",
                method:"POST"
           }),
           reader:new Ext.data.JsonReader(
   		   { 
                root:"data",
                id:"supplierId"
           },supplierfields),
            sortInfo: {field:'supplierId',direction: "ASC"}   
});
proSupplierStore.load();
    var AddProductInfofp=new Ext.form.FormPanel({
			width:380,
			height:600,
			plain:true,
			layout:"form",
			defaultType:"textfield",
			labelWidth:100,
            baseCls:"x-plain",
			//锚点布局-
			defaults:{anchor:"95%",msgTarget:"side"},
			buttonAlign:"center",
			bodyStyle:"padding:0 0 0 0",
			items:[{      
			        name:"firstcategory",
				    xtype:"combo",
				    tpl: '<tpl for="."><div ext:qtip="{categoryname}" class="x-combo-list-item">{categoryname}</div></tpl>',
	                typeAhead: true,
	                fieldLabel:'商品一级分类', 
	                width:130, 
	                forceSelection: true,
	                hiddenName:"firstcategoryselected",
	                triggerAction: 'all',
	                emptyText:'请选择商品类别',
	                selectOnFocus:true, 
	                editable: false, 
	                allowBlank:false, 
	                blankText:'请选择类别', 
	                displayField:'categoryname',
	                valueField: 'categoryid',
	                store:FirstCategorystore,
	                listeners :{
	                select:function(firstcategory, record,index){
	                SecondCategorystore.load({params:{
	                firstcategory:Ext.get("firstcategoryselected").dom.value
	                }});
	                }
	                },
	                mode: 'remote'
			},{     
			        name:"secondcategory1",
				    xtype:"combo",
				    tpl: '<tpl for="."><div ext:qtip="{categoryname}" class="x-combo-list-item">{categoryname}</div></tpl>',
	                store:SecondCategorystore,
	                typeAhead: true,
	                fieldLabel:'商品二级分类',
	                forceSelection: true,
	                hiddenName:"secondcategory",
	                triggerAction: 'all',
	                emptyText:'请选择商品类别',
	                selectOnFocus:true,
	                width:130,
	                editable: false, 
	                allowBlank:false, 
	                blankText:'请选择类别', 
	                displayField:'categoryname',
	                valueField: 'categoryid',
	                mode: 'remote'
			},{
			        name:"productName",
					fieldLabel:"<font color=red>商品名称</font>",
					allowBlank:false,
                    blankText:"商品名称不允许为空"
			},{
					name:"unit",
					fieldLabel:"计量单位",
//					xtype:"datafield",
					allowBlank:false,
					blankText:"单位不能为空"
			},{
			       
			        name:"originalPrice",
					fieldLabel:"原价",
					allowBlank:false,
                    blankText:"原价不允许为空",
				//	regex:/[0-9.][1-9]{0,10}$/,
                    regexText:"小数-第一位不允许有小数点"
					
			},{
			       
			        name:"discount",
					fieldLabel:"商品折扣率",
					allowBlank:false,
                    blankText:"商品折扣率不允许为空",
                    regex:/[0.][1-9]|[1.][0]/
			},{
			       
			        name:"costPrice",
					fieldLabel:"成本价",
					allowBlank:false,
                    blankText:"成本价不允许为空",
				//	regex:/[0-9.][1-9]{0,10}$/,
                    regexText:"小数-第一位不允许有小数点"
					
			},{
			       
			        name:"productType",
					fieldLabel:"型号",
					allowBlank:true
					
			},{
			        xtype:"combo",
			        name:"supplier",
					tpl: '<tpl for="."><div ext:qtip="{supplierName}" class="x-combo-list-item">{supplierName}</div></tpl>',
					store:proSupplierStore,
					fieldLabel:"供应商",
					allowBlank:false,
					forceSelection: true,
					typeAhead: true,
					hiddenName:"supplierSelected",
				    triggerAction: 'all',
					displayField:'supplierName',
					valueField:'supplierId',
                    blankText:"供应商不允许为空",
                    mode: 'remote'
					
			},{
			       
			        name:"manufacturer",
					fieldLabel:"厂商",
					allowBlank:false,
                    blankText:"厂商不允许为空"
					
			},{
			       xtype:"datefield",
			        format:"Y-m-d",
			        name:"guaranteePeriod",
					fieldLabel:"保质期限",
					allowBlank:true,
					
					
			},{
	                xtype:"combo",
	                name:'returnable',
	                fieldLabel:'可否退货',
	                emptyText:'请选择是否可退货',
	                allowBlank:false, 
	                blankText:'请选择是否可退货',
	                editable: false, 
	                hiddenName:'returnable',
	                store:new Ext.data.SimpleStore({
		            data:[["否","否"],["是","是"]],
		            fields:["state","value"]
		            }),
		            tpl: '<tpl for="."><div ext:qtip="退货状态为--{state}" class="x-combo-list-item">{state}</div></tpl>',
		            displayField:"state",
		            mode:"local",
		            valueField:"value",
		            triggerAction:"all"
            },{
	                xtype:"combo",
	                name:'changeable',
	                fieldLabel:'是否换货',
	                emptyText:'请选择是否可换货',
	                allowBlank:false, 
	                blankText:'请选择是否可换货',
	                editable: false, 
	                hiddenName:'changeable',
	                store:new Ext.data.SimpleStore({
		            data:[["否","否"],["是","是"]],
		            fields:["state","value"]
		            }),
		            tpl: '<tpl for="."><div ext:qtip="换货状态为--{state}" class="x-combo-list-item">{state}</div></tpl>',
		            displayField:"state",
		            mode:"local",
		            valueField:"value",
		            triggerAction:"all"
            },{
			        name:"productRemark",
			        xtype:"textarea",
					fieldLabel:"商品描述",
					allowBlank:true,
                   // blankText:"商品描述不允许为空"
					regex:/^[\s\S]{1,50}$/,
                    regexText:"描述请不要超过50个字符"
					
			}]});
			


 var AddProductInfoWin=new Ext.Window({
			title:"添加商品信息",
			width:430,
			height:530,
			plain:true,
			iconCls:"addicon", 
			resizable:false, 
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
			items:[AddProductInfofp],
			listeners:{
			    "show":function()
			    {
			        //当window show事件发生时清空一下表单
			        AddProductInfofp.getForm().reset();
			    }
			},
			buttons:[{
					text:"保存信息",
					minWidth:70,
					handler:function()
					{
						if(AddProductInfofp.getForm().isValid())
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
                                AddProductInfofp.form.submit({
                                    url:"productInfo.do?actionType=add",
                                    method:"POST",
                                    success:function(form,action)
                                    {
                                        //成功后
                                        var flag=action.result.success;
                                        if(flag)
                                        {
                                            //填 写开房房间信息
                                        	Ext.MessageBox.alert("恭喜","添加商品信息成功!");
                                        	//ProductInfostore.reload();
                                            AddProductInfoWin.hide(); 
                                        }
                                    },
                                    failure:function(form,action)
                                    {
                                    	ProductInfostore.reload();
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
			        AddProductInfoWin.getForm().reset();
			    }
			},{
					text:"取 消",
					minWidth:70,
					handler:function()
					{
					    AddProductInfoWin.hide();
					}
			}]
	
	});
    AddProductInfoWin.show();
}

CheckProductIsOk=function()
{
       
        var productId=Ext.get('productId').dom.value;
        Ext.Ajax.request({
               // url:'servlet/CheckGoodsIdServlet',
                method:"POST",
                params:{productId:productId},
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
              ProductisOK = b;//给变量赋值
        }
       return ProductisOK;
  } 

    
    
    




