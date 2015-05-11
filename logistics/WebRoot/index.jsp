<%@ page language="java" import="java.util.*,com.neusoft.logistics.bean.User" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	    <title>NEU-物流配送系统</title>
		<script type="text/javascript" language = "javascript">
		var rootsid="";
		var loginid="";
		function load(){
			rootsid="101";
		}
		</script>
		<link href="css/Loading.css" rel="stylesheet" type="text/css" />
		<link href="css/css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet"  type="text/css" href="ext/resources/css/ext-all.css" />
		<link rel="stylesheet" type="text/css" href="ext/resources/css/xtheme-galdaka.css" />
		<style type="text/css">
		    .cbox{border:0px solid #D6D6D6;float:right;width:140px;height:80px}
		    .cbox img{margin-bottom:3px;vertical-align:middle}
		</style>


		<script src="ext/adapter/ext/ext-base.js" type="text/javascript"></script>
		<script src="ext/ext-all.js"type="text/javascript"></script>
		<script type="text/javascript" src="logisticsjs/skin.js"></script>
		<!-- 物流管理系统所有事件驱动 -->
		<script type="text/javascript" src="logisticsjs/ALLEvents.js"></script>
		
		<!-- 大家把自己写的js文件添加到这里 介于ALLEvents.js 与 Main.js文件之间-->

		<!--==================李亚方====================-->
		<script type="text/javascript" src="logisticsjs/storemanage/showDetail.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/WriteStoreInfo.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/CentralOutStorage.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/CentralInStorage.js"></script>
		
		

		<script type="text/javascript" src="logisticsjs/allocation/ManuAllocation.js"></script>
		
		
		<!--==================周诗龙====================-->
		
		<!-- 分站库房调拨入库-周诗龙-->
		<script type="text/javascript" src="logisticsjs/storemanage/SureSubstationInto.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/SearchValidateOrder.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/SubstationInto.js"></script>
	
		<!-- 分站库房领货-周诗龙-->
		<script type="text/javascript" src="logisticsjs/storemanage/SureTakeProduct.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/SearchTaskOrder.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/TakeProduct.js"></script>
		<!-- 退货管理-退货登记-周诗龙-->
		<script type="text/javascript" src="logisticsjs/storemanage/returnproductmanage/SearchReturnTaskOrder.js"></script>
		<script type="text/javascript" src="logisticsjs/storemanage/returnproductmanage/SubstationReturn.js"></script>
		<!-- 退货管理-分站库房退货出库-周诗龙-->
		<script type="text/javascript" src="logisticsjs/storemanage/returnproductmanage/SubstationReturnOut.js"></script>
		<!-- 退货管理-中心库房退货入库-周诗龙-->
		<script type="text/javascript" src="logisticsjs/storemanage/returnproductmanage/CenterwarehouseInto.js"></script>
		<!-- 退货管理-中心库房退货出库-周诗龙-->
		<script type="text/javascript" src="logisticsjs/storemanage/returnproductmanage/CenterwarehouseOut.js"></script>
		
		
		<!--==================陈秀能====================-->
		
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/warehouse/AddWareHouse.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/warehouse/WarehouseManage.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/warehouse/SearchInOutOrder.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/warehouse/SearchStorageAmount.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/warehouse/StorageInfoManage.js"></script>
		
		<!-- 供应商管理 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/supplier/SupplierManage.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/supplier/AddSupplier.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/supplier/DeleSupplier.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/supplier/EditSupplier.js"></script>
		
		
		<!--==================罗荣博====================-->
		<!-- 查询订单 罗荣博 2011-7-15 -->
		<script type="text/javascript" src="logisticsjs/customerservice/OrderInfo.js"></script>
		<!-- 订单详细信息 罗荣博 2011-7-15 -->
		<script type="text/javascript" src="logisticsjs/customerservice/OrderDetailInfo.js"></script>
		
		
		<!--==================张文华====================-->
		<!-- 添加客户信息 张文华-->
		<script type="text/javascript" src="logisticsjs/customerservice/AddOrder.js"></script>
		<script type="text/javascript" src="logisticsjs/customerservice/AddCustomer.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/product/AddProductInfo.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/product/DeleProductInfo.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/product/ProductManage.js"></script>
		<!-- 客户信息及添加订单 李亚方 张文华-->
		<script type="text/javascript" src="logisticsjs/customerservice/CustomerOrder.js"></script>
		
		
		<!--==================李莎====================-->

		<!-- 配送中心管理 龚玉斌 -->
		<!-- 配送中心管理 进货管理 龚玉斌 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/purchaseProduct/purchaseProduct.js"></script>
		<!-- 配送中心管理 分站配送情况统计管理 龚玉斌 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/statisticInfo/subStationExecutive.js"></script>
		<!-- 配送中心管理 最热商品排行榜 龚玉斌 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/statisticInfo/productHotMost.js"></script>
		<!-- 配送中心管理 退货管理 龚玉斌 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/returnProduct/returnProduct.js"></script>
		<!-- 配送中心管理 客户满意度统计 龚玉斌 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/statisticInfo/customerSatisfaction.js"></script>
	
		<!-- 配送中心管理 陈秀能-->
		
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/category/AddFirstCategory.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/category/firstCategoryManage.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/category/DeleFirstCategory.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/category/EditFirstCategory.js"></script>

<!-- 


        <script type="text/javascript" src="logisticsjs/dispatcherCenterManage/productManage.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/AddProduct.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/DeleProduct.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/EditProduct.js"></script>
		
 -->


        <script type="text/javascript" src="logisticsjs/dispatcherCenterManage/category/secondCategoryManage.js"></script>
	 	<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/category/EditSecondCategory.js"></script>
	
		<!-- 分站管理 任务分配和任务查询  李莎-->
		<script type="text/javascript" src="logisticsjs/substationmanage/showDetailedInfo.js"></script>
		<script type="text/javascript" src="logisticsjs/substationmanage/AllocateTask.js"></script>
		<script type="text/javascript" src="logisticsjs/substationmanage/SubTaskSearch.js"></script>
		<!-- 分站管理 回执录入  李莎-->
		<script type="text/javascript" src="logisticsjs/substationmanage/Sign.js"></script>
		<script type="text/javascript" src="logisticsjs/substationmanage/AddFeedback.js"></script>
		<script type="text/javascript" src="logisticsjs/substationmanage/FeedbackRecord.js"></script>
		
		<!-- 分站管理 发票管理  李莎-->
		<script type="text/javascript" src="logisticsjs/substationmanage/InvoiceManage.js"></script>
		
		<!-- 分站管理 缴款查询  李莎-->
		<script type="text/javascript" src="logisticsjs/substationmanage/PaymentSearch.js"></script>
		
		
		<!-- 调度中心 手动调度 自动调度 订单状态修改 宋延杰 -->
		<script type="text/javascript" src="logisticsjs/allocation/Allocation.js"></script>
		<!-- 任务单查询  宋延杰 -->
		<script type="text/javascript" src="logisticsjs/allocation/TaskOrderQuery.js"></script>


		<!-- 配送中心管理 龚玉斌 -->
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/purchaseProduct.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/subStationExecutive.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/productHotMost.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/returnProduct.js"></script>
		<script type="text/javascript" src="logisticsjs/dispatcherCenterManage/customerSatisfaction.js"></script>
		<script type="text/javascript" src="logisticsjs/Main.js"></script>
	</head>
    <body onload = "load()">
        <div id="loading">
             <div  class="loading-indicator">
                 <img src="images/extanim32.gif" alt="" width="32" height="32" style="margin-right:8px;" align="absmiddle"/>
                     Loading......
             </div>
        </div>
        <div id="loading-mask">
        </div>
        <div id="top"  class="fiterall">
			<div id="bg" style=" vertical-align:middle;width:160px;height:49px;">
			<img src="images/logistic.bmp" style="left: 35px;height: 80px; width: 436px;">  
	        </div>       
	        <div class="cbox" style="left: 0px; position: relative; top: -45px; height: 65px">
	        <!-- <embed src="flash/fivestar.swf" style="height:20px; width: 134px;float:left" autostart="1" loop="-1" type="application/x-shockwave-flash" wmode="transparent" quality="high" ></embed> -->
	         <br><br><br>
	         <script type="text/javascript">
	                for(var i=0;i<5;i++){
	                    if(parseInt(skinID)==i){
	                        document.writeln("<img id=\"imgkin"+i+"\" src=\"images\/skin/\c"+i+"_1.gif\" width=\"12\" height=\"12\" alt=\"\" onclick=\"setSkin("+i+")\" \/>");
	                    }
	                    else{
	                        document.writeln("<img id=\"imgkin"+i+"\" src=\"images\/skin/\c"+i+"_0.gif\" width=\"12\" height=\"12\" alt=\"\" onclick=\"setSkin("+i+")\" \/>");
	                    }
	                }
	          </script>
	             <a href="login.jsp">退出后台</a>
	         </div>
		 </div>
      
        <div id="botton"  class="bottonall">
            <br/><b>2011&nbsp;&nbsp; 物流配送系统 <font color="red">NEU</font> 小组倾情制作 (作者:周诗龙 陈秀能  李莎 李亚方 龚玉斌 罗荣博 张文华 宋延杰 QQ:888888)</b> 
        </div>
        <!-- 房间实景图片欣赏 -->
        <div id="roomtypeSee" style=" height:450px;">
            <div id="demo" style="overflow:hidden; width:200px; height:490px; text-align:center">
	            <div id="demo1">
		            <center>
			            <font color="red">
				            <b>
				                <img src="images/right/1.jpg" alt="山东配送站配送车图"  height="180" /><br/>山东配送站配送车图<br/>
				                <img src="images/right/2.jpg" alt="山西配送站配送车图" height="180" /><br/>山西配送站配送车图<br/>
				                <img src="images/right/3.jpg"  alt="辽宁配送站配送车图" height="180" /><br/>辽宁配送站配送车图<br/>
				                <img src="images/right/4.jpg" alt="四川配送站配送车图"  height="180" /><br/>四川配送站配送车图<br/>
				                <img src="images/right/5.jpg" alt="重庆配送站配送车图"  height="180" /><br/>重庆配送站配送车图<br/>
				                <img src="images/right/6.jpg" alt="广州配送飞机图"  height="180" /><br/>广州配送飞机图<br/>
				                <img src="images/right/7.jpg" alt="全国配送分布图"  height="180" /><br/>全国配送分布图<br/>
				            </b>
			            </font>
		            </center>
	            </div>
            <div id="demo2"></div>
            </div>
            <script type="text/javascript">
                 var speed=1;
                 var demo2=document.getElementById("demo2");
                 var demo1=document.getElementById("demo1");
                 var demo=document.getElementById("demo");
                 demo2.innerHTML=demo1.innerHTML;
                 function Marquee(){
	                  if(demo2.offsetTop-demo.scrollTop<=0)
	                  		demo.scrollTop-=demo1.offsetHeight;
	                  else{
	                  		//alert("测试1");
	                  		demo.scrollTop++;
	                  }
                 }
                 var MyMar=setInterval(Marquee,speed);
                 demo.onmouseover=function() {clearInterval(MyMar)}
                 demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
     		</script> 
         </div>
         <div id="centerindex">
         </div>
    </body>
</html>