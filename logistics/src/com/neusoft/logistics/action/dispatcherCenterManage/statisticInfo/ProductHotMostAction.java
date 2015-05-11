package com.neusoft.logistics.action.dispatcherCenterManage.statisticInfo;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.dispatchCenterManage.ITopHotProducts;
/**
 * PurchaseProductAction
 * @author 龚玉斌
 *
 */
public class ProductHotMostAction extends DispatchAction{

	private ITopHotProducts topHotProductsService;
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		//获取页面查询 开始 结束时间
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String str = null;
		if(startTime==null && endTime==null){
			System.out.println("最热商品： 不 按时间————————————————————————————");
			str = topHotProductsService.getTopHotProducts();
		}
		else{		
			System.out.println("最热商品：    按时间————————————————————————————");
			str = topHotProductsService.getTopHotProductsByTime(startTime, endTime);
		}
//		String str="{success:true,totalCount:3,data:[{rank:'1',productId:'1',productName:'打印机'}" +
//		",{rank:'2',productId:'2',productName:'打印机'}" +
//		",{rank:'3',productId:'3',productName:'打印机'}]}";
		response.getWriter().print(str);
		return null;
	}
	public ITopHotProducts getTopHotProductsService() {
		return topHotProductsService;
	}
	public void setTopHotProductsService(ITopHotProducts topHotProductsService) {
		this.topHotProductsService = topHotProductsService;
	}
}
