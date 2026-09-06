# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on an embedded Tomcat 7 server.  
Build a single fat JAR with Maven or use the Maven wrapper – no external servers are required.

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

Open `http://localhost:8080/EmployeeManagementSystem/` in your browser and you’re ready to go.

---

## Table of contents

- [Overview](#overview)
- [Getting started](#getting-started)
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

The Employee Management System is a self‑contained Java web application that offers both a JSP‑based UI and a RESTful API.  
It uses an embedded SQLite database, automatically initialized on the first run.  
User sessions are handled with HTTP cookies, allowing the UI and the API to share authentication state.

---

## Getting started

```bash
# Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee
```

---

## Features

- **User management** – register, log in, and maintain sessions via cookies.
- **RESTful CRUD** API for `/employees`.
- **Automatic schema initialization** on startup.
- **Standalone deployment** – a single fat JAR or the Maven Tomcat plugin.
- **JSP UI** for user and employee CRUD operations.

---

## Technology stack

| Category | Technology |
|----------|------------|
| Language | Java 8 (compatible with later JDKs) |
| Server   | Embedded Tomcat 7 |
| Servlet  | `javax.servlet` |
| Database | SQLite 3.45.1 |
| Build    | Maven 3+ |
| Front‑end| JSP, HTML, CSS |

---

## Prerequisites

- JDK 8 or newer
- Maven 3+ (or the provided wrapper)
- Git (for cloning)

---

## Build and run

### Option 1 – Fat JAR

```bash
mvn clean package
java -jar target/employee-jar-with-dependencies.jar
```

The application is then available at `http://localhost:8080/EmployeeManagementSystem/`.

### Option 2 – Embedded Tomcat Maven plugin

```bash
mvn tomcat7:run
```

You can use the Maven wrapper scripts instead:

```bash
./mvnw clean package
./mvnw tomcat7:run
```

---

## Using the application

1. Open `http://localhost:8080/EmployeeManagementSystem/` in a browser.  
2. Register a new user via **reg.jsp**.  
3. Log in with the new account using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

### Authentication

After a successful login the server sets a `JSESSIONID` cookie.  
All `POST`, `PUT`, and `DELETE` requests to the API must include this cookie.  
(If you extend the project you may also use an `Authorization: Bearer <token>` header.)

---

## REST API

All responses are JSON.

| Method | Endpoint          | Purpose            |
|--------|-------------------|---------------------|
| GET    | `/employees`      | List all employees  |
| POST   | `/employees`      | Create a new employee |
| PUT    | `/employees/{id}` | Update an existing employee |
| DELETE | `/employees/{id}` | Delete an employee |

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
├── mvnw, mvnw.cmd                # Maven wrapper scripts
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

The application’s context path is defined in `WEB-INF/web.xml`. By default it is served at
`http://localhost:8080/EmployeeManagementSystem/`.

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `java: invalid source release 8` | Ensure `JAVA_HOME` points to a JDK ≥ 8 and `mvn -version` shows the correct Java version. |
| Database file not created | Verify write permissions in the project directory. |
| `JSESSIONID` missing on API call | Make sure the cookie is sent with `curl` or your HTTP client. |

---

## Contributing

Pull requests are welcome! Please follow these guidelines:

1. Run the test suite: `mvn test`.  
2. Keep the code style consistent with the existing conventions.  
3. Update the documentation if you add or modify features.  
4. Describe your changes clearly in the commit message and pull request description.

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
