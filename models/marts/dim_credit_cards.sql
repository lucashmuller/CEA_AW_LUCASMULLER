with
    stg_credit_card as (
        select *
        from {{ ref('stg_credit_card') }}
    )

    , transformed as (
        select
            credit_card_id as pk_credit_card
            , ifnull(card_type,'Unknow') as card_type
        from stg_credit_card
        order by pk_credit_card
    )

select *
from transformed