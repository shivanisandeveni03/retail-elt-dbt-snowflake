import anthropic
import snowflake.connector

# Connect to Snowflake
conn = snowflake.connector.connect(
    account='tjpznut-ip05563',
    user='SHIVANISANDEVENI',
    password='Shivani@200312',
    warehouse='COMPUTE_WH',
    database='RETAIL_DB',
    schema='RAW',
    role='ACCOUNTADMIN'
)

cursor = conn.cursor()

# Pull KPI data
cursor.execute("""
    SELECT 
        CUSTOMER_STATE,
        ROUND(AVG(AVG_DELIVERY_DAYS), 1) as avg_delivery_days,
        ROUND(AVG(ON_TIME_PCT), 1) as on_time_pct,
        SUM(TOTAL_ORDERS) as total_orders
    FROM FCT_DELIVERY_ANALYTICS
    GROUP BY 1
    ORDER BY avg_delivery_days DESC
    LIMIT 5
""")

results = cursor.fetchall()
conn.close()

# Format data for Claude
kpi_data = "\n".join([
    f"State: {r[0]}, Avg Delivery Days: {r[1]}, On-Time %: {r[2]}, Total Orders: {r[3]}"
    for r in results
])

# Call Claude API
client = anthropic.Anthropic()

message = client.messages.create(
    model="claude-opus-4-5",
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": f"""You are a senior business analyst at Olist, Brazil's largest e-commerce platform.
            
Here are the top 5 states with worst delivery performance this week:

{kpi_data}

Write a concise executive summary (3-4 sentences) explaining:
1. What the data shows
2. Which states need immediate attention
3. One specific business recommendation

Write it as if presenting to the CEO. No bullet points, just clear prose."""
        }
    ]
)

print("=== AI-Generated KPI Summary ===")
print(message.content[0].text)