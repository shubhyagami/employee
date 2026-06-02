# Eclipse Setup Guide — Employee Management System

Build this project from scratch in Eclipse using only `sqlite-jdbc.jar` (no Maven).

---

## Prerequisites

| Item | Notes |
|------|-------|
| Eclipse IDE for Enterprise Java | Includes Dynamic Web Project support |
| Apache Tomcat 9 | Configured in Eclipse (Servers view) |
| sqlite-jdbc-3.45.1.0.jar | Download from: https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.45.1.0/sqlite-jdbc-3.45.1.0.jar |

---

## Step 1 — Create the Project

1. **File → New → Dynamic Web Project**
2. Project name: `EmployeeManagementSystem`
3. **Target runtime**: select your Tomcat
4. **Configuration**: Default Configuration for Apache Tomcat
5. Check **Generate web.xml deployment descriptor**
6. Click **Finish**

---

## Step 2 — Add sqlite-jdbc.jar

1. In `WebContent/WEB-INF/` create a folder named `lib`
2. Copy `sqlite-jdbc-3.45.1.0.jar` into `WebContent/WEB-INF/lib/`
3. In Eclipse, right-click the JAR → **Build Path → Add to Build Path**

---

## Step 3 — Project Structure

After creating all files (steps below), your project will look like:

```
EmployeeManagementSystem/
├── src/
│   └── com/example/demo1/
│       ├── Employee.java
│       ├── EmployeeServlet.java
│       ├── DatabaseUtil.java
│       └── DatabaseInitializer.java
│
├── WebContent/
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   └── lib/
│   │       └── sqlite-jdbc-3.45.1.0.jar
│   │
│   ├── index.jsp              (Landing Page)
│   ├── reg.jsp                (Registration Form)
│   ├── register.jsp           (Registration Action)
│   ├── sign.jsp               (Login Form)
│   ├── check.jsp              (Login Action)
│   ├── dashboard.jsp          (User Dashboard)
│   ├── update.jsp             (Edit Profile Form)
│   ├── upd.jsp                (Edit Profile Action)
│   ├── delete.jsp             (Delete Profile)
│   ├── logout.jsp             (Logout)
│   ├── error.jsp              (Error Page)
│   ├── admin.jsp              (Admin Panel)
│   ├── employee-list.jsp      (Employee CRUD List)
│   ├── employee-form.jsp      (Employee CRUD Form)
│   ├── style.css              (Stylesheet 1)
│   └── style1.css             (Stylesheet 2)
│
└── employees.db               (Auto-created at runtime — DO NOT create manually)
```

---

## Step 4 — Create the Package

- **Right-click `src/` → New → Package**
- Name: `com.example.demo1`

---

## Step 5 — Create Java Classes (in `com.example.demo1`)

### 5a. Employee.java

```java
package com.example.demo1;

public class Employee {
    private int id;
    private String name;
    private String department;
    private String email;
    private double salary;

    public Employee() {}

    public Employee(int id, String name, String department, String email, double salary) {
        this.id = id;
        this.name = name;
        this.department = department;
        this.email = email;
        this.salary = salary;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }
}
```

### 5b. DatabaseUtil.java

