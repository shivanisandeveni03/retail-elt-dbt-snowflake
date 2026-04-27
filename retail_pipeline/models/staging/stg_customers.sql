with source as (
    select * from {{ source('raw', 'CUSTOMERS') }}
),
staged as (
    select
        CUSTOMER_ID,
        CUSTOMER_UNIQUE_ID,
        CUSTOMER_CITY,
        CUSTOMER_STATE
    from source
)
select * from staged