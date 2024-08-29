with
    source_store as (
        select
            cast (businessentityid as int) as store_id
            , cast (name as string) as store_name
        from {{ source('raw_adventure_works','store')}}
    )

select *
from source_store