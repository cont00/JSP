<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team1.library_system.LibraryBoardListDBBean" %>
<%@ page import = "team1.library_system.LibraryBoardListDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="article" scope="page" class="team1.library_system.LibraryBoardListDataBean">
	<jsp:setProperty name="article" property="*"	/>
</jsp:useBean>
<%
	String pageNum = request.getParameter("pageNum");
	
	LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
	int check = dbPro.updateArticle(article);
	
	if( check == 1 )	{
%>
	<meta http-equiv="Refresh" content="0;url=boardList.jsp?pageNum=<%=pageNum %>">
<%		
	}	else	{
%>
	<script type="text/javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
	}
%>