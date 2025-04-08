<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	//입력값 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass"); // 비밀번호는 문자열도 같이 쓰는게 효과적
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	// db내용 가져오기
	BoardDao boardDao = new BoardDao();
	Board mypass = boardDao.selectBoardOne(num); 
	System.out.println("입력된 pass: [" + pass + "]");
	System.out.println("DB pass:     [" + mypass.getPass() + "]");
	System.out.println("일치 여부:   " + pass.equals(mypass.getPass()));
	// 비밀번호 맞는지 확인
	if(pass.equals(mypass.getPass())) {
		// 비밀번호가 맞으면 수정 진행
		mypass.setSubject(subject);
		mypass.setContent(content);
		
		boardDao.updateBoard(mypass); // db에서도 수정
		
		// 수정 성공시 목록으로 이동
		response.sendRedirect("/poll/board/boardList.jsp");
		
	} else { // 비밀번호 틀릴 경우 되돌아감 
	
	%>
		<script>
			alert("비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<%
	}
%>
















