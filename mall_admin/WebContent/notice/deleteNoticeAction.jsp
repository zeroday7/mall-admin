<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 삭제 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	// noticeOne에서 값 받아옴
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// 디버깅
	System.out.println(noticeNo+"<-- deleteNoticeOneAction의 noticeNo");
	
	// 댓글이 있는 공지글인지 질문?
	int rowCnt = CommentDao.selectCommentCnt(noticeNo);
	if(rowCnt != 0) {
		System.out.printf(noticeNo+"공지글의 댓글이 "+rowCnt+"개 있습니다");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
		return; // 코드 실행 멈춤
	}
	// Dao 호출
	NoticeDao.deleteNoticeOne(noticeNo);
	
	// 공지 삭제 후 공지 목록으로 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
%>