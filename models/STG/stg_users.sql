select 
user_id,
name as user_name ,
email
from {{source('raw_data','users')}}
