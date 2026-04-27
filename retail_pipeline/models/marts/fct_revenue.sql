with order_items as (
    select * from {{ source('raw', 'ORDER_ITEMS') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

final as (
    select
        o.ORDER_ID,
        o.CUSTOMER_ID,
        o.ORDER_STATUS,
        o.ordered_at,
        count(oi.ORDER_ITEM_ID) as total_items,
        sum(oi.PRICE) as revenue,
        sum(oi.FREIGHT_VALUE) as freight_cost,
        sum(oi.PRICE + oi.FREIGHT_VALUE) as total_order_value
    from orders o
    left join order_items oi on o.ORDER_ID = oi.ORDER_ID
    group by 1,2,3,4
)

select * from final