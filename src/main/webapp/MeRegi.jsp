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
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "system", "1234");

String sql = "select max(menu_cd)+1 menu_cd from menu_tbl_008";

ResultSet rs = conn.prepareStatement(sql).executeQuery();
rs.next();
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">메뉴 등록</h2>
<br>
<section style="display: flex; justify-content: center;">
<form action="MeRegiConfirm.jsp">
	<table border="1" style="border-spacing: 0px;">
		<tr>
			<th>메뉴코드(자동채번)</th>
			<td>
			<input type="text" name="menu_cd" readonly value="<%=rs.getString(1)%>">
			</td>
		</tr>
		<tr>
			<th>메뉴명</th>
			<td>
			<input type="text" name="menu_nm">
			</td>
		</tr>
		<tr>
			<th>메뉴가격</th>
			<td>
			<input type="text" name="price">
			</td>
		</tr>
		<tr>
			<th>메뉴구분</th>
			<td>
			<select name="menu_fg">
				<option></option>
				<option value="0">커피</option>
				<option value="1">티</option>
			</select>		
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center">
			<input type="submit" value="등록">
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