## Project Title

Olist E-Commerce Sales Analytics

## Business Problem

Analyze e-commerce sales performance and build executive dashboard tracking:

- GMV

- AOV

- Orders

- Customer metrics

## Tech Stack

- PostgreSQL (data cleaning & preparation)

- Python (EDA & analysis)

- Power BI (dashboard & KPI reporting)

## Data Pipeline

- Raw data → PostgreSQL

- SQL cleaning & fact table creation

- Python validation & analysis

- Power BI dashboard

## Key Metrics
- Review score

- Late deliveries

- GMV = SUM(order_value)

- AOV = AVG(order_value)

- Total orders = COUNT(order_id)

## Dashboard Preview
<img width="2156" height="1165" alt="Region_Sales" src="https://github.com/user-attachments/assets/2c458408-367e-4b8c-86d2-4207fcd89370" />

<img width="2157" height="1164" alt="Finance" src="https://github.com/user-attachments/assets/c26c6046-7cf3-42f3-bdee-31ed34f54825" />

## Business Insights
- GMV demonstrates seasonality, with significant spikes especially during the Winter.
- AOV showed low volatility and maintained an average of 150 after the year 2017.  

## Recommendations
- Increase marketing spend during Autumn and Winter.
- Focus retention strategy on high-AOV customers.
- Promote high-margin categories to increase GMV.

## To do/improve
- Try out different ensemble methods such as adaboost, gradient boost, XGboost.
- Create pipeline
