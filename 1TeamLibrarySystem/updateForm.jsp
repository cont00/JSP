<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team1.library_system.LibraryBoardListDBBean" %>
<%@ page import = "team1.library_system.LibraryBoardListDataBean" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>추천도서 게시판</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="script.js"></script>
	</head>
	<body>
		<%
			int recommend_num = Integer.parseInt(request.getParameter("recommend_num"));
			String pageNum = request.getParameter("pageNum");
			try	{
				LibraryBoardListDBBean dbPro = LibraryBoardListDBBean.getInstance();
				LibraryBoardListDataBean article = dbPro.updateGetArricle(recommend_num);
		%>
		<p>글수정</p>
		<br>
		<form method="post" name="writeform" action="updatePro.jsp?pageNum=<%=pageNum %>" onsubmit="return writeSave()">
			<table>
				<tr>
					<td width="70" align="center">이름</td>
					<td width="330" align="left">
						<input type="text" size="10" maxlength="10" name="writer" value="<%=article.getRecommend_user_name() %>" style="ime-mode:active;">
						<input type="hidden" name="recommend_num" value="<%=article.getRecommend_num() %>">
					</td>
				</tr>
				<tr>
					<td width="70" align="center">제목</td>
					<td width="330" align="left">
						<input type="text" size="40" maxlength="50" name="subject" value="<%=article.getRecommend_title() %>" style="ime-mode:active;">
					</td>
				</tr>
				<tr>
					<td width="70" align="center">내 용</td>
					<td width="330" align="left">
						<textarea name="content" rows="13" cols="40" style="ime-mod:active;"><%=article.getRecommend_content() %></textarea>
					</td>
				</tr>
				<tr>
					<td width="70" align="center">비밀번호</td>
					<td width="330" align="left">
						<input type="password" size="8" maxlength="12" name="recommend_passwd" style="ime-mode:inactive;">
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center">
						<input type="submit" value="글수정">
						<input type="reset" value="다시작성">
						<input type="button" value="목록보기" onclick="document.location.href='boardList.jsp?pageNum=<%=pageNum %>'">
					</td>
				</tr>
			</table>
		</form>
		<%}	catch( Exception e )	{}%>
	</body>
</html>