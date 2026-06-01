<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        th {
            background: #1a1a2e;
            color: #ff00ff;
            text-transform: uppercase;
            letter-spacing: 2px;
            padding: 14px 10px;
            border-bottom: 2px solid #ff00ff;
            text-align: left;
        }
        td {
            padding: 12px 10px;
            border-bottom: 1px solid #00ff8822;
            color: #00ff88;
        }
        tr:hover td {
            background: #00ff8808;
            color: #ffffff;
        }
        .empty {
            text-align: center;
            padding: 60px;
            color: #ff00ff88;
            font-size: 18px;
            letter-spacing: 3px;
        }
        .error {
            text-align: center;
            padding: 20px;
            color: #ff0044;
            border: 1px solid #ff0044;
            border-radius: 4px;
            background: #ff004411;
        }
        .glow {
            display: inline-block;
            margin-bottom: 20px;
            font-size: 12px;
            color: #00ff8844;
            letter-spacing: 2px;
        }
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
                    out.println("<table>");
                    out.println("<thead><tr>");
                    out.println("<th>First-Name</th>");
                    out.println("<th>Last-Name</th>");
                    out.println("<th>Gender</th>");
                    out.println("<th>Telephone</th>");
                    out.println("<th>E-Mail</th>");
                    out.println("<th>Password</th>");
                    out.println("<th>Domain</th>");
                    out.println("</tr></thead>");
                    out.println("<tbody>");
                    
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
            try {
                if (rst != null) rst.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                out.println("<div class='error'>! CLOSE ERROR: " + e.getMessage() + "</div>");
            }
        }
        %>
    </div>
</body>
</html>
