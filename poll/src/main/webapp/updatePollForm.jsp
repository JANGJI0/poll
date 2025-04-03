<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model. *" %>
<%@ page import="dto. *" %>
<%
	// updatePollForm 안에 item , question 같이 넣기 위해 값을 받아야한다.
	int questionNum = Integer.parseInt(request.getParameter("num"));

	QuestionDao questionDao = new QuestionDao();
	Question q = questionDao.selectQuestionList(question); // 질문 가져오기
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>설문 전체수정</h1>
	<form method="post" action="/poll/updatePollAction.jsp">
		<table border="1">
		<tr>
			<td>질문</td>
			<td colspan="2">
				<input type="text" name="title">
			</td>
		</tr>

		<tr>
			<td rowspan="8">항목</td>
			<td>1) <input type="text" name="content"></td>
			<td>2) <input type="text" name="content"></td>
		</tr>

		<tr>
			<td>3) <input type="text" name="content"></td>
			<td>4) <input type="text" name="content"></td>
		</tr>

		<tr>
			<td>5) <input type="text" name="content"></td>
			<td>6) <input type="text" name="content"></td>
		</tr>

		<tr>
			<td>7) <input type="text" name="content"></td>
			<td>8) <input type="text" name="content"></td>
		</tr>

		<tr>
			<td>시작일</td>
			<td><input type="date" name="startdate"></td>
		</tr>

		<tr>
			<td>종료일</td>
			<td><input type="date" name="enddate"></td>
		</tr>

		<tr>
			<td>복수투표</td>
			<td>
				<input type="radio" name="type" value="1">yes
				<input type="radio" name="type" value="0">no
			</td>
		</tr>
		</table>
		<a href="/poll/pollList.jsp"><button type="button">수정하기</button></a>
		<a href="/poll/pollList.jsp"><button type="button">수정취소</button></a>
	</form>
</body>
</html>












