{%- macro test_frequency(model, date_col, date_part="day", filter_cond=None) -%}
{% if not execute %}
    {{ return('') }}
{% endif %}
{% call statement('date_range', fetch_result=True) %}

    select 
        min({{ date_col }}) as start_date, 
        max({{ date_col }}) as end_date 
    from {{ model }} 
    {% if filter_cond %}
    where {{ filter_cond }}
    {% endif %}
{% endcall %}

{%- set dr = load_result('date_range') -%}
{%- set start_date = dr['data'][0][0].strftime('%Y-%m-%d') -%}
{%- set end_date = dr['data'][0][1].strftime('%Y-%m-%d') -%}

with day_dates as
(
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'" ~ start_date ~ "'",
        end_date="'" ~ end_date ~ "'"
       )
    }}
),
model_data as
(
    select
        {{ dbt_utils.date_trunc(date_part, date_col) }} as date_{{date_part}},
        count(*) as row_cnt
    from
        {{ model }} f
    {% if filter_cond %}
    where {{ filter_cond }}
    {% endif %}
    group by
        1
),
date_range as 
(
    select 
        min(date_{{date_part}}) as start_date, 
        max(date_{{date_part}}) as end_date 
    from model_data
),
date_part_dates as 
(
    select
        {{ dbt_utils.date_trunc(date_part, 'date_day') }} as date_{{date_part}}
    from
        day_dates d
        join
        date_range dr on d.date_day between dr.start_date and dr.end_date
    group by 
        1
),
final as
(
    select
        d.date_{{date_part}},
        case when f.date_{{date_part}} is null then true else false end as is_missing,
        coalesce(f.row_cnt, 0) as row_cnt
    from
        date_part_dates d
        left outer join
        model_data f on d.date_{{date_part}} = f.date_{{date_part}}
)
select count(*) from final where row_cnt = 0
{%- endmacro -%}