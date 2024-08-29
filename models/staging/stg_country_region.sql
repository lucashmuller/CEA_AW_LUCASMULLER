with
    source_country_region as (
        select
            countryregioncode as country_region_code
            , name as country_region_name
        from {{ source('raw_adventure_works','countryregion')}}
    )

select *
from source_country_region