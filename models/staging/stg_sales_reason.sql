with
    source_sales_reason as (
        select
            cast(salesreasonid as int) as sales_reason_id
            , name as sales_reason_name
        from {{ source('raw_adventure_works','salesreason')}}
    )

select *
from source_sales_reason