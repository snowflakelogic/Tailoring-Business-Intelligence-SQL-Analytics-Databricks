# 🧵Tailoring Business Management — SQL & Data Warehouse

A MySQL project combining a **relational OLTP database** with a **star-schema data warehouse design** for a small tailoring business. The project covers customer management, measurements, garments, orders, payments, tailor assignments, status tracking, and SQL-based business analysis.

> **Project Status:** OLTP schema, sample data, analytics queries, and warehouse schema are implemented. ETL and warehouse population are not yet implemented; current analytics run against the OLTP database.

---

## 🗂️ ER Diagram

![ER Diagram](Tailoring_Management_Database.drawio.png)

---

## 🏗️ Data Architecture & Schema Design

### ⭐ Star Schema Design

```text
                    dim_customer
                (customer_key,...)
                       |
                       |
                   dim_tailor
                (tailor_key,...)
                       |
                       |
dim_payment ---->   fact_orders   <---- dim_garment
(payment_key)     (order_key,...)      (garment_key)
                       |
                       |
                   dim_date
                (date_key,...)
                       |
                       |
                   dim_status
                (status_key,...)
```

The warehouse contains **1 fact table and 6 dimension tables**. Surrogate keys are used in the dimensions.

The star schema is currently implemented at the **database-definition level**. No ETL process is included yet to load data from the OLTP database.

---

## 🎯 Project Objective

Build a relational database for managing tailoring operations and use SQL to generate practical business insights such as:

* Revenue and order-value analysis
* Tailor performance
* Pending and overdue orders
* Garment popularity
* Customer spending
* Geographic distribution
* Order-status metrics

---

## 🧠 Skills Demonstrated

### Database

* Relational database design
* Primary & foreign keys
* Referential integrity
* Entity relationships
* Audit/status logging
* Normalization principles

### SQL

* `JOIN`
* `GROUP BY`
* `HAVING`
* `CASE`
* `COUNT()`
* `SUM()`
* `AVG()`
* `MAX()`
* `STR_TO_DATE()`
* `DATE_FORMAT()`
* `DATEDIFF()`
* Conditional aggregation

### Data Warehousing

* Star schema
* Fact & dimension tables
* Surrogate keys
* OLTP vs. analytical database design

---

## 🗄️ Database Design

### OLTP Database

The `tailor` database contains **9 tables**:

| Table                    | Purpose                                      |
| ------------------------ | -------------------------------------------- |
| `customer`               | Customer information                         |
| `my_tailor`              | Tailor information                           |
| `garment_type`           | Garment and fabric details                   |
| `measurements`           | Customer measurements                        |
| `order_list`             | Orders, deadlines, prices, status and tailor |
| `payment`                | Payment information                          |
| `order_status_log`       | Status-change history                        |
| `customer_order_details` | Customer/order associations                  |
| `customer_order_payment` | Customer/order/payment associations          |

### Data Warehouse

The `tailor_dw` database contains:

* `fact_orders`
* `dim_customer`
* `dim_tailor`
* `dim_garment`
* `dim_payment`
* `dim_date`
* `dim_status`

---

## 📊 Sample Dataset

| Entity             | Records |
| ------------------ | ------: |
| Customers          |      15 |
| Tailors            |       5 |
| Garment types      |      15 |
| Measurements       |      15 |
| Orders             |      15 |
| Payments           |      15 |
| Status log records |      16 |

The dataset is a small demonstration dataset, not production-scale data.

---

## 📈 SQL Analytics

The project contains **9 analytical queries across 5 areas**.

### 1. Revenue Analysis

* Monthly completed-order analysis
* Payment value by payment method
* Average order value

### 2. Tailor Performance

* Order count
* Order value
* Average order value
* Completed orders
* Completion rate

### 3. Operational Insights

* Overdue pending orders
* Days overdue
* Garment order count and value
* Fabric requirements

### 4. Customer Analytics

* High-value customers using `HAVING`
* Total spending
* Average order value
* Customer geographic distribution

### 5. Business Health

* Total orders
* Completed/pending orders
* Total order value
* Completed order value
* Completion rate
* Order-status distribution

### Sample Results

Based on the supplied 15 orders:

| Metric                |   Value |
| --------------------- | ------: |
| Total orders          |      15 |
| Completed orders      |       9 |
| Pending orders        |       6 |
| Total order value     | ₹30,420 |
| Completed order value | ₹18,950 |
| Average order value   |  ₹2,028 |
| Completion rate       |     60% |
| Pending overdue value | ₹11,470 |

These figures describe the supplied sample data only.

---

## ⚠️ Known Schema Limitation

`order_list.fid` currently has a foreign key to `customer(cid)`:

```sql
FOREIGN KEY (fid) REFERENCES customer(cid)
```

However, some analytics queries also use `fid` as a garment identifier:

```sql
JOIN garment_type gt ON gt.fid = ol.fid
```

The sample data happens to use IDs `1–15` in both tables, so the joins return results, but this is not a correctly modeled relationship.

### Planned Fix

Replace the ambiguous column with separate identifiers:

```text
customer_id
garment_id
```

and create independent foreign keys.

Other improvements include using proper `DATE` and `DECIMAL` data types and adding missing foreign-key constraints to association tables.

---

## 🚀 Quick Start

### 1. Create the OLTP database

```bash
mysql -u root -p < schema/tailor_schema.sql
```

### 2. Load sample data

```bash
mysql -u root -p tailor < data/sample_data.sql
```

### 3. Create the warehouse schema

```bash
mysql -u root -p < schema/tailor_dw_schema.sql
```

### 4. Run analytics

```bash
mysql -u root -p tailor < analytics/business_intelligence.sql
```

> Analytics currently run against the `tailor` OLTP database, not the warehouse.

---

## 📁 Project Structure

```text
Tailoring-DMBS-And-Data-Warehouse/
│
├── schema/
│   ├── tailor_schema.sql
│   └── tailor_dw_schema.sql
│
├── data/
│   └── sample_data.sql
│
├── analytics/
│   └── business_intelligence.sql
│
├── Tailoring_Management_Database.drawio.png
│
└── README.md
```

---

## 🔮 Next Steps

* [ ] Fix the ambiguous `order_list.fid` relationship
* [ ] Improve data types (`DATE`, `DECIMAL`, etc.)
* [ ] Add missing foreign-key constraints
* [ ] Implement ETL from OLTP → Data Warehouse
* [ ] Populate fact and dimension tables
* [ ] Run analytics against the star schema
* [ ] Expand the sample dataset

---

## 🛠️ Tech Stack

**MySQL 8.0 · SQL · Relational Database · Data Warehousing · Star Schema**
