'''select * from skills_job_dim limit 5;'''

select *
from
skills_dim 
limit 5;

select * 
from information_schema.columns
where table_catalog = 'data_jobs';

select * 
from information_schema.table_constraints
where table_catalog = 'data_jobs';

select * 
from information_schema.key_column_usage
where table_catalog = "data_jobs";

--PRAGMA show_tables;

describe job_postings_fact;