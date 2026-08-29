## E-commerce Customer Experience Investigation
 
A SQL + Power BI analysis of the Olist Brazilian e-commerce dataset, investigating what actually drives good vs. bad customer experience — and where the business can act on it.
 
---
 
## Business Context
 
Olist connects small/medium Brazilian sellers to major marketplaces and handles logistics on their behalf. Customer reviews (1–5 stars) are a key signal of marketplace health, but low scores alone don't tell you *why* customers are unhappy or *what to fix*.
 
This project investigates: **what actually drives a customer to have a good or bad experience, and where should the business focus its efforts to improve it?**
 
---
 
## Key Questions Investigated
 
1. Does delivery performance (on-time vs. late) predict review scores?
2. Which product categories and sellers underperform — and is that caused by delivery, or by the seller/product itself?
3. Does freight cost relative to item price affect satisfaction?
4. Which regions have the worst delivery/satisfaction outcomes, and is that a logistics or seller issue?
5. What would improving delivery accuracy do to overall customer satisfaction?
---
 
## Dataset
 
[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — 9 relational CSVs covering ~100k orders (2016–2018): orders, order items, payments, reviews, customers, sellers, products, geolocation, and category translations.
 
---
 
## Data Architecture: Bronze / Silver / Gold
 
SQL work is organized into three layers to mirror real-world data pipeline design, rather than one flat set of ad-hoc queries.
 
```
sql/
├── 01_bronze/          Raw ingestion — 1:1 copies of source CSVs, no transformation
├── 02_silver/          Cleaned, typed, deduplicated, and joined into analysis-ready tables
└── 03_gold/            Business-level aggregates, one table per question, feeds Power BI directly
```
 
**Bronze** — exact raw load of all 9 tables (`bronze_orders`, `bronze_order_items`, etc.), preserved as source of truth.
 
**Silver** — deduplicated and type-corrected data, translated category names, and a unified `silver_orders_enriched` table joining orders, items, payments, and customer location, with derived fields like `delivery_delay_days`, `is_late`, and `freight_to_price_ratio`.
 
**Gold** — pre-aggregated, dashboard-ready tables built to answer specific business questions, e.g. `gold_review_score_by_delay_bucket`, `gold_seller_performance_ontime_only`, `gold_monthly_revenue`, `gold_rfm_segments`.
 
---
 
## Data Model
 
*(Insert an entity-relationship diagram here — orders as the central fact table, joined to customers, order_items, payments, reviews, products, sellers, and geolocation.)*
 
---

# Power BI Dashboard
 
**Pages:**
- **Executive Overview** — revenue, order volume, AOV, average review score, trend over time
- **Delivery Performance** — on-time vs. late rate by state (map), delay distribution
- **Customer Satisfaction Drivers** — review score by delay bucket, freight-to-price ratio vs. score
- **Seller & Category Performance** — top/bottom performers, on-time-only comparison
- **RFM Segmentation** — customer segments by recency, frequency, monetary value
DAX measures used: YoY/MoM growth, days-late calculated column, RFM segment classification, dynamic KPI cards with conditional formatting.
 
*(Insert dashboard screenshots here.)*
 
---
 
## Key Findings
 
*(Fill in with your actual numbers once queries are run — placeholders below show the format to aim for.)*
 
- Orders delivered late score on average **X** vs. **Y** for on-time orders — delivery timing is the single strongest driver of satisfaction.
- **Z%** of sellers/categories still underperform even on time-delivered orders, pointing to product/seller quality issues independent of logistics.
- Freight cost relative to item price shows a [positive/negative/no] correlation with review score.
- [State/region] shows both the longest delivery times and lowest review scores, suggesting a logistics investment priority.
- Only **W%** of customers are repeat buyers, indicating a retention gap separate from the satisfaction issue.
---
 
## Business Recommendations
 
- Improve delivery estimate accuracy so fewer orders are perceived as "late," even without shipping faster.
- Prioritize logistics investment in the worst-performing regions identified above.
- Audit and support underperforming sellers whose scores stay low even on time-delivered orders.
- Reconsider freight pricing/subsidies for low-cost items where shipping cost feels disproportionate.
---
 
## What I'd Do Next
 
- Bring in geolocation data to model customer-seller distance as a control variable for delivery time.
- Build a simple churn/repeat-purchase prediction model using order and review history.
- Extend the Power BI report with a drill-through from state → seller → order level detail.
---
 
## Tools Used
 
`MySQL` · `Power BI` · `DAX` · `SQL (CTEs, window functions, conditional aggregation)`
 
---

## License

This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.

