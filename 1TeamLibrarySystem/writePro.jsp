<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "library.admin.LibraryBoardListDBBean" %>
<%@ page import = "library.admin.LibraryBoardListDataBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="article" scope="page" class="library.admin.LibraryBoardListDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
	article.setRecommend_date( new Timestamp( System.currentTimeMillis() ) );
	
	LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
	dbPro.insertArticle(article);
	
	response.sendRedirect("boardList.jsp");
%>