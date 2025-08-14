with stg_raw_Line_items as (

    select * from {{ ref('stg_raw_line_items') }}
)
select 1
from stg_raw_Line_items
where quantity < 0