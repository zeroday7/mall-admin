<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 매니저인 사람들만 고객리스트에 접근할 수 있게 함
	// 매니저가 아니라면 다시 adminIndex로 보내버림
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
<title>ebookList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
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
	
	<h1>ebookList</h1>
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="button">ebook 추가</button></a>
	<!-- rowPerPage별 페이징 -->
	<%
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
		}
		
		// 페이지 당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = EbookDao.totalCount();
		System.out.println(totalRow+"<-- EbookDao의 totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<Ebook> list = EbookDao.selectEbookListByPage(rowPerPage, beginRow);
	%>
			
			<!-- 한 페이지당 몇 개씩 볼건지 선택가능 -->
			<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
				<select name="rowPerPage">
					<%
						for(int i=10; i<31; i+=5) {
							if(rowPerPage == i) {
					%>
								<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
								<option value=<%=i%> selected="selected"><%=i%></option> 
					<%
							} else {
					%>
								<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
								<option value=<%=i%>><%=i%></option>
					<%	
							}
						}
					%>
				</select>
				<button type="submit">보기</button>
			</form>
	
	<!-- Ebook 목록 테이블 작성 -->
	<table border="1">
		<thead>
			<th>categoryName</th>
			<th>ebookISBN</th>
			<th>ebookTitle</th>
			<th>ebookAuthor</th>
			<th>ebookDate</th>
			<th>ebookPrice</th>
		</thead>
		<tbody>
			<%
				for(Ebook e : list) {
			%>
					<tr>
						<td><%=e.categoryName%></td>
						<td><%=e.ebookISBN%></td>
						<!-- ebookTitle을 누르면 상세정보로 넘어가게 링크 걸음 -->
						<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.ebookISBN%>"><%=e.ebookTitle%></a></td>
						<td><%=e.ebookAuthor%></td>
						<td><%=e.ebookDate.substring(0,11)%></td>
						<td><%=e.ebookPrice%></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage > 1) {
	%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
	<%
		}
	%>
</body>
</html>