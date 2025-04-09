<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>이미지 올리기</title>
    </head>
    <body>
    <form action="/poll/imageBoard/insertImageAction.jsp" method="post" enctype="multipart/form-data">
		<div style="margin-top: 5px;">
			메모 : <input type="text" name="memo">
		</div>
		<div style="margin-top: 5px;">
			이미지 : <input type="file" name="imageFile">
		</div>
		<div style="margin-top: 5px;">
		<button type="submit">이미지 등록</button>
    </form>
    </body>
</html>