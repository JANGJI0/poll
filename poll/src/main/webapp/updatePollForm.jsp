<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model. *" %>
<%@ page import="dto. *" %>
<%@ page import="java.util. *" %>
<%
	// updatePollForm 안에 item , question 같이 넣기 위해 값을 받아야한다.
	//int questionNum = Integer.parseInt(request.getParameter("num"));
	int num = Integer.parseInt(request.getParameter("num"));
	
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	Question question = new Question();
	
	
	question = questionDao.selectQuestion(num); // 질문 가져오기
	ArrayList<Item> list = itemDao.selectItemListByQnum(num);
	
	int i = 1;
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
		<input type="hidden" name="num" value="<%=num %>">
		<table border="1">
		<tr>
			<td>질문</td>
			<td colspan="2">
				<input type="text" name="title" value="<%=question.getTitle() %>">
			</td>
		</tr>

		<tr>
			<td rowspan="8">항목</td>
			<%
				for(Item item : list) {
			%>
					<td><%=i %>) <input type="text" name="content" value="<%=item.getContent() %>"></td>
			<%
					if(i % 2 == 0) {
			%>
						</tr><tr>
			<%
					}
				i++;
				}
				
				while(i <= 8) {
			%>
					<td><%=i %>) <input type="text" name="content"></td>
			<%
				if(i % 2 == 0) {
			%>
					</tr><tr>
			<%
					}
				i++;
				}
			
			%>
			<td>시작일</td>
			<td><input type="date" name="startdate" value="<%=question.getStartdate() %>">
			</td>
		</tr>

		<tr>
			<td>종료일</td>
			<td><input type="date" name="enddate" value="<%=question.getEnddate() %>">
			</td>
		</tr>

		<tr>
			<td>복수투표</td>
			<td>
				<input type="radio" name="type" value="1" <% if(question.getType() == 1) {%>checked <%}%>>yes
				<input type="radio" name="type" value="0" <% if(question.getType() == 0) {%>checked <%}%>>no
			</td>
		</tr>
		</table>
		<a href="/poll/pollList.jsp"><button type="submit">수정하기</button></a>
		<a href="/poll/pollList.jsp"><button type="submit">수정취소</button></a>
	</form>
</body>
</html>












