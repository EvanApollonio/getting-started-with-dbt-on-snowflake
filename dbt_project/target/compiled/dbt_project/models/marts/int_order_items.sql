with orders as (
    
    select * from DBT_DEMO_DB.raw.stg_raw_orders

),

line_item as (

    select * from DBT_DEMO_DB.raw.stg_raw_line_items

)
select 

    l.order_item_key,
    o.order_key,
    o.customer_key,
    o.order_date,
    o.status_code as order_status_code,
    l.part_key,
    l.supplier_key,
    l.return_flag,
    l.line_number,
    l.status_code as order_item_status_code,
    l.ship_date,
    l.commit_date,
    l.receipt_date,
    l.ship_mode,
    l.extended_price,
    l.quantity,
    
    -- extended_price is actually the line item total,
    -- so we back out the extended price per item
    (l.extended_price/nullif(l.quantity, 0))::decimal(16,2) as base_price,
    l.discount_percentage,
    (base_price * (1 - l.discount_percentage))::decimal(16,2) as discounted_price,

    l.extended_price as gross_item_sales_amount,
    (l.extended_price * (1 - l.discount_percentage))::decimal(16,2) as discounted_item_sales_amount,
    -- We model discounts as negative amounts
    (-1 * l.extended_price * l.discount_percentage)::decimal(16,2) as item_discount_amount,
    l.tax_rate,
    ((gross_item_sales_amount + item_discount_amount) * l.tax_rate)::decimal(16,2) as item_tax_amount,
    (
        gross_item_sales_amount + 
        item_discount_amount + 
        item_tax_amount
    )::decimal(16,2) as net_item_sales_amount

from
    orders o
inner join line_item l
        on o.order_key = l.order_key
order by
    o.order_date