<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="model. * " %>
<%@ page import ="java.util. * " %>
<%

	String enddate = request.getParameter("enddate");
	int num = Integer.parseInt(request.getParameter("num"));
		// 디버깅
		System.out.println("updateQuetionEnddateAction.jsp num: " + num);
		System.out.println("updateQuetionEnddateAction.jsp enddate: " + enddate);
		
		// 오늘 날짜 가져오기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(date);
		Date today = sdf.parse(todayStr);
		
		// enddate 객체 타입 변환
		Date endDate = sdf.parse(enddate);
		
		// 이미 종료된 설문 -> 종료 일자 수정 불가 -> 다시 수정 페이지로 이동
		if(today.after(endDate)) {
			response.sendRedirect("/poll/updateQuestionEnddateForm.jsp?num=" + num);
				return;
		}
		// Dao 객체 및 endate 수정 메서드 호출
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestionEnddate(num, enddate);

	
	response.sendRedirect("/poll/pollList.jsp");

%>