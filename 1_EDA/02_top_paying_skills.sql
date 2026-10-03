/*
Question: waht are the highest pyaing skills for data engineers?
- calculate the median salary for each skill requried in data engineer positions
- focus on remote postions with specified salaries
- include skill frequency to identify both salary and demand
- why? helps identify whcih skills command the highest compensation while also showing 
   how common those skills are, providing a more complete picture for skill development priorities

*/

select 
sd.skills,
round(median(jpf.salary_year_avg), 0) as median_salary,
count (jpf.*) AS demand_count
from job_postings_fact as jpf 
inner join skills_job_dim as sjd 
using (job_id)
inner join skills_dim as sd 
using(skill_id)
where jpf.job_title_short = 'Data Engineer'
and jpf.job_work_from_home = True 
group by sd.skills
having count(jpf.*)>100
order by demand_count desc
limit 25;

/*

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ sql        │      130000.0 │        29221 │
│ python     │      135000.0 │        28776 │
│ aws        │      137320.0 │        17823 │
│ azure      │      128000.0 │        14143 │
│ spark      │      140000.0 │        12799 │
│ airflow    │      150000.0 │         9996 │
│ snowflake  │      135500.0 │         8639 │
│ databricks │      132750.0 │         8183 │
│ java       │      135000.0 │         7267 │
│ gcp        │      136000.0 │         6446 │
│ kafka      │      145000.0 │         6415 │
│ scala      │      137290.0 │         6304 │
│ redshift   │      130000.0 │         5737 │
│ hadoop     │      135000.0 │         5447 │
│ pyspark    │      140000.0 │         4898 │
│ git        │      140000.0 │         4641 │
│ power bi   │      120000.0 │         4600 │
│ nosql      │      134415.0 │         4514 │
│ tableau    │      115000.0 │         4402 │
│ docker     │      135000.0 │         4316 │
│ kubernetes │      150500.0 │         4202 │
│ sql server │      120000.0 │         3931 │
│ bigquery   │      135000.0 │         3523 │
│ mongodb    │      135750.0 │         3512 │
│ postgresql │      122500.0 │         3360 │
└────────────┴───────────────┴──────────────┘



*/