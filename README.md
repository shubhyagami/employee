# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on an embedded Tomcat 7 server.  
Everything is bundled into a single “fat” JAR, so no external application server is required.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)  
![GitHub Actions](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Table of contents

- [Overview](#overview)
- [Features](#features)
- [Technical stack](#technical-stack)
- [Prerequisites](#prerequisites)
- [Getting started](#getting-started)
  - [Build & run](#build--run)
  - [Deploy with Maven](#deploy-with-maven)
- [Using the application](#using-the-application)
  - [Web UI](#web-ui)
  - [REST API](#rest-api)
- [Project structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Overview

The **Employee Management System** is a self‑contained Java web app that provides:

* A JSP‑based user interface for CRUD operations on employees.
* A RESTful API (`/employees`) that can be used programmatically.
* Automatic SQLite database schema creation on first run.
* Session management via HTTP cookies (`JSESSIONID`), allowing the UI and API to share authentication state.

---

## Features

| Feature | Description |
|---------|-------------|
| **User authentication** | Register, log in, and maintain sessions via cookies. |
| **CRUD UI** | Intuitive JSP pages to create, read, update, and delete employees. |
| **REST API** | `GET /employees`, `POST /employees`, `PUT /employees/{id}`, `DELETE /employees/{id}`. |
| **Embedded server** | Runs on a bundled Tomcat 7, no external deployment needed. |
| **Database initialization** | The SQLite schema is created automatically on first start. |

---

## Technical stack

| Category | Technology |
|----------|------------|
| Language | Java 8+ |
| Server | Embedded Tomcat 7 |
| Servlet API | `javax.servlet` |
| Database | SQLite 3.45.1 |
| Build tool | Maven 3+ |
| Front‑end | JSP, HTML, CSS |

---

## Prerequisites

* JDK 8 or newer (`java -version` should show 1.8.x or higher)
* Maven 3+ (`mvn -version`)
* Git (for cloning)

---

## Getting started

### Build & run

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package
java -jar target/employee-jar-with-dependencies.jar
```

The application will be available at `http://localhost:8080/EmployeeManagementSystem/`.

### Deploy with Maven

If you prefer not to build the JAR, you can run the app directly from Maven:

```bash
mvn tomcat7:run
```

Or, if you use the wrapper scripts:

```bash
./mvnw clean package
./mvnw tomcat7:run
```

---

## Using the application

### Web UI

1. Open <http://localhost:8080/EmployeeManagementSystem/> in a browser.  
2. Register a new user on **reg.jsp** (or **register.jsp**).  
3. Log in via **sign.jsp**.  
4. Use the UI to manage employee records.

### REST API

All responses are JSON. The endpoint is relative to the context path:

| Method | Endpoint | Purpose |
|--------|----------|---------|
| `GET` | `/employees` | List all employees |
| `POST` | `/employees` | Create a new employee |
| `PUT` | `/employees/{id}` | Update an existing employee |
| `DELETE` | `/employees/{id}` | Delete an employee |

**Create‑employee example**

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=...' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

**Authentication**  
After logging in, the server sets a `JSESSIONID` cookie. Include this cookie with every `POST`, `PUT`, or `DELETE` request (via `-b` in `curl` or `withCredentials` in browsers). Optionally, you may implement an `Authorization: Bearer <token>` header in the future.

---

## Project structure

```
employee/
├── pom.xml
├── mvnw / mvnw.cmd
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

The context path is defined in `WEB-INF/web.xml` and defaults to `EmployeeManagementSystem`.

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `java: invalid source release 8` | Verify `JAVA_HOME` points to a JDK ≥ 8 and run `mvn -version`. |
| Database file not created | Ensure the working directory is writable. |
| `JSESSIONID` missing on API call | Send the cookie with your HTTP client (e.g., `-b 'JSESSIONID=...'` in `curl`). |

---

## Contributing

Pull requests are welcome! Please:

1. Run the test suite: `mvn test`.  
2. Follow the existing coding style.  
3. Update documentation when adding or changing functionality.  
4. Write clear commit messages and PR descriptions.

If you run into a problem, open an issue with a concise description and, if possible, a minimal reproducible example.

---

## Changelog

* 2026‑09‑04 – Updated README, cleaned wording, added concise feature list.  
* 2026‑09‑03 – Minor documentation cleanup.  
* 2026‑09‑02 – Reorganized sections.  
* 2026‑08‑21 – Minor wording edits.  
* 2026‑08‑12 – Added tech‑stack table.

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
