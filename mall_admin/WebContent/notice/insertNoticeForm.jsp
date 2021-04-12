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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeInsertForm</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<!-- include 사용 시에 프로젝트명 필요없음 -->
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>
	<h1>noticeInsertForm</h1>
	<!-- 공지 추가 테이블 작성 -->
	<form action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp" method="post">
	<!-- action 파일에 managerId 값도 같이 넘겨줌 / 이미 로그인했기 때문에 managerId 값 넘어온 상태 -->
	<input type="hidden" name="managerId" value="<%=manager.managerId%>">	
		<table border="1">
			<tr>
				<th>noticeTitle</th>
				<td>
					<input type="text" name="noticeTitle" required="required">
				</td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td>
					<textarea rows="10" cols="80" name="noticeContent" required="required"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>