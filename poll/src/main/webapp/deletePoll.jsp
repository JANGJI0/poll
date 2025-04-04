<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model. *" %>
<%
	 //1. Question 모델(DAO메서드) 호출
	
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	ItemDao itemDao = new ItemDao();
	QuestionDao questionDao = new QuestionDao();
	
	// item 먼저 삭제 후 question 삭제
	itemDao.deleteItem(qnum);
	questionDao.deleteQuestion(qnum);
	
	response.sendRedirect("/poll/pollList.jsp");
	
	
%>
