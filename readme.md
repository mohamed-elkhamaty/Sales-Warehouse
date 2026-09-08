# 🏗️ Data Warehouse Project

This project demonstrates a **comprehensive data warehousing workflow**, from building a data warehouse to generating actionable business insights. It highlights industry best practices in data engineering and analytics.

Built entirely on **SQL Server**, the project consolidates raw sales data from two source systems (**CRM** and **ERP**) into a layered warehouse (Bronze → Silver → Gold) following the **Medallion Architecture**, then exposes a clean **Star Schema** in the Gold layer, ready for BI reporting and machine learning use cases.

---

## 📂 Repository Structure

```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── documents/                          # Project documentation and architecture details
│   ├── ETL_process.png                 # shows all different techniquies and methods of ETL
│   ├── data_architecture.png           # shows the project's architecture
│   ├── data_flow.png                   # show the data flow diagram
│   ├── data_models.png                 # show data models (star schema)
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
└── .gitignore                          # Files and directories to be ignored by Git
```



## 🏛️ Data Architecture

The project follows the **Medallion Architecture** (Bronze, Silver, Gold layers):

![Data Architecture](documents/Data_Architecture_DW.png)

![DA Process](documents/DA_process.png)
1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

---

## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications

- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### ETL Process

![ETL Process](documents/ETL_process.png)

---

## 🔤 Naming Conventions

The project uses **snake_case** for all naming conventions.

**Table naming conventions:**

| Layer | Pattern | Example |
|---|---|---|
| Bronze | `<source>_<entity>` | `crm_customer_info` |
| Silver | `<source>_<entity>` | `crm_customer_info` |
| Gold | `<type>_<entity>` | `dim_customers` |

---

## 🔗 Data Integration

![Data Integration](documents/Data_Integration_Diagram.png)

---

## 🗂️ Data Model

![Data Model](documents/data_model.png)

---

## 🔄 Data Flow

Data flow through the source systems and the three layers (Bronze → Silver → Gold):

![Data Flow](documents/data_flow.png)
