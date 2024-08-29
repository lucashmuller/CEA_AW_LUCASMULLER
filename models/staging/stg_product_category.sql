with
    source_product_category as (
        select
            cast(productcategoryid as int) as product_category_id
            , name as product_category_name
        from {{ source('raw_adventure_works','productcategory')}}
    )

select *
from source_product_category