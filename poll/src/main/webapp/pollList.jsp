<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util. *" %>
<%
	// question 테이블 리스트 -> 페이징 -> title링크(startdate <= 오늘날짜 <= enddate) -> 투표프로그램
	// questionDao.selectQuestionList(Paging) beginrow rowPerPage 구할 수 있다.
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	
	int rowPerPage = 5;
	int lastPage = 0;
	
	String jsp = "/poll/pollList.jsp";
	
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	
	lastPage = paging.getLastPage(questionDao.getTotalDataCount());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<!--  foreach문 ArrayList<Question> list 출력 title
	링크(startdate <= 오늘날짜 <= enddate) 투표시직전, 투표종료, 투표하기-->
	<h1>설문리스트</h1>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>주제</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>복수투표</th>
				<th>투표</th>
				<th>삭제</th>
			</tr>
			<%
				String today = java.time.LocalDate.now().toString(); // "2025-04-03" 같은 문자열
				
				for(Question q : list) {
					String status = "투표대기";
					if(q.getStartdate().compareTo(today) <= 0 && q.getEnddate().compareTo(today) >= 0) {
						status = "<a href='/poll/insertPollForm.jsp?qnum=" + q.getNum() + "'>투표하기</a>";
					} else if(today.compareTo(q.getEnddate()) > 0) {
						status = "투표종료";
					}
			%>
			<tr>
				<td><%=q.getNum() %></td>
				<td><%=q.getTitle() %></td>
				<td><%=q.getStartdate() %></td>
				<td><%=q.getEnddate() %></td>
				<td>
				<%
					if(q.getType() == 1) {
				%>
						O
				<%
					} else {
				%>
						X
				<%
					}
				%>
				</td>
				<td><%=status %></td>
				<td>
					<a href="/poll/deletePoll.jsp?num=<%=q.getNum() %>"
					onclick='return confirm("정말 삭제할까요?"");'>
					삭제하기
					</a>
				</td>
			</tr>
			<%
				}
			%>
	</table>
	<%=currentPage %> / <%=lastPage %>
	<br>
	<!--  -->
	<a href="<%=jsp %>?currentPage=1">[처음]</a>
	<%
		if(currentPage > 1) {
	%>
		<a href="<%=jsp %>?currentPage=<%=currentPage - 1 %>">[이전]</a>
	<%
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
		<a href="<%=jsp %>?currentPage=<%=currentPage + 1 %>">[다음]</a>
	<%
		}
	%>
		<a href="<%=jsp %>?currentPage=<%=lastPage%>">[마지막]</a>
</body>
</html>







