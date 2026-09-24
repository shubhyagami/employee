[K[2m  [2mmodel deepseek-ai/deepseek-v4.1-flash failed, trying next...[0m[0m
# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on a bundled Tomcat 7 server.  
Everything is packaged in a single executable JAR – no external application server is required.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)  
![CI](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Quick start

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package
java -jar target/employee-jar-with-dependencies.jar
```

Open <http://localhost:8080/EmployeeManagementSystem/> to view the web UI or hit the REST endpoints under `/employees`.

> **Tip**: The bundle runs on port 8080 by default. Override it with `-Dtomcat.port=9090` if needed.

---

## Overview

The application offers:

- JSP‑based CRUD UI for employee records  
- A RESTful API (`/employees`) returning JSON  
- Automatic SQLite schema creation on first run  
- Cookie‑based session handling (`JSESSIONID`) shared between UI and API  
- Self‑contained deployment via an embedded Tomcat 7

The context path is **EmployeeManagementSystem** (`WEB-INF/web.xml`).

---

## Features

- User registration & login with persistent sessions  
- Create, read, update, and delete employee records  
- REST API: `GET /employees`, `POST /employees`, `PUT /employees/{id}`, `DELETE /employees/{id}`  
- Embedded Tomcat 7; no external server needed  
- Automatic database bootstrap on first launch  

---

## Prerequisites

| Tool | Minimum version | Check command |
|------|-----------------|---------------|
| JDK  | 8+              | `java -version` |
| Maven | 3+             | `mvn -version` |
| Git  | –               | `git --version` |

---

## Getting started

### 1. Build the fat JAR

```bash
mvn clean package
```

The JAR is created at `target/employee-jar-with-dependencies.jar`.

### 2. Run the application

```bash
java -jar target/employee-jar-with-dependencies.jar
```

The server starts on `localhost:8080`. Open the web UI at <http://localhost:8080/EmployeeManagementSystem/> or use the API.

### 3. Alternative – run via Maven (Tomcat plugin)

```bash
mvn tomcat7:run
```

or with the wrapper:

```bash
./mvnw clean package
./mvnw tomcat7:run
```

---

## Using the application

### Web UI

1. Open <http://localhost:8080/EmployeeManagementSystem/>  
2. Register a user on **reg.jsp** or **register.jsp**  
3. Log in via **sign.jsp**  
4. Manage employees from the admin pages

### REST API

All responses are JSON. Authentication is cookie‑based: after logging in, include the `JSESSIONID` cookie on each request.

| Method | Endpoint | Description |
|--------|----------|--------------|
| `GET` | `/employees` | List all employees |
| `POST` | `/employees` | Create a new employee |
| `PUT` | `/employees/{id}` | Update an employee |
| `DELETE` | `/employees/{id}` | Delete an employee |

**Example – create an employee via curl**

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=YOUR_COOKIE_ID' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

---

## Configuration

- **Tomcat port** – `-Dtomcat.port=9090` (or edit `pom.xml`)  
- **SQLite data file** – defaults to `${user.dir}/employee.db`; change in `DatabaseUtil` if needed

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

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|--------|--------------|-----|
| `java: invalid source release 8` | `JAVA_HOME` points to JDK < 8 | Point `JAVA_HOME` to a Java 8+ JDK |
| SQLite file not created | No write permission | Run the JAR from a writable directory or change the SQLite path |
| `JSESSIONID` missing | Cookie not sent | Include the cookie in requests (`-b` with curl, `withCredentials` in XHR/Fetch) |
| Application fails to start | Port 8080 already in use | Stop the conflicting process or set a different port |

---

## Contributing

1. Fork the repo and create a feature branch.  
2. Run `mvn test` – all tests should pass.  
3. Keep the code style consistent with the existing code.  
4. Update this README if you add or remove functionality.  
5. Submit a pull request with a clear description.

Bug reports welcome – please include a reproducible example if possible.

---

## Changelog

- **2026‑09‑18** – Minor README cleanup and typo fixes.  
- **2026‑09‑13** – Added concise feature list.  
- **2026‑09‑04** – Updated badges and table of contents.  
- **2026‑08‑12** – Added tech‑stack table.

---

## License

MIT – see the `LICENSE` file.
