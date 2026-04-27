with order_items as (
    select * from {{ source('raw', 'ORDER_ITEMS') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

sellers as (
    select * from {{ source('raw', 'SELLERS') }}
),

final as (
    select
        s.SELLER_ID,
        s.SELLER_CITY,
        s.SELLER_STATE,
        count(distinct o.ORDER_ID) as total_orders,
        count(oi.ORDER_ITEM_ID) as total_items_sold,
        round(sum(oi.PRICE), 2) as total_revenue,
        round(avg(oi.PRICE), 2) as avg_item_price,
        round(avg(datediff('day', o.ordered_at, o.delivered_at)), 1) as avg_delivery_days
    from sellers s
    left join order_items oi on s.SELLER_ID = oi.SELLER_ID
    left join orders o on oi.ORDER_ID = o.ORDER_ID
    where o.ORDER_STATUS = 'delivered'
    group by 1,2,3
)

select * from final