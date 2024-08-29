with
    source_sales_order_header as (
        select
            cast(salesorderid as int) as sales_order_id
            , cast(customerid as int) as customer_id
            , cast(salespersonid as int) as sales_person_id
            , cast(creditcardid as int) as credit_card_id
            , cast(shiptoaddressid as int) as ship_to_address_id
            , cast(orderdate as DATETIME) as order_date
            , case
                when status = 1 then 'In progress'
                when status = 2 then 'Approved'
                when status = 3 then 'Backordered'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Cancelled'
                else 'Unknown'
            end as status
            , case
                when onlineorderflag = 'True' then 'Online'
                when onlineorderflag = 'False' then 'Vendedor'
            end as order_type
        from {{ source('raw_adventure_works','salesorderheader')}}
    )

select *
from source_sales_order_header