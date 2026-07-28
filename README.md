# Employee Management System

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

## Changelog

### 2026-07-29 – Version 1.0.0 Release

- **Initial release** of the Employee Management System.
- Core CRUD operations for employee records (Create, Read, Update, Delete).
- SQLite embedded database – zero external setup.
- User authentication with registration, login, and session management.
- Admin panel for viewing all registered employees.
- Responsive JSP frontend with two custom stylesheets.
- Built with Maven + embedded Tomcat for easy local development.

---

## Pro Tips 💡

- **Running the app:** Use `mvn tomcat7:run` from the project root. The app will be available at `http://localhost:8080/employees`.
- **Database location:** The `employees.db` file is created in the project root directory. Delete it to reset all data (the tables are recreated on next startup).
- **Customizing the schema:** Modify the `CREATE TABLE` statements in `DatabaseInitializer.java` before the first run – changes won’t affect an existing database file.
- **Admin credentials:** No pre‑defined admin – any registered user can be promoted to admin by manually updating the `role` column in the `employees` table (or by extending the login logic).
- **Testing with cURL:**
  ```bash
  # List all employees (GET)
  curl http://localhost:8080/employees

  # Add an employee (POST)
  curl -X POST -d "name=Jane&email=jane@example.com&department=Engineering" http://localhost:8080/employees
  ```

---

## Quick Start 🚀

1. **Prerequisites:** Java 8, Maven 3+, Git.
2. **Clone the repository:**
   ```bash
   git clone https://github.com/shubhyagami/EmployeeManagementSystem.git
   cd EmployeeManagementSystem
   ```
3. **Start the embedded Tomcat server:**
   ```bash
   mvn tomcat7:run
   ```
4. **Open your browser** and go to `http://localhost:8080/employees`.
5. **Register an account** via the `/reg.jsp` page, then log in to access the dashboard.

---

*Made with ☕ and SQLite by shubhyagami – TVA Temporal Engineering Division*