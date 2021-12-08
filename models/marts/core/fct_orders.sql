with payments as (
    select * from {{ ref ('stg_payments') }}
),

orders as (
    select * from {{ ref ('stg_orders') }}
),

customer_payments as (
    select
        order_id,
        SUM(CASE WHEN status = 'success' THEN amount END) as amount
    from payments
    GROUP BY 1

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(customer_payments.amount, 0) as amount

    from orders
    left join customer_payments using (order_id)
)

select * from final