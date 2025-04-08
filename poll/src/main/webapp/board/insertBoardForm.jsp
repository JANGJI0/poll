<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	<h1>글입력</h1>
	<form method="post" action="/poll/board/insertBoardAction.jsp">
		<table class="table">
		<thead class="table-dark">
			<tr>
				<td>name</td>
				<td><input type="text" name="name"></td>
			</tr>
			</thead>
			
			<tr>
				<td>subject</td>
				<td><input type="text" name="subject"></td>
			</tr>
			
			<thead class="table-dark">
			<tr>
				<td style="vertical-align: top;">content</td>
				<td><textarea name="content" rows="5" cols="50"></textarea></td>
			</tr>
			</thead>
			
			<tr>
				<td>pass</td>
				<td><input type="password" name="pass"></td>
			</tr>
			
		</table>
		<button type="submit" class="btn btn-dark">글쓰기</button>
		</form>
</body>
</html>