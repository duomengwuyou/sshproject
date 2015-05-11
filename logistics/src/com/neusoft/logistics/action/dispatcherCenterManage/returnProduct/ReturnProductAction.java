package com.neusoft.logistics.action.dispatcherCenterManage.returnProduct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
/**
 * PurchaseProductAction
 * @author 龚玉斌
 *
 */
public class ReturnProductAction extends DispatchAction{
		
		public ActionForward doSearch(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			response.setContentType("text/json;charset=utf-8");
		    response.setCharacterEncoding("UTF-8");
		    request.setCharacterEncoding("UTF-8");
		    String str="{success:true,totalCount:3,data:[{supplierName:'东大水站',productId:'1',productName:'补水霜',puchaseQuantity:'11',remainQuantity:'11',returnQuantity:'1'}" +
		    		",{supplierName:'东大水站',productId:'2',productName:'补水霜',puchaseQuantity:'11',remainQuantity:'11',returnQuantity:'1'}" +
		    		",{supplierName:'东大水站',productId:'3',productName:'补水霜',puchaseQuantity:'11',remainQuantity:'11',returnQuantity:'1'}]}";
		    response.getWriter().print(str);
			return null;
		}
	}
