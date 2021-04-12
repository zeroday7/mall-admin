<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>

<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!-- weight는 자동으로 1로 들어간다. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div><!-- 인클루드는 프로젝트 명이 필요없다 -->
	<h1>카테고리 등록</h1>
	<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp">
		<table border="1">
			<tr>
				<th>카테고리 이름</th>
				<td><input type="text" name="categoryName"></td>
			</tr>	
		</table>
		<button type="submit">카테고리 생성</button>
	</form>
</body>
</html>