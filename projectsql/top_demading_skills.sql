/* Question :: Top Demanding Skills for Data Analyst ??
   and average salary for that skills*/

with skill_count_tab as (
select 
    round(avg(salary_year_avg),2)as avg_sal_USD,
     skill_id ,
     count(*) as skill_count
   
from 
   skills_job_dim
Inner join job_postings_fact on job_postings_fact.job_id=skills_job_dim.job_id
where 
      job_title_short='Data Analyst' and
      salary_year_avg is not null
group by skill_id
)
select 
      
       skill_count_tab.skill_id,
       skills,
       skill_count_tab.skill_count,
       skill_count_tab.avg_sal_USD
     
from 
    skills_dim 
Inner JOIN skill_count_tab on skill_count_tab.skill_id=skills_dim.skill_id
order by skill_count desc
limit 5;
