select 
user_id,
order_id,
amount,
date

from {{source('raw_data','order')}}