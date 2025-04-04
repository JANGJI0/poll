<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!--  CSS 스타일 정의 -->
	<style>
		P {color:orange;}
		#one {color : blue;}
		.two {color : green;}  /* 이것만 쓰면 된다 */
		.three {background-color : yellow;} 
	</style>	
	
</head>
<body>
	<div>GOOD</div>
	<P>GOOD</P>
	
	<div id="one">GOOD</div> <!--  자바스크립트에는 중복하면 에러가 난다 -->
	<div class="two">GOOD</div>
	<div class="two">TEST</div> 
	<div class="two three">TEST</div>
</body>
</html>