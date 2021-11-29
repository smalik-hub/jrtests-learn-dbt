{{config(materialized='table')}}

with sales_order as (
  select o_orderdate as date,sum(o_totalprice) as total_sales
  from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"
  group by o_orderdate
)

select date, sum(total_sales) over (order by date asc rows between unbounded preceding and current row) as cumulative_sales_by_date
from sales_order
