# Employee Management System

A lightweight Java Servlet application that stores employee records in an embedded SQLite database and runs on an embedded Tomcat server. No external servers are required—just a single JAR or the Maven wrapper.

![Java 8](https://img.shields.io/badge/Java-8-blue?logo=java)
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)
![SQLite 3.45](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [API](#api)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Features

- **User authentication** – register, log in, and manage sessions via cookies.
- **RESTful CRUD API** – `GET`, `POST`, `PUT`, `DELETE` on `/employees`.
- **Automatic schema creation** – database tables are created on first run.
- **Standalone deployment** – a single fat JAR, or run locally with the embedded Tomcat Maven plugin.
- **Simple UI** – JSP pages for registration, login, and employee management.

---

## Tech Stack

| Category | Technology |
|----------|------------|
| Language | Java 8 (compatible with newer JDKs) |
| Server   | Embedded Tomcat 7 |
| Web framework | Servlet API (`javax.servlet`) |
| Database | SQLite 3.45.1 |
| Build tool | Maven 3+ |
| Front‑end | JSP, HTML, CSS |

---

## Project Structure

```
employee/
├── pom.xml                # Maven build configuration
├── mvnw                   # Maven wrapper (Unix)
├── mvnw.cmd               # Maven wrapper (Windows)
├── .gitignore
├── README.md
├── LICENSE
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

The application context is defined in `WEB-INF/web.xml`. By default it is exposed at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Getting Started

### Prerequisites

- JDK 8 (any newer JDK works)
- Maven 3+
- Git

### Quick Setup

```bash
# Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build the application (creates a fat JAR in target/)
mvn clean package

# Run the embedded Tomcat server
mvn tomcat7:run
```

> **Tip** – If you prefer not to build the application yourself, you can run the pre‑built JAR:  
> `java -jar target/employee-jar-with-dependencies.jar`.  
> The web UI will be available at `http://localhost:8080/EmployeeManagementSystem/`.

### First Use

1. Open the landing page in a browser.  
2. Register a new user via **reg.jsp**.  
3. Log in with the new account using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

---

## API

All responses are JSON. Authentication is required for `POST`, `PUT`, and `DELETE`. A session cookie is set after successful login.

| Method | URL               | Description                         |
|--------|-------------------|-------------------------------------|
| `GET`  | `/employees`     | List all employees.                 |
| `POST` | `/employees`     | Create a new employee.             |
| `PUT`  | `/employees/{id}` | Update an existing employee.       |
| `DELETE` | `/employees/{id}` | Remove an employee.              |

You can authenticate by sending the session cookie returned from `/login` or by using the `Authorization` header with a `Bearer` token (if you add that feature later).

---

## Contributing

Pull requests are welcome! Before submitting:

1. Run the test suite: `mvn test`.  
2. Follow the existing naming and indentation conventions.  
3. Update the documentation if you add or change features.

If you encounter an issue, feel free to open one. Please provide a clear description and, if possible, a minimal example that reproduces the problem.

---

## Changelog

- **2026‑09‑03** – Minor documentation cleanup and grammar fixes.  
- **2026‑09‑02** – Reorganised sections and added a concise feature list.  
- **2026‑08‑21** – Wording edits.  
- **2026‑08‑12** – Added tech‑stack table.  

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
