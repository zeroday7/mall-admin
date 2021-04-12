<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String ebookISBN = request.getParameter("ebookISBN");
	%>
	<h1>updateEbookImgForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<input type="file" name="ebookImg">
		<button type="submit">이미지 수정</button>
	</form>
</body>
</html>