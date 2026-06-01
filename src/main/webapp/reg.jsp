<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>
    <%@ page import="java.io.File"%>
<%@ page import="java.util.Arrays"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
    margin: 0;
    padding: 0;
    overflow: hidden;
            background: url('https://cdn.dribbble.com/userupload/19932519/file/original-99d45300581bfa18481557c5fa63733a.gif') no-repeat center center fixed;
            background-size: cover;
    font-family: 'Montserrat', sans-serif;
}

.video-background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    z-index: -1;
}

video {
    min-width: 100%;
    min-height: 100%;
    width: auto;
    height: auto;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    object-fit: cover;
}

.content {
    position: relative;
    z-index: 1;
    padding-top: 160px;
    padding-left: 10%;
    color: #fff;
    min-width: 500px;
    min-height: 200px;
    height: 100vmax;
}

h1 {
    text-shadow: 0 56px 40px rgba(0, 0, 0, 5.19), 0 8px 26px rgba(0, 0, 0, 3.23);
    text-transform: uppercase;
    font-size: 31px;
    letter-spacing: 5px;
    margin-top: 10px;
    padding-top: 0px;
    color: rgb(255, 41, 41);
}

.card {
    margin-left: 32%;
    margin-top: 11%;
    max-width: 700px;
    height: 500px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
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

.card:hover {
    transform: scale(1.06);
}

.card .formm {
    width: 97%;
    height: 500px;
    margin-top: -35px;
    margin-right: 80px;
    float: left;
    border-radius: 20px;
}

.card .formm form {
    margin-top: 75px;
    width: 100%;
    height: 80%;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 33px;
}

.card .formm input,select {
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

.card .formm input,select:focus {
    border: 3px solid cyan;
    box-shadow: 0px 0px 20px pink, inset 0px 0px 20px pink;
    transform: scale(1.09);
}

.card .formm .but:hover {
    border: 3px solid violet;
    transform: scale(1.05);
}

.card .formm .but {
    width: 40%;
    height: 50px;
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
<div class="video-background">
        <video autoplay muted loop>
            <source src="vide.mp4" type="video/mp4">
            
        </video>
    </div>

    <%
   
    String gmail=request.getParameter("room");

    %>
    <div class="header">
        <div class="bars" id="nav-action">
            <span class="bar"> </span>
          </div>
          

          <nav id="nav">
            <ul>
              <!-- <li class="shape-circle circle-one"><a href="#">Register</a></li> -->
              <li class="shape-circle circle-two"><a href="sign.jsp">Sign In</a></li>
              <li class="shape-circle circle-three"><a href="About.jsp">About Us</a></li>
              <li class="shape-circle circle-five">
                <a href="index.jsp">Home</a>
              </li>
            </ul>
          </nav>
          
          
    </div>
    <div class="card">
        <div class="titl"><h1>Sign Up for <%=gmail %></h1></div>
        <div class="formm" >
            <form id='myForm' action="register.jsp" method="post">
                <input type="hidden" name="domain" value="<%=gmail %>">
                <input type="text" name="fname" placeholder="first name">
                <input type="text" name="lname" placeholder="last name">
                <input type="tel" name="tel" placeholder="phone">
                <select name="gender">
                <option value="na" Selected>Gender</option>
                  <option value="male">Male</option>
                  <option value="female">Female</option>
                </select>
                <input type="email" name="eAdd"  placeholder="E-mail">
                <input type="password" name="pwd"  placeholder="Password">
               
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

</body>
