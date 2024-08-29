with
    source_sales_order_detail as (
        select
            cast(salesorderid as int) as sales_order_id
            , cast(salesorderdetailid as int) as sales_order_detail_id
            , cast(productid as int) as product_id
            , cast(orderqty as int) as quantity
            , unitprice as unit_price
            , unitpricediscount as discount
        from {{ source('raw_adventure_works','salesorderdetail')}}
    )

select *
from source_sales_order_detail