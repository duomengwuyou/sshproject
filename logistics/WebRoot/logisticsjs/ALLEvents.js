// JScript 文件
ALLEvents=function(node){

	// ==============李亚方==================
    // 客户信息管理-李亚方
    if(node.id == 11){
    	node.text="客户信息管理";
    	CustomerOrder(node);
    }
     // 中心库房购货入库-->李亚方
    if(node.id == 41){
    	node.text = "中心库房购货入库";
    	CentralInStorage(node);
    }
     // 中心库房调拨出库-->李亚方
    if(node.id == 42){
    	node.text = "中心库房调度出库";
    	CentralOutStorage(node);
    }
     // 中心库房调拨出库-->李亚方
    if(node.id == 621){
    	node.text = "库房设置";
    	WarehouseManage(node);
    }
     // 中心库房调拨出库-->李亚方
    if(node.id == 622){
    	node.text = "库房储备设置";
    	StorageInfoManage(node);
    }
     // 中心库房调拨出库-->李亚方
    if(node.id == 623){
    	node.text = "库存量查询";
    	SearchStorageAmount(node);
    }
     // 中心库房调拨出库-->李亚方
    if(node.id == 624){
    	node.text = "出入单查询";
    	SearchInOutOrder(node);
    }

    //==============张文华==================
    //商品管理-张文华
    if(node.id == 613){
    	node.text="商品管理";
   // 	alert("商品管理");
    	ProductInfoManage(node);
    }
	//==============宋延杰==================
    //调度中心-手动/自动调度、修改状态-宋延杰
    if(node.id == 21){
    	node.text="手/自动调度";
    //	alert("Allocation");
    	Allocation(node);
    }
    // 调度中心-任务单查询-宋延杰
    if(node.id == 24){
    	node.text="任务单查询";
    	TaskOrderQuery(node);
    }
    // ==============周诗龙==================
    // 库房管理-分站库房调拨入库-周诗龙-20110715
    if(node.id == 51){
    	node.text="分站库房调拨入库";
    	// SearchValidateOrderWin.show();
    	SubstationInto(node);
    }
    // 库房管理-分站库房领货-周诗龙-20110715
    if(node.id == 52){
    	node.text="分站库房领货";
    	// SearchTaskOrderWin.show();
    	TakeProduct(node);
    }
    // 库房管理-退货管理-退货登记-周诗龙-20110715
    if(node.id == 531){
    	node.text="退货登记";
    	// SearchReturnTaskOrderWin.show();
    	SubstationReturn(node);
    }
    // 库房管理-分站库房退货出库-周诗龙-20110715
    if(node.id == 532){
    	node.text="分站库房退货出库";
    	SubstationReturnOut(node);
    }
    // 库房管理-中心库房退货入库-周诗龙-20110715
    if(node.id == 431){
    	node.text="中心库房退货入库";
    	CenterwarehouseInto(node);
    }
    // 库房管理-中心库房退货出库-周诗龙-20110715
    if(node.id == 432){
    	node.text="中心库房退货出库";
    	CenterwarehouseOut(node);
    }
    // ==============罗荣博==================
    // 订单信息查询-罗荣博
    if(node.id == 125){
    	node.text = "订单信息查询";
    	OrderInfo(node);
    }

    // ==============龚玉斌==================
      // 龚玉斌 进货管理
	if(node.id == 64){
        node.text="进货管理";
//        alert("开始去进货页面");
        PurchaseProduct(node);
        
	}
	
	// 龚玉斌 退货管理GYB
	if(node.id == 65){
        node.text="退货管理";
        ReturnProduct(node);
	}
	
	// 龚玉斌 订购排行榜分析GYB
	if(node.id == 661){
        node.text="订购排行榜分析";
        ProductHotMost(node);
	}
	
	// 龚玉斌 分站配送情况分析GYB
	if(node.id == 662){
        node.text="分站配送情况分析";
        SubStationExecutive(node);
	}
	// 龚玉斌 客户满意度分析GYB
	if(node.id == 663){
        node.text="客户满意度分析";
        CustomerSatisfaction(node);
	}

    //==============陈秀能==================   
	//陈秀能 商品一级分类
	if(node.id == 611){
        node.text="商品一级分类";  
        FirstCaterygoryManage(node);
        
	}
	//陈秀能 商品二级分类
	if(node.id == 612){
        node.text="商品二级分类";
        SecondCategoryManage(node);
	}
	//陈秀能 商品管理
//	if(node.id == 613){
//        node.text="商品管理";
//        ProductManage(node);
//	}

	if(node.id ==63){
		node.text = "供应商管理";
		SupplierManage(node);
	}

    
    //==============李莎==================
    //分站管理-->任务分配和任务查询 李莎
	if(node.id == 31){
    	node.text = "任务单查询";
    	SubTaskSearch(node);
    }
    if(node.id == 32){
    	node.text = "任务分配";
    	AllocateTask(node);
    }
     // 分站管理-->回执录入和补打商品签收单 李莎

     if(node.id == 33 || node.id == 34){
    	node.text = "补打商品签收单和回执录入";
    	FeedBackRecord(node);
    }
    // 分站管理-->缴款查询 李莎
    if(node.id == 35){
    	node.text = "缴款查询";
    	PaymentSearch(node);
    }
     // 分站管理-->发票管理 李莎
     if(node.id == 32){
    	node.text = "发票管理";
    	InvoiceManage(node);
     }
    //分站管理-->发票管理 李莎
    if(node.id == 32){
   	node.text = "发票管理";
   	InvoiceManage(node);
    }


}
// 关闭TabPanel标签
Ext.ux.TabCloseMenu = function(){
      var tabs, menu, ctxItem;
      this.init = function(tp) {
         tabs = tp;
         tabs.on('contextmenu', onContextMenu);
      }
      // Tab右击菜单列表事件
      function onContextMenu(ts, item, me) {
         if (!menu) { // create context menu on first right click
            menu = new Ext.menu.Menu([{
               id: tabs.id + '-close',
               text: '关闭当前标签',
               iconCls:"closetabone",
               handler : function() {
                  tabs.remove(ctxItem);
               }
            },{
               id: tabs.id + '-close-others',
               text: '除此之外全部关闭',
               iconCls:"closetaball",
               handler : function() {
                  tabs.items.each(function(item){
                     if(item.closable && item != ctxItem){
                        tabs.remove(item);
                     }
                  });
               }
            }]);
         }
         ctxItem = item;
         var items = menu.items;
         items.get(tabs.id + '-close').setDisabled(!item.closable);
         var disableOthers = true;
         tabs.items.each(function() {
            if (this != item && this.closable) {
               disableOthers = false;
               return false;
            }
         });
         items.get(tabs.id + '-close-others').setDisabled(disableOthers);
         menu.showAt(me.getXY());
      }
};
   
// 内容为Grid
GridMain=function(node,grid,icon){
    var tab = center.getItem(node.id);
	    if(!tab){
		   var tab = center.add({
			    id:node.id,
			    iconCls:icon,
			    xtype:"panel",
			    title:node.text,
			    closable:true,
			    layout:"fit",
			    items:[grid]
		    });
	    }
	center.setActiveTab(tab);
}
