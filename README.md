# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on a bundled Tomcat 7 server.  
Everything is packaged in a single “fat” JAR – no external application server is required.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)  
![CI](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Table of contents

- [Overview](#overview)
- [Features](#features)
- [Technical stack](#technical-stack)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
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

The **Employee Management System** is a self‑contained Java web app that offers:

* A JSP‑based UI for creating, reading, updating, and deleting employee records.
* A RESTful API (`/employees`) for programmatic access.
* Automatic creation of the SQLite schema on first run.
* Session management via HTTP cookies (`JSESSIONID`), shared between UI and API.

---

## Features

| Feature | What it does |
|---------|--------------|
| **User authentication** | Register, log in, and maintain a session. |
| **CRUD UI** | Simple JSP pages to manage employees. |
| **REST API** | Standard endpoints for CRUD operations. |
| **Embedded server** | Runs on a bundled Tomcat 7 – no external deployment. |
| **Database initialization** | SQLite schema is created automatically on first launch. |

---

## Technical stack

| Category | Technology |
|----------|-----------|
| Language | Java 8+ |
| Server | Embedded Tomcat 7 |
| Servlet API | `javax.servlet` |
| Database | SQLite 3.45.1 |
| Build tool | Maven 3+ |
| Front‑end | JSP, HTML, CSS |

---

## Prerequisites

* JDK 8 or newer (`java -version` shows 1.8.x or higher)
* Maven 3+ (`mvn -version`)
* Git (to clone the repository)

---

## Quick start

```bash
# Clone the repo
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build the executable JAR
mvn clean package

# Run the application
java -jar target/employee-jar-with-dependencies.jar
```

The app is available at `http://localhost:8080/EmployeeManagementSystem/`.

If you prefer to run it directly from Maven:

```bash
mvn tomcat7:run
# or with the wrapper scripts
./mvnw clean package
./mvnw tomcat7:run
```

---

## Using the application

### Web UI

1. Open <http://localhost:8080/EmployeeManagementSystem/> in a browser.  
2. Register a new user on **reg.jsp** (or **register.jsp**).  
3. Log in via **sign.jsp**.  
4. Use the UI to add, edit, or delete employees.

### REST API

All responses are JSON. The API base path is relative to the context path.

| Method | Endpoint           | Purpose                        |
|--------|--------------------|---------------------------------|
| GET    | `/employees`       | List all employees              |
| POST   | `/employees`       | Create a new employee           |
| PUT    | `/employees/{id}`   | Update an existing employee     |
| DELETE | `/employees/{id}`   | Delete an employee             |

**Example – create an employee**

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=...' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

Authentication is cookie based. Log in, note the `JSESSIONID` cookie, and include it in subsequent writes (`POST`, `PUT`, `DELETE`). Future versions may support token‑based auth.

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

| Symptom | Fix |
|---------|-----|
| `java: invalid source release 8` | Ensure `JAVA_HOME` points to a JDK ≥ 8 and `mvn -version` shows the correct JDK. |
| Database file not created | The directory where the JAR is executed must be writable. |
| `JSESSIONID` missing on API call | Be sure to send the cookie (`-b 'JSESSIONID=...'` with `curl` or `withCredentials` in browsers). |

---

## Contributing

Pull requests are welcome! Please:

1. Run the tests: `mvn test`.  
2. Follow the existing style.  
3. Update documentation if you add or modify features.  
4. Write clear commit messages and PR descriptions.

If you hit a bug, open an issue with a brief description and, if possible, a minimal reproducible example.

---

## Changelog

* **2026‑09‑13** – Minor README cleanup, added concise feature list.  
* **2026‑09‑04** – Updated badges and table of contents.  
* **2026‑08‑12** – Added tech‑stack table.

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
