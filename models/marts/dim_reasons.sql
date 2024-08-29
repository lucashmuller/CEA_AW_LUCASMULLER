with sales_order_header_sales_reason as (
    select *
    from {{ref('stg_sales_order_header_sales_reason')}}
)

, sales_reason as (
    select *
    from {{ref('stg_sales_reason')}}
)

, order_with_reason as (
    select
        sales_order_header_sales_reason.sales_order_id
        , sales_reason.sales_reason_name as reason_name
    from sales_order_header_sales_reason
    left join sales_reason on sales_order_header_sales_reason.sales_reason_id = sales_reason.sales_reason_id
)

, transformed as (
    select
        sales_order_id
        , LISTAGG(distinct reason_name, ' and ') within group (order by reason_name) as reason_name_aggregated
    from order_with_reason
    group by sales_order_id
)

select *
from transformed