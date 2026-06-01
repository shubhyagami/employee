<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
int reg;
String fname,lname,gmail,pwd,domain,tel,gender;
domain=request.getParameter("domain");
tel=request.getParameter("tel");
gender=request.getParameter("gender");
fname=request.getParameter("fname");
lname=request.getParameter("lname");
gmail=request.getParameter("eAdd");
pwd=request.getParameter("pwd");

Class.forName("org.sqlite.JDBC");

Connection conn=DriverManager.getConnection("jdbc:sqlite:employees.db");

String sqlQuery="INSERT INTO esp (first_name, last_name, gender, telephone, email, password, domain) VALUES(?,?,?,?,?,?,?)";
PreparedStatement stmt = conn.prepareStatement(sqlQuery);
stmt.setString(1,fname);
stmt.setString(2,lname);
stmt.setString(3,gender);
stmt.setString(4,tel);
stmt.setString(5,gmail);
stmt.setString(6,pwd);
stmt.setString(7,domain);
stmt.executeUpdate();
conn.close();
stmt.close();
%>
<script>
alert("Registration successfully ! BOSS");
setTimeout(()=>{
    alert("redirecting......")},2000
)
</script>
<%
response.sendRedirect("sign.jsp?room=" + domain);
%>