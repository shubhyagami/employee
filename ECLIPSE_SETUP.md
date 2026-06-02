# Eclipse Setup Guide (No Maven | Manual sqlite.jar)

## Prerequisites
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat (8 or 9) configured in Eclipse
- sqlite-jdbc.jar downloaded from https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.45.1.0/sqlite-jdbc-3.45.1.0.jar

---

## Step 1: Create Dynamic Web Project

1. **File → New → Dynamic Web Project**
2. Enter project name: `EmployeeManagementSystem`
3. **Target Runtime**: Select your Tomcat server (if not listed, configure it in Servers view)
4. **Configuration**: Default Configuration for Apache Tomcat
5. Check **Generate web.xml deployment descriptor**
6. Click **Finish**

---

## Step 2: Add sqlite-jdbc.jar

1. Create a folder `WEB-INF/lib` inside `src/main/webapp` (or just `WebContent/WEB-INF/lib` depending on Eclipse version)
2. Copy the downloaded `sqlite-jdbc-3.45.1.0.jar` into that folder
3. **Right-click the JAR → Build Path → Add to Build Path**

*(The JAR goes in WEB-INF/lib so it's deployed with the app — no need to modify Tomcat's lib folder)*

---

## Step 3: Create Package and Java Classes

### 3a. Create the package
- **Right-click `src/` → New → Package**
- Name: `com.example.demo1`

### 3b. Employee.java (Model)
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
        this.id = id; this.name = name; this.department = department;
        this.email = email; this.salary = salary;
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

### 3c. DatabaseUtil.java
```java
package com.example.demo1;

import java.sql.*;

public class DatabaseUtil {
    private static final String URL = "jdbc:sqlite:" + 
        System.getProperty("catalina.base") + "/webapps/employees.db";

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

### 3d. DatabaseInitializer.java
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
    public void contextDestroyed(ServletContextEvent sce) {}
}
```

### 3e. EmployeeServlet.java
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
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM employees ORDER BY id")) {
            while (rs.next())
                list.add(new Employee(rs.getInt("id"), rs.getString("name"),
                    rs.getString("department"), rs.getString("email"), rs.getDouble("salary")));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private Employee getEmployee(int id) {
        String sql = "SELECT * FROM employees WHERE id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return new Employee(rs.getInt("id"), rs.getString("name"),
                    rs.getString("department"), rs.getString("email"), rs.getDouble("salary"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private void addEmployee(String name, String department, String email, double salary) {
        String sql = "INSERT INTO employees (name, department, email, salary) VALUES (?,?,?,?)";
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
            pstmt.setString(3, email); pstmt.setDouble(4, salary); pstmt.setInt(5, id);
            pstmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private void deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id); pstmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
```

---

## Step 4: Create JSP Files

### 4a. employee-list.jsp
Create in `WebContent/` (or `src/main/webapp/`):
```jsp
<%@ page session="false" %>
<%@ page import="java.util.List, com.example.demo1.Employee" %>
<html>
<body>
<h2>Employee List</h2>
<a href="employee-form.jsp">Add Employee</a>
<table border="1">
<tr><th>ID</th><th>Name</th><th>Department</th><th>Email</th><th>Salary</th><th>Actions</th></tr>
<% for (Employee emp : (List<Employee>) request.getAttribute("employees")) { %>
<tr>
    <td><%= emp.getId() %></td><td><%= emp.getName() %></td>
    <td><%= emp.getDepartment() %></td><td><%= emp.getEmail() %></td>
    <td><%= emp.getSalary() %></td>
    <td><a href="employees?action=edit&id=<%= emp.getId() %>">Edit</a>
        <a href="employees?action=delete&id=<%= emp.getId() %>">Delete</a></td>
</tr>
<% } %>
</table>
</body>
</html>
```

### 4b. employee-form.jsp
```jsp
<%@ page session="false" %>
<%@ page import="com.example.demo1.Employee" %>
<html>
<body>
<% Employee emp = (Employee) request.getAttribute("employee"); %>
<h2><%= emp != null ? "Edit Employee" : "Add Employee" %></h2>
<form action="employees" method="post">
    <% if (emp != null) { %>
        <input type="hidden" name="id" value="<%= emp.getId() %>">
    <% } %>
    Name: <input type="text" name="name" value="<%= emp != null ? emp.getName() : "" %>"><br>
    Department: <input type="text" name="department" value="<%= emp != null ? emp.getDepartment() : "" %>"><br>
    Email: <input type="email" name="email" value="<%= emp != null ? emp.getEmail() : "" %>"><br>
    Salary: <input type="number" step="0.01" name="salary" value="<%= emp != null ? emp.getSalary() : "" %>"><br>
    <input type="submit" value="Save">
</form>
<a href="employees">Back</a>
</body>
</html>
```

---

## Step 5: Run on Tomcat

1. **Right-click project → Run As → Run on Server**
2. Select your configured Tomcat server
3. Click **Finish**
4. Access at: `http://localhost:8080/EmployeeManagementSystem/employees`

---

## Key Differences from Maven Version

| Aspect           | Maven Version                     | Eclipse Manual Version           |
|------------------|-----------------------------------|----------------------------------|
| Dependencies     | Auto-downloaded via `pom.xml`     | JAR manually placed in WEB-INF/lib|
| sqlite-jdbc.jar  | Declared in pom.xml               | Downloaded & copied manually     |
| Servlet API      | `provided` scope (from Tomcat)    | Provided by Tomcat runtime       |
| DB location      | Project root (`employees.db`)     | Tomcat's webapps folder          |
| Run command      | `mvn tomcat7:run`                 | Right-click → Run on Server      |

## sqlite.jar Download

Download `sqlite-jdbc-3.45.1.0.jar` and place it in `WebContent/WEB-INF/lib/`:

**URL**: https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.45.1.0/sqlite-jdbc-3.45.1.0.jar
