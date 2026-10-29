-- select 
--     job_posted_date,
--     job_posted_date :: DATE as Date,
--     job_posted_date :: TIME as Time,
--     job_posted_date :: TIMESTAMP as Timestamp,
--     job_posted_date :: TIMESTAMPTZ as Timestampz
-- from 
--     job_postings_fact
-- limit 10;

select 
    --job_posted_date, (This will lead to Binder Error: column "job_posted_date" 
    -- must appear in the GROUP BY clause or must be part of an aggregate function 
    -- GROUP BY clause or must be part of an aggregate function)
    extract(year from job_posted_date) as job_posted_year,
    extract(month from job_posted_date) as job_posted_month,
    count(job_id) as job_count
    --extract(day from job_posted_date) as job_posted_day
from job_postings_fact 
where job_title_short = 'Data Engineer'
group by 
    extract(year from job_posted_date),
    extract(month from job_posted_date)
order by
    job_posted_year,
    job_posted_month;

--limit 10;

---date trunc
select 
    job_posted_date,
    cast(date_trunc('year', job_posted_date) as Date) as job_year,
    cast(date_trunc('quarter', job_posted_date) as Date) as job_quarter,
    cast(date_trunc('month', job_posted_date) as Date) as job_month,
    cast(date_trunc('week', job_posted_date) as Date) as job_week,
    cast(date_trunc('day', job_posted_date) as Date) as job_day,
    cast(date_trunc('hour', job_posted_date) as Date) as job_hour
from job_postings_fact
order by random()
limit 10;


SELECT
    job_posted_date,
    CAST(DATE_TRUNC('year', job_posted_date) AS DATE) AS job_year,
    CAST(DATE_TRUNC('quarter', job_posted_date) AS DATE) AS job_quarter,
    CAST(DATE_TRUNC('month', job_posted_date) AS DATE) AS job_month,
    CAST(DATE_TRUNC('week', job_posted_date) AS DATE) AS job_week,
    CAST(DATE_TRUNC('day', job_posted_date) AS DATE) AS job_day,
    CAST(DATE_TRUNC('hour', job_posted_date) AS TIMESTAMP) AS job_hour


FROM
    job_postings_fact
ORDER BY
    RANDOM()
LIMIT
    10;

select 
    
    cast(
        date_trunc('month', job_posted_date) as DATE 
    ) as job_posted_month,
    count(job_id) as job_count
from job_postings_fact
where job_title_short = 'Data Engineer'
and
DATE_TRUNC('year', job_posted_date) = '2024-01-01'
--extract(year from job_posted_date) = 2024
group by 
    job_posted_month
order by 
    job_posted_month;



--TIMESTAMP

select
    '2026-10-22 00:00:00+00'::TIMESTAMPTZ at time zone 'IST';

select 
    job_title_short,
    job_location,
    job_posted_date at time zone 'UTC' at time zone 'EST'
from 
    job_postings_fact
where 
    job_location like 'New York, NY':

select
    extract(hour from job_posted_date at time zone 'UTC' at time zone 'EST') as job_posted_hour,
    count(job_id)
from 
    job_postings_fact
where 
    job_location LIKE 'New York, NY'
group by 
    extract( hour from job_posted_date at time zone 'UTC' at time zone 'EST')
order by 
    job_posted_hour;