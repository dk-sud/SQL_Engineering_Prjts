--- Subquery

select *
from (
select * 
from job_postings_fact
where salary_year_avg is not null
or salary_hour_avg is not null
) as valid_salaries
limit 10;

--- cte

with valid_salaries as(
    select *
    from job_postings_fact
    where salary_year_avg is not null
    or salary_hour_avg is not null
)
select * from valid_salaries;

--- scenairo 1: Subquery in 'SELECT'
--- Show each job's salary next to the overall market median:\

select 
job_title,
salary_year_avg,
(
    select median(salary_year_avg)
    from job_postings_fact
    
)as market_median_salary
from job_postings_fact
where salary_year_avg is not null
limit 10;

--- Scenairo 2: Syubquery in from
--- Stage only jobs that are remote before aggregating to determine the remote median salary
--- per job


SELECT
job_title_short,
median(salary_year_avg) as  median_salary,

(
select 
median(salary_year_avg) 
from job_postings_fact
where job_work_from_home = True
) as market_remote_median_sal

from 
(
    select
    job_title_short,
    salary_year_avg
    from job_postings_fact
    where job_work_from_home = True 
    
) as clean_salary_list
---where
    ---salary_year_avg is not null
group by job_title_short
limit 10;

--- Scenario 3: Subquery in having
-- Keep only job titles whose median salary is above the overall median:

select 
job_title_short,
median(salary_year_avg) as median_salary,

(
select
median(salary_year_avg)
from job_postings_fact
where job_work_from_home = True
) as non_aggregated_list
from 
(
select
job_title_short,
salary_year_avg
from job_postings_fact
where job_work_from_home = True
)
group by job_title_short
having median(salary_year_avg) >
(
    select
    median(salary_year_avg)
    from job_postings_fact
)
limit 10;

---- CTE --

-- CTE Example
-- Compare how much more/less remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calcualte the median salary by title and work arrangement, then compare those 
-- medians.

'''with title_median as (

    select 
        job_title_short,
        job_work_from_home,
        median(salary_year_avg) :: int as median_salary
    from job_postings_fact
    where job_country = 'United States'
    group by 
        job_title_short, 
        job_work_from_home
)

select 
    r.job_title_short,
    r.median_salary as remote_median_sal,
    o.median_salary as onsite_median_sal,
    (remote_median_sal - onsite_median_sal) as premium_over_the_other
from title_median as r
inner join title_median as o 
USING (job_title_short)
where r.job_work_from_home = True
    and o.job_work_from_home = false
    order by premium_over_the_other desc;'''

with median_sal_rem_vs_ons as 
(

select 
job_title_short,
job_work_from_home,
median(salary_year_avg) :: int as median_salary
from job_postings_fact
where job_country = 'United States'
group by job_title_short, job_work_from_home
)

select 
    r.job_title_short,
    r.median_salary as remote_sal,
    o.median_salary as onsite_sal,
    (remote_sal - onsite_sal) as premium_over_the_other_ii
from median_sal_rem_vs_ons as r
inner join median_sal_rem_vs_ons as o
using (job_title_short)
    where r.job_work_from_home = True
    and o.job_work_from_home = false
    order by premium_over_the_other_ii desc;

--- Final E.g.,
--- Identify job postings that have no associated skills before loading them into a data mart

select * 
from range(3) as src(key);

select * 
from range(2) as tgt(key);

select * 
from range(3) as src(key)
where not exists (
    select 1
    from range(2) as tgt(key)
    where tgt.key = src.key
);


select *
from job_postings_fact
order by job_id
limit 10;


select * 
from skills_job_dim
order by job_id
limit 10;


select *
from job_postings_fact as tgt 
where  exists (
    select * 
    from skills_job_dim as src 
    where tgt.job_id = src.job_id
)
order by job_id;wa   