<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
DecimalFormat de = new DecimalFormat("###,###");
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "system", "1234");

String sql = "select sa.sale_ymd, sa.sale_no, st.store_nm, me.menu_nm, si.size_nm, sa.sale_cnt, sum((me.price + si.plus_price) * sa.sale_cnt) as total, sa.pay_type "
			+ "from menu_tbl_008 me, size_tbl_008 si, store_tbl_008 st, sale_tbl_004 sa "
			+ "where me.menu_cd = sa.menu_cd and si.size_cd = sa.size_cd and st.store_cd = sa.store_cd "
			+ "group by sa.sale_ymd, sa.sale_no, st.store_nm, me.menu_nm, si.size_nm, sa.sale_cnt, sa.pay_type "
			+ "order by sa.sale_no ";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">매출현황</h2>
<br>
<section style="display: flex; justify-content: center;">
<table border="1" style="border-spacing: 0px;">
<tr>
<th>판매일자</th>
<th>판매번호</th>
<th>점포명</th>
<th>판매메뉴</th>
<th>사이즈</th>
<th>판매수량</th>
<th>판매금액</th>
<th>수취구분</th>
</tr>
<%
while(rs.next()) {
	String str = de.format(rs.getInt(7));
%>
<tr>
<td><%= rs.getString(1) %></td>
<td><%= rs.getString(2) %></td>
<td><%= rs.getString(3) %></td>
<td><%= rs.getString(4) %></td>
<td><%= rs.getString(5) %></td>
<td><%= rs.getString(6) %></td>
<td><%= str %>원</td>
<td><%= rs.getString(8).equalsIgnoreCase("01") ? "현금" : (rs.getString(8).equalsIgnoreCase("02") ? "카드" : "") %></td>
</tr>
<%
}
%>
</table>
</section>
</body>
</html>