-- Tailoring Business Analytics Queries
-- These queries provide actionable business insights

-- 1. REVENUE ANALYSIS
-- Monthly revenue trend analysis
SELECT 
    DATE_FORMAT(STR_TO_DATE(deadline, '%d-%m-%y'), '%Y-%m') as month,
    COUNT(oid) as total_orders,
    SUM(CAST(price AS UNSIGNED)) as monthly_revenue,
    ROUND(AVG(CAST(price AS UNSIGNED)), 2) as avg_order_value
FROM order_list 
WHERE status = 'COMPLETED'
GROUP BY month
ORDER BY month;

-- Revenue by payment method
SELECT 
    p.mode_of_payment,
    COUNT(*) as transaction_count,
    SUM(CAST(p.price AS UNSIGNED)) as total_revenue,
    ROUND(AVG(CAST(p.price AS UNSIGNED)), 2) as avg_transaction_value
FROM payment p
GROUP BY p.mode_of_payment
ORDER BY total_revenue DESC;

-- 2. PERFORMANCE METRICS
-- Top performing tailors by revenue and order count
SELECT 
    t.tailor_name,
    COUNT(ol.oid) as total_orders,
    SUM(CAST(ol.price AS UNSIGNED)) as revenue_generated,
    ROUND(AVG(CAST(ol.price AS UNSIGNED)), 2) as avg_order_value,
    SUM(CASE WHEN ol.status = 'COMPLETED' THEN 1 ELSE 0 END) as completed_orders,
    ROUND(
        (SUM(CASE WHEN ol.status = 'COMPLETED' THEN 1 ELSE 0 END) * 100.0 / COUNT(ol.oid)), 
        2
    ) as completion_rate_percent
FROM my_tailor t
JOIN order_list ol ON t.tailor_id = ol.tailor_id
GROUP BY t.tailor_id, t.tailor_name
ORDER BY revenue_generated DESC;

-- 3. OPERATIONAL INSIGHTS
-- Orders beyond deadline (Risk Management)
SELECT 
    c.cname as customer_name,
    c.cnumber as phone_number,
    ol.deadline,
    gt.type_name as garment_type,
    CAST(ol.price AS UNSIGNED) as order_value,
    t.tailor_name,
    DATEDIFF(CURDATE(), STR_TO_DATE(ol.deadline, '%d-%m-%y')) as days_overdue
FROM order_list ol
JOIN customer c ON ol.fid = c.cid
JOIN garment_type gt ON ol.fid = gt.fid
JOIN my_tailor t ON ol.tailor_id = t.tailor_id
WHERE ol.status = 'PENDING' 
AND STR_TO_DATE(ol.deadline, '%d-%m-%y') < CURDATE()
ORDER BY days_overdue DESC;

-- Most popular garment types
SELECT 
    gt.type_name,
    COUNT(ol.oid) as order_count,
    SUM(CAST(ol.price AS UNSIGNED)) as total_revenue,
    ROUND(AVG(CAST(ol.price AS UNSIGNED)), 2) as avg_price,
    gt.fabric_required
FROM garment_type gt
JOIN order_list ol ON gt.fid = ol.fid
GROUP BY gt.fid, gt.type_name, gt.fabric_required
ORDER BY order_count DESC;

-- 4. CUSTOMER ANALYTICS
-- High-value customers analysis
SELECT 
    c.cname as customer_name,
    c.caddress,
    COUNT(ol.oid) as total_orders,
    SUM(CAST(ol.price AS UNSIGNED)) as total_spent,
    ROUND(AVG(CAST(ol.price AS UNSIGNED)), 2) as avg_order_value,
    MAX(STR_TO_DATE(ol.deadline, '%d-%m-%y')) as last_order_date
FROM customer c
JOIN order_list ol ON c.cid = ol.fid
GROUP BY c.cid, c.cname, c.caddress
HAVING total_spent > 1000
ORDER BY total_spent DESC;

-- Customer geographic distribution
SELECT 
    caddress as location,
    COUNT(*) as customer_count,
    SUM(CAST(ol.price AS UNSIGNED)) as location_revenue
FROM customer c
JOIN order_list ol ON c.cid = ol.fid
WHERE ol.status = 'COMPLETED'
GROUP BY caddress
ORDER BY location_revenue DESC;

-- 5. BUSINESS HEALTH METRICS
-- Overall business summary
SELECT 
    COUNT(DISTINCT c.cid) as total_customers,
    COUNT(ol.oid) as total_orders,
    SUM(CASE WHEN ol.status = 'COMPLETED' THEN 1 ELSE 0 END) as completed_orders,
    SUM(CASE WHEN ol.status = 'PENDING' THEN 1 ELSE 0 END) as pending_orders,
    SUM(CAST(ol.price AS UNSIGNED)) as total_revenue,
    ROUND(AVG(CAST(ol.price AS UNSIGNED)), 2) as avg_order_value,
    ROUND(
        (SUM(CASE WHEN ol.status = 'COMPLETED' THEN 1 ELSE 0 END) * 100.0 / COUNT(ol.oid)), 
        2
    ) as overall_completion_rate
FROM customer c
JOIN order_list ol ON c.cid = ol.fid;

-- Order status distribution
SELECT 
    status,
    COUNT(*) as order_count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_list)), 2) as percentage,
    SUM(CAST(price AS UNSIGNED)) as status_revenue
FROM order_list
GROUP BY status
ORDER BY order_count DESC;
