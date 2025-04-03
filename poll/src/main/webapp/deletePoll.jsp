<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model. *" %>
<%
	 //1. Question 모델(DAO메서드) 호출
	
	int questionNum = Integer.parseInt(request.getParameter("num"));
	QuestionDao questiondao = new QuestionDao();
	boolean deleted = questiondao.deleteQuestionNoVote(questionNum);
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 삭제 결과</title>
</head>
<body>
	<%
		if(deleted) {
	%>
		<h2 style="color: green;">삭제되었습니다.</h2>
	<%
		} else {
	%>
		<h2 style="color: red;">삭제 할 수 없습니다. 이미 투표가 존재합니다.</h2>
	<%
		}
	%>
		<a href="/poll/pollList.jsp">목록으로 돌아가기</a>
</body>
</html>