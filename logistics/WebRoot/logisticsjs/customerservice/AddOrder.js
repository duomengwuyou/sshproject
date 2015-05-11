/**
 * 张文华
 * 添加订单 
 */
var addorderstore;
var secondclassstore;
var productstore;
var purchasestore;

AddOrder = function(row){
	//商品一级分类	
	//alert("进入添加订单");
	var firstclassfileds = Ext.data.Record.create([
	{name:'categoryid',mapping:'categoryid'},{name:'categoryname',mapping:'categoryname'}
	]);
	var firstclassstore = new Ext.data.Store({
		 proxy: new Ext.data.HttpProxy({      
        	url : 'orderProductInfo.do?actionType=getFirstcategory',
		 	method : "POST"
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'categoryid'     
        },
        firstclassfileds 
        )      
	});
	firstclassstore.load();	
	
	//商品二级分类
	var secondclassfileds = Ext.data.Record.create([
	{name:'categoryid',mapping:'categoryid'},{name:'categoryname',mapping:'categoryname'}
	]);
	secondclassstore = new Ext.data.Store({
		 proxy: new Ext.data.HttpProxy({      
        	url : 'orderProductInfo.do?actionType=getParent',
		 	method : "POST"
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'categoryid'     
        },
        secondclassfileds 
        )      
	});
	secondclassstore.load();
	
	//货物投递分站
	var deliverfileds = Ext.data.Record.create([
	{name:'substationId',mapping:'substationId'},{name:'substationAdd',mapping:'substationAdd'}
	]);
	var deliverstore = new Ext.data.Store({
		 proxy: new Ext.data.HttpProxy({      
        	url : 'orderProductInfo.do?actionType=getDeliverSubstation',
		 	method : "POST"
        }),      
        reader: new Ext.data.JsonReader({      
            root: 'data',      
            id:'substationId'     
        },
        deliverfileds 
        )      
	});
	deliverstore.load();
	//分页数大小
	var pageSize = 10;
	//显示搜索到的商品
	var productfields = ["firstcategoryName","secondcategoryName","productId","productName","unit","originalPrice","discount","productRemark"];
	productstore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			//url : "servlet/SearchAllGoodsInfo",
			url:"orderProductInfo.do?actionType=doSearch",
			method : "POST"
		}),
		reader : new Ext.data.JsonReader({
			fields : productfields,
			root : "data",
			id : "productId",
			totalProperty : "totalCount"
		})
	});
	productstore.load({params:{start:0,limit:pageSize}});
	var productColumn = new Ext.grid.ColumnModel([{
		header : "商品代码",
        dataIndex : "productId",
        width : 30,
        //排序
        sortable : true
	},{
		header : "商品名称",
        dataIndex : "productName",
        width : 30,
        //排序
        sortable : true
	},{
		header : "计量单位",
        dataIndex : "unit",
        width : 40,
        //排序
        sortable : true
	},{
         header : "原价",
         dataIndex : "originalPrice",
         width : 40,
         sortable : true
  	 },{
		header : "商品折扣",
        dataIndex : "discount",
        width : 50,
        //排序
        sortable : true
	},{
		header : "备注",
        dataIndex : "productRemark",
        width : 50,
        //排序
        sortable : true
	}]);

	//商品详细信息
	var productDetailInfo = new Ext.form.FieldSet({
		collapsible : true,
        title : "详细信息",
        border : true,
        labelWidth : 100,
        width : 320,
        buttonAlign :'center',
        autoHeight : true,
        layout : 'form',
        defaults : {autoWidth:true},
        items : [{
			fieldLabel : "商品一级分类",
			xtype : 'textfield',
		    name : "firstcategoryName"
		},{
			fieldLabel : "商品二级分类",
			xtype :'textfield',
		    name : "secondcategoryName"
		},{
			fieldLabel : "商品代码",
			xtype : 'textfield',
		    name : "productId"
		},{
			fieldLabel : "商品名称",
			xtype :'textfield',
		    name : "productName"
		},{
			fieldLabel : "计量单位",
			xtype : 'textfield',
		    name : "unit"
		},{
		     fieldLabel : "原价",
		     xtype :'textfield',
		     name : "originalPrice"
		 },{
			fieldLabel : "商品折扣",
			xtype :'textfield',
		    name : "discount"
		},{
			fieldLabel : "备注",
			xtype :'textfield',
		    name : "productRemark"
		},{
			fieldLabel : "购买数量",
			xtype :'textfield',
		    name : "buyNumber",
		    blankText:"购买数量不能为空",
			regex:/^[0-9]{1,100}$/,
            regexText:"只能是数字"
		}],
		 buttons:[{
            text : '确定',
            minWidth : 60,
            handler:function(){
			if(AddOrderGridForm.getForm().isValid())
                            {
                                AddOrderGridForm.form.submit({
                                    url:"orderProductInfo.do?actionType=purchaseSearch&customerId="+row.data.customerId,
                                    method:"POST",
                                    success:function(){
                         
                                        //    Ext.MessageBox.alert("恭喜","订购商品成功!");
                                           
			                                AddOrderGridForm.getForm().reset();
                                            purchasestore.reload({params:{start:0,limit:pageSize,customerId:row.data.customerId}});
                                    },
                                    failure:function(){
                                        purchasestore.reload();
                                        Ext.MessageBox.alert("提示!","订购商品失败!");
                                    }
                                });
                           }
					}
        },{
            text : '取消',
            minWidth : 60,
            handler : function(){
            	Ext.get("buyNumber").dom.value=1;
            }
        }] 
	});
	
	//客户购买的商品列表
	var purchasefields = ["firstClassName2","secondClassName2","productId2","productName2","unit2","originalPrice2","discount2","productRemark2","productNumber","totalPrice"];
	purchasestore = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({
			url : "orderProductInfo.do?actionType=getOrderItems",
			method : "POST"
		}),
		reader : new Ext.data.JsonReader({
			fields : purchasefields,
			root : "data",
			id : "productId2",
			totalProperty : "totalCount"
		})
	});
	purchasestore.load();

    var sm = new Ext.grid.CheckboxSelectionModel({
		dataIndex:"productId2"
	});
	var purchaseInfoColumn = new Ext.grid.ColumnModel([sm,
	{
		header:"商品一级分类",
        dataIndex:"firstClassName2",
        menuDisabled:true,
        width:15,
        //排序
        sortable:true
	},{
		header:"商品二级分类",
        dataIndex:"secondClassName2",
        menuDisabled:true,
        width:15,
        //排序
        sortable:true
	},{
		header:"商品名称",
        dataIndex:"productName2",
        menuDisabled:true,
        width:15,
        //排序
        sortable:true
	},{
		header:"计量单位",
        dataIndex:"unit2",
        menuDisabled:true,
        width:10,
        //排序
        sortable:true
	},{
		header:"原价",
        dataIndex:"originalPrice2",
        menuDisabled:true,
        width:10,
        //排序
        sortable:true
	},{
		header:"商品折扣",
        dataIndex:"discount2",
        menuDisabled:true,
        width:10,
        //排序
        sortable:true
	},{
		header:"商品备注",
        dataIndex:"productRemark2",
        menuDisabled:true,
        width:10,
        //排序
        sortable:true
	},{
		header:"购买数量",
        dataIndex:"productNumber",
        menuDisabled:true,
        width:10,
        //排序
        sortable:true
	},{
		header:"总价",
        dataIndex:"totalPrice",
        menuDisabled:true,
        width:10,
        //排序
        sortable:true
	}
	]);
	
	//订单类型选择
	var orderType = new Ext.form.FieldSet({
		collapsible : true,
        title : "订单类型",
        border : true,
        labelWidth : 75,
        width : 350,
        buttonAlign :'center',
        autoHeight : true,
        layout : 'form',
        defaults : {autoWidth:true},
        items : [{
            xtype:'fieldset',
            checkboxToggle:true,
            title: '是否异地收费',
            defaultType: 'textfield',
            labelWidth :80,
            autoHeight : true,
        	layout : 'form',
        	defaults : {autoWidth:true},
        	width : 100,
            collapsed: true,
            items :[{
                fieldLabel: '<font color=red>付款人姓名</font>',
                hiddenName:'fukuanName',
                name: 'fukuanName',
                allowBlank:true
            }
            ,{
                fieldLabel: '<font color=red>付款人地址</font>',
                name: 'fukuanAdd',
                allowBlank:true
            },{
                fieldLabel: '<font color=red>付款人电话</font>',
                name: 'fukuanTel',
                allowBlank:true
            }, {
                fieldLabel: '<font color=red>付款人邮编</font>',
                name: 'fukuanPost',
                allowBlank:true
            },{
               name:"receiveSubstation",
			    xtype:"combo",
			    tpl: '<tpl for="."><div ext:qtip="{substationAdd}" class="x-combo-list-item">{substationAdd}</div></tpl>',
	            store: deliverstore,
	            typeAhead: true,
	            fieldLabel:'异地收款分站',
	            hiddenName:'checkoutsubstation',
	            forceSelection: true,
	            triggerAction: 'all',
	            emptyText:'请选择分站',
	            selectOnFocus:true,
	            width:130,
	            editable: false, 
	            allowBlank:true, 
	            displayField:'substationAdd',
	            valueField: 'substationId',
	            mode: 'remote'           
	            }]
        }]});
	
	var dateInfo = new Ext.form.FieldSet({
        border : true,
        width : 350,
        buttonAlign :'center',
        autoHeight : true,
        layout : 'form',
        defaults : {autoWidth:true},
		collapsible : true,
        width:350,
		height:150,
		plain:true,
		layout:"form",
		labelWidth:90,
        items : [{
			fieldLabel : "<font color=red>订单生成日期</font>",
			xtype : 'datefield',
			format : 'Y-m-d',
			allowBlank:false, 
			blankText:"订单生成日期不允许为空",
		    name : "date1"
		},{
			fieldLabel : "<font color=red>要求完成日期</font>",
			xtype : 'datefield',
			format : 'Y-m-d',
			allowBlank:false, 
			blankText:"订单要求完成日期不允许为空",
		    name : "date"
		},{
        	name:"deliverSubstation",
		    xtype:"combo",
		    tpl: '<tpl for="."><div ext:qtip="{substationAdd}" class="x-combo-list-item">{substationAdd}</div></tpl>',
            store: deliverstore,
            typeAhead: true,
            fieldLabel:'货物投递分站',
            hiddenName:'deliverSubstation1',
            forceSelection: true,
            triggerAction: 'all',
            emptyText:'请选择分站',
            selectOnFocus:true,
            width:130,
            editable: false, 
            allowBlank:true, 
            displayField:'substationAdd',
            valueField: 'substationId',
            mode: 'remote'           
		}]
	});
	
	var purchaseInfo = new Ext.FormPanel({
        frame : true,
        bodyStyle : 'padding:5px',
        title　:　"客户购买的商品",
        autoWidth : true,
       	autoHeight : true,
        border　:　false,
        labelWidth　: 35,
        layout : 'column',
        defaults　:　{anchor:"95%"},
        items :　[{
        	columnWidth : 0.55,
        	id : 'purchaseInfoGrid',
        	xtype : 'grid',
            height : 340,
            width : 600,
            cm : purchaseInfoColumn,
            loadMask : true,
            store : purchasestore,
            border : false,
            viewConfig : {
                columnsText : "显示/隐藏列",
                sortAscText : "正序排列",
                sortDescText : "倒序排列",
                forceFit : true
            },tbar:[
                    new Ext.Toolbar.Fill(),
                    	{
                    	text : "删除商品",
                        tooltip : "删除数据",
                        iconCls : "deleteicon",
                        handler : function(){
							var row1 = Ext.getCmp("purchaseInfoGrid").getSelectionModel().getSelections();
							if(row1.length == 0){
								Ext.Msg.alert("提示信息","请您选择一个!");
							}else if(row1.length>1){
						        Ext.Msg.alert("提示信息","对不起只能选择一个!");
						    }else if(row1.length == 1){
						    Ext.Msg.confirm("提示!", "您确定要删除该商品吗?", function(btn) {
								var productId3 =row1[0].data.productId2;	
								var operate = "delete";	
								if (btn == "yes"){			
								purchasestore.reload({
									params:{start:0,limit:pageSize,customerId:row.data.customerId,productId:productId3,operate:operate}
								});}else{}
						      })
						    }
						}
					},"","-",""
                ],
            bbar:new Ext.PagingToolbar({
                store : purchasestore,
                pageSize : pageSize,
                displayInfo : true,
                displayMsg : ' {0}-{1} 条 共 {2} 条',
                emptyMsg : "No results to display",
                prevText : "上一页",
                nextText : "下一页",
               // refreshText : "刷新",
                lastText : "最后页",
                firstText : "第一页",
                beforePageText : "当前页",
                afterPageText : "共{0}页"
            }),
            listeners:{
                "render": function(g) {
		            g.getSelectionModel().selectRow(0);
	            },
	            delay: 10 
            }
        },
            {
			columnWidth: 0.45,
			layout:'form',
		    autoWidth:true,
		    height:340,
		    bodyStyle: Ext.isIE ? 'padding:0 0 5px 15px;' : 'padding:10px 15px;',
		    border: true,
		    style: {
		        "margin-left": "10px", 
		        "margin-right": Ext.isIE6 ? (Ext.isStrict ? "-10px" : "-13px") : "0"  
		    },
		    items: [dateInfo,orderType]
		}]
	});

	var AddOrderGridForm = new Ext.FormPanel({
		id : 'AddOrderGridForm',
		frame : true,
        bodyStyle : 'padding:5px',
       autoWidth : true,
       aotoHeight : true,
        border : false,
        layout : 'column',
        defaults : {anchor:"95%"},
        items : [{
            columnWidth : 0.55,
            layout : 'fit',
            items : {
                xtype : 'grid',
                height : 320,
                cm : productColumn,
                loadMask : true,
                store : productstore,
                border : false,
                viewConfig : {
                    columnsText : "显示/隐藏列",
                    sortAscText : "正序排列",
                    sortDescText : "倒序排列",
                    forceFit : true
                },
                sm :new Ext.grid.RowSelectionModel({
                    singleSelect: true,
                    listeners: {
                        "rowselect":function(sm, row, rec) {
                            Ext.getCmp("AddOrderGridForm").getForm().loadRecord(rec);
                        }
                    }
                }),
                tbar:[
                    new Ext.Toolbar.Fill(),
                    {
                        text : "请选择商品类别",
                        //默认样式为按下
                        //pressed:true,
                        tooltip : "选择商品类别"
                        
                    },"","-","",{
                        text : "一级分类",
                        //默认样式为按下
                        tooltip : "选择商品类别"
                        
                    },"",{
                    	name : 'firstclass',
						labelfield : "商品一级分类",
						xtype : "combo",
						 tpl: '<tpl for="."><div ext:qtip="{categoryname}" class="x-combo-list-item">{categoryname}</div></tpl>',
						typeAhead: true,
						width:120,
						hiddenName:'firstclass3',
						tootip : "查询消费信息",
						iconCls:"editicon",
						forceSelection: true,
						emptyText:'请选择商品类别',
						blankText:'请选择类别',
						readOnly : true,
						mode : "remote",
						selectOnFocus:true,
						displayField : "categoryname",
						valueField : "categoryid",
						triggerAction : "all",
						editable :false,
						store : firstclassstore,
					    listeners :{ // 监听
					    select:function(firstclass, record,index){
					     secondclassstore.proxy=new Ext.data.HttpProxy({
					     url:"orderProductInfo.do?actionType=getParent&firstcategory="+Ext.get("firstclass3").dom.value,
					     method : "POST"});
					     secondclassstore.reload();
					    }
					    }
					},"","-","",{
                        text : "二级分类",
                        tooltip : "选择商品类别"
                        
                    },"",{
                    	name : 'secondclass',
                    	//id : "secondclass1",
						labelfield : "商品二级分类",
						xtype : "combo",
						 tpl: '<tpl for="."><div ext:qtip="{categoryname}" class="x-combo-list-item">{categoryname}</div></tpl>',
						width:120,
						tootip : "查询消费信息",
						iconCls:"editicon",
						readOnly : true,
						hiddenName:'secondclass3',
						mode : "remote",
						emptyText:'请选择商品类别',
						blankText:'请选择类别',
						displayField : "categoryname",
						valueField : "categoryid",
						triggerAction : "all",
						editable :false,
						store : secondclassstore
					},"","-","",{
                    	text : "搜索",
                        tooltip : "搜索数据",
                        iconCls:"serchopenroomrecord",
                        handler : function(){
							var firstclass = Ext.get("firstclass3").dom.value;
							var secondclass = Ext.get("secondclass3").dom.value;
							productstore.reload({
								params:{start:0,limit:pageSize,firstcategory : firstclass,secondcategory : secondclass}
							});
						}
					},"","-",""
                ],
                bbar:new Ext.PagingToolbar({
                    store : productstore,
                    pageSize : pageSize,
                    displayInfo : true,
                    displayMsg : ' {0}-{1} 条 共 {2} 条',
                    emptyMsg : "No results to display",
                    prevText : "上一页",
                    nextText : "下一页",
                    refreshText : "刷新",
                    lastText : "最后页",
                    firstText : "第一页",
                    beforePageText : "当前页",
                     afterPageText : "共{0}页"
                }),
                listeners:{
                    "render": function(g) {
    		            g.getSelectionModel().selectRow(0);
    	            },
    	            delay: 10 
                }
         	}
		},{
			columnWidth: 0.45,
			layout:'form',
		    autoWidth:true,
		    height:320,
		    bodyStyle: Ext.isIE ? 'padding:0 0 5px 15px;' : 'padding:10px 15px;',
		    border: true,
		    style: {
		        "margin-left": "10px", 
		        "margin-right": Ext.isIE6 ? (Ext.isStrict ? "-10px" : "-13px") : "0"  
		    },
		    items: [productDetailInfo]
		}]
	}); 

	FiltProductInfo = function(){
		var firstclass = Ext.get("firstclass3").dom.value;
		var secondclass = Ext.get("secondclass3").dom.value;
		productstore.reload({
			params:{firstcategory : firstclass,secondcategory : secondclass}
		});
	}
	    
     	var AddOrderwin=new Ext.Window({
			title:"添加订单信息",
			width:1100,
			height:800,
			plain:true,
			layout:"anchor",
			iconCls:"addicon",
			//不可以随意改变大小
			resizable:false,
			//是否可以拖动
			//draggable:false,
			defaultType:"textfield",
			labelWidth:100,
			collapsible:true, //允许缩放条
            closeAction : 'close',
            closable:true,
            //弹出模态窗体
			modal: 'true', 
			buttonAlign:"center",
			bodyStyle:"padding:10px 0 0 15px",
			items:[AddOrderGridForm,purchaseInfo],
			listeners:{
			    "show":function()
			    {
			        //当window show事件发生时清空一下表单
			        purchaseInfo.getForm().reset();
			    }
			},
			buttons:[{
					text:"生成订单",
					minWidth:70,
					handler:function(){
								if(purchaseInfo.getForm().isValid()){
	                                //弹出效果
	                                Ext.MessageBox.show({
	                                        msg: '正在提交，请稍等...',
								            progressText: 'Saving...',
								            width:300,
								            wait:true,
								            waitConfig: {interval:200},
								            icon:'download',
								            animEl: 'saving'
	                                    });
                                    setTimeout(function(){}, 1000);
	                                purchaseInfo.form.submit({
	                                    url:"orderProductInfo.do?actionType=addOrder&customerId="+row.data.customerId,
	                                    method:"POST",
	                                    success:function(form,action)
	                                    {
	                                        //成功后
	                                        var flag=action.result.success;
	                                        if(flag)
	                                        {
	                                            Ext.MessageBox.alert("恭喜","添加订单成功!");
	                                            AddOrderwin.hide();
	                                        }
	                                    },
	                                    failure:function(form,action)
	                                    {
	                                     //   var responseArray = Ext.util.JSON.decode(response.responseText);
	                                        Ext.MessageBox.alert("提示!",action.result.msg);
	                                    }
	                                });
	                           }
	                           }},
						{
							text:"取 消",
							minWidth:70,
							handler:function()
							{
							Ext.Ajax.request({
								url : "orderProductInfo.do?actionType=removeOrderItems&customerId="+row.data.customerId,
								method : "POST",
								success : function(response, option) {
									var responseArray = Ext.util.JSON.decode(response.responseText);
									var flag = responseArray.success;
									if (flag) {
										Ext.Msg.alert("恭喜您", "更新成功");
									} else {
										Ext.Msg.alert("对不起", responseArray.msg);
									}
									addorderstore.reload();
								},
								failure : function(response, option) {
									Ext.Msg.alert("不好意思", "更新失败了");
									addorderstore.reload();
								}
							});
							    AddOrderwin.close();
							}
						}]
	});
    AddOrderwin.show();    
}















