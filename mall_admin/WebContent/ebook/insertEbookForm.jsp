<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
/*
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertEbookForm</title>
</head>
<body>
	<div>
		<!-- include 사용 시에 프로젝트명은 필요없음! -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 카테고리 눌렀을 때, 카테고리별로 리스트를 나오게 함 (네비게이션) -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String s : categoryNameList) {
		%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]</a>
		<%
			}
		%>
	</div>
	<h1>insertEbookForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>
					categoryName
				</td>
				<td>
					<select name="categoryName">
						<option value="">선택</option>
						<%
							for(String cn : categoryNameList) {
						%>
								<option value="<%=cn%>"><%=cn%></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr>	
				<td>
					ebookISBN
				</td>
				<td>
					<input type="text" name="ebookISBN">
				</td>
			</tr>
			<tr>	
				<td>
					ebookTitle
				</td>
				<td>
					<input type="text" name="ebookTitle">
				</td>
			</tr>
			
			<tr>	
				<td>
					ebookAuthor
				</td>
				<td>
					<input type="text" name="ebookAuthor">
				</td>
			</tr>
			
			<tr>	
				<td>
					ebookCompany
				</td>
				<td>
					<input type="text" name="ebookCompany">
				</td>
			</tr>
			
			<tr>	
				<td>
					ebookPageCount
				</td>
				<td>
					<input type="text" name="ebookPageCount">
				</td>
			</tr>
			
			<tr>	
				<td>
					ebookPrice
				</td>
				<td>
					<input type="text" name="ebookPrice">
				</td>
			</tr>
			
			<tr>	
				<td>
					ebookSummary
				</td>
				<td>
					<textarea rows="5" cols="80" name="ebookSummary"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">ebook 추가</button>
	</form>
</body>
</html>