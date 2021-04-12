<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<ul class="navbar-nav">
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/adminIndex.jsp">운영자 홈</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/manager/managerList.jsp">운영자 관리</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/client/clientList.jsp">고객 관리</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/category/categoryList.jsp">카테고리 관리</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/ebook/ebookList.jsp">Ebook 관리</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/orders/ordersList.jsp">주문 관리</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지 관리</a></li>
	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">로그아웃</a></li>
</ul>