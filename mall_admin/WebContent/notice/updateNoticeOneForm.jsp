<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
<%
	// 수집 (noticeOne에서 수정 버튼에서 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- updateNoticeOneForm의 noticeNo"); // 디버깅
	
	// dao 연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>	
	
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<h1>updateNoticeOneForm</h1>
	<!-- updateNoticeOneForm 테이블 작성 -->
	<form action="<%=request.getContextPath()%>/notice/updateNoticeOneAction.jsp" method="post">
	<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
		<table border="1">
			<tr>
				<th>noticeNo</th>
				<td><%=notice.noticeNo%></td>
			</tr>
			<tr>
				<th>noticeTitle</th>
				<td>
					<input type="text" name="noticeTitle" required="required" placeholder="<%=notice.noticeTitle%>">
				</td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td>
					<textarea rows="10" cols="80" name="noticeContent" required="required"><%=notice.noticeContent%></textarea>
				</td>
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
		<button type="submit">수정</button>
	</form>
</body>
</html>