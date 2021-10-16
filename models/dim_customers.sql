{{config(
    materialized='table'
)}}

with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from dbt_jburnworth.customers

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from dbt_jburnworth.orders

),

customer_orders as (

    select
        user_id as customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(id) as number_of_orders

    from dbt_jburnworth.orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final order by customer_id 