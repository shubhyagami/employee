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
    public void init() {
        DatabaseUtil.initializeDatabase();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Employee emp = getEmployee(id);
            request.setAttribute("employee", emp);
            request.getRequestDispatcher("employee-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            deleteEmployee(id);
            response.sendRedirect("employees");
        } else {
            List<Employee> employees = getAllEmployees();
            request.setAttribute("employees", employees);
            request.getRequestDispatcher("employee-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("department"),
                    rs.getString("email"),
                    rs.getDouble("salary")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Employee getEmployee(int id) {
        String sql = "SELECT * FROM employees WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Employee(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("department"),
                        rs.getString("email"),
                        rs.getDouble("salary")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private void addEmployee(String name, String department, String email, double salary) {
        String sql = "INSERT INTO employees (name, department, email, salary) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, department);
            pstmt.setString(3, email);
            pstmt.setDouble(4, salary);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateEmployee(int id, String name, String department, String email, double salary) {
        String sql = "UPDATE employees SET name=?, department=?, email=?, salary=? WHERE id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, department);
            pstmt.setString(3, email);
            pstmt.setDouble(4, salary);
            pstmt.setInt(5, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE id=?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
