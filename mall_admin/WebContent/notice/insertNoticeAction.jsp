<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// noticeInsertForm에서 값 받아옴
	String managerId = request.getParameter("managerId");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 디버깅
	System.out.println(managerId+"<-- InsertNoticeAction의 managerId");
	System.out.println(noticeTitle+"<-- InsertNoticeAction의 noticeTitle");
	System.out.println(noticeContent+"<-- InsertNoticeAction의 noticeContent");
	
	// 데이터 전처리
	Notice notice = new Notice();
	notice.managerId = managerId;
	notice.noticeTitle = noticeTitle;
	notice.noticeContent = noticeContent;
	
	// Dao 호출
	NoticeDao.insertNotice(notice);
	
	// 공지 추가 후 공지 목록으로 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
%>