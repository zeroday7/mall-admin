<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	// 관리자 인증 코드
	/*
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	*/
	request.setCharacterEncoding("UTF-8");
	//수집
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice =Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	//디버깅 확인
	System.out.printf("categoryName: %s\n ebookISBN: %s\n ebookTitle:%s\n ebookAuthor:%s\n ebookCompany:%s\n ebookpageCount:%s\n ebookPrice:%s\n ebookSummary:%s\n",categoryName,ebookISBN,ebookTitle,ebookAuthor,ebookCompany,ebookPageCount,ebookPrice,ebookSummary);
	
	//중복된 isbn 생성 불가 ebookDao에서 호출
	String returnebookISBN = EbookDao.checkEbookISBN(ebookISBN);//isbn 중복된지 확인 코드
	if(returnebookISBN != null){//사용중
		System.out.println("사용중인 ISBN 입니다.");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}
	//전처리
	Ebook ebook = new Ebook();
	ebook.categoryName = categoryName;
	ebook.ebookISBN = ebookISBN;
	ebook.ebookTitle = ebookTitle;
	ebook.ebookAuthor= ebookAuthor;
	ebook.ebookCompany = ebookCompany;
	ebook.ebookPageCount = ebookPageCount;
	ebook.ebookPrice = ebookPrice;
	ebook.ebookSummary = ebookSummary;
	
	EbookDao.insertEbook(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>