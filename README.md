# Employee Management System

A lightweight Java servlet application that stores employee records in an embedded SQLite database and runs on an embedded Tomcat instance – no external servers needed.

[![Java 8](https://img.shields.io/badge/Java-8-blue?logo=java)](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html)  
[![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)](https://maven.apache.org/)  
[![SQLite 3.45](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)](https://www.sqlite.org/)  
[![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)](https://tomcat.apache.org/)  
[![License MIT](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)](https://opensource.org/licenses/MIT)

---

## Features

- **User authentication** – register, log in, and maintain sessions.  
- **RESTful CRUD API** – `GET`, `POST`, `PUT`, `DELETE` on `/employees`.  
- **Automatic schema creation** – tables are generated on first run.  
- **Standalone deployment** – a single fat JAR, or use the embedded Tomcat Maven plugin for local development.

---

## Tech Stack

| Category   | Technology |
|------------|------------|
| Language   | Java 8 |
| Web framework | Java Servlet (`javax.servlet`) |
| Database   | SQLite |
| Build tool | Maven 3+ |
| Server     | Embedded Tomcat 7 |
| Front‑end  | JSP, HTML, CSS |

---

## Project Structure

```
employee/
├── pom.xml          # Maven configuration
├── mvnw             # Maven wrapper (Unix)
├── mvnw.cmd         # Maven wrapper (Windows)
├── .gitignore
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/example/demo1/
        │       ├── Employee.java
        │       ├── EmployeeServlet.java
        │       ├── DatabaseUtil.java
        │       └── DatabaseInitializer.java
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml
            ├── index.jsp
            ├── reg.jsp
            ├── register.jsp
            ├── sign.jsp
            └── check.jsp
```

---

## Getting Started

### Prerequisites

- JDK 8 (Java 8 compatible; newer JDKs also work)
- Maven 3+
- Git

### Quick Setup

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package          # Build the application
mvn tomcat7:run             # Start embedded Tomcat
```

The web application will be available at <http://localhost:8080/EmployeeManagementSystem/> (the context path is set in `web.xml`).

### First Use

1. Open the landing page in a browser.  
2. Register a new user via `reg.jsp`.  
3. Log in with the new account using `sign.jsp`.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

---

## API

| Method | URL | Description |
|--------|-----|-------------|
| GET    | `/employees` | List all employees. |
| POST   | `/employees` | Create a new employee. |
| PUT    | `/employees/{id}` | Update an existing employee. |
| DELETE | `/employees/{id}` | Remove an employee. |

All responses are in JSON. Authentication is required for non‑GET requests; a session cookie is issued upon successful login.

---

## Contributing

Feel free to open issues or submit pull requests. Please ensure that:

- Tests pass (`mvn test`).  
- Code follows the existing coding style.  
- Documentation is updated when new features are added.

---

## Changelog

- **2026‑09‑02** – README cleaned up, sections reorganised.  
- **2026‑08‑21** – Minor wording edits.  
- **2026‑08‑12** – Added feature list and tech‑stack table.  
- **2026‑08‑10** – Fixed typos.  
- **2026‑08‑05** – Fixed rendering issue on `reg.jsp`.

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
