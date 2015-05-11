package com.neusoft.logistics.action.dynamictree;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.dynamictree.IDynamicTreeService;
/**
 * 
 * @author 周诗龙
 *
 */
public class DynamicTreeAction extends DispatchAction {
	private IDynamicTreeService dynamicTreeService;
	public IDynamicTreeService getDynamicTreeService() {
		return dynamicTreeService;
	}

	public void setDynamicTreeService(IDynamicTreeService dynamicTreeService) {
		this.dynamicTreeService = dynamicTreeService;
	}
	/**
	 * 
	 * @author 周诗龙
	 * 日期 ： 2011年6月20日
	 * 功能 ： 获取权限树信息
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public ActionForward doTree(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws Exception {
		System.out.println("---------------------进入到doTree中来了！！------------------------");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		HttpSession session = request.getSession();
		User user = ((User)session.getAttribute("user"));
		PrintWriter out = response.getWriter();
		if(user==null){
			System.out.println("测试扛不住");
			out.print("success : false");
			response.sendRedirect("http://localhost:8080/HotelRoomManage/login.jsp");
			//RequestDispatcher rd = request.getRequestDispatcher("http://localhost:8080/HotelRoomManage/login.jsp");
			//rd.forward(request, response);
		} else{
			System.out.println("测试扛的住");
			int roleId = user.getLRole().getRoleid();
			String Json= "";
			if(id == null){
				Json = dynamicTreeService.getDtreeInfos(1,roleId);
			}else if(id.equals("ynode-262")||id.equals("ynode-105")){
				out.print("success : false");
			}else if (id != null){
				int parentID = Integer.parseInt(id);
				Json = dynamicTreeService.getDtreeInfos(parentID,roleId);
			}else{
				out.print("success : false");
			}
			out.println(Json);
		}
		out.flush();
		out.close();
		return null;
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
