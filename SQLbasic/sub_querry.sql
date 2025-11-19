/* querry on sub Querry*/
select company_id,
      name
 from company_dim
 where company_id in (
select company_id
         --job_no_degree_mention
         --search_location
     from job_postings_fact
     where job_no_degree_mention=true
     order by company_id
 );


select * FROM company_dim limit 100;
select * FROM job_postings_fact limit 100;


/* querry on Ctes*/
with company_job_count as(
 select company_id,
        count(*) as job_openings
   FROM
    job_postings_fact
    group by company_id
)
select 
      name,
      company_job_count.job_openings,
      CASE
       when job_openings<='10'  then 'Less'
        when job_openings>'10' and job_openings<50 then 'Medium'
        else 'More'
        End as Job_openings_range
 FROM 
      company_dim
left JOIN company_job_count ON company_job_count.company_id=company_dim.company_id
--order by job_openings ;



/**    another queey       */
select * FROM skills_dim

with top_skills as (
select skill_id,
     count(*) as skill_count
 from
       skills_job_dim
       group by skill_id
        order by skill_count desc
        
)
select
   --skills_dim.skill_id,
   skills_dim.skills,
   top_skills.skill_count
from 
   skills_dim
left join top_skills on skills_dim.skill_id=top_skills.skill_id

order by skill_count desc
limit 5;