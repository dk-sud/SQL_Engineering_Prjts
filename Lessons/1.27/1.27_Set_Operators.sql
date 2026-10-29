create temp table jobs_2023 as
select * exclude (job_id, job_posted_date)
from job_postings_fact
where extract(year from job_posted_date) = 2023;



create temp table jobs_2024 as
select * exclude(job_id, job_posted_date)
from job_postings_fact
where extract (year from job_posted_date) = 2024; 



select 
    'jobs_2023'as table_name,
    count(*) as jobs_count
from jobs_2023
union
select 
    'jobs_2024' as table_name,
    count(*) 
from jobs_2024;

select * from jobs_2023 
union all
select * from jobs_2024; 

--- Which job postings appeared ion 2023 but no in 2024

select * from jobs_2023
except  
select * from jobs_2024;

--- which job postings from 2023 remain after subtracting matchin 2024 postings,
--- one - for - one ?

select * from jobs_2023
except all
select * from jobs_2024;


--- which job_postings appeared in 2023 and 2024;

select * from jobs_2023
intersect all
select * from jobs_2024;