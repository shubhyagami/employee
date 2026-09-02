# Employee Management System

A lightweight Java servlet application that stores employee records in an embedded SQLite database. It runs on an embedded Tomcat instance, so you can start a local server with a single command – no external application server needed.

## Badges

[![Java](https://img.shields.io/badge/Java-8-blue)](https://www.oracle.com/java/technologies/javase-jdk8-javadoc.html)
[![Maven](https://img.shields.io/badge/Maven-3%2B-red)](https://maven.apache.org/)
[![SQLite](https://img.shields.io/badge/SQLite-3.45.1-orange)](https://www.sqlite.org/)
[![Tomcat](https://img.shields.io/badge/Tomcat-7-orange)](https://tomcat.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://opensource.org/licenses/MIT)

## Overview

* **Java 8** application
* **Java Servlets** (no external framework)
* **Embedded SQLite** for data persistence
* **Embedded Tomcat 7** via Maven plugin for local development
* **JSP** front‑end with simple HTML/CSS

## Features

| Feature | Description |
|---------|-------------|
| User authentication | Register and log in, with session handling |
| CRUD API | Endpoint `/employees` supports create, read, update, delete |
| Automatic schema creation | Tables are created on first run |
| Stand‑alone | Build a single JAR or run with the embedded Tomcat Maven plugin |
| Simple UI | JSP pages for registration, login, and employee management |

## Tech Stack

| Category      | Technology |
|---------------|------------|
| Language      | Java 8 |
| Web framework | Java Servlet (`javax.servlet`) |
| Database      | SQLite |
| Build tool    | Maven 3+ |
| Server        | Embedded Tomcat 7 |
| Front‑end     | JSP, HTML, CSS |

## Project Structure

```
employee/
├── pom.xml                # Maven configuration
├── mvnw / mvnw.cmd        # Maven wrapper scripts
├── .gitignore
├── README.md
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

## Getting Started

### Prerequisites

* JDK 8 (or newer, code is Java‑8 compatible)
* Maven 3+
* Git

### Quick Setup

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package
mvn tomcat7:run
```

The application is available at:

```
http://localhost:8080/EmployeeManagementSystem/
```

### First Use

1. Open the landing page in a browser.  
2. Register a new account via `reg.jsp`.  
3. Log in with the new account using `sign.jsp`.  
4. Manage employee records through the UI or the `/employees` API.

## API Reference

The REST endpoint follows a standard resource pattern:

* `GET /employees` – List all employees
* `POST /employees` – Create a new employee (`{ "name": "...", "position": "...", "salary": ... }`)
* `GET /employees/{id}` – Retrieve a specific employee
* `PUT /employees/{id}` – Update an employee
* `DELETE /employees/{id}` – Delete an employee

All responses are JSON. The endpoint is protected; a valid session is required.

## Running Tests

```bash
mvn test
```

Unit tests are located under `src/test/java`.

## Contributing

Pull requests are welcome. Please open an issue first to discuss major changes.

## Changelog

* **2026‑09‑02** – Refactored README for clarity, fixed typos, added usage instructions.
* **2026‑08‑21** – Cleaned README and reorganized sections.
* **2026‑08‑12** – Added features list and tech‑stack table.
* **2026‑08‑10** – Polish wording and fixed typos.
* **2026‑08‑05** – Fixed rendering issue on `reg.jsp`.

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
