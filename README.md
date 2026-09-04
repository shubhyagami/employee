# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on an embedded Tomcat server.  
Build a single fat JAR or use the Maven wrapper – no external servers are required.

![Java 8](https://img.shields.io/badge/Java-8-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)

---

## Table of contents

- [Overview](#overview)
- [Features](#features)
- [Tech stack](#tech-stack)
- [Project structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Using the application](#using-the-application)
- [API reference](#api-reference)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Overview

The application exposes a simple UI (JSP) and a RESTful API for managing employees.  
User accounts are stored in the same SQLite database, and sessions are handled with HTTP cookies.

Use it either as a stand‑alone web app or as a library to embed a minimal servlet engine into another project.

---

## Features

- **User registration, login and session management** via cookies.
- **RESTful CRUD API** for `/employees`.
- **Automatic database schema creation** on first run.
- **Standalone deployment** – a single fat JAR, or run locally with the embedded Tomcat Maven plugin.
- **JSP UI** for registration, login, and employee CRUD.

---

## Tech stack

| Category | Technology |
| -------- | --------- |
| Language | Java 8 (compatible with newer JDKs) |
| Web server | Embedded Tomcat 7 |
| Servlet API | `javax.servlet` |
| Database | SQLite 3.45.1 |
| Build tool | Maven 3+ |
| Front‑end | JSP, HTML, CSS |

---

## Project structure

```
employee/
├── pom.xml                # Maven build file
├── mvnw                   # Maven wrapper (Unix)
├── mvnw.cmd                # Maven wrapper (Windows)
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

The application context is defined in `WEB-INF/web.xml`. By default it is served at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Prerequisites

- JDK 8 (or newer)
- Maven 3+
- Git

---

## Quick start

```bash
# Clone the repo
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build the fat JAR
mvn clean package

# Run with the embedded Tomcat
mvn tomcat7:run
```

**Or** run the pre‑built JAR directly:

```bash
java -jar target/employee-jar-with-dependencies.jar
```

The web UI will be available at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Using the application

1. Open the landing page in a browser.  
2. Register a new user via **reg.jsp**.  
3. Log in with the new account using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

---

## API reference

All responses are JSON. For `POST`, `PUT` and `DELETE` authentication is required. A session cookie is set after a successful login.

| Method | Endpoint            | Description                          |
|--------|----------------------|--------------------------------------|
| GET    | `/employees`        | List all employees                    |
| POST   | `/employees`        | Create a new employee                |
| PUT    | `/employees/{id}`   | Update an existing employee           |
| DELETE | `/employees/{id}`   | Delete an employee                    |

You can authenticate by sending the session cookie returned from `/login` or, if you extend the project, with an `Authorization: Bearer <token>` header.

---

## Contributing

Pull requests are welcome. Before submitting:

1. Run the test suite: `mvn test`.  
2. Follow the existing naming and indentation conventions.  
3. Update the documentation if you add or change features.

If you encounter an issue, feel free to open one with a clear description and, if possible, a minimal reproducible example.

---

## Changelog

- **2026‑09‑04** – Updated README, cleaned up wording, and added a concise feature list.  
- **2026‑09‑03** – Minor documentation cleanup.  
- **2026‑09‑02** – Reorganised sections.  
- **2026‑08‑21** – Minor wording edits.  
- **2026‑08‑12** – Added tech‑stack table.  

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
