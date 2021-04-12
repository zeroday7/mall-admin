<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.managerLevel < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//managerList에서 넘겨준 no값 받아오기
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	
	//디버깅
	System.out.println(managerNo+"<--managerNo");
	
	//dao 삭제 메소드 호출. 리턴값 0->일치하지 않으므로 삭제실패, 1->삭제성공
	int rowCnt = ManagerDao.deleteManager(managerNo);
	System.out.println(rowCnt+"=delete(1:삭제완료, 0:삭제실패)");
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>