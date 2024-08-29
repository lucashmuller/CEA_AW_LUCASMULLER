with
    source_person as (
        select
            cast(businessentityid as int) as person_id
            , cast(firstname as varchar) || ' ' || cast(lastname as varchar) as person_name
            , persontype as person_type
        from {{ source('raw_adventure_works','person')}}
    )

select *
from source_person