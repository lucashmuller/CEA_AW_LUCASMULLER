with
    source_product_subcategory as (
        select
            cast(productsubcategoryid as int) as product_subcategory_id
            , cast(productcategoryid as int) as product_category_id
            , name as product_subcategory_name
        from {{ source('raw_adventure_works','productsubcategory')}}
    )

select *
from source_product_subcategory