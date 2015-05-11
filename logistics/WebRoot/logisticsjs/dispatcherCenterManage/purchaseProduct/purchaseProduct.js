// JScript 文件
/**
 * 进货管理
 * 
 * @author:龚玉斌
 */

var PurchaseProductStore;
PurchaseProduct = function(node) {

//	alert("进到ProductPurchase中了"+node);
	// 分页每页显示数量
	var pageSize = 12;
	// 指定列参数
	var fields = ["firstCatergory", "secondCategory", "productId",
			"productName", "remainQuantity", "warningQuantity","maxQuantity",
			"shortageQuantity", "puchaseQuantity","unit","purchaseDate"];

	// 数据还没有开始工作
	PurchaseProductStore = new Ext.data.Store({
				proxy : new Ext.data.HttpProxy({
							url : "purchaseProduct.do?actionType=doSearch",
							method : "POST"
						}),
				reader : new Ext.data.JsonReader({
							fields : fields,
							root : "data",
							id : "productId",
							totalProperty : "totalCount"
						})
			});
	 //加载时参数
	PurchaseProductStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});

	// --------------------------------------------------列选择模式
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : "productId"
			});
	// --------------------------------------------------列头
	var cm = new Ext.grid.ColumnModel([sm, {
				header : "商品一级分类",
				tooltip : "商品一级分类",
				dataIndex : "firstCatergory",
				sortable : true
			}, {
				header : "商品二级分类",
				tooltip : "商品二级分类",
				dataIndex : "secondCategory",
				sortable : true
			}, {
				header : "商品代码",
				tooltip : "商品代码",
				dataIndex : "productId",
				sortable : true,
				renderer : function(value) {
					return "<font color=blue>" + value + "</font>";
				}
			}, {
				header : "商品名称",
				tooltip : "商品名称",
				dataIndex : "productName",
				sortable : true,
				renderer : function(value) {
					return "<font color=red>" + value + "</font>";
				}
			}, {
				header : "库存量",
				tooltip : "库存量",
				dataIndex : "remainQuantity",
				sortable : true
			}, {
				header : "预警库存量",
				tooltip : "预警库存量",
				dataIndex : "warningQuantity",
				sortable : true
			}, {
				header : "最大库存量",
				tooltip : "最大库存容量",
				dataIndex : "maxQuantity",
				sortable : true
			},
			
			 {
				header : "缺货数",
				tooltip : "缺货数",
				dataIndex : "shortageQuantity",
				// 可以进行排序
				sortable : true
			}, {
				header : "进货量",
				tooltip : "进货量",
				dataIndex : "puchaseQuantity",
				// 可以进行排序
				sortable : true,
				renderer : function(value) {
					return "<font color=red>" + value + "</font>";
				},
				editor:new Ext.form.NumberField({
            		style:'text-align:left'
        		}),
			},{
				header : "进货时间",
				tooltip : "进货时间",
				dataIndex : "purchaseDate",
				// 可以进行排序
				sortable : true,renderer : function(value) {
					return "<font color=red>" + value + "</font>";
				},
				editor:new Ext.form.TextField({
            	style:'text-align:left'
        		}),
			}, {
				header : "计量单位",
				tooltip : "计量单位",
				dataIndex : "unit",
				// 可以进行排序
				sortable : true
			}]);

	// ----------------------------------------------------定义grid
	var purchaseProductGrid = new Ext.grid.EditorGridPanel({
				id : "purchaseProductGridId",
				store : PurchaseProductStore,
					sm:sm,
					cm:cm,
					loadMask:true,
					stripeRows:true, 
					clicksToEdit:2,
					//autoExpandColumn:7,
					//超过长度带自动滚动条
					autoScroll:true,
					border:false,
					viewConfig : {
					columnsText : "显示/隐藏列",
					sortAscText : "正序排列",
					sortDescText : "倒序排列",
					forceFit : true
				},
				// 分页
				bbar : new Ext.PagingToolbar({
							store : PurchaseProductStore,
							pageSize : pageSize,
							// 显示右下角信息
							displayInfo : true,
							displayMsg : '当前记录 {0} -- {1} 条 共 {2} 条记录',
							emptyMsg : "No results to display",
							prevText : "上一页",
							nextText : "下一页",
							refreshText : "刷新",
							lastText : "最后页",
							firstText : "第一页",
							beforePageText : "当前页",
							afterPageText : "共{0}页"

						}),
				tbar : [new Ext.Toolbar.Fill(), {
							text : "生成进货单",
							tooltip : "生成进货单",
							iconCls : "serchopenroomrecord",
							handler : ToPurchaseProduct
						}],
			listeners:{
			            'contextmenu':function(e)
			            {
			                e.stopEvent();
			            },
			             "afteredit":function(e)
			                 {
			                    var g=e.grid;//得到当前grid
			                    var r=e.record;//得到当前行所有数据
			                    var f=e.field;//得到修改列
			                    var v=e.value;//得到修改列修改后值
			                    var orgin=e.originalValue;//修改列修改前值
			                    var row=e.row;//当前行索引
			                    var col=e.column;//当前点击的列索引
			                    //alert("ID："+r.data.id+"-field:"+f+"-value:"+v+"-修改前值："+orgin+"-坐标:"+row+","+col);
			                    //通过ajax请求修改数据
			                    alert("修改后的进货量为"+v);
			                    if(f == "purchaseDate"){
			                    	r.data.purchaseDate = v;
			                    }else if(v > r.data.maxQuantity || v<r.data.shortageQuantity){
			                   	 	Ext.Msg.alert("提示","您输入的进货量大于最大库存量或者小于缺货数");
			                   	 	PurchaseProductStore.reload();
			                    }else{
			                     	r.data.puchaseQuantity = v;
			                    }
			                 },
		                 "rowcontextmenu":function(grid,rowIndex,e)
		                 {
		                    e.stopEvent();
		                    RoomRightClick.showAt(e.getXY());
		                 }
		}
			});

	// 传入icon样式
	GridMain(node, purchaseProductGrid, "guesticon");
}

