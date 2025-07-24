
with source as (

    select * from {{ source('raw', 'customer') }}

)
select
    c_custkey as customer_key,
    c_nationkey as nation_key,
    c_name as customer_name,
    c_address as customer_address,
    c_mktsegment as market_segment
from source