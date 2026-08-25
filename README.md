# Employee Management System

![Java](https://img.shields.io/badge/Java-8-blue)
![Servlet](https://img.shields.io/badge/Servlet-4.0.1-orange)
![SQLite](https://img.shields.io/badge/SQLite-3.45.1.0-green)
![Maven](https://img.shields.io/badge/Maven-3%2B-red)
![Tomcat](https://img.shields.io/badge/Tomcat-7-important)
![License](https://img.shields.io/badge/License-MIT-yellow)

A lightweight, Java Servlet-based web application for managing employee records. It utilizes an embedded SQLite database, making it ideal for local development.

## Features

### User Authentication

#### Registration and Login
* A simple user registration and login system allows users to sign up and log in securely.
* Proper authentication filters ensure secure session management in production environments.

### Employee CRUD Operations

* **Create**: Add new employee records using the `/employees` endpoint.
* **Read**: Retrieve existing employee records via the `/employees` endpoint.
* **Update**: Modify existing employee records using the `/employees` endpoint.
* **Delete**: Remove employee records using the `/employees` endpoint.

### Embedded Database

* The embedded SQLite database auto-initializes the required schema on application startup, streamlining development.

### Local Development

* The application uses the embedded Tomcat Maven plugin, eliminating the need for a local server installation.

## Tech Stack

| Component   | Technology        |
|-------------|--------------------|
| Language    | Java 8            |
| Web Framework | Java Servlet (javax.servlet)  |
| Database     | SQLite            |
| Build Tool   | Maven 3+          |
| Server       | Tomcat 7 (embedded via plugin) |
| Frontend     | JSP, HTML, CSS      |

## Project Structure

```text
employee/
├── pom.xml                      # Maven config and dependencies
├── mvnw / mvnw.cmd                # Maven wrapper scripts
├── .gitignore
├── README.md
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/demo1/
│       │       ├── Employee.java      # Employee model
│       │       ├── EmployeeServlet.java # CRUD servlet (/employees)
│       │       ├── DatabaseUtil.java   # SQLite connection & table init
│       │       └── DatabaseInitializer.java # Auto-runs table creation on startup
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml          # Web app descriptor
│           ├── index.jsp            # Landing page
│           ├── reg.jsp              # Registration form
│           ├── register.jsp         # Registration action (SQL insert)
│           ├── sign.jsp             # Login form
│           └── check.jsp           # Login action (auth check)
```

## Getting Started

### Prerequisites

* Java 8 JDK
* Maven 3+
* Git

### Setup & Running

1. **Clone the repository**
   ```bash
   git clone https://github.com/shubhyagami/employee.git
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

## Changelog

| Date       | Description                                  |
|------------|------------------------------------------------|
| 2026-08-21 | README cleanup                               |
| 2026-08-12 | Improved README with no redundant entries    |
| 2026-08-10 | Polished README with corrected grammar and structure |
| 2026-08-05 | Fixed JSP rendering anomaly on `reg.jsp`       |

## License

This project is licensed under the MIT License.
