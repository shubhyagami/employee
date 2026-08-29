# Employee Management System  

[![Java](https://img.shields.io/badge/Java-8-blue)](https://www.oracle.com/java/technologies/javase-jdk8-javadoc.html)  
[![Maven](https://img.shields.io/badge/Maven-3%2B-red)](https://maven.apache.org/)  
[![SQLite](https://img.shields.io/badge/SQLite-3.45.1-orange)](https://www.sqlite.org/)  
[![Tomcat](https://img.shields.io/badge/Tomcat-7-orange)](https://tomcat.apache.org/)  
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://opensource.org/licenses/MIT)  

A lightweight Java servlet application that manages employee records using an embedded SQLite database. It runs with an embedded Tomcat instance, making it ideal for local development and quick prototyping.

## Features  

- **User Authentication** – Secure registration and login with session handling.  
- **CRUD Operations** – Create, read, update, and delete employee records via the `/employees` endpoint.  
- **Embedded Database** – SQLite automatically initializes the schema on startup, eliminating external DB setup.  
- **Local Development Friendly** – Embedded Tomcat Maven plugin removes the need for a separate server installation.  

## Tech Stack  

| Component      | Technology                               |
|----------------|------------------------------------------|
| Language       | Java 8                                   |
| Web Framework  | Java Servlet (`javax.servlet`)          |
| Database       | SQLite                                   |
| Build Tool     | Maven 3+                                 |
| Server         | Tomcat 7 (embedded via Maven plugin)     |
| Frontend       | JSP, HTML, CSS                           |

## Project Structure  

```
employee/
├── pom.xml                     # Maven configuration and dependencies
├── mvnw / mvnw.cmd             # Maven wrapper scripts
├── .gitignore
├── README.md
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/demo1/
│       │       ├── Employee.java          # Model class
│       │       ├── EmployeeServlet.java   # CRUD servlet (/employees)
│       │       ├── DatabaseUtil.java      # SQLite connection & table init
│       │       └── DatabaseInitializer.java # Auto‑creates tables on startup
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                # Web application descriptor
│           ├── index.jsp                  # Landing page
│           ├── reg.jsp                    # Registration form
│           ├── register.jsp               # Registration processing
│           ├── sign.jsp                   # Login form
│           └── check.jsp                  # Login authentication
```

## Getting Started  

### Prerequisites  

- Java 8 JDK  
- Maven 3+  
- Git  

### Quick Setup  

```bash
git clone https://github.com/shubhyagami/employee.git
cd employee
mvn clean package
mvn tomcat7:run
```

The application starts at `http://localhost:8080/EmployeeManagementSystem/`.

### First Use  

1. Open the landing page in a browser.  
2. Register a new user via `reg.jsp`.  
3. Log in with the newly created account using `sign.jsp`.  
4. Manage employees through the `/employees` endpoint.  

## Changelog (selected)  

- **2026‑08‑21** – Cleaned up README and reorganized sections.  
- **2026‑08‑12** – Added clear feature list and tech‑stack table.  
- **2026‑08‑10** – Polished wording and fixed minor typos.  
- **2026‑08‑05** – Fixed rendering issue on `reg.jsp`.  

## License  

This project is licensed under the MIT License. See the `LICENSE` file for details.
