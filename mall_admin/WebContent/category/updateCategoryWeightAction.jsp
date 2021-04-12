<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집코드 구현
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	
	System.out.printf("categoryName:%s\n categoryWeight:%s\n",categoryName,categoryWeight);
	//categoryDao에서 호출
	CategoryDao.updateCategoryWeight(categoryName, categoryWeight);
	
	//categoryList 재실행
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>