<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%
String uname,pwd;
uname=request.getParameter("uname");
pwd=request.getParameter("pwd");
Class.forName("org.sqlite.JDBC");

Connection conn=DriverManager.getConnection("jdbc:sqlite:employees.db");

String sqlQuery="SELECT * FROM esp WHERE email=? and password=? ;";
PreparedStatement stmt = conn.prepareStatement(sqlQuery);
stmt.setString(1,uname);
stmt.setString(2,pwd);
ResultSet rs = stmt.executeQuery();
if(rs.next()){
	response.sendRedirect("dashboard.jsp?gmail="+uname);
	%>
<%
} else{ %>
<script>
alert("login failed !!!");
window.location.href="error.jsp";
</script>
<% }
conn.close();
stmt.close();
%>