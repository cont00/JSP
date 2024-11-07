<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team1.library_system.LibraryBoardListDBBean" %>
<%@ page import = "team1.library_system.LibraryBoardListDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	String pageNum = request.getParameter("pageNum");

	if( pageNum == null )
		pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize + 1;
	int count = 0;
	int number = 0;
	List<LibraryBoardListDataBean> articleList = null;
	
	LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
	count = dbPro.getArticleCount();
	
	if( count > 0 )
		articleList = dbPro.getArticles(startRow, pageSize);
	
	number = count - (currentPage - 1) * pageSize;
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="style.css" rel="stylesheet" type="text/css">
		<title>추천도서 게시판</title>
	</head>
	<body>
		<p>추천도서 글목록(전체 글:<%=count %>)</p>
		
		<%if( count == 0 )	{ %>
		
		<table align="center">
			<tr>
				<td align="center">추천도서 게시판에 저장된 글이 없습니다.
			</tr>
		</table>
		
		<%}	else	{ %>
		
		<table align="center">
			<tr height="30">
				<td align="center" width="50">번 호</td>
				<td align="center" width="50">도서제목</td>
				<td align="center" width="50">제 목</td>
				<td align="center" width="50">작성자</td>
				<td align="center" width="50">작성일</td>
				<td align="center" width="50">조 회</td>
			</tr>
			<%
				for( int i = 0; i < articleList.size(); i++ )	{
					LibraryBoardListDataBean article = articleList.get(i);
			%>
			<tr height="30">
				<td width="50"><%=number-- %></td>
				<td width="100"><%=article.getRecommend_title() %></td>
				<td width="250" align="left">
				<%
					int wid = 0;
					if( article.getRecommend_re_level() > 0)	{
						wid = 5 * ( article.getRecommend_re_level() );
				%>
					<img src="images/lebel.png" width="<%=wid %>" height="16">
					<img src="images/re.png">
					<%}	else	{%>
					<img src="images/level.png" width="<%=wid %>" height="16">
					<%} %>
			
					<a href="content.jsp?num=<%=article.getRecommend_num() %> & pageNum = <%=currentPage %>"><%=article.getRecommend_title() %></a>
					<%if( article.getRecommend_readcount() >= 20 )	{ %>
					<img src="images/hot.png" border="0" height="16"><%} %>
				</td>
				<td width="150"><%=sdf.format( article.getRecommend_date() ) %></td>
				<td width="50"><%=article.getRecommend_readcount() %></td>
			</tr>
			<%} %>
		</table>
	<%} %>
	<%
		if( count > 0 )	{
			int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
			int startPage = 1;
			
			if( currentPage % 10 != 0 )
				startPage = (int)(currentPage / 10) * 10 + 1;
			else
				startPage = ((int)(currentPage / 10) - 1) * 10 + 1;
			
			int pageBlock = 10;
			int endPage = startPage + pageBlock - 1;
			if( endPage > pageCount )
				endPage = pageCount;
			
			if(startPage > 10) { %>
				<a href="list.jsp?pageNum =<%=startPage - 10 %>">[이전]</a>
		<%	}
			for( int i = startPage; i <= endPage; i++ )	{ %>
				<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
		<%	}
		
			if( endPage < pageCount )	{%>
				<a href="list.jsp?pageNum =<%=startPage + 10 %>">[다음]</a>
	<%
			}
		}
	%>
		<input type="button" value="글쓰기" OnClick="window.location='writeform.jsp'">
	</body>
</html>