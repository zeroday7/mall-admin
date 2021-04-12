<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!-- 보안코드 넣기 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookOne</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div><!-- 인클루드는 프로젝트 명이 필요없다 -->
	<!-- 카테고리별 목록을 볼 수 있는 메뉴(네비게이션) -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String s : categoryNameList){
		%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s %>]</a>
		<%
			}
		
			//수집
			String ebookISBN = request.getParameter("ebookISBN");
			System.out.printf("ebookISBN: %s<ebookOne.jsp>\n",ebookISBN);
			
			//dao연결
			Ebook ebook = EbookDao.selectEbookOne(ebookISBN);

		%>
	</div>

	<h1>ebookOne</h1>
	<table border="1">
		<tr>
			<th>ebookNO</th>
			<td><%=ebook.ebookNo %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>categoryName</th>
			<td><%=ebook.categoryName%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookTitle</th>
			<td><%=ebook.ebookTitle %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookState</th>
			<td><%=ebook.ebookState %></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp">
					<button type="button">책상태 수정</button>
				</a>
			</td>
		</tr>
		<tr>
			<th>ebookAuthor</th>
			<td><%=ebook.ebookAuthor %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookImg</th>
			<td><img src="<%=request.getContextPath()%>/img/<%=ebook.ebookImg %>"></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.ebookISBN%>">
					<button type="button">이미지 수정</button>
				</a>
			</td>
		</tr>
		<tr>
			<th>ebookISBN</th>
			<td><%=ebook.ebookISBN %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookCompany</th>
			<td><%=ebook.ebookCompany %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookDate</th>
			<td><%=ebook.ebookDate.substring(0,11)%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookSummary</th>
			<td><%=ebook.ebookSummary %></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp">
					<button type="button">책요약 수정</button>
				</a>
			</td>
		</tr>
		<tr>
			<th>ebookPrice</th>
			<td><%=ebook.ebookPrice %></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookPageCount</th>
			<td><%=ebook.ebookPageCount %></td>
			<td>&nbsp;</td>
		</tr>
	</table>
	
	<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp">
		<button type="button">전체 수정(이미지 제외)</button>
	</a>
		
	<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp">
		<button type="button">삭제</button>
	</a>
</body>
</html>