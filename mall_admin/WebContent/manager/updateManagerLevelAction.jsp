<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.managerLevel < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수정할 때 보낸 no, level 값 넘겨받기
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	
	//디버깅
	System.out.println(managerNo+"<--managerNo");
	System.out.println(managerLevel+"<--managerLevel");
	
	//dao 수정 메소드 호출. 받아온 값 넣어주기. 리턴값 0->수정실패 또는 1->수정완료
	int rowCnt = ManagerDao.updateManagerLevel(managerNo, managerLevel);
	
	//결과 내보내기
	System.out.println(rowCnt+"=update(1:수정완료, 0:수정실패)");
	System.out.printf("관리자 레벨 : %s", managerLevel);
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>