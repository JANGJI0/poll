<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto. *" %>
<%@ page import="model. *" %>
<%@ page import="java.util. *" %>

<%
	// 1. 요청값 분석 (question) 받기
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));
	
	String[] content = request.getParameterValues("content");
	ArrayList<String> contentList = new ArrayList<>();
	for(String c : content) {
		if(!c.equals("")) {
			contentList.add(c);
		}
	}
	
	// 2. Question 객체 생성 및 설정
	Question question = new Question();
	question.setNum(num);
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(type);
	
	// 3. model 호출
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestion(question); //sql 저장
	
	// item 호출
	ArrayList<Item> list = new ArrayList<>();
	int i = 1;
	for(String c : contentList) {
			Item item = new Item();
			item.setQnum(num);
			item.setInum(i++);
			item.setContent(c);
			
			list.add(item);
		}
	
	ItemDao itemDao = new ItemDao();
	itemDao.deleteItem(num);
	
	for(Item item : list) {
			itemDao.insertItem(item);
	}
	
	// 4. 결과 페이지로 이동
	response.sendRedirect("/poll/pollList.jsp");

%>