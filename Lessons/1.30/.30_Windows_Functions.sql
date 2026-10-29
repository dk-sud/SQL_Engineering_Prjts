select 
    job_id,
    job_title_short,
    ---company_id,
    salary_hour_avg,
    avg(salary_hour_avg) over (partition by job_title_short,
company_id)
from 
    job_postings_fact
where
    salary_hour_avg is not null
order by 
    random()
limit 10;






select 
    avg(salary_hour_avg)
from   
    job_postings_fact;


-- Order by - Ranking hourly salary

select  
    job_id,
    job_title_short,
    salary_hour_avg,
    rank() over(
        order by salary_hour_avg desc
    ) as ranked_hourly_salary
from 
    job_postings_fact
where   
    salary_hour_avg is not null
order by 
    salary_hour_avg desc
limit 10;


--- Partition by with Avg aggregator, rank order, order by for the aggregatred column.


select 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    company_id,
    max(salary_hour_avg) over (
        partition by job_title_short
        order by job_posted_date
    ) as running_avg_hourly_by_title
from    
    job_postings_fact
where 
    salary_hour_avg is not null 
    and
    job_title_short = 'Data Engineer'

order by 
    job_title_short,
    job_posted_date
limit 10;

------------------------------

select 
    job_id,
    job_title_short,
    salary_hour_avg,
    row_number() over (
        ---partition by job_title_short
        order by salary_hour_avg desc
    ) as rank_hourly_salary
from 
    job_postings_fact
where  
    salary_hour_avg is not null
order by 
    rank_hourly_salary
        
limit 140;

--- Rank vs Dense Rank function

select
    job_id,
    job_title_short,
    salary_hour_avg,
    dense_rank() over(
        order by
            salary_hour_avg desc
    ) as ranked_hourly_salary
from
    job_postings_fact
where
    salary_hour_avg is not null
order by
    salary_hour_avg desc
limit
    140;

---- row number 

select 
    *,
    row_number() over (
        order by job_posted_date
    )
from job_postings_fact
order by 
    job_posted_date
limit 20;

--- LAG() Time based comparision of company yearly salary

select 
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    lag(salary_year_avg) over (
        partition by company_id
        order by job_posted_date
    ) as previous_posted_salary
    salary_year_avg - lag(salary_year_avg) over(
        partition by company_id
        order by job_posted_date
    ) as salary_change
from 
    job_postings_fact

where 
    salary_year_avg is not null
order by 
    company_id, job_posted_date
limit 60;

--- lead

select
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    lead(salary_year_avg) over (
        partition by company_id
        order by
            job_posted_date
    ) as next_posted_salary,
    salary_year_avg - lead(salary_year_avg) over(
        partition by company_id
        order by
            job_posted_date
    ) as salary_change
from
    job_postings_fact
where
    salary_year_avg is not null
order by
    company_id,
    job_posted_date
limit
    60;