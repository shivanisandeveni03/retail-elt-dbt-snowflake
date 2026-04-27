with source as (
    select * from {{ source('raw', 'ORDERS') }}
),
staged as (
    select
        ORDER_ID,
        CUSTOMER_ID,
        ORDER_STATUS,
        cast(ORDER_PURCHASE_TIMESTAMP as timestamp) as ordered_at,
        cast(ORDER_DELIVERED_CUSTOMER_DATE as timestamp) as delivered_at,
        cast(ORDER_ESTIMATED_DELIVERY_DATE as timestamp) as estimated_delivery_at
    from source
)
select * from staged