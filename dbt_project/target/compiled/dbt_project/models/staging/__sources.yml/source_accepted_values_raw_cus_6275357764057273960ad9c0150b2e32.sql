
    
    

with all_values as (

    select
        c_mktsegment as value_field,
        count(*) as n_records

    from snowflake_sample_data.tpch_sf1.customer
    group by c_mktsegment

)

select *
from all_values
where value_field not in (
    'HOUSEHOLD','BUILDING','AUTOMOBILE'
)


