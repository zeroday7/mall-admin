<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>

<%
	//세션확인후 레벨에 해당하지않으면 adminIndex.jsp로
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager ==null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if (manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateClientForm</title>
</head>
<body>
	<%
		String clientMail= request.getParameter("clientMail");
	%>
	<!-- 관리자 화면 메뉴(네비게이션) includ-->
	<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp" method="post">
		<table>
			<thead>
				<tr>
					<th>clientMail</th>
					<th>새로운 비밀번호</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=clientMail%></td>
					<td>
						<!-- 관리자가 강제로 수정하는 거니까 그냥 타입은 text로 -->
						<input type = "hidden" name="clientMail" value ="<%=clientMail%>">
						<input type = "text" name="clientPw">
					</td>
				</tr>
			</tbody>
		</table>
		<button type="submit">비밀번호 수정</button>
	</form>

</body>
</html>