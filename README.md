# Employee Management System

![Java](https://img.shields.io/badge/Java-8-blue)
![Servlet](https://img.shields.io/badge/Servlet-4.0.1-orange)
![SQLite](https://img.shields.io/badge/SQLite-3.45.1.0-green)
![Maven](https://img.shields.io/badge/Maven-3%2B-red)
![Tomcat](https://img.shields.io/badge/Tomcat-7-important)
![License](https://img.shields.io/badge/License-MIT-yellow)

A Java Servlet-based web application for managing employee records. It uses an embedded SQLite database for storage, meaning no external database setup is required to run the project locally.

## Features

- **User Authentication:** Basic user registration and login system.
- **Employee CRUD:** Create, read, update, and delete employee records via the `/employees` endpoint.
- **Embedded Database:** SQLite auto-initializes the required schema on application startup.
- **Local Development:** Runs entirely via the embedded Tomcat Maven plugin.

## Tech Stack

| Component     | Technology                     |
|---------------|--------------------------------|
| Language      | Java 8                         |
| Web Framework | Java Servlet (javax.servlet)   |
| Database      | SQLite                         |
| Build Tool    | Maven 3+                       |
| Server        | Tomcat 7 (embedded via plugin) |
| Frontend      | JSP, HTML, CSS                 |

## Project Structure

```text
employee/
├── pom.xml                           # Maven config and dependencies
├── mvnw / mvnw.cmd                   # Maven wrapper scripts
├── .gitignore
├── README.md
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/demo1/
│       │       ├── Employee.java            # Employee model
│       │       ├── EmployeeServlet.java     # CRUD servlet (/employees)
│       │       ├── DatabaseUtil.java        # SQLite connection & table init
│       │       └── DatabaseInitializer.java # Auto-runs table creation on startup
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                  # Web app descriptor
│           ├── index.jsp                    # Landing page
│           ├── reg.jsp                      # Registration form
│           ├── register.jsp                 # Registration action (SQL insert)
│           ├── sign.jsp                     # Login form
│           └── check.jsp                    # Login action (auth check)
```

## Getting Started

### Prerequisites

- Java 8 JDK
- Maven 3+
- Git

### Setup & Running

1. **Clone the repository**
   ```bash
   git clone https://github.com/shubhyagami/employee.git
   cd employee
   ```

2. **Build the project**
   ```bash
   mvn clean package
   ```

3. **Run with embedded Tomcat**
   ```bash
   mvn tomcat7:run
   ```
   Once started, the application will be available at `http://localhost:8080/EmployeeManagementSystem/`.

4. **Access the app**
   - Open the landing page in your browser.
   - Register a new user via `reg.jsp`.
   - Log in via `sign.jsp`.
   - Manage employees through the servlet at `/employees`.

## Developer Notes

- **SQLite Concurrency:** SQLite is a single-writer database. Avoid running concurrent write operations from multiple browser tabs simultaneously to prevent database locking.
- **Session Management:** Login uses a simple `user` session attribute. For production, implement a proper authentication filter.
- **Debugging:** Enable Tomcat’s HTTP logging or check `catalina.out` for stack traces and exceptions.
- **Extending the Model:** To add fields, update `Employee.java`, the SQLite schema in `DatabaseUtil.java`, and the corresponding JSP forms.

## Contributing

1. Fork the repository.
2. Create a feature branch (e.g., `feature/add-employee-search`).
3. Commit your changes with clear, descriptive messages.
4. Open a pull request describing your changes.

## Changelog

| Date       | Description                                                  |
|------------|--------------------------------------------------------------|
| 2026-08-20 | Dropped redundant changelog entries; streamlined developer notes |
| 2026-08-12 | README cleanup: improved structure and developer notes       |
| 2026-08-10 | README cleanup: polished grammar, formatting, and structure |
| 2026-08-05 | Fixed minor JSP rendering anomaly on `reg.jsp`              |

## License

This project is licensed under the MIT License.
