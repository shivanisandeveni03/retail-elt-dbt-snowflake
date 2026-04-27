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
## Key Findings

**Problem:** Olist needed to understand whether delivery delays were caused by seller underperformance or regional logistics failures.

**Finding 1 — Northeastern states have a late delivery crisis**
AL (Alagoas) has a 23.93% late delivery rate, MA 19.67%, PI 15.97% — all 2-3x the national average. These states share one thing: distance from São Paulo, where 80%+ of sellers are based.

**Finding 2 — Northern states are being over-promised**
RR, AP, and AM receive deliveries 17-20 days earlier than estimated. Olist pads estimates so aggressively for remote states that sellers look bad even when performing well.

**Finding 3 — Bad reviews follow geography, not seller quality**
Sellers in AM average a 2.33 review score vs 4.05 in SP — despite meeting their delivery estimates. The 48-day average wait time in AM vs 12 days in SP drives dissatisfaction regardless of estimate accuracy.

**Conclusion:** Delivery underperformance is a last-mile logistics infrastructure problem, not a seller performance issue. Olist should invest in regional fulfillment centers in northeastern Brazil and recalibrate delivery estimates for northern states.
## Dashboard

Live KPI Dashboard: [Olist Delivery Performance — Tableau Public](https://public.tableau.com/app/profile/shivani.sandeveni7417/viz/Olist-Brazil-Delivery-KPI-Dashboard/OlistDeliveryKPIDashboard)