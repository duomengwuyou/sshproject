package com.neusoft.logistics.action;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.IQueryUserService;

public class LoginAction extends DispatchAction{
	private IQueryUserService queryUserService;

	public IQueryUserService getQueryUserService() {
		return queryUserService;
	}
	public void setQueryUserService(IQueryUserService queryUserService) {
		this.queryUserService = queryUserService;
	}
	public ActionForward doLogin(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("=====================登录系统=======================================");
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
		String name=request.getParameter("user");
	    String pass=request.getParameter("password");
	    String roleValue=request.getParameter("role");
	    //获取session
		HttpSession session = request.getSession();
	    int role = -1;
	    //PrintWriter out=response.getWriter();
	    if(name==null && name.equals("") && pass==null && pass.length()==0)
	    	return null;
	    System.out.println(name+","+pass);
	    System.out.println("good");
	    String str;
		if(roleValue!=null&&roleValue.equals("staff")){
			System.out.println("=====================登录系统staff=======================================");
			role = 2;
		}else if(roleValue!=null&&roleValue.equals("manager")){
			System.out.println("=====================登录系统manager=======================================");
			role = 1;
		}else if(roleValue!=null&&roleValue.equals("admin")){
			System.out.println("=====================登录系统admin=======================================");
			role = 0;
		}
		if(role!=-1){
			User user = queryUserService.findUserByNameAndPassword(Integer.parseInt(name), pass);
			if(user!=null){
				session.setAttribute("user", user);
				str="{success:true}";
			    response.getWriter().print(str);
			    System.out.println("login");
			}else{
				str="{success:false}";
			    response.getWriter().print(str);
			    System.out.println("password error");
			}
		}
		
//		HttpSession session = request.getSession();
//		// session.setMaxInactiveInterval(30);
//		PrintWriter out = response.getWriter();
//		//String userName = request.getParameter("userName");
//		//String password = request.getParameter("password");
//		////////////////////////////////
//		System.out.println("登录成功");
//		out.print("{success:true,msg:'登录成功'}");
//		int userId = 1111;
//		int roleId = 2;
//		System.out.println("角色编号：" + roleId);
//		// 把用户的名称、角色名称还有编号放入到session中
//		session.setAttribute("userId", userId);
//		session.setAttribute("userName", "坤龙");
//		session.setAttribute("roleId", roleId);
//		// 用户成功登录之后把他的权限(即可以访问的地址)放入到Session中
////		String[] rightUrl = rightService.findRight(users.get(i)
////				.getSysRole().getRoleId());
//		session.setAttribute("rightUrl", "");
		return null;
	}
}
