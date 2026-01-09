Here is a **clean, beginner-friendly, GitHub-ready `README.md` section** for your **Docker practice (CRUD Project)**.
I’ve converted raw history into **clear steps + explanations**, perfect for learning & interviews.

---

# Docker Practice – CRUD Project (2-Tier Application)

This project demonstrates a **2-tier Docker application** using **Docker Compose**, consisting of:

* **Web Application (PHP)**
* **MySQL Database**

The setup helps you practice **Docker, Docker Compose, containers, networking, and exec usage**.

---

## 📌 Prerequisites

Make sure Docker and Docker Compose are installed:

```bash
docker --version
docker-compose --version
```

---

## 1️⃣ Clone the Project Repository

Clone the CRUD project from GitHub:

```bash
git clone https://github.com/RohitRawat891997/CURD-project.git
```

Move into the project directory:

```bash
cd CURD-project/
```

Verify files:

```bash
ls
```

---

## 2️⃣ Cleanup Old Files (Optional)

Remove unused or old database directory (if present):

```bash
rm -rf database.sql-2-tier
```

> ⚠️ This step is optional and used for clean practice runs.

---

## 3️⃣ Build and Start Containers Using Docker Compose

Build images and start containers in detached mode:

```bash
docker-compose up -d --build
```

### What this command does:

* Builds Docker images
* Creates a Docker network
* Starts MySQL & Web containers
* Runs everything in background (`-d`)

---

## 4️⃣ Verify Running Containers

Check running containers:

```bash
docker ps
```

Expected containers:

* Web container (Apache + PHP)
* MySQL container

---

## 5️⃣ Access MySQL Container

Enter the MySQL container shell:

```bash
docker exec -it curd-project_mysql_1 bash
```

From here, you can:

* Login to MySQL
* Check databases & tables
* Debug database issues

---

## 📂 Project Architecture (2-Tier)

```
Client (Browser)
      |
      v
Web Container (PHP + Apache)
      |
      v
MySQL Container
```

---

## 🧠 Docker Concepts Practiced

* Dockerfile
* Docker Compose
* Multi-container application
* Container networking
* `docker exec`
* Persistent MySQL container usage

---

## ✅ Common Docker Commands Used

```bash
docker ps
docker-compose up -d --build
docker exec -it <container_name> bash
```

---

## 🚀 Result

You successfully deployed a **CRUD application** using:

* Docker
* Docker Compose
* PHP
* MySQL

This is a **real-world beginner-friendly DevOps practice project**.

---

### ✍️ Author

**Rohit Rawat**
DevOps | Docker | Kubernetes | Linux | AWS

---

