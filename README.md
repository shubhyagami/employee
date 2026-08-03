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
- Java code must be **free of temporal loops** (no infinite loops or recursion without escape).
- Use **javax.servlet** (not jakarta – we live in the Java 8 timeline).
- SQLite queries must be **prepared statements** – never raw string concatenation (that’s a **Variant**).
- JSP files should contain **minimal scriptlets** – prefer JSTL or EL (as per the **Sacred Timeline of best practices**).

### ✅ Pull Request – The Judgment
1. Ensure your changes **don’t prune** existing functionality – run `mvn clean test` (if tests exist) or manually test the app.
2. Update the **README** if you add new endpoints or change the project structure.
3. Request a review from a **TVA Analyst** (any collaborator).
4. Once approved, a **Minuteman** (maintainer) will merge your branch into the **Sacred Timeline** (main branch).

### 📜 Legal Notice
By contributing, you agree that your code is **not a Nexus event** – it will not create a branch that could destroy the multiverse of this project. All contributions fall under the **MIT License** (Section 7B – Temporal Clause).

**For the preservation of the Sacred Timeline!**  
– *The Time Variance Authority*

---

## 🧩 Fun Facts (Bonus Section – Because Time is Relative)

| Fact | Detail |
|------|--------|
| 🐱 **Hidden Cat** | The `DatabaseInitializer.java` contains a comment `// meow` that only appears if you open the file at exactly 13:37 UTC. |
| 🕶 **Oblivion Easter Egg** | Typing `?variant=yes` on the login page triggers a hidden `<div>` that says “This timeline is now pruned.” |
| ⏳ **First Commit** | The initial commit message was “Let there be employees.” – a reference to the Big Bang of project management. |
| 🧑‍💻 **Tomcat 7** | Yes, we use Tomcat 7 in 2026. Some timelines never change. |