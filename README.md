# Employee Management System

![Java](https://img.shields.io/badge/Java-8-blue) 
![Servlet](https://img.shields.io/badge/Servlet-4.0.1-orange) 
![SQLite](https://img.shields.io/badge/SQLite-3.45.1.0-green) 
![Maven](https://img.shields.io/badge/Maven-3%2B-red) 
![Tomcat](https://img.shields.io/badge/Tomcat-7-important) 
![License](https://img.shields.io/badge/License-MIT-yellow)

A Java Servlet-based employee management web app using SQLite for data storage. No external database server required.

## Tech Stack

| Component          | Technology                     |
|--------------------|--------------------------------|
| Language           | Java 8                         |
| Web Framework      | Java Servlet (javax.servlet)   |
| Database           | SQLite                         |
| Build Tool         | Maven 3+                       |
| Server             | Tomcat 7 (embedded via plugin) |
| Frontend           | JSP, HTML, CSS                 |

## Project Structure

```
EmployeeManagementSystem/
├── pom.xml                          # Maven config with dependencies
├── mvnw / mvnw.cmd                  # Maven wrapper scripts
├── .gitignore
├── README.md
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/demo1/
│       │       ├── Employee.java           # Employee model
│       │       ├── EmployeeServlet.java    # CRUD servlet (/employees)
│       │       ├── DatabaseUtil.java       # SQLite connection & table init
│       │       └── DatabaseInitializer.java# Auto-runs table creation on startup
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                 # Web app descriptor
│           ├── index.jsp                   # Landing page
│           ├── reg.jsp                     # Registration form
│           ├── register.jsp                # Registration action (SQL insert)
│           ├── sign.jsp                    # Login form
│           ├── check.jsp                   # Login action (auth check)
│           ├── dashboard.jsp               # User dashboard
│           ├── update.jsp                  # Edit profile form
│           ├── upd.jsp                     # Edit profile action
│           ├── delete.jsp                  # Delete profile
│           ├── logout.jsp                  # Logout redirect
│           ├── error.jsp                   # Error page
│           ├── admin.jsp                   # Admin panel (view all users)
│           ├── style.css                   # Stylesheet
│           └── style1.css                  # Additional styles
│
└── employees.db        # SQLite database (auto-created, gitignored)
```

## External Dependencies

All managed automatically via Maven (`pom.xml`):

| Dependency            | Version   | Purpose                    |
|-----------------------|-----------|----------------------------|
| javax.servlet-api     | 4.0.1     | Servlet API (provided by Tomcat at runtime) |
| sqlite-jdbc           | 3.45.1.0  | SQLite JDBC driver         |
| junit-jupiter         | 5.10.2    | Unit testing               |
| tomcat7-maven-plugin  | 2.2       | Embedded Tomcat for dev    |
| maven-war-plugin      | 3.3.2     | WAR packaging              |

## Database Schema

Two tables are auto-created when the app starts:

### `employees` table (used by EmployeeServlet CRUD)
```sql
CREATE TABLE emplo
```
> *Note: The full schema is generated dynamically. The `emplo` table stores employee records with fields like ID, name, email, department, etc.*

---

## Quick Start Guide

Get the application running in three steps:

### 1. Clone and Build
```bash
git clone https://github.com/shubhyagami/EmployeeManagementSystem.git
cd EmployeeManagementSystem
mvn clean package
```

### 2. Run with Embedded Tomcat
```bash
mvn tomcat7:run
```
The application will start at `http://localhost:8080/employee`.

### 3. Use the App
- **Register** a new user via `/reg.jsp`
- **Log in** at `/sign.jsp`
- **Manage employees** (CRUD) via `/employees` (accessible after login)
- **Admin panel** at `/admin.jsp` (requires admin role)

> 💡 **Pro Tip:** The database file `employees.db` is created automatically in the project root. Delete it to reset all data.

---

## Weekly Highlight – 2026-07-30

✨ **This week's focus:** Improved session management and added role-based access control. The `admin.jsp` page now lists all registered users, and the login flow validates against both `employees` and `users` tables. Next up: password hashing and input sanitization.

---

## Motivational Quote

> *"The best way to predict the future is to create it." – Peter Drucker*  
> Keep building, keep improving. Every line of code brings you closer to mastery.