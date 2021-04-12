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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
</head>
<body>
<%
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); // 디버깅
	
	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
		
	<h1>noticeOne</h1>
	<!-- noticeOne 테이블 생성 -->
	<table border="1">
		<tr>
			<th>noticeNo</th>
			<td><%=notice.noticeNo%></td>
		</tr>
		<tr>
			<th>noticeTitle</th>
			<td><%=notice.noticeTitle%></td>
		</tr>
		<tr>
			<th>noticeContent</th>
			<td><%=notice.noticeContent%></td>
		</tr>
		<tr>
			<th>managerId</th>
			<td><%=notice.managerId%></td>
		</tr>
		<tr>
			<th>noticeDate</th>
			<td><%=notice.noticeDate.substring(0,11)%></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.noticeNo%>"><button type="button">수정</button></a>
	<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.noticeNo%>"><button type="button">삭제</button></a>
	<br>
	
	<!-- 댓글 -->
	<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
		<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
		<div>
			managerId : 
			<input type="text" name="managerId" value="<%=manager.managerId%>" readonly="readonly">
		</div>
		<div>
			<textarea rows="2" cols="80" name="commentContent"></textarea>
		</div>
		<button type="submit">입력</button>
	</form>
	
	<!-- 댓글 리스트 -->
	<table	border="1">
	<%
		ArrayList<Comment> list = CommentDao.selectCommentListByNoticeNo(noticeNo);
		for(Comment c : list){
	%>
				<tr>
					<td><%=c.commentContent%></td>
					<td><%=c.commentDate.substring(0,10)%></td>
					<td><%=c.managerId%></td>
					<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.commentNo%>&noticeNo=<%=noticeNo%>&managerId=<%=manager.managerId%>"><button>삭제</button></a></td>
				</tr>
	<%
		}
	%>
	</table>
</body>
</html>