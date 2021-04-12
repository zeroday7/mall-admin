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
	
	Comment comment = new Comment();
	
	comment.noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	comment.managerId = request.getParameter("managerId");
	comment.commentContent = request.getParameter("commentContent");
	
	CommentDao.insertComment(comment);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeOne.jsp?noticeNo=" + comment.noticeNo);
%>