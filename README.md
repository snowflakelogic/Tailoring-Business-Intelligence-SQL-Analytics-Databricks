# 🧵 Tailoring Business — DBMS & Data Warehouse Project
## SQL Project - Relational Database + Star Schema Data Warehouse
---
![ER Diagram](Tailoring_Management_Database.drawio.png)

## 🏗️ **Data Architecture & Schema Design**

### **Star Schema Design**
```
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
A MySQL project for managing a small tailoring business using a relational OLTP database and a designed data-warehouse layer. Includes customer, tailor, garment, measurement, order, payment, and order-status data, along with SQL analytics for revenue, tailor performance, customer spending, order status, and overdue orders.
 
Demonstrates relational schema design, primary/foreign keys, joins, aggregation, conditional metrics, date conversion, and dimensional modeling.
 
> **Project status:** The OLTP database, sample data, analytics queries, and warehouse table design are implemented. The supplied SQL does **not** include an ETL process that loads the warehouse, or analytics queries that run against the warehouse.

---

## 🎯 **Project Objectives**

**Problem**: Small tailoring businesses often track orders and payments manually, with no reporting layer.
**Solution**: A normalized operational schema plus a set of SQL analytics queries surfacing revenue, tailor performance, and order-risk insights.

### **Concepts Practiced**
- Relational schema design & normalization
- Star schema / dimensional modeling (design only — not yet loaded)
- Aggregate SQL analytics (GROUP BY, JOINs, CASE-based metrics)
- Business KPI calculation from raw transactional data

---
## SQL Analytics (9 queries, 5 areas)
 
**1. Revenue Analysis** — Monthly revenue (via `STR_TO_DATE`, grouped by month) and revenue by payment method.
 
**2. Tailor Performance** — orders, order value, completion rate per tailor:
 
| Tailor | Orders | Order Value | Completed | Completion Rate |
|---|---:|---:|---:|---:|
| Nikshita | 3 | ₹9,500 | 1 | 33.33% |
| Anamika | 3 | ₹8,300 | 2 | 66.67% |
| Ahalya | 3 | ₹6,550 | 3 | 100.00% |
| Kesha | 3 | ₹4,000 | 2 | 66.67% |
| Ganga | 3 | ₹2,370 | 1 | 33.33% |
 
**3. Operational Insights** — Overdue pending orders (6 orders, ₹11,470 total, based on 2024 sample deadlines) and garment analysis (order count, value, fabric requirements).
 
**4. Customer Analytics** — High-value customers (`HAVING total_spent > 1000`) and geographic distribution of completed orders by address.
 
**5. Business Health Metrics**
 
| Metric | Value |
|---|---:|
| Customers | 15 |
| Orders | 15 |
| Completed orders | 9 |
| Pending orders | 6 |
| Total order value | ₹30,420 |
| Completed order value | ₹18,950 |
| Average order value | ₹2,028 |
| Completion rate | 60% |
 
Order status distribution: COMPLETED 9 orders (60%, ₹18,950), PENDING 6 orders (40%, ₹11,470).
 
---
 
## SQL Techniques Used
 
- Aggregation: `COUNT()`, `SUM()`, `AVG()`, `MAX()`
- Conditional aggregation (`CASE` + `SUM`)
- Date conversion: `STR_TO_DATE(deadline, '%d-%m-%y')`
- Date formatting: `DATE_FORMAT(..., '%Y-%m')`
- Filtering aggregates: `HAVING total_spent > 1000`
- Multi-table joins across customers, orders, tailors, garments, and payments
---
---

## 🎨 **Database Design**

### **Normalized OLTP Schema**
```
customer ──────┐
│              │
├─measurements │
│              ▼
│         order_list ◄──── garment_type
│              │
│              ├─────── my_tailor
│              │
└─────────► payment
             │
        order_status_log
```

**Design principles applied**: normalization, foreign key constraints, an audit trail table (`order_status_log`).

**Known limitation**: `order_list.fid` is declared as a foreign key to `customer(cid)`, but some analytics queries also join it against `garment_type.fid` as if it referenced garment type. This only works in the sample data because both tables happen to use IDs 1–15 — it isn't a real or enforced relationship, and would break with real-world data. This should be fixed (e.g. split into two separate, properly named FK columns) before treating the schema as a reference design.

---

## 🛠️ **Technical Stack**

| **Component** | **Technology** |
|---------------|----------------|
| **Data Storage** | MySQL 8.0 |
| **OLTP Schema** | Normalized relational tables |
| **Warehouse Schema** | Star schema (designed, not yet populated) |
| **Analytics** | Standard SQL — joins, GROUP BY, CASE, aggregate functions |

---

## 🚀 **Quick Start**

```bash
# Clone and set up
git clone https://github.com/snowflakelogic/Tailoring-DMBS-And-Data-Warehouse.git

# Load the OLTP schema and sample data
mysql -u root -p < schema/tailor_schema.sql
mysql -u root -p tailor < data/sample_data.sql

# (Optional) create the empty warehouse schema
mysql -u root -p < schema/tailor_dw_schema.sql

# Run the analytics queries
mysql -u root -p tailor < analytics/business_intelligence.sql
```

*(Adjust the paths above to match how the SQL files are actually organized in the repo. The database is `tailor` — `tailor_dbms`, referenced in an earlier draft of this README, doesn't exist in the schema.)*

### **Sample Query Output - code block**
```
+----------+--------------+------------------+
| month    | total_orders | monthly_revenue  |
+----------+--------------+------------------+
| 2024-04  |            3 |             1050 |
| 2024-09  |            1 |             7800 |
+----------+--------------+------------------+
```

---

## 🎯 **Concepts Covered**

- Relational schema design & normalization (customer, tailor, garment, order, payment tables)
- Star schema / dimensional modeling for a future data warehouse
- SQL aggregation, joins, and conditional (`CASE`) logic for KPI queries
- Basic audit logging via `order_status_log`

---

## 📊 **Project Contents**

- **8 OLTP tables** (customer, tailor, garment_type, measurements, order_list, payment, order_status_log, plus junction tables) and **7 warehouse tables** (1 fact + 6 dimensions, currently unpopulated)
- **9 SQL analytics queries** across revenue, tailor performance, overdue orders, garment popularity, and customer analysis
- **15 rows of sample data** per core table, for demonstration purposes only

---

## 📌 **Next Steps**

- [ ] Write ETL scripts to populate `tailor_dw` from the OLTP tables
- [ ] Point analytics queries at the star schema instead of raw OLTP tables
- [ ] Fix the `order_list.fid` ambiguity (split into two proper FK columns)
- [ ] Expand the sample dataset for more meaningful aggregate results

---

<div align="center">

⭐ **Star this repo if you find the schema design or queries useful** ⭐

</div>
