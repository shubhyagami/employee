<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
        <%
String Email;
Email=request.getParameter("gmail");

Class.forName("org.sqlite.JDBC");

Connection conn=DriverManager.getConnection("jdbc:sqlite:employees.db");

String sqlQuery="DELETE FROM esp WHERE email=?";
PreparedStatement stmt = conn.prepareStatement(sqlQuery);
stmt.setString(1,Email);
stmt.executeUpdate();
conn.close();
stmt.close();
%>
<script>
alert("Profile deleted!");
window.location.href = "index.jsp";
</script>