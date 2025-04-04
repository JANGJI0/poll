<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>

<%
		//controller : request 요청 분석, model 호출
		int qnum = Integer.parseInt(request.getParameter("qnum"));
		
		// 1) questionOne
		QuestionDao questionDao = new QuestionDao();
		Question question = questionDao.selectQuestion(qnum);
		
		// 2) 1)의 itemList  // 조인 하는이점과 안하는 이점을 고려
		ItemDao itemDao = new ItemDao();
		ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
		
		// 3) 총 투표자 수
		int totalCount = itemDao.selectItemCountByQnum(qnum);

		
%>




<!--  View  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div>
		<a herf="/poll/pollList.jsp">리스트</a>
	</div>
	<h1><%=qnum %>번 설문 투표결과</h1>
	<table border="1" width="80%">
		<tr>
			<td colspan="4">
				Q : <%=question.getTitle() %>
			</td>
		</tr>

		<tr>
			<td>번호</td><td>내용</td><td>카운트(차트))</td><td>카운트</td>
		</tr>

		<tr>
			<td colspan="4">
				총 투표수 : <%=totalCount %>
			</td>
		</tr>
		<%
			for(Item i : itemList) {
		%>
			<tr>
				<td><%=i.getInum() %></td>
				<td><%=i.getContent() %></td>
				<td>
					<%
						// 각 count값에 대한 백분율 값
						int precentage = (int)(Math.round((double)i.getCount() / (double)totalCount * 100));
					
						// 차트 식으로 표현
						for(int n=1; n<= precentage; n=n+1) {
					%>
							*
					<%
						}
					%>
				</td>
				<td><%=i.getContent() %></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>


















