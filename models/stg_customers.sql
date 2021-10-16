WITH customers AS (

    SELECT
    id AS customer_id
    ,first_name
    ,last_name
    FROM
    dbt_jburnworth.customers

)

SELECT * FROM customers
