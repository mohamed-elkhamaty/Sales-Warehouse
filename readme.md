# Data Warehouse project



This project demonstrates a **comprehensive** data warehousing workflow, from building a data warehouse to generating actionable insights.

It highlights industry best practices in data engineering and analytics.

</aside>

<aside>
<img src="https://app.notion.com/icons/folder_gray.svg" alt="https://app.notion.com/icons/folder_gray.svg" width="40px" />

## Project Requirement:

#### building a Data Warehouse

objectives:

develop a modern data warehouse using sql server to consolisate sales data, enabling analytical reporting and informed decision-making.

Specifications:

1. data scources: two data sources (ERP,CRM) as CSV files
2. data quality
3. integration
4. scope: no historization needed
5. documentation

#### BI: Analytical & reporting:

objectives:

develop SQL-based analytics to deliver detailed insights into stakeholders

</aside>

![Screenshot_20260905-081920_YouTube ReVanced.png](documents/DA_process.png)

|  | **bronze layer** | **silver layer** | **gold layer** |
| --- | --- | --- | --- |
| **definition** | the raw data(as-is) | clean and transformed data | data marts |
| obj | traceability & debugging | prepare data for analysis | for reporting |
| **object type** | tables | tables | views |
| l**oad method** | full load (truncate & insert) | full load (truncate & insert) | none |
| **transformation** | none |   1. cleaniing
  2. standardization
  3. normalization
  4. enrichment |   • integration
  •  aggregation
  • business logic & rules |
| **data modelling** | none | none |   • schema
  • aggregated objects
  • flat tables |

Data Architecture

![Data_Architecture_DW.png](Data_Architecture_DW.png)

ETL process

![ETL process](Screenshot_20260905-060314_YouTube_ReVanced.png)

ETL process

Naming conventions

<aside>
<img src="https://app.notion.com/icons/shop_gray.svg" alt="https://app.notion.com/icons/shop_gray.svg" width="40px" />

using snake_case for naming conventions

Table naming conventions: 

- bronze → <source>_<entity> like: crm_customer_info
- silver → <source>_<entity> like: crm_customer_info
- gold → <type>_<entity> like: dim_customers
</aside>

![data integraion](Data_Integration_Diagram.png)

data integraion

Data Model

![data_model.png](data_model.png)

Data Flow through the source & 3 layers

![data_flow.png](data_flow.png)
