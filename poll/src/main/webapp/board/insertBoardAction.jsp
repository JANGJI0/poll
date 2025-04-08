<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto. *" %>
<%@ page import = "model. *" %>
<%
	// controller Layer(request분석, model 호출)
	
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	
	
	// 답글이면 부모글의 pk을 받아옴, 아니면 본인 pk
	int ref = 0; // 답글이 아니면 0을 입력하고 입력직후에 본인의 num값과 동일하게"
	if(request.getParameter("ref") != null) {
		Integer.parseInt(request.getParameter("ref"));
	}
	
	
	// Form 입력타입(dto사용가능)으로 묶음
	// BoardForm.class 로 받아야한다. 대신 따로 안만들고 board로 받는다
	Board board = new Board();
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	board.setRef(ref);
	board.setPass(pass);
	board.setIp(request.getRemoteAddr()); // 실무에서 안쓴다. 정확한 것을 안준다 // 다른 API를 이용하여 IP를 구하는 경우가 많음
	
	// logging(디버깅.....)
	System.out.println(board.toString());  //System.out.println(board); 오버로딩 되어있어서 toString 생략할 수 있다.
	
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);
	
	// 뷰가 있다면 뷰룰 연결(디스패츠 ex)), 뷰가 없다면 다른요청을 강제(리다이렉트)
	response.sendRedirect("/poll/board/boardList.jsp");
%>