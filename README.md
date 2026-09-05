# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on an embedded Tomcat server.  
Build a single fat JAR with Maven or use the Maven wrapper – no external servers are required.

![Java 8](https://img.shields.io/badge/Java-8-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)

---

## Table of contents

- [Introduction](#introduction)
- [Getting started](#getting-started)
- [Features](#features)
- [Technology stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Using the application](#using-the-application)
- [REST API](#rest-api)
- [Project structure](#project-structure)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Introduction

The Employee Management System is a small, self‑contained Java web app that combines a JSP‑based UI with a RESTful API.  
The data layer uses an embedded SQLite database that is automatically initialized on first run.  
Sessions are handled with HTTP cookies, allowing the API and the UI to be used side‑by‑side.

---

## Getting started

1. **Clone the repository**  
2. **Build** a fat JAR or run the embedded Tomcat server.  
3. **Access** the UI at `http://localhost:8080/EmployeeManagementSystem/` and the API at `http://localhost:8080/EmployeeManagementSystem/employees`.

---

## Features

- **User management** – register, log in, maintain sessions via cookies.  
- **RESTful CRUD** API for `/employees`.  
- **Automatic schema initialization** on startup.  
- **Standalone deployment** – a fat JAR or Maven’s Tomcat plugin.  
- **JSP UI** for registration, login, and employee CRUD.  

---

## Technology stack

| Category | Technology |
|----------|------------|
| Language | Java 8 (works with later JDKs) |
| Server   | Embedded Tomcat 7 |
| Servlet  | `javax.servlet` |
| Database | SQLite 3.45.1 |
| Build    | Maven 3+ |
| Front‑end| JSP, HTML, CSS |

---

## Prerequisites

- JDK 8 or newer
- Maven 3+ (or the provided wrapper)
- Git (for cloning)

---

## Quick start

```bash
# Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build a fat JAR
mvn clean package

# Run with the embedded Tomcat Maven plugin
mvn tomcat7:run
```

Or run the pre‑built JAR directly:

```bash
java -jar target/employee-jar-with-dependencies.jar
```

The web UI is now available at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Using the application

1. Open the landing page in a browser.  
2. Register a new user via **reg.jsp**.  
3. Log in with the new account using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

### Authentication

After a successful login the server sets a `JSESSIONID` cookie.  
All `POST`, `PUT`, and `DELETE` requests to the API require this cookie.  
If you extend the project you can also add an `Authorization: Bearer <token>` header.

---

## REST API

All responses from the API are JSON.

| Method | Endpoint          | Purpose |
|--------|------------------|---------|
| GET    | `/employees`     | List all employees |
| POST   | `/employees`     | Create a new employee |
| PUT    | `/employees/{id}`| Update an existing employee |
| DELETE | `/employees/{id}`| Delete an employee |

Example request to create an employee:

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
├── pom.xml                     # Maven build file
├── mvnw                        # Maven wrapper (Unix)
├── mvnw.cmd                    # Maven wrapper (Windows)
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
