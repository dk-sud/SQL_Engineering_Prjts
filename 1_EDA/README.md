# Exploartory data analysis/using SQL
## Executive Summary

## Tech Stack

- **Query Engine** Postgress SQL for fast OLAP Style analytical queries 
- **Languages used** SQL (ANSI-Style with analytical functions)
- **Data Model:** Star Schema with Fact + Dimension + Bridge Tables
- **Development:** VS Code for SQl editing + Terminal for DuckDB CLI
- **Version Control:** Git/GitHub fopr versioned SQL scripts

## Problem & Statement

## Analysis Overview
- Key Insights
- 

## SQL Demonstrated



### HEADING 3

[Project Overview](https://google.com)  



![Alt Text](../Images\me.jpeg) 

```sql
select
sd.skills,
round(median(jpf.salary_year_avg), 0) as median_salary,
count(jpf.salary_year_avg) as demand_count,
round(ln(count(jpf.*)), 0) as ln_demand_count,
round((median(jpf.salary_year_avg) * ln(count(jpf.*)))/ 1_000_000, 2) as optimal_score
from job_postings_fact as jpf 
inner join skills_job_dim as sjd 
using (job_id)
inner join skills_dim as sd 
using (skill_id)
where jpf.job_title_short = 'Data Engineer'
and 
jpf.salary_year_avg is not null
and
jpf.job_work_from_home = True
group by sd.skills
having count(jpf.*) > 100
order by optimal_score desc
limit 25;

```