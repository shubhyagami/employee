[K[2m  [2mmodel z-ai/glm-5.3-flash failed, trying next...[0m[0m
[K[2m  [2mmodel deepseek-ai/deepseek-v4.1-flash failed, trying next...[0m[0m
# Employee Management System

A lightweight Java EE web application that stores employee records in an embedded SQLite database and runs on a bundled Tomcat 7 server.  
It is packaged as a single executable JAR – just run it and the server starts automatically.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)  
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)  
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)  
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)  
![MIT](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)  
![CI](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
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

The application provides:

* A JSP‑based CRUD interface for managing employees.
* A RESTful API (`/employees`) that returns and accepts JSON.
* Cookie‑based session handling shared between the UI and API.
* Automatic SQLite schema creation on the first run.
* A self‑contained deployment through an embedded Tomcat 7.

Only a Java 8+ runtime is required on the target machine.

---

## Getting Started

```bash
# 1. Clone
git clone https://github.com/shubhyagami/employee.git
cd employee

# 2. Build the fat JAR
mvn clean package          # or ./mvnw clean package

# 3. Run
java -jar target/employee-jar-with-dependencies.jar
```

Open <http://localhost:8080/EmployeeManagementSystem/> to access the web UI.  
The API is available under the same context path.

> **Tip** – Change the default port:
> ```
> java -Dtomcat.port=9090 -jar target/employee-jar-with-dependencies.jar
> ```

---

## Features

| Feature | Description |
|---------|-------------|
| **JSP UI** | Server‑side CRUD pages for employees. |
| **REST API** | CRUD endpoints at `/employees` (GET, POST, PUT, DELETE). |
| **Session Auth** | Cookie‑based `JSESSIONID` shared across UI and API. |
| **User Accounts** | Registration and login, with sessions that survive restarts. |
| **Embedded Runtime** | Single JAR with Tomcat 7 and SQLite JDBC driver. |
| **Auto‑Schema** | Database schema is created automatically on first launch. |

---

## Architecture

```
employee/
├─ pom.xml
├─ src/
│  ├─ main/
│  │  ├─ java/          # Servlets, DAOs, utilities
│  │  └─ webapp/
│  │     ├─ WEB-INF/   # web.xml
│  │     └─ jsp/        # JSP pages (index.jsp, reg.jsp, sign.jsp, …)
└─ target/
   └─ employee-jar-with-dependencies.jar
```

The JAR bundles:

* Embedded Tomcat 7
* SQLite JDBC driver
* All compiled classes

On startup it listens on `localhost:<port>` (default 8080) with the context path `EmployeeManagementSystem`.

---

## Prerequisites

| Tool | Minimum version | Verify |
|------|-----------------|--------|
| JDK  | 8+              | `java -version` |
| Maven | 3+ | `mvn -version` |
| Git   | any | `git --version` |

---

## Build & Run

### 1. Build

```bash
mvn clean package          # or ./mvnw clean package
```

The executable JAR appears in `target/employee-jar-with-dependencies.jar`.

### 2. Run

```bash
java -jar target/employee-jar-with-dependencies.jar
```

### 3. (Optional) Run with Maven Tomcat plugin

```bash
mvn tomcat7:run          # or ./mvnw tomcat7:run
```

---

## Configuration

Command‑line system properties override defaults:

| Property | Purpose | Default |
|----------|---------|---------|
| `tomcat.port` | Tomcat listening port | `8080` |
| `sqlite.path` | Location of the SQLite database file | `${user.dir}/employee.db` |

Example:

```bash
java -Dtomcat.port=9090 -Dsqlite.path=/data/employee.db \
    -jar target/employee-jar-with-dependencies.jar
```

---

## REST API

All endpoints are under `/EmployeeManagementSystem`.  
After a successful login, include the `JSESSIONID` cookie with each request.

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET`  | `/employees` | List all employees |
| `POST` | `/employees` | Create a new employee |
| `PUT` | `/employees/{id}` | Update an existing employee |
| `DELETE` | `/employees/{id}` | Delete an employee |

### Example – Create an employee

```bash
curl -X POST \
  http://localhost:8080/EmployeeManagementSystem/employees \
  -H 'Content-Type: application/json' \
  -b 'JSESSIONID=YOUR_COOKIE' \
  -d '{"name":"Alice","role":"Developer","salary":70000}'
```

---

## Web UI

| Page | URL | Purpose |
|------|-----|---------|
| Register | `/EmployeeManagementSystem/reg.jsp` | Create a new user |
| Login | `/EmployeeManagementSystem/sign.jsp` | Authenticate |
| Dashboard | `/EmployeeManagementSystem/` | CRUD operations on employees |

The UI uses server‑side JSP rendering and shares the same session cookie as the API.

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| `invalid source release 8` | `JAVA_HOME` points to a JDK older than 8 | Set `JAVA_HOME` to a Java 8+ installation |
| SQLite file not created | Lack of write permission | Run the JAR from a writable directory or set `-Dsqlite.path` to a writable location |
| `JSESSIONID` missing | Cookie not sent in requests | Use `-b` with `curl` or set `withCredentials=true` in browser fetch/XHR |
| Application fails to start | Port 8080 already in use | Stop the conflicting process or change the port with `-Dtomcat.port=9090` |

---

## Contributing

1. Fork the repository and create a feature branch.  
2. Run `mvn test` – all tests should pass.  
3. Follow the existing coding style (CheckStyle, PMD).  
4. Update the README if you add or remove features.  
5. Submit a pull request with a clear description.

Bug reports are welcome; please include a minimal reproducible example if possible.

---

## Changelog

- **2026‑09‑27** – Minor README cleanup, corrected wording.  
- **2026‑09‑18** – Updated badges and table of contents.  
- **2026‑09‑13** – Refactored feature list.  
- **2026‑09‑04** – Added architecture diagram.  
- **2026‑08‑12** – Added tech‑stack badges.

---

## License

MIT – see the `LICENSE` file.
