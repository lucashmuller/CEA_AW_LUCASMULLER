with
    source_address as (
        select
            cast (addressid as int) as address_id
            , city
            , cast (stateprovinceid as int) as state_province_id
        from {{ source('raw_adventure_works','address')}}
    )

select *
from source_address