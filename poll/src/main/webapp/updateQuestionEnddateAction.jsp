<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto. * " %>
<%@ page import ="model. * " %>
<%@ page import ="java.util. * " %>
<%

	String enddate = request.getParameter("enddate");
	int num = Integer.parseInt(request.getParameter("num"));
	
	Question question = new Question();
	question.setNum(num);
	question.setEnddate(enddate);
	question.setTitle(request.getParameter("title"));
	question.setStartdate(request.getParameter("startdate"));
	question.setType(Integer.parseInt(request.getParameter("type")));
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestion(question);
	
	response.sendRedirect("/poll/pollList.jsp");

%>