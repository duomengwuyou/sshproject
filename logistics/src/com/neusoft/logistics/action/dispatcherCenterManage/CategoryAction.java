package com.neusoft.logistics.action.dispatcherCenterManage;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IManageCategoryService;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IQueryCategoryService;

/**
 * 分类管理，查询一级分类，二级分类，添加一级分类，二级分类
 * CategoryAction
 * 
 * @author 陈秀能
 * 
 */
public class CategoryAction extends DispatchAction {
	private IManageCategoryService manageCategoryService;
	private IQueryCategoryService queryCategoryService;

	public IManageCategoryService getManageCategoryService() {
		return manageCategoryService;
	}

	public void setManageCategoryService(
			IManageCategoryService manageCategoryService) {
		this.manageCategoryService = manageCategoryService;
	}

	public IQueryCategoryService getQueryCategoryService() {
		return queryCategoryService;
	}

	public void setQueryCategoryService(
			IQueryCategoryService queryCategoryService) {
		this.queryCategoryService = queryCategoryService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String actionType = request.getParameter("actionType");
		System.out.println(this.getClass() + " exec");
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		if (actionType.equals("add"))
			return add(mapping, form, request, response);
		else if (actionType.equals("first"))
			return first(mapping, form, request, response);
		else if (actionType.equals("second"))
			return second(mapping, form, request, response);
		else if (actionType.equals("edit"))
			return edit(mapping, form, request, response);
		else if(actionType.equals("delete"))
			return delete(mapping, form, request, response);
		return null;
	}

	private ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		//String[] s=request.getParameterValues("categoryId");
		String categoryIds = request.getParameter("categoryId");
		System.out.println(this.getClass()+" categoryIds="+categoryIds);
		String[] root = categoryIds.split(",");
		response.getWriter().print(manageCategoryService.delCategory(root));
		return null;
	}

	private ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		System.out.println(this.getClass() + " edit");
		Category category=new Category();
		category.setCategoryid(Integer.valueOf(request.getParameter("categoryid")));
		category.setCategoryname(request.getParameter("categoryname"));
		Category firstcategory = new Category();
		if (request.getParameter("parentcategory") != null
				&& !request.getParameter("parentcategory").equals("")) { 
			firstcategory.setCategoryid(Integer.valueOf(request.getParameter("parentcategory")));
			//firstcategory.setCategoryname(request.getParameter("parentcategory"));
			category.setLCategory(firstcategory);
		} else { 
			category.setLCategory(null);
		}
		response.getWriter().print(manageCategoryService.modCategory(category));
		return null;
	}


	private ActionForward second(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		System.out.println(this.getClass() + " second");
		Category category=null;
		if(request.getParameter("firstcategory")!=null&&!request.getParameter("firstcategory").equals("")){
			System.out.println(this.getClass()+" firstcategory="+request.getParameter("firstcategory"));
			category=new Category();
			category.setCategoryid(Integer.valueOf(request.getParameter("firstcategory")));
		}
		response.getWriter().print(queryCategoryService.getSecondCategories(category));
		return null;
	}

	private ActionForward first(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println(this.getClass() + " first"); 
		response.getWriter().print(queryCategoryService.getFirstCategories());
		return null;
	}

	private ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println(this.getClass() + " aadd");
		Category category = new Category();
		category.setCategoryname(request.getParameter("categoryName"));
		Category firstcategory = new Category();
		if (request.getParameter("firstcategoryselected") != null
				&& !request.getParameter("firstcategoryselected").equals("")) {
			System.out.println(this.getClass() + " if");
			firstcategory.setCategoryid(Integer.valueOf(request.getParameter("firstcategoryselected")));
			//firstcategory.setCategoryname(request.getParameter("firstCategory"));
			category.setLCategory(firstcategory);
		} else {
			System.out.println(this.getClass() + " else");
			category.setLCategory(null);
		}
		manageCategoryService.addCategory(category);
		String str = "{success:true,totalCount:2}";
		response.getWriter().print(str);
		return null;
	}
}
