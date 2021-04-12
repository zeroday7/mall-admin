<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.managerLevel < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
		//현재 페이지
		int currentPage = 1 ;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//페이지당 게시글 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		//시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		ArrayList<Manager> list = ManagerDao.selectManagerList(rowPerPage, beginRow);
		System.out.println(list.size()+" <--manager list size");
	%>
	<h1>managerList</h1>
	<table border="1">
		<thead>
			<tr>
				<th>managerNo</th>
				<th>managerId</th>
				<th>managerName</th>
				<th>managerDate</th>
				<th>managerLevel</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Manager m : list) {
			%>
					<tr>
						<td><%=m.managerNo%></td>
						<td><%=m.managerId%></td>
						<td><%=m.managerName%></td>
						<td><%=m.managerDate%></td>
						<td>
							<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
								<input type="hidden" name="managerNo" value="<%=m.managerNo%>">
								<select name="managerLevel">
									<%
										for(int i=0; i<3; i++) {
											if(m.managerLevel == i) {
									%>
												<option value="<%=i%>" selected="selected"><%=i%></option>
									<%	
											} else {
									%>
												<option value="<%=i%>"><%=i%></option>
									<%
											}	
										}
									%>
								</select>
								<button type="submit">수정</button>
							</form>
						</td>
						<td><a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.managerNo%>"><button type="button">삭제</button></a></td>
					<tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>