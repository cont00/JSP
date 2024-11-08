<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "library.admin.LibraryBoardListDBBean" %>
<%@ page import = "library.admin.LibraryBoardListDataBean" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	int recommend_num = Integer.parseInt( request.getParameter("recommend_num") );	

	LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
	dbPro.getRecommend(recommend_num);
		
	response.sendRedirect("boardList.jsp");
%>

