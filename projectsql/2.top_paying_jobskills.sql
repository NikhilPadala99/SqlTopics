
/*
-- 2.Question :what are the top  skills required for data analyst jobs: 
           who works remotely ??
   
   */
with top_paying_job as (
select 
    job_id,
    job_title,
   salary_year_avg,
    job_country,
  
    company_dim.name as company_name
from 
    job_postings_fact 
left join company_dim on job_postings_fact.company_id=company_dim.company_id
where job_title_short='Data Analyst' and
         job_work_from_home=true  AND
         salary_year_avg is not null
         
order by 
        salary_year_avg desc
limit 10
)
select 
       top_paying_job.*,
       skills_dim.skills

from top_paying_job
inner join  skills_job_dim on skills_job_dim.job_id=top_paying_job.job_id
inner join  skills_dim on skills_dim.skill_id=skills_job_dim.skill_id 
order by 
      salary_year_avg desc
       limit 10;


