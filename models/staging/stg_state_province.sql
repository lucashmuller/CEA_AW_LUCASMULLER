with
    source_state_province as (
        select
            cast(stateprovinceid as int) as state_province_id
            , stateprovincecode as state_province_code
            , countryregioncode as country_region_code
            , name as state_province_name
        from {{ source('raw_adventure_works','stateprovince')}}
    )

select *
from source_state_province