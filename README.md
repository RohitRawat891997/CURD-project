Below is a **clean, readable, GitHub-ready `README.md` version** of your notes.
I’ve converted raw terminal output into **structured steps**, **clear headings**, and **proper code blocks**, suitable for documentation or a project repo.

---

# LAMP Stack Setup (Apache + PHP + MariaDB) on RHEL / Rocky Linux

This guide explains how to install and configure **Apache, PHP, and MariaDB**, create a database and table, deploy a PHP application, and configure **SELinux** and **Firewall**.

---

## 📌 Prerequisites

* RHEL / Rocky Linux / AlmaLinux (RHEL 9 based)
* Root user access

---

## 1️⃣ Install Required Packages

Install Apache, PHP, MariaDB, and PHP MySQL extension:

```bash
dnf install httpd php php-mysqlnd mariadb-server php-fpm -y
```

> ℹ️ Note:
> Subscription warnings can be ignored for local or lab setups.

---

## 2️⃣ Start and Enable Apache (httpd)

```bash
systemctl start httpd
systemctl enable httpd
```

Verify Apache is running:

```bash
systemctl status httpd
```

---

## 3️⃣ Start and Enable MariaDB

```bash
systemctl start mariadb
systemctl enable mariadb
```

Verify MariaDB status:

```bash
systemctl status mariadb
```

---

## 4️⃣ Secure MariaDB Installation

Run the MariaDB security script:

```bash
mysql_secure_installation
```

### Recommended Options

* Set root password ✅
* Remove anonymous users ✅
* Disallow remote root login ✅
* Remove test database ✅
* Reload privilege tables ✅

This step is **mandatory for production-level security**.

---

## 5️⃣ Login to MariaDB

```bash
mysql -uroot -p
```

---

## 6️⃣ Create Database and Table

### Create Database

```sql
CREATE DATABASE customer_db;
```

### Select Database

```sql
USE customer_db;
```

### Create Table

```sql
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT NOT NULL
);
```

Exit MariaDB:

```sql
exit;
```

---

## 7️⃣ Deploy Web Application Files

### Create HTML & PHP Files

```bash
vim /var/www/html/index.html
vim /var/www/html/submit.php
```

> `index.html` → Frontend form
> `submit.php` → PHP script to insert data into MariaDB

---

## 8️⃣ Restart Apache

```bash
systemctl restart httpd
```

---

## 9️⃣ Configure SELinux for Apache + PHP

Allow Apache to read/write files:

```bash
restorecon -Rv /var/www/html/
chcon -R -t httpd_sys_rw_content_t /var/www/html/
```

> Required when PHP interacts with files or databases on SELinux-enabled systems.

---

## 🔟 Configure Firewall (Allow HTTP)

```bash
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
```

Verify:

```bash
firewall-cmd --list-all
```

---

## ✅ Final Verification Checklist

* Apache running ✔️
* MariaDB running ✔️
* Database & table created ✔️
* PHP files deployed ✔️
* SELinux configured ✔️
* Firewall HTTP allowed ✔️

---

## 📂 Important Paths

| Component      | Path             |
| -------------- | ---------------- |
| Web Root       | `/var/www/html/` |
| Apache Config  | `/etc/httpd/`    |
| MariaDB Config | `/etc/my.cnf`    |

---

## 🚀 Result

You now have a **working LAMP stack** with:

* Apache web server
* PHP backend
* MariaDB database
* Secure + production-ready configuration

---

### ✍️ Author

**Rohit Rawat**
DevOps | Linux | Docker | Kubernetes | AWS

---
