<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
</head>
<body>
<%
	//categoryDao로 부터 리스트 받아옴
	ArrayList<Category> list = CategoryDao.categoryList();
%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div><!-- 인클루드는 프로젝트 명이 필요없다 -->
	<!-- 페이징 X, 검색어 X -->
	<h1>카테고리 목록</h1><!-- weight는 자동으로 0으로 들어가고 수정가능 -->
	<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp"><button type="button">케타고리 추가</button></a>
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>categoryWeight(수정)</th><!-- 레벨 수정하듯이 수정가능 -->
				<th>삭제</th>
			</tr>
		</thead>
			<tbody>
			<%
				for(Category c : list){
			%>
				<tr>
					<td><%=c.categoryName %></td>
					<td>
						<form action="<%=request.getContextPath()%>/category/updateCategoryWeightAction.jsp" method="post">
							<input type="hidden" name="categoryName" value="<%=c.categoryName %>">
							<select name="categoryWeight">
							<%
								for(int i=0; i<list.size(); i++){
									if(i == c.categoryWeight){
							%>
										<option value="<%=i%>" selected="selected"><%=i%></option>
							<%	
									} else{
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
					<td><a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=c.categoryName%>"><button>삭제</button></a></td>
				</tr>
			<%
				}
			%>
			</tbody>
	</table>
</body>
</html>