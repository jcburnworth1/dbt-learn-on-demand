{% macro cents_to_dollars(column_name = 'amount')-%}
{{column_name}} / 100.00
{%- endmacro %}