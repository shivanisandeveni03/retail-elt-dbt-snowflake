import pandas as pd
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas

conn = snowflake.connector.connect(
    account='tjpznut-ip05563',
    user='SHIVANISANDEVENI',
    password='Shivani@200312',
    warehouse='COMPUTE_WH',
    database='RETAIL_DB',
    schema='RAW',
    role='ACCOUNTADMIN'
)

csv_files = {
    'ORDERS': 'data/raw/olist_orders_dataset.csv',
    'ORDER_ITEMS': 'data/raw/olist_order_items_dataset.csv',
    'CUSTOMERS': 'data/raw/olist_customers_dataset.csv',
    'PRODUCTS': 'data/raw/olist_products_dataset.csv',
    'SELLERS': 'data/raw/olist_sellers_dataset.csv',
    'PAYMENTS': 'data/raw/olist_order_payments_dataset.csv',
    'REVIEWS': 'data/raw/olist_order_reviews_dataset.csv',
    'GEOLOCATION': 'data/raw/olist_geolocation_dataset.csv',
    'CATEGORY_TRANSLATION': 'data/raw/product_category_name_translation.csv'
}

for table_name, file_path in csv_files.items():
    print(f'Loading {table_name}...')
    df = pd.read_csv(file_path)
    df.columns = [c.upper() for c in df.columns]
    write_pandas(conn, df, table_name, auto_create_table=True)
    print(f'Done — {len(df)} rows loaded into {table_name}')

conn.close()
print('All tables loaded successfully!')