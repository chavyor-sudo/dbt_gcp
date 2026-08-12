{{
    config(
        materialized='incremental',
        incremental_strategy='merge'
   )
}}

select 
    order_id,
    user_id,
    amount,
    date
from {{ ref('stg_order') }}

{% if is_incremental() %}
    where date > (select max(date) from {{ this }})
{% endif %}
