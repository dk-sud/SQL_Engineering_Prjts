/*

Question: 
What are the most optimal skills for data engineering candidates balancing both 
demand and salary ?
 - Create a ranking column that combines both demand count and median salary to 
   identify the most valuable skills 
 - Focus on only remote data engineers positions with specified annual salaries 
 - why ?
    : This approach highlights skills that balance market demand and finanacial reward.
      it weighs core skills approach 

*/

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


select ln(1133);