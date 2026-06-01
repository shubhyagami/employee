package com.example.demo1;

import java.sql.*;

public class DatabaseUtil {
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
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(empTable);
            stmt.execute(espTable);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
