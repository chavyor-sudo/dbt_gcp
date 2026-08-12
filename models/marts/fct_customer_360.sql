with users as (
    select user_id, user_name, email from {{ ref('int_users') }}
),

addresses as (
    select user_id, city from {{ ref('int_addresses') }}
),

-- שימוש ב-Seed: מביא את המחוז ועלות המשלוח לפי העיר של הלקוח
address_with_regions as (
    select 
        a.user_id,
        a.city,
        r.region,
        r.shipping_cost
    from addresses a
    left join {{ ref('region_mapping') }} r on a.city = r.city
),

orders_aggregated as (
    select 
        user_id,
        count(order_id) as total_orders,
        sum(amount) as total_amount_spent_usd,
        max(date) as last_order_date
    from {{ ref('int_orders') }}
    group by 1
)

select
    u.user_id,
    u.user_name,
    u.email,
    a.city,
    a.region, 
    a.shipping_cost, 
    coalesce(o.total_orders, 0) as total_orders,
    coalesce(o.total_amount_spent_usd, 0.0) as total_amount_spent_usd,
    
    {{ convert_usd_to_ils('o.total_amount_spent_usd') }} as total_amount_spent_ils,
    
    o.last_order_date
    from users u
left join address_with_regions a on u.user_id = a.user_id
left join orders_aggregated o on u.user_id = o.user_id
