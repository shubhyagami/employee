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

## 🕰️ Contributing – TVA Edition

Welcome, Variant Developer! You are about to step into the Sacred Timeline of the Employee Management System. All contributions must be reviewed by the Time Variance Authority before being allowed to merge. Failure to comply will result in a **reset charge** and possible **pruning** of your pull request.

### 🔧 How to Submit a Change

1. **File a Temporal Variance Report** – Open an issue describing the timeline anomaly (bug) or the new timeline branch (feature). Use the labels `Nexus Event` for features and `Variant` for bugs.

2. **Create a Sacred Branch** – Fork the repository and create a branch named after your TVA case number (e.g., `tva-2026-08-02-add-search`). Never branch from a pruned commit.

3. **Write Code That Does Not Create a Multiversal War** –  
   - Follow the **Java 8** timeline. No lambda-based paradoxes from Java 9+ allowed.  
   - Use the **Servlet 4.0.1** API – we don’t have clearance for Jakarta.  
   - SQLite queries must be parameterized – we prune SQL injection variants on sight.  

4. **Test Your Timeline** – Run `mvn clean test` locally. If the timeline breaks, you will be reprimanded by a Minuteman bot.

5. **Submit a Pull Request** – In your PR description, include:  
   - The TVA case number (issue link).  
   - A description of the temporal impact (what your code does).  
   - A screenshot of the test results (or a signed affidavit from a Variant Hunter).

### 🚨 Code of Conduct

- **No Nexus Events** – Do not introduce breaking changes without prior approval from the Time-Keepers (maintainers).  
- **Respect the Loom** – Keep your commits small and atomic. The Loom cannot process 500-line commits.  
- **No Alioth** – Do not rewrite entire files unless you have an approved Temporal Aura.  
- **Stay on the Sacred Timeline** – All code must pass the build and be compatible with Tomcat 7.

### 🧹 Pruning Process

Once your PR is approved, a **Time-Keeper** will merge it into the Sacred Timeline. Any subsequent commits that break the build will be **pruned** (reverted) without warning.  

---

*“For all time. Always.”*  
– The TVA Temporal Engineering Team