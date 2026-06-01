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
CREATE TABLE employees (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    department  TEXT NOT NULL,
    email       TEXT NOT NULL,
    salary      REAL NOT NULL
);
```

### `esp` table (used by JSP registration flow)
```sql
CREATE TABLE esp (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    gender      TEXT NOT NULL,
    telephone   TEXT NOT NULL,
    email       TEXT NOT NULL,
    password    TEXT NOT NULL,
    domain      TEXT NOT NULL
);
```

## Setup & Run

### Prerequisites
- Java 8 or higher installed (`java -version`)
- Git installed

### Steps

```bash
# 1. Clone the repo
git clone https://github.com/shubhyagami/employee.git
cd employee

# 2. Run with embedded Tomcat (no Tomcat install needed)
mvnw tomcat7:run
```

On first run, the app will:
- Download all Maven dependencies
- Start Tomcat 7 on port 8080
- Create `employees.db` in the project root
- Create both database tables

### Access the app

| URL                                           | Description            |
|-----------------------------------------------|------------------------|
| http://localhost:8080/demo1/                  | Landing page           |
| http://localhost:8080/demo1/employees         | Employee CRUD list     |
| http://localhost:8080/demo1/reg.jsp           | Registration form      |
| http://localhost:8080/demo1/sign.jsp          | Login                  |
| http://localhost:8080/demo1/dashboard.jsp     | User dashboard         |
| http://localhost:8080/demo1/admin.jsp         | Admin panel            |

## How It Works

### Employee CRUD (`/employees`)

1. **`EmployeeServlet.java`** handles `GET` and `POST` requests to `/employees`
2. Uses `DatabaseUtil.getConnection()` for SQLite access
3. **List**: `GET /employees` → queries all rows → forwards to `employee-list.jsp`
4. **Add**: form submits `POST /employees` → inserts into `employees` table → redirects to list
5. **Edit**: `GET /employees?action=edit&id=N` → fetches one row → forwards to `employee-form.jsp`
6. **Update**: form submits `POST /employees` with `id` → updates row → redirects to list
7. **Delete**: `GET /employees?action=delete&id=N` → deletes row → redirects to list

### User Registration Flow

1. Landing page (`index.jsp`) shows department cards (IOT, Cloud, Transport, ITIS)
2. Clicking a card goes to `reg.jsp?room=<department>` with a registration form
3. Form submits to `register.jsp` which inserts into `esp` table using SQLite
4. After registration, user is redirected to `sign.jsp` to log in
5. `check.jsp` validates credentials against the `esp` table
6. On success, redirects to `dashboard.jsp` showing user info
7. User can update or delete their profile

### Session Handling

This app does **not** use `HttpSession`. Login state is maintained via cookies. No server-side session storage.

## Key Code Snippets

### SQLite Connection
```java
Class.forName("org.sqlite.JDBC");
Connection conn = DriverManager.getConnection("jdbc:sqlite:employees.db");
```

### Database Initialization (runs on startup)
```java
@WebListener
public class DatabaseInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DatabaseUtil.initializeDatabase();
    }
}
```

### Employee Servlet (GET handler)
```java
@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            // fetch single employee and forward to form
        } else if ("delete".equals(action)) {
            // delete and redirect
        } else {
            // list all employees
            request.setAttribute("employees", getAllEmployees());
            request.getRequestDispatcher("employee-list.jsp").forward(request, response);
        }
    }
}
```

## Troubleshooting

| Problem                     | Solution                                                              |
|-----------------------------|-----------------------------------------------------------------------|
| Port 8080 already in use    | Change port in `pom.xml` under `tomcat7-maven-plugin` configuration   |
| "no such table" error       | Delete `employees.db` and restart — tables are auto-created           |
| ClassNotFoundException      | Run `mvnw clean` then `mvnw tomcat7:run` to redownload dependencies   |
| Permission denied (Linux)   | Run `chmod +x mvnw` to make the Maven wrapper executable              |

## IntelliJ IDEA Setup

1. Open IntelliJ → `File` → `Open` → select the project folder
2. IntelliJ will auto-detect the Maven project
3. Open `pom.xml` and click "Load Maven Project" if prompted
4. To run: open the Maven tool window → `Plugins` → `tomcat7` → `tomcat7:run`
   - Or create a Run Configuration: `+` → `Maven` → set `Run` to `tomcat7:run`
5. Access at `http://localhost:8080/demo1/`
