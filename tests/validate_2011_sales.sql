with
    sales_2011 as (
        select to_decimal(sum(quantity*unit_price), 10, 2) as total_sales
        from stg_sales_order_detail so
        left join stg_sales_order_header sh on so.sales_order_id = sh.sales_order_id
        where extract(year from sh.order_date) = 2011
    )

select *
from sales_2011
where total_sales <> 12646112.16