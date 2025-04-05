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
	
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	
	int lastPage = paging.getLastPage(questionDao.getTotal());
	
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	
	Calendar today = Calendar.getInstance();
	// yyyy-mm-dd
	int year = today.get(Calendar.YEAR);
	int mon = today.get(Calendar.MONTH)+1;
	int date = today.get(Calendar.DATE);
	String strToday = year+"-";
	if(mon<10) {
		strToday = strToday + "0" + mon + "-";
	} else {
		strToday = strToday + mon + "-";
	}
	if(date<10) {
		strToday = strToday + "0" + date;
	} else {
		strToday = strToday + date;
	}
	
	System.out.println(strToday);

	
	
%>
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!--  nav.jsp 인클루드 -->
	<div>
	<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	<!--  foreach문 ArrayList<Question> list 출력 title
	링크(startdate <= 오늘날짜 <= enddate) 투표시직전, 투표종료, 투표하기-->
	<h1>설문리스트</h1>
		<table class="table table-dark table-hover">
			<tr>
				<th>번호</th>
				<th>주제</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>복수투표</th>
				<th>현재투표현황</th>
				<th>투표</th>
				<th>삭제</th>
				<th>수정</th>
				<th>종료일수정</th>
				<th>결과</th>
			</tr>
			<%
				for(Question q : list) {
					String startdate = q.getStartdate();
					String enddate = q.getEnddate();
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
				
				<td><%=q.getCnt() %></td>
				
				<td>
				<%
					// 오늘날짜 - 시작날짜 : + 양수 && 끝 날짜 - 오늘날짜 : 양수
					if(strToday.compareTo(startdate) < 0) { // 투표시작전
				%>
							투표시작전
				<%
					} else if(strToday.compareTo(enddate) > 0) { //투표 이후
				%>
							투표종료
				<%
					} else {
				%>
						<a href="/poll/updateItemForm.jsp?qnum=<%=q.getNum() %>">투표하기</a>
				<%
					} 
				%>
				</td>
				
				<td>
				<%
					if(q.getCnt() > 0) {
				%>
						삭제불가
				<%
					} else {
				%>
						<a href="/poll/deletePoll.jsp?qnum=<%=q.getNum() %>">삭제하기</a>
				<%
					}
				%>
				</td> 
				
				<td><!-- 누군가 투표를 했으면 전체수정 불가능 -->
				<%
					if(q.getCnt() > 0) {
				%>
						수정불가
				<%
					} else {
				%>
					<a href="/poll/updatePollForm.jsp?num=<%=q.getNum() %>">수정하기</a>
				<%
					}
				%>
				</td>
			
				<td>
				<%
					if(enddate.compareTo(strToday) >= 0) {
				%>
					<a href="/poll/updateQuestionEnddateForm.jsp?num=<%=q.getNum() %>">종료일 수정하기</a>
				<%
					} else {
				%>
						수정불가
				<%
					}
				%>
				</td>

				<td>
				<%
					if(strToday.compareTo(enddate) > 0) {
				%>
					<a href="/poll/questionOneResult.jsp?qnum=<%=q.getNum() %>">결과보기</a>
				<%
					} else {
				%>
							투표진행중
				<%
					}
				%>
				</td>
			</tr>
			<%
				}
			%>
	</table>
	<%=currentPage %> / <%=lastPage %>
	<br>
	<!--  -->
	<a href="<%=currentPage %>?currentPage=1">[처음]</a>
	<%
		if(currentPage > 1) {
	%>
		<a href="/poll/pollList.jsp?currentPage=<%=currentPage - 1 %>">[이전]</a>
	<%
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
		<a href="/poll/pollList.jsp?currentPage=<%=currentPage + 1 %>">[다음]</a>
	<%
		}
	%>
		<a href="/poll/pollList.jsp?currentPage=<%=lastPage%>">[마지막]</a>
</body>
</html>







