with
    source_credit_card as (
        select
            cast(creditcardid as int) as credit_card_id
            , cardtype as card_type
        from {{ source('raw_adventure_works','creditcard')}}
    )

select *
from source_credit_card