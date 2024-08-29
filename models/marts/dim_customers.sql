with
    stg_customer as (
        select *
        from {{ ref('stg_customer') }}
    )

    , stg_person as (
        select *
        from {{ ref('stg_person') }}
    )

    , stg_store as (
        select *
        from {{ ref('stg_store') }}
    )

    , transformed as (
        select
            stg_customer.customer_id as pk_customer
            , stg_customer.person_id as fk_person
            , case
                when stg_person.person_name is null then ''
                else stg_person.person_name
            end as person_fullname
            , stg_customer.store_id as fk_store
            , stg_store.store_name
        from stg_customer
        left join stg_person on stg_person.person_id = stg_customer.person_id
        left join stg_store on stg_store.store_id = stg_customer.store_id
        order by pk_customer
    )

select *
from transformed