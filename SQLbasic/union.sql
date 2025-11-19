create table april_jobs as(
select * FROM job_postings_fact
where  job_posted_date >'2023-03-31' and job_posted_date<'2023-05-01'

);
select * from april_jobs;

select job_title_short,
       job_id,
       search_location
from january_jobs
 UNION    -- it unions and gives with out dupliates we can union as many as want
select job_title_short,
       job_id,
       search_location
from febrauary_jobs

-- Union all similar to union but gives dupliactes also
select job_title_short,
       job_id,
       search_location
from january_jobs
 UNION all
 select job_title_short,
       job_id,
       search_location
from febrauary_jobs

select 
     job_title_short,
     job_via,
     job_schedule_type,
     search_location,
     salary_year_avg
     from (
    
select * from january_jobs
UNION ALL
select * from febrauary_jobs
UNION ALL
select * from march_jobs
  )
  where salary_year_avg>'70000'and job_title_short='Data Analyst'
 
  order by salary_year_avg desc