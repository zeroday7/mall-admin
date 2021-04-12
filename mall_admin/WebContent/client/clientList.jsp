<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>clientList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- include는 프로젝트명 x,  -->
	</div>
	<h1>clientList</h1>
	<%
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		String searchWord = "";
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}
		
		
		// 시작 행
		int beginRow = (currentPage-1) * rowPerPage;
		// 전체 데이터의 개수
		int totalRow = ClientDao.totalCount(searchWord);
		System.out.println(totalRow); // totalRow를 잘 받아오는지 디버깅
		
		// list 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
		

	%>
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<input type="hidden" name="searchWord" value="<%=searchWord%>">
		<select name="rowPerPage">
			<%
				for(int i=10; i<=30; i+=5) {
					if(rowPerPage == i) {
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
		<button type="submit">보기</button>
	</form>
	
	<table border="1">
		<thead>
			<tr>
				<th>clientEmail</th>
				<th>clientDate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Client c : list){
			%>
					<tr>

						<td><%=c.clientMail %></td>
						<td><%=c.clientDate.substring(0,11) %></td>
						<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.clientMail%>"><button type="button">수정</button></a></td>
						<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.clientMail%>"><button type="button">삭제</button></a></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
			<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">이전</a>
		<%
			}

			int lastPage = totalRow / rowPerPage; // 마지막 페이지
			if(totalRow % rowPerPage != 0){
				lastPage += 1;
			}
			System.out.println("lastPage : " + lastPage); // 라스트 페이지 잘 나오는지 디버깅
			
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>
		<%
			}
		%>
		<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
			<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
			<div>
				clientMail :
				<input type="text" name="searchWord">
				<button type="submit">검색</button>
			</div>
		</form>
</body>
</html>










