[K[2m  [2mmodel z-ai/glm-5.3-flash failed, trying next...[0m[0m
[K[2m  [2mmodel deepseek-ai/deepseek-v4.1-flash failed, trying next...[0m[0m
# Employee Management System

A lightweight Java EE web application that stores employee records in an embedded SQLite database and runs on a bundled Tomcat 7 server.  
Built as a single executable JAR, it can be started without any external application server.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)  
![CI](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Table of Contents

- [Overview](#overview)
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

## Overview

The system provides:

- A JSP‑based CRUD UI for managing employees.
- A RESTful API (`/employees`) that returns JSON.
- Cookie‑based session handling shared between the UI and API.
- Automatic SQLite schema creation on first run.
- A self‑contained deployment via an embedded Tomcat 7.

The JAR is bundled with the Tomcat runtime, the SQLite JDBC driver, and all application classes, so the only external requirement is a Java 8+ runtime.

---

## Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee

# 2. Build the executable JAR
mvn clean package          # or ./mvnw clean package

# 3. Run the application
java -jar target/employee-jar-with-dependencies.jar
```

Open <http://localhost:8080/EmployeeManagementSystem/> to view the web UI or issue requests to the `/employees` API endpoints.

> **Tip**  
> The default port is `8080`. Override it with `-Dtomcat.port=9090`.

---

## Features

| Feature | Description |
|---------|-------------|
| **JSP UI** | CRUD interface for employee records. |
| **REST API** | `/employees` endpoint for `GET`, `POST`, `PUT`, `DELETE`. |
| **Session management** | Cookie‑based `JSESSIONID` shared across UI and API. |
| **Persisted authentication** | User registration and login; sessions survive server restarts. |
| **Embedded runtime** | Self‑contained JAR with Tomcat 7 and SQLite driver. |
| **Auto‑schema** | Database schema created automatically on first run. |

---

## Architecture

```
employee/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/          # Servlets, utilities, data access
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       └── jsp/       # index.jsp, reg.jsp, sign.jsp, etc.
├── target/
│   └── employee-jar-with-dependencies.jar
```

The JAR contains:

- Embedded Tomcat 7
- SQLite JDBC driver
- All compiled application classes

On start it listens at `localhost:8080` (default) with a context path of `EmployeeManagementSystem`.

---

## Prerequisites

| Tool | Minimum version | Check command |
|------|-----------------|---------------|
| JDK  | 8+              | `java -version` |
| Maven | 3+              | `mvn -version` |
| Git   | any             | `git --version` |

---

## Build & Run

### 1. Build the fat JAR

```bash
mvn clean package   # or ./mvnw clean package
```

The JAR will be available at `target/employee-jar-with-dependencies.jar`.

### 2. Run the application

```bash
java -jar target/employee-jar-with-dependencies.jar
```

### 3. (Optional) Run with Maven Tomcat plugin

```bash
mvn tomcat7:run          # or ./mvnw tomcat7:run
```

---

## Configuration

Properties can be overridden on the command line with the `-D` syntax.

| Property | Description | Default |
|----------|--------------|---------|
| `tomcat.port` | Port on which Tomcat listens | `8080` |
| `sqlite.path` | Path to the SQLite database file | `${user.dir}/employee.db` |

Example:

```bash
java -Dtomcat.port=9090 -Dsqlite.path=/data/employee.db \
    -jar target/employee-jar-with-dependencies.jar
```

---

## REST API

All endpoints are relative to `/EmployeeManagementSystem`.  
After logging in, include the `JSESSIONID` cookie with each request.

| Method | Endpoint | Purpose |
|--------|----------|---------|
| `GET` | `/employees` | List all employees |
| `POST` | `/employees` | Create a new employee |
| `PUT` | `/employees/{id}` | Update an existing employee |
| `DELETE` | `/employees/{id}` | Delete an employee |

### Example – Create an employee

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=YOUR_COOKIE_ID' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

---

## Web UI

1. **Register** – <http://localhost:8080/EmployeeManagementSystem/reg.jsp>  
2. **Login** – <http://localhost:8080/EmployeeManagementSystem/sign.jsp>  
3. **Dashboard** – After login, access employee CRUD pages.

The UI uses server‑side JSP rendering and shares the same session cookie as the API.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `java: invalid source release 8` | `JAVA_HOME` points to a JDK older than 8 | Set `JAVA_HOME` to a Java 8+ JDK. |
| SQLite file not created | No write permission | Run the JAR from a writable directory or set `sqlite.path` to a writable location. |
| `JSESSIONID` missing | Cookie not sent in requests | Use `-b` with `curl`, or set `withCredentials=true` in fetch/XHR. |
| Application fails to start | Port 8080 already in use | Stop the conflicting process or change the port: `-Dtomcat.port=9090`. |

---

## Contributing

1. Fork the repository and create a feature branch.  
2. Run `mvn test` – all tests should pass.  
3. Follow the existing code style (CheckStyle, PMD).  
4. Update the README if you add or remove features.  
5. Submit a pull request with a clear description.

Bug reports are welcome. If possible, include a minimal reproducible example.

---

## Changelog

- **2026‑09‑27** – Minor cleanup of README, corrected wording.  
- **2026‑09‑27** – Added screenshot of UI (coming soon).  
- **2026‑09‑18** – Updated badges and table of contents.  
- **2026‑09‑13** – Refactored feature list for clarity.  
- **2026‑09‑04** – Added architecture diagram.  
- **2026‑08‑12** – Added tech‑stack table.

---

## License

MIT – see the `LICENSE` file.
