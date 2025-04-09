<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.* " %>
<%@ page import = "model.* " %>
<%@ page import = "java.util.* " %>
<%
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5;
	
	ImageDao ImageDao = new ImageDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	
	
	// int lastPage = paging.getLastPage(Image.getTotal());
	
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
	ArrayList<Image> list = ImageDao.selectImageList(p);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		for(Image i : list) {
	%>
			<table border="1">
				<tr>
					<td><%=i.getMemo() %></td>
				</tr>

				<tr>
					<td>
						<img src="/poll/upload/<%=i.getFilename() %>">
					</td>
				</tr>

				<tr>
					<td>
						<a href="/poll/upload/updateImage.jsp?num=<%=i.getNum()%>">수정</a>
					</td>
				</tr>

				<tr>
					<td>
						<a href="/poll/imageBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFilename() %>">삭제</a> <!-- 원래는 db에서 넘겨와야하는데 나중에 바꾸기 -->
					</td>
				</tr>
			</table>
			<hr>
	<%
		}  // 수정도 나중에 만들어보기
	%>
</body>
</html>