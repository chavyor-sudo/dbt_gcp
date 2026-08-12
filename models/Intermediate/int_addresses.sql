
{{
    config(
        materialized='incremental',
        unique_key='user_id',          
        incremental_strategy='merge',         
        on_schema_change='append_new_columns' 
    )
}}

with incoming_data as (
    select 
        user_id,
        city,
        created_at,
        row_number() over (partition by user_id order by created_at desc) as rn
    from {{ ref('stg_address') }}

    {% if is_incremental() %}
        where created_at > (select max(created_at) from {{ this }})
    {% endif %}
)

select 
    user_id,
    city,
    created_at 
from incoming_data
where rn = 1
