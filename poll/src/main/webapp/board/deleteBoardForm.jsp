<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h2>비밀번호 확인</h2>
	<!--  onsubmit으로 하는이유는 form 전체가 제출될때 확인창을 띄우기 위해 -->
	<form method="post" action="deleteBoardAction.jsp"
	onsubmit="return confirm('⚠️ 정말 삭제할까요? 삭제하면 복구할 수 없습니다!');">
	
	<input type="hidden" name="num" value="<%=num %>">
	비밀번호 : <input type="password" name="pass" required>
	<button type="submit">삭제하기</button>
	</form>
</body>
</html>