with orders as (
    select * from {{ ref('stg_orders') }}
),
customers as (
    select * from {{ ref('stg_customers') }}
),
final as (
    select
        o.ORDER_ID,
        o.CUSTOMER_ID,
        c.CUSTOMER_CITY,
        c.CUSTOMER_STATE,
        o.ORDER_STATUS,
        o.ordered_at,
        o.delivered_at,
        datediff('day', o.ordered_at, o.delivered_at) as days_to_deliver
    from orders o
    left join customers c on o.CUSTOMER_ID = c.CUSTOMER_ID
)
select * from final