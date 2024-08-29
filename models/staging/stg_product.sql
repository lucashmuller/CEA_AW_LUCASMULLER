with 
    source_product as (
        select
            cast(productid as int) as product_id
            , name as product_name
            , cast(productsubcategoryid as int) as product_subcategory_id
        from {{ source('raw_adventure_works','product')}}
    )

select *
from source_product