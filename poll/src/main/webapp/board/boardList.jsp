<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.* " %>
<%@ page import = "model.* " %>
<%@ page import = "java.util.* " %>
<%
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5;
	
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	BoardDao boardDao = new BoardDao();
	
	
	int lastPage = paging.getLastPage(boardDao.getTotal());
	
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
	ArrayList<Board> list = boardDao.selectBoardList(p);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>BoardList</h1>
	
	<!-- nav2.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav2.jsp"></jsp:include>
	</div>
	
	<!--  boardList table... -->
	<table class="table">
		<thead class="table-dark">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : list) {
			%>
				<tr>
					<td><%=b.getNum() %></td>
					<td>
					<%
						for(int i=0; i<=b.getDepth(); i++) {
					%>
							&nbsp;&nbsp;&nbsp;&nbsp;
					<%
						}
					%>
					<%
						if(b.getSubject().equals("삭제된 글입니다.")) {
					%>
						<span style="color:gray;"><%=b.getSubject() %></span>
					<%
						} else {
					%>
						<a href="/poll/board/boardOne.jsp?num=<%=b.getNum()%>">
							<%=b.getSubject() %>
						</a>
					<%
						}
					%>
					</td>
					<td><%=b.getName() %></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<%=currentPage %> / <%=lastPage %>
	<br>
	<a href="/poll/board/boardList.jsp?currentpage=1">[처음]</a>
	<%
		// 5개 이전 할 경우
		if(currentPage > 1) {
			int prevPage = currentPage - 5;
			if(prevPage < 1) prevPage = 1;
	%>
		<a href="/poll/board/boardList.jsp?currentPage=<%=prevPage %>">[이전 5]</a>
	<%
		}
	%>
	<%
		// 페이징 수 나타내기
		int pageCount = 5;
		int startPage = ((currentPage - 1) / pageCount) * pageCount + 1;
		int endPage = startPage + pageCount - 1;
		if(endPage > lastPage) {
			endPage = lastPage;
		}
		for(int i = startPage; i <= endPage; i++) {
	%>
		<a href="/poll/board/boardList.jsp?currentPage=<%=i %>">[<%=i %>]</a>
	<%
		}
	%>
	<%
		// 5개 다음 할 경우
		if(currentPage < lastPage) {
			int nextPage = currentPage + 5;
			if(nextPage > lastPage) nextPage = lastPage;
	%>
		<a href="/poll/board/boardList.jsp?currentPage=<%=nextPage %>">[다음 5]</a>
	<%
		}
	%>
		<a href="/poll/board/boardList.jsp?currentPage=<%=lastPage %>">[마지막]</a>
</body>
</html>













