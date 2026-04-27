-- Late delivery rate by state
-- Finding: Northeastern states (AL, MA, PI, CE) have up to 24% late delivery rates
-- vs national average of ~8%, indicating a regional logistics gap

SELECT 
    c.CUSTOMER_STATE,
    COUNT(o.ORDER_ID) as total_orders,
    SUM(CASE WHEN o.ORDER_DELIVERED_CUSTOMER_DATE > o.ORDER_ESTIMATED_DELIVERY_DATE THEN 1 ELSE 0 END) as late_orders,
    ROUND(100.0 * SUM(CASE WHEN o.ORDER_DELIVERED_CUSTOMER_DATE > o.ORDER_ESTIMATED_DELIVERY_DATE THEN 1 ELSE 0 END) / COUNT(o.ORDER_ID), 2) as late_pct
FROM RETAIL_DB.RAW.ORDERS o
JOIN RETAIL_DB.RAW.CUSTOMERS c ON o.CUSTOMER_ID = c.CUSTOMER_ID
WHERE o.ORDER_DELIVERED_CUSTOMER_DATE IS NOT NULL
GROUP BY 1
ORDER BY late_pct DESC;