<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto. *" %>
<%@ page import="model. *" %>
<%
	// 1. 글 번호 받기
	int num = Integer.parseInt(request.getParameter("num"));

	// Dao 호출
	BoardDao boardDao = new BoardDao();
	
	// 제목과 내용을 삭제된 글입니다 로 바꿈
	boardDao.deleteBoardSoft(num); // 삭제된 것처럼만 보이게 처리(db엔 남김)
	
	// 목록페이지로 이동
	response.sendRedirect("/poll/board/boardList.jsp");
%>
