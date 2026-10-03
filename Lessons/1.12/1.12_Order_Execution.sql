/*
Find trhe top 10 comanies for posting jobs
They must have >3000 postings
*/

select 
cd.name as company_name,
count(jpf.*) as postings_count

from job_postings_fact as jpf
left join company_dim as cd
using (company_id)
group by cd.name;

/*
Find trhe top 10 comanies for posting jobs
They must have >3000 postings

Limit this only to US jobs.
*/
explain analyze
select
cd.name as company_name,
jpf.job_country as country,
count(jpf.job_id) as posting_count

from job_postings_fact as jpf 
left join company_dim as cd 
using (company_id)
where jpf.job_country = 'United States'
group by cd.name, jpf.job_country
having count(jpf.job_id) > 3000
order by posting_count desc
limit 10;