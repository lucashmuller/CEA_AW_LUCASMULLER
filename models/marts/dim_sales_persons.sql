with
    stg_person as (
        select *
        from {{ ref('stg_person') }}
    )

    , transformed as (
        select
            person_id as pk_sales_person
            , person_name as sales_person_fullname
        from stg_person
        where person_type = 'SP'
    )

select *
from transformed