<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team1.library_system.LibraryBoardListDBBean" %>
<%@ page import = "team1.library_system.LibraryBoardListDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	int recommend_num = Integer.parseInt(request.getParameter("recommend_num"));
	String pageNum = request.getParameter("pageNum");
	String recommend_passwd = request.getParameter("recommend_passwd");
	
	LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
	int check = dbPro.deleteArticle(recommend_num, recommend_passwd);
	
	if( check == 1 )	{
%>

<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">
<%
	}	else	{
%>
	<script type="text/javascript">
		<!--
			alert("비밀번호가 맞지 않습니다.")
			history.go(-1);
		!-->
	</script>
<%
	}
%>