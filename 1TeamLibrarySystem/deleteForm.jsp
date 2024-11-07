<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int recommend_num = Integer.parseInt( request.getParameter("recommend_num") );
	String pageNum = request.getParameter("pageNum");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>추천도서 게시판</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			<!--
				function deleteSave()	{
				if(!document.delForm.recommend_passwd.value)	{
					alert("비밀번호를 입력하십시오.");
				document.delForm.recommend_passwd.focus();
				return false;
				}
				}
			--!>
		</script>
	</head>
	<body>
		<p>글삭제</p>
		<br>
		<form method="post" name="delForm" action="deletePro.jsp?pageNum=<%=pageNum %>" onsubmit="return deleteSave()">
			<table>
				<tr height="30">
					<td align="center"><b>비밀번호를 입력해 주세요.</b></td>
				</tr>
				<tr height="30">
					<td align="center">비밀번호: 
						<input type="password" name="recommend_passwd" size="8" maxlength="12">
						<input type="hidden" name="recommend_num" value="<%=recommend_num %>">
					</td>
				</tr>
				<tr height="30">
					<td align="center">
						<input type="submit" value="글삭제">
						<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>