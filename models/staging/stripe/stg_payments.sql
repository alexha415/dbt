WITH payments as (
    SELECT 
        orderid as order_id,
        amount / 100 as amount,
        paymentmethod as payment_method,
        status,
        created as created_at
    FROM {{ source('stripe', 'payment') }}
)

SELECT * FROM payments