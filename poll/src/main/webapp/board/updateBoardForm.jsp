<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String numStr = request.getParameter("num");
	int num = 0;
	Board b = null;
	
	if (numStr != null && !numStr.equals("")) {
	    num = Integer.parseInt(numStr);
	    BoardDao dao = new BoardDao();
	    b = dao.selectBoardOne(num);
	} else {
	    out.println("<p style='color:red;'>잘못된 접근입니다.</p>");
	    return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav2.jsp 인클루드-->
	<div>
		<jsp:include page="/inc/nav2.jsp"></jsp:include>
	</div>
	
	<h1 style="text-align: center;">수정하기</h1>
	<form method="post" action="/poll/board/updateBoardAction.jsp">
	<input type="hidden" name="num" value="<%=b.getNum() %>">
		<table class="table">
		<thead class="table-dark">
			<tr>
				<td>성명</td>
				<td><input type="text" name="name"></td>
			</tr>
			</thead>
			
			<tr>
				<td>제목</td>
				<td><input type="text" name="subject"></td>
			</tr>
			
			<thead class="table-dark">
			<tr>
				<td style="vertical-align: top;">내용</td>
				<td><textarea name="content" rows="5" cols="50"></textarea></td>
			</tr>
			</thead>
			
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pass">
				수정 시에는 비밀번호가 필요합니다.
				</td>
			</tr>
			
		</table>
		<button type="submit" class="btn btn-dark">수정완료</button>
		<button type="submit" class="btn btn-dark">다시수정</button>
		<button type="submit" class="btn btn-dark">뒤로</button>
		</form>
</body>
</html>