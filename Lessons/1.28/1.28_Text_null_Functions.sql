select length('Sql');

select char_length('sql');

select upper('sql');

select left('SQL', 2);

select substring('SQL', 2, 1);

select concat('SQL', '-', 'Functions');

select 'SQL' || '-' || 'Fnctions';

-----------------------------------------------------

--- Cleaening up using text functions.2
with title_lower as (
    select 
        job_title,
        lower(trim(job_title)) as job_title_clean
    from job_postings_fact
)


select 
    job_title,
    case
        when job_title_clean like '%data%'
            and job_title_clean like '%analyst%' then 'Data Analyst'
        when job_title_clean like '%data%'
            and job_title_clean like '%scientist%' then 'Data Scientist'
        when job_title_clean like '%data%'
            and job_title_clean like '%engineer%' then 'Data Engineer'
        else 'Other'
    end as job_title_category
from title_lower
order by random()
limit 30;


select 
    salary_year_avg,
    salary_hour_avg
from   
    job_postings_fact
where 
    salary_hour_avg is not null 
or 
    salary_year_avg is not null
order by salary_year_avg
limit 10;



select
    median(nullif(salary_year_avg, 0)),
    median(nullif(salary_hour_avg, 0))
from
    job_postings_fact
where
    salary_hour_avg is not null
    or salary_year_avg is not null
limit
    10;

    --- coalesce

select coalesce(null, 1, 2, 3, 4);
select
    coalesce(null, null, 2, 3, 4);

select 
    salary_hour_avg,
    salary_year_avg,
    coalesce(salary_year_avg, salary_hour_avg * 2080)
from 
    job_postings_fact
where 
    salary_hour_avg is not null
    or
    salary_year_avg is not null
limit 10;