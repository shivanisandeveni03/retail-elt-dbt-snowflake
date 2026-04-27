with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        c.CUSTOMER_STATE,
        c.CUSTOMER_CITY,
        count(o.ORDER_ID) as total_orders,
        round(avg(datediff('day', o.ordered_at, o.delivered_at)), 1) as avg_delivery_days,
        round(avg(datediff('day', o.ordered_at, o.estimated_delivery_at)), 1) as avg_estimated_days,
        round(avg(datediff('day', o.estimated_delivery_at, o.delivered_at)), 1) as avg_delay_days,
        sum(case when o.delivered_at <= o.estimated_delivery_at then 1 else 0 end) as on_time_deliveries,
        round(100.0 * sum(case when o.delivered_at <= o.estimated_delivery_at then 1 else 0 end) / count(o.ORDER_ID), 2) as on_time_pct
    from orders o
    left join customers c on o.CUSTOMER_ID = c.CUSTOMER_ID
    where o.delivered_at is not null
    group by 1,2
)

select * from final