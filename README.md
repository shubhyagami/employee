[K[2m  [2mmodel z-ai/glm-5.3-flash failed, trying next...[0m[0m
[K[2m  [2mmodel deepseek-ai/deepseek-v4.1-flash failed, trying next...[0m[0m
# Employee Management System

A lightweight Java web application that stores employee data in an embedded SQLite database and runs on a bundled Tomcat 7 server.  
Everything is packaged into a single executable JAR, so you can deploy it without installing a separate application server.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)  
![CI](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Table of Contents

- [Quick Start](#quick-start)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Build & Run](#build--run)
- [Configuration](#configuration)
- [REST API](#rest-api)
- [Web UI](#web-ui)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Quick Start

```bash
# Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build the fat JAR
mvn clean package          # or ./mvnw clean package

# Run the application
java -jar target/employee-jar-with-dependencies.jar
```

Open your browser at <http://localhost:8080/EmployeeManagementSystem/> to access the web UI, or hit the REST endpoints under `/employees`.

> **Tip**  
> The server listens on port **8080** by default. Override it with `-Dtomcat.port=9090`.

---

## Features

* JSP‑based CRUD UI for employee records  
* RESTful API (`/employees`) returning JSON  
* Cookie‑based session handling (`JSESSIONID` shared between UI and API)  
* Automatic SQLite schema creation on first run  
* Self‑contained deployment via an embedded Tomcat 7  
* User registration and login with persistent sessions  

---

## Architecture

```
(employee)
├── pom.xml                     ← Maven build definition
├── src/
│   ├── main/
│   │   ├── java/               ← Java source (servlets, utilities)
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml   ← Servlet configuration
│   │       └── jsp files      ← UI pages (index.jsp, reg.jsp, sign.jsp, etc.)
├── target/
│   └── employee-jar-with-dependencies.jar   ← Executable JAR
```

The JAR bundles Tomcat 7, SQLite JDBC driver, and all application classes. It starts a server on `localhost:8080` with the context path `EmployeeManagementSystem`.

---

## Prerequisites

| Tool | Minimum version | Command to check |
|------|-----------------|------------------|
| JDK  | 8+              | `java -version`  |
| Maven | 3+             | `mvn -version`   |
| Git   | any             | `git --version`  |

---

## Build & Run

### 1. Build the fat JAR

```bash
mvn clean package
#   → target/employee-jar-with-dependencies.jar
```

### 2. Run the application

```bash
java -jar target/employee-jar-with-dependencies.jar
```

### 3. (Optional) run via Maven Tomcat plugin

```bash
mvn tomcat7:run
# or with the wrapper script:
./mvnw tomcat7:run
```

---

## Configuration

| Property | Description | Default |
|----------|-------------|---------|
| `tomcat.port` | Port on which Tomcat listens | `8080` |
| `sqlite.path` | Location of the SQLite database file | `${user.dir}/employee.db` |

You can override properties on the command line:

```bash
java -Dtomcat.port=9090 -Dsqlite.path=/data/employee.db -jar target/employee-jar-with-dependencies.jar
```

---

## REST API

All endpoints are relative to the context path `EmployeeManagementSystem`.  
Authentication is cookie‑based: after logging in, include the `JSESSIONID` cookie in each request.

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/employees` | List all employees |
| `POST` | `/employees` | Create a new employee |
| `PUT` | `/employees/{id}` | Update an employee |
| `DELETE` | `/employees/{id}` | Delete an employee |

### Example – Create an employee with `curl`

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=YOUR_COOKIE_ID' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

---

## Web UI

1. **Register** – Open <http://localhost:8080/EmployeeManagementSystem/reg.jsp> (or `/register.jsp`) and create a user.  
2. **Login** – Go to `<http://localhost:8080/EmployeeManagementSystem/sign.jsp>` (or `/sign.jsp`) and sign in.  
3. **Manage Employees** – After logging in, you’ll see the admin pages where you can add, edit, or delete employee records.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `java: invalid source release 8` | `JAVA_HOME` points to a JDK older than 8 | Point `JAVA_HOME` to a Java 8+ JDK |
| SQLite file not created | No write permission | Run the JAR from a writable directory or change the SQLite path |
| `JSESSIONID` missing | Cookie not sent | Include the cookie in requests (`-b` with curl, `withCredentials` in XHR/Fetch) |
| Application fails to start | Port 8080 already in use | Stop the conflicting process or set a different port (`-Dtomcat.port=9090`) |

---

## Contributing

1. Fork the repo and create a feature branch.  
2. Run `mvn test` – all tests should pass.  
3. Maintain the existing code style (CheckStyle, PMD).  
4. Update the README if you add or remove functionality.  
5. Submit a pull request with a clear description.

Bug reports are welcome. If possible, provide a minimal reproducible example.

---

## Changelog

- **2026‑09‑27** – Minor cleanup of README, corrected wording.  
- **2026‑09‑18** – Updated badges and table of contents.  
- **2026‑09‑13** – Refactored feature list for clarity.  
- **2026‑09‑04** – Added architecture diagram.  
- **2026‑08‑12** – Added tech‑stack table.

---

## License

MIT – see the `LICENSE` file.
