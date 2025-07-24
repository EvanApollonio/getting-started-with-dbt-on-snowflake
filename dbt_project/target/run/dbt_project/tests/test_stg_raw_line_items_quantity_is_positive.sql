select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      with stg_raw_Line_items as (

    select * from DBT_DEMO_DB.raw.stg_raw_line_items
)
select 1
from stg_raw_Line_items
where quantity > 0
      
    ) dbt_internal_test