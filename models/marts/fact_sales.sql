with
    customers as (
        select
            pk_customer
        from {{ref('dim_customers')}}
    )

    , credit_cards as (
        select
            pk_credit_card
        from {{ref('dim_credit_cards')}}
    )

    , territories as (
        select
            pk_territory
        from {{ref('dim_territories')}}
    )

    , reasons as (
        select
            sales_order_id
            , reason_name_aggregated
        from {{ref('dim_reasons')}}
    )

    , products as (
        select
            pk_product
        from {{ref('dim_products')}}
    )

    , sales_person as (
        select
            pk_sales_person
        from {{ref('dim_sales_persons')}}
    )

    , sales_order_detail as (
        select
            sales_order_detail.sales_order_id
            , sales_order_detail.sales_order_detail_id
            , products.pk_product as fk_product
            , sales_order_detail.quantity
            , sales_order_detail.unit_price
            , sales_order_detail.discount
            , sales_order_detail.unit_price * sales_order_detail.quantity  AS  gross_revenue
            , (sales_order_detail.unit_price * sales_order_detail.quantity) * (1 - sales_order_detail.discount) AS net_revenue
            , ifnull(reasons.reason_name_aggregated,'Reason not indicated') as reason_name
        from {{ref('stg_sales_order_detail')}} sales_order_detail
        left join products on sales_order_detail.product_id = products.pk_product
        left join reasons on sales_order_detail.sales_order_id = reasons.sales_order_id
    )

    , sales_order_header as (
        select
            sales_order_id
            , customers.pk_customer as fk_customer
            , credit_cards.pk_credit_card as fk_credit_card
            , territories.pk_territory as fk_territory
            , status as order_status
            , order_date
            , order_type
            , sales_person.pk_sales_person as fk_sales_person
        from {{ref('stg_sales_order_header')}}
        left join customers on stg_sales_order_header.customer_id = customers.pk_customer
        left join credit_cards on stg_sales_order_header.credit_card_id = credit_cards.pk_credit_card
        left join territories on stg_sales_order_header.ship_to_address_id = territories.pk_territory
        left join sales_person on stg_sales_order_header.sales_person_id = sales_person.pk_sales_person
    )

    , final as (
        select
            row_number() over(order by sales_order_detail_id) as sk_sales
            , sales_order_detail.sales_order_id as pk_sales_order
            , sales_order_detail.sales_order_detail_id
            , sales_order_detail.fk_product
            , sales_order_header.fk_customer
            , sales_order_header.fk_territory
            , sales_order_header.fk_credit_card
            , sales_order_header.fk_sales_person
            , sales_order_detail.unit_price
            , sales_order_detail.quantity
            , sales_order_detail.discount
            , sales_order_detail.gross_revenue
            , sales_order_detail.net_revenue
            , sales_order_detail.reason_name
            , sales_order_header.order_date
            , sales_order_header.order_status
            , sales_order_header.order_type
        from sales_order_detail
        left join sales_order_header on sales_order_detail.sales_order_id = sales_order_header.sales_order_id
    )

select *
from final