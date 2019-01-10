{%- macro test_frequency(model, date_col, date_part="day", filter_cond=None) -%}
with model_data as
(
    select
        {{ dbt_utils.date_trunc(date_part, date_col) }} as date_col,
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
    select min(date_col) as start_date, max(date_col) as end_date from model_data
),
dates as
(
    select
        {{ dbt_utils.date_trunc(date_part, 'd.calendar_date') }} as date_col
    from
        {{ ref('d_date') }} d
        join
        date_range r on d.calendar_date between r.start_date and r.end_date
    group by 1
),
final as
(
    select
        d.date_col,
        case when f.date_col is null then true else false end as is_missing,
        coalesce(f.row_cnt, 0) as row_cnt
    from
        dates d
        left outer join
        model_data f on d.date_col = f.date_col
)
select count(*) from final where row_cnt = 0
{%- endmacro -%}