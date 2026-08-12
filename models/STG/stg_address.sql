select 
user_id,
city,
current_timestamp() as created_at
from {{ source('raw_data', 'address') }}