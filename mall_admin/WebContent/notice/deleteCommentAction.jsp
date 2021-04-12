<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	
	request.setCharacterEncoding("utf-8");
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	if(manager.managerLevel > 1) {
		System.out.println("commentNo : " +commentNo+" managerId : "+manager.managerId);
		CommentDao.deleteComment(commentNo);
	} else if(manager.managerLevel > 0){
		System.out.println("commentNo : " +commentNo+" managerId : "+manager.managerId);
		CommentDao.deleteComment(commentNo,manager.managerId);
	}
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeOne.jsp?noticeNo=" + noticeNo);
%>