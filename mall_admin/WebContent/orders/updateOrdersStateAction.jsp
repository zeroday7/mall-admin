<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>

<%
	//보안코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//수집
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	//디버깅
	System.out.printf("<upadteOrdersStateAction.jsp> \n ordersNo: %s\n ordersState: %s\n",ordersNo, ordersState);
	//dao call
	OrdersDao.updateOrdersState(ordersNo, ordersState);
	//ordersList재실행
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp");
%>