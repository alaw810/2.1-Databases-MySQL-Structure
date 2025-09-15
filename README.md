# 📘 SQL Database Modeling

## 📄 Description – Exercise Statements

This repository contains three MySQL exercises focused on relational modeling, normalization, and basic querying.

### Level 1 — Exercise 1: Optics (“Cul d’Ampolla”)
Design a database for an optician to manage suppliers, brands, glasses, customers, employees, and sales.

**Key rules**
- Each **brand** is purchased from **exactly one supplier** (a supplier can provide multiple brands).
- For **glasses**, store brand, frame type (floating/pasta/metal), frame colour, **left/right lens graduation and colour**, and price.
- For **customers**, store name, postal address, phone, email, registration date, and (optionally) the **referring customer**.
- Track which **employee** sold each pair of glasses.

### Level 1 — Exercise 2: Pizzeria
Model a food delivery system with customers, geography, stores, employees, products, categories, and orders.

**Key rules**
- **Geography**: `provinces` and `localities` in separate tables (a locality belongs to one province).
- **Customers**: first/last name, address, postal code, locality, phone.
- **Stores**: address, postal code, locality.
- **Employees**: first/last name, NIF, phone, role (`cook` / `delivery`), **one store per employee**.
- **Products**: pizzas, burgers, drinks (name, description, image, price). **Pizzas** belong to **one category**; categories can change names over the year.
- **Orders**: header (datetime, `delivery`/`pickup`, total, store, customer) + **order items** (product, quantity, **unit price snapshot**). For deliveries, record **who delivered** and **when**.

### Level 2 — Exercise 1: YouTube
Create a simplified YouTube schema with users, channels, videos, tags, subscriptions, playlists, comments, views, and reactions.

**Key rules**
- **Users**: email (unique), password hash, username, date of birth, sex, country, postal code.
- **Channels**: one channel per user (name, description, creation date).
- **Videos**: title, description, filename, size, duration, thumbnail, **state** (`public`/`hidden`/`private`), publish datetime, and counters (views, likes, dislikes).
- **Tags** (N–N via `video_tags`), **subscriptions** (user → channel), **playlists** (public/private), **comments**, **reactions** to videos/comments (one per user per target), and **view events**.

---

## 💻 Technologies Used
- **MySQL 8.0+**
- **MySQL CLI** or **MySQL Workbench**
- Docker
- Git & GitHub

---

## 📋 Requirements
- MySQL **8.0 or newer**
- MySQL Workbench or another SQL client
- Text/code editor
- Git for version control

---

## 🛠️ Installation
1. **Clone** the repository:
   ```bash
   git clone https://github.com/alaw810/2.1-Databases-MySQL-Structure
   ```
2. Open the project folder.

3. Open the **.sql** files using your SQL client.

4. Run the creation and insertion scripts in the correct order.


---

## ▶️ Execution

- Execute MySQL Workbench or your preferred MySQL client.

- After the installation you only need to run the **.sql** files with the example queries to verify the database was correctly populated and relational constraints work.

---

## 🌐 Deployment
This project is designed for local execution only. No online or production deployment is required.

