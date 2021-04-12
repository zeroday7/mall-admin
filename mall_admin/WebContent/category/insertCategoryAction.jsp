<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	//0.인코딩
	request.setCharacterEncoding("UTF-8");
	
	//1.수집
	String categoryName = request.getParameter("categoryName");
	System.out.printf("categoryName: %s <insertCategoryAction>\n",categoryName);
	
	//2.중복된 카테고리 생성 불가
	String returnCategoryName = CategoryDao.overlapCategory(categoryName);//categoryDao에 중복된지 확인 코드
	if(returnCategoryName != null){//카테고리 사용중
		System.out.println("사용중인 카테고리 입니다.");
		response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp");
		return;
	}
	//3.중복된 카테고리 없으면 생성 - categoryDao에 생성 코드 만듬
	CategoryDao.insertCategory(categoryName);
	
	//4.categoryList.jsp로 돌아감
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>