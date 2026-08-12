{{
    config(
        materialized='table'
    )
}}

select 
    user_id,
    user_name,
    email
from {{ ref('stg_users') }}