```java
package com.example.demo1;

import java.sql.*;

public class DatabaseUtil {
    // DB file will be created in Tomcat's bin directory
    private static final String URL = "jdbc:sqlite:employees.db";

    static {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL);
    }

    public static void initializeDatabase() {
        String empTable = "CREATE TABLE IF NOT EXISTS employees (" +
                          "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                          "name TEXT NOT NULL," +
                          "department TEXT NOT NULL," +
                          "email TEXT NOT NULL," +
                          "salary REAL NOT NULL)";
        String espTable = "CREATE TABLE IF NOT EXISTS esp (" +
                          "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                          "first_name TEXT NOT NULL," +
                          "last_name TEXT NOT NULL," +
                          "gender TEXT NOT NULL," +
                          "telephone TEXT NOT NULL," +
                          "email TEXT NOT NULL," +
                          "password TEXT NOT NULL," +
                          "domain TEXT NOT NULL)";
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            stmt.execute(empTable);
            stmt.execute(espTable);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

### 5c. DatabaseInitializer.java

```java
package com.example.demo1;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DatabaseUtil.initializeDatabase();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
```

### 5d. EmployeeServlet.java

```java
package com.example.demo1;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("employee", getEmployee(id));
            request.getRequestDispatcher("employee-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            deleteEmployee(Integer.parseInt(request.getParameter("id")));
            response.sendRedirect("employees");
        } else {
            request.setAttribute("employees", getAllEmployees());
            request.getRequestDispatcher("employee-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String email = request.getParameter("email");
        double salary = Double.parseDouble(request.getParameter("salary"));

        if (idParam == null || idParam.isEmpty()) {
            addEmployee(name, department, email, salary);
        } else {
            updateEmployee(Integer.parseInt(idParam), name, department, email, salary);
        }
        response.sendRedirect("employees");
    }

    private List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM employees ORDER BY id";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Employee(
                    rs.getInt("id"), rs.getString("name"),
                    rs.getString("department"), rs.getString("email"),
                    rs.getDouble("salary")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private Employee getEmployee(int id) {
        String sql = "SELECT * FROM employees WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next())
                    return new Employee(rs.getInt("id"), rs.getString("name"),
                        rs.getString("department"), rs.getString("email"),
                        rs.getDouble("salary"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private void addEmployee(String name, String department, String email, double salary) {
        String sql = "INSERT INTO employees (name, department, email, salary) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name); pstmt.setString(2, department);
            pstmt.setString(3, email); pstmt.setDouble(4, salary);
            pstmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private void updateEmployee(int id, String name, String department, String email, double salary) {
        String sql = "UPDATE employees SET name=?, department=?, email=?, salary=? WHERE id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name); pstmt.setString(2, department);
            pstmt.setString(3, email); pstmt.setDouble(4, salary);
            pstmt.setInt(5, id);
            pstmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private void deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
```

---

## Step 6 — Create JSP Files

All JSPs go in `WebContent/`.

### 6a. index.jsp — Landing Page

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Management System</title>
<link rel="stylesheet" href="style.css">
<style>
.cont {
    display: flex;
    flex-direction: row;
    gap: 20px;
    align-items: center;
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
.container { padding: 2px 16px; }
.cont .card p a:link { color: green; text-decoration: none; }
.cont .card p a:visited { color: pink; text-decoration: none; }
.cont .card p a:hover { color: red; text-decoration: underline; }
.cont .card p a:active { color: yellow; text-decoration: underline; }
</style>
</head>
<body>

<div class="header">
    <div class="bars" id="nav-action">
        <span class="bar"> </span>
    </div>
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
    var bars = document.getElementById("nav-action");
    var nav = document.getElementById("nav");
    bars.addEventListener("click", barClicked, false);
    function barClicked() {
        bars.classList.toggle('active');
        nav.classList.toggle('visible');
    }
</script>
</body>
</html>
```

### 6b. reg.jsp — Registration Form

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            margin: 0; padding: 0; overflow: hidden;
            background: url('https://cdn.dribbble.com/userupload/19932519/file/original-99d45300581bfa18481557c5fa63733a.gif') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Montserrat', sans-serif;
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
        .card:hover { transform: scale(1.06); }
        .card .formm { width: 97%; height: 500px; margin-top: -35px; margin-right: 80px; float: left; border-radius: 20px; }
        .card .formm form { margin-top: 75px; width: 100%; height: 80%; display: flex; flex-wrap: wrap; justify-content: center; align-items: center; gap: 33px; }
        .card .formm input,select { width: 45%; height: 37px; font-size: 18px; border-radius: 5px; border: 2px solid silver; outline: none; text-align: center; transition: all ease-in 0.4s; }
        .card .formm input,select:focus { border: 3px solid cyan; box-shadow: 0px 0px 20px pink, inset 0px 0px 20px pink; transform: scale(1.09); }
        .card .formm .but:hover { border: 3px solid violet; transform: scale(1.05); }
        .card .formm .but { width: 40%; height: 50px; background-color: blue; margin-bottom: 40px; color: aliceblue; font-size: 30px; border-radius: 10px; transition: all ease-in 0.4s; }
    </style>
</head>
<body>
    <%
    String gmail=request.getParameter("room");
    %>
    <div class="header">
        <div class="bars" id="nav-action">
            <span class="bar"> </span>
        </div>
        <nav id="nav">
            <ul>
                <li class="shape-circle circle-two"><a href="sign.jsp">Sign In</a></li>
                <li class="shape-circle circle-three"><a href="About.jsp">About Us</a></li>
                <li class="shape-circle circle-five"><a href="index.jsp">Home</a></li>
            </ul>
        </nav>
    </div>
    <div class="card">
        <div class="titl"><h1>Sign Up for <%=gmail %></h1></div>
        <div class="formm">
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
                <input type="email" name="eAdd" placeholder="E-mail">
                <input type="password" name="pwd" placeholder="Password">
                <button type="submit" class="but">Submit</button>
            </form>
        </div>
    </div>

    <script>
        var bars = document.getElementById("nav-action");
        var nav = document.getElementById("nav");
        bars.addEventListener("click", barClicked, false);
        function barClicked() {
            bars.classList.toggle('active');
            nav.classList.toggle('visible');
        }
    </script>
</body>
```

### 6c. register.jsp — Registration Action

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
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
alert("Registration successfully !");
setTimeout(()=>{ alert("redirecting......"); },2000)
</script>
<%
response.sendRedirect("sign.jsp?room=" + domain);
%>
```

### 6d. sign.jsp — Login Form

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            padding-top: 160px; padding-left: 10%; position: relative;
            background: url('https://cdn.dribbble.com/userupload/21957699/file/original-fd768c65ea40a0b7ae0e5ffc2fcae859.gif') no-repeat center center fixed;
            background-size: cover;
            min-width: 500px; min-height: 200px;
            color: #fff; font-family: 'Montserrat'; height: 100vmax;
        }
        h1 {
            text-shadow: 0 56px 40px rgba(0, 0, 0, 5.19), 0 8px 26px rgba(0, 0, 0, 3.23);
            text-transform: uppercase; font-size: 31px; letter-spacing: 5px;
            padding-left: 34%; margin-top: -30px; color: rgb(73, 255, 103);
        }
        .card {
            margin: 32%; max-width: 300px; min-height: 200px;
            display: flex; flex-direction: column; justify-content: space-between;
            margin-top: 20px; max-width: 500px; height: 300px;
            color: cornflowerblue; padding: 35px; font-size: 45px;
            border: 1px solid rgba(255, 255, 255, .25); border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.31);
            box-shadow: 0 0 10px 1px rgba(0, 0, 0, 0.25);
            backdrop-filter: blur(15px); transition: all ease-in-out 0.4s;
        }
        .card:hover { transform: scale(1.06); box-shadow: 0px 0px 20px pink, inset 0px 0px 20px pink; }
        .card .formm { width: 97%; height: 500px; margin-top: -35px; margin-right: 80px; float: left; border-radius: 20px; }
        .card .formm form { margin-top: 75px; width: 100%; height: 80%; display: flex; flex-wrap: wrap; justify-content: center; align-items: center; gap: 33px; }
        .card .formm input { width: 60%; height: 30px; font-size: 18px; border-radius: 5px; border: 2px solid silver; outline: none; text-align: center; transition: all ease-in 0.4s; }
        .card .formm input:focus { border: 3px solid cyan; transform: scale(1.09); }
        .card .formm .but:hover { border: 3px solid violet; transform: scale(1.05); }
        .card .formm .but { width: 40%; height: 50px; background-color: blue; margin-bottom: 40px; color: aliceblue; font-size: 30px; border-radius: 10px; transition: all ease-in 0.4s; }
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
        <nav id="nav">
            <ul>
                <li class="shape-circle circle-one"><a href="index.jsp">Register</a></li>
                <li class="shape-circle circle-three"><a href="About.jsp">About Us</a></li>
                <li class="shape-circle circle-five"><a href="index.jsp">Home</a></li>
            </ul>
        </nav>
    </div>
    <div class="card">
        <div class="titl"><h1>Sign In</h1></div>
        <div class="formm">
            <form id='myForm' action="check.jsp" method="post">
                <input type="email" name="uname" placeholder="Email" value="<%=usr %>">
                <input type="password" name="pwd" placeholder="Password" value="<%=pswd%>">
                <button type="submit" class="but">Submit</button>
            </form>
        </div>
    </div>

    <script>
        var bars = document.getElementById("nav-action");
        var nav = document.getElementById("nav");
        bars.addEventListener("click", barClicked, false);
        function barClicked() {
            bars.classList.toggle('active');
            nav.classList.toggle('visible');
        }
    </script>
</body>
</html>
```

### 6e. check.jsp — Login Action

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
} else{ %>
<script>
alert("login failed !!!");
window.location.href="error.jsp";
</script>
<% }
conn.close();
stmt.close();
%>
```

### 6f. dashboard.jsp — User Dashboard

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<% Class.forName("org.sqlite.JDBC"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DashBoard</title>
<link rel="stylesheet" href="style1.css">
<style>
a { display: block; margin-top: 10px; font-size: 45px; font-weight: bolder; text-decoration: none; color: whitesmoke; }
</style>
</head>
<body>
<%
Connection conn=DriverManager.getConnection("jdbc:sqlite:employees.db");
String gmail=request.getParameter("gmail");
String sqlQuery="SELECT * FROM esp WHERE email=?;";
PreparedStatement ps = conn.prepareStatement(sqlQuery);
ps.setString(1, gmail);
ResultSet rs=ps.executeQuery();
String fname="",lname="",domain="";
if(rs.next()){
    fname=rs.getString(2);
    lname=rs.getString(3);
    domain = rs.getString(8);
}
ps.close();
conn.close();
%>
<div class="header">
    <div class="bars" id="nav-action">
        <span class="bar"> </span>
    </div>
    <nav id="nav">
        <ul>
            <li class="shape-circle circle-one"><a href="delete.jsp?gmail=<%=gmail %>">Delete Profile</a></li>
            <li class="shape-circle circle-two"><a href="update.jsp?gmail=<%=gmail %>">Edit Profile</a></li>
            <li class="shape-circle circle-three"><a href="logout.jsp">Log Out</a></li>
        </ul>
    </nav>
    <article class="container">
        <h1>Welcome,<br>Master<br><%=fname %> <%=lname %></h1>
        <br><br><br><br><br><br><br><br><br><br><br><br>
        <h1>you have registered in <%=domain %>.</h1>
    </article>
</div>

<script>
    var bars = document.getElementById("nav-action");
    var nav = document.getElementById("nav");
    bars.addEventListener("click", barClicked, false);
    function barClicked() {
        bars.classList.toggle('active');
        nav.classList.toggle('visible');
    }
</script>
</body>
</html>
```

### 6g. update.jsp — Edit Profile Form

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            padding-top: 160px; padding-left: 10%; position: relative;
            background: url('https://cdn.dribbble.com/userupload/21273218/file/original-00ce99e2b654a88efafff7d0fe53e18c.gif') no-repeat center center fixed;
            background-size: cover; min-width: 500px; min-height: 200px;
            color: #fff; font-family: 'Montserrat'; height: 100vmax;
        }
        h1 {
            text-shadow: 0 56px 40px rgba(0, 0, 0, 5.19), 0 8px 26px rgba(0, 0, 0, 3.23);
            text-transform: uppercase; font-size: 31px; letter-spacing: 5px;
            margin-top: -20px; padding-top: 0px; color: rgb(255, 41, 41);
        }
        .card {
            margin: 27%; max-width: 300px; min-height: 200px;
            display: flex; flex-direction: column; justify-content: space-between;
            margin-top: -69px; max-width: 500px; height: 300px;
            color: cornflowerblue; padding: 35px; font-size: 45px;
            border: 1px solid rgba(255, 255, 255, .25); border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.31);
            box-shadow: 0 0 10px 1px rgba(0, 0, 0, 0.25);
            backdrop-filter: blur(15px); transition: all ease-in-out 0.4s;
        }
        .card:hover { transform: scale(1.06); }
        .card .formm { width: 97%; height: 500px; margin-top: -35px; margin-right: 80px; float: left; border-radius: 20px; }
        .card .formm form { margin-top: 75px; width: 100%; height: 80%; display: flex; flex-wrap: wrap; justify-content: center; align-items: center; gap: 33px; }
        .card .formm input,select { width: 45%; height: 37px; font-size: 18px; border-radius: 5px; border: 2px solid silver; outline: none; text-align: center; transition: all ease-in 0.4s; }
        .card .formm input,select:focus { border: 3px solid cyan; box-shadow: 0px 0px 20px pink, inset 0px 0px 20px pink; transform: scale(1.09); }
        .card .formm .but:hover { border: 3px solid violet; transform: scale(1.05); }
        .card .formm .but { width: 40%; height: 50px; background-color: blue; margin-bottom: 40px; color: aliceblue; font-size: 30px; border-radius: 10px; transition: all ease-in 0.4s; }
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
    fname=rs.getString(2); lname=rs.getString(3); gen=rs.getString(4);
    tel=rs.getString(5); mail=rs.getString(6); passwd=rs.getString(7);
    domain=rs.getString(8);
}
ps.close();
conn.close();
%>

<div class="card">
    <div class="titl"><h1>Update For <%=domain %></h1></div>
    <div class="formm">
        <form id='myForm' action="upd.jsp" method="post">
            <input type="text" name="fname" placeholder="first name" value=<%=fname %>>
            <input type="text" name="lname" placeholder="last name" value=<%=lname %>>
            <input type="tel" name="tel" placeholder="phone" value=<%=tel %>>
            <select name="gender">
                <option value=<%=gen%>><%=gen%></option>
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
            <input type="email" name="eAdd" placeholder="E-mail" value=<%=mail %>>
            <input type="text" name="pwd" placeholder="Password" value=<%=passwd %>>
            <button type="submit" class="but">Submit</button>
        </form>
    </div>
</div>

<script>
    var bars = document.getElementById("nav-action");
    var nav = document.getElementById("nav");
    bars.addEventListener("click", barClicked, false);
    function barClicked() {
        bars.classList.toggle('active');
        nav.classList.toggle('visible');
    }
</script>
</body>
</html>
```

### 6h. upd.jsp — Edit Profile Action

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
String fname,lname,gmail,pwd,tel,gen;
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
stmt.setString(1,fname); stmt.setString(2,lname); stmt.setString(3,pwd);
stmt.setString(4,tel); stmt.setString(5,gen); stmt.setString(6,gmail);
stmt.executeUpdate();
conn.close();
stmt.close();
%>
<script>
alert("Profile updated successfully!");
window.location.href = "index.jsp";
</script>
```

### 6i. delete.jsp — Delete Profile

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
```

### 6j. logout.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
response.sendRedirect("index.jsp");
%>
```

### 6k. error.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ERROR</title>
<link rel="stylesheet" href="style.css">
<style>
body {
    position: relative;
    background: url('https://cdn.dribbble.com/users/2480087/screenshots/7009361/media/5be4690e38762fd53647912018e86189.gif') no-repeat center center fixed;
    background-size: cover;
    min-width: 500px; min-height: 200px;
    color: #fff; font-family: 'Montserrat'; height: 100vmax;
}
</style>
</head>
<body>

<div class="header">
    <div class="bars" id="nav-action">
        <span class="bar"> </span>
    </div>
    <nav id="nav">
        <ul>
            <li class="shape-circle circle-one"><a href="reg.jsp">Register</a></li>
            <li class="shape-circle circle-two"><a href="sign.jsp">Sign In</a></li>
            <li class="shape-circle circle-three"><a href="About.jsp">About Us</a></li>
            <li class="shape-circle circle-five"><a href="index.jsp">Home</a></li>
        </ul>
    </nav>
    <article class="container">
        <h1>OOPS<br>AN<br><br><br>occur</h1>
    </article>
</div>

<script>
    var bars = document.getElementById("nav-action");
    var nav = document.getElementById("nav");
    bars.addEventListener("click", barClicked, false);
    function barClicked() {
        bars.classList.toggle('active');
        nav.classList.toggle('visible');
    }
</script>
</body>
</html>
```

### 6l. admin.jsp — Admin Panel (Cyberpunk)

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background: #0a0a0f;
            color: #00ff88;
            font-family: 'Courier New', monospace;
            padding: 40px;
            min-height: 100vh;
        }
        h1 {
            text-align: center;
            font-size: 28px;
            text-transform: uppercase;
            letter-spacing: 6px;
            color: #ff00ff;
            text-shadow: 0 0 20px #ff00ff, 0 0 60px #ff00ff44;
            margin-bottom: 40px;
            border-bottom: 2px solid #ff00ff44;
            padding-bottom: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: #0d0d1a;
            border: 1px solid #00ff8844;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 0 30px #00ff8822;
        }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a1a2e; color: #ff00ff; text-transform: uppercase; letter-spacing: 2px; padding: 14px 10px; border-bottom: 2px solid #ff00ff; text-align: left; }
        td { padding: 12px 10px; border-bottom: 1px solid #00ff8822; color: #00ff88; }
        tr:hover td { background: #00ff8808; color: #ffffff; }
        .empty { text-align: center; padding: 60px; color: #ff00ff88; font-size: 18px; letter-spacing: 3px; }
        .error { text-align: center; padding: 20px; color: #ff0044; border: 1px solid #ff0044; border-radius: 4px; background: #ff004411; }
        .glow { display: inline-block; margin-bottom: 20px; font-size: 12px; color: #00ff8844; letter-spacing: 2px; }
    </style>
</head>
<body>
    <h1>Admin Panel</h1>
    <div class="container">
        <div class="glow">// EMPLOYEE DATABASE //</div>

        <%
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rst = null;
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:employees.db");
            if (conn != null) {
                String query = "SELECT * FROM esp";
                pst = conn.prepareStatement(query);
                rst = pst.executeQuery();
                if (rst.next()) {
                    out.println("<table><thead><tr>");
                    out.println("<th>First-Name</th><th>Last-Name</th><th>Gender</th><th>Telephone</th><th>E-Mail</th><th>Password</th><th>Domain</th>");
                    out.println("</tr></thead><tbody>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rst.getString(2) + "</td>");
                        out.println("<td>" + rst.getString(3) + "</td>");
                        out.println("<td>" + rst.getString(4) + "</td>");
                        out.println("<td>" + rst.getString(5) + "</td>");
                        out.println("<td>" + rst.getString(6) + "</td>");
                        out.println("<td>" + rst.getString(7) + "</td>");
                        out.println("<td>" + rst.getString(8) + "</td>");
                        out.println("</tr>");
                    } while (rst.next());
                    out.println("</tbody></table>");
                } else {
                    out.println("<div class='empty'>// NO RECORDS FOUND //</div>");
                }
            }
        } catch (Exception e) {
            out.println("<div class='error'>! EXCEPTION: " + e.getMessage() + "</div>");
        } finally {
            try { if (rst != null) rst.close(); if (pst != null) pst.close(); if (conn != null) conn.close(); }
            catch (Exception e) { out.println("<div class='error'>! CLOSE ERROR: " + e.getMessage() + "</div>"); }
        }
        %>
    </div>
</body>
</html>
```

### 6m. employee-list.jsp — Employee CRUD List

```jsp
<%@ page session="false" %>
<%@ page import="java.util.List, com.example.demo1.Employee" %>
<html>
<body>
<h2>Employee List</h2>
<a href="employee-form.jsp">Add Employee</a>
<table border="1">
<tr><th>ID</th><th>Name</th><th>Department</th><th>Email</th><th>Salary</th><th>Actions</th></tr>
<%
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
    if (employees != null) {
        for (Employee emp : employees) {
%>
<tr>
    <td><%= emp.getId() %></td>
    <td><%= emp.getName() %></td>
    <td><%= emp.getDepartment() %></td>
    <td><%= emp.getEmail() %></td>
    <td><%= emp.getSalary() %></td>
    <td>
        <a href="employees?action=edit&id=<%= emp.getId() %>">Edit</a>
        <a href="employees?action=delete&id=<%= emp.getId() %>">Delete</a>
    </td>
</tr>
<%
        }
    }
%>
</table>
</body>
</html>
```

### 6n. employee-form.jsp — Employee CRUD Form

```jsp
<%@ page session="false" %>
<%@ page import="com.example.demo1.Employee" %>
<html>
<body>
<%
    Employee emp = (Employee) request.getAttribute("employee");
    boolean isEdit = emp != null;
%>
<h2><%= isEdit ? "Edit Employee" : "Add Employee" %></h2>
<form action="employees" method="post">
    <% if (isEdit) { %>
        <input type="hidden" name="id" value="<%= emp.getId() %>">
    <% } %>
    Name: <input type="text" name="name" value="<%= isEdit ? emp.getName() : "" %>" required><br>
    Department: <input type="text" name="department" value="<%= isEdit ? emp.getDepartment() : "" %>" required><br>
    Email: <input type="email" name="email" value="<%= isEdit ? emp.getEmail() : "" %>" required><br>
    Salary: <input type="number" step="0.01" name="salary" value="<%= isEdit ? emp.getSalary() : "" %>" required><br>
    <input type="submit" value="<%= isEdit ? "Update" : "Save" %>">
    <a href="employees">Cancel</a>
</form>
</body>
</html>
```

---

## Step 7 — Create CSS Files

### 7a. style.css (in WebContent/)

```css
* { margin: 0; padding: 0; }
body {
    position: relative;
    background: url('https://cdn.dribbble.com/users/113132/screenshots/18444004/media/3e198c3ce01041ce892dea3261d7c10c.gif') no-repeat center center fixed;
    background-size: cover;
    min-width: 500px; min-height: 200px;
    color: #fff; font-family: 'Montserrat'; height: 100vmax;
}
.bars { position: absolute; width: 27px; height: 27px; top: 30px; right: 30px; cursor: pointer; z-index: 101; padding-top: 9px; }
.bar { width: 100%; height: 4px; background-color: #fff; position: absolute; }
span::before, span::after { content: ""; display: block; background-color: #fff; width: 100%; height: 4px; position: absolute; }
.bar::before { transform: translateY(-9px); }
.bar::after { transform: translateY(9px); }
.bars.active .bar { background-color: transparent; }
.bars.active span::before { animation: top-bar 1s; animation-fill-mode: forwards; }
.bars.active span::after { animation: bottom-bar 1s; animation-fill-mode: forwards; }
#nav { position: absolute; top: 0; bottom: 0; left: 0; right: 0; transition: all 1s; z-index: -1; overflow: hidden; opacity: 0; }
#nav a { color: #fff; text-decoration: none; line-height: 70vw; font-size: 30px; position: absolute; top: 0; bottom: 0; left: 0; right: 0; text-indent: 50vw; border-radius: 50%; transition: all .5s; }
#nav a:hover { background: #6f44efdc; }
ul { list-style: none; }
.visible { z-index: 100 !important; opacity: 1 !important; }
.shape-circle { border-radius: 50%; width: 20vw; height: 20vw; top: -10vw; right: -10vw; position: absolute; transition: all 1s ease-in-out; background: #0acb7bb9; box-shadow: 0 0px 0px rgba(4, 26, 62, 0.5); }
nav.visible li:first-child { width: 200vw; height: 200vw; top: -100vw; right: -100vw; z-index: 5; transition: all .5s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:nth-child(2) { width: 150vw; height: 150vw; top: -75vw; right: -75vw; z-index: 6; transition: all .6s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:nth-child(3) { width: 100vw; height: 100vw; top: -50vw; right: -50vw; z-index: 7; transition: all .7s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:last-child { width: 50vw; height: 50vw; top: -25vw; right: -25vw; z-index: 8; transition: all .8s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:first-child a { line-height: 265vw !important; text-indent: 15vw !important; }
nav.visible li:nth-child(2) a { line-height: 200vw !important; text-indent: 17vw !important; }
nav.visible li:nth-child(3) a { line-height: 137vw !important; text-indent: 17vw !important; }
nav.visible li:last-child a { line-height: 70vw !important; text-indent: 12vw !important; }
.container { display: flex; flex-direction: column; justify-content: center; text-align: center; }
h1 { font-size: 120px; text-shadow: 0 56px 40px rgba(0, 0, 0, 5.19), 0 8px 26px rgba(0, 0, 0, 3.23); text-transform: uppercase; letter-spacing: 5px; padding-top: 40px; }
article p { padding-bottom: 15px; font-size: 24px; font-weight: bold; text-shadow: 0 12px 22px rgba(0, 0, 18, 3.12), 0 6px 13px rgba(0, 0, 0, 5.24); }
article a { color: #fff; text-decoration: none; opacity: .2; font-size: 12px; }
article a:hover { opacity: .8; }
@keyframes top-bar { 50% { transform: translateY(0); } 100% { transform: rotate(45deg) translateY(0); } }
@keyframes bottom-bar { 50% { transform: translateY(0); } 100% { transform: rotate(-45deg) translateY(0); } }
@media screen and (max-width:800px) { h1 { padding-top: 80px; font-size: 60px; } }
```

### 7b. style1.css (in WebContent/)

```css
* { margin: 0; padding: 0; }
body {
    position: relative;
    background: url('https://cdn.dribbble.com/userupload/21137239/file/original-4e9d1dc983be55ffebaeddd765915c2e.gif') no-repeat center center fixed;
    background-size: cover;
    min-width: 500px; min-height: 200px;
    color: #fff; font-family: 'Montserrat'; height: 100vmax;
}
.bars { position: absolute; width: 27px; height: 27px; top: 30px; right: 30px; cursor: pointer; z-index: 101; padding-top: 9px; }
.bar { width: 100%; height: 4px; background-color: #fff; position: absolute; }
span::before, span::after { content: ""; display: block; background-color: #fff; width: 100%; height: 4px; position: absolute; }
.bar::before { transform: translateY(-9px); }
.bar::after { transform: translateY(9px); }
.bars.active .bar { background-color: transparent; }
.bars.active span::before { animation: top-bar 1s; animation-fill-mode: forwards; }
.bars.active span::after { animation: bottom-bar 1s; animation-fill-mode: forwards; }
#nav { position: absolute; top: 0; bottom: 0; left: 0; right: 0; transition: all 1s; z-index: -1; overflow: hidden; opacity: 0; }
#nav a { color: #fff; font-size: 30px; text-decoration: none; line-height: 70vw; position: absolute; top: 0; bottom: 0; left: 0; right: 0; text-indent: 50vw; border-radius: 50%; transition: all .5s; }
#nav a:hover { background: #6f44efdc; }
ul { list-style: none; }
.visible { z-index: 100 !important; opacity: 1 !important; }
.shape-circle { border-radius: 50%; width: 20vw; height: 20vw; top: -10vw; right: -10vw; position: absolute; transition: all 1s ease-in-out; background: #0acb7bb9; box-shadow: 0 0px 0px rgba(4, 26, 62, 0.5); }
nav.visible li:first-child { width: 200vw; height: 200vw; top: -100vw; right: -100vw; z-index: 5; transition: all .5s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:nth-child(2) { width: 150vw; height: 150vw; top: -75vw; right: -75vw; z-index: 6; transition: all .6s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:nth-child(3) { width: 100vw; height: 100vw; top: -50vw; right: -50vw; z-index: 7; transition: all .7s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:last-child { width: 50vw; height: 50vw; top: -25vw; right: -25vw; z-index: 8; transition: all .8s ease-in-out; box-shadow: 0 0px 80px rgba(4, 26, 62, 0.5); }
nav.visible li:first-child a { line-height: 265vw !important; text-indent: 15vw !important; }
nav.visible li:nth-child(2) a { line-height: 200vw !important; text-indent: 17vw !important; }
nav.visible li:nth-child(3) a { line-height: 137vw !important; text-indent: 17vw !important; }
nav.visible li:last-child a { line-height: 70vw !important; text-indent: 12vw !important; }
.container { display: flex; flex-direction: column; justify-content: center; text-align: center; }
h1 { font-size: 120px; text-shadow: 0 56px 40px rgba(0, 0, 0, 5.19), 0 8px 26px rgba(0, 0, 0, 3.23); text-transform: uppercase; letter-spacing: 5px; padding-top: 40px; }
article p { padding-bottom: 15px; font-size: 24px; font-weight: bold; text-shadow: 0 12px 22px rgba(0, 0, 18, 3.12), 0 6px 13px rgba(0, 0, 0, 5.24); }
article a { color: #fff; text-decoration: none; opacity: .2; font-size: 35px; }
article a:hover { opacity: .8; }
@keyframes top-bar { 50% { transform: translateY(0); } 100% { transform: rotate(45deg) translateY(0); } }
@keyframes bottom-bar { 50% { transform: translateY(0); } 100% { transform: rotate(-45deg) translateY(0); } }
@media screen and (max-width:800px) { h1 { padding-top: 80px; font-size: 60px; } }
```

---

## Step 8 — Update web.xml

Open `WebContent/WEB-INF/web.xml` and replace its content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
</web-app>
```

That's it — no servlet mappings needed because we use `@WebServlet` and `@WebListener` annotations.

---

## Step 9 — How the Database Gets Created

You do NOT create `employees.db` manually. Here's the flow:

1. Tomcat starts and loads your app
2. `DatabaseInitializer.java` (annotated `@WebListener`) runs automatically
3. It calls `DatabaseUtil.initializeDatabase()`
4. That method runs `CREATE TABLE IF NOT EXISTS` for both tables
5. SQLite creates the `employees.db` file automatically in Tomcat's `bin/` directory
6. All JSPs connect using `jdbc:sqlite:employees.db`

If you ever get a "no such table" error, just **delete `employees.db`** and restart Tomcat — the tables will be recreated.

---

## Step 10 — Run the Project

1. **Right-click project → Run As → Run on Server**
2. Select your Tomcat server
3. Click **Finish**
4. Browser will open at `http://localhost:8080/EmployeeManagementSystem/`

### Available URLs

| URL | What it does |
|-----|-------------|
| `/EmployeeManagementSystem/` | Landing page with domain cards |
| `/EmployeeManagementSystem/employees` | Employee CRUD list |
| `/EmployeeManagementSystem/reg.jsp?room=IOT` | Register for IOT domain |
| `/EmployeeManagementSystem/sign.jsp` | Login page |
| `/EmployeeManagementSystem/dashboard.jsp?gmail=...` | User dashboard |
| `/EmployeeManagementSystem/admin.jsp` | Admin panel (all records) |
| `/EmployeeManagementSystem/error.jsp` | Error page |

---

## Database File Location

When running in Eclipse with Tomcat, `employees.db` is created in:

```
{workspace}/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/EmployeeManagementSystem/
```

Or in Tomcat's `bin/` directory depending on your server config. If you can't find it, search for `employees.db` in your workspace.

---

## Summary

| File | Type | Purpose |
|------|------|---------|
| Employee.java | Java Bean | Employee model (id, name, department, email, salary) |
| DatabaseUtil.java | Utility | SQLite connection + table creation |
| DatabaseInitializer.java | Listener | Runs table creation on app startup |
| EmployeeServlet.java | Servlet | CRUD operations at `/employees` |
| index.jsp | JSP | Home page with domain selection cards |
| reg.jsp | JSP | Registration form |
| register.jsp | JSP | Insert into `esp` table |
| sign.jsp | JSP | Login form with cookie prefill |
| check.jsp | JSP | Validate credentials |
| dashboard.jsp | JSP | Show logged-in user info |
| update.jsp | JSP | Edit profile form (prefilled) |
| upd.jsp | JSP | Execute profile update |
| delete.jsp | JSP | Delete user from `esp` |
| logout.jsp | JSP | Redirect to index |
| error.jsp | JSP | Login failure page |
| admin.jsp | JSP | Admin panel — cyberpunk table |
| employee-list.jsp | JSP | Employee CRUD list |
| employee-form.jsp | JSP | Employee add/edit form |
| style.css | CSS | Animated navigation styles |
| style1.css | CSS | Dashboard variant styles |
| web.xml | XML | Web descriptor (minimal) |
| sqlite-jdbc.jar | Library | SQLite JDBC driver (in WEB-INF/lib) |
