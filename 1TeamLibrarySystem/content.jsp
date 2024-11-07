<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team1.library_system.LibraryBoardListDBBean" %>
<%@ page import = "team1.library_system.LibraryBoardListDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>추천도서 게시판</title>
		<link href="style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%
			int recommend_num = Integer.parseInt( request.getParameter("recommend_num") );
			String pageNum = request.getParameter("pageNum");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			try	{
				LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
				LibraryBoardListDataBean article = dbPro.getArticle(recommend_num);
				int recommend_ref = article.getRecommend_ref();
				int recommend_re_step = article.getRecommend_re_step();
				int recommend_re_level = article.getRecommend_re_level();
		%>
		<p>추천도서 내용 보기</p>
		
		<form>
			<table>
				<tr height="30">
					<td align="center" width="125">글번호</td>
					<td align="center" width="125"><%=article.getRecommend_num() %></td>
					<td align="center" width="125">조회수</td>
					<td align="center" width="125"><%=article.getRecommend_readcount() %></td>
				</tr>
				<tr height="30">
					<td align="center" width="125">작성자</td>
					<td align="center" width="125"><%=article.getRecommend_user_name() %></td>
					<td align="center" width="125">작성일</td>
					<td align="center" width="125"><%=sdf.format( article.getRecommend_date() ) %></td>
				</tr>
				<tr height="30">
					<td align="center" width="125">추천도서</td>
					<td align="center" width="375" colspan="3"><%=article.getRecommend_booktitle() %></td>
				</tr>
				<tr height="30">
					<td align="center" width="125">글제목</td>
					<td align="center" width="375" colspan="3"><%=article.getRecommend_title() %></td>
				</tr>
				<tr>
					<td align="center" width="125">글내용</td>
					<td align="center" width="375" colspan="3"><pre><%=article.getRecommend_content() %></pre></td>
				</tr>
				<tr height="30">
					<td colspan="4" align="right">
						<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?recommend_num=<%=article.getRecommend_num() %>&pageNum=<%=pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?recommend_num=<%=article.getRecommend_num() %>&pageNum=<%=pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="댓글쓰기" onclick="document.location.href='writeForm.jsp?recommend_num=<%=recommend_num %>&recommend_ref=<%=recommend_ref %>&recommend_re_step=<%=recommend_re_step %>&recommend_re_level=<%=recommend_re_level %>'">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="글목록" onclick="document.location.href='boardList.jsp?pageNum=<%=pageNum %>'">
					</td>
				</tr>
			</table>
			<%}	catch( Exception e )	{} %>
		</form>
	</body>
</html>