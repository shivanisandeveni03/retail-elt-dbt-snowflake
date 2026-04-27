# Retail ELT Pipeline — Brazilian E-Commerce Analytics

End-to-end analytics engineering project built on 100K+ real e-commerce transactions. Ingests raw data into Snowflake, transforms it through a dbt-modeled star schema, and surfaces business KPIs across revenue, delivery performance, and seller analytics.

## What this does

Raw CSV data from Olist's Brazilian e-commerce platform lands in Snowflake's RAW schema via a Python ingestion script. dbt then transforms it through two layers — staging (cleaning and typing) and marts (business logic) — producing analytics-ready tables for BI consumption.

## Stack

- **Ingestion:** Python, snowflake-connector-python, pandas
- **Storage:** Snowflake (RAW → STAGING → MARTS)
- **Transformation:** dbt Core with staging/mart layers
- **Testing:** dbt tests (unique, not_null) across all models
- **Version control:** Git + GitHub

## Data

Brazilian E-Commerce Public Dataset by Olist — 9 tables, 100K+ orders, 1M+ geolocation records.

## Project structure