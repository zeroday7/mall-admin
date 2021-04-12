<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//1.인코딩
	request.setCharacterEncoding("UTF-8");
	
	//2.수집
	String categoryName = request.getParameter("categoryName");
	System.out.printf("categoryName : %s <deleteCategoryAction.jsp>\n",categoryName);
	
	//3.dao에서 삭제메서드 호출
	CategoryDao.deleteCategory(categoryName);
	
	//4.categoryList 재실행
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>