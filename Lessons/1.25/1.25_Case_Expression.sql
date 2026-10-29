-- Bucket Salaries
-- < 25 = 'low'
-- 25 - 50 'medium'
-- > 50 = 'high'


select current_database();


-- Bucket Salaries
-- select 
--     job_title_short,
--     salary_hour_avg,
--     case 
--         when salary_hour_avg is null then 'Missing'
--         when salary_hour_avg < 25 then 'Low'
--         when salary_hour_avg < 50 then 'Medium'
--         else 'High'
--     end as salary_category
-- from job_postings_fact

-- limit 10;


-- Cztegorizing categorical values
-- Classifying the 'job title' colulmn values as:
    -- 'Data Anlayst'
    -- 'Data Scientist'
    -- 'Data Engineer'


-- select 
--     job_title,
--     case
--         when job_title like '%Data%' and job_title like '%Analyst%' then 'Data Analyst'
--         when job_title like '%Data%' and job_title like '%Engineer%' then 'Data Engineer'
--         when job_title like '%Data%' and job_title like '%Scientist%' then 'Data Scientist'
--         else 'Other'
--     end as job_title_category,
--     job_title_short,
    
-- from job_postings_fact
-- order by random()
-- limit 20;

-- Conditonal Aggregation
-- Calculate median Salaries for different Buckets
        -- < $100K
        -- >= $100k


-- select 
--     job_title_short,
--     count(*) as total_postings,
--     median(
--         case 
--             when salary_year_avg < 100000 then salary_year_avg
--         end 
--     ) as median_low_salary,
--     median(
--         case
--             when salary_year_avg >= 100000 then salary_year_avg
--         end
--     ) as median_high_salary
-- from job_postings_fact
-- where salary_year_avg is not null
-- group by job_title_short;

-- Final Data modelling excercise 
-- Conditional calculations
-- Compute a standardize salary using yearly salary and adjusted hourly salary (e.g., 2080 hours/year)
-- Categorise salaries into tiers of:
   -- <75k 'Low',
   -- 75k - 150k 'Medium'
   -- >= 150k 'High'

with salaries as (
    select 
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        case
            when salary_year_avg is not null then salary_year_avg
            when salary_hour_avg is not null then salary_hour_avg*2080
        end as standardized_salary
    from 
        job_postings_fact

)

select 
    *,
    case 
        when standardized_salary is null then 'Missing'
        when standardized_salary < 75000 then 'Low'
        when standardized_salary <150000 then 'Medium'
        else 'High'

    end as salary_bucket
from salaries 
--order by standardized_salary desc
limit 10;