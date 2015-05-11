package com.neusoft.logistics.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class FunctionListAction extends DispatchAction{
	
	public ActionForward doList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("测试撒的发生的发生");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");	
		String functionList=new String("[{id:'11',parentid:'111',text:'客户管理ZWH',leaf:true,iconCls:'openroomicon',number:'1',url:''}," +
				//"{id:'121',parentid:'12',text:'新订LRB',leaf:true,iconCls:'homemanage',number:'2',url:''}," +
				//"{id:'122',parentid:'12',text:'退订LRB',leaf:true,iconCls:'homemanage',number:'2',url:''}," +
				//"{id:'123',parentid:'12',text:'换货LRB',leaf:true,iconCls:'homemanage',number:'2',url:''}," +
				//"{id:'124',parentid:'12',text:'退货LRB',leaf:true,iconCls:'homemanage',number:'2',url:''}," +
				"{id:'125',parentid:'12',text:'订单信息查询LRB',leaf:true,iconCls:'homemanage',number:'2',url:''}," +
				//"{id:'13',parentid:'111',text:'操作员工作量查询LRB',leaf:true,iconCls:'homemanage',number:'2',url:''}," +
				"{id:'21',parentid:'222',text:'调度管理SYJ',leaf:true,iconCls:'allmanagemenu',number:'5',url:''}," +
				//"{id:'22',parentid:'222',text:'自动调度SYJ',leaf:true,iconCls:'allmanagemenu',number:'4',url:''},"+
				//"{id:'23',parentid:'222',text:'订单状态修改SYJ',leaf:true,iconCls:'allmanagemenu',number:'7',url:''}," +
				"{id:'24',parentid:'222',text:'任务单查询SYJ',leaf:true,iconCls:'allmanagemenu',number:'8',url:''},"+		
				"{id:'31',parentid:'333',text:'任务单查询LS',leaf:true,iconCls:'goodstypemanage',number:'2',url:''}," +
				"{id:'32',parentid:'333',text:'任务分配LS',leaf:true,iconCls:'goodstypemanage',number:'3',url:''},"+
				"{id:'33',parentid:'333',text:'补订商品签收单LS',leaf:true,iconCls:'goodsinfomanage',number:'4',url:''}," +
				"{id:'34',parentid:'333',text:'回执录入LS',leaf:true,iconCls:'goodstypemanage',number:'6',url:''},"+
				"{id:'35',parentid:'333',text:'缴纳查询LS',leaf:true,iconCls:'goodstypemanage',number:'7',url:''},"+
				//"{id:'32',parentid:'333',text:'发票管理LS',leaf:true,iconCls:'goodstypemanage',number:'8',url:''},"+
				"{id:'41',parentid:'444',text:'中心库房购货入库LYF',leaf:true,iconCls:'roomtypemanage',number:'9',url:''},"+
				"{id:'42',parentid:'444',text:'中心库房调拨出库LYF',leaf:true,iconCls:'roomtypemanage',number:'2',url:''},"+
				"{id:'51',parentid:'555',text:'分站库房调拨入库ZSL',leaf:true,iconCls:'finantial',number:'2',url:''},"+
				"{id:'52',parentid:'555',text:'领货ZSL',leaf:true,iconCls:'finantial',number:'2',url:''},"+
			//	"{id:'531',parentid:'53',text:'退货登记ZSL',leaf:true,iconCls:'finantial',number:'2',url:''},"+
			//	"{id:'532',parentid:'53',text:'分站库房退货出库ZSL',leaf:true,iconCls:'finantial',number:'2',url:''},"+
	
			//	"{id:'431',parentid:'43',text:'中心库房退货入库LYF',leaf:true,iconCls:'roomtypemanage',number:'2',url:''},"+
			//	"{id:'432',parentid:'43',text:'中心库房退货出库LYF',leaf:true,iconCls:'roomtypemanage',number:'2',url:''},"+
				"{id:'611',parentid:'61',text:'商品一级分类CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'612',parentid:'61',text:'商品二级分类CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'613',parentid:'61',text:'商品管理CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'621',parentid:'62',text:'库房设置CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'622',parentid:'62',text:'库房储备设置CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'623',parentid:'62',text:'库存量查询CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'624',parentid:'62',text:'出入单查询CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'63',parentid:'666',text:'供应商管理CXN',leaf:true,iconCls:'enter',number:'2',url:''},"+
				"{id:'64',parentid:'666',text:'进货管理GYB',leaf:true,iconCls:'leave',number:'2',url:''},"+
			    //"{id:'65',parentid:'666',text:'退货管理GYB',leaf:true,iconCls:'leave',number:'2',url:''},"+
				"{id:'661',parentid:'66',text:'订购排行榜分析GYB',leaf:true,iconCls:'leave',number:'2',url:''},"+
				//"{id:'662',parentid:'66',text:'分站配送情况分析GYB',leaf:true,iconCls:'leave',number:'2',url:''},"+
				"{id:'663',parentid:'66',text:'客户满意度分析GYB',leaf:true,iconCls:'leave',number:'2',url:''}]");
				//"{id:'71',parentid:'777',text:'与供应商结算LYF',leaf:true,iconCls:'roomtypemanage',number:'2',url:''},"+
				//"{id:'72',parentid:'777',text:'与分站结算LYF',leaf:true,iconCls:'roomtypemanage',number:'2',url:''},"+
				//"{id:'73',parentid:'777',text:'发票管理LYF',leaf:true,iconCls:'roomtypemanage',number:'2',url:''}]");
		PrintWriter out = response.getWriter();
		out.println(functionList);
		out.flush();
		out.close();
		return null;
	}
}
