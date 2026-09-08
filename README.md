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

> A SQL project demonstrating relational (OLTP) database design for a small tailoring business, alongside a star-schema data warehouse design for analytical reporting.

**Note:** the warehouse schema above (`fact_orders` and its dimension tables) is defined but not yet populated — there's no ETL script in this repo that loads data from the OLTP tables into it. The analytics queries currently run directly against the OLTP tables, not this star schema. Populating the warehouse and re-pointing the queries at it is a planned next step.

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
## 📈 **Sample Data Results**

The repo currently ships with 15 sample customers, 5 tailors, and 15 orders. Based on that sample data:

| Metric | Value |
|--------|-------|
| **Total Revenue** | ₹30,420 |
| **Completion Rate** | 60% (9 of 15 orders) |
| **Avg Order Value** | ₹2,028 |
| **Customers in sample data** | 15 |

### **Observations from the Sample Data**
- 🏆 **Best completion record**: Ahalya (tailor id 1001) — 3 orders, all completed
- 💰 **Largest single order**: ₹7,800, dated September 2024
- 📍 **Top location by revenue**: Marol (tied to that same ₹7,800 order)
- ⚠️ **Overdue orders**: 6 PENDING orders past their deadline, ₹11,470 combined value at risk

These are descriptive facts drawn from a 15-row sample dataset — not statistically meaningful trends, and there's no earlier baseline in the data to support a claim of "improvement" over time.

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

### **Sample Query Output**
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
