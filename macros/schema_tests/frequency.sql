{%- macro test_frequency(model, date_col, date_part="day", filter_cond=None, test_start_date=None, test_end_date=None) -%}
{% if not execute %}
    {{ return('') }}
{% endif %}

{% if test_start_date is none and test_end_date is none %}
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
{% else %}
    {% call statement('date_expression', fetch_result=True) %}

        select 
            {{ test_start_date }} as start_date, 
            {{ test_end_date }} as end_date 

    {% endcall %}
    {%- set dr = load_result('date_expression') -%}
{% endif %}


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
        {{ dbt_utils.date_trunc(date_part, date_col) }}::date as date_{{date_part}},
        count(*) as row_cnt
    from
        {{ model }} f
    {% if filter_cond %}
    where {{ filter_cond }}
    {% endif %}
    group by
        1
),
date_part_dates as 
(
    select
        {{ dbt_utils.date_trunc(date_part, 'date_day') }}::date as date_{{date_part}}
    from
        day_dates d
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