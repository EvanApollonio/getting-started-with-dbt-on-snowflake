with customers as (

    select * from {{ ref('stg_raw_customers') }}
)
select 
    customer_key,
    nation_key,
    customer_name,
    customer_address,
    market_segment
from customers



