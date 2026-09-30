[K[2m  [2mmodel z-ai/glm-5.3-flash failed, trying next...[0m[0m
# Employee Management System

A small Java web application for managing employee records. It uses JSPs and servlets, stores data in SQLite, and runs on an embedded Tomcat 7 server. The whole application is packaged as a single executable JAR, so no external Tomcat installation is needed.

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

* A JSP-based CRUD interface for managing employees.
* A REST API at `/employees` that accepts and returns JSON.
* Cookie-based session handling shared between the UI and API.
* User registration and login.
* Automatic SQLite schema creation on first run.
* A self-contained deployment through embedded Tomcat 7.

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

Open <http://localhost:8080/EmployeeManagementSystem/> to use the web UI.
The REST API is available under the same context path.

To change the default port:

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
