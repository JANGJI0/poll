<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto. *" %>
<%@ page import="model. *" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	QuestionDao questionDao = new QuestionDao();
	Question question = new Question();
	
	question = questionDao.selectQuestion(num);
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
		<h1>종료날짜 수정</h1>
		<form action="/poll/updateQuestionEnddateAction.jsp" method="post">
			<input type="hidden" name="num" value="<%=num %>">
			<input type="hidden" name="title" value="<%=question.getTitle() %>">
			<input type="hidden" name="startdate" value="<%=question.getStartdate() %>">
			<input type="hidden" name="type" value="<%=question.getTitle() %>">
			<table border="1">
				<tr>
					<td>종료일</td>
					<td>
						<input type="date" name="enddate" value="<%=question.getEnddate() %>">
					</td>
				</tr>
			</table>
			<button type="submit">수정하기</button>
			<a href="/poll/pollList.jsp">리스트</a>
		</form>
</body>
</html>