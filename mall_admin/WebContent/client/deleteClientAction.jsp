<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>

<%
	//deleteClientAction
	//세션확인후 레벨에 해당하지않으면 adminIndex.jsp로
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager ==null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if (manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//값 수집
	String clientMail = request.getParameter("clientMail");
	
	//수집된 데이터 디버깅
	System.out.println(clientMail + "<-- deleteClientAction.jsp에서 clientMail");
	
	//삭제 실행
	ClientDao.deleteClient(clientMail);
	
	// managerList.jsp로 리다이렉션
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");

%>