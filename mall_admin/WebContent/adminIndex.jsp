<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="gdu.mall.vo.*" %>
<%@ page import ="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminIndex</title>
</head>
<body>
	<h1>adminIndex</h1>
	<!-- 
		- 2가지 화면을 분기
		- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용 
		1) 관리자 로그인 폼
		2) 관리자 인증 화면 & 몰 메인페이지
	-->
<%
	if(session.getAttribute("sessionManager") == null) {
%>
		<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="managerId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="managerPw"></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
			<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">매니저 등록</a>
		</form>
		<h1>승인대기 중인 메니저 목록</h1>
		<table border="1">
			<thead>
				<tr>
					<th>managerId</th>
					<th>managerDate</th>
				</tr>
			</thead>
			<tbody>		
<%
				ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
				for(Manager m : list) {
%>
					<tr>
						<td><%=m.managerId%></td>
						<td><%=m.managerDate.substring(0,10)%></td>
					</tr>
<%					
				}
%>
			</tbody>	
		</table>				
<%
	} else {
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
%>
		<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp">
			</jsp:include>
		</div>
		
		<div>
			<%=manager.managerName%>님 반갑습니다.
			레벨 : <%=manager.managerLevel%>
		</div>
		
		<%
			ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
			ArrayList<Manager> managerList = ManagerDao.selectManagerList(5, 0);
			ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0, null);
			ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(5, 0);
			ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(5, 0);
		%>
		<!-- 최근 등록한 공지 5개 -->
		<div>
			<h2>noticeList <a href="<%=request.getContextPath()%>/notice/noticeList.jsp">[more]</a></h2>
			<table border="1">
				<%
					for(Notice n : noticeList) {
				%>
						<tr>
							<td><%=n.noticeTitle%></td>
							<td><%=n.managerId%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		
		<!-- 최근 가입한 관리자 5명 -->
		<div>
			<h2>managerList <a href="">[more]</a></h2>
			<table border="1">
				<%
					for(Manager m : managerList) {
				%>
						<tr>
							<td><%=m.managerId%></td>
							<td><%=m.managerName%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		
		<!-- 최근 가입한 고객 5명 -->
		<div>
			<h2>clientList <a href="">[more]</a></h2>
			<table border="1">
				<%
					for(Client c : clientList) {
				%>
						<tr>
							<td><%=c.clientMail%></td>
							<td><%=c.clientDate%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		
		<!-- 최근 등록한 상품(Ebook) 5개 -->
		<div>
			<h2>ebookList <a href="">[more]</a></h2>
			<table border="1">
				<%
					for(Ebook e : ebookList) {
				%>
						<tr>
							<td><%=e.ebookTitle%></td>
							<td><%=e.ebookPrice%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		
		<!-- 최근 주문한 주문 5개 -->
		<div>
			<h2>ordersList <a href="">[more]</a></h2>
			<table border="1">
				<%
					for(OrdersAndEbookAndClient oec : oecList) {
				%>
						<tr>
							<td><%=oec.orders.ordersNo%></td>
							<td><%=oec.ebook.ebookTitle%></td>
							<td><%=oec.client.clientMail%><td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
<%		
	}
%>	
</body>
</html>