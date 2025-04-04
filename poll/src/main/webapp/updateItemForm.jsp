<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%
	// ?번 문제와 아이템을 출력
	// type(복수투표) = 1 아이템의 타입을 checkbox
	// type(복수투표) = 0 아이템의 타입을 radio
	
	// Contolller Layer(request분석 + Model Layer 호출/반환)
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestion(qnum);
	// 2) 1)의 itemList  // 조인 하는이점과 안하는 이점을 고려
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
	
	System.out.println("넘어온 qnum = " + request.getParameter("qnum"));
	System.out.println("itemList size = " + itemList.size());
%>
<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>
</head>
<body>
	<h1>투표하기</h1>
	<form action="/poll/updateItemAction.jsp" method="post">
	<input type="hidden" name="qnum" value="<%=qnum %>">
	<table border="1">
		<tr>
			<td>
				Q : <%= question.getTitle() %>
				(<%=question.getType() == 1 ? "복수투표가능" : "복수투표불가" %>)
			</td>
		</tr>
		<tr>
			<td>
				<%
					for(Item i : itemList) {
				%>
					<div>
						<%
							if(question.getType() == 0) { // type = radio
						%>
								<input type="radio" name="inum" value="<%=i.getInum() %>">
						<%
							} else { // type = checkbox
						%>
								<input type="checkbox" name="inum" value="<%=i.getInum() %>">
						<%	
							}
						%>
							<%=i.getContent() %>
					</div>
				<%
					}
				%>
			</td>
		</tr>
	</table>
	<button type="submit">투표하기</button>
	</form>
</body>
</html>