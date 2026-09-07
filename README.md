# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on an embedded Tomcat 7 server. It bundles everything into a single fat JAR, so no external server is needed.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)

---

## Quick start

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package
java -jar target/employee-jar-with-dependencies.jar
```

Open [http://localhost:8080/EmployeeManagementSystem/](http://localhost:8080/EmployeeManagementSystem/) in your browser.

> **Tip** – You can also run the app directly from Maven:

```bash
mvn tomcat7:run
```

---

## Table of contents

- [Overview](#overview)
- [Quick start](#quick-start)
- [Features](#features)
- [Technology stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Build and run](#build-and-run)
- [Using the application](#using-the-application)
- [REST API](#rest-api)
- [Project structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Overview

The **Employee Management System** is a self‑contained Java web app that provides:

- A JSP‑based user interface for CRUD operations.
- A RESTful API (`/employees`) for programmatic access.
- Automatic schema creation in an embedded SQLite database on first run.
- Session handling via HTTP cookies (`JSESSIONID`), allowing the UI and API to share authentication state.

---

## Features

- **User management** – register, login, and maintain sessions through cookies.
- **RESTful CRUD API** – `GET /employees`, `POST /employees`, `PUT /employees/{id}`, `DELETE /employees/{id}`.
- **Automatic database initialization** – the schema is created on first start.
- **Standalone deployment** – a single fat JAR or run via the Maven Tomcat plugin.
- **JSP UI** – intuitive web pages for user and employee management.

---

## Technology stack

| Category      | Technology |
|---------------|-----------|
| Language      | Java 8+ |
| Server        | Embedded Tomcat 7 |
| Servlet API   | `javax.servlet` |
| Database      | SQLite 3.45.1 |
| Build tool    | Maven 3+ |
| Front‑end     | JSP, HTML, CSS |

---

## Prerequisites

- JDK 8 or newer
- Maven 3+ (or the included wrapper scripts)
- Git (for cloning)

---

## Build and run

### Option 1 – Fat JAR

```bash
mvn clean package
java -jar target/employee-jar-with-dependencies.jar
```

The application is now available at `http://localhost:8080/EmployeeManagementSystem/`.

### Option 2 – Embedded Tomcat Maven plugin

```bash
mvn tomcat7:run
```

You can also use the Maven wrapper:

```bash
./mvnw clean package
./mvnw tomcat7:run
```

---

## Using the application

1. Open `http://localhost:8080/EmployeeManagementSystem/` in a browser.  
2. Register a new user via **reg.jsp** (or **register.jsp**).  
3. Log in with your credentials using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

### Authentication

After a successful login, the server sets a `JSESSIONID` cookie.  
All `POST`, `PUT`, and `DELETE` requests to the API must include this cookie.  
(If you extend the project, you can also implement an `Authorization: Bearer <token>` header.)

---

## REST API

All responses are JSON.

| Method | Endpoint          | Purpose                                 |
|--------|-------------------|------------------------------------------|
| GET    | `/employees`      | List all employees                       |
| POST   | `/employees`      | Create a new employee                     |
| PUT    | `/employees/{id}` | Update an existing employee              |
| DELETE | `/employees/{id}` | Delete an employee                       |

**Create employee example**

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=...' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

---

## Project structure

```
employee/
├── pom.xml                       # Maven build file
├── mvnw / mvnw.cmd               # Maven wrapper scripts
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

The application’s context path is defined in `WEB-INF/web.xml`.  
By default it is served at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `java: invalid source release 8` | Ensure `JAVA_HOME` points to a JDK ≥ 8 and that `mvn -version` reports the correct Java version. |
| Database file not created | Verify the project directory has write permissions. |
| `JSESSIONID` missing on API call | Make sure the cookie is sent with your HTTP client (e.g., `-b 'JSESSIONID=...'` in `curl`). |

---

## Contributing

Pull requests are welcome! Please follow these steps:

1. Run the test suite: `mvn test`.  
2. Keep the coding style consistent with the existing code.  
3. Update documentation if you add or modify functionality.  
4. Write clear commit messages and PR descriptions.

If you encounter a problem, open an issue with a concise description and, if possible, a minimal reproducible example.

---

## Changelog

- **2026‑09‑04** – Updated README, cleaned wording, added concise feature list.  
- **2026‑09‑03** – Minor documentation cleanup.  
- **2026‑09‑02** – Reorganized sections.  
- **2026‑08‑21** – Minor wording edits.  
- **2026‑08‑12** – Added tech‑stack table.

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
