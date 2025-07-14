# 📊 Customer Churn Analysis Dashboard

This project explores customer churn behavior using a real-world-style dataset of 10,000 bank customers. It combines **SQL**, **Excel**, and **Tableau** to uncover churn drivers, build KPIs, and create interactive dashboards that are insightful and ready for stakeholder presentations.

---

## 🧠 Project Overview

**Goal:**  
Analyze factors contributing to customer churn and develop visual tools to track churn KPIs and surface at-risk segments.

**Tools Used:**
- **SQL (PostgreSQL):** Data cleaning, querying, advanced aggregations, and subqueries
- **Excel:** Initial preprocessing, derived columns, export formatting
- **Tableau:** Interactive dashboards with filtering, segmentation, KPIs, and visual storytelling

---

## 📁 Dataset Overview

Columns include:
- Customer demographics: `age`, `gender`, `country`, `age_group`
- Banking activity: `balance`, `years_with_bank`, `num_products`, `has_credit_card`, `is_active_member`
- Customer experience: `satisfaction_score`, `has_complaint`, `card_type`
- Target: `has_exited`, `churn_status`

---

## ✅ Key Questions Answered

- What is the overall churn rate?
- Which age groups and countries have the highest churn?
- How do complaints, satisfaction, and activity level impact churn?
- Which card types and product combinations are most associated with retention?
- What segments are at highest risk of churn?

---

## 🧮 SQL Analysis Highlights

- ✅ Subqueries & aggregate functions to calculate churn KPIs  
- ✅ Churn rate breakdowns by age group, country, product usage, and complaints  
- ✅ Multi-level joins and filtering for segmentation  
- ✅ Subquery examples for comparing individuals to group-level averages  
- ✅ No casting errors (`::NUMERIC` avoided for compatibility)

---

## 📊 Tableau Dashboards

> **insert ss**

Includes:
- 📌 **Churn Rate by Segment** (Country, Age Group, Card Type)
- 📌 **Churn Drivers Breakdown** (Complaints, Activity, Satisfaction)
- 📌 **High-Value At-Risk Customers** table
- 📌 **KPI Scorecards** for total churn, churned revenue, average tenure
- 📌 **Interactive Filters** for country, age group, complaint status

---

## 📈 Key Insights

- Customers with **complaints** had a churn rate of **~99%**
- Churn was highest in the **40–59 age group**
- Customers with **1 product** churned far more than those with **2+**
- **Inactive members** and **low satisfaction** scores were strong churn predictors

---

## 💼 Skills Demonstrated

- **SQL:** Joins, GROUP BY, subqueries, filtering, aggregate logic  
- **Data storytelling:** Communicating insights through visuals  
- **Dashboards:** Designing recruiter-facing Tableau dashboards  
- **ETL process:** Cleaning and enriching data using Excel and SQL

---


## 📎 Screenshots

---
