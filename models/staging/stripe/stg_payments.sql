WITH payment AS (

    SELECT
    id AS payment_id
    ,orderid AS order_id
    ,paymentmethod AS payment_method
    ,status
    -- Convert cents to dollars using macro
    ,{{ cents_to_dollars() }} AS amount
    ,created AS created_at
    FROM
    {{ source('stripe', 'payment') }}

    {{ limit_data_in_dev('created') }}

)

SELECT * FROM payment
