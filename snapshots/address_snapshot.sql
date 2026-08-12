{% snapshot address_snapshot %}

{{
    config(
        target_database='cblab-505208',
        target_schema='snapshots',
        unique_key='user_id',
        strategy='check',
        check_cols=['city']
    )
}}

select * from {{ source('raw_data', 'address') }}

{% endsnapshot %}