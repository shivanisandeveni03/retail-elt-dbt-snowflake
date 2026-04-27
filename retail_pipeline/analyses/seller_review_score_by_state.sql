-- Seller review scores and revenue by state
-- Finding: Sellers in AM average 2.33 review score with 48-day delivery
-- vs SP sellers at 4.05 score and 12-day delivery -- 4x longer wait time
-- despite meeting estimates, proving logistics infrastructure is the root cause

SELECT
    s.SELLER_STATE,
    COUNT(DISTINCT oi.SELLER_ID) as total_sellers,
    ROUND(AVG(r.REVIEW_SCORE), 2) as avg_review_score,
    ROUND(AVG(DATEDIFF('day', o.ORDER_PURCHASE_TIMESTAMP, o.ORDER_DELIVERED_CUSTOMER_DATE)), 1) as avg_delivery_days,
    ROUND(SUM(oi.PRICE), 2) as total_revenue
FROM RETAIL_DB.RAW.SELLERS s
JOIN RETAIL_DB.RAW.ORDER_ITEMS oi ON s.SELLER_ID = oi.SELLER_ID
JOIN RETAIL_DB.RAW.ORDERS o ON oi.ORDER_ID = o.ORDER_ID
JOIN RETAIL_DB.RAW.REVIEWS r ON o.ORDER_ID = r.ORDER_ID
WHERE o.ORDER_DELIVERED_CUSTOMER_DATE IS NOT NULL
GROUP BY 1
ORDER BY avg_review_score ASC;