//获取选择的行
function ToPurchaseProduct()
{
        var row=Ext.getCmp("purchaseProductGridId").getSelectionModel().getSelections();
       // alert("这里的row"+row);
        if(row.length==0)
        {
            Ext.Msg.alert("提示信息","请您至少选择一个!");
        }
        else
        {  
                Ext.Msg.confirm("提示!","您确定要生成进货单和购货入库单?",function(btn){ 
                if(btn=="yes")
                {
                	ToPurchaseProducts(row);
                }
                else
                {                
                }
            })
       	 }  

}


//请求后台
ToPurchaseProducts=function(row)
{
     var purchaseProductIds="";
     var purchaseQuantitys="";
     var purchaseDates="";
    for(var i=0;i<row.length;i++)
    {
                if(row.length==1)
                {
                    purchaseProductIds=row[i].data.productId;
                    purchaseQuantitys=row[i].data.puchaseQuantity;
                    purchaseDates=row[i].data.purchaseDate;
                }
                else
                {
                    
                    if(i<(row.length-1))
                    {
                        purchaseProductIds=row[i].data.productId+","+purchaseProductIds;
                        purchaseQuantitys=row[i].data.puchaseQuantity+","+purchaseQuantitys;
                        purchaseDates=row[i].data.purchaseDate+","+purchaseDates;
                    }
                    if(i==(row.length-1))
                   {
                        purchaseProductIds=purchaseProductIds+row[i].data.productId;
                        purchaseQuantitys=purchaseQuantitys+row[i].data.puchaseQuantity;
                        purchaseDates=purchaseDates+row[i].data.purchaseDate;
                   } 
                }
     } 
     
      Ext.Ajax.request({
            url : "purchaseProduct.do?actionType=doToPurchaseProduct",
			method : "POST",
            params:{
                   purchaseProductIds:purchaseProductIds,
                   purchaseQuantitys:purchaseQuantitys,
                   purchaseDates:purchaseDates
                   
            },
            success:function(response,option)
            {
                   var responseArray = Ext.util.JSON.decode(response.responseText); 
                   var flag = responseArray.success;
                   if(flag){
                   		Ext.Msg.alert("恭喜您","生成订货单和购货入库单成功");
                   }else{
                   	Ext.Msg.alert("对不起",responseArray.msg);
                   } 
                   PurchaseProductStore.reload();
            },
            failure:function(response,option)
            {
	                var responseArray = Ext.util.JSON.decode(response.responseText); 
	                Ext.Msg.alert("系统错误",responseArray.msg);
	               	PurchaseProductStore.reload();
            }
            });
}

 

// -------------------------------------------------------搜索
function GetLogWanted() {
	var startTime = Ext.get("startTime").dom.value;
	// alert("Ext.get(startTime).dom.value"+Ext.get("startTime").dom.value);
	var endTime = Ext.get("endTime").dom.value;
	PurchaseProductStore.reload({
				params : {
					start : 0,
					limit : 12,
					startTime : startTime,
					endTime : endTime
				}
			});
}