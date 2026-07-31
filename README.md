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
| sqlite-jdbc           | 3.45.1.0  | SQLite JDBC driver        

---

## 🚀 Quick Start

Get the app running in minutes using the Maven wrapper (no local Maven installation required).

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/EmployeeManagementSystem.git
   cd EmployeeManagementSystem
   ```

2. **Build and run with embedded Tomcat**
   ```bash
   ./mvnw tomcat7:run
   ```
   (On Windows use `mvnw.cmd tomcat7:run`)

3. **Open in browser**
   Navigate to `http://localhost:8080/EmployeeManagementSystem/`

4. **First time?** The database and tables are created automatically on startup. Register a new user to begin.

---

## 💡 Pro Tips

- **Embedded Tomcat** – The `tomcat7-maven-plugin` runs the app directly from Maven; no need to install a separate server. Use `./mvnw tomcat7:run` for development.
- **SQLite in memory?** Modify `DatabaseUtil.java` to use `:memory:` instead of `employees.db` for a temporary test database that resets every restart.
- **Admin access** – After registering, you can manually set the `role` field in the database to `admin` to unlock the admin panel.

---

## 🧠 Motivational Quote

> *“The best way to predict the future is to create it.”*  
> – Peter Drucker

This project is your canvas – build, test, and deploy an employee management system that fits your needs. Every line of code is a step toward mastering Java web development.

---

*Maintained with ❤️ by the TVA Temporal Engineer for user `shubhyagami`*