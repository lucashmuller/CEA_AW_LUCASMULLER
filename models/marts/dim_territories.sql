with
    address as (
        select *
        from {{ref('stg_address')}}
    )

    , country_region as (
        select *
        from {{ref('stg_country_region')}}
    )

    , state_province as (
        select *
        from {{ref('stg_state_province')}}
    )

    , transformed as (
        select
            address.address_id as pk_territory
            , address.city
            , address.state_province_id as fk_state
            , state_province.state_province_code
            , state_province.state_province_name
            , state_province.country_region_code
            , country_region.country_region_name
        from address
        left join state_province on state_province.state_province_id = address.state_province_id
        left join country_region on state_province.country_region_code = country_region.country_region_code
        order by pk_territory
    )

select *
from transformed