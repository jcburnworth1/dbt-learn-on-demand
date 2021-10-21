{% macro limit_data_in_dev(column_name) -%}

{% if target.dataset == 'dbt_jburnworth' %}

WHERE
DATE_DIFF(CURRENT_DATE(), {{ column_name }}, DAY) <= 10000

{% endif %}

{%- endmacro %}