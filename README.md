# dbt-extend
Extension package for [dbt](https://github.com/fishtown-analytics/dbt), including schema tests and validation macros.

## Macros
### Cross-database

### Schema Tests
#### equal_expression ([source](macros/schema_tests/equal_expression.sql))
This schema test asserts that two expressions are equal.

Parameters:

`expression` : expression using SQL compatible with database platform 

`compare_model` : if specified, a `ref` to another model; otherwise, the same model is assumed

`compare_expression` : if specified, an expression, using SQL compatible with database platform, to apply to the `model` or `comparison_model` (if specified) 

`group_by` : list of columns from `model` to use as group by columns. If specified, evaluates `expression` at the granularity of the `group_by` columns.

`compare_group_by` : if specified, columns to group by the `comparison_model`; otherwise, same column names as specified in `group_by` are assumed.

`tol` : comparison tolerance, in absolute units of `expression`. E.g. `tol: 1000` specifies that only differences between `expression ` and `comparison_expression` greate than or equal to 1,000 are considered test failures. 

Usage:
```yaml
version: 2

models:
  - name: model_name
    tests:
      - dbt_utils.equal_expression:
          expression: count(*)
          compare_model: ref('same_or_other_model_name')
      - dbt_utils.equal_expression:
          expression: count(*)
          compare_model: ref('same_or_other_model_name')
          group_by: [date_col]
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          compare_model: ref('same_or_other_model_name')
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          compare_expression: sum(col_b)
          group_by: [date_col]
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          compare_expression: sum(col_b)
          compare_model: ref('same_or_other_model_name')
          group_by: [date_col]
          tol: 100
```