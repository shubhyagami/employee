# Employee Management System

A lightweight Java servlet application that stores employee records in an embedded SQLite database and runs on an embedded Tomcat instance – no external servers needed.

![Java 8](https://img.shields.io/badge/Java-8-blue?logo=java)
![Maven 3+](https://img.shields.io/badge/Maven-3%2B-red?logo=maven)
![SQLite 3.45](https://img.shields.io/badge/SQLite-3.45.1-orange?logo=sqlite)
![Tomcat 7](https://img.shields.io/badge/Tomcat-7-orange?logo=apache-tomcat)
![MIT License](https://img.shields.io/badge/License-MIT-yellow?logo=opensourceinitiative)

---

## Features

- **User authentication** – register, log in, and maintain sessions.
- **RESTful CRUD API** – `GET`, `POST`, `PUT`, `DELETE` on `/employees`.
- **Automatic schema creation** – tables are generated on first run.
- **Standalone deployment** – a single fat JAR, or use the embedded Tomcat Maven plugin for local development.
- **Simple front‑end** – JSP pages for registration, login, and employee management.

---

## Tech Stack

| Category     | Technology |
|--------------|------------|
| Language     | Java 8 |
| Web framework | Java Servlet (`javax.servlet`) |
| Database     | SQLite |
| Build tool   | Maven 3+ |
| Server       | Embedded Tomcat 7 |
| Front‑end    | JSP, HTML, CSS |

---

## Project Structure

```
employee/
├── pom.xml          # Maven configuration
├── mvnw             # Maven wrapper (Unix)
├── mvnw.cmd         # Maven wrapper (Windows)
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

The context path is defined in `WEB‑INF/web.xml`; by default the application is exposed at `http://localhost:8080/EmployeeManagementSystem/`.

---

## Getting Started

### Prerequisites

- **JDK 8** (Java 8 compatible; newer JDKs work too)
- **Maven 3+**
- **Git**

### Quick Setup

```bash
# Clone the repository
git clone https://github.com/shubhyagami/employee.git
cd employee

# Build the application (creates a fat JAR in target/)
mvn clean package

# Run the embedded Tomcat server
mvn tomcat7:run
```

> **Tip** – You can skip the Maven build step if you prefer the pre‑built JAR: `java -jar target/employee-jar-with-dependencies.jar`.

The web application will be available at `http://localhost:8080/EmployeeManagementSystem/`.

### First Use

1. Open the landing page in a browser.  
2. Register a new user via **reg.jsp**.  
3. Log in with the new account using **sign.jsp**.  
4. Use the UI or the `/employees` REST endpoint to create, read, update, or delete employee records.

---

## API

All responses are JSON. Authentication is required for non‑GET requests; a session cookie is issued upon successful login.

| Method | URL                     | Description                     |
|--------|------------------------|---------------------------------|
| GET    | `/employees`           | List all employees.             |
| POST   | `/employees`           | Create a new employee.          |
| PUT    | `/employees/{id}`      | Update an existing employee.     |
| DELETE | `/employees/{id}`      | Remove an employee.             |

Use the `Authorization` header or session cookie for non‑GET calls.

---

## Contributing

Pull requests are welcome. Before submitting:

1. Run the test suite: `mvn test`.  
2. Ensure code follows the existing style (indentation, naming).  
3. Update documentation when adding or changing features.

---

## Changelog

- **2026-09-02** – README cleaned up, sections reorganised.  
- **2026-08-21** – Minor wording edits.  
- **2026-08-12** – Added feature list and tech‑stack table.  
- **2026-08-10** – Fixed typos.  
- **2026-08-05** – Fixed rendering issue on `reg.jsp`.

---

## License

MIT – see the `LICENSE` file.
