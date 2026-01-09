Below is a **clean, professional, GitHub-ready `README.md`** for your **Kubernetes CRUD Project** based exactly on the steps you followed.
You can **copy–paste this directly** into your repo.

---

# Kubernetes CRUD Project (MySQL + Web App)

This project demonstrates deploying a **CRUD (Create, Read, Update, Delete) application** on **Kubernetes** using **Pods, Services, Secrets, ConfigMaps, and StatefulSets**.

The setup follows a **real-world DevOps workflow**, moving from a standalone MySQL Pod to a **StatefulSet-based database deployment**, and finally connecting it with a web application.

---

## 📌 Project Architecture

```
Browser
   |
   v
Web Pod  ----->  Web Service
   |
   v
MySQL StatefulSet  ----->  MySQL Headless Service
```

---

## 🛠 Technologies Used

* Kubernetes
* MySQL 5.6
* PHP Web Application
* ConfigMap
* Secrets
* StatefulSet
* Services (ClusterIP & Headless)

---

## 📂 Repository Branch

This setup is available under the **`k8s` branch**.

```bash
git clone -b k8s https://github.com/RohitRawat891997/CURD-project.git
cd CURD-project
```

---

## 1️⃣ Create MySQL Service (Headless)

Create a headless service for StatefulSet communication:

```bash
kubectl create -f mysql-svc
kubectl get all
```

This service provides **stable DNS** for MySQL pods.

---

## 2️⃣ Create Secrets (Database Credentials)

Create Kubernetes secrets for MySQL credentials:

```bash
kubectl create -f secrets
kubectl get secrets
kubectl get secret web-secrets -o yaml
```

Secrets are used to securely inject:

* MySQL root password
* Database credentials

---

## 3️⃣ Create ConfigMap (Database Initialization)

Create a ConfigMap containing the SQL file:

```bash
kubectl create -f cm
```

This ConfigMap includes:

* Database creation
* Table schema for the `customers` table

---

## 4️⃣ Deploy MySQL as a Pod (Initial Testing)

Before StatefulSet, MySQL was tested using a Pod:

```bash
kubectl create -f mysql-pod
kubectl get pod -w
kubectl exec -it mysql-pod-0 -- bash
```

After verification, the Pod was removed:

```bash
kubectl delete -f mysql-pod
rm -rf mysql-pod
```

---

## 5️⃣ Deploy MySQL Using StatefulSet (Production Approach)

Create the StatefulSet:

```bash
kubectl create -f statefulset
watch kubectl get pod
```

Access MySQL Pod:

```bash
kubectl exec -it mysql-pod-0 -- bash
```

### Why StatefulSet?

* Stable pod names (`mysql-pod-0`)
* Persistent storage (PVC per pod)
* Ideal for databases

---

## 6️⃣ Deploy Web Application Service

Create the web service:

```bash
kubectl create -f web-service
```

This service exposes the web application internally or externally (based on type).

---

## 7️⃣ Deploy Web Application Pod

Deploy the web pod:

```bash
kubectl create -f web-pod
kubectl get all
watch kubectl get all
```

The web pod connects to MySQL using:

* Service DNS
* Secrets
* Environment variables

---

## 8️⃣ Verification & Debugging

Check running resources:

```bash
kubectl get all
```

Access MySQL again if needed:

```bash
kubectl exec -it mysql-pod-0 -- bash
```

---

## ✅ Key Kubernetes Concepts Practiced

* Pods vs StatefulSets
* Headless Services
* ConfigMaps for SQL files
* Secrets for credentials
* Persistent Volumes (PVC)
* Pod-to-Pod communication
* Real database initialization flow

---

## ⚠️ Important Notes

* MySQL init SQL runs **only once** when the data directory is empty
* StatefulSet creates **independent MySQL instances**
* This setup is for **learning & practice**, not MySQL clustering

---

## 🚀 Outcome

You successfully deployed a **Kubernetes-based CRUD application** with:

* Secure credentials
* Persistent database
* Proper service discovery
* Production-style StatefulSet usage

---

## 👤 Author

