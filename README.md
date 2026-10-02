[K[2m  [2mmodel z-ai/glm-5.3-flash failed, trying next...[0m[0m
# Employee Management System

A small Java web application for managing employee records. The UI is built with JSPs and servlets, data is stored in SQLite, and the app runs on an embedded Tomcat 7 server. Everything ships as a single executable JAR, so no external Tomcat installation is required — only a Java 8+ runtime.

![Java 8+](https://img.shields.io/badge/Java-8%2B-blue?logo=java)
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)
![SQLite 3.45.1](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)
![MIT](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)
![CI](https://github.com/shubhyagami/employee/actions/workflows/maven.yml/badge.svg)

---

## Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Build & Run](#build--run)
- [Configuration](#configuration)
- [REST API](#rest-api)
- [Web UI](#web-ui)
- [Project Layout](#project-layout)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Overview

The application provides:

- A JSP-based CRUD interface for managing employees.
- A REST API at `/employees` that accepts and returns JSON.
- Cookie-based session handling shared between the UI and the API.
- User registration and login.
- Automatic SQLite schema creation on first run.
- A self-contained deployment through embedded Tomcat 7.

Only a Java 8+ runtime is required on the target machine.

---

## Features

| Feature | Description |
| --- | --- |
| JSP UI | Server-rendered CRUD pages for employees. |
| REST API | CRUD endpoints at `/employees` (`GET`, `POST`, `PUT`, `DELETE`). |
| Session auth | Cookie-based `JSESSIONID` shared across the UI and API. |
| User accounts | Registration and login, with sessions that survive restarts. |
| Embedded runtime | Single JAR containing Tomcat 7 and the SQLite JDBC driver. |
| Auto schema | Database tables are created automatically on first launch. |

---

## Getting Started

Clone the repository, build the executable JAR, and run it:

    git clone https://github.com/shubhyagami/employee.git
    cd employee
    mvn clean package
    java -jar target/employee-jar-with-dependencies.jar

Then open <http://localhost:8080/EmployeeManagementSystem/> to use the web UI. The REST API is available under the same context path.

On the first launch the SQLite database file is created in the working directory and the tables are set up automatically.

To run on a different port:

    java -Dtomcat.port=9090 -jar target/employee-jar-with-dependencies.jar

---

## Prerequisites

| Tool | Minimum version | Verify |
| --- | --- | --- |
| JDK | 8+ | `java -version` |
| Maven | 3+ | `mvn -version` |
| Git | any | `git --version` |

---

## Build & Run

### Build

    mvn clean package

This produces `target/employee-jar-with-dependencies.jar`, a runnable JAR that bundles the application, Tomcat 7, and the SQLite JDBC driver.

To compile and run the tests without packaging:

    mvn test

### Run

    java -jar target/employee-jar-with-dependencies.jar

The server starts on port 8080 by default, with the application served under the `/EmployeeManagementSystem/` context path.

---

## Configuration

| Setting | Default | How to change |
| --- | --- | --- |
| HTTP port | `8080` | `java -Dtomcat.port=9090 -jar target/employee-jar-with-dependencies.jar` |
| Context path | `/EmployeeManagementSystem` | Defined in the web application descriptor; rebuild after changing it. |
| Database file | SQLite file created in the working directory | Delete the file and restart to recreate the schema from scratch. |

---

## REST API

All endpoints live under `/employees` and exchange JSON.

| Method | Path | Description |
| --- | --- | --- |
| `GET` | `/employees` | List all employees. |
| `GET` | `/employees/{id}` | Fetch a single employee. |
| `POST` | `/employees` | Create a new employee. |
| `PUT` | `/employees/{id}` | Update an existing employee. |
| `DELETE` | `/employees/{id}` | Delete an employee. |

Requests must carry the session cookie issued after logging in through the web UI, for example:

    curl -b cookies.txt http://localhost:8080/EmployeeManagementSystem/employees

---

## Web UI

The UI covers the full employee lifecycle:

- Register a new account or log in with an existing one.
- Browse the employee list.
- Add, edit, and delete employee records through simple JSP forms.
- Log out, which invalidates the session cookie used by both the UI and the API.

---

## Project Layout

    employee/
    ├── pom.xml                       # Maven build and dependencies
    ├── src/
    │   ├── main/
    │   │   ├── java/                 # Servlets, data access, and models
    │   │   ├── resources/            # Runtime resources
    │   │   └── webapp/               # JSP pages and web.xml
    │   └── test/                     # Unit tests
    └── .github/workflows/maven.yml   # CI build

---

## Troubleshooting

**Port 8080 is already in use.** Start the app with a different port: `java -Dtomcat.port=9090 -jar target/employee-jar-with-dependencies.jar`.

**The root URL returns a 404.** The application is not served at `/`. Use <http://localhost:8080/EmployeeManagementSystem/>.

**The data looks stale or corrupted.** Stop the app, delete the SQLite database file in the working directory, and start it again. The schema is recreated on startup.

**Build fails with an unsupported class version.** Check `java -version` and `mvn -version`; both must use JDK 8 or newer.

---

## Contributing

1. Fork the repository and create a branch off `main`.
2. Keep changes focused and follow the existing code style.
3. Run `mvn clean package` to confirm the project still builds.
4. Open a pull request describing what changed and why.

---

## Changelog

- **2026-10-02** — README cleanup: removed a stray build-log line, tightened wording, and regrouped the sections.
- **1.0** — Initial release: JSP CRUD UI, REST API, SQLite persistence, and embedded Tomcat 7.

See the [commit history](https://github.com/shubhyagami/employee/commits/main) for the full list of changes.

---

## License

Released under the MIT License. See [LICENSE](LICENSE) for details.
