# Employee Management System

![Java](https://img.shields.io/badge/Java-8-blue) 
![Servlet](https://img.shields.io/badge/Servlet-4.0.1-orange) 
![SQLite](https://img.shields.io/badge/SQLite-3.45.1.0-green) 
![Maven](https://img.shields.io/badge/Maven-3%2B-red) 
![Tomcat](https://img.shields.io/badge/Tomcat-7-important) 
![License](https://img.shields.io/badge/License-MIT-yellow)

A Java Servlet-based employee management web app using SQLite for data storage. No external database server required.

## Tech Stack

| Component          | Technology                     |
|--------------------|--------------------------------|
| Language           | Java 8                         |
| Web Framework      | Java Servlet (javax.servlet)   |
| Database           | SQLite                         |
| Build Tool         | Maven 3+                       |
| Server             | Tomcat 7 (embedded via plugin) |
| Frontend           | JSP, HTML, CSS                 |

## Project Structure

```
EmployeeManagementSystem/
├── pom.xml                          # Maven config with dependencies
├── mvnw / mvnw.cmd                  # Maven wrapper scripts
├── .gitignore
├── README.md
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/demo1/
│       │       ├── Employee.java           # Employee model
│       │       ├── EmployeeServlet.java    # CRUD servlet (/employees)
│       │       ├── DatabaseUtil.java       # SQLite connection & table init
│       │       └── DatabaseInitializer.java# Auto-runs table creation on startup
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                 # Web app descriptor
│           ├── index.jsp                   # Landing page
│           ├── reg.jsp                     # Registration form
│           ├── register.jsp                # Registration action (SQL insert)
│           ├── sign.jsp                    # Login form
│           ├── check.jsp                   # Login action (auth check)
│
```

---

## 🌀 Contributing – TVA Temporal Engineer’s Guide

Greetings, Time-Keeper! You’ve been recruited by the **Time Variance Authority** to help maintain the **Sacred Timeline** of this Employee Management System. Every pull request must be **approved by a Variant Analyst** to avoid branching into a nexus event. Follow these protocols:

### 🕰 Pruning a Bug (Filing an Issue)
- Scan the timeline for **anomalies** (bugs, missing features, broken JSP).
- Open an issue with the prefix `[NEXUS]` if it threatens the **Sacred Timeline**.
- Describe the **inciting incident** (steps to reproduce) and the **expected timeline** (desired behavior).

### 🌐 Submitting a New Branch
- Fork the repository into your own **Minuteman Unit**.
- Name your branch like a TVA case file: `TVA-<issue-number>-<short-description>` (e.g., `TVA-42-fix-login-auth`).
- Keep your commits **chronologically pure** – no resetting the timeline.

### 🛠 Code Standards (The TVA Style Guide)
- Java code must be **free of 

---

## 🚀 Quick Start

Get this employee management system running in your own timeline in minutes.

### Prerequisites

- Java 8 JDK
- Maven 3+
- Apache Tomcat 7 (or use the embedded plugin as described below)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/shubhyagami/employee.git
   cd employee
   ```

2. **Build the project with Maven**
   ```bash
   mvn clean package
   ```

3. **Run with embedded Tomcat**
   ```bash
   mvn tomcat7:run
   ```
   The app will be available at `http://localhost:8080/EmployeeManagementSystem/`.

4. **Access the app**
   - Open your browser to the landing page.
   - Register a new user via `reg.jsp`.
   - Log in via `sign.jsp`.
   - Manage employees through the servlet at `/employees`.

> ⏳ **TVA Note:** If the database does not auto-initialize, run the `DatabaseInitializer` manually by visiting `/init` (if configured) or restart the server.

---

## 📅 Changelog – 2026-08-05

| Nexus Event ID | Description                                                  | Status   |
|----------------|--------------------------------------------------------------|----------|
| TVA-2026-08-05 | Added Quick Start guide to README for new Time-Keepers       | ✅ Closed |
| TVA-2026-08-05 | Enhanced project documentation with TVA-style changelog      | ✅ Closed |
| TVA-2026-08-05 | Fixed minor JSP rendering anomaly on `reg.jsp`               | ✅ Pruned |

---

## 🧠 Pro Tips – From the TVA Archives

- **SQLite is single‑writer** – do not run concurrent write operations from multiple browser tabs.
- **Session management** – the login uses a simple session attribute `user`. For production, consider using a proper authentication filter.
- **Debugging** – enable Tomcat’s `HTTP` logging or check `catalina.out` for timeline‑breaking exceptions.
- **Extending the model** – to add fields, update `Employee.java`, the SQLite schema in `DatabaseUtil.java`, and the corresponding JSP forms.

---

## ⏳ Weekly Highlight – This Time Variance

> **“The Sacred Timeline must be preserved. Every commit is a reset charge.”**  
> – Mobius M. Mobius, TVA Analyst

This week the TVA observed **0 timeline branchings** in this repository. Keep your pull requests clean and your commits atomic. Remember: a single nexus event can collapse an entire project timeline.

---

*Maintained by the TVA Temporal Engineering Division – Variant ID: shubhyagami*