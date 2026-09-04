# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on an embedded Tomcat server.  
Build a single fat JAR with Maven or use the Maven wrapper – no external servers are required.

![Java 8](https://img.shields.io/badge/Java-8-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)

---

## Table of contents

- [Introduction](#introduction)
- [Features](#features)
- [Technology stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Using the application](#using-the-application)
- [API reference](#api-reference)
- [Project structure](#project-structure)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Introduction

The application offers both a user‑friendly JSP UI and a RESTful API for managing employees.  
It uses a single SQLite database to store user accounts and employee records, and handles sessions via HTTP cookies.

You can run it as a stand‑alone web application or embed the servlet container into another project.

---

## Features

- **User management** – register, log in, and maintain sessions with cookies.
- **RESTful CRUD API** for `/employees`.
- **Automatic schema initialization** when the application starts.
- **Standalone deployment** – a fat JAR or Maven’s Tomcat plugin.
- **JSP UI** for registration, login, and employee CRUD.

---

## Technology stack

| Category | Technology |
| -------- | ---------- |
| Language | Java 8 (compatible with newer JDKs) |
| Web server | Embedded Tomcat 7 |
| Servlet API | `javax.servlet` |
| Database | SQLite 3.45.1 |
| Build tool | Maven 3+ |
| Front‑end | JSP, HTML, CSS |

---

## Prerequisites

- JDK 8 or newer
- Maven 3+ (or use the provided wrapper)
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

The web UI is available at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Using the application

1. Open the landing page in a browser.  
2. Register a new user via **reg.jsp**.  
3. Log in with the new account using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

### REST API

All responses are JSON. For `POST`, `PUT`, and `DELETE` requests authentication is required; a session cookie is set after a successful login.

| Method | Endpoint          | Description                    |
| ------ | ----------------- | ------------------------------ |
| GET    | `/employees`      | List all employees             |
| POST   | `/employees`      | Create a new employee          |
| PUT    | `/employees/{id}` | Update an existing employee    |
| DELETE | `/employees/{id}` | Delete an employee             |

You can authenticate by sending the session cookie returned from `/login`.  
If you extend the project, you may also use an `Authorization: Bearer <token>` header.

---

## Project structure

```
employee/
├── pom.xml              # Maven build file
├── mvnw                 # Maven wrapper (Unix)
├── mvnw.cmd             # Maven wrapper (Windows)
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
