{% macro get_model_row_count(model_name) %}
    with source as (
    
        select * from {{ ref(model_name) }}
    
    )
    select
        count(*) as row_count
    from source
{% endmacro %}
