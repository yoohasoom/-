<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
String menu_cd = request.getParameter("menu_cd");
String menu_nm = request.getParameter("menu_nm");
String price = request.getParameter("price");
String menu_fg = request.getParameter("menu_fg");
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">메뉴 수정</h2>
<br>
<section style="display: flex; justify-content: center;">
<form action="MeEditConfirm.jsp">
	<table border="1" style="border-spacing: 0px;">
		<tr>
			<th>메뉴코드(수정불가)</th>
			<td>
			<input type="text" name="menu_cd" readonly value="<%=menu_cd%>">
			</td>
		</tr>
		<tr>
			<th>메뉴명</th>
			<td>
			<input type="text" name="menu_nm" value="<%=menu_nm%>">
			</td>
		</tr>
		<tr>
			<th>메뉴가격</th>
			<td>
			<input type="text" name="price" value="<%=price%>">
			</td>
		</tr>
		<tr>
			<th>메뉴구분</th>
			<td>
			<select name="menu_fg">
				<option><%=menu_fg.equalsIgnoreCase("0") ? "커피" : (menu_fg.equalsIgnoreCase("1") ? "티" : "")%></option>
				<option value="0">커피</option>
				<option value="1">티</option>
			</select>		
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center">
			<input type="submit" value="수정">
			<input type="button" value="조회" onclick="fn_button();">
			</td>
		</tr>
	</table>
</form>
</section>
<script type="text/javascript">
function fn_button() {
	location = "List.jsp";
}
</script>
</body>
</html>