'''select
    jpf.*,
    cd.*
from
    job_postings_fact as jpf 
left join company_dim as cd 
    on jpf.company_id = cd.company_id
limit 10;'''

'''-------------------------left join------------------------------'''



'''-------------------------------------------------------

select 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name as company_name,
    jpf.job_location
from    
    job_postings_fact as jpf 
left join company_dim as cd
    on jpf.company_id = cd.company_id

    order by jpf.job_id
limit 10;

------------------------right join-------------------------------

select 
jpf.job_id,
jpf.job_location,
cd.company_id,
cd.name as company_name,
jpf.job_title_short

from job_postings_fact as jpf
right join 
company_dim as cd
using (company_id)
order by jpf.job_id;
'''

'''------------------------full outer join-------------------------------'''

select count(*)
from
job_postings_fact;

select 
jpf.job_id,
jpf.job_location,
cd.company_id,
cd.name as company_name,
jpf.job_title_short
from job_postings_fact as jpf
left outer join 
company_dim as cd
using (company_id)
order by jpf.job_id;

select * 
from skills_job_dim
limit 10;

select * 
from skills_dim
limit 10;

'''------------------------two lef join-------------------------------'''
select 
jpf.job_id,
jpf.job_title_short,
sjd.skill_id

from job_postings_fact as jpf
left join skills_job_dim as sjd 
using (job_id)
left join skills_dim as sd 
using (skill_id)
--- order by jpf.job_id
limit 10;

'''------------------------two inner join-------------------------------'''

select
jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills

from job_postings_fact as jpf 
inner join skills_job_dim as sjd 
using (job_id)
inner join skills_dim as sd 
using (skill_id);
---limit 10;

'''------------------------two left join-------------------------------'''
select
jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills

from job_postings_fact as jpf
left join skills_job_dim as sjd 
using (job_id)
left join skills_dim as sd 
using (skill_id);