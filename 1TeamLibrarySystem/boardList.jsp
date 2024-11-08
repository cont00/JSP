<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "library.admin.LibraryBoardListDBBean" %>
<%@ page import = "library.admin.LibraryBoardListDataBean" %>
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
		<p>회원님들의 추천도서목록(전체 글:<%=count %>)		<input type="button" value="글쓰기" OnClick="window.location='writeForm.jsp'"></p>

		<%if( count == 0 )	{ %>
		
		<table>
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.
			</tr>
		</table>
		
		<%}	else	{ %>
		
		<table align="center" id="boardList">
			<tr height="30">
				<td align="center" width="50">번 호</td>
				<td align="center" width="50">도서제목</td>
				<td align="center" width="50">자성자</td>
				<td align="center" width="50">내 용</td>
				<td align="center" width="50">작성일</td>
				<td align="center" width="50">조회수</td>
				<td align="center" width="50">추 천</td>
			</tr>
			<%
				for( int i = 0; i < articleList.size(); i++ )	{
					LibraryBoardListDataBean article = articleList.get(i);
			%>
			<tr height="30">
				<td width="50"><%=number-- %></td>
				<td width="250"><%=article.getRecommend_booktitle() %></td>
				<td width="100"><%=article.getRecommend_user_name() %></td>
				<td width="250" align="left">
				<%
					int wid = 0;
					if( article.getRecommend_re_level() > 0)	{
						wid = 5 * ( article.getRecommend_re_level() );
				%>
					<img src="lebel.png" width="<%=wid %>" height="16">
					<img src="re.png">
					<%}	else	{%>
					<img src="level.png" width="<%=wid %>" height="16">
					<%} %>
					<a href="content.jsp?recommend_num=<%=article.getRecommend_num() %>&pageNum=<%=currentPage %>"><%=article.getRecommend_title() %></a>
					<%if( article.getRecommend_count() >= 20 || article.getRecommend_readcount() >= 50 )	{ %>
					<img src="hot.png" border="0" height="16"><%} %>
				</td>
				<td width="150"><%=sdf.format( article.getRecommend_date() ) %></td>
				<td width="100"><%=article.getRecommend_readcount() %></td>
				<td width="100">
					<a href="recommend.jsp?recommend_num=<%=article.getRecommend_num() %>" id="recommend_count_up"><img src="RecommendUp.png" border="0" height="16"></a>
					&nbsp;<%=article.getRecommend_count() %>
				</td>
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
			<a href="boardList.jsp?pageNum =<%=startPage - 10 %>">[이전]</a>
		<%	}
			for( int i = startPage; i <= endPage; i++ )	{ %>
				<a href="boardList.jsp?pageNum=<%=i %>">[<%=i %>]</a>
		<%	}
		
			if( endPage < pageCount )	{%>
				<a href="boardList.jsp?pageNum =<%=startPage + 10 %>">[다음]</a>
	<%
			}
		}
	%>
	</body>
</html>