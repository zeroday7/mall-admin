<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersList</title>
</head>
<body>
<!-- 페이징되는 리스트 -->
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}	

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
	
	//dao에서 리스트 호출
	ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(rowPerPage, beginRow);
	
	//ordersState list
	String[] ordersStateList = {"주문완료", "주문취소"};
%>

<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<h1>ordersList</h1>
	<!-- 페이지 당 보는 게시글 수 변화 -->
	<form action = "<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
		<select name="rowPerPage">
		<%
			for(int i=10; i<31; i+=5){
				if(rowPerPage == i){
		%>
					<option selected="selected" value="<%=i%>"><%=i%></option>
		<%
				} else {
		%>
					<option value="<%=i%>"><%=i%></option>
		<%
				}
			}
		%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<!-- 테이블 -->
	<table border="1">
		<thead>
			<tr>
				<th>ordersNo</th>
				<th>ebookNo</th>
				<th>ebookTitle</th>
				<th>clientNo</th>
				<th>clientMail</th>
				<th>ordersDate</th>
				<th>ordersState</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(OrdersAndEbookAndClient oec: list){
		%>
			<tr>
				<td><%=oec.orders.ordersNo%></td>
				<td><%=oec.orders.ebookNo %></td>
				<td><%=oec.ebook.ebookTitle %></td>
				<td><%=oec.orders.clientNo %></td>
				<td><%=oec.client.clientMail %></td>
				<td><%=oec.orders.ordersDate.substring(0,10) %></td>
				<td>
					<form method="post" action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp">
						<input type="hidden" name="ordersNo" value="<%=oec.orders.ordersNo%>">
						<select name="ordersState">
						<%
							for(int i=0;i<2;i++){
								if(oec.orders.ordersState.equals(ordersStateList[i])){
						%>
									<option selected="selected" value="<%=ordersStateList[i]%>"><%=ordersStateList[i]%></option>	
						<%
							} else{
						%>
									<option value="<%=ordersStateList[i]%>"><%=ordersStateList[i]%></option>	
						<%
								}
							}
						%>			
						</select>
						<button type="submit">변경</button>
					</form>
				</td>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<!-- 이전 -->
<%
	if(currentPage>1){
%>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>"><button>이전</button></a>
<%
	}
	
	//전체 페이지- 마지막 페이지 구하기
	int totalPage = OrdersDao.totalCount();
	int lastPage = totalPage/rowPerPage;
	if(totalPage%rowPerPage != 0){
		lastPage += 1;
	}
	
	//다음버튼
	
	if(lastPage > currentPage){
%>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>"><button>다음</button></a>
<%
	}
%>
</body>
</html>