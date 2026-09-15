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
- [Quick start](#quick-start)
- [Features](#features)
- [Technical stack](#technical-stack)
- [Prerequisites](#prerequisites)
- [Getting started](#getting-started)
  - [Run the fat JAR](#run-the-fat-jar)
  - [Run via Maven](#run-via-maven)
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

**Employee Management System** is a self‑contained Java web app that offers:

- A JSP‑based UI for CRUD operations on employee records.
- A RESTful API (`/employees`) for programmatic access.
- Automatic SQLite schema creation on first launch.
- Session handling via HTTP cookies (`JSESSIONID`), shared between UI and API.

By default the application is deployed under the context path **EmployeeManagementSystem**, as defined in `WEB-INF/web.xml`.

---

## Quick start

```bash
# Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build the single executable JAR
mvn clean package

# Run it
java -jar target/employee-jar-with-dependencies.jar
```

Open <http://localhost:8080/EmployeeManagementSystem/> to view the UI.

---

## Features

- **User authentication** – register, login, and maintain a session.
- **Employee CRUD** – create, read, update, delete employee records.
- **REST API** – standard CRUD endpoints, JSON responses.
- **Embedded server** – runs on bundled Tomcat 7; no external deployment needed.
- **Database initialization** – SQLite schema is created automatically on first launch.

---

## Technical stack

| Category    | Details                 |
|-------------|------------------------|
| Language    | Java 8+                |
| Server      | Embedded Tomcat 7       |
| Servlet API | `javax.servlet`       |
| Database    | SQLite 3.45.1          |
| Build tool  | Maven 3+               |
| Front‑end   | JSP, HTML, CSS         |

---

## Prerequisites

| Tool | Minimum version | Check command          |
|------|-----------------|------------------------|
| JDK  | 8+              | `java -version`        |
| Maven | 3+             | `mvn -version`         |
| Git   | –              | `git --version`         |

---

## Getting started

### Run the fat JAR

```bash
# Build
mvn clean package

# Run
java -jar target/employee-jar-with-dependencies.jar
```

The application listens on port **8080** by default.

### Run via Maven

If you prefer to start the application directly from Maven (requires the Tomcat plugin):

```bash
# Using Maven
mvn tomcat7:run
```

or with the Maven wrapper:

```bash
./mvnw clean package
./mvnw tomcat7:run
```

---

## Using the application

### Web UI

1. Open <http://localhost:8080/EmployeeManagementSystem/>.  
2. Register a new user on **reg.jsp** (or **register.jsp**).  
3. Log in via **sign.jsp**.  
4. Use the UI pages to add, edit, or delete employees.

### REST API

All responses are JSON. The base path is relative to the application context.  
Authentication is cookie‑based: after logging in, include the `JSESSIONID` cookie with each request.

| Method | Endpoint            | Purpose                     |
|--------|---------------------|-----------------------------|
| GET    | `/employees`        | List all employees           |
| POST   | `/employees`         | Create a new employee      |
| PUT    | `/employees/{id}`  | Update an existing employee |
| DELETE | `/employees/{id}`  | Delete an employee          |

**Example – create an employee**

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=...' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

Replace `JSESSIONID=...` with the cookie value obtained after logging in.

> **Tip**: In browsers, enable “Include cookies” or use an extension such as *ModHeader* to preserve authentication across requests.

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

| Symptom                                 | Likely cause                                        | Fix                                               |
|---------------------------------------- | --------------------------------------------------- | ------------------------------------------------- |
| `java: invalid source release 8`        | `JAVA_HOME` points to a JDK older than Java 8        | Update `JAVA_HOME` to a JDK ≥ 8; verify with `java -version`. |
| Database file not created               | Current directory is not writable                    | Run the JAR from a writable folder, or change the SQLite data source path via `DatabaseUtil`. |
| `JSESSIONID` missing on API call        | Cookie not sent or lost                              | Ensure the tool sends the cookie (`-b 'JSESSIONID=...'` with `curl`, `withCredentials` in AJAX). |
| Application fails to start            | Port 8080 already in use                             | Stop the conflicting process, or change the Tomcat port in `pom.xml` or `web.xml`. |

---

## Contributing

Pull requests are welcome! Please follow these guidelines:

1. Create a new topic branch.  
2. Run `mvn test` to ensure the test suite passes.  
3. Keep the coding style consistent with the existing code.  
4. If you add or modify features, update the README accordingly.  
5. Submit a detailed pull request.

For bug reports, open an issue with a concise description and, if possible, a minimal reproducible example.

---

## Changelog

- **2026‑09‑13** – Minor README cleanup, added concise feature list.  
- **2026‑09‑04** – Updated badges and TOC.  
- **2026‑08‑12** – Added tech‑stack table.

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
