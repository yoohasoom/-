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

String sql = "select menu_cd, menu_nm, price, menu_fg from menu_tbl_008";

ResultSet rs = conn.prepareStatement(sql).executeQuery();
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">메뉴등록/수정</h2>
<br>
<section style="display: flex; justify-content: center;">
<table border="1" style="border-spacing: 0px;">
<tr>
                    <td style="padding: 0 30px;">메뉴코드</td>
                    <td style="padding: 0 80px;">메뉴명</td>
                    <td style="padding: 0 30px;">메뉴가격</td>
                    <td style="padding: 0 30px;">메뉴구분</td>
                    
                </tr>
                <%
                while (rs.next()) {
                	String str = de.format(rs.getInt(3));
                %>
                <tr>
                    <td><a href="MeEdit.jsp?menu_cd=<%=rs.getString(1)%>&menu_nm=<%=rs.getString(2)%>&price=<%=rs.getString(3)%>&menu_fg=<%=rs.getString(4)%>" style="color: black; text-decoration: none; font-size: 15px"><%=rs.getString(1)%></a></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=str%> 원</td>                   
                    <td><%=rs.getString(4).equalsIgnoreCase("0") ? "커피" : (rs.getString(4).equalsIgnoreCase("1") ? "티" : "")%></td>
                </tr>
                <%
                }
                %>
                <tr>
                <td colspan="4" style="text-align: center;"><input type="button" value="등록" onclick="fn_button();"></td>
                </tr>
</table>
</section>
<script type="text/javascript">
function fn_button() {
	location = "MeRegi.jsp";
}
</script>
</body>
</html>