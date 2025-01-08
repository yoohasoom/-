<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*" %>
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

String sql = "select store_cd, store_nm from store_tbl_008 group by store_cd, store_nm";
String sql1 = "select menu_cd, menu_nm from menu_tbl_008 group by menu_cd, menu_nm";
String sql2 = "select size_cd, size_nm from size_tbl_008 group by size_cd, size_nm";
String sql3 = "select max(sale_no)+1 from sale_tbl_004";

Statement stmt = conn.createStatement();
%>
<%
Date da = new Date();
SimpleDateFormat simpledate = new SimpleDateFormat("yyyyMMdd");
String strDate = simpledate.format(da);
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">매출 등록</h2>
<br>
<section style="display: flex; justify-content: center;">
<form action="RegiConfirm.jsp" name="form">
	<table border="1" style="border-spacing: 0px;">
		<tr>
			<th>판매일자(자동발생)</th>
			<td>
			<input type="text" name="sale_ymd" readonly value="<%=strDate%>">
			</td>
		</tr>
		<tr>
			<th>판매번호(자동채번)</th>
			<td>
			<%  ResultSet rs = stmt.executeQuery(sql3);
			
			rs.next();
			
			String str1 = rs.getString(1);
			
				String str;
				if (str1.equals("10")) {
					str = "00" + rs.getString(1);
				} else {
					str = "000" + rs.getString(1);
				}
			%>
			<input type="text" name="sale_no" value="<%= str %>" readonly>
			</td>
		</tr>
		<tr>
			<th>판매점포</th>
			<td>
			<% rs = stmt.executeQuery(sql); %>
			<select name="store_cd">
				<option></option>
				<% while(rs.next()) {%>
				<option value="<%= rs.getString(1) %>"><%= rs.getString(2) %></option>
				<%
				}
				rs.close();
				%>
				
			</select>		
			</td>
		</tr>
		<tr>
			<th>메뉴코드</th>
			<td>
			<%  rs = stmt.executeQuery(sql1); %>
			<select name="menu_cd">
				<option></option>
				<% while(rs.next()) {%>
				<option value="<%= rs.getString(1) %>"><%= rs.getString(2) %></option>
				<%
				}
				rs.close();
				%>
			</select>		
			</td>
		</tr>
		<tr>
			<th>사이즈</th>
			<td>
			<%  rs = stmt.executeQuery(sql2); %>
			<select name="size_cd">
				<option></option>
				<% while(rs.next()) {%>
				<option value="<%= rs.getString(1) %>"><%= rs.getString(2) %></option>
				<%
				}
				rs.close();
				%>
			</select>		
			</td>
		</tr>
		<tr>
			<th>판매수량</th>
			<td>
			<input type="text" name="sale_cnt">
			</td>
		</tr>
		<tr>
			<th>수취구분</th>
			<td>
			<select name="pay_type">
				<option></option>
				<option value="01">현금</option>
				<option value="02">카드</option>
			</select>		
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center">
			<input type="submit" value="등록" onclick="fn_submit(); return false;">
			<input type="button" value="조회" onclick="fn_button();">
			</td>
		</tr>
	</table>
</form>
</section>
<script type="text/javascript">
function fn_submit() {
	var f = document.form;
	
	if(f.sale_cnt.value == "") {
		alert("판매수량을 입력하지 않았습니다.");
		return false;
	}
	f.submit();
}
function fn_button() {
	location = "Result.jsp";
}
</script>
</body>
</html>