with
    product as (
        select *
        from {{ ref('stg_product') }}
    )

    , product_category as (
        select *
        from {{ ref('stg_product_category') }}
    )

    , product_subcategory as (
        select *
        from {{ ref('stg_product_subcategory') }}
    )

    , transformed as (
        select
            product.product_id as pk_product
            , product.product_subcategory_id as fk_product_subcategory
            , product_category.product_category_id as fk_product_category
            , product.product_name
            , product_subcategory.product_subcategory_name
            , product_category.product_category_name
        from product
        left join product_subcategory on product_subcategory.product_subcategory_id = product.product_subcategory_id
        left join product_category on product_category.product_category_id = product_subcategory.product_category_id
        order by pk_product
    )

select *
from transformed