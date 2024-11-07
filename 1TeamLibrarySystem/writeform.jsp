<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>추천도서 게시판</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="script.js">	</script>
	</head>
	<body>
	<%
		int recommend_num = 0, recommend_ref = 1, recommend_re_step = 0, recommend_re_level = 0;
		String strV = "";
		try	{
			if( request.getParameter("recommend_num") != null )	{
				recommend_num = Integer.parseInt(request.getParameter("recommend_num"));
				recommend_ref = Integer.parseInt(request.getParameter("recommend_ref"));
				recommend_re_step = Integer.parseInt(request.getParameter("recommend_re_step"));
				recommend_re_level = Integer.parseInt(request.getParameter("recommend_re_level"));
			}
	%>
	<p>글쓰기</p>
	<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
		<input type="hidden" name="recommend_num" value="<%=recommend_num %>">
		<input type="hidden" name="recommend_ref" value="<%=recommend_ref %>">
		<input type="hidden" name="recommend_re_step" value="<%=recommend_re_step %>">
		<input type="hidden" name="recommend_re_level" value="<%=recommend_re_level %>">
		
		<table align="center">
			<tr>
				<td width="70" align="center">이름</td>
				<td width="330" align="left">
					<input type="text" size="10" maxlength="10" name="recommend_user_name" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td width="70" align="center">추천도서</td>
				<td width="330" align="left">
					<input type="text" size="40" maxlength="50" name="recommend_booktitle" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td width="70" align="center">제목</td>
				<td width="330" align="left">
				<%
					if( request.getParameter("recommend_num") == null )
						strV = "";
					else
						strV = "[답변]";
				%>
				<input type="text" size="40" maxlength="50" name="recommend_title" value="<%=strV %>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td width="70" align="center">내용</td>
				<td width="330" align="left">
					<textarea name="recommend_content" rows="13" cols="40" style="ime-mode:active;"></textarea></td>
			</tr>
			<tr>
				<td width="70" align="center">비밀번호</td>
				<td width="330" align="left">
					<input type="password" size="8" maxlength="12" name="recommend_passwd" style="ime-mode:inaactive;"></td>
			</tr>
			<tr>
				<td colspan=2 align="center">
					<input type="submit" value="글쓰기">
					<input type="reset" value="다시 작성">
					<input type="button" value="목록" OnClick="window.location='boardList.jsp'">
				</td>
			</tr>
		</table>
		<%
		}	catch( Exception e )	{}
		%>
	</form>
	</body>
</html>