<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%
String fname,lname,gmail,pwd,tel,game,gen;
 gmail=request.getParameter("eAdd");
fname=request.getParameter("fname");
lname=request.getParameter("lname");
tel=request.getParameter("tel");
gen=request.getParameter("gender");
pwd=request.getParameter("pwd");



Class.forName("org.sqlite.JDBC");

Connection conn=DriverManager.getConnection("jdbc:sqlite:employees.db");
String sqlQuery="UPDATE esp SET first_name=?,last_name=?,password=?,telephone=?,gender=? WHERE email=?";
PreparedStatement stmt = conn.prepareStatement(sqlQuery);
stmt.setString(6,gmail);
stmt.setString(1,fname);
stmt.setString(2,lname);
stmt.setString(3,pwd);
stmt.setString(4,tel);
stmt.setString(5,gen);
stmt.executeUpdate();
conn.close();
stmt.close();
%>
<script>
alert("Profile updated successfully!");
window.location.href = "index.jsp";
</script>