-- Actual vs estimated delivery time by state
-- Finding: Northern states (RR, AP, AM) are delivered 17-20 days EARLIER than estimated
-- Olist is over-padding estimates for remote states, masking real performance

SELECT 
    c.CUSTOMER_STATE,
    COUNT(o.ORDER_ID) as total_orders,
    ROUND(AVG(DATEDIFF('day', 
        o.ORDER_PURCHASE_TIMESTAMP, 
        o.ORDER_DELIVERED_CUSTOMER_DATE)), 1) as avg_actual_days,
    ROUND(AVG(DATEDIFF('day', 
        o.ORDER_PURCHASE_TIMESTAMP, 
        o.ORDER_ESTIMATED_DELIVERY_DATE)), 1) as avg_estimated_days,
    ROUND(AVG(DATEDIFF('day', 
        o.ORDER_ESTIMATED_DELIVERY_DATE,
        o.ORDER_DELIVERED_CUSTOMER_DATE)), 1) as avg_delay_days
FROM RETAIL_DB.RAW.ORDERS o
JOIN RETAIL_DB.RAW.CUSTOMERS c ON o.CUSTOMER_ID = c.CUSTOMER_ID
WHERE o.ORDER_DELIVERED_CUSTOMER_DATE IS NOT NULL
GROUP BY 1
ORDER BY avg_actual_days DESC;