# Employee Management System

[![Java](https://img.shields.io/badge/Java-8-blue)](https://www.oracle.com/java/technologies/javase-jdk8-javadoc.html)  
[![Maven](https://img.shields.io/badge/Maven-3%2B-red)](https://maven.apache.org/)  
[![SQLite](https://img.shields.io/badge/SQLite-3.45.1-orange)](https://www.sqlite.org/)  
[![Tomcat](https://img.shields.io/badge/Tomcat-7-orange)](https://tomcat.apache.org/)  
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://opensource.org/licenses/MIT)

A lightweight Java servlet application that stores employee records in an embedded SQLite database. It runs in an embedded Tomcat instance so you can get up and running with just a few commands—no external server required.

---

## Features

- **User authentication** – register and log in, with session handling.
- **CRUD API** – `/employees` supports create, read, update, and delete operations.
- **Automatic schema creation** – SQLite tables are created on first run.
- **Standalone deployment** – a single JAR can be run, or you can use the embedded Tomcat Maven plugin for local development.

---

## Tech Stack

| Category      | Technology                           |
|---------------|--------------------------------------|
| Language      | Java 8                                |
| Web framework | Java Servlet (`javax.servlet`)       |
| Database      | SQLite                               |
| Build tool    | Maven 3+                             |
| Server        | Tomcat 7 (embedded via Maven plugin) |
| Front‑end     | JSP, HTML, CSS                       |

---

## Project Structure

```
employee/
├── pom.xml                        # Maven configuration
├── mvnw / mvnw.cmd                # Maven wrapper
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

---

## Getting Started

### Prerequisites

- JDK 8 (or higher – the code is Java‑8 compatible)
- Maven 3+
- Git

### Quick Setup

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package
mvn tomcat7:run
```

The web app is available at `http://localhost:8080/EmployeeManagementSystem/`.

### First Use

1. Open the landing page in a browser.  
2. Register a new user via `reg.jsp`.  
3. Log in with your new account using `sign.jsp`.  
4. Use the `/employees` endpoint (or the UI pages) to manage employee records.

---

## Changelog

- **2026‑08‑21** – Cleaned the README and reorganized sections.  
- **2026‑08‑12** – Added a clear feature list and tech‑stack table.  
- **2026‑08‑10** – Polished wording and fixed typos.  
- **2026‑08‑05** – Fixed rendering issue on `reg.jsp`.

---

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
