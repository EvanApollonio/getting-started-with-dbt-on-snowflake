-- dbt can handle dynamic sql generation much easier than informatica
{% macro union_of_models(model_names)%}
    {% set sql_parts = [] %}
    {% for model in model_names %}
        {% do sql_parts.append("select * from " ~ ref(model)) %}
    {% endfor %}
    {{ sql_parts | join('\nunion all\n')}}
{% endmacro %}