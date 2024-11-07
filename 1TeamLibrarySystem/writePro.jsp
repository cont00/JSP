<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team1.library_system.LibraryBoardListDBBean" %>
<%@ page import = "team1.library_system.LibraryBoardListDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="article" scope="page" class="team1.library_system.LibraryBoardListDataBean">	
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
	article.setRecommend_date( new Timestamp( System.currentTimeMillis() ) );
	
	LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
	dbPro.insertArticle(article);
	
	response.sendRedirect("boardList.jsp");
%>