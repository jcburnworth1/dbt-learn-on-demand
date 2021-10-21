-- Payment methods we want to roll up in the pivot
-- Use - after or before % to trim whitespace
{%- set payment_methods = ['bank_transfer','coupon','credit_card','gift_card'] %}

WITH payments AS (

    SELECT * FROM {{ ref('stg_payments') }}

),

pivoted AS (

    SELECT
    order_id

    {% for payment_method in payment_methods -%}

    ,SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN amount ELSE 0 END) AS {{ payment_method }}_amount

    {% endfor -%}
    
    -- The above jinja replaces all the below SQL to do the same thing 
    -- ,SUM(CASE WHEN payment_method = 'bank_transfer' THEN amount ELSE 0 END) AS bank_transfer_amount
    -- ,SUM(CASE WHEN payment_method = 'coupon' THEN amount ELSE 0 END) AS coupon_amount
    -- ,SUM(CASE WHEN payment_method = 'credit_card' THEN amount ELSE 0 END) AS credit_card_amount
    -- ,SUM(CASE WHEN payment_method = 'gift_card' THEN amount ELSE 0 END) AS gift_card_amount
    FROM
    payments
    WHERE
    status = 'success'
    GROUP BY
    order_id

)

SELECT * FROM pivoted