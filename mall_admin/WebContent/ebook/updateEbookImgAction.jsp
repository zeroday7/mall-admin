<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	// String ebookISBN = request.getParameter("ebookISBN");
	// String ebookImg = request.getParameter("ebookImg");
	// System.out.println(ebookISBN); // why null?
 	// System.out.println(ebookImg); // why null? <form enctype="multipart/form-data"...때문에...
 			
 	// 파일을 다운로드 받을 위치
 	// 새로고침 바로 확인 가능하나 폴더에서는 확인X
 	//String path = application.getRealPath("img"); // img라는 폴더의 OS상의 실제 폴더
	// 새로고침하면 확인가능하고 폴더에서도 확인가능
 	String path = "D:/goodee/web/mall_admin/WebContent/img";
 	System.out.println(path); 
 	int size = 1024 * 1024 * 100; // 100MB
 // MultipartRequest(현재페이지의 request, 파일이 저장될경로, 가능파일크기, request의 인코딩, 동일이름 네임정책) 
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
 	String ebookISBN = multi.getParameter("ebookISBN");
 	String ebookImg = multi.getFilesystemName("ebookImg");
 	System.out.println(ebookISBN);
 	System.out.println(ebookImg);
 	
 	Ebook ebook = new Ebook();
 	ebook.ebookISBN = ebookISBN;
 	ebook.ebookImg = ebookImg;
 	EbookDao.updateEbookImg(ebook);
 	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>