**Rohit Rawat**
DevOps | Kubernetes | Docker | Linux | AWS

---

Below is a **ready-to-paste Troubleshooting section** you can directly add to your `README.md`.
It’s written in a **GitHub-professional + interview-friendly** way.

---

## 🛠 Troubleshooting

This section covers **common issues** faced during the deployment of this Kubernetes CRUD project and how to fix them.

---

### ❌ Issue 1: MySQL database exists but tables are missing

**Symptom**

```sql
mysql> SHOW DATABASES;
customer_db

mysql> USE customer_db;
mysql> SHOW TABLES;
Empty set
```

**Root Cause**

* MySQL runs SQL files from `/docker-entrypoint-initdb.d` **only once**
* If the data directory (`/var/lib/mysql`) is already initialized (PVC exists), SQL files are skipped
* Using `MYSQL_DATABASE` env var pre-creates the database and prevents SQL execution

**Solution**

1. Remove `MYSQL_DATABASE` from MySQL manifest
2. Update SQL with safe checks:

   ```sql
   CREATE DATABASE IF NOT EXISTS customer_db;
   CREATE TABLE IF NOT EXISTS customers (...);
   ```
3. Delete StatefulSet and PVCs:

   ```bash
   kubectl delete statefulset mysql-pod
   kubectl delete pvc --all
   ```
4. Re-apply manifests

---

### ❌ Issue 2: ConfigMap SQL file not executed

**Symptom**

* SQL file exists but not executed
* No logs showing SQL execution

**Check**

```bash
kubectl exec -it mysql-pod-0 -- ls /docker-entrypoint-initdb.d
```

If `database.sql` exists, ConfigMap is mounted correctly.

**Reason**

* MySQL only executes SQL on **first initialization**
* PVC already contains data

**Fix**

* Delete PVC and recreate pods
  **OR**
* Use an `initContainer` to run SQL manually

---

### ❌ Issue 3: Pod stuck in `CrashLoopBackOff`

**Check logs**

```bash
kubectl logs mysql-pod-0
```

**Common causes**

* Wrong MySQL root password in Secret
* Secret key name mismatch
* Corrupted PVC data

**Fix**

* Verify secret:

  ```bash
  kubectl describe secret web-secrets
  ```
* Ensure secret keys match manifest
* Delete PVC if data is corrupted

---

### ❌ Issue 4: Web app cannot connect to MySQL

**Symptoms**

* Database connection errors in web pod
* PHP errors like `Connection refused`

**Checks**

```bash
kubectl exec -it web-pod -- ping mysql
kubectl exec -it web-pod -- nslookup mysql
```

**Common causes**

* Wrong MySQL service name
* MySQL pod not ready
* Incorrect credentials

**Fix**

* Ensure MySQL Service exists
* Use service DNS name (`mysql`)
* Verify Secrets & env variables

---

### ❌ Issue 5: StatefulSet pods not starting

**Check**

```bash
kubectl describe pod mysql-pod-0
```

**Common causes**

* Missing headless service
* PVC not bound
* StorageClass not found

**Fix**

* Ensure headless service exists:

  ```yaml
  clusterIP: None
  ```
* Verify PVC status:

  ```bash
  kubectl get pvc
  ```
* Check StorageClass name

---

### ❌ Issue 6: Changes not reflecting after update

**Reason**

* StatefulSet preserves PVC data
* ConfigMap changes do not re-run SQL

**Fix**

```bash
kubectl rollout restart statefulset mysql-pod
```

If schema changes are needed:

* Use initContainer
* Or manual migration strategy

---

## 🧠 Important Kubernetes Behavior (Must Know)

* ConfigMap SQL runs **only once**
* PVC data persists across pod restarts
* StatefulSet creates **independent MySQL instances**
* This setup is **not MySQL clustering**

---

## ✅ Debugging Commands Cheat Sheet

```bash
kubectl get all
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- bash
kubectl get pvc
kubectl get cm
kubectl get secret
```

---

## 🎯 Interview Tip

> “When MySQL tables are missing in Kubernetes, the issue is usually PVC persistence and MySQL init script behavior, not ConfigMap attachment.”

---



